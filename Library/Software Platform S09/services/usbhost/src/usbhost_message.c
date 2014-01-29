// usbhost_message.c

#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <timing.h>
#include <stdio.h>

#include <usbhost.h>
#include <usbhost_message.h>

#define _SWAP16(A) ((((uint16_t)(A) & 0xFF00) >> 8) | \
(((uint16_t)(A) & 0x00FF) << 8))


static void usbhost_synccompletefunction( usbhost_urb_t *urb)
{
        urb->completeContext = (void *)1;
}


void usbhost_buildgetstatus(uint32_t target, uint32_t idx, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_STANDARD | target;
    cReq->bRequest      = USBHOST_REQ_GET_STATUS;
    cReq->wValue        = 0;
    cReq->wIndex        = _SWAP16(idx);
    cReq->wLength       = _SWAP16(0x02);
}

#define USBHOST_DEFAULT_LANGUAGE_ID 0

void usbhost_buildgetdescriptor(uint32_t descType, uint32_t descIdx, uint32_t len, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_STANDARD | USBHOST_RECIP_DEVICE;
    cReq->bRequest      = USBHOST_REQ_GET_DESCRIPTOR;
    cReq->wValue        = _SWAP16((descType << 8) | descIdx);
    cReq->wIndex        = _SWAP16(USBHOST_DEFAULT_LANGUAGE_ID); // Language ID
    cReq->wLength       = _SWAP16(len);
}


void usbhost_buildsetaddress(uint32_t devAddr, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_STANDARD | USBHOST_RECIP_DEVICE;
    cReq->bRequest      = USBHOST_REQ_SET_ADDRESS;
    cReq->wValue        = _SWAP16(devAddr);
    cReq->wIndex        = 0;
    cReq->wLength       = 0;
}


void usbhost_buildsetconfiguration(uint32_t configIdx, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_STANDARD | USBHOST_RECIP_DEVICE;
    cReq->bRequest      = USBHOST_REQ_SET_CONFIGURATION;
    cReq->wValue        = _SWAP16(configIdx);
    cReq->wIndex        = 0;
    cReq->wLength       = 0;
}


void usbhost_buildsetinterface(uint32_t intf, uint32_t altIntf, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_STANDARD | USBHOST_RECIP_INTERFACE;
    cReq->bRequest      = USBHOST_REQ_SET_INTERFACE;
    cReq->wValue        = _SWAP16(altIntf);
    cReq->wIndex        = _SWAP16(intf);
    cReq->wLength       = 0;
}


void usbhost_buildportfeaturecmd(uint32_t setClear, uint32_t port, uint32_t feature, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = (setClear==USBHOST_FEATURE_CLR)?USBHOST_REQ_CLEAR_FEATURE:USBHOST_REQ_SET_FEATURE;
    cReq->wValue        = _SWAP16(feature);
    cReq->wIndex        = _SWAP16(port);
    cReq->wLength       = 0;
}


void usbhost_buildgetportstatus(uint32_t port, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = USBHOST_REQ_GET_STATUS;
    cReq->wValue        = 0;
    cReq->wIndex        = _SWAP16(port);
    cReq->wLength       = _SWAP16(sizeof(uint32_t));
}


void usbhost_buildresethubtt(uint32_t ttPort, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = USBHOST_HUB_REQ_RESET_TT;
    cReq->wValue        = 0;
    cReq->wIndex        = _SWAP16(ttPort);
    cReq->wLength       = 0;
}


void usbhost_buildclearhubtt(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, uint32_t ttPort, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = USBHOST_HUB_REQ_RESET_TT;
    cReq->wValue        = 0;//_SWAP16(  (USB_EpDirection(ep->desc.bEndpointAddress) << 15) | (USB_EpType(ep->desc.bmAttributes)<<11) | (dev->devNum << 4) | (USB_EpNumber(ep->desc.bEndpointAddress)));
    cReq->wIndex        = _SWAP16(ttPort);
    cReq->wLength       = 0;
}


void usbhost_buildsynccontrolurb(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t bufLen, usbhost_urb_t *urb)
{
    bool input = ((creq->bmRequestType & USBHOST_DIR_IN) == USBHOST_DIR_IN);

    urb->dev               = dev;
    urb->ep                = input ? &dev->ep0IN : &dev->ep0OUT;
    urb->setupPacket       = (uint8_t *)creq;
    urb->xferBuf           = buf;
    urb->xferBufSize       = bufLen;
    urb->completeContext   = 0;
    urb->OnComplete        = &usbhost_synccompletefunction;
}


void usbhost_buildsyncbulkurb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, usbhost_urb_t *urb)
{
    urb->dev               = dev;
    urb->ep                = ep;
    urb->setupPacket       = NULL;
    urb->xferBuf           = buf;
    urb->xferBufSize       = bufLen;
    urb->completeContext   = 0;
    urb->OnComplete        = &usbhost_synccompletefunction;
}


