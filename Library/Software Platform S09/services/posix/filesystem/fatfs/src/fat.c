/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2008 Altium BV
|*
|*  DESCRIPTION:    FAT file system implementation. Supports FAT12, FAT16 and
|*                  FAT32.
|*
\******************************************************************************/

#include <errno.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>

#include <pal.h>
#include <blockio.h>

#include "fat.h"
#include "fat_layout.h"
#include "fat_cache.h"
#include "fat_cluster.h"
#include "fat_direntries.h"
#include "fat_lfn.h"

//.............................................................................
// helper functions

// This is a shortcut to the standard.
// Generate volume id, randomness fully depends on clock().
static uint32_t fat_volume_id( void )
{
    return pal_clock() & 0xFFFFFFFF;
}

// test given name for match with given wildcard, return 1 when match
// TODO: no real wildcards supported yet!
static int wildcard_match( const char *name, const char *wildcard )
{
    if ( strcmp( wildcard, "*" ) == 0 )
    {
        return 1;
    }

    while ( *name && *wildcard && ( toupper( *name ) == toupper( *wildcard ) ) )
    {
        ++name;
        ++wildcard;
    }

    if ( *name || ( *wildcard && ( *wildcard != FS_DIRSEPCHAR ) ) )
    {
        return 0;
    }

    return 1;
}

//.............................................................................
// fcb support functions

// initialize fcb, keep tally of open & writable files
static void fat_fcb_init( fatfs_t * restrict fatfs, fs_fcb_t * fcb )
{
    ++fatfs->filecount_open;

    if ( fcb->flags & ( O_CREAT | O_RDWR | O_WRONLY ) )
    {
        if ( ++fatfs->filecount_writable == 1 )
        {
            // first file open for writing, mark volume as dirty

            // TODO: reset FAT32_CLEANSHUTDOWN bit
             debugprintf("marking volume dirty\n");
        }
    }
}

//.............................................................................
// init block device
int fat_init_block_device( fatfs_t * restrict fatfs, uint32_t *blkstart, uint32_t *blktotal, uint32_t *blksize )
{
    posix_devctl_blockio_cfg_t cfg;

    // just to be safe
    *blkstart = *blktotal = *blksize = 0;

    if ( fatfs->blk_id < 0 )
    {
        // open block device
        int blk_id = open( fatfs->block_device, O_RDWR );

        if ( blk_id < 0 )
        {
            return -1;
        }

        // save file descriptor
        fatfs->blk_id = blk_id;
    }

    // get disk layout
    if ( posix_devctl( fatfs->blk_id, DEVCTL_BLOCKIO_CFG, ( void * ) &cfg, sizeof( cfg ), NULL ) < 0 )
    {
        close(fatfs->blk_id);
        return -1;
    }

    *blkstart = cfg.blkstart;
    *blksize = cfg.blksize;
    *blktotal = cfg.blktotal;

    // select partition
    if ( fatfs->partition_nr > 0 )
    {
        if ( blockio_select_partition( fatfs->blk_id, fatfs->partition_nr, blkstart, blktotal ) < 0 )
        {
            close(fatfs->blk_id);
            return -1;
        }
    }

    // get block driver implementation
    if ( posix_devctl( fatfs->blk_id, DEVCTL_BLOCKIO_IMPL, ( void * ) &fatfs->blkdrv, sizeof( fatfs->blkdrv ), NULL ) < 0 )
    {
        close(fatfs->blk_id);
        return -1;
    }

    fatfs->sectorsize = *blksize;

    return 0;
}

//.............................................................................
// file system operations

/*
 * Microsoft rules for determining clustersize
 */
typedef struct
{
    uint32_t sectors;
    uint8_t type;
    uint8_t sectors_per_cluster;
} fat_type_t;

static const fat_type_t fat_type_list[] = {
    {8400, FAT12, 2},           // 0 - 4.1 Mb FAT12 1k cluster
    {32680, FAT16, 2},          // 4.1 Mb - 16 Mb FAT16 1k cluster
    {262144, FAT16, 4},         // 16 Mb - 128 Mb FAT16 2k cluster
    {524288, FAT16, 8},         // 128 Mb - 256 Mb FAT16 4k cluster
    {1048576, FAT16, 16},       // 256 Mb - 512 Mb FAT16 8k cluster
    {532480, FAT32, 1},         // 32.5 Mb - 260 Mb FAT32 .5k cluster - only when FAT32 forced
    {16777216, FAT32, 8},       // 128 Mb - 8 Gb FAT32 4k cluster
    {33554432, FAT32, 16},      // 8 Gb - 16 Gb FAT32 8k cluster
    {67108864, FAT32, 32},      // 16 Gb - 32 Gb FAT32 16k cluster
    {0xFFFFFFFF, FAT32, 64},    // 32 Gb - 2048 Gb FAT32 32k cluster
    {2097152, FAT16, 32},       // 512 Mb - 1 Gb FAT16 16k cluster - only when FAT16 forced
    {4194304, FAT16, 64},       // 1 Gb - 2 Gb FAT16 32k cluster - only when FAT16 forced
};

