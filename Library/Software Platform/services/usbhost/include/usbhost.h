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

#ifdef  __cplusplus
extern "C" {
#endif

#include <usbhost_core.h>

#define USBHOST_URB_NOTIFY_TBD      0
#define USBHOST_URB_NOTIFY_COND     1
#define USBHOST_URB_NOTIFY_POLL     2

extern void usbhost_init(usbhost_t * restrict usbhost);

extern usbhost_registereddriver_t *usbhost_registerdevicedriver(usbhost_t * restrict usbhost, void *devicedrv,
                                                                bool (*connect_test)(void *devicedrv, usbhost_device_t *usbdevice),
                                                                void (*disconnect)(void *devicedrv, usbhost_device_t *usbdevice));
extern usbhost_t       *usbhost_open(int id);
extern void             usbhost_daemon(void);
extern void             usbhost_process(usbhost_t * restrict usbhost);
extern void             usbhost_freeurb(usbhost_urb_t **urb);
extern void             usbhost_initurb(usbhost_urb_t *urb, int notify);
extern int32_t          usbhost_enqueueurb(usbhost_urb_t *urb);
extern int32_t          usbhost_dequeueurb(usbhost_urb_t *urb);
extern int32_t          usbhost_abort_endpoint(usbhost_host_endpoint_t *ep);
extern uint32_t         usbhost_get_interrupt(usbhost_t * restrict usbhost);
extern usbhost_urb_t   *usbhost_allocurb(int iso_packets);

#ifdef  __cplusplus
}
#endif

#endif /* _USBHOST_H */

