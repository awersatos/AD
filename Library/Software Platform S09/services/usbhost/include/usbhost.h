/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        USB-Host driver
|*
 *****************************************************************************/

/**
 * @file
 * USB-Host service
 */

#ifndef _USBHOST_H
#define _USBHOST_H

#include <usbhost_core.h>

extern void usbhost_init(usbhost_t * restrict usbhost);

extern usbhost_registereddriver_t *usbhost_registerdevicedriver(usbhost_t * restrict usbhost, void *devicedrv,
                                                                bool (*connect_test)(void *devicedrv, usbhost_device_t *usbdevice),
                                                                void (*disconnect)(void *devicedrv, usbhost_device_t *usbdevice));

extern void usbhost_process(usbhost_t * restrict usbhost);

extern void usbhost_initurb(usbhost_urb_t *urb);
extern int32_t usbhost_enqueueurb(usbhost_urb_t *urb);
extern int32_t usbhost_dequeueurb(usbhost_urb_t *urb);
//extern int32_t usbhost_completeurb(usbhost_urb_t *urb);

extern usbhost_t *usbhost_open(int id);


#endif /* _USBHOST_H */

