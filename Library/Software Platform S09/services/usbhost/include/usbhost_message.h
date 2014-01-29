/*
 * usbhost_message
 */

#ifndef __USBHOST_MESSAGE_H
#define __USBHOST_MESSAGE_H

#include <usbhost_core.h>

extern int32_t usbhost_dobulktransferasync(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, usbhost_urb_t *urb);
extern int32_t usbhost_waitonurbcomplete(usbhost_urb_t *urb, uint32_t timeOutMs);

extern void usbhost_buildasyncinterrupturb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, usbhost_urb_t *urb);
extern void usbhost_buildasyncbulkurb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, usbhost_urb_t *urb);

extern void usbhost_buildgetstatus(uint32_t target, uint32_t idx, usbhost_controlrequest_t *cReq);

extern void usbhost_buildsetinterface(uint32_t intf, uint32_t altIntf, usbhost_controlrequest_t *cReq);
extern void usbhost_buildgetdescriptor(uint32_t descType, uint32_t descIdx, uint32_t len, usbhost_controlrequest_t *cReq);
extern void usbhost_buildsetaddress(uint32_t devAddr, usbhost_controlrequest_t *cReq);
extern void usbhost_buildsetconfiguration(uint32_t configIdx, usbhost_controlrequest_t *cReq);
extern void usbhost_buildportfeaturecmd(uint32_t setClear, uint32_t port, uint32_t feature, usbhost_controlrequest_t *cReq);
extern void usbhost_buildgetportstatus(uint32_t port, usbhost_controlrequest_t *cReq);
extern void usbhost_buildresethubtt(uint32_t ttPort, usbhost_controlrequest_t *cReq);
extern void usbhost_buildclearhubtt(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, uint32_t ttPort, usbhost_controlrequest_t *cReq);

extern void usbhost_buildsynccontrolurb(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t bufLen, usbhost_urb_t *urb) ;
extern void usbhost_buildsyncbulkurb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, usbhost_urb_t *urb);
extern void usbhost_buildsyncinterrupturb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, usbhost_urb_t *urb);

extern int32_t usbhost_docontrolrequest(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t bufLen);
extern int32_t usbhost_dobulktransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen);
extern int32_t usbhost_dobulktransfer_timeout(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, int timeout_ms);
extern int32_t usbhost_dointerrupttransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen);

#endif /* __USBHOST_MESSAGE_H */

