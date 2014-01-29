/*
 * USB handling
 */
/** @file
 * Driver functionality for USB devices
 */


#ifndef __DRV_CY7C68001_H
#define __DRV_CY7C68001_H         1

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef struct _usb_t usb_t;

/* USB setup packet */
typedef struct
{
    uint8_t             bmRequestType;
    uint8_t             bRequest;
    uint16_t            wValue;
    uint16_t            wIndex;
    uint16_t            wLength;
} usb_setup_t;

/* class request handler */
typedef bool (usb_class_request_handler_t)(usb_setup_t* setup, uint8_t* result, int* length, void *data);

/* defines the number of allowed request handlers */
#define USB_REQTYPE_MAX_TYPES               4

/* USB descriptor designators */
#define USB_DESC_DEVICE                     1
#define USB_DESC_CONFIGURATION              2
#define USB_DESC_STRING                     3
#define USB_DESC_INTERFACE                  4
#define USB_DESC_ENDPOINT                   5
#define USB_DESC_DEVICE_QUALIFIER           6
#define USB_DESC_OTHER_SPEED                7
#define USB_DESC_INTERFACE_POWER            8

/* access macros for setup data */
#define USB_SETUP_GET_ENDPOINT(x)           ((x)->wIndex & 0x7F)
#define USB_SETUP_GET_ADDRESS(x)            (((x)->wValue >> 8) & 0xFF)
#define USB_SETUP_GET_LENGTH(x)             ((x)->wLength)

#define USB_REQTYPE_GET_DIR(x)              (((x)->bmRequestType >> 7) & 0x01)
#define USB_REQTYPE_DIR_TO_DEVICE           0
#define USB_REQTYPE_DIR_TO_HOST             1

#define USB_REQTYPE_GET_TYPE(x)             (((x)->bmRequestType >> 5) & 0x03)
#define USB_REQTYPE_TYPE_STANDARD           0
#define USB_REQTYPE_TYPE_CLASS              1
#define USB_REQTYPE_TYPE_VENDOR             2
#define USB_REQTYPE_TYPE_RESERVED           3

#define USB_REQTYPE_GET_RECIP(x)            ((x)->bmRequestType & 0x1F)
#define USB_REQTYPE_RECIP_DEVICE            0
#define USB_REQTYPE_RECIP_INTERFACE         1
#define USB_REQTYPE_RECIP_ENDPOINT          2
#define USB_REQTYPE_RECIP_OTHER             3

#define USB_DSCTYPE_GET_TYPE(x)             (((x)->wValue >> 8) & 0xFF)
#define USB_DSCTYPE_GET_INDEX(x)            (((x)->wValue) & 0xFF)
#define USB_DSCTYPE_GET_LANGID(x)           ((x)->wIndex)
/* types are defined by USB_DESC_xxx */

#define USB_REQTYPE_GET_REQUEST(x)          ((x)->bRequest)
#define USB_REQ_GET_STATUS                  0x00
#define USB_REQ_CLEAR_FEATURE               0x01
#define USB_REQ_SET_FEATURE                 0x03
#define USB_REQ_SET_ADDRESS                 0x05
#define USB_REQ_GET_DESCRIPTOR              0x06
#define USB_REQ_SET_DESCRIPTOR              0x07
#define USB_REQ_GET_CONFIGURATION           0x08
#define USB_REQ_SET_CONFIGURATION           0x09
#define USB_REQ_GET_INTERFACE               0x0A
#define USB_REQ_SET_INTERFACE               0x0B
#define USB_REQ_SYNC_FRAME                  0x0C

/* MSD class requests */
#define USB_FEATURE_MSD_MAX_LUN             0xFE
#define USB_FEATURE_MSD_RESET               0xFF

/* USB settings */
#define USB_EP0_BUFFER_SIZE                 64
#define USB_EPx_BUFFER_SIZE                 512

#define USB_MSD_OUT_EP                      0x04
#define USB_MSD_IN_EP                       0x88

/* initialize USB */
extern  usb_t                   *usb_open(int id, uint8_t *descriptor, int descriptor_length);
extern  void                    usb_set_class_request_handler(usb_t *usb, usb_class_request_handler_t* func, void *data);
extern  void                    usb_set_packet_size(usb_t *usb, uint8_t endpoint, int packet_size);
extern  int                     usb_get_packet_size(usb_t *usb, uint8_t endpoint);

/* setup handling */
extern  int                     usb_read_setup(usb_t *usb);

/* USB request handling */
extern  void                    usb_handle_request(usb_t *usb);

/* read from endpoint */
extern  int                     usb_read_endpoint(usb_t *usb, uint8_t endpoint, uint8_t* buffer, int max_length);
extern  uint8_t                 usb_read_endpoint_byte(usb_t *usb, uint8_t endpoint);
extern  uint16_t                usb_read_endpoint_word(usb_t *usb, uint8_t endpoint);
extern  uint32_t                usb_read_endpoint_dword(usb_t *usb, uint8_t endpoint);

/* write to endpoint */
extern  int                     usb_write_endpoint(usb_t *usb, uint8_t endpoint, uint8_t* buffer, int length);
extern  void                    usb_write_endpoint_byte(usb_t *usb, uint8_t endpoint, uint8_t data);
extern  void                    usb_write_endpoint_word(usb_t *usb, uint8_t endpoint, uint16_t data);
extern  void                    usb_write_endpoint_dword(usb_t *usb, uint8_t endpoint, uint32_t data);

/* endpoint handling */
extern  bool                    usb_endpoint_is_valid(usb_t *usb, uint8_t endpoint);
extern  bool                    usb_endpoint_ready(usb_t *usb, uint8_t endpoint);
extern  void                    usb_enable_endpoint(usb_t *usb, uint8_t endpoint);
extern  void                    usb_disable_endpoint(usb_t *usb, uint8_t endpoint);
extern  bool                    usb_endpoint_is_enabled(usb_t *usb, uint8_t endpoint);
extern  void                    usb_stall_endpoint(usb_t *usb, uint8_t endpoint);
extern  void                    usb_unstall_endpoint(usb_t *usb, uint8_t endpoint);
extern  void                    usb_endpoint_pktend(usb_t *usb, uint8_t endpoint);

#ifdef  __cplusplus
}
#endif

#endif /* !defined(__DRV_CY7C68001_H) */

