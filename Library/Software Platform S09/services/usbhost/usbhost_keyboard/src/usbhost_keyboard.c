/**
 * @file
 * Device driver for USB-Host keyboards
 *
 */

#include <assert.h>

#include <util_endian.h>

#include <usbhost_keyboard.h>
#include <usbhost_keyboard_cfg_instance.h>

#include <usbhost.h>
#include <usbhost_message.h>

#define USBHOST_CLASS_HID           3
#define HID_SUBCLASS_BOOTINTERFACE  1
#define HID_PROTOCOL_KEYBOARD       1

#define HID_SET_IDLE                0x0A
#define HID_SET_PROTOCOL            0x0B
#define HID_SET_REPORT              0x09

#define HID_SET_PROTOCOL_BOOT       0

#define HID_REPORT_OUTPUT           0x02

#define KEYBOARDDATA_SIZE           8

struct usbhost_keyboard_s
{
    usbhost_t *usbhost;
    usbhost_registereddriver_t *registereddriver;
    uint8_t keyboarddata_prev[6];
    uint16_t *buffer;
    size_t buffer_size;
    volatile size_t buffer_head;
    size_t buffer_tail;
};


static usbhost_keyboard_t usbhost_keyboard_driver_table[USBHOST_KEYBOARD_INSTANCE_COUNT];


// callback for USB-interrupt based URB for keyboard status change
static void usbhost_keyboard_synccomplete(usbhost_urb_t *urb)
{
    usbhost_keyboard_t *restrict drv = (usbhost_keyboard_t *) urb->completeContext;
    uint8_t *keyboarddata = (uint8_t *) urb->xferBuf;
    int i;

    if (urb->status)
    {
        // keyboard driver received URB error, uninstalling
        free(keyboarddata);
        free(urb);
        return;
    }

    uint16_t shiftcode = ((uint16_t) keyboarddata[0]) << 8;
    bool anykey = false;
    for (i = 2; i < 8; ++i)
    {
        uint8_t scancode = keyboarddata[i];
        int j;
        size_t next;

        if (scancode == 0x00) continue;
        if (scancode == 0x01) goto error_rollover;

        for (j = 2; j < 8; ++j)
        {
            // key was already pressed
            if (drv->keyboarddata_prev[j] == scancode) break;
        }
        if (j < 8) continue;

        next = drv->buffer_head + 1;
            if (next >= drv->buffer_size) next = 0;
            if (next == drv->buffer_tail) break;

            drv->buffer[drv->buffer_head] = shiftcode | scancode;
            drv->buffer_head = next;
            anykey = true;
        }

    for (int i = 0; i < 8; ++i)
    {
        drv->keyboarddata_prev[i] = keyboarddata[i];
    }

    if (!anykey)
    {
        // shift only or all release
        size_t next = drv->buffer_head + 1;
        if (next >= drv->buffer_size) next = 0;
        if (next != drv->buffer_tail)
        {
            drv->buffer[drv->buffer_head] = shiftcode;
            drv->buffer_head = next;
        }
    }

error_rollover:
    // repeat the request for the keyboard status
    usbhost_enqueueurb(urb);
}


// test new USB device for HID keyboard with boot interface
static bool usbhost_keyboard_devicetest(void *devicedrv, usbhost_device_t *usbdevice)
{
    usbhost_keyboard_t *restrict drv = (usbhost_keyboard_t *) devicedrv;
    usbhost_urb_t *urb;
    uint8_t *keyboarddata;

    usbhost_controlrequest_t controlrequest;

    // verify if we are a suitable driver for this device
    if (usbdevice->desc.bDeviceClass)
    {
        // class is specified directly
        if (usbdevice->desc.bDeviceClass != USBHOST_CLASS_HID) return false;
        if (usbdevice->desc.bDeviceSubClass != HID_SUBCLASS_BOOTINTERFACE) return false;
        if (usbdevice->desc.bDeviceProtocol != HID_PROTOCOL_KEYBOARD) return false;
    }
    else
    {
        // class is specified by interface
        if (usbdevice->config->intf[0]->curIntf->desc.bInterfaceClass != USBHOST_CLASS_HID) return false;
        if (usbdevice->config->intf[0]->curIntf->desc.bInterfaceSubClass != HID_SUBCLASS_BOOTINTERFACE) return false;
        if (usbdevice->config->intf[0]->curIntf->desc.bInterfaceProtocol != HID_PROTOCOL_KEYBOARD) return false;
    }

    // activate bootinterface on HID-keyboard
    controlrequest.bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_INTERFACE;
    controlrequest.bRequest      = HID_SET_PROTOCOL;
    controlrequest.wValue        = little16(HID_SET_PROTOCOL_BOOT);
    controlrequest.wIndex        = 0;
    controlrequest.wLength       = 0;
    if (usbhost_docontrolrequest(usbdevice, &controlrequest, 0, 0)) return false;

    // turn idle reporting off
    controlrequest.bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_INTERFACE;
    controlrequest.bRequest      = HID_SET_IDLE;
    controlrequest.wValue        = 0;
    controlrequest.wIndex        = 0;
    controlrequest.wLength       = 0;
    if (usbhost_docontrolrequest(usbdevice, &controlrequest, 0, 0)) return false;

    // create & send a request for the keyboard status
    urb = (usbhost_urb_t*) malloc(sizeof(usbhost_urb_t));
    if (!urb) return false;
    keyboarddata = (uint8_t*) malloc(KEYBOARDDATA_SIZE);
    if (!keyboarddata) return false;
    usbhost_initurb(urb);
    usbhost_buildasyncinterrupturb(usbdevice, &usbdevice->config->intf[0]->curIntf->endpoint[0], keyboarddata, KEYBOARDDATA_SIZE, &usbhost_keyboard_synccomplete, urb);
    urb->completeContext = drv;
    usbhost_enqueueurb(urb);

    return true;
}


