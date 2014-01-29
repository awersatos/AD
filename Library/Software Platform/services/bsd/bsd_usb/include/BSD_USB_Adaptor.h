////////////////////////////////////////////////////////////////////////////////
// BSD_USB_Adaptor.h

#ifndef __BSD_USB_ADAPTOR_H
#define __BSD_USB_ADAPTOR_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <sys/bsdtypes.h>
#include <sys/queue.h>

#include <usbhost.h>
#include <usbhost_core.h>

//#define BSD_USB_DEBUG
#undef BSD_USB_DEBUG

#ifdef BSD_USB_DEBUG
extern int bsd_usb_debug_lvl;
#define BSD_USB_DPRINTF(x)  do { if (bsd_usb_debug_lvl) printf x; } while (0)
#define BSD_USB_DPRINTFN(n,x)   do { if (n<=bsd_usb_debug_lvl) printf x; } while (0)
#else
#define BSD_USB_DPRINTF(x)
#define BSD_USB_DPRINTFN(n,x)
#endif

/* Locator stuff. */

/* XXX these values are used to statically bind some elements in the USB tree
 * to specific driver instances. This should be somehow emulated in FreeBSD
 * but can be done later on.
 * The values are copied from the files.usb file in the NetBSD sources.
 */
#define UHUBCF_PORT_DEFAULT             -1
#define UHUBCF_CONFIGURATION_DEFAULT    -1
#define UHUBCF_INTERFACE_DEFAULT        -1
#define UHUBCF_VENDOR_DEFAULT           -1
#define UHUBCF_PRODUCT_DEFAULT          -1
#define UHUBCF_RELEASE_DEFAULT          -1

#define UHUBCF_PORT             0
#define UHUBCF_CONFIGURATION    1
#define UHUBCF_INTERFACE        2
#define UHUBCF_VENDOR           3
#define UHUBCF_PRODUCT          4
#define UHUBCF_RELEASE          5

#define uhubcf_port             cf_loc[UHUBCF_PORT]
#define uhubcf_configuration    cf_loc[UHUBCF_CONFIGURATION]
#define uhubcf_interface        cf_loc[UHUBCF_INTERFACE]
#define uhubcf_vendor           cf_loc[UHUBCF_VENDOR]
#define uhubcf_product          cf_loc[UHUBCF_PRODUCT]
#define uhubcf_release          cf_loc[UHUBCF_RELEASE]
#define UHUB_UNK_PORT           UHUBCF_PORT_DEFAULT             /* wildcarded 'port'            */
#define UHUB_UNK_CONFIGURATION  UHUBCF_CONFIGURATION_DEFAULT    /* wildcarded 'configuration'   */
#define UHUB_UNK_INTERFACE      UHUBCF_INTERFACE_DEFAULT        /* wildcarded 'interface'       */
#define UHUB_UNK_VENDOR         UHUBCF_VENDOR_DEFAULT           /* wildcarded 'vendor'          */
#define UHUB_UNK_PRODUCT        UHUBCF_PRODUCT_DEFAULT          /* wildcarded 'product'         */
#define UHUB_UNK_RELEASE        UHUBCF_RELEASE_DEFAULT          /* wildcarded 'release'         */

typedef uint8_t uByte;
typedef uint8_t uWord[2];
typedef uint8_t uDWord[4];

#define UGETW(w)    (read_little16from16(&w))
#define USETW(w,v)  (write_little16to16(&w, v))
#define UGETDW(w)   (read_little32from32(&w))
#define USETDW(w,v) (write_little32to32(&w, v))

typedef usbhost_interfacedescriptor_t   usb_interface_descriptor_t;
typedef usbhost_endpointdescriptor_t    usb_endpoint_descriptor_t;

//typedef struct usbd_bus         *usbd_bus_handle;
typedef usbhost_device_t        *usbd_device_handle;
typedef usbhost_interface_t     *usbd_interface_handle;
typedef usbhost_host_endpoint_t *usbd_pipe_handle;
typedef usbhost_urb_t           *usbd_xfer_handle;
typedef void                    *usbd_private_handle;

typedef usbhost_controlrequest_t usb_device_request_t;

typedef int                     usbd_status;

typedef void                    *usbd_callback;


