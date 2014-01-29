/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        M25PX0 specific I/O interface.
|*
\*****************************************************************************/

#ifndef _DRV_M25PX0_H
#define _DRV_M25PX0_H

#ifdef  __cplusplus
extern "C" {
#endif

/** @file
 * Interface to SPI based M25PX0 serial flash memory device driver
 * The memory of this device is organized as:
 * - 1,048,576 bytes (8 bits each)
 * - 16 sectors (512 Kbits, 65536 bytes each)
 * - 4096 pages (256 bytes each).
 * Each page can be individually programmed (bits are programmed from 1 to 0).
 * The device is Sector or Bulk Erasable (bits are erased from 0 to 1) but not
 * Page Erasable.
 */

#include <stdint.h>
#include <stdbool.h>

/**
 * @name Error codes
 */

/** @{ */

#define M25PX0_ERR_OK           0       /**<  No error */
#define M25PX0_ERR_SPI          -1      /**<  Could not get control over SPI bus */
/** @} */

/**
 * @name M25PX0 Status information
 */

/** @{ */
#define M25PX0_STAT_WIP         0x01    /**<  Write in progress */
#define M25PX0_STAT_WEL         0x02    /**<  Write enable latch */
#define M25PX0_STAT_BP0         0x04    /**<  Block protect bit 0 */
#define M25PX0_STAT_BP1         0x08    /**<  Block protect bit 1 */
#define M25PX0_STAT_BP2         0x10    /**<  Block protect bit 2 */
#define M25PX0_STAT_SRWD        0x80    /**<  Status register write protect */
/** @} */

typedef struct drv_m25px0_s m25px0_t;

extern m25px0_t * m25px0_open( unsigned id );

extern int m25px0_status( m25px0_t * drv );
extern int m25px0_set_protection( m25px0_t * drv, uint8_t pattern );

extern int m25px0_bulk_erase( m25px0_t * drv );
extern int m25px0_sector_erase( m25px0_t * restrict drv, uint32_t address );

extern size_t m25px0_program_page( m25px0_t * restrict drv, uint32_t address, void * buffer, size_t buflen );
extern size_t m25px0_read( m25px0_t * restrict drv, uint32_t address, void * buffer, size_t buflen );

extern int m25px0_power_down( m25px0_t * restrict drv );
extern int m25px0_wake_up( m25px0_t * restrict drv );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_M25PX0_H */
