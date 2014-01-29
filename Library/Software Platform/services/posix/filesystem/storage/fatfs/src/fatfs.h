/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Generic (POSIX-compatible) file system interface for FAT.
|*
\******************************************************************************/

#ifndef _FSFAT_H
#define _FSFAT_H

#include <stdint.h>
#include <sysutils.h>
#include <fsio.h>
#include <blockio.h>

#include "fatfs_cfg.h"
#include "posix_filesystem_cfg.h"

// determine cache element size from posix filesystem instances
#if POSIX_FILESYSTEM_INSTANCE_COUNT > 0
# include "posix_filesystem_cfg_instance.h"
# define FATFS_CACHE_BLOCKSIZE          POSIX_FILESYSTEM_INSTANCE_CACHE_BLOCKSIZE_MAX
#else
# define FATFS_CACHE_BLOCKSIZE          512
#endif

// sector size: if 512 is specified as maximum cache size (most of the cases) we use a constant for a nice speedup
#if (FATFS_CACHE_BLOCKSIZE == 512)
#define FATFS_SECTORSIZE  512
#else
#define FATFS_SECTORSIZE  fatfs->sectorsize
#endif

#if ( FATFS_USE_MUTEX != 0 )
#include <pthread.h>
#endif

#define FATFS                           1

// (mount) flags for open_filesystem()
#define FS_FLAG_RDONLY                  MOUNT_FLAG_RDONLY       /* Open the filesystem in read only mode (see fatfs_open_filesystem()) */
#define FS_FLAG_SYNC                    MOUNT_FLAG_SYNC         /* Flush cached data to disk after every write (see fatfs_open_filesystem()) */

// partition types for mkfs()
#define FS_PARTITIONTYPE_AUTO           0       /* Choose optimum partition type automatically (see fatfs_mkfs()) */
#define FS_PARTITIONTYPE_FAT12          0x01    /* FAT12 partition (see fatfs_mkfs()) */
#define FS_PARTITIONTYPE_FAT16          0x06    /* FAT16 partition (see fatfs_mkfs()) */
#define FS_PARTITIONTYPE_FAT32          0x0B    /* FAT32 partition (see fatfs_mkfs()) */

// directory entry attributes
#define FS_ATTRIBUTE_RO                 0x01    /* Read-only file or directory (see fatfs_direntry_get_attributes()) */
#define FS_ATTRIBUTE_HIDDEN             0x02    /* Hidden file or directory (see fatfs_direntry_get_attributes()) */
#define FS_ATTRIBUTE_SYSTEM             0x04    /* System file or directory (see fatfs_direntry_get_attributes()) */
#define FS_ATTRIBUTE_VOLUME             0x08    /* Volume label (see fatfs_direntry_get_attributes()) */
#define FS_ATTRIBUTE_SUBDIR             0x10    /* Subdirectory (see fatfs_direntry_get_attributes()) */
#define FS_ATTRIBUTE_ARCHIVE            0x20    /* Archive file or directory (see fatfs_direntry_get_attributes()) */
#define FS_ATTRIBUTE_LFN                0x0F    /* Long filename used for file or directory (see fatfs_direntry_get_attributes()) */

// file systems
#ifndef FATFS_MOUNT_MAX
#define FATFS_MOUNT_MAX                 4
#endif

// mount flag
#define FS_FLAG_MOUNTED                 0x8000

// supported partition types
#define FS_PARTITIONTYPE_FAT16LESS32M   0x04    /* Small FAT16 partition (< 32MB) (see fatfs_mkkfs()) */
#define FS_PARTITIONTYPE_FAT16WIN95     0x0E    /* FAT16 partition, Win95 variant (see fatfs_mkkfs()) */
#define FS_PARTITIONTYPE_FAT32LBA       0x0C    /* FAT32 partition with LBA addressing (see fatfs_mkkfs()) */

#define FAT12                           FS_PARTITIONTYPE_FAT12
#define FAT16                           FS_PARTITIONTYPE_FAT16
#define FAT32                           FS_PARTITIONTYPE_FAT32

// cache
#ifndef FATFS_CACHE_HASH
#define FATFS_CACHE_HASH                32
#endif

// mutex handling
#if ( FATFS_USE_MUTEX != 0 )
# define FATFS_MUTEX_PREPARE()          POSIX_DEV_MUTEX_PREPARE( fatfs_mutex_buffer )
# define FATFS_MUTEX_LOCK( fatfs )      POSIX_DEV_MUTEX_LOCK( &fatfs->mutex, fatfs_mutex_buffer )
# define FATFS_MUTEX_UNLOCK( fatfs )    POSIX_DEV_MUTEX_UNLOCK( &fatfs->mutex, fatfs_mutex_buffer )
#else
# define FATFS_MUTEX_PREPARE()          do {} while (0)
# define FATFS_MUTEX_LOCK( fatfs )      do {} while (0)
# define FATFS_MUTEX_UNLOCK( fatfs )    do {} while (0)
#endif

//.............................................................................
// type definitions

