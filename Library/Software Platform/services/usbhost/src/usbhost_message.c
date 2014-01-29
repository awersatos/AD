// usbhost_message.c
// builds standard types of USB messages
// asynchronous in this context means do not wait on urb completion just call
// the provided completion handler...
#define DEBUG_USBHOST_MSD 0

#include <string.h>
#include <stddef.h>
#include <stdlib.h>
#include <timing.h>
#include <stdio.h>

#include <usbhost.h>
#include <usbhost_message.h>
#include <util_endian.h>

#if __POSIX_KERNEL__
#include <assert.h>
#include <time.h>

static void msec_to_timespec(long msec, struct timespec *pts)
{
    pts->tv_nsec = (msec % 1000) * 1000000;
    pts->tv_sec = msec / 1000;
}

static void usec_to_timespec(long usec, struct timespec *pts)
{
    pts->tv_nsec = (usec % 1000000) * 1000;
    pts->tv_sec = usec / 1000000;
}

static void timespec_add(struct timespec *ret, struct timespec *ts1, struct timespec *ts2)
{
    struct timespec temp;

    temp.tv_nsec = ts1->tv_nsec + ts2->tv_nsec;
    temp.tv_sec = 0;
    while (temp.tv_nsec > 1000000000)
    {
        temp.tv_sec++;
        temp.tv_nsec -= 1000000000;
    }
    ret->tv_sec = temp.tv_sec + ts1->tv_sec + ts2->tv_sec;
    ret->tv_nsec = temp.tv_nsec;
}
#endif

static void usbhost_completefunction( usbhost_urb_t *urb)
{
#if __POSIX_KERNEL__
    int err;

    if (urb->notify == USBHOST_URB_NOTIFY_COND)
    {
#if 0
        err = pthread_mutex_trylock(&urb->mutex);
        if (err == EBUSY)
        {
            /* we are dequeuing due to timeout, no need to signal */
            return;
        }
#else
        err = pthread_mutex_lock(&urb->mutex);
#endif
        assert(!err);
        err = pthread_cond_signal(&urb->cond);
        assert(!err);
        err = pthread_mutex_unlock(&urb->mutex);
        assert(!err);
    }
    else
    {
        urb->completecontext = (void *)1;
    }
#else
    urb->completecontext = (void *)1;
#endif
}


void usbhost_buildgetstatus(uint8_t target, uint16_t idx, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_STANDARD | target;
    cReq->bRequest      = USBHOST_REQ_GET_STATUS;
    cReq->wValue        = 0;
    cReq->wIndex        = little16(idx);
    cReq->wLength       = little16(0x02);
}


void usbhost_buildgetdescriptor(uint8_t descType, uint8_t descIdx, uint16_t langid, uint16_t len, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_STANDARD | USBHOST_RECIP_DEVICE;
    cReq->bRequest      = USBHOST_REQ_GET_DESCRIPTOR;
    cReq->wValue        = little16((descType << 8) | descIdx);
    cReq->wIndex        = little16(langid);
    cReq->wLength       = little16(len);
}


void usbhost_buildsetaddress(uint16_t devAddr, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_STANDARD | USBHOST_RECIP_DEVICE;
    cReq->bRequest      = USBHOST_REQ_SET_ADDRESS;
    cReq->wValue        = little16(devAddr);
    cReq->wIndex        = 0;
    cReq->wLength       = 0;
}


void usbhost_buildsetconfiguration(uint16_t configIdx, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_STANDARD | USBHOST_RECIP_DEVICE;
    cReq->bRequest      = USBHOST_REQ_SET_CONFIGURATION;
    cReq->wValue        = little16(configIdx);
    cReq->wIndex        = 0;
    cReq->wLength       = 0;
}


void usbhost_buildsetinterface(uint16_t intf, uint16_t altIntf, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_STANDARD | USBHOST_RECIP_INTERFACE;
    cReq->bRequest      = USBHOST_REQ_SET_INTERFACE;
    cReq->wValue        = little16(altIntf);
    cReq->wIndex        = little16(intf);
    cReq->wLength       = 0;
}


void usbhost_buildportfeaturecmd(uint8_t setClear, uint16_t port, uint16_t feature, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = (setClear==USBHOST_FEATURE_CLR)?USBHOST_REQ_CLEAR_FEATURE:USBHOST_REQ_SET_FEATURE;
    cReq->wValue        = little16(feature);
    cReq->wIndex        = little16(port);
    cReq->wLength       = 0;
}


void usbhost_buildgetportstatus(uint16_t port, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_IN | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = USBHOST_REQ_GET_STATUS;
    cReq->wValue        = 0;
    cReq->wIndex        = little16(port);
    cReq->wLength       = little16(sizeof(uint32_t));
}


void usbhost_buildresethubtt(uint16_t ttPort, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = USBHOST_HUB_REQ_RESET_TT;
    cReq->wValue        = 0;
    cReq->wIndex        = little16(ttPort);
    cReq->wLength       = 0;
}


