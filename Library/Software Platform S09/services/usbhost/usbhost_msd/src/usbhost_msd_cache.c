/**
 * @file
 *  USB Host Mass Storage Device service cached access part
 *
 */

#include <assert.h>
#include <string.h>

#include <usbhost_msd_cache.h>
#include <usbhost_msd_direct.h>
#include <usbhost_msd_i.h>

#include <usbhost_msd_cfg.h>
#include <usbhost_msd_cfg_instance.h>

#define USBHOST_MSD_CACHE_PAGESIZE            (USBHOST_MSD_INSTANCE_PAGESIZE_KB_MAX * 1024)

#define USBHOST_MSD_CACHE_PAGENR_UNUSED       0xFFFF

#define USBHOST_MSD_CACHE_PAGE_STATUS_EMPTY        0
#define USBHOST_MSD_CACHE_PAGE_STATUS_ORGDATA      1
#define USBHOST_MSD_CACHE_PAGE_STATUS_NEWDATA      2

typedef struct _usbhost_msd_page_t   usbhost_msd_page_t;

struct _usbhost_msd_page_t
{
    uint32_t                page_data[USBHOST_MSD_CACHE_PAGESIZE / sizeof( uint32_t )];
    int                     page;                           /* lba / blocks_per_page                */
    uint32_t                status;						    /* empty, org, modified                 */
    struct _usbhost_msd_page_t   *prev;
    struct _usbhost_msd_page_t   *next;
};

struct _usbhost_msd_cache_t
{
    bool                    inuse;
    int                     blocks_per_page;                /* sizeof(page_data) / block_size	    */
    int                     block_size;                     /* drv->info.blksize                    */
    usbhost_msd_page_t      cache[USBHOST_MSD_INSTANCE_NUMPAGES_MAX];
    usbhost_msd_page_t      *cache_head;
    usbhost_msd_page_t      *cache_tail;
};

#if USBHOST_MSD_INSTANCE_CACHE_TRUE_USED
static usbhost_msd_cache_t  usbhost_msd_cache_table[USBHOST_MSD_INSTANCE_CACHE_TRUE_USED * USBHOST_MSD_INSTANCE_NUMDEV_MAX];
#endif

static void cache_makehead(usbhost_msd_cache_t *cache, usbhost_msd_page_t *page);

/*
 * Cache handling
 */

/*
 * find given page in cache
 */
static usbhost_msd_page_t *cache_find_page(usbhost_msd_cache_t * cache, int page_number)
{
    usbhost_msd_page_t *page = cache ->cache_head;

    while ( page && page->page != page_number )
    {
        page = page->next;
    }

    return page;
}

/*
 * find given page in cache, if it's not in the cache read it from the device
 */
static usbhost_msd_page_t *cache_find_and_fill_page(usbhost_msd_t *drv, int sid, int page_number)
{
    usbhost_msd_page_t   *page;
    usbhost_msd_cache_t     *cache;
    int                     err;

    cache = drv->usbdevices[sid].cache;
    page = cache_find_page(cache, page_number);
    if (page == NULL)
    {
        page = cache->cache_tail;
        if (page->status == USBHOST_MSD_CACHE_PAGE_STATUS_NEWDATA)
        {
            err = usbhost_msd_write_direct(drv, sid, (uint8_t *)page->page_data, page->page * cache->blocks_per_page, (uint16_t)cache->blocks_per_page);
        }
        page->page = page_number;
        err = usbhost_msd_read_direct(drv, sid, (uint8_t *)page->page_data, page->page * cache->blocks_per_page, (uint16_t)cache->blocks_per_page);
        page->status = USBHOST_MSD_CACHE_PAGE_STATUS_ORGDATA;
        cache_makehead(cache, page);
    }

    return page;
}


