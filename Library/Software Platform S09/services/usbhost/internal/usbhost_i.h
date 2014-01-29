/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    USB Host service internal header
|*
\*****************************************************************************/

#ifndef _USBHOST_I_H
#define _USBHOST_I_H

#include <stdint.h>
#include <stdbool.h>

#include <usbhost.h>
#include <usbhost_cfg_instance.h>

#include <usbhost_core.h>

struct usbhost_s
{
    usbhost_device_t    *hub;
    usbhost_urb_t       hub_urb;
    uint8_t         hub_status;

    int drv_id;
    void *drv;

    uint32_t devicenum;

    void *(*open)(int id);
    int32_t (*reset)(void *drv);
    int32_t (*start)(void *drv);
    int32_t (*stop)(void *drv);
    int32_t (*shutdown)(void *drv);
    int32_t (*enqueue_urb)(void *drv, usbhost_urb_t *urb);
    int32_t (*dequeue_urb)(void *drv, usbhost_urb_t *urb, int32_t status);
    int32_t (*hubstatus)(void *drv, uint8_t *buf);
    int32_t (*hubcontrol)(void *drv, uint16_t typeReq, uint16_t wValue, uint16_t wIndex, uint8_t *buf, uint16_t wLength);
};

extern usbhost_t usbhost_table[USBHOST_INSTANCE_COUNT];

extern uint32_t usbhost_getnextdevicenum(usbhost_t * restrict usbhost);

#endif  // _USBHOST_I_H
