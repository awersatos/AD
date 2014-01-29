// usbhost_core.h

#ifndef _USBHOST_CORE_H
#define _USBHOST_CORE_H

#include <stdint.h>
#include <stdbool.h>
#include <errno.h>

#include <usbhost_framework.h>


//#define put_unaligned(x) (x)

/* todo, remove/replace when makeing usbhost code little endian compatible */
#define cpu_to_le32(x) (x)
#define le32_to_cpu(x) (x)
#define cpu_to_le16(x) (x)

#define spin_lock_irqsave(...)
#define spin_unlock_irqrestore(...)
#define spin_lock(...)
#define spin_unlock(...)
#define spin_lock_irq(...)
#define spin_unlock_irq(...)


typedef struct
{
    usbhost_endpointdescriptor_t    desc;
    void                       *hcPriv; // QH => QTD_LIST ???
    uint32_t                    enabled;
} usbhost_host_endpoint_t;


typedef struct
{
    usbhost_interfacedescriptor_t   desc;
    usbhost_host_endpoint_t         *endpoint;
} usbhost_host_interface_t;


typedef struct usbhost_device_s usbhost_device_t;

typedef struct
{
    usbhost_device_t            *dev;
    usbhost_host_interface_t    *curIntf;
    usbhost_host_interface_t    *altIntf;
    uint32_t                    altCount;
} usbhost_interface_t;


typedef struct
{
    usbhost_configurationdescriptor_t   desc;

    usbhost_interface_t    *intf[USBHOST_MAX_INTERFACES];
} usbhost_host_config_t;


typedef struct usbhost_s usbhost_t;

typedef struct usbhost_registereddriver_s usbhost_registereddriver_t;

struct usbhost_device_s
{
    usbhost_t                   *usbhost;

    usbhost_device_t            *parent;      // hub the device is connected to
    uint8_t                     parentport;   // port on hub the device is connected to
    usbhost_device_t            *children;    // first child if this device is a hub
    usbhost_device_t            *nextchild;   // next child on the same hub
    usbhost_device_t            *nextregistered;  // next device for the same driver

    usbhost_devicedescriptor_t  desc;
    usbhost_devicestate_t       state;

    usbhost_host_config_t       *config;
    uint8_t                     *rawDesc;
    uint32_t                    rawDescLen;

    usbhost_host_endpoint_t     ep0IN;
    usbhost_host_endpoint_t     ep0OUT;

    uint8_t                     devNum;
    uint8_t                     ttport;

    usbhost_devicespeed_t       speed;

    usbhost_registereddriver_t  *registereddriver; // devicedriver which is controlling this device
};


struct usbhost_registereddriver_s
{
    bool (*connect_test)(void *drv, usbhost_device_t *usbdevice);
    void (*disconnect)(void *drv, usbhost_device_t *usbdevice);
    void *drv;
    struct usbhost_registereddriver_s *next;
    usbhost_device_t *devices;      // devices registred to the driver
};



#define URB_SHORT_NOT_OK        0x01  // report short reads as errors
#define URB_ISO_ASAP            0x02  // iso-only, urb->start_frame ignored
#define URB_NO_TRANSFER_DMA_MAP 0x04  // urb->transfer_dma valid on submit
#define URB_NO_SETUP_DMA_MAP    0x08  // urb->setup_dma valid on submit
#define URB_ASYNC_UNLINK        0x10  // usbhost_unlink_urb() returns asap
#define URB_NO_FSBR             0x20  // UHCI-specific
#define URB_ZERO_PACKET         0x40  // Finish bulk OUTs with short packet
#define URB_NO_INTERRUPT        0x80  // HINT: no non-error interrupt needed

#define URB_OWNER_CREATOR   0
#define URB_OWNER_HOST      1


typedef struct _usbhost_isoframedesc_t
{
    uint32_t offset;
    uint32_t len;            // expected length
    uint32_t actualLen;
    uint32_t status;
} usbhost_isoframedesc_t;


typedef struct usbhost_urb_s usbhost_urb_t;

typedef void (*hostusbhost_onurbcomplete_t)(usbhost_urb_t *urb);


typedef struct usbhost_urb_s
{

    int16_t                 status;        // Status of this URB
    uint16_t                owner;         // What context currently "owns" this URB

    usbhost_device_t           *dev;           // Device
    usbhost_host_endpoint_t    *ep;            // Endpoint

    void                   *xferBuf;       // In/Out buffer for transfer
    uint32_t                xferBufSize;   // Buf size
    uint32_t                xferActual;    // Bytes transferred
    uint32_t                xferFlags;

    uint8_t                *setupPacket;   // 8 Byte setup packet

    uint32_t                timeout;       // In ?? units

    void                   *completeContext;
    hostusbhost_onurbcomplete_t         OnComplete;

    uint16_t                interval;

    int32_t                 isoStartFrame;
    int32_t                 isoErrorCount;
    int32_t                 isoFrameCount;
    usbhost_isoframedesc_t      *isoFrames;
};


// Host Driver State
#define  __ACTIVE                0x01
#define  __SUSPEND               0x04
#define  __TRANSIENT             0x80

#define  HC_STATE_HALT           0
#define  HC_STATE_RUNNING        (__ACTIVE)
#define  HC_STATE_QUIESCING      (__SUSPEND|__TRANSIENT|__ACTIVE)
#define  HC_STATE_RESUMING       (__SUSPEND|__TRANSIENT)
#define  HC_STATE_SUSPENDED      (__SUSPEND)

#define HC_IS_RUNNING(state)    ((state) & __ACTIVE)
#define HC_IS_SUSPENDED(state)  ((state) & __SUSPEND)

#endif  // _USBHOST_CORE_H