int usbhost_msd_flush_cache(usbhost_msd_t *drv, int sid)
{
    int ret, err = 0;
    usbhost_msd_page_t   *page;
    usbhost_msd_cache_t     *cache;

    cache = drv->usbdevices[sid].cache;
    page = cache->cache_head;
    while (page != NULL)
    {
        if (page->status == USBHOST_MSD_CACHE_PAGE_STATUS_NEWDATA)
        {
            ret = usbhost_msd_write_direct(drv, sid, (uint8_t *)page->page_data, page->page * cache->blocks_per_page, (uint16_t)cache->blocks_per_page);
            if (ret == cache->blocks_per_page)
            {
                page->status = USBHOST_MSD_CACHE_PAGE_STATUS_ORGDATA;
            }
            else
            {
                err++;
            }
        }
        page = page->next;
    }

    if (err)
    {
        return -1;
    }
    return 0;
}

/*
 * make given cachepage the head of the mru list
 */
static void cache_makehead(usbhost_msd_cache_t *cache, usbhost_msd_page_t *page)
{
    if (cache->cache_head != page)
    {
        /* cut out from MRU/LRU list */
        page->prev->next = page->next;
        if (page->next)
        {
            page->next->prev = page->prev;
        }

        /* update tail if page was tail */
        if (cache->cache_tail == page)
        {
            cache->cache_tail = page->prev;
        }

        /* insert as head element */
        page->next = cache->cache_head;
        cache->cache_head->prev = page;
        cache->cache_head = page;
        page->prev = NULL;
    }
}

int usbhost_msd_read_cache(usbhost_msd_t *drv, int sid, uint8_t *data, uint32_t lba, uint16_t sectorcount)
{
    uint32_t sofar, page_number, page_offset, offset;
    uint16_t num_blocks;
    usbhost_msd_page_t *page;
    usbhost_msd_cache_t *cache;
    char *cpdst, *cpsrc;

    cache = drv->usbdevices[sid].cache;
    page_number = lba / cache->blocks_per_page;
    page_offset = lba % cache->blocks_per_page;
    sofar = 0;
    cpdst = (char *)data;

    do
    {
        page = cache_find_and_fill_page(drv, sid, page_number);
        if (page == NULL)
        {
            return -1;
        }
        offset = sofar * cache->block_size;
        if (page_offset)
        {
            cpsrc = (char *)page->page_data;
            cpsrc += page_offset * cache->block_size;
            if (sectorcount - sofar > cache->blocks_per_page - page_offset)
            {
                num_blocks = cache->blocks_per_page - page_offset;
            }
            else
            {
                num_blocks = sectorcount - sofar;
            }
            page_offset = 0;
        }
        else
        {
            cpsrc = (char *)page->page_data;
            if (sectorcount - sofar > cache->blocks_per_page)
            {
                     num_blocks = (uint16_t)cache->blocks_per_page;
            }
            else
            {
                     num_blocks = sectorcount - sofar;
            }
        }
        memcpy(cpdst + offset, cpsrc, num_blocks * cache->block_size);
        sofar += num_blocks;
        page_number ++;
    } while (sofar < sectorcount);

    return sectorcount;
}

int usbhost_msd_write_cache(usbhost_msd_t *drv, int sid, const uint8_t *data, uint32_t lba, uint16_t sectorcount)
{
    uint32_t sofar, page_number, page_offset, offset;
    uint16_t num_blocks;
    usbhost_msd_page_t *page;
    usbhost_msd_cache_t *cache;
    char *cpto, *cpsrc;

    cache = drv->usbdevices[sid].cache;
    page_number = lba / cache->blocks_per_page;
    page_offset = lba % cache->blocks_per_page;
    sofar = 0;
    cpsrc = (char *)data;

    do
    {
        page = cache_find_and_fill_page(drv, sid, page_number);
        if (page == NULL)
        {
            return -1;
        }
        offset = sofar * cache->block_size;
        if (page_offset)
        {
            cpto = (char *)page->page_data;
            cpto += page_offset * cache->block_size;
            if (sectorcount - sofar > cache->blocks_per_page - page_offset)
            {
                num_blocks = cache->blocks_per_page - page_offset;
            }
            else
            {
                num_blocks = sectorcount - sofar;
            }
            page_offset = 0;
        }
        else
        {
            cpto = (char *)page->page_data;
            if (sectorcount - sofar > cache->blocks_per_page)
            {
                     num_blocks = (uint16_t)cache->blocks_per_page;
            }
            else
            {
                     num_blocks = sectorcount - sofar;
            }
        }
        memcpy(cpto, cpsrc + offset, num_blocks * cache->block_size);
        sofar += num_blocks;
        page_number ++;
        page->status = USBHOST_MSD_CACHE_PAGE_STATUS_NEWDATA;
    } while (sofar < sectorcount);

    return sectorcount;
}

