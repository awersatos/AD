/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system directory entries.
|*
\******************************************************************************/

#include <time.h>
#include <string.h>
#include <ctype.h>

#include "fat.h"
#include "fat_cache.h"
#include "fat_cluster.h"
#include "fat_direntries.h"
#include "fat_lfn.h"

//.............................................................................
// helper functions

// Next function is a shortcut to the standard
// date/time resolution is in seconds instead of 1/100 seconds
static uint8_t fat_datetime( uint8_t *fat_date, uint8_t *fat_time )
{
#if 0
    // FIXME: time() and gmtime() are not available in our time.h

    struct tm *t;
    time_t now;
    uint8_t retval = 0;

    now = time( NULL );
    if ( now == ( time_t ) - 1 )
    {
        // dummy, return 1/1/1980, 00:00:00
        write_little16to8( fat_date, ( 1 << 5 ) + 1 );
        if ( fat_time )
        {
            write_little16to8( fat_time, 0 );
        }
    }
    else
    {
        t = gmtime( &now );
        write_little16to8( fat_date, ( ( t->tm_year - 80 ) << 9 ) + ( ( t->tm_mon + 1 ) << 5 ) + t->tm_mday );
        if ( fat_time )
        {
            write_little16to8( fat_time, ( t->tm_hour << 11 ) + ( t->tm_min << 5 ) + ( t->tm_sec >> 1 ) );
        }
        retval = t->tm_sec % 2 ? 100 : 0;
    }
    return retval;
#endif

    // dummy, return 1/1/1980, 00:00:00
    write_little16to8( fat_date, ( 1 << 5 ) + 1 );
    if ( fat_time )
    {
        write_little16to8( fat_time, 0 );
    }
    return 0;
}

//------------------------------------------------------------
// DIRECTORY SUPPORT FUNCTIONS

// get pointer to cached next entry in an opened directory file
// direntry_location    if <> 0 will be set up to point to the entry
extern fat_direntry_t *dir_get_next_entry( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                           fat_direntry_location_t * direntry_location )
{
    // don't use the normal diskreading, we know sectorsize is a multiple of the direntrysize
    // and FAT12/FAT16 use a special area instead of a clusterchain

    uint32_t lba;
    uint32_t nextcluster;

    if ( fcb->u.fat.cluster )
    {
        // dir is normal chained file
        if ( fcb->u.fat.pos_pastcluster )
        {
            // find next cluster
            nextcluster = cluster_readlink( fatfs, fcb->u.fat.pos_cluster );
            if ( fatfs->error )
            {
                return 0;
            }

            if ( cluster_is_eoc( fatfs, nextcluster ) )
            {
                return 0;
            }

            fcb->u.fat.pos_cluster = nextcluster;
            fcb->u.fat.pos_pastcluster = 0;
        }

        uint32_t clustersize = fatfs->sectors_per_cluster * FATFS_SECTORSIZE;
        uint32_t pos_in_cluster = fcb->u.fat.pos % clustersize;

        lba = cluster2lba( fatfs, fcb->u.fat.pos_cluster ) + ( pos_in_cluster / FATFS_SECTORSIZE );

        // check if will reach the end of the cluster after this entry
        if ( ( pos_in_cluster + sizeof( fat_direntry_t ) ) == clustersize )
        {
            fcb->u.fat.pos_pastcluster = 1;
        }
    }
    else
    {
        // special rootdir area on disk
        lba = fatfs->rootdir_lba + ( fcb->u.fat.pos / FATFS_SECTORSIZE );
        if ( lba >= fatfs->data_lba )
        {
            // end of rootdir area
            return 0;
        }
    }

    // get the sector from the cache
    uint32_t *datacache = cache_read( fatfs, lba, 0 );
    if ( fatfs->error )
    {
        return 0;
    }

    uint16_t pos_in_sector = fcb->u.fat.pos % FATFS_SECTORSIZE;
    fat_direntry_t *direntry = ( fat_direntry_t * ) ( ( ( uint8_t * ) datacache ) + pos_in_sector );

    // can be used later to update the directory entry very fast
    if ( direntry_location )
    {
        direntry_location->lba = lba;
        direntry_location->pos_in_sector = pos_in_sector;
    }

    fcb->u.fat.pos += sizeof( fat_direntry_t );

    return direntry;
}

