/*
 * usbhost_hub.h
 */

#ifndef _USBHOST_HUB_H
#define _USBHOST_HUB_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <usbhost_core.h>

extern int32_t usbhost_hub_enumeratedevice(usbhost_device_t *dev, usbhost_device_t *hub, uint8_t port);
extern int32_t usbhost_hub_getnextportchange(uint32_t *hubStatus);
extern usbhost_devicespeed_t usbhost_hub_getportspeed(uint32_t portStatus);

#ifdef  __cplusplus
}
#endif

#endif /* _USBHOST_HUB_H */
