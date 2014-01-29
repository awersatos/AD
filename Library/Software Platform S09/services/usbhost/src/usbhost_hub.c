/*
 * usbhost_hub.c
 */

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>

#include <util_endian.h>

#include <usbhost_i.h>
#include <usbhost_device.h>
#include <usbhost_message.h>
#include <usbhost_hub.h>

static uint32_t FFS32(uint32_t value)
{
    uint32_t fb;

    value &= -(int32_t)value;
    if (!(value & 0x55555555)) fb = 1; else fb = 0;
    if (!(value & 0x33333333)) fb |= 2;
    if (!(value & 0x0F0F0F0F)) fb |= 4;
    if (!(value & 0x00FF00FF)) fb |= 8;
    if (!(value & 0x0000FFFF)) fb |= 16;

    return fb;
}


#if DEBUG_USBHOST
static char *eptype_to_str(int eptype)
{
    switch(eptype)
    {
        case 0:
            return "Control";
        case 1:
            return "Isochronous";
        case 2:
            return "Bulk";
        case 3:
            return "Interrupt";
        default:
            /* should never get here when using USBHOST_EPTYPE() macro te extract the bits */
            return "<unknown ep type>";
    }
}
#endif

int32_t usbhost_hub_enumeratedevice(usbhost_device_t *dev, usbhost_device_t *hub, uint8_t port)
{
    int32_t                         i, j;
    int32_t                         retVal;
    uint16_t                        newDevAddr;
    usbhost_controlrequest_t            myControlRequest;
    usbhost_configurationdescriptor_t   *pConfig;
    usbhost_interfacedescriptor_t       *pInterface;
    usbhost_endpointdescriptor_t        *pEndpoint;

    usbhost_host_endpoint_t             *newEndpoints;
    usbhost_host_interface_t            *newHostInterface;
    usbhost_interface_t                 *newInterface;

    dev->parent = hub;
    dev->parentport = port;
    dev->ttport = 1;

#if 0
    if (dev->speed == USBHOST_SPEED_HIGH)
    {
        printf("Attempting to do split transaction!\n");
        uint32_t activePortStatus;

        //dev->speed = USBHOST_SPEED_LOW;

        dev->ep0.desc.wMaxPacketSize    = _SWAP16(8);
        //dev->ep0.desc.bEndpointAddress  = 0x00;

        //USB_BuildClearHubTT(dev, &dev->ep0, 1, &myControlRequest);
        //retVal = USBHOST_DoControlRequest(hub, &myControlRequest, 0, 0);

        usbhost_buildgetdescriptor(USB_DT_DEVICE, 0, 8, &myControlRequest);
        retVal = usbhost_docontrolrequest(dev, &myControlRequest, &dev->desc, 8);

        dev->ep0.desc.wMaxPacketSize = _SWAP16(64);
    }
#endif

    // Get enough of the device descriptor to determine wMaxPacketSize
    usbhost_buildgetdescriptor(USBHOST_DT_DEVICE, 0, 8, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, &dev->desc, 8);

    // Update max packet to actual size
    dev->ep0IN.desc.wMaxPacketSize = little16(dev->desc.bMaxPacketSize);
    dev->ep0OUT.desc.wMaxPacketSize = little16(dev->desc.bMaxPacketSize);

    usbhost_buildgetdescriptor(USBHOST_DT_DEVICE, 0, USBHOST_DEVICE_DESCRIPTOR_SIZE, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, &dev->desc, USBHOST_DEVICE_DESCRIPTOR_SIZE);

    dev->config = (usbhost_host_config_t *)calloc(sizeof(usbhost_host_config_t), 1);

    // Get just the config descriptor to work out total length
    usbhost_buildgetdescriptor(USBHOST_DT_CONFIG, 0, USBHOST_CONFIGURATION_DESCRIPTOR_SIZE, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, &dev->config->desc, USBHOST_CONFIGURATION_DESCRIPTOR_SIZE);

    dev->rawDescLen = little16(dev->config->desc.wTotalLength);
    dev->rawDesc    = (uint8_t *)calloc(dev->rawDescLen, 1);

    // Set device address
    newDevAddr = usbhost_getnextdevicenum(dev->usbhost);
    usbhost_buildsetaddress(newDevAddr, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, 0, 0);
    dev->devNum = (uint8_t)newDevAddr;

    usbhost_buildgetdescriptor(USBHOST_DT_CONFIG, 0, dev->rawDescLen, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, dev->rawDesc, dev->rawDescLen);

    pConfig    = (usbhost_configurationdescriptor_t *)(dev->rawDesc);
    pInterface = (usbhost_interfacedescriptor_t *)(pConfig + 1);

    for (i = 0; i < pConfig->bNumInterfaces; i++)
    {
        newEndpoints = usbhost_endpointalloc(pInterface->bNumEndpoints);

        pEndpoint  = (usbhost_endpointdescriptor_t *)(pInterface + 1);

        // At this point pEndpoint may in fact point to a Class descriptor so check type and skip if not type endpoint
        while (pEndpoint->bDescriptorType != USBHOST_DT_ENDPOINT)
        {
            pEndpoint = (usbhost_endpointdescriptor_t *)(((uint8_t *)pEndpoint)+pEndpoint->bLength);
        }

        for (j = 0; j < pInterface->bNumEndpoints; j++)
        {
            // BL[FIXME]: Set according to device speed
            if (!pEndpoint->bInterval)
            {
                pEndpoint->bInterval = 0x0C;
            }

            switch (USBHOST_EPDIRECTION(pEndpoint->bEndpointAddress))
            {
                case USBHOST_XFER_DIR_OUT:
#if DEBUG_USBHOST
                    printf("ep %s OUT %i\n", eptype_to_str(USBHOST_EPTYPE(pEndpoint->bmAttributes)), USBHOST_EPNUMBER(pEndpoint->bEndpointAddress));
#endif
                    break;
                default:
#if DEBUG_USBHOST
                    printf("ep %s IN %i\n", eptype_to_str(USBHOST_EPTYPE(pEndpoint->bmAttributes)), USBHOST_EPNUMBER(pEndpoint->bEndpointAddress));
#endif
					break;
            }

            usbhost_endpointinit(pEndpoint, 1, &newEndpoints[j]);

            pEndpoint++;
        }

        newHostInterface = usbhost_hostinterfacealloc(1);
        usbhost_hostinterfaceinit(pInterface, newEndpoints, newHostInterface);

        // BL[FIXME]: Need to load alternate interface list below instead of hardcoding it to NULL and 0 count
        newInterface = usbhost_interfacealloc(1);
        usbhost_interfaceinit(dev, newHostInterface, 0, NULL,  newInterface);

        dev->config->intf[i] = newInterface;

        pInterface = (usbhost_interfacedescriptor_t*) pEndpoint;
    }

    // BL[FIXME]: Set active configuration - for now we always pick the first one
    usbhost_buildsetconfiguration(1, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, 0, 0);

    if (hub)
    {
        // add device to list of devices for this hub
        dev->nextchild = hub->children;
        hub->children = dev;
    }

    return 0;
}