void usbhost_buildclearhubtt(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, uint16_t ttPort, usbhost_controlrequest_t *cReq)
{
    cReq->bmRequestType = USBHOST_DIR_OUT | USBHOST_TYPE_CLASS | USBHOST_RECIP_OTHER;
    cReq->bRequest      = USBHOST_HUB_REQ_RESET_TT;
    cReq->wValue        = 0;//little16(  (USB_EpDirection(ep->desc.bEndpointAddress) << 15) | (USB_EpType(ep->desc.bmAttributes)<<11) | (dev->devNum << 4) | (USB_EpNumber(ep->desc.bEndpointAddress)));
    cReq->wIndex        = little16(ttPort);
    cReq->wLength       = 0;
}


void usbhost_buildcontrolurb(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb)
{
    bool input = ((creq->bmRequestType & USBHOST_DIR_IN) == USBHOST_DIR_IN);

    urb->dev               = dev;
    urb->ep                = input ? &dev->ep0IN : &dev->ep0OUT;
    urb->setuppacket       = (uint8_t *)creq;
    urb->xferbuf           = buf;
    urb->xferbufsize       = bufLen;
    urb->completecontext   = completecontext;
    urb->OnComplete        = complete ? complete : &usbhost_completefunction;
}

void usbhost_buildbulkurb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb)
{
    urb->dev               = dev;
    urb->ep                = ep;
    urb->setuppacket       = NULL;
    urb->xferbuf           = buf;
    urb->xferbufsize       = bufLen;
    urb->completecontext   = completecontext;
    urb->OnComplete        = complete ? complete : &usbhost_completefunction;
}


void usbhost_buildinterrupturb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb)
{
    urb->dev               = dev;
    urb->ep                = ep;
    if (dev->speed == USBHOST_SPEED_HIGH)
        urb->interval      = 1 << (ep->desc.bInterval - 1); // polling interval in uframes
    else
        urb->interval      = ep->desc.bInterval;            // polling interval in frames
    urb->setuppacket       = NULL;
    urb->xferbuf           = buf;
    urb->xferbufsize       = bufLen;
    urb->completecontext   = completecontext;
    urb->OnComplete        = complete ? complete : &usbhost_completefunction;
}


void usbhost_buildisourb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb, int32_t npackets, uint32_t packetlen)
{
    urb->dev               = dev;
    urb->ep                = ep;
    if (dev->speed == USBHOST_SPEED_HIGH)
        urb->interval      = 1 << (ep->desc.bInterval - 1); // polling interval in uframes
    else
        urb->interval      = ep->desc.bInterval;            // polling interval in frames
    urb->setuppacket       = NULL;
    urb->xferbuf           = buf;
    urb->xferbufsize       = buflen;
    urb->xferflags         = URB_ISO_ASAP;
    urb->OnComplete        = complete ? complete : &usbhost_completefunction;
    urb->completecontext   = completecontext;
    urb->isoframecount     = npackets;
    for (int32_t i = 0; i < npackets; i++)
    {
        urb->isoframes[i].offset = i * packetlen;
        urb->isoframes[i].len = packetlen;
    }
}


int32_t usbhost_docontrolrequest_timeout(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t buflen, uint32_t timeout)
{
    usbhost_urb_t   urb;
#if __POSIX_KERNEL__
    struct timespec ts, ts_delta, ts_now;
    int err, err2;
#else
    int             delay_cnt, err;
#endif

#if __POSIX_KERNEL__
    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_COND);
#else
    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_POLL);
#endif

    usbhost_buildcontrolurb(dev, creq, buf, buflen, NULL, NULL, &urb);

    err = usbhost_enqueueurb(&urb);
    if (!err)
    {
#if __POSIX_KERNEL__
        if (timeout == 0)
        {
            err = pthread_cond_wait(&urb.cond, &urb.mutex);
            assert(!err);
            err = pthread_mutex_unlock(&urb.mutex);
            assert(!err);
        }
        else
        {
            usec_to_timespec(125 * timeout, &ts_delta);
            clock_gettime(CLOCK_REALTIME, &ts_now);
            timespec_add(&ts, &ts_now, &ts_delta);
            err = pthread_cond_timedwait(&urb.cond, &urb.mutex, &ts);
            if (err == ETIMEDOUT)
            {
                /* 'timed out' */
                // bug in dequeue routine causes double clean which trigger assert
                // usbhost_dequeueurb(&urb);
                urb.status = -ETIMEDOUT;
            }
            err2 = pthread_mutex_unlock(&urb.mutex);
            assert(!err2);
        }
#else
        delay_cnt = 0;
        while (!urb.completecontext && ((timeout == 0) || (delay_cnt < timeout)))
        {
            delay_us(125);
            delay_cnt++;
        }
        if (delay_cnt >= timeout)
        {
            /* 'timed out' */
            usbhost_dequeueurb(&urb);
        }
#endif
        return urb.status;
    }

    return err;
}

