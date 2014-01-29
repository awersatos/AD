/*
 * usbhost_message
 */

#ifndef __USBHOST_MESSAGE_H
#define __USBHOST_MESSAGE_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <usbhost_core.h>

extern int32_t usbhost_waitonurbcomplete(usbhost_urb_t *urb, uint32_t timeOutMs);


extern void usbhost_buildgetstatus(uint8_t target, uint16_t idx, usbhost_controlrequest_t *cReq);

extern void usbhost_buildsetinterface(uint16_t intf, uint16_t altIntf, usbhost_controlrequest_t *cReq);
extern void usbhost_buildgetdescriptor(uint8_t descType, uint8_t descIdx, uint16_t langid, uint16_t len, usbhost_controlrequest_t *cReq);
extern void usbhost_buildsetaddress(uint16_t devAddr, usbhost_controlrequest_t *cReq);
extern void usbhost_buildsetconfiguration(uint16_t configIdx, usbhost_controlrequest_t *cReq);
extern void usbhost_buildportfeaturecmd(uint8_t setClear, uint16_t port, uint16_t feature, usbhost_controlrequest_t *cReq);
extern void usbhost_buildgetportstatus(uint16_t port, usbhost_controlrequest_t *cReq);
extern void usbhost_buildresethubtt(uint16_t ttPort, usbhost_controlrequest_t *cReq);
extern void usbhost_buildclearhubtt(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, uint16_t ttPort, usbhost_controlrequest_t *cReq);

extern void usbhost_buildcontrolurb(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb);
extern void usbhost_buildbulkurb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb);
extern void usbhost_buildinterrupturb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb);
extern void usbhost_buildisourb(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb, int32_t npackets, uint32_t packetlen);

extern int32_t usbhost_dobulktransferasync(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, hostusbhost_onurbcomplete_t complete, void *completecontext, usbhost_urb_t *urb);
extern int32_t usbhost_docontrolrequest(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t bufLen);
extern int32_t usbhost_docontrolrequest_timeout(usbhost_device_t *dev, usbhost_controlrequest_t *creq, void *buf, uint32_t buflen, uint32_t timeout);
extern int32_t usbhost_dobulktransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen);
extern int32_t usbhost_dobulktransfer_timeout(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen, int timeout_ms);
extern int32_t usbhost_dointerrupttransfer(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t bufLen);
extern int32_t usbhost_doisotransferasync(usbhost_device_t *dev, usbhost_host_endpoint_t *ep, void *buf, uint32_t buflen, hostusbhost_onurbcomplete_t complete, void *completecontext, int32_t npackets, uint32_t packetlen);

#ifdef  __cplusplus
}
#endif

#endif /* __USBHOST_MESSAGE_H */