/*********************************************************************
* FUNCTION: fat_mkfs
*
* make FAT filesystem
*
* fs                     filesystem to create
* type                   type to create (FAT12/16/32) or if 0 use Microsoft rules
* sectors_per_cluster    clustersize (sectorsize = hardcoded 512 byte) to use, if 0 use Microsoft rules
* removable              if <>0 sets mediatype to "removable", otherwise to "fixed"
* label                  label (11 char max uppercase no spaces etc.)
* cache                  single-element cache
*                        (allocated and owned by caller)
*
* returns                partition typecode for FAT system formatted or errorcode < 0
*/
extern int fat_mkfs( fatfs_t * restrict fatfs,
                     uint8_t type, uint8_t sectors_per_cluster, uint8_t removable,
                     const char *label, fatfs_cache_t * cache )
{
    uint32_t *buf32 = cache[0].data;
    uint8_t *buf8 = ( uint8_t * ) buf32;
    fat_volume_t *volume = ( fat_volume_t * ) buf32;
    uint8_t reserved_sector_count;
    uint16_t root_entry_count;
    uint32_t rootdir_cluster;
    uint8_t media;
    uint8_t number_of_fats;
    char *filesystem_type;
    uint8_t info_sector;
    uint8_t backup_boot_sector;
    const fat_type_t *fat_type;
    int rootdir_sectors;
    uint16_t sectors_per_fat;
    int data_sector_count;
    int data_cluster_count;
    int wipecount;
    int tmp1, tmp2;
    fat16_volume_t *fat16_volume;
    uint32_t lba;
    uint32_t blkstart;
    uint32_t blksize;
    uint32_t blktotal;

    if ( fat_init_block_device( fatfs, &blkstart, &blktotal, &blksize ) < 0 )
    {
        return -1;
    }

    debugprintf( "formatting blockdevice (start %i count %i bs %i) using FAT driver\n",
                 blkstart, blktotal, blksize );

    if ( blksize > FATFS_CACHE_BLOCKSIZE )
    {
        debugprintf( "unsupported blocksize, aborting format\n" );
        return FS_ERROR_FAT_BLOCKSIZE_UNSUPPORTED;
    }

    if ( blktotal < 2 )
    {
        debugprintf( "partition too small, aborting format\n" );
        return 0;
    }

    /* IMPORTANT:
     * Before modifying values below be sure to read the Microsoft specs for FAT filesystems.
     * All values below were choosen to give maximum compatibility on all platforms.
     * This is especially important when moving FAT systems around on memorycards and the like.
     */

    reserved_sector_count = 1;
    root_entry_count = 0;
    rootdir_cluster = 2;
    media = removable ? FAT_MEDIA_REMOVABLE : FAT_MEDIA_FIXED;
    number_of_fats = 2;
    filesystem_type = 0;
    info_sector = 1;
    backup_boot_sector = 6;

    // if the FAT type or sectorsize was not specified use Microsofts' tables
    // NOTE: the table is based on clustersize 512 and all other settings as given above
    fat_type = fat_type_list;
    while ( !sectors_per_cluster )
    {
        if ( ( blktotal <= fat_type->sectors ) && ( !type || ( type == fat_type->type ) ) )
        {
            type = fat_type->type;
            sectors_per_cluster = fat_type->sectors_per_cluster;
        }
        ++fat_type;
    }

    switch ( type )
    {
    case FS_PARTITIONTYPE_FAT12:
        type = FAT12;
        root_entry_count = 64;
        filesystem_type = "FAT12   ";
        break;

    case FS_PARTITIONTYPE_FAT16LESS32M:
    case FS_PARTITIONTYPE_FAT16:
    case FS_PARTITIONTYPE_FAT16WIN95:
        type = FAT16;
        root_entry_count = 512;
        filesystem_type = "FAT16   ";
        break;

    case FS_PARTITIONTYPE_FAT32:
    case FS_PARTITIONTYPE_FAT32LBA:
        type = FAT32;
        reserved_sector_count = 32;
        filesystem_type = "FAT32   ";
        break;

    default:
        debugprintf( "unknown FAT type, aborting format\n" );
        return FS_ERROR_FAT_UNKNOWN_TYPE;

    }

    /*
     * Microsoft magic formula to determine the FAT size (don't touch, correct or try to understand :-)
     */
    rootdir_sectors = ( ( root_entry_count * 32 ) + ( blksize - 1 ) ) / blksize;
    tmp1 = blktotal - ( reserved_sector_count + rootdir_sectors );
    tmp2 = ( 256 * sectors_per_cluster ) + number_of_fats;
    if ( type == FAT32 )
    {
        tmp2 = tmp2 / 2;
    }
    sectors_per_fat = ( tmp1 + ( tmp2 - 1 ) ) / tmp2;

    /* Microsoft magic formula to determine if the FAT type is legal for the number of data clusters
     * (only needed to verify user specified FAT type & clustersize)
     */
    data_sector_count =
        blktotal - ( reserved_sector_count + ( number_of_fats * sectors_per_fat ) + rootdir_sectors );
    data_cluster_count = data_sector_count / sectors_per_cluster;

    debugprintf( "type: %s\n", filesystem_type );
    debugprintf( "sectors per cluster: %i\n", sectors_per_cluster );
    debugprintf( "reserved sectors: %i\n", reserved_sector_count );
    debugprintf( "sectors per fat: %i\n", sectors_per_fat );
    debugprintf( "data cluster count: %i\n", data_cluster_count );
    debugprintf( "number of FATs: %i\n", number_of_fats );
    debugprintf( "rootdir sectors: %i (entries: %i)\n", rootdir_sectors, root_entry_count );

    if ( ( ( ( data_cluster_count < 4085 ) && ( type != FAT12 ) ) ||
           ( ( data_cluster_count >= 4085 ) && ( data_cluster_count < 65525 ) && ( type != FAT16 ) ) ||
           ( ( data_cluster_count >= 65525 ) && ( type != FAT32 ) ) ) )
    {
        debugprintf( "illegal FAT type for number of data clusters, aborting format\n" );
        return FS_ERROR_FAT_ILLEGALTYPE;
    }

    // wipe start of disk
    wipecount = reserved_sector_count + // reserved region
        ( number_of_fats * sectors_per_fat ) +  // FAT(s)
        rootdir_sectors +       // rootdir region
        ( ( type == FAT32 ) ? sectors_per_cluster : 0 );        // for FAT32 the initial rootdir cluster
    if ( fatfs->blkdrv.clear_sectors( fatfs->blkdrv.device, blkstart, wipecount ) != wipecount )
    {
        return FS_ERROR_FAT_IO;
    }

    // build the volume sector
    memset( buf32, 0, blksize );
    // bootstrap code is nonsensical but needed?
    volume->bootstrap[0] = BOOTSTRAP_0;
    volume->bootstrap[1] = BOOTSTRAP_1;
    volume->bootstrap[2] = BOOTSTRAP_2;
    strncpy( volume->oemname, "MSWIN4.1", 8 );
    write_little16to8( volume->bytes_per_sector, (uint16_t) blksize);
    volume->sectors_per_cluster = sectors_per_cluster;
    write_little16to16( volume->reserved_sector_count, reserved_sector_count );
    volume->number_of_fats = number_of_fats;
    write_little16to8( volume->root_entry_count, root_entry_count );
    write_little16to8( volume->sector_count_16, ( ( blktotal < 0x10000 ) ? blktotal : 0 ) & 0xFFFF );
    volume->media = media;
    write_little16to16( volume->sectors_per_fat_16, ( type == FAT32 ) ? 0 : sectors_per_fat );
    write_little32to32( volume->sector_count_32, blktotal );

    if ( type == FAT32 )
    {
        fat32_volume_t *fat32_volume = ( fat32_volume_t * ) ( buf8 + sizeof( fat_volume_t ) );

        write_little32to32( fat32_volume->sectors_per_fat_32, sectors_per_fat );
        write_little32to32( fat32_volume->rootdir_cluster, rootdir_cluster );
        write_little16to16( fat32_volume->info_sector, info_sector );
        write_little16to16( fat32_volume->backup_boot_sector, backup_boot_sector );

        fat16_volume = ( fat16_volume_t * ) ( buf8 + sizeof( fat_volume_t ) + sizeof( fat32_volume_t ) );
    }
    else
    {
        fat16_volume = ( fat16_volume_t * ) ( buf8 + sizeof( fat_volume_t ) );
    }

    fat16_volume->boot_signature = FAT_EXTENDED_BOOT_SIGNATURE;
    write_little32to8( fat16_volume->volume_id, fat_volume_id() );    // 'random' serial nr
    shortname2sfn( label, fat16_volume->volume_label, 1 );
    strncpy( fat16_volume->filesystem_type, filesystem_type, 8 );

    write_little16to16( buf8 + FAT_SIGNATURE_OFFSET, FAT_SIGNATURE );

    // write the volume sector
    lba = blkstart;
    if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, buf32, lba, 1 ) != 1 )
    {
        return FS_ERROR_FAT_IO;
    }

    if ( type == FAT32 )
    {
        // write the backup of the volume sector
        if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, buf32, lba + backup_boot_sector, 1 ) != 1 )
        {
            return FS_ERROR_FAT_IO;
        }

    }
    ++lba;

    if ( type == FAT32 )
    {
        // build the fsinfo sector
        fat32_fsinfo_t *fsinfo = ( fat32_fsinfo_t * ) buf32;
        memset( buf32, 0, blksize );

        write_little32to32( fsinfo->lead_signature, FAT32_FSINFO_LEAD_SIGNATURE );
        write_little32to32( fsinfo->struct_signature, FAT32_FSINFO_STRUCT_SIGNATURE );
        write_little32to32( fsinfo->free_cluster_count, 0 );
        write_little32to32( fsinfo->next_free_cluster, 0 );
        write_little32to32( fsinfo->trail_signature, FAT32_FSINFO_TRAIL_SIGNATURE );

        // write the fsinfo sector
        if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, buf32, lba, info_sector ) != 1 )
        {
            return FS_ERROR_FAT_IO;
        }

        // write the backup of the fsinfo sector
        if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, buf32, lba + backup_boot_sector, 1 ) != 1 )
        {
            return FS_ERROR_FAT_IO;
        }
    }

    // create the FAT
    memset( buf32, 0, blksize );

    // first FAT entry is all bits set, but with media code at bytepos 0
    // second FAT entry is always EOC
    switch ( type )
    {
    case FAT12:
        buf8[0] = media;
        buf8[1] = 0xFF;
        buf8[2] = 0xFF;
        break;

    case FAT16:
        buf8[0] = media;
        buf8[1] = 0xFF;
        write_little16to16( buf8 + 2, CLUSTER_EOC & 0xFFFF );
        break;

    case FAT32:
        buf8[0] = media;
        buf8[1] = 0xFF;
        buf8[2] = 0xFF;
        buf8[3] = 0x0F;
        write_little32to32( buf8 + 4, CLUSTER_EOC );
        write_little32to32( buf8 + 4 * rootdir_cluster, CLUSTER_EOC );
        break;

    }

    // write the first FAT sector in all its copies
    lba = blkstart + reserved_sector_count;
    for ( int i = 0; i < number_of_fats; ++i )
    {
        if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, buf32, lba, 1 ) != 1 )
        {
            return FS_ERROR_FAT_IO;
        }

        lba += sectors_per_fat;
    }

    // create the first sector of the rootdir
    memset( buf32, 0, blksize );

    // dir-entry for volume label
    fat_direntry_t *direntry = ( fat_direntry_t * ) buf32;
    shortname2sfn( label, direntry->name, 1 );
    direntry->attributes = FATFS_ATTRIBUTE_VOLUME;

    // write the first sector of the rootdir
    if ( fatfs->blkdrv.write_sectors( fatfs->blkdrv.device, buf32, lba, 1 ) != 1 )
    {
        return FS_ERROR_FAT_IO;
    }

    // make sure all ends up written to the device
    if ( fatfs->blkdrv.flush_data( fatfs->blkdrv.device, 1 ) )
    {
        return FS_ERROR_FAT_IO;
    }

    return type;
}

