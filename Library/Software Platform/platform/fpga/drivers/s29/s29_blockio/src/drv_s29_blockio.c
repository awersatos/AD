/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    S29_BLOCKIO driver (non-posix interface).
|*
\*****************************************************************************/

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

#include <sysutils.h>
#include <pal.h>
#include <drv_s29.h>
#include <drv_s29_blockio.h>
#include "drv_s29_internal.h" // definition of struct s29_s

#include "drv_s29_blockio_cfg_instance.h"


#define S29_BLOCKIO_MAXPAGESIZE         (DRV_S29_BLOCKIO_MAXPAGESIZE_KB * 1024)

#define S29_BLOCKIO_SECTORSIZE          512
#define S29_BLOCKIO_SECTORSIZE_WORDS    (S29_BLOCKIO_SECTORSIZE / sizeof(uint32_t))

#define S29_BLOCKIO_PAGENR_UNUSED       0xFFFF

#define S29_BLOCKIO_STATUS_EMPTY        0
#define S29_BLOCKIO_STATUS_ORGDATA      1
#define S29_BLOCKIO_STATUS_NEWDATA      2

typedef struct s29_blockio_cache_s s29_blockio_cache_t;

struct s29_blockio_cache_s
{
    uint32_t data[S29_BLOCKIO_MAXPAGESIZE / sizeof( uint32_t )];
    uint8_t sectorstatus[S29_BLOCKIO_MAXPAGESIZE / S29_BLOCKIO_SECTORSIZE];
    uint8_t musterase;
    int pagenr;
    uint32_t dirtymask;
    s29_blockio_cache_t *prev;
    s29_blockio_cache_t *next;
};

struct s29_blockio_s
{
    s29_t * restrict s29;
    s29_blockio_info_t info;
    s29_blockio_cache_t cache[DRV_S29_BLOCKIO_CACHEPAGES];
    s29_blockio_cache_t *cache_head;
    s29_blockio_cache_t *cache_tail;
    int fileflush;
};

static s29_blockio_t s29_blockio_table[DRV_S29_BLOCKIO_INSTANCE_COUNT];

/*
 * Cache handling
 */

/******************************************************************************
* FUNCTION: s29_blockio_set_fileflush
*
* set fileflush mode for the driver (default upon init is 0=off)
*
* s29_blockio   device structure with s29_blockio flash block device description
* fileflush    if true individual fileflush requests are honoured, if false they are ignored
*/
inline void s29_blockio_set_fileflush( s29_blockio_t * restrict  s29_blockio, int fileflush )
{
    s29_blockio->fileflush = fileflush;
}

// find given pagenr in cache
inline s29_blockio_cache_t *cache_find( s29_blockio_t * restrict  s29_blockio, int pagenr )
{
    s29_blockio_cache_t *cache = s29_blockio->cache_head;

    while ( cache && ( cache->pagenr != pagenr ) )
    {
        cache = cache->next;
    }

    return cache;
}

// flush given cachepage to disk
// returns 0 if OK, <>0 if write error
inline int s29_blockio_cache_flush( s29_blockio_t * restrict  s29_blockio, s29_blockio_cache_t * cache )
{
    int sectorsperpage;
    size_t flashoffset;
    uint32_t *cachepos;
    uint8_t *cachestatus;

    sectorsperpage = s29_blockio->s29->pagesize / S29_BLOCKIO_SECTORSIZE;

    if ( cache->pagenr != S29_BLOCKIO_PAGENR_UNUSED )
    {
        flashoffset = cache->pagenr * s29_blockio->s29->pagesize;

        if ( cache->musterase )
        {
            // erase the flash page
            debug_printf( "s29 erasing page %i\n", cache->pagenr );
            s29_erase_sector( s29_blockio->s29, flashoffset );
        }

        debug_printf( "s29 flashing page %i\n", cache->pagenr );

        cachepos = cache->data;
        cachestatus = cache->sectorstatus;

        for ( int i = sectorsperpage; i; --i )
        {
            // write the dirty (and if erased also non-empty) sectors to flash
            if ( ( *cachestatus == S29_BLOCKIO_STATUS_NEWDATA )
                 || ( cache->musterase && ( *cachestatus == S29_BLOCKIO_STATUS_ORGDATA ) ) )
            {
                if ( s29_program_block( s29_blockio->s29, flashoffset, cachepos, S29_BLOCKIO_SECTORSIZE ) )
                {
                    return -1;
                }               // write error
            }

            // any new data in the cache is still usable but it is now old data
            if ( *cachestatus == S29_BLOCKIO_STATUS_NEWDATA )
            {
                *cachestatus = S29_BLOCKIO_STATUS_ORGDATA;
            }

            flashoffset += S29_BLOCKIO_SECTORSIZE;
            cachepos += S29_BLOCKIO_SECTORSIZE_WORDS;
            ++cachestatus;
        }
    }

    return 0;
}

