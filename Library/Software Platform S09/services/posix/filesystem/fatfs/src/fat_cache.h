/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system cache.
|*
\******************************************************************************/

#ifndef _FAT_CACHE_H
#define _FAT_CACHE_H

#include <stdint.h>

#include "fat.h"

extern void cache_write( fatfs_t * restrict fatfs, fatfs_cache_t * cache );

extern uint32_t *cache_read( fatfs_t * restrict fatfs, int lba, uint32_t filemask );

extern uint32_t *cache_blank( fatfs_t * restrict fatfs, int lba, uint32_t filemask );

extern void cache_setdirty( fatfs_t * restrict fatfs, int lba, uint32_t filemask );

extern void cache_readthrough( fatfs_t * restrict fatfs, void *buffer, uint32_t lba, uint32_t sectorcount );

extern void cache_writethrough( fatfs_t * restrict fatfs, void *buffer, uint32_t lba, uint32_t sectorcount,
                                uint32_t filemask );

extern void cache_flush( fatfs_t * restrict fatfs, uint32_t filemask, int invalidate );

extern void cache_init( fatfs_t * restrict fatfs, int cache_count );

#endif /* _FAT_CACHE_H */