// BL[IMPL]
// BSD status map
#define USBD_NORMAL_COMPLETION      0
#define USBD_IN_PROGRESS            (-EINPROGRESS)
#define USBD_PENDING_REQUESTS       2
#define USBD_NOT_STARTED            3
#define USBD_INVAL                  4
#define USBD_NOMEM                  5
#define USBD_CANCELLED              6
#define USBD_BAD_ADDRESS            7
#define USBD_IN_USE                 8
#define USBD_NO_ADDR                9
#define USBD_SET_ADDR_FAILED        10
#define USBD_NO_POWER               11
#define USBD_TOO_DEEP               12
#define USBD_IOERROR                (-EREMOTEIO)
#define USBD_NOT_CONFIGURED         14
#define USBD_TIMEOUT                ETIME
#define USBD_SHORT_XFER             15
#define USBD_STALLED                (-EPIPE)
#define USBD_INTERRUPTED            17
#define USBD_ERROR_MAX              18

/* Attach data */
struct usb_attach_arg {
    int         port;
    int         configno;
    int         ifaceno;
    int         vendor;
    int         product;
    int         release;
    int         matchlvl;
    usbd_device_handle      device;     /* current device */
    usbd_interface_handle   iface;      /* current interface */
    int         usegeneric;
    usbd_interface_handle   *ifaces;    /* all interfaces */
    int         nifaces;                /* number of interfaces */
};

/* Match codes. */
/* First five codes is for a whole device. */
#define UMATCH_VENDOR_PRODUCT_REV                   14
#define UMATCH_VENDOR_PRODUCT                       13
#define UMATCH_VENDOR_DEVCLASS_DEVPROTO             12
#define UMATCH_DEVCLASS_DEVSUBCLASS_DEVPROTO        11
#define UMATCH_DEVCLASS_DEVSUBCLASS                 10
/* Next six codes are for interfaces. */
#define UMATCH_VENDOR_PRODUCT_REV_CONF_IFACE         9
#define UMATCH_VENDOR_PRODUCT_CONF_IFACE             8
#define UMATCH_VENDOR_IFACESUBCLASS_IFACEPROTO       7
#define UMATCH_VENDOR_IFACESUBCLASS                  6
#define UMATCH_IFACECLASS_IFACESUBCLASS_IFACEPROTO   5
#define UMATCH_IFACECLASS_IFACESUBCLASS              4
#define UMATCH_IFACECLASS                            3
#define UMATCH_IFACECLASS_GENERIC                    2
/* Generic driver */
#define UMATCH_GENERIC                               1
/* No match */
#define UMATCH_NONE                                  0

////////////////////////////////////////////////////////////////////////////////
#define UE_GET_XFERTYPE(x)  USBHOST_EPXFERTYPE(x)
#define UE_GET_DIR(x)       USBHOST_EPXFERDIR(x)

#define UE_DIR_IN           USBHOST_EPXFERDIR_IN
#define UE_DIR_OUT          USBHOST_EPXFERDIR_OUT

#define UE_CONTROL          USBHOST_EPXFERTYPE_CONTROL
#define UE_ISOCHRONOUS      USBHOST_EPXFERTYPE_ISO
#define UE_BULK             USBHOST_EPXFERTYPE_BULK
#define UE_INTERRUPT        USBHOST_EPXFERTYPE_INT

////////////////////////////////////////////////////////////////////////////////
#define UT_WRITE        0x00
#define UT_READ         0x80
#define UT_STANDARD     0x00
#define UT_CLASS        0x20
#define UT_VENDOR       0x40
#define UT_DEVICE       0x00
#define UT_INTERFACE    0x01
#define UT_ENDPOINT     0x02
#define UT_OTHER        0x03