// make given cachepage the head of the mru list
inline void cache_makehead( s29_blockio_t * restrict  s29_blockio, s29_blockio_cache_t * cache )
{
    if ( s29_blockio->cache_head != cache )
    {
        // cut out from MRU/LRU list
        cache->prev->next = cache->next;
        if ( cache->next )
        {
            cache->next->prev = cache->prev;
        }

        if ( s29_blockio->cache_tail == cache )
        {
            s29_blockio->cache_tail = cache->prev;
        }

        // insert as head element
        cache->next = s29_blockio->cache_head;
        s29_blockio->cache_head->prev = cache;
        s29_blockio->cache_head = cache;
        cache->prev = NULL;
    }
}

/*
 * Local interface
 */

/******************************************************************************
* FUNCTION: s29_blockio_read
*
* Read sector(s) of data from memory
*
* blks29_blockio       device structure describing blockdevice to use
* data         start of area where data will be stored
* lba          LBA where to start
* sectorcount  number of sectors (512 byte) to read
*
* returns   number of blocks read
*/
inline uint32_t s29_blockio_read( s29_blockio_t * restrict  s29_blockio, void *data, uint32_t lba, uint32_t sectorcount )
{
    int sectorsperpage;
    int pagenr;
    int sectorinpage;
    int sectorscurrentpage;
    uint32_t orgsectorcount;
    s29_blockio_cache_t *cache;
    uint32_t *copydata;
    size_t copysize;

    orgsectorcount = sectorcount;
    sectorsperpage = s29_blockio->s29->pagesize / S29_BLOCKIO_SECTORSIZE;

    while ( sectorcount )
    {
        pagenr = lba / sectorsperpage;

        // sectors to read from this page
        sectorscurrentpage = ( ( pagenr + 1 ) * sectorsperpage ) - lba;
        if ( sectorscurrentpage > sectorcount )
        {
            sectorscurrentpage = sectorcount;
        }

        sectorinpage = lba % sectorsperpage;
        copysize = sectorscurrentpage * S29_BLOCKIO_SECTORSIZE;

        cache = cache_find( s29_blockio, pagenr );

        if ( cache )
        {
            cache_makehead( s29_blockio, cache );
            copydata = cache->data + ( sectorinpage * S29_BLOCKIO_SECTORSIZE_WORDS );
        }
        else
        {
            // not found: copy straight from flash
            copydata = ( uint32_t * ) ( s29_blockio->s29->baseaddr + ( lba * S29_BLOCKIO_SECTORSIZE ) );
        }

        memcpy( data, copydata, copysize );

        data = ( uint8_t * ) data + copysize;
        sectorcount -= sectorscurrentpage;
        lba += sectorscurrentpage;
    }

    return orgsectorcount;
}

