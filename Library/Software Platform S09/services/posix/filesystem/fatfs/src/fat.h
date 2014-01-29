/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system implementation. Supports FAT12, FAT16 and
|*                  FAT32.
|*
\******************************************************************************/

#ifndef _FAT_H
#define _FAT_H

#include <errno.h>
#include <stdint.h>
#include <io.h>

#if FATFS_DEBUG
#include <stdio.h>
#define debugprintf printf
#else
#define debugprintf(...)
#endif

#include "fatfs.h"

//.............................................................................
// Readability defines

// cluster markers
#define CLUSTER_EOC                             0x0FFFFFFF
#define FAT32_CLUSTER_BAD                       0x0FFFFFF7
#define FAT32_CLUSTER_MASK                      0x0FFFFFFF      // should be mask all FAT32 cluster actions
#define FAT16_CLUSTER_BAD                       0x0000FFF7
#define FAT12_CLUSTER_BAD                       0x00000FF7

// boot sector stuff
#define FAT16_CLEANSHUTDOWN                     0x8000
#define FAT16_HARDERROR                         0x4000

#define FAT32_CLEANSHUTDOWN                     0x08000000
#define FAT32_HARDERROR                         0x04000000

#define FAT_MEDIA_FIXED                         0xF8
#define FAT_MEDIA_REMOVABLE                     0xF0

#define FAT_EXTENDED_BOOT_SIGNATURE             0x29

#define FAT_SIGNATURE                           0xAA55
#define FAT_SIGNATURE_OFFSET                    510

#define BOOTSTRAP_0                             0xEB
#define BOOTSTRAP_1                             0x00
#define BOOTSTRAP_2                             0x90

#define FAT32_FSINFO_LEAD_SIGNATURE             0x41615252
#define FAT32_FSINFO_STRUCT_SIGNATURE           0x61417272
#define FAT32_FSINFO_TRAIL_SIGNATURE            0x0000AA55

#define FAT32_VERSION                           0

// timestamps
#define DIR_TIMESTAMP_CREATED                   0x01
#define DIR_TIMESTAMP_MODIFIED                  0x02

//.............................................................................
// FAT fs implementation

#if (FS_OPENFILES > 32)
#error FS_OPENFILES > 32 is not supported yet in the FAT cache
#endif
#if (FS_OPENFILES > 255)
#error FS_OPENFILES > 255 is not supported by the FAT filesystems
#endif

#define FS_ERROR_FAT_IO                         -1
#define FS_ERROR_FAT_UNKNOWN_TYPE               -2
#define FS_ERROR_FAT_BLOCKSIZE_UNSUPPORTED      -3
#define FS_ERROR_FAT32_UNSUPPORTED_VERSION      -4
#define FS_ERROR_FAT_SIGNATURE                  -5
#define FS_ERROR_FAT_ILLEGALTYPE                -6
#define FS_ERROR_FAT_CORRUPT                    1
#define FS_ERROR_FAT_HARDERROR                  2
#define FS_ERROR_FAT_CLEANSHUTDOWN              3

#define FATFS_NAME0_FREE                       0xE5

#define FATFS_ATTRIBUTE_RO                     0x01
#define FATFS_ATTRIBUTE_HIDDEN                 0x02
#define FATFS_ATTRIBUTE_SYSTEM                 0x04
#define FATFS_ATTRIBUTE_VOLUME                 0x08
#define FATFS_ATTRIBUTE_SUBDIR                 0x10
#define FATFS_ATTRIBUTE_ARCHIVE                0x20
#define FATFS_ATTRIBUTE_LFN                    0x0F

//.............................................................................
// helper functions

static inline void seterrno( int new_errno )
{
    if ( !errno )
    {
        errno = new_errno;
    }
}

// set internal cursors of fcb to position 0 at given node
// (node==0 indicating empty chain)
static inline void fat_fcb_pos_at_node( fatfs_t * restrict fatfs, fs_fcb_t * fcb, uint32_t node )
{
    fcb->u.fat.cluster = node;
    fcb->u.fat.pos = 0;
    fcb->u.fat.pos_cluster = node;
    fcb->u.fat.pos_pastcluster = node ? 0 : 1;
}

//.............................................................................
// private fat interface

extern int fat_mkfs( fatfs_t * restrict fatfs, uint8_t type, uint8_t sectors_per_cluster,
                     uint8_t removable, const char *label, fatfs_cache_t * cache );

extern int fat_open_filesystem( fatfs_t * restrict fatfs, uint16_t flags, fatfs_cache_t * cache,
                                int cache_count );

extern int fat_flush_all( fatfs_t * restrict fatfs, int invalidate );

extern int fat_flush( fs_fcb_t * restrict fcb );
extern int fat_open( fs_fcb_t * restrict fcb, const fatfs_dirent_t * restrict dirent );
extern int fat_create( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent );
extern int fat_close( fs_fcb_t * restrict fcb );
extern int fat_remove( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent );
extern int fat_rename( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent, uint32_t newdirnode, const char *newname );
extern int fat_seek( fs_fcb_t * restrict fcb, uint32_t offset, _whence_t whence );
extern int fat_read( fs_fcb_t * restrict fcb, void *buffer, uint32_t count );
extern int fat_write( fs_fcb_t * restrict fcb, const void *buffer, uint32_t count );
extern int fat_mkdir( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent );
extern int fat_diropen( fs_fcb_t * restrict fcb, uint32_t node );
extern int fat_dirread( fs_fcb_t * restrict fcb, fatfs_dirent_t * dirent, const char *wildcard, uint32_t node );

#endif /* _FAT_H */