/*********************************************************************
* FUNCTION: fat_open_filesystem
*
* initialize existing FAT filesystem
*
* fatfs            filesystem structure to use for mounting the filesystem
* blkdev        blockdevice on which filesystem is located
* flags         TODO: global properties of filesystem
* cache         area to be used for private cache
*                   (allocated and owned by caller)
* cache_count   size (in fatfs_cache_t) of cache
*
* returns       0 success, <0 error with filesystem not mounted, >0 error with filesystem mounted
*/
int fat_open_filesystem( fatfs_t * restrict fatfs, uint16_t flags, fatfs_cache_t * cache, int cache_count )
{
    uint32_t *buf32 = cache[0].data;    // use first cache as scratchbuffer
    uint8_t *buf8 = ( uint8_t * ) buf32;
    fat_volume_t *volume;
    uint8_t type;
    fat32_volume_t *fat32_volume;
    uint16_t reserved_sector_count;
    uint8_t media;
    uint16_t root_entry_count;
    uint16_t bytes_per_sector;
    uint32_t sectors_per_fat;
    uint32_t sector_count;
    int rootdir_sectors;
    int data_sector_count;
    int data_cluster_count;
    uint32_t blkstart;
    uint32_t blksize;
    uint32_t blktotal;

    if ( fat_init_block_device( fatfs, &blkstart, &blktotal, &blksize ) < 0 )
    {
        return -1;
    }

    fatfs->error = 0;
    fatfs->flags = flags;
    fatfs->cache_mru = cache;
    fatfs->filecount_open = 0;
    fatfs->filecount_writable = 0;
#if FATFS_DEBUG
    fatfs->hits = 0;
    fatfs->misses = 0;
    fatfs->direntrywrite = 0;
    fatfs->direntryread = 0;
#endif

    // initialize cache
    cache_init( fatfs, cache_count );

    // read volume table
    if ( fatfs->blkdrv.read_sectors( fatfs->blkdrv.device, buf32, blkstart, 1 ) != 1 )
    {
        return FS_ERROR_FAT_IO;
    }

    volume = ( fat_volume_t * ) buf32;

    bytes_per_sector = read_little16from8( volume->bytes_per_sector );
    if (( bytes_per_sector != blksize ) || ( bytes_per_sector > FATFS_CACHE_BLOCKSIZE ))
    {
        debugprintf( "FAT blocksize unsupported, aborting mount\n" );
        return FS_ERROR_FAT_BLOCKSIZE_UNSUPPORTED;
    }

    if ( read_little16from16( buf8 + FAT_SIGNATURE_OFFSET ) != FAT_SIGNATURE )
    {
        debugprintf( "wrong FAT signature, aborting mount\n" );
        return FS_ERROR_FAT_SIGNATURE;
    }

    reserved_sector_count = read_little16from16( volume->reserved_sector_count );
    media = volume->media;
    root_entry_count = read_little16from8( volume->root_entry_count );
    sectors_per_fat = read_little16from16( volume->sectors_per_fat_16 );
    sector_count = read_little16from8( volume->sector_count_16 );

    /* FAT32 only */
    fat32_volume = ( fat32_volume_t * ) ( buf8 + sizeof( fat_volume_t ) );
    if ( !sector_count )
    {
        sector_count = read_little32from16( volume->sector_count_32 );
    }
    if ( !sectors_per_fat )
    {
        sectors_per_fat = read_little32from32( fat32_volume->sectors_per_fat_32 );
    }

    /*
     * Microsoft magic formula to determine the FAT type (don't touch, correct or try to understand :-)
     */

    rootdir_sectors = ( ( root_entry_count * 32 ) + ( blksize - 1 ) ) / blksize;
    data_sector_count = sector_count - reserved_sector_count - rootdir_sectors
        - ( volume->number_of_fats * sectors_per_fat );
    data_cluster_count = data_sector_count / volume->sectors_per_cluster;

    if ( data_cluster_count < 4085 )
    {
        debugprintf( "type FAT12\n" );
        type = FAT12;
        fatfs->rootdir_node = 0;
    }
    else if ( data_cluster_count < 65525 )
    {
        debugprintf( "type FAT16\n" );
        type = FAT16;
        fatfs->rootdir_node = 0;
    }
    else
    {
        debugprintf( "type FAT32\n" );
        type = FAT32;
        fatfs->rootdir_node = read_little32from32( fat32_volume->rootdir_cluster );

        // we only support 0.0 (are there others anyway?)
        if ( read_little16from16( fat32_volume->version ) != FAT32_VERSION )
        {
            debugprintf( "unknown FAT32 subtype, aborting mount\n" );
            return FS_ERROR_FAT32_UNSUPPORTED_VERSION;
        }
    }

    fatfs->type = type;
    fatfs->fat_lba = blkstart + reserved_sector_count;
    fatfs->sectors_per_cluster = volume->sectors_per_cluster;
    fatfs->sectors_per_fat = sectors_per_fat;
    fatfs->number_of_fats = volume->number_of_fats;
    fatfs->lastallocated_cluster = 2;
    fatfs->rootdir_lba = fatfs->fat_lba + volume->number_of_fats * sectors_per_fat;
    fatfs->data_lba =
        fatfs->rootdir_lba + root_entry_count * sizeof( fat_direntry_t ) / blksize;
    fatfs->max_cluster =
        ( sector_count - ( fatfs->data_lba - fatfs->fat_lba ) ) / volume->sectors_per_cluster;
    fatfs->curdir_node = fatfs->rootdir_node;

    debugprintf( "sectors in blockdriver: %i\n", blktotal );
    debugprintf( "sectors per cluster: %i\n", fatfs->sectors_per_cluster );
    debugprintf( "number of fats: %i\n", volume->number_of_fats );
    debugprintf( "rootdir entries: %i\n", root_entry_count );
    debugprintf( "data cluster count: %i\n", data_cluster_count );
    debugprintf( "\n" );

    // read first sector of FAT
    if ( fatfs->blkdrv.read_sectors( fatfs->blkdrv.device, buf32, fatfs->fat_lba, 1 ) != 1 )
    {
        return FS_ERROR_FAT_IO;
    }

    // first FAT entry should have all bits set, but with media code at bytepos 0
    // second FAT entry is always EOC
    // FAT16/FAT32 have flags to indicate previous problems, we'll mount
    // but will report them
    // TODO: don't ever reset the flags ourselves when we can't repair?
    switch ( type )
    {
    case FAT12:
        if ( ( buf8[0] != media ) || ( buf8[1] != 0xFF ) || ( buf8[2] != 0xFF ) )
        {
            debugprintf( "warning: wrong media marker at begin of fat\n" );
            return FS_ERROR_FAT_CORRUPT;
        }
        break;

    case FAT16:
        {
            uint16_t cluster = read_little16from16( buf8 + 2 );

            if ( ( buf8[0] != media ) || ( buf8[1] != 0xFF ) ||
                 !cluster_is_eoc( fatfs, cluster | FAT16_HARDERROR | FAT16_CLEANSHUTDOWN ) )
            {
                debugprintf( "warning: wrong media marker at begin of fat\n" );
                return FS_ERROR_FAT_CORRUPT;
            }

            if ( !( cluster & FAT16_HARDERROR ) )
            {
                debugprintf( "warning: fat marked as harderror\n" );
                return FS_ERROR_FAT_HARDERROR;
            }

            if ( !( cluster & FAT16_CLEANSHUTDOWN ) )
            {
                debugprintf( "warning: fat marked as dirty shutdown\n" );
                return FS_ERROR_FAT_CLEANSHUTDOWN;
            }
        }
        break;

    case FAT32:
        {
            uint32_t cluster = read_little32from32( buf8 + 4 );

            if ( ( buf8[0] != media ) || ( buf8[1] != 0xFF ) || ( buf8[2] != 0xFF )
                 || ( ( buf8[3] & 0x0F ) != 0x0F )
                 || !cluster_is_eoc( fatfs, cluster & FAT32_CLUSTER_MASK ) )
            {
                debugprintf( "warning: wrong media marker at begin of fat\n" );
                return FS_ERROR_FAT_CORRUPT;
            }

            if ( !( cluster & FAT32_HARDERROR ) )
            {
                debugprintf( "warning: fat marked as harderror\n" );
                return FS_ERROR_FAT_HARDERROR;
            }

            if ( !( cluster & FAT32_CLEANSHUTDOWN ) )
            {
                debugprintf( "warning: fat marked as dirty shutdown\n" );
                return FS_ERROR_FAT_CLEANSHUTDOWN;
            }
        }
        break;

    }

    /* TODO: verify that FAT copies are identical */

    return 0;
}