// read the next file from a directory
// TODO: verify LFN checksum
#if FATFS_USE_LFN
extern fat_direntry_t *dir_get_next_file( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                          fat_direntry_location_t * direntry_location,
                                          char *name, size_t size )
#else
extern fat_direntry_t *dir_get_next_file( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                          fat_direntry_location_t * direntry_location )
#endif
{
    fat_direntry_t *direntry;

#if FATFS_USE_LFN
    *name = 0;
    direntry_location->lfn_lba = 0;
    direntry_location->lfn_pos_in_sector = 0;
#endif

    for ( ;; )
    {
        direntry = dir_get_next_entry( fatfs, fcb, direntry_location );
        if ( fatfs->error )
        {
            return 0;
        }

        if ( !direntry )
        {
            // end of directory
            return 0;
        }
        else if ( !*direntry->name )
        {
            // last entry
            return 0;
        }
        else if ( *direntry->name == FATFS_NAME0_FREE )
        {
            // unused, skip
            continue;
        }
#if FATFS_USE_LFN
        else if ( direntry->attributes == FATFS_ATTRIBUTE_LFN )
        {
            // LFN entry
            if ( name )
            {
                fat_direntry_lfn_t *direntry_lfn = ( fat_direntry_lfn_t * ) direntry;

                lfn2name( direntry_lfn, name, size );

                if ( direntry_lfn->slotnumber & 0x40 )
                {
                    // first LFN entry, remember in case we must delete or rename
                    direntry_location->lfn_lba = direntry_location->lba;
                    direntry_location->lfn_pos_in_sector = direntry_location->pos_in_sector;
                }
            }
        }
#endif
/*
        else if (direntry->attributes & FATFS_ATTRIBUTE_VOLUME)
        {
            // volume label, skip
            continue;
        }
*/
        else
        {
            // normal entry
            return direntry;
        }
    }
}

#if FATFS_USE_LFN
// convert given sfn into a unique sfn in open directory
static void dir_make_sfn_unique( fatfs_t * restrict fatfs, fs_fcb_t * fcb, uint32_t node, uint8_t *sfn,
                                 int tailnr )
{
    fat_direntry_t *direntry;
    fat_direntry_location_t direntry_location;
    int nexttailnr;
    int pos;

    for ( ;; )
    {
        direntry = dir_get_next_file( fatfs, fcb, &direntry_location, NULL, 0 );
        if ( fatfs->error )
        {
            return;
        }

        if ( !direntry )
        {
            break;
        }                       // no more files, current sfn is usable

        nexttailnr = sfn_nexttail( sfn, direntry->name );
        if ( nexttailnr > tailnr )
        {
            tailnr = nexttailnr;
        }
    }

    if ( tailnr )
    {
        // write a tailnr at the end of the basename
        pos = 7;
        while ( tailnr )
        {
            sfn[pos--] = '0' + ( tailnr % 10 );
            tailnr /= 10;
        }

        // fill up space between short names and the tailnr with at least one '~'
        do
        {
            sfn[pos--] = '~';
        }
        while ( sfn[pos] == ' ' );
    }
}
#endif

// find one/multiple continuous free entries in open directory
#if FATFS_USE_LFN
static fat_direntry_t *dir_get_free_entries( fatfs_t * restrict fatfs, fs_fcb_t * fcb, uint8_t entries,
                                             fat_direntry_location_t * direntry_location )
