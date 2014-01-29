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

// in linux core/config.c -> usb_parse_configuration
int32_t usbhost_hub_enumeratedevice(usbhost_device_t *dev, usbhost_device_t *hub, uint8_t port)
{
    int8_t                            previfnum = -1;
    int32_t                           epnum = -1;
    int32_t                           iad_num = 0;
    int32_t                           retVal;
    uint16_t                          newDevAddr;
    usbhost_controlrequest_t          myControlRequest;
    usbhost_interfacedescriptor_t     *pInterface;
    usbhost_endpointdescriptor_t      *pEndpoint;
    usbhost_configurationdescriptor_t tempconf;
    uint8_t                           *rawdesc;

    usbhost_host_endpoint_t           *newEndpoints = NULL;
    usbhost_host_interface_t          *newHostInterface = NULL;

    dev->parent = hub;
    dev->parentport = port;
    dev->ttport = 1;

    // Get enough of the device descriptor to determine wMaxPacketSize
    usbhost_buildgetdescriptor(USBHOST_DT_DEVICE, 0, 0, 8, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, &dev->desc, 8);

    // Update max packet to actual size
    dev->ep0IN.desc.wMaxPacketSize = little16(dev->desc.bMaxPacketSize);
    dev->ep0OUT.desc.wMaxPacketSize = little16(dev->desc.bMaxPacketSize);

    usbhost_buildgetdescriptor(USBHOST_DT_DEVICE, 0, 0, USBHOST_DEVICE_DESCRIPTOR_SIZE, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, &dev->desc, USBHOST_DEVICE_DESCRIPTOR_SIZE);

    // Get the config descriptor to determine the number of interfaces (bNumInterfaces)
    usbhost_buildgetdescriptor(USBHOST_DT_CONFIG, 0, 0, USBHOST_CONFIGURATION_DESCRIPTOR_SIZE, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, &tempconf, USBHOST_CONFIGURATION_DESCRIPTOR_SIZE);

    dev->config = usbhost_configalloc(tempconf.bNumInterfaces);
    if (!dev->config)
        return -ENOMEM;
    dev->config->nintf = tempconf.bNumInterfaces;

    // Get just the config descriptor to work out total length
    usbhost_buildgetdescriptor(USBHOST_DT_CONFIG, 0, 0, USBHOST_CONFIGURATION_DESCRIPTOR_SIZE, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, &dev->config->desc, USBHOST_CONFIGURATION_DESCRIPTOR_SIZE);

    dev->rawDescLen = little16(dev->config->desc.wTotalLength);
    dev->rawDesc    = (uint8_t *)calloc(dev->rawDescLen, 1);

    // Set device address
    newDevAddr = usbhost_getnextdevicenum(dev->usbhost);
    usbhost_buildsetaddress(newDevAddr, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, 0, 0);
    dev->devNum = newDevAddr;

    // The following may take a while if there is a lot of interfaces
    usbhost_buildgetdescriptor(USBHOST_DT_CONFIG, 0, 0, dev->rawDescLen, &myControlRequest);
    retVal = usbhost_docontrolrequest(dev, &myControlRequest, dev->rawDesc, dev->rawDescLen);

    // Pass 1. determine number of alternate settings.
    rawdesc = dev->rawDesc;
    while (rawdesc < dev->rawDesc + dev->rawDescLen)
    {
        pInterface = (usbhost_interfacedescriptor_t *)rawdesc;
        if(pInterface->bDescriptorType == USBHOST_DT_INTERFACE) // every descriptor has a header with field bDescriptorType
        {
            // we assume the last encountered pInterface->bAlternateSetting is also the highest bAlternateSetting.
            // In that case we can safely set altCount to the last pInterface->bAlternateSetting found.
            dev->config->intf[pInterface->bInterfaceNumber].altCount = pInterface->bAlternateSetting + 1;
        }
        rawdesc += pInterface->bLength;
#if DEBUG_USBHOST
        printf("DT=%d, IN=%d, AS=%d\n",pInterface->bDescriptorType, pInterface->bInterfaceNumber, pInterface->bAlternateSetting + 1);
#endif
    }

    // Pass 2. fill the host interface arrays
    rawdesc = dev->rawDesc;
    pInterface = NULL;
    previfnum = -1;
    while (rawdesc < dev->rawDesc + dev->rawDescLen)
    {
        switch (((usbhost_descriptorheader_t *)rawdesc)->bDescriptorType)
        {
        case USBHOST_DT_INTERFACE_ASSOCIATION:
            if (iad_num < USBHOST_MAXIADS)
                dev->config->intf_assoc[iad_num++] = (usbhost_ifassociationdescriptor_t *)rawdesc;
            break;
        case USBHOST_DT_INTERFACE:
            if (newHostInterface && !newHostInterface[pInterface->bAlternateSetting].extralen) // determine size of extra descrs after previous interface
                newHostInterface[pInterface->bAlternateSetting].extralen = rawdesc - newHostInterface[pInterface->bAlternateSetting].extra;
            pInterface = (usbhost_interfacedescriptor_t *)rawdesc;
            if (pInterface->bInterfaceNumber != previfnum)
            {
                previfnum = pInterface->bInterfaceNumber;
                newHostInterface = usbhost_hostinterfacealloc(dev->config->intf[previfnum].altCount);
            }
            newHostInterface[pInterface->bAlternateSetting].extra = rawdesc + pInterface->bLength;
            newEndpoints = usbhost_endpointalloc(pInterface->bNumEndpoints);
            epnum = 0;
            break;
        case USBHOST_DT_ENDPOINT:
            if (newHostInterface && !newHostInterface[pInterface->bAlternateSetting].extralen) // determine size of extra descrs after previous interface
                newHostInterface[pInterface->bAlternateSetting].extralen = rawdesc - newHostInterface[pInterface->bAlternateSetting].extra;
            pEndpoint = (usbhost_endpointdescriptor_t *)rawdesc;
            usbhost_endpointinit(dev, pEndpoint, 1, &newEndpoints[epnum++]); // init newEndpoints (copy descriptor to it)

#if DEBUG_USBHOST
            switch (USBHOST_EPXFERDIR(pEndpoint->bEndpointAddress))
            {
                case USBHOST_EPXFERDIR_OUT:
                    printf("ep %s OUT %i\n", eptype_to_str(USBHOST_EPXFERTYPE(pEndpoint->bmAttributes)), USBHOST_EPXFERNUMBER(pEndpoint->bEndpointAddress));
                    break;
                default:
                    printf("ep %s IN %i\n", eptype_to_str(USBHOST_EPXFERTYPE(pEndpoint->bmAttributes)), USBHOST_EPXFERNUMBER(pEndpoint->bEndpointAddress));
                    break;
            }
#endif
            break;
        default: ;
        }
        if ((epnum > -1) && (epnum == pInterface->bNumEndpoints))
        {
            usbhost_hostinterfaceinit(pInterface, newEndpoints, &newHostInterface[pInterface->bAlternateSetting]); // add pInterface->desc and newEndpoints to newHostInterface
            if(dev->config->intf[previfnum].altCount == (pInterface->bAlternateSetting + 1))
            {
                usbhost_interfaceinit(dev, &newHostInterface[0], pInterface->bAlternateSetting + 1, newHostInterface,  &dev->config->intf[previfnum]);
            }
            epnum = -1;
        }
        rawdesc += ((usbhost_descriptorheader_t *)rawdesc)->bLength;
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
        printf("DEVICE SPEED UNKNOWN\n");
#endif
        return USBHOST_SPEED_UNKNOWN;
    }
}