#define UT_READ_DEVICE              (UT_READ  | UT_STANDARD | UT_DEVICE)
#define UT_READ_INTERFACE           (UT_READ  | UT_STANDARD | UT_INTERFACE)
#define UT_READ_ENDPOINT            (UT_READ  | UT_STANDARD | UT_ENDPOINT)
#define UT_WRITE_DEVICE             (UT_WRITE | UT_STANDARD | UT_DEVICE)
#define UT_WRITE_INTERFACE          (UT_WRITE | UT_STANDARD | UT_INTERFACE)
#define UT_WRITE_ENDPOINT           (UT_WRITE | UT_STANDARD | UT_ENDPOINT)
#define UT_READ_CLASS_DEVICE        (UT_READ  | UT_CLASS    | UT_DEVICE)
#define UT_READ_CLASS_INTERFACE     (UT_READ  | UT_CLASS    | UT_INTERFACE)
#define UT_READ_CLASS_OTHER         (UT_READ  | UT_CLASS    | UT_OTHER)
#define UT_READ_CLASS_ENDPOINT      (UT_READ  | UT_CLASS    | UT_ENDPOINT)
#define UT_WRITE_CLASS_DEVICE       (UT_WRITE | UT_CLASS    | UT_DEVICE)
#define UT_WRITE_CLASS_INTERFACE    (UT_WRITE | UT_CLASS    | UT_INTERFACE)
#define UT_WRITE_CLASS_OTHER        (UT_WRITE | UT_CLASS    | UT_OTHER)
#define UT_WRITE_CLASS_ENDPOINT     (UT_WRITE | UT_CLASS    | UT_ENDPOINT)
#define UT_READ_VENDOR_DEVICE       (UT_READ  | UT_VENDOR   | UT_DEVICE)
#define UT_READ_VENDOR_INTERFACE    (UT_READ  | UT_VENDOR   | UT_INTERFACE)
#define UT_READ_VENDOR_OTHER        (UT_READ  | UT_VENDOR   | UT_OTHER)
#define UT_READ_VENDOR_ENDPOINT     (UT_READ  | UT_VENDOR   | UT_ENDPOINT)
#define UT_WRITE_VENDOR_DEVICE      (UT_WRITE | UT_VENDOR   | UT_DEVICE)
#define UT_WRITE_VENDOR_INTERFACE   (UT_WRITE | UT_VENDOR   | UT_INTERFACE)
#define UT_WRITE_VENDOR_OTHER       (UT_WRITE | UT_VENDOR   | UT_OTHER)
#define UT_WRITE_VENDOR_ENDPOINT    (UT_WRITE | UT_VENDOR   | UT_ENDPOINT)

/* Requests */
#define UR_GET_STATUS       0x00
#define UR_CLEAR_FEATURE    0x01
#define UR_SET_FEATURE      0x03
#define UR_SET_ADDRESS      0x05
#define UR_GET_DESCRIPTOR   0x06
#define  UDESC_DEVICE       0x01
#define  UDESC_CONFIG       0x02
#define  UDESC_STRING       0x03
#define  UDESC_INTERFACE    0x04
#define  UDESC_ENDPOINT     0x05
#define  UDESC_DEVICE_QUALIFIER 0x06
#define  UDESC_OTHER_SPEED_CONFIGURATION 0x07
#define  UDESC_INTERFACE_POWER  0x08
#define  UDESC_OTG      0x09
#define  UDESC_CS_DEVICE    0x21    /* class specific */
#define  UDESC_CS_CONFIG    0x22
#define  UDESC_CS_STRING    0x23
#define  UDESC_CS_INTERFACE 0x24
#define  UDESC_CS_ENDPOINT  0x25
#define  UDESC_HUB      0x29
#define UR_SET_DESCRIPTOR   0x07
#define UR_GET_CONFIG       0x08
#define UR_SET_CONFIG       0x09
#define UR_GET_INTERFACE    0x0a
#define UR_SET_INTERFACE    0x0b
#define UR_SYNCH_FRAME      0x0c

/* Feature numbers */
#define UF_ENDPOINT_HALT    0
#define UF_DEVICE_REMOTE_WAKEUP 1
#define UF_TEST_MODE        2

#define USB_MAX_IPACKET     8 /* maximum size of the initial packet */

#define USB_2_MAX_CTRL_PACKET   64
#define USB_2_MAX_BULK_PACKET   512

////////////////////////////////////////////////////////////////////////////////

/* Open flags */
#define USBD_EXCLUSIVE_USE  0x01

/* Use default (specified by ep. desc.) interval on interrupt pipe */
#define USBD_DEFAULT_INTERVAL   (-1)

/* Request flags */
#define USBD_NO_COPY            0x00            /* do not copy data to DMA buffer */
#define USBD_SYNCHRONOUS        0x00            /* wait for completion */
#define USBD_SHORT_XFER_OK      0x00            /* allow short reads */
#define USBD_FORCE_SHORT_XFER   URB_ZERO_PACKET /* force last short packet on write */

#define USBD_NO_TIMEOUT 0
#define USBD_DEFAULT_TIMEOUT 5000 /* ms = 5 s */

#define DEVINFOSIZE 1024


////////////////////////////////////////////////////////////////////////////////
/* Interface class codes */
#define UICLASS_UNSPEC              0x00