#else
static fat_direntry_t *dir_get_free_entry( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                           fat_direntry_location_t * direntry_location )
#endif
{
    fat_direntry_t *direntry;
    uint32_t cluster;
#if FATFS_USE_LFN
    uint8_t found_entries = 0;
    uint32_t found_cluster = CLUSTER_EOC;
    uint8_t found_pos_pastcluster = 0;
    uint32_t found_pos = -1;
#endif
    for ( ;; )
    {
#if FATFS_USE_LFN
        if ( found_entries == 0 )
        {
            // remember where this entry is
            found_cluster = fcb->u.fat.pos_cluster;
            found_pos = fcb->u.fat.pos;
            found_pos_pastcluster = fcb->u.fat.pos_pastcluster;
        }
#endif
        direntry = dir_get_next_entry( fatfs, fcb, direntry_location );
        if ( fatfs->error )
        {
            return 0;
        }

        if ( !direntry )
        {
            if ( fcb->u.fat.pos_pastcluster )
            {
                // end of directory

                // FAT32: just add another cluster
                cluster = cluster_allocate( fatfs, fcb->u.fat.pos_cluster, fcb->filemask );
                if ( fatfs->error )
                {
                    return 0;
                }

                if ( cluster_is_eoc( fatfs, cluster ) )
                {
                    // disk full
                    seterrno( ENOSPC );
                    return 0;
                }

                // blank the first sector using the cache
                uint32_t lba = cluster2lba( fatfs, cluster );  // + fatfs->sectors_per_cluster;
                cache_blank( fatfs, lba, fcb->filemask );
                if ( fatfs->error )
                {
                    return 0;
                }

                // blank the other sectors of the cluster on disk
                if ( fatfs->sectors_per_cluster > 1 )
                {
                    cache_writethrough( fatfs, 0, ++lba, fatfs->sectors_per_cluster - 1, fcb->filemask );
                    if ( fatfs->error )
                    {
                        return 0;
                    }
                }

                // set up fcb to avoid having dir_get_next_entry() follow the chain again
                fcb->u.fat.pos_cluster = cluster;
                fcb->u.fat.pos_pastcluster = 0;
            }
            else
            {
                // FAT12/FAT16 rootdir full
                seterrno( ENOSPC );
                return 0;
            }
        }
        else if ( ( !*direntry->name ) || ( *direntry->name == FATFS_NAME0_FREE ) )
        {
            // unused or last entry, usable
#if FATFS_USE_LFN
            if ( ++found_entries == entries )
            {
                if ( entries > 1 )
                {
                    // position back to the first entry
                    fcb->u.fat.pos_cluster = found_cluster;
                    fcb->u.fat.pos = found_pos;
                    fcb->u.fat.pos_pastcluster = found_pos_pastcluster;
                    direntry = dir_get_next_entry( fatfs, fcb, direntry_location );
                    if ( fatfs->error )
                    {
                        return 0;
                    }
                }
                return direntry;
            }
#else
            return direntry;
#endif
        }
#if FATFS_USE_LFN
        else
        {
            // used entry
            found_entries = 0;
        }
#endif
    }
}