int32_t usbhost_docontrolrequest(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t buflen)
{
    return usbhost_docontrolrequest_timeout(dev, creq, buf, buflen, 8000);
}

int32_t usbhost_dobulktransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen)
{
    int32_t         err;
    usbhost_urb_t   urb;
#if !(__POSIX_KERNEL__)
    volatile int    delay_cnt;
#endif

#if __POSIX_KERNEL__
    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_COND);
#else
    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_POLL);
#endif

    usbhost_buildbulkurb(dev, ep, buf, buflen, NULL, NULL, &urb);

    err = usbhost_enqueueurb(&urb);
    if (!err)
    {
#if __POSIX_KERNEL__
        err = pthread_cond_wait(&urb.cond, &urb.mutex);
        assert(!err);
        err = pthread_mutex_unlock(&urb.mutex);
        assert(!err);
#else
        delay_cnt = 0;
        while (!urb.completecontext)
        {
            delay_us(75);
            delay_cnt++;
        }
#endif
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
#if __POSIX_KERNEL__
    int err2;
    struct timespec ts, ts_delta, ts_now;
#else
    volatile int    delay_cnt;
#endif

#if __POSIX_KERNEL__
    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_COND);
#else
    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_POLL);
#endif

    usbhost_buildbulkurb(dev, ep, buf, buflen, NULL, NULL, &urb);

    err = usbhost_enqueueurb(&urb);
    if (!err)
    {
#if __POSIX_KERNEL__
        if (timeout_ms != 0)
        {
            msec_to_timespec(timeout_ms, &ts_delta);
            clock_gettime(CLOCK_REALTIME, &ts_now);
            timespec_add(&ts, &ts_now, &ts_delta);
            err = pthread_cond_timedwait(&urb.cond, &urb.mutex, &ts);
            if (err == ETIMEDOUT)
            {
                // bug in dequeue routine causes double clean which trigger assert
                // usbhost_dequeueurb(&urb);
                urb.status = -ETIMEDOUT;
            }
            err2 = pthread_mutex_unlock(&urb.mutex);
            assert(!err2);
        }
        else
        {
            err = pthread_cond_wait(&urb.cond, &urb.mutex);
            assert(!err);
            err = pthread_mutex_unlock(&urb.mutex);
            assert(!err);
        }
#else
        delay_cnt = 0;
        while (!urb.completecontext)
        {
            if (timeout_ms && delay_cnt > timeout_ms * (1000 / 75))
            {
                usbhost_dequeueurb(&urb);
                break;
            }
            delay_us(75);
            delay_cnt++;
        }
#endif
        return urb.status;
    }
#if DEBUG_USBHOST_MSD
    else
    {
        printf("Error return usbhost_enqueueurb\n");
    }
#endif
#if __POSIX_KERNEL__
    err = pthread_mutex_unlock(&urb.mutex);
    assert(!err);
#endif

    return err;
}


int32_t usbhost_dobulktransferasync(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb)
{

    usbhost_initurb(urb, 0);

    usbhost_buildbulkurb(dev, ep, buf, buflen, complete, NULL, urb);

    usbhost_enqueueurb(urb);

    return 0;
}


int32_t usbhost_waitonurbcomplete(usbhost_urb_t *urb, uint32_t timeout_ms)
{
    int      delay_cnt = 0;
    uint32_t reval = -1;

    while (!urb->completecontext)
    {
        if (timeout_ms && delay_cnt > timeout_ms * (1000 / 75))
        {
            usbhost_dequeueurb(urb);
            return -ETIME;
        }
        delay_us(75);
        delay_cnt++;
    }

    return urb->status;
}



int32_t usbhost_dointerrupttransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen)
{
    usbhost_urb_t urb;
    int err;
#if __POSIX_KERNEL__

    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_COND);
#else
    usbhost_initurb(&urb, USBHOST_URB_NOTIFY_POLL);
#endif

    usbhost_buildinterrupturb(dev, ep, buf, buflen, NULL, NULL, &urb);

    err = usbhost_enqueueurb(&urb);

#if __POSIX_KERNEL__
    if (!err)
    {
        err = pthread_cond_wait(&urb.cond, &urb.mutex);
        assert(!err);
        err = pthread_mutex_unlock(&urb.mutex);
        assert(!err);
    }
#else
    while(!urb.completecontext)
    {
        delay_us(125);
    }
#endif

    return urb.status;
}


int32_t usbhost_doisotransferasync(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, hostusbhost_onurbcomplete_t complete, void *completecontext, int32_t npackets, uint32_t packetlen)
{
    usbhost_urb_t *urb = usbhost_allocurb(npackets);

    if (!urb)
        return -ENOMEM;

    usbhost_buildisourb(dev, ep, buf, buflen, complete, completecontext, urb, npackets, packetlen);

    usbhost_enqueueurb(urb);
    return 0;
}