#define UICLASS_AUDIO               0x01
#define  UISUBCLASS_AUDIOCONTROL    1
#define  UISUBCLASS_AUDIOSTREAM     2
#define  UISUBCLASS_MIDISTREAM      3

#define UICLASS_CDC                                     0x02 /* communication */
#define  UISUBCLASS_DIRECT_LINE_CONTROL_MODEL           1
#define  UISUBCLASS_ABSTRACT_CONTROL_MODEL              2
#define  UISUBCLASS_TELEPHONE_CONTROL_MODEL             3
#define  UISUBCLASS_MULTICHANNEL_CONTROL_MODEL          4
#define  UISUBCLASS_CAPI_CONTROLMODEL                   5
#define  UISUBCLASS_ETHERNET_NETWORKING_CONTROL_MODEL   6
#define  UISUBCLASS_ATM_NETWORKING_CONTROL_MODEL        7
#define   UIPROTO_CDC_AT                                1

#define UICLASS_HID             0x03
#define  UISUBCLASS_BOOT        1
#define  UIPROTO_BOOT_KEYBOARD  1

#define UICLASS_PHYSICAL        0x05

#define UICLASS_IMAGE           0x06

#define UICLASS_PRINTER         0x07
#define  UISUBCLASS_PRINTER     1
#define  UIPROTO_PRINTER_UNI    1
#define  UIPROTO_PRINTER_BI     2
#define  UIPROTO_PRINTER_1284   3

#define UICLASS_MASS            0x08
#define  UISUBCLASS_RBC         1
#define  UISUBCLASS_SFF8020I    2
#define  UISUBCLASS_QIC157      3
#define  UISUBCLASS_UFI         4
#define  UISUBCLASS_SFF8070I    5
#define  UISUBCLASS_SCSI        6
#define  UIPROTO_MASS_CBI_I     0
#define  UIPROTO_MASS_CBI       1
#define  UIPROTO_MASS_BBB_OLD   2   /* Not in the spec anymore */
#define  UIPROTO_MASS_BBB       80  /* 'P' for the Iomega Zip drive */

#define UICLASS_HUB             0x09
#define  UISUBCLASS_HUB         0
#define  UIPROTO_FSHUB          0
#define  UIPROTO_HSHUBSTT       0 /* Yes, same as previous */
#define  UIPROTO_HSHUBMTT       1

#define UICLASS_CDC_DATA            0x0a
#define  UISUBCLASS_DATA            0
#define   UIPROTO_DATA_ISDNBRI      0x30    /* Physical iface */
#define   UIPROTO_DATA_HDLC         0x31    /* HDLC */
#define   UIPROTO_DATA_TRANSPARENT  0x32    /* Transparent */
#define   UIPROTO_DATA_Q921M        0x50    /* Management for Q921 */
#define   UIPROTO_DATA_Q921         0x51    /* Data for Q921 */
#define   UIPROTO_DATA_Q921TM       0x52    /* TEI multiplexer for Q921 */
#define   UIPROTO_DATA_V42BIS       0x90    /* Data compression */
#define   UIPROTO_DATA_Q931         0x91    /* Euro-ISDN */
#define   UIPROTO_DATA_V120         0x92    /* V.24 rate adaption */
#define   UIPROTO_DATA_CAPI         0x93    /* CAPI 2.0 commands */
#define   UIPROTO_DATA_HOST_BASED   0xfd    /* Host based driver */
#define   UIPROTO_DATA_PUF          0xfe    /* see Prot. Unit Func. Desc.*/
#define   UIPROTO_DATA_VENDOR       0xff    /* Vendor specific */

#define UICLASS_SMARTCARD           0x0b

/*#define UICLASS_FIRM_UPD  0x0c*/

#define UICLASS_SECURITY                0x0d

#define UICLASS_VIDEO                   0x0e
#define  UISUBCLASS_VIDEOCONTROL        1
#define  UISUBCLASS_VIDEOSTREAM         2
#define  UISUBCLASS_VIDEO_IF_COLLECTION 3

#define UICLASS_DIAGNOSTIC  0xdc

#define UICLASS_WIRELESS        0xe0
#define  UISUBCLASS_RF          0x01
#define   UIPROTO_BLUETOOTH     0x01

#define UICLASS_APPL_SPEC               0xfe
#define  UISUBCLASS_FIRMWARE_DOWNLOAD   1
#define  UISUBCLASS_IRDA                2
#define  UIPROTO_IRDA                   0

#define UICLASS_VENDOR 0xff