int fat_flush_all( fatfs_t * restrict fatfs, int invalidate )
{
    if ( fatfs->error )
    {
        return -1;
    }

    cache_flush( fatfs, 0xFFFFFFFF, invalidate );
    if ( fatfs->error )
    {
        return -1;
    }

    if ( fatfs->blkdrv.flush_data( fatfs->blkdrv.device, invalidate ) < 0 )
    {
        return -1;
    }

    return 0;
}

//.............................................................................
// file/directory operations

int fat_flush( fs_fcb_t * restrict fcb )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    cache_flush( fatfs, fcb->filemask, 0 );
    if ( fatfs->error )
    {
        return -1;
    }

    if ( fatfs->blkdrv.flush_data( fatfs->blkdrv.device, 0 ) < 0 )
    {
        return -1;
    }

    return 0;
}

int fat_open( fs_fcb_t * restrict fcb, const fatfs_dirent_t * restrict dirent )
{
    fatfs_t * restrict fatfs = ( fatfs_t * ) fcb->fs;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    fat_fcb_init( fatfs, fcb );

    fat_fcb_pos_at_node( fatfs, fcb, 0 );

    // will be used to find the referring direntry
    fcb->u.fat.direntry_location.lba = dirent->u.fat.direntry_location.lba;
    fcb->u.fat.direntry_location.pos_in_sector = dirent->u.fat.direntry_location.pos_in_sector;

    if ( fcb->flags & O_TRUNC )
    {
        // update to actual size & startcluster
        uint32_t cluster;
        uint32_t size;
        dir_get_actuals( fatfs, fcb, &cluster, &size );
        if ( fatfs->error )
        {
            return -1;
        }

        if ( size )
        {
            fat_direntry_t *direntry;

            // truncate
            cluster_freechain( fatfs, cluster, fcb->filemask );
            if ( fatfs->error )
            {
                return -1;
            }

            direntry = dir_get_entry( fatfs, &fcb->u.fat.direntry_location );
            if ( fatfs->error )
            {
                return -1;
            }

            dir_set_cluster( direntry, 0 );
            dir_set_size( direntry, 0 );
            dir_set_timestamp( direntry, DIR_TIMESTAMP_MODIFIED );
            dir_setdirty( fatfs, fcb, &fcb->u.fat.direntry_location );

            if ( fatfs->flags & FS_FLAG_SYNC )
            {
                fat_flush( fcb );
                if ( fatfs->error )
                {
                    return -1;
                }
            }
        }
    }

    return 0;
}