// write new entry (described by given dirent) into directory starting at dirent->dirnode pointing
// to dirent->node
// if given from_direntry will be used for all except the name
// the fcb->u.fat.direntry_location will be set up to point to the entry
extern fat_direntry_t *dir_create_entry( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                         fatfs_dirent_t * dirent, fat_direntry_t * from_direntry )
{
    fat_direntry_t *direntry;
    uint8_t sfn[11];
#if FATFS_USE_LFN
    int nameslots;
    int tailnr;
    char namebuf[13];
#endif

#if FATFS_USE_LFN
    nameslots = ( strlen( dirent->dirent.d_name ) / 13 ) + 1;
    tailnr = 1;

    // try if it is a valid 8.3 name
    if ( shortname2sfn( dirent->dirent.d_name, sfn, 0 ) )
    {
        tailnr = 0;

        // is it all capitals?
        sfn2shortname( sfn, namebuf, 0 );
        if ( strcmp( namebuf, dirent->dirent.d_name ) == 0 )
        {
            // it's a valid 8.3 name, no LFN slots needed
            nameslots = 0;
        }
    }

    // create default sfn and turn it into a unique sfn
    longname2sfn( dirent->dirent.d_name, sfn );
    fat_fcb_pos_at_node( fatfs, fcb, dirent->dirnode );
    dir_make_sfn_unique( fatfs, fcb, dirent->dirnode, sfn, tailnr );
#else
    if ( !shortname2sfn( dirent->dirent.d_name, sfn, 0 ) )
    {
        seterrno( EINVAL );
        return 0;               // illegal name
    }
#endif

    fat_fcb_pos_at_node( fatfs, fcb, dirent->dirnode );

#if FATFS_USE_LFN
    direntry = dir_get_free_entries( fatfs, fcb, 1 + nameslots, &dirent->u.fat.direntry_location );
#else
    direntry = dir_get_free_entry( fatfs, fcb, &dirent->u.fat.direntry_location );
#endif
    if ( fatfs->error )
    {
        return 0;
    }

    if ( !direntry )
    {
        return 0;               // no space in directory
    }

#if FATFS_USE_LFN
    if ( nameslots )
    {
        uint8_t checksum = sfn_checksum( sfn );

        // write slots in reverse order with the first slotnr marked with a 0x40 flag
        for ( uint8_t slot = ( uint8_t )nameslots; slot >= 1; --slot )
        {
            fat_direntry_lfn_t *direntry_lfn = ( fat_direntry_lfn_t * ) direntry;

            direntry_lfn->attributes = FATFS_ATTRIBUTE_LFN;
            direntry_lfn->checksum = checksum;
            direntry_lfn->reserved = 0;
            direntry_lfn->dummy_cluster[0] = 0;
            direntry_lfn->dummy_cluster[1] = 0;

            if ( slot == nameslots )
            {
                direntry_lfn->slotnumber = slot | 0x40;
            }
            else
            {
                direntry_lfn->slotnumber = slot;
            }

            longname2lfn( dirent->dirent.d_name, direntry_lfn );
            cache_setdirty( fatfs, dirent->u.fat.direntry_location.lba, fcb->filemask );

            // we already tested for enough free slots, the next one _will_ be free
            direntry = dir_get_next_entry( fatfs, fcb, &dirent->u.fat.direntry_location );
            if ( fatfs->error )
            {
                return 0;
            }
        }
    }
#endif

    if ( from_direntry )
    {
        // copy direntry as given
        memcpy( direntry, from_direntry, sizeof( fat_direntry_t ) );
    }
    else
    {
        // build new direntry based on dirent given
        memset( direntry, 0, sizeof( fat_direntry_t ) );

        direntry->attributes = dirent->attributes;

        write_little16to16( direntry->cluster_high, ( dirent->node >> 16 ) & 0xFFFF );
        write_little16to16( direntry->cluster_low, dirent->node & 0xFFFF );

        direntry->created_tenths = fat_datetime( direntry->created_date, direntry->created_time );
        direntry->modified_date[0] = direntry->created_date[0];
        direntry->modified_date[1] = direntry->created_date[1];
        direntry->modified_time[0] = direntry->created_time[0];
        direntry->modified_time[1] = direntry->created_time[1];
    }

    // name is always taken from dirent
    memcpy( direntry->name, sfn, 11 );

    // TODO: the timestamp on the parent directory should be updated?

    cache_setdirty( fatfs, dirent->u.fat.direntry_location.lba, fcb->filemask );

    return direntry;
}

// find a directory entry based on the given direntry_location,
// cache the sector containing it and return a pointer to the entry
extern fat_direntry_t *dir_get_entry( fatfs_t * restrict fatfs,
                                         fat_direntry_location_t * direntry_location )
{
#if FATFS_DEBUG
    ++fatfs->direntryread;
#endif
    uint8_t *dircache = ( uint8_t * ) cache_read( fatfs, direntry_location->lba, 0 );
    if ( fatfs->error )
    {
        return 0;
    }

    return ( fat_direntry_t * ) ( dircache + direntry_location->pos_in_sector );
}

// mark the given directory entry as 'unused'
static void dir_set_unused( fat_direntry_t * direntry )
{
    direntry->name[0] = FATFS_NAME0_FREE;
}

