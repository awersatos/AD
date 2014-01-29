// usbhost_framework.h

#ifndef __USBHOST_FRAMEWORK_H
#define __USBHOST_FRAMEWORK_H

#include <stdint.h>

#ifdef  __cplusplus
extern "C" {
#endif

#define USBHOST_EPXFERTYPE_CONTROL     0x00
#define USBHOST_EPXFERTYPE_ISO         0x01
#define USBHOST_EPXFERTYPE_BULK        0x02
#define USBHOST_EPXFERTYPE_INT         0x03

#define USBHOST_EPXFERDIR_OUT          0x00
#define USBHOST_EPXFERDIR_IN           0x80

#define USBHOST_EPXFERNUMBER(_bEndpointAddress)   (_bEndpointAddress & 0x0F)
#define USBHOST_EPXFERDIR(_bEndpointAddress)      (_bEndpointAddress & USBHOST_EPXFERDIR_IN)
#define USBHOST_EPXFERTYPE(_bmAttributes)         (_bmAttributes & 0x3)

#define USBHOST_ISOUTEP(_bEndpointAddress)          (USBHOST_EPXFERDIR(_bEndpointAddress) == USBHOST_EPXFERDIR_OUT)
#define USBHOST_ISINEP(_bEndpointAddress)           (USBHOST_EPXFERDIR(_bEndpointAddress) == USBHOST_EPXFERDIR_IN)

#define USBHOST_ISCONTROLEP(_bmAttributes) (USBHOST_EPXFERTYPE(_bmAttributes) == USBHOST_EPXFERTYPE_CONTROL )
#define USBHOST_ISISOEP(_bmAttributes)     (USBHOST_EPXFERTYPE(_bmAttributes) == USBHOST_EPXFERTYPE_ISO     )
#define USBHOST_ISBULKEP(_bmAttributes)    (USBHOST_EPXFERTYPE(_bmAttributes) == USBHOST_EPXFERTYPE_BULK    )
#define USBHOST_ISINTEP(_bmAttributes)     (USBHOST_EPXFERTYPE(_bmAttributes) == USBHOST_EPXFERTYPE_INT     )

// normal descriptor header
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
} usbhost_descriptorheader_t;

// class specific descriptor header
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;
    uint8_t     bDescriptorSubtype;
} usbhost_csdescriptorheader_t;


typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;

    uint16_t    bcdUSB;
    uint8_t     bDeviceClass;
    uint8_t     bDeviceSubClass;
    uint8_t     bDeviceProtocol;
    uint8_t     bMaxPacketSize;
    uint16_t    idVendor;
    uint16_t    idProduct;
    uint16_t    bcdDevice;
    uint8_t     iManufacturer;
    uint8_t     iProduct;
    uint8_t     iSerialNumber;
    uint8_t     bNumConfigurations;
} usbhost_devicedescriptor_t;
#define USBHOST_DEVICE_DESCRIPTOR_SIZE sizeof(usbhost_devicedescriptor_t)

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;

    uint16_t    wTotalLength;
    uint8_t     bNumInterfaces;
    uint8_t     bConfigurationValue;
    uint8_t     iConfiguration;
    uint8_t     bmAttributes;
    uint8_t     bMaxPower;

} usbhost_configurationdescriptor_t;
#define USBHOST_CONFIGURATION_DESCRIPTOR_SIZE sizeof(usbhost_configurationdescriptor_t)

#define USBHOST_MAX_INTERFACES 32
typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;

    uint8_t     bInterfaceNumber;
    uint8_t     bAlternateSetting;
    uint8_t     bNumEndpoints;
    uint8_t     bInterfaceClass;
    uint8_t     bInterfaceSubClass;
    uint8_t     bInterfaceProtocol;
    uint8_t     iInterface;

} usbhost_interfacedescriptor_t;
#define USBHOST_INTERFACE_DESCRIPTOR_SIZE sizeof(usbhost_interfacedescriptor_t)

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;

    uint8_t     bEndpointAddress;
    uint8_t     bmAttributes;    // 0..1 Transfer Type
    uint16_t    wMaxPacketSize;
    uint8_t     bInterval;
} usbhost_endpointdescriptor_t;
#define USBHOST_ENDPOINT_DESCRIPTOR_SIZE sizeof(usbhost_endpointdescriptor_t)

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;

    uint16_t    bcdUSB;
    uint8_t     bDeviceClass;
    uint8_t     bDeviceSubClass;
    uint8_t     bDeviceProtocol;
    uint8_t     bMaxPacketSize0;
    uint8_t     bNumConfigurations;
    uint8_t     bReserved;
} usbhost_devqualifierdescriptor_t;
#define USBHOST_DEVQUALIFIER_DESCRIPTOR_SIZE sizeof(usbhost_devqualifierdescriptor_t)