/******************************************************************************
* FUNCTION: s29_blockio_write
*
* Write sector(s) of data to memory
*
* blks29_blockio       device structure describing blockdevice to use
* data         start of area where data is located
*              if =0 then write zeros to all bytes in sector(s)
* lba          LBA where to start
* sectorcount  number of sectors (512 byte) to write
*
* returns   number of blocks written
*/
inline uint32_t s29_blockio_write( s29_blockio_t * restrict  s29_blockio, const void *data, uint32_t lba, uint32_t sectorcount )
{
    int sectorsperpage;
    int pagenr;
    int sectorinpage;
    int sectorscurrentpage;
    uint32_t orgsectorcount;
    s29_blockio_cache_t *cache;
    uint32_t *flashpos;
    uint32_t *cachepos;
    uint8_t *cachestatus;
    size_t copysize;
    uint32_t filemask = 0xFFFFFFFF;     // FIXME: what to do with filemasks?

    if ( !s29_blockio->cache_head )
    {
        return 0;               // writing not allowed without cache
    }

    orgsectorcount = sectorcount;
    sectorsperpage = s29_blockio->s29->pagesize / S29_BLOCKIO_SECTORSIZE;

    while ( sectorcount )
    {
        pagenr = lba / sectorsperpage;

        cache = cache_find( s29_blockio, pagenr );

        if ( !cache )
        {
            // not yet in cache, we will re-use the lru element
            cache = s29_blockio->cache_tail;

            if ( s29_blockio_cache_flush( s29_blockio, cache ) )
            {
                return 0;
            }                   // write error

            // copy the page from flash
            debug_printf( "s29_blockio caching page %i\n", pagenr );
            flashpos = ( uint32_t * ) ( s29_blockio->s29->baseaddr + pagenr * s29_blockio->s29->pagesize );
            cachepos = cache->data;
            cachestatus = cache->sectorstatus;

            for ( int i = sectorsperpage; i; --i )
            {
                uint8_t status = S29_BLOCKIO_STATUS_EMPTY;

                for ( int j = S29_BLOCKIO_SECTORSIZE_WORDS; j; --j )
                {
                    if ( ( *cachepos++ = *flashpos++ ) != 0xFFFFFFFF )
                    {
                        status = S29_BLOCKIO_STATUS_ORGDATA;
                    }
                }

                *cachestatus++ = status;
            }

            cache->pagenr = pagenr;
            cache->musterase = 0;
            cache->dirtymask = 0;
        }

        // make cache the head of the mru list
        cache_makehead( s29_blockio, cache );
        cache->dirtymask |= filemask;

        // sectors to write to this page
        sectorscurrentpage = ( ( pagenr + 1 ) * sectorsperpage ) - lba;
        if ( sectorscurrentpage > sectorcount )
        {
            sectorscurrentpage = sectorcount;
        }

        sectorinpage = lba % sectorsperpage;

        cachepos = cache->data + sectorinpage * S29_BLOCKIO_SECTORSIZE_WORDS;
        copysize = sectorscurrentpage * S29_BLOCKIO_SECTORSIZE;

        if ( data )
        {
            memcpy( cachepos, data, copysize );
            data = ( uint8_t * ) data + copysize;
        }
        else
        {
            memset( cachepos, 0, copysize );
        }

        // mark sectors to be written while verifying if page must be erased
        cachestatus = &cache->sectorstatus[sectorinpage];
        for ( int i = sectorscurrentpage; i; --i )
        {
            switch ( *cachestatus )
            {
            case S29_BLOCKIO_STATUS_ORGDATA:
                cache->musterase = 1;
                // fallthrough

            case S29_BLOCKIO_STATUS_EMPTY:
                *cachestatus = S29_BLOCKIO_STATUS_NEWDATA;
                break;

            default:
                // no action
                break;

            }

            ++cachestatus;
        }

        sectorcount -= sectorscurrentpage;
        lba += sectorscurrentpage;
    }

    return orgsectorcount;
}

/******************************************************************************
* FUNCTION: s29_blockio_device_init
*
* Fill device structure describing partition on a memory blockdevice
*
* s29_blockio           device structure to contain with s29_blockio flash block device description
* s29_blockio           s29_blockio low level driver
* cache         buffer area for dirty pages
* cachesize     size of cache in cacheelements
*               if =0 only reading is supported
*
* returns       0 for success, <>0 if any error
*/
inline void s29_blockio_cache_init( s29_blockio_t * restrict  s29_blockio )
{
    s29_blockio_cache_t *prevcache;
    uint32_t cache_size = DRV_S29_BLOCKIO_CACHEPAGES;
    s29_blockio_cache_t *cache = s29_blockio->cache;

    // build double linked mru cachelist
    s29_blockio->cache_head = cache;
    prevcache = NULL;

    while ( cache_size-- )
    {
        if ( prevcache )
        {
            prevcache->next = cache;
        }

        cache->prev = prevcache;
        cache->pagenr = S29_BLOCKIO_PAGENR_UNUSED;

        prevcache = cache++;
    }
    prevcache->next = NULL;
    s29_blockio->cache_tail = prevcache;

    s29_blockio->info.blksize = S29_BLOCKIO_SECTORSIZE;
    s29_blockio->info.blkcount = ( s29_blockio->s29->pagesize * s29_blockio->s29->pagecount ) / S29_BLOCKIO_SECTORSIZE;
}

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize the S29 paralel flash device
 *
 * This function initializes the S29 paralel flash device and retrieves
 * information about the chip layout (see <code>s29_blockio_get_info()</code>).
 *
 * @param id
 *      Driver id (defined in devices.h)
 *
 * @return
 *      The s29_blockio driver pointer for the specified device, or NULL on error.
 *
 * @see
 *      s29_blockio_get_info
 */
