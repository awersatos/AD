/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system cache.
|*
\******************************************************************************/

#include <string.h>

#include <blockio.h>

#include "fat.h"
#include "fat_cache.h"

//.............................................................................
// caching

// no gain using anything more complicated
#define lba_hash(lba) (lba % FATFS_CACHE_HASH)

#if FATFS_DEBUG
extern void fatfs_cache_stats( fatfs_t * restrict fatfs, uint8_t reset )
{
    int dirty = 0;
    for ( fatfs_cache_t * cache = fatfs->cache_mru; cache; cache = cache->mru_next )
    {
        if ( cache->dirtymask )
        {
            ++dirty;
        }
    }

    printf( "cache hits %i misses %i dirty %i\n", fatfs->hits, fatfs->misses, dirty );
    printf( "direntry read %i write %i\n", fatfs->direntryread, fatfs->direntrywrite );

    if ( reset )
    {
        fatfs->hits = 0;
        fatfs->misses = 0;
        fatfs->direntrywrite = 0;
        fatfs->direntryread = 0;
    }
}
#endif

// remove cache entry from mru/lru list and put at mru head
static void cache_makemru( fatfs_t * restrict fatfs, fatfs_cache_t * cache )
{
    // only move if not already at top
    if ( cache->mru_prev )
    {
        // cut out from MRU/LRU list
        cache->mru_prev->mru_next = cache->mru_next;
        if ( cache->mru_next )
        {
            cache->mru_next->mru_prev = cache->mru_prev;
        }

        if ( fatfs->cache_lru == cache )
        {
            fatfs->cache_lru = cache->mru_prev;
        }

        // glue to the MRU end of the MRU/LRU list
        fatfs->cache_mru->mru_prev = cache;
        cache->mru_next = fatfs->cache_mru;
        cache->mru_prev = 0;
        fatfs->cache_mru = cache;
    }
}

// write a cached sector to the underlying blockdevice
extern void cache_write( fatfs_t * restrict fatfs, fatfs_cache_t * cache )
{
    uint32_t lba = cache->lba;

    if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, cache->data, lba, 1 ) != 1 )
    {
        // device error
        seterrno( EIO );
        fatfs->error = EIO;
        return;
    }

    if ( ( lba < fatfs->rootdir_lba ) && ( lba >= fatfs->fat_lba ) )
    {
        // this is a cached FAT sector, duplicate write to all copies of fat
        for ( uint8_t i = fatfs->number_of_fats - 1; i; --i )
        {
            lba += fatfs->sectors_per_fat;
            if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, cache->data, lba, 1 ) != 1 )
            {
                // device error
                seterrno( EIO );
                fatfs->error = EIO;
                return;
            }
        }
    }

    // don't need to make MRU because in this driver the
    // calling code always excuted a cache_read() just before
}

// delete the cache from the hashlist for cache->lba
static void cache_deletehash( fatfs_t * restrict fatfs, fatfs_cache_t * cache )
{
    // find position in hash list
    int hashcode = lba_hash( cache->lba );
    fatfs_cache_t *hash_prev = 0;
    fatfs_cache_t *hash = fatfs->cache_hash[hashcode];
    while ( hash && ( hash != cache ) )
    {
        hash_prev = hash;
        hash = hash->hash_next;

        if ( !hash )
        {
            debugprintf( "INTERNAL ERROR: cache entry not in hash-list\n" );
        }
    }

    // cut from the hash list
    if ( hash_prev )
    {
        hash_prev->hash_next = cache->hash_next;
    }
    else
    {
        fatfs->cache_hash[hashcode] = cache->hash_next;
    }
}

// insert the cache into the head of the hashlist for cache->lba
static void cache_inserthash( fatfs_t * restrict fatfs, fatfs_cache_t * cache )
{
    int hashcode = lba_hash( cache->lba );
    cache->hash_next = fatfs->cache_hash[hashcode];
    fatfs->cache_hash[hashcode] = cache;
}

