/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        SD card driver
|*
\*****************************************************************************/

#ifndef _DRV_SDCARD_H
#define _DRV_SDCARD_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/*
 * sdcard_device_init response codes
 */
#define SD_ERR_OK                0
#define SD_ERR_COMM             -1
#define SD_ERR_INIT             -2
#define SD_ERR_UNSUPPORTED      -3

/**
 * @brief
 *      SD card disk layout
 *
 * This data structure holds information about the disk layout of an SD card.
 */
typedef struct
{
    unsigned int blksize;       /**< Size of a sector */
    unsigned int blkcount;      /**< Number of sectors on the device */
} sdcard_info_t;

typedef struct sdcard_s sdcard_t;

extern sdcard_t *sdcard_open( unsigned int id );

extern const sdcard_info_t *sdcard_get_info( sdcard_t * restrict sdcard );

extern int sdcard_read_sectors( sdcard_t * restrict sdcard, uint8_t *data, unsigned int lba,
                                unsigned int sectorcount );

extern int sdcard_write_sectors( sdcard_t * restrict sdcard, const uint8_t *data, unsigned int lba,
                                 unsigned int sectorcount );

extern int sdcard_clear_sectors( sdcard_t * restrict sdcard, unsigned int lba, unsigned int sectorcount );

extern int sdcard_device_init( sdcard_t * restrict sdcard );

extern bool sdcard_protected( sdcard_t * restrict sdcard );
extern bool sdcard_detect( sdcard_t * restrict sdcard );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_SDCARD_H */
