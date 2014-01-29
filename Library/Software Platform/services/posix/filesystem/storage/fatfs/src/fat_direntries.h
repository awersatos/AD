/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system directory entries.
|*
\******************************************************************************/

#ifndef _FAT_DIRENTRIES_H
#define _FAT_DIRENTRIES_H

#include <stdint.h>

#include <util_endian.h>

#include "fat.h"
#include "fat_layout.h"

#if FATFS_DEBUG
extern void dir_debug_dump( fatfs_t * restrict fatfs, uint32_t dirnode );
#endif

extern fat_direntry_t *dir_get_next_entry( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                           fat_direntry_location_t * direntry_location );

#if FATFS_USE_LFN
extern fat_direntry_t *dir_get_next_file( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                          fat_direntry_location_t * direntry_location,
                                          char *name, size_t size );
#else
extern fat_direntry_t *dir_get_next_file( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                          fat_direntry_location_t * direntry_location );
#endif

extern fat_direntry_t *dir_create_entry( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                         fatfs_dirent_t * dirent, fat_direntry_t * from_direntry );

extern fat_direntry_t *dir_get_entry( fatfs_t * restrict fatfs,
                                      fat_direntry_location_t * direntry_location );

extern void dir_set_timestamp( fat_direntry_t * direntry, uint8_t timestamp );

extern void dir_get_actuals( fatfs_t * restrict fatfs, fs_fcb_t * fcb, uint32_t *cluster, uint32_t *size );

extern void dir_remove_entry( fatfs_t * restrict fatfs, fs_fcb_t * fcb, uint32_t dirnode,
                              fat_direntry_location_t * direntry_location );

/*
 * inline helper functions
 */

// write the startcluster entry in the given direntory entry
static inline void dir_set_cluster( fat_direntry_t * direntry, uint32_t cluster )
{
    write_little16to16( direntry->cluster_high, ( cluster >> 16 ) & 0xFFFF );
    write_little16to16( direntry->cluster_low, cluster & 0xFFFF );
}

// write the filesize in the given direntory entry
static inline void dir_set_size( fat_direntry_t * direntry, uint32_t size )
{
    write_little32to32( direntry->filesize, size );
}

// mark as dirty the cached sector the given direntry_location is pointing to
static inline void dir_setdirty( fatfs_t * restrict fatfs, fs_fcb_t * fcb,
                                 fat_direntry_location_t * direntry_location )
{
#if FATFS_DEBUG
    ++fatfs->direntrywrite;
#endif
    cache_setdirty( fatfs, direntry_location->lba, fcb->filemask );
}

#endif /* _FAT_DIRENTRIES_H */
