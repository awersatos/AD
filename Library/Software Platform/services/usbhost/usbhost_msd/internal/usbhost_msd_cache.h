/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        USB-Host Mass Storage Device (MSD) driver
|*                      cached device access
|*
 *****************************************************************************/

#include <usbhost_msd.h>

#ifndef _DRV_USBHOST_MSD_CACHE_H
#define _DRV_USBHOST_MSD_CACHE_H

typedef struct _usbhost_msd_cache_t     usbhost_msd_cache_t;

extern int usbhost_msd_read_cache(usbhost_msd_t *drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount);
extern int usbhost_msd_write_cache(usbhost_msd_t *drv, int sid, const uint8_t *data, uint32_t lba, uint16_t blockcount);
extern int usbhost_msd_clear_cache(usbhost_msd_t *drv, int sid, uint32_t lba, uint16_t blockcount);
extern int usbhost_msd_flush_cache(usbhost_msd_t *drv, int sid);
extern usbhost_msd_cache_t *usbhost_msd_alloc_cache(uint32_t blksize);
extern void usbhost_msd_free_cache(usbhost_msd_cache_t *cache);

#endif /* _DRV_USBHOST_MSD_CACHE_H */

