/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        USB-Host Mass Storage Device (MSD) driver
|*                      direct (none cached) device access
|*
 *****************************************************************************/

#include <usbhost_msd.h>

#ifndef _DRV_USBHOST_MSD_DIRECT_H
#define _DRV_USBHOST_MSD_DIRECT_H

extern int usbhost_msd_read_direct(usbhost_msd_t * drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount);
extern int usbhost_msd_write_direct(usbhost_msd_t * drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount);
extern int usbhost_msd_clear_direct(usbhost_msd_t * drv, int sid, uint32_t lba, uint16_t blockcount);

#endif /* _DRV_USBHOST_MSD_DIRECT_H */