int fat_diropen( fs_fcb_t * restrict fcb, uint32_t node )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    fat_fcb_init( fatfs, fcb );

    fcb->flags = O_RDONLY;

    // FAT32 node 0 (root dir) is defined in the volumetable
    if ( !node && ( fatfs->type == FAT32 ) )
    {
        node = fatfs->rootdir_node;
    }

    fat_fcb_pos_at_node( fatfs, fcb, node );

    return 0;
}

int fat_dirread( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent, const char *wildcard, uint32_t node )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    fat_direntry_t *direntry;

    dirent->fs = fcb->fs;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    for ( ;; )
    {
#if FATFS_USE_LFN
        direntry = dir_get_next_file( fatfs, fcb, &dirent->u.fat.direntry_location,
                                      dirent->dirent.d_name, NAME_MAX + 1 );
#else
        direntry = dir_get_next_file( fatfs, fcb, &dirent->u.fat.direntry_location );
#endif
        if ( fatfs->error )
        {
            return -1;
        }

        if ( !direntry )
        {
            return -1;
        }                       // no more files

        // cluster number the entry is pointing at
        dirent->node = ( ( uint32_t ) ( read_little16from8( direntry->cluster_high ) ) << 16 ) |
            ( uint32_t ) read_little16from8( direntry->cluster_low );

        if ( node && ( dirent->node != node ) )
        {
            continue;
        }                       // node did not match the one specified

#if FATFS_USE_LFN
        sfn2shortname( direntry->name, dirent->u.fat.shortname,
                       direntry->attributes & FATFS_ATTRIBUTE_VOLUME );

        if ( wildcard )
        {
            if ( !*dirent->dirent.d_name || !wildcard_match( dirent->dirent.d_name, wildcard ) )
            {
                // no lfn or no match, try matching the 8.3 name

                // (this does give weird matches but is as should be,
                // try running "dir *1*" on any Microsoft OS...)
                if ( !wildcard_match( dirent->u.fat.shortname, wildcard ) )
                {
                    continue;
                }
            }
        }

        if ( !*dirent->dirent.d_name )
        {
            // no LFN name, use the 8.3 name as full name
            strncpy( dirent->dirent.d_name, dirent->u.fat.shortname, NAME_MAX + 1 );
        }
#else
        sfn2shortname( direntry->name, dirent->dirent.d_name, direntry->attributes & FATFS_ATTRIBUTE_VOLUME );

        if ( wildcard && !wildcard_match( dirent->dirent.d_name, wildcard ) )
        {
            continue;
        }
#endif

        // size is often used and nice to have converted to MSB
        dirent->size = read_little32from8( direntry->filesize );

        // same for attributes
        dirent->attributes = direntry->attributes;

        return 0;
    }
}

int fat_close( fs_fcb_t * restrict fcb )
{
    int     error = 0;
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;

    if ( fcb->flags & ( O_CREAT | O_RDWR | O_WRONLY ) )
    {
        fat_flush( fcb );
        if ( fatfs != NULL && fatfs->error )
        {
            error = -1;
        }
    }

    if (fatfs != NULL)
    {
        --fatfs->filecount_open;

        if ( fcb->flags & ( O_CREAT | O_RDWR | O_WRONLY ) )
        {
            if ( !--fatfs->filecount_writable )
            {
                // no more files open for writing, mark volume as clean

                // TODO: write new free clustercount and last allocated cluster to fsinfo sector

                // TODO: set FAT32_CLEANSHUTDOWN bit
                 debugprintf("marking volume clean\n");
            }
        }
    }

    return error;
}

int fat_create( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    fat_direntry_t *direntry;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    fat_fcb_init( fatfs, fcb );

    dirent->node = 0;

    direntry = dir_create_entry( fatfs, fcb, dirent, 0 );

    if ( fatfs->error )
    {
        return -1;
    }

    if ( !direntry )
    {
        return -1;
    }

    fat_flush( fcb );
    if ( fatfs->error )
    {
        return -1;
    }

    // setup the fcb to reflect an empty file
    fat_fcb_pos_at_node( fatfs, fcb, 0 );

    // remember where to find the directory entry
    fcb->u.fat.direntry_location.lba = dirent->u.fat.direntry_location.lba;
    fcb->u.fat.direntry_location.pos_in_sector = dirent->u.fat.direntry_location.pos_in_sector;

    return 0;
}

int fat_remove( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    fat_direntry_location_t *direntry_location = &fcb->u.fat.direntry_location;
    uint32_t cluster;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    fat_fcb_init( fatfs, fcb );

    // will be used to find the referring direntry
    direntry_location->lba = dirent->u.fat.direntry_location.lba;
    direntry_location->pos_in_sector = dirent->u.fat.direntry_location.pos_in_sector;

    // verify if any other handle is referring to same entry
    fs_fcb_t *openfcb = fatfs->fcblist;
    while ( openfcb )
    {
        if ( ( openfcb != fcb ) &&
             ( openfcb->u.fat.direntry_location.lba == direntry_location->lba ) &&
             ( openfcb->u.fat.direntry_location.pos_in_sector == direntry_location->pos_in_sector ) )
        {
            // other fcb has same file open
            fat_close( fcb );
            if ( fatfs->error )
            {
                return -1;
            }

            seterrno( EBUSY );
            return -1;
        }

        openfcb = openfcb->fcb_next;
    }

    dir_get_actuals( fatfs, fcb, &cluster, 0 );
    if ( fatfs->error )
    {
        return -1;
    }

    if ( dirent->attributes & FS_ATTRIBUTE_SUBDIR )
    {
        // verify if subdir is empty
        fat_fcb_pos_at_node( fatfs, fcb, cluster );
        for ( ;; )
        {
            fat_direntry_t *direntry;

            direntry = dir_get_next_entry( fatfs, fcb, 0 );
            if ( fatfs->error )
            {
                return -1;
            }

            if ( !direntry )
            {
                // end of directory
                break;
            }
            else if ( !*direntry->name )
            {
                // last entry
                break;
            }
            else if ( *direntry->name == FATFS_NAME0_FREE )
            {
                // unused entry, skip
            }
            else if ( *direntry->name == '.' )
            {
                // dot or dotdot entry, skip
            }
            else
            {
                // used, can't delete
                fat_close( fcb );

                return EEXIST;
            }
        }
    }

    cluster_freechain( fatfs, cluster, fcb->filemask );
    if ( fatfs->error )
    {
        return -1;
    }

    dir_remove_entry( fatfs, fcb, dirent->dirnode, &dirent->u.fat.direntry_location );
    if ( fatfs->error )
    {
        return -1;
    }

    return fat_close( fcb );
}

