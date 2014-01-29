/*
 * USB descriptor
 */

#include <drv_cy7c68001.h>

#define LE_WORD(x)                  ((x) & 0xFF), (((x) >> 8) & 0xFF)
#define LE_UNICHAR(c)               (c), 0

uint8_t usb_msd_descr[] =
{
    /* Device descriptor */
    0x12, USB_DESC_DEVICE, LE_WORD(0x0200), /* USB specification release */
    0x00, /* class */
    0x00, /* subclass */
    0x00, /* protocol */
    USB_EP0_BUFFER_SIZE, /* maximum packet size for endpoint 0 */
    LE_WORD(0x414C), /* vendor ID */
    LE_WORD(0x4144), /* product ID */
    LE_WORD(0x4E42), /* device ID */
    0x01, /* manufacturer string ID */
    0x02, /* product string ID */
    0x03, /* serial number string ID */
    0x01, /* number of configurations */

    /* Configuration descriptor */
    0x09, USB_DESC_CONFIGURATION, LE_WORD(0x0020), /* total length */
    0x01, /* number of interfaces */
    0x01, /* configuration identifier ID */
    0x00, /* string ID (not defined) */
    0xC0, /* attributes: self powered, no remote wakeup */
    0x32, /* maximum power consumption: 100mA */

    /* Interface descriptor */
    0x09, USB_DESC_INTERFACE, 0x00, /* interface ID */
    0x00, /* alternate setting number */
    0x02, /* number of endpoints */
    0x08, /* interface class: mass storage */
    0x06, /* interface subclass: transparant SCSI */
    0x50, /* interface protocol: bulk transport only */
    0x00, /* string ID (not defined) */

    /* Endpoint descriptor*/
    0x07, USB_DESC_ENDPOINT, USB_MSD_IN_EP, /* endpoint number and direction: in */
    0x02, /* attributes: bulk */
    LE_WORD(USB_EPx_BUFFER_SIZE), /* maximum packet size */
    0x00, /* maximum latency/high-speed output: does not apply */

    /* Endpoint 2 descriptor */
    0x07, USB_DESC_ENDPOINT, USB_MSD_OUT_EP, /* endpoint number and direction: out */
    0x02, /* attributes: bulk */
    LE_WORD(USB_EPx_BUFFER_SIZE), /* maximum packet size */
    0x00, /* maximum latency/high-speed output: does not apply */

    /* String descriptor 0 (Language ID) */
    0x04, USB_DESC_STRING, LE_WORD(0x0409), /* language ID: US english */

    /* String descriptor 1 (Manufacturer ID) */
    0x0E, USB_DESC_STRING, LE_UNICHAR('A'), LE_UNICHAR('l'), LE_UNICHAR('t'), LE_UNICHAR('i'), LE_UNICHAR('u'), LE_UNICHAR('m'),

    /* String descriptor 2 (Product ID) */
    0x1E, USB_DESC_STRING, LE_UNICHAR('U'), LE_UNICHAR('S'), LE_UNICHAR('B'), LE_UNICHAR(' '), LE_UNICHAR('N'), LE_UNICHAR('a'), LE_UNICHAR('n'), LE_UNICHAR('o'), LE_UNICHAR(' '), LE_UNICHAR('B'), LE_UNICHAR('r'), LE_UNICHAR('i'), LE_UNICHAR('c'), LE_UNICHAR('k'),

    /* String descriptor 3 (Serial number) */
    0x1A, USB_DESC_STRING, LE_UNICHAR('0'), LE_UNICHAR('1'), LE_UNICHAR('2'), LE_UNICHAR('3'), LE_UNICHAR('4'), LE_UNICHAR('5'), LE_UNICHAR('6'), LE_UNICHAR('7'), LE_UNICHAR('8'), LE_UNICHAR('9'), LE_UNICHAR('A'), LE_UNICHAR('B'),

    /* Termination byte */
    0x00
};

int             usb_msd_descr_length = sizeof(usb_msd_descr);