typedef struct __packed__ {
    uint8_t     bLength;
    uint8_t     bDescriptorType;

    uint8_t     bFirstInterface;
    uint8_t     bInterfaceCount;
    uint8_t     bFunctionClass;
    uint8_t     bFunctionSubClass;
    uint8_t     bFunctionProtocol;
    uint8_t     iFunction;
} usbhost_ifassociationdescriptor_t;
#define USBHOST_IFASSOCIATION_DESCRIPTOR_SIZE sizeof(usbhost_ifassociationdescriptor_t)

typedef enum {
        USBHOST_SPEED_UNKNOWN = 0,                  // enumerating
        USBHOST_SPEED_LOW, USBHOST_SPEED_FULL,          // usb 1.1
        USBHOST_SPEED_HIGH                          // usb 2.0
} usbhost_devicespeed_t;

typedef enum {
        USBHOST_STATE_NOTATTACHED = 0,
        USBHOST_STATE_ATTACHED,
        USBHOST_STATE_POWERED,
        USBHOST_STATE_DEFAULT,
        USBHOST_STATE_ADDRESS,
        USBHOST_STATE_CONFIGURED,
        USBHOST_STATE_SUSPENDED
} usbhost_devicestate_t;


#define USBHOST_MAX_KIDS 16
typedef struct {
        uint8_t  bLength;
        uint8_t  bDescriptorType;

        uint8_t  bNbrPorts;
        uint16_t wHubCharacteristics;
        uint8_t  bPwrOn2PwrGood;
        uint8_t  bHubContrCurrent;
        // Add 1 bit for hub status change; round to bytes
        uint8_t  DeviceRemovable[(USBHOST_MAX_KIDS + 1 + 7) / 8];
        uint8_t  PortPwrCtrlMask[(USBHOST_MAX_KIDS + 1 + 7) / 8];
} usbhost_hubdescriptor_t;

// Control Requests

typedef struct __packed__ {
    uint8_t     bmRequestType;
    uint8_t     bRequest;
    uint16_t    wValue;
    uint16_t    wIndex;
    uint16_t    wLength;
} usbhost_controlrequest_t;

#define USBHOST_FEATURE_CLR 0
#define USBHOST_FEATURE_SET 1

// bmRequestType - Direction(relative to host)
#define USBHOST_DIR_OUT                     (0)
#define USBHOST_DIR_IN                      (1<<7)

// bmRequestType - Type
#define USBHOST_TYPE_MASK                   (0x03 << 5)
#define USBHOST_TYPE_STANDARD               (0x00 << 5)
#define USBHOST_TYPE_CLASS                  (0x01 << 5)
#define USBHOST_TYPE_VENDOR                 (0x02 << 5)
#define USBHOST_TYPE_RESERVED               (0x03 << 5)

// bmRequestType - Recepient
#define USBHOST_RECIP_MASK                  0x1f
#define USBHOST_RECIP_DEVICE                0x00
#define USBHOST_RECIP_INTERFACE             0x01
#define USBHOST_RECIP_ENDPOINT              0x02
#define USBHOST_RECIP_OTHER                 0x03

// Wireless only
#define USBHOST_RECIP_PORT                  0x04
#define USBHOST_RECIP_RPIPE                 0x05

// Standard Control Requets
#define USBHOST_REQ_GET_STATUS              0x00
#define USBHOST_REQ_CLEAR_FEATURE           0x01
#define USBHOST_REQ_SET_FEATURE             0x03
#define USBHOST_REQ_SET_ADDRESS             0x05
#define USBHOST_REQ_GET_DESCRIPTOR          0x06
#define USBHOST_REQ_SET_DESCRIPTOR          0x07
#define USBHOST_REQ_GET_CONFIGURATION       0x08
#define USBHOST_REQ_SET_CONFIGURATION       0x09
#define USBHOST_REQ_GET_INTERFACE           0x0A
#define USBHOST_REQ_SET_INTERFACE           0x0B
#define USBHOST_REQ_SYNCH_FRAME             0x0C