// TODO: improve powerfailure robustness?
int fat_rename( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent, uint32_t newdirnode, const char *newname )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    fat_direntry_t *org_direntry;
    uint32_t org_dirnode;
    fat_direntry_location_t org_direntry_location_copy;
    fat_direntry_t org_direntry_copy;
    fat_direntry_t *new_direntry;
    fat_direntry_location_t dotdot_direntry_location;
    fat_direntry_t *dotdot_direntry;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    fat_fcb_init( fatfs, fcb );

    // read old dir entry
    org_direntry = dir_get_entry( fatfs, &dirent->u.fat.direntry_location );
    if ( fatfs->error )
    {
        return -1;
    }

// if LFN support we just treat every rename as a move and create a new
// set of directory entries, verifying if the new name would fit into the
// old slots would be just as much work
#if ( FATFS_USE_LFN == 0 )
    if ( newdirnode == dirent->dirnode )
    {
        // rename only
        shortname2sfn( newname, org_direntry->name, 0 );
        dir_setdirty( fatfs, fcb, &dirent->u.fat.direntry_location );
    }
    else
#endif
    {
        // move (& optionally rename)

        // remember location of org entry, we will only wipe it after the copy succeeded
        org_dirnode = dirent->dirnode;
        org_direntry_location_copy = dirent->u.fat.direntry_location;

        // make copy of direntry location in case cache gets wiped while creating the LFN slots
        org_direntry_copy = *org_direntry;

        // set up dirent to describe the renamed and/or moved location
        dirent->dirnode = newdirnode;
        if ( newname )
        {
            if ( strlen(newname) > NAME_MAX )
            {
                fat_close( fcb );
                return ENAMETOOLONG;
            }
            strcpy( dirent->dirent.d_name, newname );
        }

        // create new entry
        new_direntry = dir_create_entry( fatfs, fcb, dirent, &org_direntry_copy );
        if ( fatfs->error )
        {
            return -1;
        }

        if ( !new_direntry )
        {
            fat_close( fcb );
            return -1;
        }

        // remove old entry
        dir_remove_entry( fatfs, fcb, org_dirnode, &org_direntry_location_copy );
        if ( fatfs->error )
        {
            return -1;
        }

        if ( ( newdirnode != org_dirnode ) && ( dirent->attributes & FS_ATTRIBUTE_SUBDIR ) )
        {
            // we moved a dir, open it (can always be opened as a file because the special rootdir can't be moved)
            fat_fcb_pos_at_node( fatfs, fcb, dirent->node );

            // first entry is dot-entry
            dir_get_next_entry( fatfs, fcb, 0 );
            if ( fatfs->error )
            {
                return -1;
            }

            // 2nd entry is dotdot-entry, change it to refer to the new parent
            dotdot_direntry = dir_get_next_entry( fatfs, fcb, &dotdot_direntry_location );
            if ( fatfs->error )
            {
                return -1;
            }

            dir_set_cluster( dotdot_direntry, newdirnode );
            dir_set_timestamp( dotdot_direntry, DIR_TIMESTAMP_MODIFIED );
            dir_setdirty( fatfs, fcb, &dotdot_direntry_location );
        }
    }

    // TODO: touch parentdir(s)?

    return fat_close( fcb );
}

int fat_mkdir( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    fat_direntry_t *direntry;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    fat_fcb_init( fatfs, fcb );

    // allocate initial directory cluster
    dirent->node = cluster_allocate( fatfs, 0, fcb->filemask );
    if ( fatfs->error )
    {
        return -1;
    }

    // location of first entry
    uint32_t lba = cluster2lba( fatfs, dirent->node );
    fcb->u.fat.direntry_location.lba = lba;
    fcb->u.fat.direntry_location.pos_in_sector = 0;

    // created a blank sector as first sector of the new dir
    direntry = ( fat_direntry_t * ) cache_blank( fatfs, lba, fcb->filemask );
    if ( fatfs->error )
    {
        return -1;
    }

    // have a dot-entry pointing to ourselves
    direntry = dir_get_entry( fatfs, &fcb->u.fat.direntry_location );
    if ( fatfs->error )
    {
        return -1;
    }

    dir_set_cluster( direntry, dirent->node );
    dir_set_timestamp( direntry, DIR_TIMESTAMP_CREATED | DIR_TIMESTAMP_MODIFIED );
    memcpy( direntry->name, ".          ", 11 );
    direntry->attributes = FATFS_ATTRIBUTE_SUBDIR;

    // have a dotdot-entry pointing to our parent
    ++direntry;
    dir_set_cluster( direntry, dirent->dirnode );
    dir_set_timestamp( direntry, DIR_TIMESTAMP_CREATED | DIR_TIMESTAMP_MODIFIED );
    memcpy( direntry->name, "..         ", 11 );
    direntry->attributes = FATFS_ATTRIBUTE_SUBDIR;

    // (cache_blank has marked sector dirty)

    // blank the other sectors of the cluster
    if ( fatfs->sectors_per_cluster > 1 )
    {
        cache_writethrough( fatfs, 0, ++lba, fatfs->sectors_per_cluster - 1, fcb->filemask );
        if ( fatfs->error )
        {
            return -1;
        }
    }

    // create entry in parentdir
    direntry = dir_create_entry( fatfs, fcb, dirent, 0 );

    if ( fatfs->error || !direntry )
    {
        // we could not create the parent, clean up the directory we just allocated
        cluster_freechain( fatfs, dirent->node, fcb->filemask );

        fat_close( fcb );
        return -1;
    }

    return fat_close( fcb );
}