/**
 * @brief
 *      Get next scancode
 *
 * Returns the next keyboard scan code. If multiple USB keyboards are
 * connected to the same driver instance, there is no way to identify
 * from which keyboard the key originated.
 *
 * @param drv
 *      usbhost_keyboard driver pointer
 *
 * @return
 *      scancode i successful, 0xFFFF otherwise.
 */
uint16_t usbhost_keyboard_get_scancode(usbhost_keyboard_t *drv)
{
    uint16_t ret = 0xFFFF;

    size_t tail = drv->buffer_tail;
    if (tail != drv->buffer_head)
    {
        ret = drv->buffer[tail++];
        if (tail >= drv->buffer_size) tail = 0;
        drv->buffer_tail = tail;
    }

    return ret;
}


/**
 * @brief
 *      Set keyboard LEDs on/off
 *
 * Turn keyboard LEDs on or off for NumLock, CapsLock and ScrollLock.
 * The LED's will be set on all USB keyboards connected to the driver instance.
 * Only bits 0, 1 and 2 of the @em leds bitmask value are used, which
 * correspond with the NumLock, Capslock and ScrollLock LED respectively.
 *
 * @param drv
 *      usbhost_keyboard driver pointer
 * @param leds
 *      Bitmask containing LED values
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int usbhost_keyboard_setleds(usbhost_keyboard_t *drv, uint8_t leds)
{
    usbhost_device_t *usbdevice = drv->registereddriver->devices;

    // send the request to all connected devices for this driver
    while (usbdevice)
    {
        usbhost_controlrequest_t controlrequest;

        // create a HID output report (=set LEDS)
        controlrequest.bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_INTERFACE;
        controlrequest.bRequest      = HID_SET_REPORT;
        controlrequest.wValue        = little16(HID_REPORT_OUTPUT << 8);
        controlrequest.wIndex        = 0;
        controlrequest.wLength       = little16(1);

        if (usbhost_docontrolrequest(usbdevice, &controlrequest, &leds, 1)) return -1;

        usbdevice = usbdevice->nextregistered;
    }

    return 0;
}


/**
 * @brief Initialize the USB-Host keyboard driver
 *
 * @param     id         USB-Host keyboard driver id
 *
 * @return    pointer to the initialized driver structure or NULL on failure.
 */
usbhost_keyboard_t *usbhost_keyboard_open(int id)
{
    assert((id >= 0) && (id < USBHOST_KEYBOARD_INSTANCE_COUNT));

    usbhost_keyboard_t *restrict drv = &usbhost_keyboard_driver_table[id];
    usbhost_keyboard_cfg_instance_t *restrict drv_cfg = &usbhost_keyboard_instance_table[id];
    usbhost_t *usbhost;

    if (drv->usbhost) return drv;

    usbhost = usbhost_open(drv_cfg->usbhost);
    drv->usbhost = usbhost;

    drv->registereddriver = usbhost_registerdevicedriver(usbhost, drv, &usbhost_keyboard_devicetest, NULL);

    for (int i = 0; i < 8; ++i) drv->keyboarddata_prev[i] = 0;

    drv->buffer = drv_cfg->buffer;
    drv->buffer_size = drv_cfg->buffer_size;
    drv->buffer_head = 0;
    drv->buffer_tail = 0;

    return drv;
}