void usbhost_buildasyncbulkurb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, usbhost_urb_t *urb)
{
    urb->dev               = dev;
    urb->ep                = ep;
    urb->setupPacket       = NULL;
    urb->xferBuf           = buf;
    urb->xferBufSize       = bufLen;
    urb->completeContext   = 0;
    urb->OnComplete        = complete ? complete : &usbhost_synccompletefunction;
}



void usbhost_buildsyncinterrupturb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, usbhost_urb_t *urb)
{
    urb->dev               = dev;
    urb->ep                = ep;
    urb->interval          = ep->desc.bInterval * 8;
    urb->setupPacket       = NULL;
    urb->xferBuf           = buf;
    urb->xferBufSize       = bufLen;
    urb->completeContext   = 0;
    urb->OnComplete        = &usbhost_synccompletefunction;
}


void usbhost_buildasyncinterrupturb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, usbhost_urb_t *urb)
{
    urb->dev               = dev;
    urb->ep                = ep;
    urb->interval          = ep->desc.bInterval;
    urb->setupPacket       = NULL;
    urb->xferBuf           = buf;
    urb->xferBufSize       = bufLen;
    urb->completeContext   = 0;
    urb->OnComplete        = complete ? complete : &usbhost_synccompletefunction;
}


int32_t usbhost_docontrolrequest(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t buflen)
{
    usbhost_urb_t   urb;
    int             delay_cnt, err;

    usbhost_initurb(&urb);

    usbhost_buildsynccontrolurb(dev, creq, buf, buflen, &urb);

    err = usbhost_enqueueurb(&urb);
    if (!err)
    {
        delay_cnt = 0;
        while (!urb.completeContext && delay_cnt < 8000)
        {
            delay_us(125);
            delay_cnt++;
            //debugptddump();
        }
        if (delay_cnt >= 8000)
        {
            /* 'timed out' */
            usbhost_dequeueurb(&urb);
        }
        return urb.status;
    }

    return err;
}

int32_t usbhost_dobulktransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen)
{
    int32_t         err;
    usbhost_urb_t   urb;
    volatile int    delay_cnt;

    usbhost_initurb(&urb);

    usbhost_buildsyncbulkurb(dev, ep, buf, buflen, &urb);

    err = usbhost_enqueueurb(&urb);
    if (!err)
    {
        delay_cnt = 0;
        while (!urb.completeContext)
        {
            delay_us(125);
            delay_cnt++;
        }

        return urb.status;
    }

#if DEBUG_USBHOST_MSD
    else
    {
        printf("Error return usbhost_enqueueurb\n");
    }
#endif

    return err;
}

int32_t usbhost_dobulktransfer_timeout(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, int timeout_ms)
{
    int32_t         err;
    usbhost_urb_t   urb;
    volatile int    delay_cnt;
    uint64_t        usec = 125;

    usbhost_initurb(&urb);

    usbhost_buildsyncbulkurb(dev, ep, buf, buflen, &urb);

    err = usbhost_enqueueurb(&urb);
    if (!err)
    {
        delay_cnt = 0;
        while (!urb.completeContext)
        {
            delay_us(usec);
            if (!urb.completeContext && timeout_ms > 0 && usec > timeout_ms * 1000)
            {
                usbhost_dequeueurb(&urb);
                break;
            }
            delay_cnt++;
            usec *= 2;
            //debugptddump();
        }

        return urb.status;
    }
#if DEBUG_USBHOST_MSD
    else
    {
        printf("Error return usbhost_enqueueurb\n");
    }
#endif

    return err;
}


int32_t usbhost_dobulktransferasynccomplete(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, hostusbhost_onurbcomplete_t complete, usbhost_urb_t *urb)
{

    usbhost_initurb(urb);

    usbhost_buildasyncbulkurb(dev, ep, buf, buflen, complete, urb);

    usbhost_enqueueurb(urb);

    return 0;
}


int32_t usbhost_dobulktransferasync(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, usbhost_urb_t *urb)
{

    usbhost_initurb(urb);

    usbhost_buildsyncbulkurb(dev, ep, buf, buflen, urb);

    usbhost_enqueueurb(urb);

    return 0;
}


int32_t usbhost_waitonurbcomplete(usbhost_urb_t *urb, uint32_t timeoutms)
{
    uint32_t reval = -1;

    while(!urb->completeContext && timeoutms--){
        delay_ms(1);
    }
    return timeoutms?urb->status:-ETIME;
}



int32_t usbhost_dointerrupttransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen)
{
    usbhost_urb_t urb;

    usbhost_initurb(&urb);

    usbhost_buildsyncinterrupturb(dev, ep, buf, buflen, &urb);

    usbhost_enqueueurb(&urb);

    while(!urb.completeContext){
        delay_us(125);
        //debugptddump();
    }

    return urb.status;
}

