// UsbDevice.c

#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <timing.h>

#include <util_endian.h>

#include <usbhost_core.h>
#include <usbhost_device.h>
#include <usbhost_i.h>

void usbhost_buildcontrolendpoint(usbhost_host_endpoint_t *ep, uint8_t direction)
{
    ep->desc.bLength           = 0x07;
    ep->desc.bDescriptorType   = USBHOST_DT_ENDPOINT;
    ep->desc.bEndpointAddress  = direction;
    ep->desc.bmAttributes      = 0x00;  // it's a control endpoint
    ep->desc.wMaxPacketSize    = little16(0x40);
    ep->desc.bInterval         = 0x00;
    ep->period                 = 0;     // this ep does not need to be polled
    ep->ping                   = 0;     // start communication to this ep without ping
    ep->toggle                 = 0;     // start communication to this ep with DATA0
    ep->enabled                = 0x01;  // enable ptd generation for this ep
}

usbhost_device_t *usbhost_devicealloc(usbhost_t * restrict usbhost, usbhost_devicespeed_t devSpeed)
{
    usbhost_device_t *dev;

    dev = (usbhost_device_t *)calloc(sizeof(usbhost_device_t), 1);

    dev->usbhost = usbhost;
    dev->speed = devSpeed;

    usbhost_buildcontrolendpoint(&dev->ep0IN, USBHOST_DIR_IN);
    usbhost_buildcontrolendpoint(&dev->ep0OUT, USBHOST_DIR_OUT);

    return dev;
}

void usbhost_devicefree(usbhost_device_t *dev)
{
    usbhost_device_t *link;

    // remove from children of its hub
    link = dev->parent->children;
    if (link == dev)
    {
        // device was the head
        dev->parent->children = dev->nextchild;
    }
    else
    {
        while (link)
        {
            if (link->nextchild == dev)
            {
                // cut device from childrenlist
                link->nextchild = dev->nextchild;
                break;
            }
            link = link->nextchild;
        }
    }

    free(dev);
}

usbhost_host_endpoint_t *usbhost_endpointalloc(uint32_t count)
{
    usbhost_host_endpoint_t *ep = (usbhost_host_endpoint_t *)calloc(sizeof(usbhost_host_endpoint_t), count);

    return ep;
}

void usbhost_endpointfree(usbhost_host_endpoint_t *ep)
{
    free(ep);
}

void usbhost_endpointinit(usbhost_device_t *dev, usbhost_endpointdescriptor_t *epDesc, uint32_t enabled, usbhost_host_endpoint_t *ep)
{
    memcpy(&ep->desc, epDesc, sizeof(usbhost_endpointdescriptor_t));
    ep->enabled = enabled;
    ep->dev = dev;
    ep->ptd_tail = NULL;
}


usbhost_host_interface_t *usbhost_hostinterfacealloc(uint32_t count)
{
    return (usbhost_host_interface_t *)calloc(sizeof(usbhost_host_interface_t), count);
}


void usbhost_hostinterfacefree(usbhost_host_interface_t *intf)
{
    free(intf);
}


void usbhost_hostinterfaceinit(usbhost_interfacedescriptor_t *intfDesc, usbhost_host_endpoint_t *epArray, usbhost_host_interface_t *intf)
{
    memcpy(&intf->desc, intfDesc, sizeof(usbhost_interfacedescriptor_t));
    intf->endpoint = epArray;
}


usbhost_host_config_t *usbhost_configalloc(uint32_t count)
{
    return (usbhost_host_config_t *)calloc(1, sizeof(usbhost_host_config_t) + count * sizeof(usbhost_interface_t));
}


void usbhost_configfree(usbhost_host_config_t **conf)
{
    if (*conf)
    {
        free (*conf);
        *conf = NULL;
}
}


void usbhost_interfaceinit(usbhost_device_t *dev, usbhost_host_interface_t *curIntf, uint32_t altCount, usbhost_host_interface_t *altIntf,  usbhost_interface_t *intf)
{
    intf->dev       = dev;
    intf->curIntf   = curIntf;
    intf->altIntf   = altIntf;
    intf->altCount  = altCount;
}

usbhost_interface_t *usbhost_getfunctioninterface(uint32_t idx, usbhost_device_t *dev)
{
    return &dev->config->intf[idx];
}

char *base_class_to_string(int base_class)
{
    switch (base_class)
    {
        case 0x00:
            return "Device";
        case 0x01:
            return "Audio";
        case 0x02:
            return "Communications and CDC Control";
        case 0x03:
            return "HID – Human Interface Device";
        case 0x05:
            return "Physical";
        case 0x06:
            return "Still Imaging";
        case 0x07:
            return "Printer";
        case 0x08:
            return "Mass Storage";
        case 0x09:
            return "Hub";
        case 0x0A:
            return "CDC-Data";
        case 0x0B:
            return "Smart Card";
        case 0x0D:
            return "Content Security";
        case 0x0E:
            return "Video";
        case 0x0F:
            return "Personal Healthcare";
        case 0xDC:
            return "Diagnostic Device";
        case 0xE0:
            return "Wireless Controller";
        case 0xEF:
            return "Miscellaneous";
        case 0xFE:
            return "Application Specific";
        case 0xFF:
            return "Vendor Specific";
        default:
            return "unknown";
    }
}

int device_get_type(usbhost_device_t *dev)
{
    return dev->desc.bDeviceClass;
}

int device_get_num_interfaces(usbhost_device_t *dev)
{
    return dev->config->desc.bNumInterfaces;
}

usbhost_interface_t *device_get_interface(usbhost_device_t *dev, int interface)
{
    return usbhost_getfunctioninterface(interface, dev);
}

int interface_get_type(usbhost_interface_t *interface)
{
    if (interface != NULL)
    {
        return interface->curIntf->desc.bInterfaceClass;
    }
    return -1;
}

int device_get_manufacturer_id(usbhost_device_t *dev)
{
    return dev->desc.iManufacturer;
}

int device_get_product_id(usbhost_device_t *dev)
{
    return dev->desc.iProduct;
}

int device_get_serial_number_id(usbhost_device_t *dev)
{
    return dev->desc.iSerialNumber;
}
