/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system clusters.
|*
\******************************************************************************/

#include <util_endian.h>

#include "fat.h"
#include "fat_cache.h"
#include "fat_cluster.h"

//------------------------------------------------
// CLUSTER PROCESSING SUPPORT FUNCTIONS

// test if given cluster number signifies EOC for active FAT type
extern uint8_t cluster_is_eoc( fatfs_t * restrict fatfs, uint32_t cluster )
{
    switch ( fatfs->type )
    {
    case FAT32:
        return ( ( cluster & FAT32_CLUSTER_MASK ) > FAT32_CLUSTER_BAD );
    case FAT16:
        return ( cluster > FAT16_CLUSTER_BAD );
    case FAT12:
        return ( cluster > FAT12_CLUSTER_BAD );
    }
    return 0;
}

// find next clusternumber in chain from given cluster
extern uint32_t cluster_readlink( fatfs_t * restrict fatfs, uint32_t cluster )
{
    uint32_t pos;
    uint32_t lba;
    uint8_t *fatcache;
    uint32_t chaincluster;

    switch ( fatfs->type )
    {
    case FAT12:
        {
            pos = cluster + cluster / 2;
            lba = fatfs->fat_lba + pos / FATFS_SECTORSIZE;
            pos %= FATFS_SECTORSIZE;

            fatcache = ( uint8_t * ) cache_read( fatfs, lba, 0 );
            if ( fatfs->error )
            {
                return 0;
            }

            if ( cluster & 1 )
            {
                chaincluster = ( ( fatcache[pos] & 0xF0 ) >> 4 );
            }
            else
            {
                chaincluster = fatcache[pos];
            }

            if ( ++pos == FATFS_SECTORSIZE )
            {
                pos = 0;

                fatcache = ( uint8_t * ) cache_read( fatfs, lba + 1, 0 );
                if ( fatfs->error )
                {
                    return 0;
                }
            }

            if ( cluster & 1 )
            {
                chaincluster |= ( ( fatcache[pos] & 0xFF ) << 4 );
            }
            else
            {
                chaincluster |= ( ( fatcache[pos] & 0x0F ) << 8 );
            }

            return chaincluster;
        }

    case FAT16:
        {
            lba = fatfs->fat_lba + cluster / ( FATFS_SECTORSIZE / 2 );

            fatcache = ( uint8_t * ) cache_read( fatfs, lba, 0 );
            if ( fatfs->error )
            {
                return 0;
            }

            return read_little16from16( fatcache + ( cluster % ( FATFS_SECTORSIZE / 2 ) ) * 2 );
        }

    default:
        // should not reach this line
    case FAT32:
        {
            lba = fatfs->fat_lba + cluster / ( FATFS_SECTORSIZE / 4 );

            fatcache = ( uint8_t * ) cache_read( fatfs, lba, 0 );
            if ( fatfs->error )
            {
                return 0;
            }

            return read_little32from32( fatcache + ( cluster % ( FATFS_SECTORSIZE / 4 ) ) * 4 );
        }
    }
}

// write value in FAT entry for given cluster
static void cluster_writelink( fatfs_t * restrict fatfs, uint32_t cluster, uint32_t value,
                               uint32_t filemask )
{
    uint32_t pos;
    uint32_t lba;
    uint8_t *fatcache;

    switch ( fatfs->type )
    {
    case FAT12:
        {
            pos = cluster + cluster / 2;
            lba = fatfs->fat_lba + pos / FATFS_SECTORSIZE;
            pos %= FATFS_SECTORSIZE;

            fatcache = ( uint8_t * ) cache_read( fatfs, lba, filemask );
            if ( fatfs->error )
            {
                return;
            }

            if ( cluster & 1 )
            {
                fatcache[pos] = ( fatcache[pos] & 0x0F ) | ( ( value & 0x00F ) << 4 );
            }
            else
            {
                fatcache[pos] = value & 0x0FF;
            }

            if ( ++pos == FATFS_SECTORSIZE )
            {
                pos = 0;

                fatcache = ( uint8_t * ) cache_read( fatfs, lba + 1, filemask );
                if ( fatfs->error )
                {
                    return;
                }
            }

            if ( cluster & 1 )
            {
                fatcache[pos] = ( value & 0xFF0 ) >> 4;
            }
            else
            {
                fatcache[pos] = ( fatcache[pos] & 0xF0 ) | ( ( value & 0xF00 ) >> 8 );
            }
        }
        break;

    case FAT16:
        {
            lba = fatfs->fat_lba + cluster / ( FATFS_SECTORSIZE / 2 );

            fatcache = ( uint8_t * ) cache_read( fatfs, lba, filemask );
            if ( fatfs->error )
            {
                return;
            }

            write_little16to16( fatcache + ( cluster % ( FATFS_SECTORSIZE / 2 ) ) * 2, value & 0xFFFF );
        }
        break;

    default:
        // should not reach this line
    case FAT32:
        {
            lba = fatfs->fat_lba + cluster / ( FATFS_SECTORSIZE / 4 );

            fatcache = ( uint8_t * ) cache_read( fatfs, lba, filemask );
            if ( fatfs->error )
            {
                return;
            }

            write_little32to32( fatcache + ( cluster % ( FATFS_SECTORSIZE / 4 ) ) * 4, value );
        }
        break;

    }
}

// allocate extra cluster to given endcluster of chain
extern uint32_t cluster_allocate( fatfs_t * restrict fatfs, uint32_t cluster, uint32_t filemask )
{
    uint32_t testcluster;
    uint32_t nextcluster;

    for ( testcluster = fatfs->lastallocated_cluster; testcluster <= fatfs->max_cluster; ++testcluster )
    {
        nextcluster = cluster_readlink( fatfs, testcluster );
        if ( fatfs->error )
        {
            return CLUSTER_EOC;
        }

        if ( !nextcluster )
        {
            cluster_writelink( fatfs, testcluster, CLUSTER_EOC, filemask );
            if ( fatfs->error )
            {
                return CLUSTER_EOC;
            }

            if ( cluster )
            {
                cluster_writelink( fatfs, cluster, testcluster, filemask );
                if ( fatfs->error )
                {
                    return CLUSTER_EOC;
                }
            }

            fatfs->lastallocated_cluster = testcluster;

            return testcluster;
        }
    }

    return CLUSTER_EOC;
}

// mark all clusters in the chain starting with the given node as unused
extern void cluster_freechain( fatfs_t * restrict fatfs, uint32_t cluster, uint32_t filemask )
{
    uint32_t nextcluster;

    while ( !cluster_is_eoc( fatfs, cluster ) )
    {
        if ( !cluster )
        {
            debugprintf( "ERROR: clusterchain ends with unused instead of EOC\n" );
            break;
        }
        nextcluster = cluster_readlink( fatfs, cluster );
        if ( fatfs->error )
        {
            return;
        }

        cluster_writelink( fatfs, cluster, 0, filemask );
        if ( fatfs->error )
        {
            return;
        }

        if ( cluster < fatfs->lastallocated_cluster )
        {
            fatfs->lastallocated_cluster = cluster;
        }

        cluster = nextcluster;
    }
}
