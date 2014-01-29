/*
 * usbhost_hub.h
 */

#ifndef _USBHOST_HUB_H
#define _USBHOST_HUB_H

#include <usbhost_core.h>

#define USBHOST_HUB_PORT_CONNECTED 0x0001
#define USBHOST_HUB_PORT_ENABLE    0x0002

extern int32_t usbhost_hub_enumeratedevice(usbhost_device_t *dev, usbhost_device_t *hub, uint8_t port);
extern int32_t usbhost_hub_getnextportchange(uint32_t *hubStatus);
extern usbhost_devicespeed_t usbhost_hub_getportspeed(uint32_t portStatus);

#endif /* _USBHOST_HUB_H */