// set the timestamp(s) of the given direntory entry
extern void dir_set_timestamp( fat_direntry_t * direntry, uint8_t timestamp )
{
    uint8_t tenths;
    uint8_t date[2];
    uint8_t time[2];

    tenths = fat_datetime( date, time );

    if ( timestamp & DIR_TIMESTAMP_CREATED )
    {
        direntry->created_tenths = tenths;
        direntry->created_date[0] = date[0];
        direntry->created_date[1] = date[1];
        direntry->created_time[0] = time[0];
        direntry->created_time[1] = time[1];
    }

    if ( timestamp & DIR_TIMESTAMP_MODIFIED )
    {
        direntry->modified_date[0] = date[0];
        direntry->modified_date[1] = date[1];
        direntry->modified_time[0] = time[0];
        direntry->modified_time[1] = time[1];
    }
}

// read the currents file's directory entry (size, cluster)
extern void dir_get_actuals( fatfs_t * restrict fatfs, fs_fcb_t * fcb, uint32_t *cluster, uint32_t *size )
{
    uint8_t *dircache;
    fat_direntry_t *direntry;
#if FATFS_DEBUG
    ++fatfs->direntryread;
#endif
    dircache = ( uint8_t * ) cache_read( fatfs, fcb->u.fat.direntry_location.lba, 0 );
    if ( fatfs->error )
    {
        return;
    }

    direntry = ( fat_direntry_t * ) ( dircache + fcb->u.fat.direntry_location.pos_in_sector );

    *cluster = ( ( ( uint32_t ) read_little16from8( direntry->cluster_high ) ) << 16 ) |
        ( uint32_t ) read_little16from8( direntry->cluster_low );

    if ( size )
    {
        *size = read_little32from32( direntry->filesize );
    }
}

// mark as unused the directory entry pointed at by the given direntry_location
extern void dir_remove_entry( fatfs_t * restrict fatfs, fs_fcb_t * fcb, uint32_t dirnode,
                              fat_direntry_location_t * direntry_location )
{
    fat_direntry_t *direntry;

#if FATFS_USE_LFN
    fat_direntry_lfn_t *direntry_lfn;
    fat_direntry_location_t lfn_direntry_location;
    uint8_t checksum;
    uint8_t slotnumber;

    if ( direntry_location->lfn_lba )
    {
        // find the first LFN entry based on its lba/pos by traversing the
        // full directory (can't use direct cache load with dir_get_entry()
        // because a LFN can cross sector and cluster bounderies)
        fat_fcb_pos_at_node( fatfs, fcb, dirnode );
        do
        {
            direntry = dir_get_next_entry( fatfs, fcb, &lfn_direntry_location );
            if ( fatfs->error )
            {
                return;
            }
        }
        while ( ( lfn_direntry_location.lba != direntry_location->lfn_lba ) ||
                ( lfn_direntry_location.pos_in_sector != direntry_location->lfn_pos_in_sector ) );

        direntry_lfn = ( fat_direntry_lfn_t * ) direntry;
        checksum = direntry_lfn->checksum;

        for ( ;; )
        {
            slotnumber = direntry_lfn->slotnumber;

            dir_set_unused( direntry );
            dir_setdirty( fatfs, fcb, &lfn_direntry_location );

            // slots are written in reversed order, 0x01 is the last
            if ( ( slotnumber & 0x3F ) == 0x01 )
            {
                break;
            }

            direntry = dir_get_next_entry( fatfs, fcb, &lfn_direntry_location );
            if ( fatfs->error )
            {
                return;
            }

            direntry_lfn = ( fat_direntry_lfn_t * ) direntry;

            if ( checksum != direntry_lfn->checksum )
            {
                debugprintf( "ERROR: LFN directory entries not all found\n" );
                break;
            }
        }
    }
#endif

    direntry = dir_get_entry( fatfs, direntry_location );
    if ( fatfs->error )
    {
        return;
    }

    dir_set_unused( direntry );
    dir_setdirty( fatfs, fcb, direntry_location );
}