////////////////////////////////////////////////////////////////////////////////
#define usb_lookup(tbl, vendor, product) \
    usb_match_device((const struct usb_devno *)(tbl), sizeof (tbl) / sizeof ((tbl)[0]), sizeof ((tbl)[0]), (vendor), (product))
#define USB_PRODUCT_ANY     0xffff

////////////////////////////////////////////////////////////////////////////////
struct usb_task {
    TAILQ_ENTRY(usb_task) next;
    void (*fun)(void *);
    void *arg;
    char onqueue;
};

void usb_add_task(usbd_device_handle dev, struct usb_task *task);
void usb_rem_task(usbd_device_handle dev, struct usb_task *task);
void usb_task_func_lock(void);
void usb_task_func_unlock(void);
#define usb_init_task(t, f, a) ((t)->fun = (f), (t)->arg = (a), (t)->onqueue = 0)

#define PUMP_USB_TASK_THREAD    usb_task_thread(NULL)

////////////////////////////////////////////////////////////////////////////////

struct device;
struct cfattach;
struct cfdriver;

// BL[TODO] - Need to impliment the following
#define usbd_add_drv_event(...)


void bsd_usb_init(void);

uint32_t splusb(void);

void usbd_delay_ms(usbd_device_handle dev, uint32_t ms);

usbd_xfer_handle usbd_alloc_xfer(usbd_device_handle);
usbd_status usbd_free_xfer(usbd_xfer_handle xfer);
usbd_status usbd_transfer(usbd_xfer_handle xfer);
usb_interface_descriptor_t *usbd_get_interface_descriptor(usbd_interface_handle iface);
usbd_status usbd_do_request(usbd_device_handle dev, usb_device_request_t *req, void *data);
usbd_status usbd_abort_pipe(usbd_pipe_handle pipe);
usb_endpoint_descriptor_t *usbd_interface2endpoint_descriptor(usbd_interface_handle iface, u_int8_t index);
void usbd_get_xfer_status(usbd_xfer_handle xfer, usbd_private_handle *priv, void **buffer, u_int32_t *count, usbd_status *status);
void usbd_setup_xfer(usbd_xfer_handle xfer, usbd_pipe_handle pipe, usbd_private_handle priv, void *buffer, u_int32_t length, u_int16_t flags, u_int32_t timeout, usbd_callback callback);
void usbd_setup_default_xfer(usbd_xfer_handle xfer, usbd_device_handle dev, usbd_private_handle priv, u_int32_t timeout, usb_device_request_t *req, void *buffer, u_int32_t length, u_int16_t flags, usbd_callback callback);
usbd_status usbd_open_pipe(usbd_interface_handle iface, u_int8_t address, u_int8_t flags, usbd_pipe_handle *pipe);
usbd_status usbd_open_pipe_ival(usbd_interface_handle iface, u_int8_t address, u_int8_t flags, usbd_pipe_handle *pipe, int ival);
usbd_status usbd_close_pipe(usbd_pipe_handle pipe);
void usbd_free_buffer(usbd_xfer_handle xfer);
void *usbd_alloc_buffer(usbd_xfer_handle xfer, u_int32_t size);
void usbd_do_request_async_cb(usbd_xfer_handle xfer, usbd_private_handle priv, usbd_status status);
usbd_status usbd_do_request_async(usbd_device_handle dev, usb_device_request_t *req, void *data);
usbd_status usbd_probe_and_attach(struct device *parent, usbd_device_handle dev, int port, int addr);

usbd_status usbd_clear_endpoint_stall(usbd_pipe_handle pipe);
usbd_status usbd_open_pipe_intr(usbd_interface_handle iface, u_int8_t address, u_int8_t flags, usbd_pipe_handle *pipe, usbd_private_handle priv, void *buffer, u_int32_t len, usbd_callback cb, int ival);
usbd_status usbd_bulk_transfer(usbd_xfer_handle xfer, usbd_pipe_handle pipe, u_int16_t flags, u_int32_t timeout, void *buf, u_int32_t *size, char *lbl);

const struct usb_devno *usb_match_device(const struct usb_devno *tbl, u_int nentries, u_int sz, u_int16_t vendor, u_int16_t product);

// In ioconf.c
void usbd_Register_device(int port, int configuration, int interface, int vendor, int product, int release, struct cfattach *cf_attach, struct cfdriver *cf_driver);

#ifdef  __cplusplus
}
#endif

#endif // __BSD_USB_ADAPTOR_H