typedef struct fatfs_s fatfs_t;
typedef struct fatfs_dirent_s fatfs_dirent_t;
typedef struct fat_direntry_location_s fat_direntry_location_t;
typedef struct fs_dirent_fat_s fs_dirent_fat_t;
typedef struct fs_fcb_fat_s fs_fcb_fat_t;
typedef struct fs_fcb_s fs_fcb_t;
typedef struct fatfs_cache_s fatfs_cache_t;

//.............................................................................
// directory data

// info to quickly find FAT directory data
struct fat_direntry_location_s
{
#if FATFS_USE_LFN
    uint32_t lfn_lba;           // lba of first direntry belonging to the LFN
    uint16_t lfn_pos_in_sector; // position in sector for same
#endif
    uint32_t lba;               // lba of direntry describing this file
    uint16_t pos_in_sector;     // position in sector for same
};

// FAT specific part of directory entry structure
struct fs_dirent_fat_s
{
    fat_direntry_location_t direntry_location;       // position on device where entry is located
#if FATFS_USE_LFN
    char shortname[13];         // 8.3 mangled filename
#endif
};

// dirent->d_name[NAME_MAX+1]
#if ( NAME_MAX < 11 )
#error NAME_MAX must be at least 11
#endif

// directory data describing a file
struct fatfs_dirent_s
{
    struct dirent dirent;           // fatfs_dirent_t can be cast to a regular struct dirent
    fatfs_t *fs;
    fatfs_dirent_t *dirent_next;
    uint32_t dirnode;
    uint32_t node;
    uint32_t size;
    uint8_t attributes;
    union
    {
#ifdef FATFS
        fs_dirent_fat_t fat;
#endif
    } u;
};

//.............................................................................
// open file (or directory) data

// FAT specific part of (open) file structure
struct fs_fcb_fat_s
{
    uint32_t cluster;           // starting node, 0 = none
    uint32_t pos;               // cursor position in file
    uint32_t pos_cluster;       // node where cursor is, 0 = unknown
    fat_direntry_location_t direntry_location;       // info where to find direntry
    uint8_t pos_pastcluster;    // if <>0 then pos is 1 byte beyond pos_cluster
};

// structure describing an open file
struct fs_fcb_s
{
    fatfs_t *fs;
    fs_fcb_t *fcb_prev;
    fs_fcb_t *fcb_next;
    uint32_t filemask;          // filenr as a bit in a field, used for masking dirty cache etc.
    unsigned int flags;
    union
    {
#ifdef FATFS
        fs_fcb_fat_t fat;
#endif
    } u;
    uint32_t size;              // copy of direntry size
    uint8_t attributes;         // copy of direntry attributes
    fatfs_dirent_t *dirent;     // for directories, reused for every call to readdir
};

//.............................................................................
// disk cache

// disk cache element for FAT filesystem
struct fatfs_cache_s
{
    uint32_t data[FATFS_CACHE_BLOCKSIZE / sizeof( uint32_t )];      // one sector of cached data
    uint32_t lba;               // lba of cached data
    fatfs_cache_t *mru_next;   // link to LRU end of chain
    fatfs_cache_t *mru_prev;   // backlink to MRU end of chain
    fatfs_cache_t *hash_next;  // link to next cache with same hash
    uint32_t dirtymask;         // bitmapped dirty markers for each open file
};

//.............................................................................
// file system data

// FAT specific filesystem structure
struct fatfs_s
{
    fs_fcb_t *fcblist;
    uint16_t flags;
    uint32_t rootdir_node;
    uint32_t curdir_node;
    int blk_id;
    int error;                          // error code for last operation
    uint32_t sectorsize;                // sectorsize = blocksize underlying device
    uint32_t max_cluster;               // available clusters in partition
    uint32_t rootdir_cluster;           // cluster number of root dir
    uint32_t fat_lba;                   // lba of filesystem (first block of the partition)
    uint32_t rootdir_lba;               // lba of root dir
    uint32_t data_lba;                  // lba of data section
    uint32_t curdir_cluster;            // cluster number of current dir entry
    uint32_t lastallocated_cluster;     // last newly allocated cluster
    uint32_t sectors_per_fat;           // sectors used by 1 FAT
    fatfs_cache_t *cache_mru;          // pointer to cache buffer
    fatfs_cache_t *cache_lru;          // ??
    fatfs_cache_t *cache_hash[FATFS_CACHE_HASH]; // disk cache hash table
    uint8_t sectors_per_cluster;        // number of sectors in each filesystem cluster
    uint8_t type;                       // FAT type
    uint8_t number_of_fats;             // number of FATs (2)
    uint8_t filecount_open;             // open file count
    uint8_t filecount_writable;         // writable open file count (for clean shutdown)
#if FATFS_DEBUG
    uint32_t hits;
    uint32_t misses;
    uint32_t direntrywrite;
    uint32_t direntryread;
#endif

    /* SwPlatform additions */
    fatfs_cache_t cache[FATFS_CACHE_ELEM]; // static disk cache buffer
    const char *block_device;           // name of the block device
    int partition_nr;                   // partition number, or 0 for entire disk
    posix_devctl_blockio_impl_t blkdrv; // block driver implementation
#if ( FATFS_USE_MUTEX != 0 )
    pthread_mutex_t mutex;              // thread safe locking
#endif
};

#endif /* _FSFAT_H */
