/**
 * @file
 * Device driver for USB-Host keyboards
 *
 */

#include <assert.h>

#include <usbhost_mouse.h>
#include <usbhost_mouse_cfg_instance.h>

#include <usbhost.h>
#include <usbhost_message.h>

#include <util_endian.h>


#define USBHOST_CLASS_HID               3
#define HID_SUBCLASS_BOOTINTERFACE  1
#define HID_PROTOCOL_MOUSE          2

#define HID_SET_PROTOCOL            0x0B
#define HID_SET_PROTOCOL_BOOT       0

#define MOUSEDATA_SIZE              4

struct usbhost_mouse_s {
    usbhost_t *usbhost;
    bool state_changes;
    usbhost_mouse_state_t state;
};


static usbhost_mouse_t usbhost_mouse_driver_table[USBHOST_MOUSE_INSTANCE_COUNT];


// callback for USB-interrupt based URB for mouse status change
static void usbhost_mouse_complete(usbhost_urb_t *urb)
{
    usbhost_mouse_t *restrict drv = (usbhost_mouse_t *) urb->completecontext;
    int8_t *mousedata = (int8_t *) urb->xferbuf;

    if (urb->status)
    {
        // mouse driver received URB error, uninstalling
        free(mousedata);
        free(urb);
        return;
    }

    drv->state.buttons = mousedata[0];
    drv->state.xmov += mousedata[1];
    drv->state.ymov += mousedata[2];
    drv->state_changes = true;

    // repeat the request for the mouse status
    usbhost_enqueueurb(urb);
}



// test new USB device for HID mouse with boot interface
static bool usbhost_mouse_devicetest(void *devicedrv, usbhost_device_t *usbdevice)
{
    usbhost_mouse_t *restrict drv = (usbhost_mouse_t *) devicedrv;
    usbhost_urb_t *urb;
    int8_t *mousedata;

    usbhost_controlrequest_t controlrequest;

    // verify if we are a suitable driver for this device
    if (usbdevice->desc.bDeviceClass)
    {
        // class is specified directly
        if (usbdevice->desc.bDeviceClass != USBHOST_CLASS_HID) return false;
        if (usbdevice->desc.bDeviceSubClass != HID_SUBCLASS_BOOTINTERFACE) return false;
        if (usbdevice->desc.bDeviceProtocol != HID_PROTOCOL_MOUSE) return false;
    }
    else
    {
        // class is specified by interface
        if (usbdevice->config->intf[0].curIntf->desc.bInterfaceClass != USBHOST_CLASS_HID) return false;
        if (usbdevice->config->intf[0].curIntf->desc.bInterfaceSubClass != HID_SUBCLASS_BOOTINTERFACE) return false;
        if (usbdevice->config->intf[0].curIntf->desc.bInterfaceProtocol != HID_PROTOCOL_MOUSE) return false;
    }
#if DEBUG_USBHOST
    printf("HID Mouse device connected\n");
#endif

    // activate bootinterface on HID-mouse
    controlrequest.bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_INTERFACE;
    controlrequest.bRequest      = HID_SET_PROTOCOL;
    controlrequest.wValue        = little16(HID_SET_PROTOCOL_BOOT);
    controlrequest.wIndex        = 0;
    controlrequest.wLength       = 0;

    if (usbhost_docontrolrequest(usbdevice, &controlrequest, 0, 0)) return false;

    // create & send a request for the mouse status
    urb = (usbhost_urb_t*) malloc(sizeof(usbhost_urb_t));
    if (!urb) return false;
    mousedata = (int8_t*) malloc(MOUSEDATA_SIZE);
    if (!mousedata) return false;
    usbhost_initurb(urb, USBHOST_URB_NOTIFY_POLL);
    usbhost_buildinterrupturb(usbdevice, &usbdevice->config->intf[0].curIntf->endpoint[0], mousedata, MOUSEDATA_SIZE, &usbhost_mouse_complete, NULL, urb);
    urb->completecontext = drv;
    usbhost_enqueueurb(urb);

    return true;
}


/**
 * @brief
 *      Get next state
 *
 * Returns the next mouse state. If multiple USB mice are connected
 * to the same driver instance, there is no way to identify from
 * which mouse the state originated.
 *
 * @param drv    usbhost_mouse driver pointer
 * @param state  pointer to state structure
 *
 * @return
 *      0 if any changes, -1 if not
 */
int usbhost_mouse_get_state(usbhost_mouse_t *drv, usbhost_mouse_state_t *state)
{
    int ret;

    // lock interrupt

    *state = drv->state;
    ret = drv->state_changes ? 0 : -1;

    drv->state.xmov = 0;
    drv->state.ymov = 0;
    drv->state_changes = false;

    // unlock interrupt

    return ret;
}


/**
 * @brief Initialize the USB-Host mouse driver
 *
 * @param     id         USB-Host mouse driver id
 *
 * @return    pointer to the initialized driver structure or NULL on failure.
 */
usbhost_mouse_t *usbhost_mouse_open(int id)
{
    assert((id >= 0) && (id < USBHOST_MOUSE_INSTANCE_COUNT));

    usbhost_mouse_t *restrict drv = &usbhost_mouse_driver_table[id];
    const usbhost_mouse_cfg_instance_t *restrict drv_cfg = &usbhost_mouse_instance_table[id];
    usbhost_t *usbhost;

    if (drv->usbhost) return drv;

    usbhost = usbhost_open(drv_cfg->usbhost);

    drv->state_changes = false;
    drv->state.buttons = 0;
    drv->state.xmov = 0;
    drv->state.ymov = 0;

    usbhost_registerdevicedriver(usbhost, drv, &usbhost_mouse_devicetest, NULL);

    drv->usbhost = usbhost;

    return drv;
}