extern s29_blockio_t *s29_blockio_open( int id )
{
    s29_blockio_t * s29_blockio;
    const drv_s29_blockio_cfg_instance_t * cfg;
    s29_t *s29;

    assert( id >= 0 && id < DRV_S29_BLOCKIO_INSTANCE_COUNT );
    s29_blockio = &s29_blockio_table[id];

    if ( s29_blockio->s29 == NULL )
    {
        cfg = &drv_s29_blockio_instance_table[id];
        s29 = s29_open( cfg->drv_s29 );

        if ( s29 != NULL  && s29->pagesize <= S29_BLOCKIO_MAXPAGESIZE )
        {
            s29_blockio->s29 = s29;
            s29_blockio_cache_init( s29_blockio );
        }
    }
    return s29_blockio->s29 != NULL ? s29_blockio : NULL;
}

/**
 * @brief
 *      Get information of the S29 device
 *
 * You can use this function to obtain sector layout information of an S29
 * device.
 *
 * @param s29_blockio
 *      s29_blockio driver pointer
 *
 * @return
 *      Pointer to an s29_blockio_info_t data structure.
 *
 * @see
 *      s29_blockio_info_t
 */
extern const s29_blockio_info_t *s29_blockio_get_info( s29_blockio_t * restrict s29_blockio )
{
    return (const s29_blockio_info_t *)&s29_blockio->info;
}

/**
 * @brief
 *      Read a number of sectors from the S29 device
 *
 * This function reads the requested number of sectors from the S29 device
 * starting with sector @em lba. The buffer @em data needs to be large enough
 * to contain the requested amount of data. Use <code>s29_blockio_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param s29_blockio
 *      s29_blockio driver pointer
 * @param data
 *      Buffer to store the data
 * @param lba
 *      Sector number to start reading from
 * @param sectorcount
 *      Number of sectors to read
 *
 * @return
 *      Number of sectors read.
 *
 * @see
 *      s29_blockio_get_info
 */
extern int s29_blockio_read_sectors( s29_blockio_t * restrict s29_blockio, uint8_t *data, unsigned int lba,
                                     unsigned int sectorcount )
{
    return s29_blockio_read( s29_blockio, data, lba, sectorcount );
}

/**
 * @brief
 *      Write a number of sectors to the S29 device
 *
 * This function writes the requested number of sectors to the S29 device
 * starting at sector @em lba. Use <code>s29_blockio_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param s29_blockio
 *      s29_blockio driver pointer
 * @param data
 *      Buffer containing the data to write
 * @param lba
 *      Sector number to start writing at
 * @param sectorcount
 *      Number of sectors to write
 *
 * @return
 *      Number of sectors written.
 *
 * @see
 *      s29_blockio_get_info
 */
extern int s29_blockio_write_sectors( s29_blockio_t * restrict s29_blockio, const uint8_t *data,
                                      unsigned int lba, unsigned int sectorcount )
{
    return s29_blockio_write( s29_blockio, data, lba, sectorcount );
}

/**
 * @brief
 *      Clear a number of sectors on the S29 device
 *
 * This function writes zeros to the requested number of sectors on the S29
 * device starting at sector @em lba. Use <code>s29_blockio_get_info()</code>
 * to find out the sector size and number of sectors of the device.
 *
 * @param s29_blockio
 *      s29_blockio driver pointer
 * @param lba
 *      Sector number to start writing at
 * @param sectorcount
 *      Number of sectors to clear
 *
 * @return
 *      Number of sectors cleared.
 *
 * @see
 *      s29_blockio_get_info
 */
extern int s29_blockio_clear_sectors( s29_blockio_t * restrict s29_blockio, unsigned int lba,
                                      unsigned int sectorcount )
{
    return s29_blockio_write( s29_blockio, NULL, lba, sectorcount );
}

/**
 * @brief
 *      Write dirty cache pages to the S29_BLOCKIO device
 *
 * This function writes all cached data to the S29_BLOCKIO flash device.
 *
 * @param s29_blockio
 *      s29_blockio driver pointer
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int s29_blockio_flush( s29_blockio_t * restrict s29_blockio )
{
    s29_blockio_cache_t *cache = s29_blockio->cache_head;
    uint32_t filemask = 0xFFFFFFFF;     // FIXME: what to do with filemasks?

//    if (s29_blockio->fileflush || (filemask == 0xFFFFFFFF))
    {
        while ( cache )
        {
            if ( cache->dirtymask & filemask )
            {
                if ( s29_blockio_cache_flush( s29_blockio, cache ) )
                {
                    return -1;
                }

                cache->dirtymask = 0;
            }

//            if ( invalidate )
            {
                cache->pagenr = S29_BLOCKIO_PAGENR_UNUSED;
            }

            cache = cache->next;
        }
    }

    return 0;
}