#define USBHOST_REQ_SET_ENCRYPTION          0x0D
#define USBHOST_REQ_GET_ENCRYPTION          0x0E
#define USBHOST_REQ_RPIPE_ABORT             0x0E
#define USBHOST_REQ_SET_HANDSHAKE           0x0F
#define USBHOST_REQ_RPIPE_RESET             0x0F
#define USBHOST_REQ_GET_HANDSHAKE           0x10
#define USBHOST_REQ_SET_CONNECTION          0x11
#define USBHOST_REQ_SET_SECURITY_DATA       0x12
#define USBHOST_REQ_GET_SECURITY_DATA       0x13
#define USBHOST_REQ_SET_WUSB_DATA           0x14
#define USBHOST_REQ_LOOPBACK_DATA_WRITE     0x15
#define USBHOST_REQ_LOOPBACK_DATA_READ      0x16
#define USBHOST_REQ_SET_INTERFACE_DS        0x17

/*
 * Standard Feature Selectors
 */
#define USBHOST_FS_DEVICE_REMOTE_WAKEUP     1       /* device */
#define USBHOST_FS_ENDPOINT_HALT            0       /* end point */
#define USBHOST_FS_TEST_MODE                2       /* device */

// Descriptor Types
#define USBHOST_DT_DEVICE                   0x01
#define USBHOST_DT_CONFIG                   0x02
#define USBHOST_DT_STRING                   0x03
#define USBHOST_DT_INTERFACE                0x04
#define USBHOST_DT_ENDPOINT                 0x05
#define USBHOST_DT_DEVICE_QUALIFIER         0x06
#define USBHOST_DT_OTHER_SPEED_CONFIG       0x07
#define USBHOST_DT_INTERFACE_POWER          0x08
#define USBHOST_DT_OTG                      0x09
#define USBHOST_DT_DEBUG                    0x0A
#define USBHOST_DT_INTERFACE_ASSOCIATION    0x0B
#define USBHOST_DT_SECURITY                 0x0C
#define USBHOST_DT_KEY                      0x0D
#define USBHOST_DT_ENCRYPTION_TYPE          0x0E
#define USBHOST_DT_BOS                      0x0F
#define USBHOST_DT_DEVICE_CAPABILITY        0x10
#define USBHOST_DT_WIRELESS_ENDPOINT_COMP   0x11
#define USBHOST_DT_WIRE_ADAPTER             0x21
#define USBHOST_DT_RPIPE                    0x22
#define USBHOST_DT_CS_RADIO_CONTROL         0x23
#define USBHOST_DT_CS_UNDEFINED             0x20
#define USBHOST_DT_CS_DEVICE                0x21
#define USBHOST_DT_CS_CONFIGURATION         0x22
#define USBHOST_DT_CS_STRING                0x23
#define USBHOST_DT_CS_INTERFACE             0x24
#define USBHOST_DT_CS_ENDPOINT              0x25


// Hub

#define C_HUB_LOCAL_POWER       0
#define C_HUB_OVER_CURRENT      1

#define USBHOST_PORT_CONNECTION             0
#define USBHOST_PORT_ENABLE                 1
#define USBHOST_PORT_SUSPEND                2
#define USBHOST_PORT_OVER_CURRENT           3
#define USBHOST_PORT_RESET                  4
#define USBHOST_PORT_POWER                  8
#define USBHOST_PORT_LOWSPEED               9
#define USBHOST_PORT_HIGHSPEED              10
#define USBHOST_PORT_C_CONNECTION           16
#define USBHOST_PORT_C_ENABLE               17
#define USBHOST_PORT_C_SUSPEND              18
#define USBHOST_PORT_C_OVER_CURRENT         19
#define USBHOST_PORT_C_RESET                20
#define USBHOST_PORT_TEST                   21
#define USBHOST_PORT_INDICATOR              22

#define USBHOST_HUB_REQ_CLEAR_TT_BUFFER     8
#define USBHOST_HUB_REQ_RESET_TT            9

#ifdef  __cplusplus
}
#endif

#endif // __USBHOST_FRAMEWORK_H
