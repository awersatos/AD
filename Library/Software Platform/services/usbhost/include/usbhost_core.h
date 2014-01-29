// usbhost_core.h

#ifndef _USBHOST_CORE_H
#define _USBHOST_CORE_H

#include <stdint.h>
#include <stdbool.h>
#include <errno.h>

#if __POSIX_KERNEL__
#include <pthread.h>
#endif

#ifdef  __cplusplus
extern "C" {
#endif

#include <usbhost_framework.h>

#define USBHOST_MAXIADS         15

typedef struct usbhost_urb_s usbhost_urb_t;
typedef struct usbhost_device_s usbhost_device_t;


typedef struct
{
    usbhost_device_t              *dev;
    usbhost_endpointdescriptor_t  desc;
    void                          *ptd_cur;     // This is the current to be scheduled ptd
    void                          *ptd_tail;    // This is the tail of the ptd queue defining a datastream to this endpoint

    uint16_t                      period;       // polling interval for interrupt endpoints
    bool                          toggle;       // endpoint toggle state
    uint8_t                       ping;         // endpoint ping state
    uint32_t                      enabled;
#if USBHOST_ISO_SUPPORT
    uint32_t                      usss;        // ISP1760: usof start split (active)
    uint32_t                      uscs;        // ISP1760: usof complete split
    uint8_t                       next_uframe; // uframe of next ISO transfer
#endif
    uint32_t                        refcnt;
} usbhost_host_endpoint_t;


typedef struct
{
    usbhost_interfacedescriptor_t   desc;
    usbhost_host_endpoint_t         *endpoint;
    uint8_t                         *extra;         // descriptors in between this interfacedescriptor
                                                    // and the following interface or endpoint descriptor
    int                             extralen;
} usbhost_host_interface_t;

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
    usbhost_ifassociationdescriptor_t   *intf_assoc[USBHOST_MAXIADS];
    int                                 nintf;  // number of interfaces in this struct
    usbhost_interface_t                 intf[]; // flexible array member
} usbhost_host_config_t;


typedef struct usbhost_s usbhost_t;

typedef struct usbhost_registereddriver_s usbhost_registereddriver_t;

struct usbhost_device_s
{
    usbhost_t                   *usbhost;

    usbhost_device_t            *parent;        // hub the device is connected to
    uint8_t                     parentport;     // hub port the device is connected to
    usbhost_device_t            *children;      // first child if this device is a hub
    usbhost_device_t            *nextchild;     // next child on the same hub
    usbhost_device_t            *nextregistered;// next device for the same driver

    usbhost_devicedescriptor_t  desc;
    usbhost_devicestate_t       state;

    usbhost_host_config_t       *config;
    uint8_t                     *rawDesc;
    uint16_t                    rawDescLen;

    usbhost_host_endpoint_t     ep0IN;
    usbhost_host_endpoint_t     ep0OUT;

    uint16_t                    devNum;
    uint8_t                     ttport;

    usbhost_devicespeed_t       speed;

    usbhost_registereddriver_t  *registereddriver; // devicedriver which is controlling this device

    void                        **subdevs;
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
#define URB_BSD_COMPATIBILTY    0x100 // Enable OpenBSD compatibility support


typedef struct _usbhost_isoframedesc_t
{
    uint32_t offset;
    uint32_t len;            // expected length
    uint32_t actuallen;
    int32_t  status;
} usbhost_isoframedesc_t;


typedef void (*hostusbhost_onurbcomplete_t)(usbhost_urb_t *urb);
typedef void (*hostusbhost_onurbcompletebsd_t)(usbhost_urb_t *urb, void *, int);


typedef struct usbhost_urb_s
{

    int32_t                     status;            // Status of this URB

    usbhost_device_t            *dev;              // Device adressed by this urb
    usbhost_host_endpoint_t     *ep;               // Endpoint adressed by this urb

    void                        *xferbuf;          // In/Out buffer for transfer
    uint32_t                    xferbufsize;       // Buf size
    uint32_t                    xferactual;        // Bytes transferred
    uint32_t                    xferflags;

    uint8_t                     *setuppacket;      // 8 Byte setup packet
    usbhost_controlrequest_t    setuppacketdata;

    uint32_t                    timeout;           // In ?? units

    uint8_t                     complete;
    void                        *completecontext;
    void                        *OnComplete;
    void                        *ptd_first;        // first ptd of this urb (used for completing the urb) 
#if __POSIX_KERNEL__
    pthread_mutex_t             mutex;
    pthread_cond_t              cond;
    int                         notify;
#endif

    uint16_t                    interval;          // polling interval for ISO and INT
    int32_t                     isoerrorcount;
    int32_t                     isoframecount;
    usbhost_isoframedesc_t      isoframes[];
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

#ifdef  __cplusplus
}
#endif

#endif  // _USBHOST_CORE_H