void usbhost_msd_cache_init(usbhost_msd_cache_t *cache, uint32_t blksize)
{
    int i;

    /* build double linked mru cachelist */
    for (i = 0; i < USBHOST_MSD_INSTANCE_NUMPAGES_MAX; i++)
    {
        if (i > 0)
        {
            cache->cache[i].prev = &cache->cache[i-1];
        }
        else
        {
            cache->cache[i].prev = NULL;
        }
        if (i < USBHOST_MSD_INSTANCE_NUMPAGES_MAX - 1)
        {
            cache->cache[i].next = &cache->cache[i+1];
        }
        else
        {
            cache->cache[i].next = NULL;
        }
        cache->cache[i].status = USBHOST_MSD_CACHE_PAGE_STATUS_EMPTY;
        cache->cache[i].page = -1;
    }
    cache->cache_head = &cache->cache[0];
    cache->cache_tail = &cache->cache[USBHOST_MSD_INSTANCE_NUMPAGES_MAX - 1];

    cache->block_size = blksize;
    cache->blocks_per_page = sizeof(cache->cache[0].page_data) / blksize;

}

int usbhost_msd_clear_cache(usbhost_msd_t *drv, int sid, unsigned int lba, uint16_t sectorcount)
{
    uint32_t sofar, page_number, page_offset, num_blocks;
    usbhost_msd_page_t *page;
    usbhost_msd_cache_t *cache;
    char *cpto;

    cache = drv->usbdevices[sid].cache;
    page_number = lba / cache->blocks_per_page;
    page_offset = lba % cache->blocks_per_page;
    sofar = 0;

    do
    {
        page = cache_find_and_fill_page(drv, sid, page_number);
        if (page == NULL)
        {
            return -1;
        }

        if (page_offset)
        {
            cpto = (char *)page->page_data;
            cpto += page_offset * cache->block_size;
            if (sectorcount - sofar > cache->blocks_per_page - page_offset)
            {
                num_blocks = cache->blocks_per_page - page_offset;
            }
            else
            {
                num_blocks = sectorcount - sofar;
            }
            page_offset = 0;
        }
        else
        {
            cpto = (char *)page->page_data;
            if (sectorcount - sofar > cache->blocks_per_page)
            {
                     num_blocks = cache->blocks_per_page;
            }
            else
            {
                     num_blocks = sectorcount - sofar;
            }
        }
        memset(cpto, 0, num_blocks * cache->block_size);
        sofar += num_blocks;
        page_number ++;
        page->status = USBHOST_MSD_CACHE_PAGE_STATUS_NEWDATA;
    } while (sofar < sectorcount);

    return sectorcount;
}

usbhost_msd_cache_t *usbhost_msd_alloc_cache(uint32_t blksize)
{
#if USBHOST_MSD_INSTANCE_CACHE_TRUE_USED
    int i;

    for (i = 0 ; i < sizeof(usbhost_msd_cache_table)/sizeof(usbhost_msd_cache_table[0]); i++)
    {
        if (!usbhost_msd_cache_table[i].inuse)
        {
            usbhost_msd_cache_table[i].inuse = true;
            usbhost_msd_cache_init(&usbhost_msd_cache_table[i], blksize);
            return &usbhost_msd_cache_table[i];
        }
    }
#endif
    return NULL;
}

void usbhost_msd_free_cache(usbhost_msd_cache_t *cache)
{
    assert(cache != NULL);

    if (cache != NULL)
    {
        memset(cache, 0, sizeof(*cache));
        cache->inuse = false;
    }
}

