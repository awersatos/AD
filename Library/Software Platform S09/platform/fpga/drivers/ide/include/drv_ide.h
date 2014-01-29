/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    IDE driver
|*
\*****************************************************************************/

#ifndef _DRV_IDE_H
#define _DRV_IDE_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/**
 * @brief
 *      IDE device disk layout
 *
 * This data structure holds information about the disk layout of an IDE
 * device.
 */
typedef struct
{
    unsigned int blksize;       /**< Size of a sector */
    unsigned int blkcount;      /**< Number of sectors on the device */
} ide_info_t;

typedef struct ide_s ide_t;

extern ide_t *ide_open( int id );

extern bool ide_detect( ide_t * restrict ide );

extern void ide_hardreset( ide_t *restrict ide );

extern void ide_powerdown( ide_t * restrict ide, bool off );

extern int ide_open_device( ide_t * restrict ide );

extern const ide_info_t *ide_get_info( ide_t * restrict ide );

extern void ide_softreset( ide_t * restrict ide );

extern void ide_set_dma_range( ide_t * restrict ide, uintptr_t dma_from, uintptr_t dma_to );

extern int ide_read_sectors( ide_t * restrict ide, uint8_t *data, unsigned int lba,
                             unsigned int sectorcount );

extern int ide_write_sectors( ide_t * restrict ide, const uint8_t *data, unsigned int lba, 
                              unsigned int sectorcount );

extern int ide_clear_sectors( ide_t * restrict ide, unsigned int lba, unsigned int sectorcount );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_IDE_H */