int fat_seek( fs_fcb_t * restrict fcb, uint32_t offset, _whence_t whence )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    uint32_t cluster;
    uint32_t size;

    if ( fatfs == NULL || fatfs->error )
    {
        return -1;
    }

    // get actual startcluster & size for open file
    dir_get_actuals( fatfs, fcb, &cluster, &size );
    if ( fatfs->error )
    {
        return -1;
    }

    if ( cluster != fcb->u.fat.cluster )
    {
        // startcluster has changed
        fcb->u.fat.cluster = cluster;

        // cluster of our position is now invalid
        fcb->u.fat.pos_cluster = 0;
    }

    switch ( whence )
    {
    case SEEK_CUR:
        offset += fcb->u.fat.pos;
        break;
    case SEEK_END:
        offset += size;
        break;
    }

    if ( offset > size )
    {
        // positioning beyond EOF
        fcb->u.fat.pos_cluster = 0;
    }
    else
    {
        uint16_t clustersize = fatfs->sectors_per_cluster * FATFS_SECTORSIZE;

        // we are currently at the N-th cluster of the file,
        // (this is NOT the same as the clusternumber)
        uint32_t clusternr_old = fcb->u.fat.pos / clustersize;

        if ( !cluster_is_eoc( fatfs, fcb->u.fat.pos_cluster ) &&
             ( ( offset / clustersize ) == clusternr_old ) )
        {
            // we stay in the same cluster
        }
        else
        {
            // TODO: optimize forward seeking

            // we don't know the cluster anymore
            fcb->u.fat.pos_cluster = 0;
        }
    }
    fcb->u.fat.pos = offset;

    return offset;
}

// internal combined read/write routine
static int readwrite( fs_fcb_t * restrict fcb, void *buffer, uint32_t size, uint32_t count, uint8_t writemode )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    uint32_t lba;
    uint32_t *datacache;

    uint32_t bytes_processed = 0;
    uint8_t cluster_update = 0;

    uint16_t clustersize;
    uint32_t pos_in_cluster;
    uint32_t pos_in_sector;

    if (fatfs == NULL)
    {
        seterrno( EIO );
        return -1;
    }

    clustersize = fatfs->sectors_per_cluster * FATFS_SECTORSIZE;

    pos_in_cluster = fcb->u.fat.pos % clustersize;
    pos_in_sector = pos_in_cluster % FATFS_SECTORSIZE;

    if ( fcb->u.fat.cluster )
    {
        if ( !fcb->u.fat.pos_cluster )
        {
            // follow the clusterchain from the top
            uint32_t cluster = fcb->u.fat.cluster;
            uint32_t cluster_endpos = clustersize;

            while ( fcb->u.fat.pos >= cluster_endpos )
            {
                cluster = cluster_readlink( fatfs, cluster );
                if ( fatfs->error )
                {
                    return 0;
                }

                if ( !cluster || cluster_is_eoc( fatfs, cluster ) )
                {
                    // internal error: broken chain or chain too short
                    seterrno( EIO );
                    return -1;
                }

                cluster_endpos += clustersize;
            }

            fcb->u.fat.pos_cluster = cluster;
            fcb->u.fat.pos_pastcluster = 0;
        }
        // TODO: add blank for pos > size (LET CALLER HANDLE?)

        lba = cluster2lba( fatfs, fcb->u.fat.pos_cluster ) + ( pos_in_cluster / FATFS_SECTORSIZE );
        if ( fcb->u.fat.pos_pastcluster )
        {
            // only truth if continuous sectors, will be verified later
            lba += fatfs->sectors_per_cluster;
        }
    }
    else
    {
        lba = 0;
    }

    // 1. read data not aligned to a sector
    if ( pos_in_sector )
    {
        // bytes to process in the first sector
        uint16_t bytes = FATFS_SECTORSIZE - pos_in_sector;

        if ( bytes > count )
        {
            bytes = ( uint16_t ) count;
        }

        // get the sector into the cache
        datacache = cache_read( fatfs, lba, 0 );
        if ( fatfs->error )
        {
            return 0;
        }

#if FATFS_DEBUG_READWRITE
debugprintf("%s lba %i pos %i count %i\n", writemode ? "write " : "read ", lba, pos_in_sector, bytes);
#endif
        if ( writemode )
        {
            if ( buffer )
            {
                memcpy( ( ( uint8_t * ) datacache ) + pos_in_sector, buffer, bytes );
            }
            else
            {
                memset( ( ( uint8_t * ) datacache ) + pos_in_sector, 0, bytes );
            }
            cache_setdirty( fatfs, lba, fcb->filemask );
        }
        else
        {
            memcpy( buffer, ( ( uint8_t * ) datacache ) + pos_in_sector, bytes );
        }

        if ( buffer )
        {
            buffer = ( uint8_t * ) buffer + bytes;
        }
        count -= bytes;
        bytes_processed += bytes;
        fcb->u.fat.pos += bytes;
        ++lba;
        pos_in_cluster = ( pos_in_cluster + bytes ) % clustersize;
        fcb->u.fat.pos_pastcluster = pos_in_cluster ? 0 : 1;
    }

    // 2. read data left in complete sectors in the current cluster
    uint32_t bytes_continuous = ( !lba || fcb->u.fat.pos_pastcluster ) ? 0 : ( clustersize - pos_in_cluster );

    // process compleet sectors in as little chunks as possible
    while ( count )
    {
        if ( count > bytes_continuous )
        {
            uint32_t nextcluster = CLUSTER_EOC;

            if ( fcb->u.fat.cluster )
            {
                nextcluster = cluster_readlink( fatfs, fcb->u.fat.pos_cluster );
                if ( fatfs->error )
                {
                    return 0;
                }
            }

            if ( writemode && cluster_is_eoc( fatfs, nextcluster ) )
            {
                nextcluster = cluster_allocate( fatfs, fcb->u.fat.pos_cluster, fcb->filemask );
                if ( fatfs->error )
                {
                    return 0;
                }
            }

            if ( !fcb->u.fat.cluster && !cluster_is_eoc( fatfs, nextcluster ) )
            {
                // allocated first cluster of file
                cluster_update = 1;

                fcb->u.fat.cluster = nextcluster;
                fcb->u.fat.pos_cluster = nextcluster;
                fcb->u.fat.pos_pastcluster = 0;
                bytes_continuous += clustersize;

                lba = cluster2lba( fatfs, nextcluster );
            }
            else if ( nextcluster == ++fcb->u.fat.pos_cluster )
            {
                // continuous cluster
                fcb->u.fat.pos_pastcluster = 0;
                bytes_continuous += clustersize;
            }
            else
            {
                // non-continuous or error, process all continuous complete sectors up to here
                if ( bytes_continuous )
                {
#if FATFS_DEBUG_READWRITE
debugprintf("%sthrough lba %i pos %i count %i\n", writemode ? "write " : "read ", lba, 0, bytes_continuous);
#endif
                    if ( writemode )
                    {
                        cache_writethrough( fatfs, buffer, lba, bytes_continuous / FATFS_SECTORSIZE,
                                            fcb->filemask );
                    }
                    else
                    {
                        cache_readthrough( fatfs, buffer, lba, bytes_continuous / FATFS_SECTORSIZE );
                    }
                    if ( fatfs->error )
                    {
                        return 0;
                    }
                }

                if ( !nextcluster || cluster_is_eoc( fatfs, nextcluster ) )
                {
                    // we did not make it to the next sector
                    fcb->u.fat.pos_pastcluster = 1;

                    if ( !bytes_processed )
                    {
                        // only report errors if there were any bytes processed
                        if ( !nextcluster || !writemode )
                        {
                            // serious error: chain broken or too short while reading
                            seterrno( EIO );
                        }
                        else
                        {
                            // no space while writing
                            seterrno( ENOSPC );
                        }
                    }
                    count = 0;
                    break;
                }

                if ( buffer )
                {
                    buffer = ( uint8_t * ) buffer + bytes_continuous;
                }
                count -= bytes_continuous;
                bytes_processed += bytes_continuous;
                fcb->u.fat.pos += bytes_continuous;

                fcb->u.fat.pos_cluster = nextcluster;
                fcb->u.fat.pos_pastcluster = 0;
                bytes_continuous = clustersize;

                lba = cluster2lba( fatfs, nextcluster );
            }
        }
        else
        {
            // process all continuous complete sectors up to here
            uint32_t sectors_continuous = count / FATFS_SECTORSIZE;

            if ( sectors_continuous )
            {
                bytes_continuous = sectors_continuous * FATFS_SECTORSIZE;

#if FATFS_DEBUG_READWRITE
debugprintf("%sthrough lba %i pos %i count %i\n", writemode ? "write " : "read ", lba, 0, sectors_continuous * FATFS_SECTORSIZE);
#endif
                if ( writemode )
                {
                    cache_writethrough( fatfs, buffer, lba, sectors_continuous, fcb->filemask );
                }
                else
                {
                    cache_readthrough( fatfs, buffer, lba, sectors_continuous );
                }
                if ( fatfs->error )
                {
                    return 0;
                }

                if ( buffer )
                {
                    buffer = ( uint8_t * ) buffer + bytes_continuous;
                }
                count -= bytes_continuous;
                bytes_processed += bytes_continuous;
                fcb->u.fat.pos += bytes_continuous;

                // fcb->u.fat.pos_cluster is already updated

                lba += sectors_continuous;
                pos_in_cluster = ( pos_in_cluster + bytes_continuous ) % clustersize;

                if ( count )
                {
                    // next cluster will be available if there are any more bytes to write
                    fcb->u.fat.pos_pastcluster = 0;
                }
                else
                {
                    fcb->u.fat.pos_pastcluster = pos_in_cluster ? 0 : 1;
                }
            }

            break;
        }
    }

    if ( count )
    {
        // get the sector into the cache
        datacache = cache_read( fatfs, lba, writemode ? fcb->filemask : 0 );
        if ( fatfs->error )
        {
            return 0;
        }

#if FATFS_DEBUG_READWRITE
debugprintf("%s lba %i pos %i count %i\n", writemode ? "write " : "read ", lba, 0, count);
#endif
        if ( writemode )
        {
            if ( buffer )
            {
                memcpy( datacache, buffer, count );
            }
            else
            {
                memset( datacache, 0, count );
            }
        }
        else
        {
            memcpy( buffer, datacache, count );
        }

        fcb->u.fat.pos += count;
        bytes_processed += count;
    }

    if ( writemode )
    {
        fat_direntry_t *direntry;

        direntry = dir_get_entry( fatfs, &fcb->u.fat.direntry_location );
        if ( fatfs->error )
        {
            return 0;
        }

        if ( cluster_update )
        {
            dir_set_cluster( direntry, fcb->u.fat.cluster );
        }
        if ( fcb->u.fat.pos > size )
        {
            dir_set_size( direntry, fcb->u.fat.pos );
        }
        dir_set_timestamp( direntry, DIR_TIMESTAMP_MODIFIED );
        dir_setdirty( fatfs, fcb, &fcb->u.fat.direntry_location );

        if ( fatfs->flags & FS_FLAG_SYNC )
        {
            fat_flush( fcb );
            if ( fatfs->error )
            {
                return 0;
            }
        }
    }

    if ( bytes_processed )
    {
        return bytes_processed;
    }
    else
    {
        return errno ? -1 : 0;
    }
}

