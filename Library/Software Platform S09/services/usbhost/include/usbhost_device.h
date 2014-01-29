/*
 * UsbDevice.h
 */

#ifndef _USB_DEVICE_H
#define _USB_DEVICE_H

#include <usbhost_core.h>

/*
 * USB Base Classes
 */
#define USBHOST_BC_DEVICE                           0x00
#define USBHOST_BC_AUDIO                            0x01
#define USBHOST_BC_COMMUNICATIONS_AND_CDC_CONTROL   0x02
#define USBHOST_BC_HUMAN_INTERFACE_DEVICE           0x03
#define USBHOST_BC_HID                              0x03
#define USBHOST_BC_PHYSICAL                         0x05
#define USBHOST_BC_STILL_IMAGING                    0x06
#define USBHOST_BC_PRINTER                          0x07
#define USBHOST_BC_MASS_STORAGE                     0x08
#define USBHOST_BC_HUB                              0x09
#define USBHOST_BC_CDC_DATA                         0x0A
#define USBHOST_BC_SMART_CARD                       0x0B
#define USBHOST_BC_CONTENT_SECURITY                 0x0D
#define USBHOST_BC_VIDEO                            0x0E
#define USBHOST_BC_PERSONAL_HEALTHCARE              0x0F
#define USBHOST_BC_DIAGNOSTIC_DEVICE                0xDC
#define USBHOST_BC_WIRELESS_CONTROLLER              0xE0
#define USBHOST_BC_MISCELLANEOUS                    0xEF
#define USBHOST_BC_APPLICATION_SPECIFIC             0xFE
#define USBHOST_BC_VENDOR_SPECIFIC                  0xFF

extern void usbhost_buildcontrolendpoint(usbhost_host_endpoint_t *ep, uint8_t direction);
extern usbhost_interface_t *usbhost_getfunctioninterface(uint32_t idx, usbhost_device_t *dev);

extern usbhost_device_t *usbhost_devicealloc(usbhost_t * restrict drv, usbhost_devicespeed_t devspeed);
extern void usbhost_devicefree(usbhost_device_t *dev);
extern usbhost_host_endpoint_t *usbhost_endpointalloc(uint32_t count);
extern void usbhost_endpointfree(usbhost_host_endpoint_t *ep);
extern void usbhost_endpointinit(usbhost_endpointdescriptor_t *epdesc, uint32_t enabled, usbhost_host_endpoint_t *ep);

extern usbhost_interface_t *usbhost_interfacealloc(uint32_t count);
extern void usbhost_interfacefree(usbhost_interface_t *intf);
extern void usbhost_interfaceinit(usbhost_device_t *dev, usbhost_host_interface_t *curintf, uint32_t altcount, usbhost_host_interface_t *altintf,  usbhost_interface_t *intf);

extern usbhost_host_interface_t *usbhost_hostinterfacealloc(uint32_t count);
extern void usbhost_hostinterfacefree(usbhost_host_interface_t *intf);
extern void usbhost_hostinterfaceinit(usbhost_interfacedescriptor_t *intfdesc, usbhost_host_endpoint_t *eparray, usbhost_host_interface_t *intf);

/*
// ERIK TODO: rename to usbhost_ style
extern char *base_class_to_string(int base_class);
extern int device_get_type(usbhost_device_t *dev);
extern int device_get_num_interfaces(usbhost_device_t *dev);
extern usbhost_interface_t *device_get_interface(usbhost_device_t *dev, int interface);
extern int interface_get_type(usbhost_interface_t *interface);

extern int device_get_manufacturer_id(usbhost_device_t *dev);
extern int device_get_product_id(usbhost_device_t *dev);
extern int device_get_serial_number_id(usbhost_device_t *dev);
*/

#endif /* _USB_DEVICE_H */

