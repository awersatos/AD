/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Block I/O interface for an S29 paralel flash device
|*
\*****************************************************************************/

#ifndef _DRV_S29_BLOCKIO_H
#define _DRV_S29_BLOCKIO_H

#include <stdint.h>
#include <stdbool.h>

#ifdef  __cplusplus
extern "C" {
#endif

/**
 * @brief
 *      S29 device sector layout
 *
 * This data structure holds information about the sector layout of an S29
 * paralel flash device.
 */
typedef struct
{
    unsigned int blksize;       /**< Size of a sector */
    unsigned int blkcount;      /**< Number of sectors on the device */
} s29_blockio_info_t;

typedef struct s29_blockio_s s29_blockio_t;

extern s29_blockio_t *s29_blockio_open( int id );

extern const s29_blockio_info_t *s29_blockio_get_info( s29_blockio_t * restrict s29_blockio );

extern int s29_blockio_read_sectors( s29_blockio_t * restrict s29_blockio, uint8_t *data, unsigned int lba,
                                     unsigned int sectorcount );

extern int s29_blockio_write_sectors( s29_blockio_t * restrict s29_blockio, const uint8_t *data,
                                      unsigned int lba, unsigned int sectorcount );

extern int s29_blockio_clear_sectors( s29_blockio_t * restrict s29_blockio, unsigned int lba,
                                      unsigned int sectorcount );

extern int s29_blockio_flush( s29_blockio_t * restrict s29_blockio );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_S29_BLOCKIO_H */