int32_t usbhost_hub_getnextportchange(uint32_t *hubStatus)
{
    uint32_t hStat = (*hubStatus &= ~1L);
    uint32_t idx;

    if (!hStat) return 0;

    idx = FFS32(hStat);

    hStat &= ~idx;

    *hubStatus = hStat;

    return idx;
}

/*
 * Assumes portStatus is already in host endianess
 */
usbhost_devicespeed_t usbhost_hub_getportspeed(uint32_t portStatus)
{
	if (portStatus & (1<<0))
    {
        if ((portStatus & (1<<10)) && (!(portStatus & (1<<9))))
        {
#if DEBUG_USBHOST
			printf("HIGH SPEED DEVICE\n");
#endif
            return USBHOST_SPEED_HIGH;
        }
        else if ((!(portStatus & (1<<10))) && ((portStatus & (1<<9))))
        {
#if DEBUG_USBHOST
            printf("LOW SPEED DEVICE\n");
#endif
            return USBHOST_SPEED_LOW;
        }
        else
        {
#if DEBUG_USBHOST
            printf("FULL SPEED DEVICE\n");
#endif
            return USBHOST_SPEED_FULL;
        }
    }
    else
    {
#if DEBUG_USBHOST
        printf("NO SPEED DEVICE :)\n");
#endif
        return USBHOST_SPEED_UNKNOWN;
    }
}