// free LRU cache entry and prepare for the given sectornr
static fatfs_cache_t *cache_free( fatfs_t * restrict fatfs, int lba )
{
    fatfs_cache_t *cache = fatfs->cache_lru;

    if ( cache->lba != ( uint32_t ) -1 )
    {
        // if needed write it to disk
        if ( cache->dirtymask )
        {
            cache_write( fatfs, cache );
            if ( fatfs->error )
            {
                return 0;
            }
        }

        cache_deletehash( fatfs, cache );
    }

    cache_makemru( fatfs, cache );

    cache->lba = lba;
    cache->dirtymask = 0;

    cache_inserthash( fatfs, cache );

    return cache;
}

// find a sector in the cache and make MRU
static fatfs_cache_t *cache_find( fatfs_t * restrict fatfs, int lba )
{
    // find the cache-entry for a given lba using the hash table & lists
    fatfs_cache_t *cache = fatfs->cache_hash[lba_hash( lba )];

    while ( cache && ( cache->lba != lba ) )
    {
        cache = cache->hash_next;
    }

    if ( !cache )
    {
        return 0;
    }

#if FATFS_DEBUG
    ++fatfs->hits;
#endif
    if ( fatfs->cache_mru != cache )
    {
        cache_makemru( fatfs, cache );
    }

    return cache;
}

// find a sector in the cache (adding it if needed) and make MRU
// the filemask is only used to flag the cache dirty in case the caller knows
// the contents is going to be changed (think fat and directory updates)
extern uint32_t *cache_read( fatfs_t * restrict fatfs, int lba, uint32_t filemask )
{
    fatfs_cache_t *cache = cache_find( fatfs, lba );

    if ( !cache )
    {
#if FATFS_DEBUG
        ++fatfs->misses;
#endif
        cache = cache_free( fatfs, lba );
        if ( fatfs->error )
        {
            return 0;
        }

        if ( fatfs->blkdrv.read_sectors( fatfs->blkdrv.device, cache->data, lba, 1 ) != 1 )
        {
            // device error
            seterrno( EIO );
            fatfs->error = EIO;
            return 0;
        }

        cache->dirtymask = 0;
    }

    cache->dirtymask |= filemask;

    return cache->data;
}

// create a blank (but marked 'dirty') sector in the cache and make MRU
extern uint32_t *cache_blank( fatfs_t * restrict fatfs, int lba, uint32_t filemask )
{
    fatfs_cache_t *cache = cache_find( fatfs, lba );
    if ( !cache )
    {
        cache = cache_free( fatfs, lba );
        if ( fatfs->error )
        {
            return 0;
        }
    }

    memset( cache->data, 0, FATFS_SECTORSIZE );
    cache->dirtymask |= filemask;

    return cache->data;
}

// mark the given cache sector as dirtied by the given filenr
extern void cache_setdirty( fatfs_t * restrict fatfs, int lba, uint32_t filemask )
{
    // find the cache-entry for a given lba using the hash table & lists
    fatfs_cache_t *cache = cache_find( fatfs, lba );

    if ( !cache )
    {
        debugprintf( "INTERNAL ERROR: cannot mark cache entry dirty when not in hash-list\n" );
        return;
    }

    cache->dirtymask |= filemask;
}

// read multiple sectors into a buffer
extern void cache_readthrough( fatfs_t * restrict fatfs, void *buffer, uint32_t lba, uint32_t sectorcount )
{
    // try to read leading sectors from cache
    while ( sectorcount )
    {
        // find the cache-entry for the first lba using the hash table & lists
        fatfs_cache_t *cache = cache_find( fatfs, lba );

        if ( !cache )
        {
            break;
        }

        memcpy( buffer, cache->data, FATFS_SECTORSIZE );

#if FATFS_DEBUG
        ++fatfs->hits;
#endif
        if ( fatfs->cache_mru != cache )
        {
            cache_makemru( fatfs, cache );
        }

        ++lba;
        --sectorcount;
        buffer = ( ( uint8_t * ) buffer ) + FATFS_SECTORSIZE;
    }

    if ( sectorcount )
    {
        // read non-cached sectors from disk
#if FATFS_DEBUG
        // count patched in as misses, as we re-read them from disk
        fatfs->misses += sectorcount;
#endif
        if ( fatfs->blkdrv.read_sectors( fatfs->blkdrv.device, buffer, lba, sectorcount ) != sectorcount )
        {
            // device error
            seterrno( EIO );
            fatfs->error = EIO;
            return;
        }

        // patch in any overlapping dirty cached sectors
        uint32_t lba_end = lba + sectorcount;
        for ( fatfs_cache_t * cache = fatfs->cache_mru; cache; cache = cache->mru_next )
        {
            if ( cache->dirtymask && ( cache->lba >= lba ) && ( cache->lba < lba_end ) )
            {
                memcpy( ( ( uint8_t * ) buffer ) + ( ( cache->lba - lba ) * FATFS_SECTORSIZE ), cache->data,
                        FATFS_SECTORSIZE );
            }
        }
    }
}

