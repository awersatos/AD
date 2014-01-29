/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        USB-Host Mass Storage Device (MSD) driver
|*
 *****************************************************************************/

/**
 * @file
 *      Driver for USB-Host MSD
 */

#ifndef _DRV_USBHOST_MSD_H
#define _DRV_USBHOST_MSD_H

#include <stdint.h>
#include <stdbool.h>

#ifdef  __cplusplus
extern "C" {
#endif

typedef struct usbhost_msd_s usbhost_msd_t;

/**
 * @brief
 *      Mass Storage Device Information
 *
 * This structure describes the number of blocks on the device and the size
 * of the blocks.
 */
typedef struct
{
    uint32_t    blksize;        /**< Size of a block */
    uint64_t    blkcount;       /**< Number of blocks on the device */
} usbhost_msd_info_t;

/**
 * @brief
 *      Callback routine
 *
 * @param   drv     service pointer as returned from usbhost_msd_open()
 * @param   sid     id for use in calls to read, write and clear
 * @param   on      true when device was inserted
 *                  false when device was removed
 * @param   data    data as passed to usbhost_msd_add_callback routine
 */
typedef void (*usbhost_msd_callback_proc)(usbhost_msd_t *drv, int sid, bool on, void *data);

extern usbhost_msd_t *usbhost_msd_open(int id);

extern usbhost_msd_info_t *usbhost_msd_get_info(usbhost_msd_t *dev, int sid);
extern int usbhost_msd_read_blocks( usbhost_msd_t * dev, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount );
extern int usbhost_msd_write_blocks( usbhost_msd_t * drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount );
extern int usbhost_msd_clear_blocks( usbhost_msd_t * dev, int sid, uint32_t lba, uint16_t blockcount );
extern int usbhost_msd_flush_blocks( usbhost_msd_t * drv, int sid );
extern int usbhost_msd_add_callback( usbhost_msd_t * drv, usbhost_msd_callback_proc callback, void *user_data);
extern int usbhost_msd_remove_callback( usbhost_msd_t * drv, usbhost_msd_callback_proc callback, void *user_data);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_USBHOST_MSD_H */