int fat_read( fs_fcb_t * restrict fcb, void *buffer, uint32_t count )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    uint32_t cluster;
    uint32_t size;

    if ( fatfs == NULL || fatfs->error )
    {
        return 0;
    }

    // get actual startcluster & size for open file
    dir_get_actuals( fatfs, fcb, &cluster, &size );
    if ( fatfs->error )
    {
        return 0;
    }

    if ( cluster != fcb->u.fat.cluster )
    {
        // startcluster has changed
        fcb->u.fat.cluster = cluster;

        // cluster of our position is now invalid
        fcb->u.fat.pos_cluster = 0;
    }

    if ( fcb->u.fat.pos >= size )
    {
        // reading from beyond EOF
        return 0;
    }

    if ( count > ( size - fcb->u.fat.pos ) )
    {
        // reading past EOF: truncate to maximum number of bytes
        count = size - fcb->u.fat.pos;
    }

    return readwrite( fcb, buffer, size, count, 0 );
}

int fat_write( fs_fcb_t * restrict fcb, const void *buffer, uint32_t count )
{
    fatfs_t *fatfs = ( fatfs_t * ) fcb->fs;
    uint32_t cluster;
    uint32_t size;

    if ( fatfs == NULL || fatfs->error )
    {
        return 0;
    }

    // get actual startcluster & size for open file
    dir_get_actuals( fatfs, fcb, &cluster, &size );
    if ( fatfs->error )
    {
        return 0;
    }

    if ( cluster != fcb->u.fat.cluster )
    {
        // startcluster has changed
        fcb->u.fat.cluster = cluster;

        // cluster of our position is now invalid
        fcb->u.fat.pos_cluster = 0;
    }

    // O_APPEND: always write at the end of the file
    if (fcb->flags & O_APPEND)
    {
        fat_seek(fcb, 0, SEEK_END);
        if ( fatfs->error )
        {
            return 0;
        }
    }

    if ( fcb->u.fat.pos > size )
    {
        // writing from beyond EOF: fill up with zero-bytes first
        // (this is a rather inefficient approach, but this use is considered low-priority)
        uint32_t zerobytes = fcb->u.fat.pos - size;
        int result;

        fat_seek( fcb, size, SEEK_SET );
        if ( fatfs->error )
        {
            return 0;
        }

        result = readwrite( fcb, 0, size, zerobytes, 1 );
        if ( fatfs->error )
        {
            return 0;
        }

        if ( result != zerobytes )
        {
            return result;
        }
        size += zerobytes;
    }

    return readwrite( fcb, ( void * ) buffer, size, count, 1 );
}