// write multiple sectors from a buffer (buffer == 0 means blank)
extern void cache_writethrough( fatfs_t * restrict fatfs, void *buffer, uint32_t lba, uint32_t sectorcount,
                                uint32_t filemask )
{
    // write leading sectors into the cache if already present
    while ( sectorcount )
    {
        // find the cache-entry for the first lba using the hash table & lists
        fatfs_cache_t *cache = cache_find( fatfs, lba );

        if ( !cache )
        {
            break;
        }

        memcpy( cache->data, buffer, FATFS_SECTORSIZE );
        cache->dirtymask |= filemask;

#if FATFS_DEBUG
        ++fatfs->hits;
#endif
        ++lba;
        --sectorcount;
        buffer = ( ( uint8_t * ) buffer ) + FATFS_SECTORSIZE;
    }

    if ( sectorcount )
    {
        // write non-cached sectors to disk
#if FATFS_DEBUG
        // count patched in as misses, as we re-write them into the cache
        fatfs->misses += sectorcount;
#endif
        if ( buffer )
        {
            if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, buffer, lba, sectorcount ) != sectorcount )
            {
                // device error
                seterrno( EIO );
                fatfs->error = EIO;
                return;
            }
        }
        else if( fatfs->blkdrv.clear_sectors( fatfs->blkdrv.device, lba, sectorcount ) != sectorcount )
        {
            // device error
            seterrno( EIO );
            fatfs->error = EIO;
            return;
        }

        // copy data also to any overlapping (dirty or not) cached sectors
        // (this is a rather uncommon situation, so we just update their data
        // without putting any effort in moving them to the MRU head)
        uint32_t lba_end = lba + sectorcount;
        for ( fatfs_cache_t * cache = fatfs->cache_mru; cache; cache = cache->mru_next )
        {
            if ( ( cache->lba >= lba ) && ( cache->lba < lba_end ) )
            {
                if ( buffer )
                {
                    memcpy( cache->data,
                            ( ( uint8_t * ) buffer ) + ( ( cache->lba - lba ) * FATFS_SECTORSIZE ),
                            FATFS_SECTORSIZE );
                }
                else
                {
                    memset( cache->data, 0, FATFS_SECTORSIZE );
                }
                cache->dirtymask = 0;
            }
        }
    }
}

// flush all cache for given file
extern void cache_flush( fatfs_t * restrict fatfs, uint32_t filemask, int invalidate )
{
    for ( fatfs_cache_t * cache = fatfs->cache_mru; cache; cache = cache->mru_next )
    {
        if ( cache->dirtymask & filemask )
        {
            cache_write( fatfs, cache );
            if ( fatfs->error )
            {
                return;
            }

            cache->dirtymask = 0;
        }

        if ( invalidate )
        {
            cache_deletehash( fatfs, cache );
            cache->lba = ( uint32_t ) -1;
        }
    }
}

// initialize cache for given filesystem
extern void cache_init( fatfs_t * restrict fatfs, int cache_count )
{
    // clear hashtable
    memset( fatfs->cache_hash, 0, sizeof( fatfs->cache_hash ) );

    // build doublelinked MRU/LRU cache list
    fatfs_cache_t *cache = fatfs->cache_mru;
    fatfs_cache_t *cache_prev = 0;
    for ( int i = cache_count; i; --i, cache_prev = cache++ )
    {
        cache->lba = ( uint32_t ) -1;
        cache->dirtymask = 0;
        cache->mru_prev = cache_prev;
        if ( cache_prev )
        {
            cache_prev->mru_next = cache;
        }
    }
    cache_prev->mru_next = 0;
    fatfs->cache_lru = cache_prev;
}
