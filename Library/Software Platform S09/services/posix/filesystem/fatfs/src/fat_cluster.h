/******************************************************************************
|*
|*  COPYRIGHT:      Copyright 2007 Altium BV
|*
|*  DESCRIPTION:    FAT file system clusters.
|*
\******************************************************************************/

#ifndef _FAT_CLUSTER_H
#define _FAT_CLUSTER_H

#include <stdint.h>
#include "fat.h"

extern uint8_t cluster_is_eoc( fatfs_t * restrict fatfs, uint32_t cluster );

extern uint32_t cluster_readlink( fatfs_t * restrict fatfs, uint32_t cluster );

extern uint32_t cluster_allocate( fatfs_t * restrict fatfs, uint32_t cluster, uint32_t filemask );

extern void cluster_freechain( fatfs_t * restrict fatfs, uint32_t cluster, uint32_t filemask );

/*
 * inline helper functions
 */

// convert given clusternumber to lba
static inline uint32_t cluster2lba( fatfs_t * restrict fatfs, uint32_t cluster )
{
    return fatfs->data_lba + ( cluster - 2 ) * fatfs->sectors_per_cluster;
}

#endif /* _FAT_CLUSTER_H */
