////////////////////////////////////////////////////////////////////////////////
// BSD_USB_Adaptor.c

#include <init.h>
#include <assert.h>
#include <interrupts.h>

#include <sysutils.h>
#include <usbhost_message.h>

#include <sys/device.h>

#include "BSD_USB_Adaptor.h"

#ifdef BSD_USB_DEBUG
int bsd_usb_debug_lvl = BSD_USB_DEBUG_LEVEL;
#endif

// Forward dec
void usb_tasks_init(void);

////////////////////////////////////////////////////////////////////////////////
static usbhost_t *BSD_USB_HostDriver        = NULL;
static uint32_t   BSD_USB_HostInterrupt     = -1;

////////////////////////////////////////////////////////////////////////////////
const char * const usbd_error_strs[] = {
    "NORMAL_COMPLETION",
    "IN_PROGRESS",
    "PENDING_REQUESTS",
    "NOT_STARTED",
    "INVAL",
    "NOMEM",
    "CANCELLED",
    "BAD_ADDRESS",
    "IN_USE",
    "NO_ADDR",
    "SET_ADDR_FAILED",
    "NO_POWER",
    "TOO_DEEP",
    "IOERROR",
    "NOT_CONFIGURED",
    "TIMEOUT",
    "SHORT_XFER",
    "STALLED",
    "INTERRUPTED",
    "XXX",
};

////////////////////////////////////////////////////////////////////////////////
void usbd_bulk_transfer_cb(usbd_xfer_handle xfer, usbd_private_handle priv, usbd_status status)
{
    xfer->completecontext = (void *)1;
}

////////////////////////////////////////////////////////////////////////////////
void bsd_usb_internal_init(void)
{
    usbhost_t *usbhostdrv;
#if 0
// BL[FIXME] - This should be set by plugin
    usbhostdrv = usbhost_open(0);

    BSD_USB_HostDriver      = usbhostdrv;
    BSD_USB_HostInterrupt   = usbhost_get_interrupt(BSD_USB_HostDriver);
#endif

    usb_tasks_init();
}

////////////////////////////////////////////////////////////////////////////////
void bsd_usb_init(void)
{
#if __POSIX_KERNEL__
    posix_mainhook_install(bsd_usb_internal_init, 10);
#endif
}


////////////////////////////////////////////////////////////////////////////////
uint32_t splusb(void)
{
    return 0;
}

////////////////////////////////////////////////////////////////////////////////
const unsigned char *usbd_errstr(usbd_status err)
{
    static char buffer[5];

    if ((err >= 0) && (err < USBD_ERROR_MAX))
        return (usbd_error_strs[err]);
    else {
        snprintf(buffer, sizeof(buffer), "%d", err);
        return (buffer);
    }
}

////////////////////////////////////////////////////////////////////////////////
void usbd_delay_ms(usbd_device_handle dev, uint32_t ms)
{
    delay_yield_us(ms * 1000);
}

////////////////////////////////////////////////////////////////////////////////
void usbd_setup_xfer(usbd_xfer_handle xfer, usbd_pipe_handle pipe, usbd_private_handle priv, void *buffer, u_int32_t length, u_int16_t flags, u_int32_t timeout, usbd_callback callback)
{

    xfer->dev               = pipe->dev;
    xfer->status            = USBD_NOT_STARTED;
    xfer->ep                = pipe;
    xfer->completecontext   = priv;
    xfer->xferactual        = 0;
    xfer->xferbufsize       = length;
    xfer->xferbuf           = buffer;
    xfer->xferflags         = flags | URB_BSD_COMPATIBILTY;
    xfer->timeout           = timeout;
    xfer->OnComplete        = callback;

    xfer->interval          = 0;
    xfer->isoerrorcount     = 0;
    xfer->isoframecount     = 0;
}

////////////////////////////////////////////////////////////////////////////////
void usbd_setup_default_xfer(usbd_xfer_handle xfer, usbd_device_handle dev, usbd_private_handle priv, u_int32_t timeout, usb_device_request_t *req, void *buffer, u_int32_t length, u_int16_t flags, usbd_callback callback)
{
    xfer->dev               = dev;

    xfer->ep                = &dev->ep0OUT;
    xfer->completecontext   = priv;
    xfer->xferbuf           = buffer;
    xfer->xferbufsize       = length;
    xfer->xferactual        = 0;
    xfer->xferflags         = flags | URB_BSD_COMPATIBILTY;
    xfer->timeout           = timeout;
    xfer->status            = USBD_NOT_STARTED;
    xfer->OnComplete        = callback;
    xfer->setuppacketdata   = *req;
    xfer->setuppacket       = &xfer->setuppacketdata;

    xfer->interval          = 0;
    xfer->isoerrorcount     = 0;
    xfer->isoframecount     = 0;
}


////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_transfer(usbd_xfer_handle xfer)
{
    return usbhost_enqueueurb(xfer);
}

////////////////////////////////////////////////////////////////////////////////
// Like usbd_transfer(), but waits for completion.
usbd_status usbd_sync_transfer(usbd_xfer_handle xfer)
{
    //xfer->flags |= USBD_SYNCHRONOUS
    xfer->OnComplete        = usbd_bulk_transfer_cb;
    xfer->completecontext   = NULL;
    usbd_transfer(xfer);
    // wait for compeletion
    return usbhost_waitonurbcomplete(xfer, xfer->timeout);
}

////////////////////////////////////////////////////////////////////////////////
usbd_xfer_handle usbd_alloc_xfer(usbd_device_handle dev)
{
    return calloc(1,sizeof(usbhost_urb_t));
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_free_xfer(usbd_xfer_handle xfer)
{
    free(xfer);
    return USBD_NORMAL_COMPLETION;
}

////////////////////////////////////////////////////////////////////////////////
usb_interface_descriptor_t *usbd_get_interface_descriptor(usbd_interface_handle iface)
{
    return &(iface->curIntf->desc);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_do_request(usbd_device_handle dev, usb_device_request_t *req, void *data)
{
    return usbhost_docontrolrequest(dev, req, data, read_little16from16(&req->wLength));
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_set_config(usbd_device_handle dev, u_int16_t conf)
{
    usbhost_controlrequest_t req;
    usbhost_buildsetconfiguration(conf, &req);
    return usbd_do_request(dev, &req, NULL);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_set_config_no(usbd_device_handle dev, u_int16_t no, int msg)
{
    return usbd_set_config(dev, no);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_abort_pipe(usbd_pipe_handle pipe)
{
    return usbhost_abort_endpoint(pipe);
}

////////////////////////////////////////////////////////////////////////////////
usb_endpoint_descriptor_t *usbd_interface2endpoint_descriptor(usbd_interface_handle iface, u_int8_t index)
{
    if (index >= iface->curIntf->desc.bNumEndpoints)
        return (0);
    return &(iface->curIntf->endpoint[index].desc);
}

////////////////////////////////////////////////////////////////////////////////
void usbd_get_xfer_status(usbd_xfer_handle xfer, usbd_private_handle *priv, void **buffer, u_int32_t *count, usbd_status *status)
{
    if (priv != NULL)
        *priv = xfer->completecontext;
    if (buffer != NULL)
        *buffer = xfer->xferbuf;
    if (count != NULL)
        *count = xfer->xferactual;
    if (status != NULL)
        *status = xfer->status;
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_open_pipe(usbd_interface_handle iface, u_int8_t address, u_int8_t flags, usbd_pipe_handle *pipe)
{
    return (usbd_open_pipe_ival(iface, address, flags, pipe, USBD_DEFAULT_INTERVAL));
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_open_pipe_ival(usbd_interface_handle iface, u_int8_t address, u_int8_t flags, usbd_pipe_handle *pipe, int ival)
{
    usbd_pipe_handle p;
    usbhost_host_endpoint_t *ep;
    usbd_status err;
    int i;

    for (i = 0; i < iface->curIntf->desc.bNumEndpoints; i++) {
        ep = &iface->curIntf->endpoint[i];
        if ((ep->desc.bEndpointAddress) == address)
            goto found;
    }
    return (USBD_BAD_ADDRESS);

found:
    if ((flags & USBD_EXCLUSIVE_USE) && ep->refcnt != 0) return (USBD_IN_USE);
    *pipe = ep;
    return (USBD_NORMAL_COMPLETION);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_close_pipe(usbd_pipe_handle pipe)
{
    return (USBD_NORMAL_COMPLETION);
}

////////////////////////////////////////////////////////////////////////////////
void *usbd_alloc_buffer(usbd_xfer_handle xfer, u_int32_t size)
{
    xfer->xferbuf = calloc(size, 1);
    return xfer->xferbuf;
}

////////////////////////////////////////////////////////////////////////////////
void usbd_free_buffer(usbd_xfer_handle xfer)
{
    free(xfer->xferbuf);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_device2interface_handle(usbd_device_handle dev, u_int8_t ifaceno, usbd_interface_handle *iface)
{
    if (dev->rawDesc == NULL)
        return (USBD_NOT_CONFIGURED);
    if (ifaceno >= dev->config->desc.bNumInterfaces)
        return (USBD_INVAL);
    *iface = &dev->config->intf[ifaceno];
    return (USBD_NORMAL_COMPLETION);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_clear_endpoint_stall_async(usbd_pipe_handle pipe)
{
    usbd_device_handle dev = pipe->dev;
    usb_device_request_t req;
    usbd_status err;

    // pipe->methods->cleartoggle(pipe);

    req.bmRequestType = UT_WRITE_ENDPOINT;
    req.bRequest = UR_CLEAR_FEATURE;
    USETW(req.wValue, UF_ENDPOINT_HALT);
    USETW(req.wIndex, pipe->desc.bEndpointAddress);
    USETW(req.wLength, 0);
    err = usbd_do_request_async(dev, &req, 0);
    return (err);
}

////////////////////////////////////////////////////////////////////////////////
void usbd_do_request_async_cb(usbd_xfer_handle xfer, usbd_private_handle priv, usbd_status status)
{
    usbd_free_xfer(xfer);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_do_request_async(usbd_device_handle dev, usb_device_request_t *req, void *data)
{
    usbd_xfer_handle xfer;
    usbd_status err;

    xfer = usbd_alloc_xfer(dev);
    if (xfer == NULL)
        return (USBD_NOMEM);
    usbd_setup_default_xfer(xfer, dev, 0, USBD_DEFAULT_TIMEOUT, req, data, UGETW(req->wLength), 0, usbd_do_request_async_cb);
    err = usbd_transfer(xfer);
    if (err != USBD_IN_PROGRESS) {
        usbd_free_xfer(xfer);
        return (err);
    }
    return (USBD_NORMAL_COMPLETION);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_bulk_transfer(usbd_xfer_handle xfer, usbd_pipe_handle pipe,
    u_int16_t flags, u_int32_t timeout, void *buf, u_int32_t *size, char *lbl)
{
    usbd_status err;
    int s, error;

    usbd_setup_xfer(xfer, pipe, 0, buf, *size, flags, timeout, usbd_bulk_transfer_cb);

    DPRINTFN(1, ("usbd_bulk_transfer: start transfer %d bytes\n", *size));
    err = usbd_transfer(xfer);

    if (err && err != USBD_IN_PROGRESS) {
        return (err);
    }

    error = usbhost_waitonurbcomplete(xfer, timeout);

    if (error) {
        DPRINTF(("usbd_bulk_transfer: usbhost_waitonurbcomplete=%d\n", error));
        usbd_abort_pipe(pipe);
        return (USBD_INTERRUPTED);
    }
    usbd_get_xfer_status(xfer, NULL, NULL, size, &err);

    DPRINTFN(1,("usbd_bulk_transfer: transferred %d\n", *size));

    if (err) {
        DPRINTF(("usbd_bulk_transfer: error=%d\n", err));
        usbd_clear_endpoint_stall(pipe);
    }
    return (err);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_open_pipe_intr(usbd_interface_handle iface, u_int8_t address,
    u_int8_t flags, usbd_pipe_handle *pipe, usbd_private_handle priv,
    void *buffer, u_int32_t len, usbd_callback cb, int ival)
{
    usbd_status err;
    usbd_xfer_handle xfer;
    usbd_pipe_handle ipipe;

    DPRINTFN(3,("usbd_open_pipe_intr: address=0x%x flags=0x%x len=%d\n", address, flags, len));

    err = usbd_open_pipe_ival(iface, address, USBD_EXCLUSIVE_USE, &ipipe, ival);
    if (err)
        return (err);
    xfer = usbd_alloc_xfer(iface->dev);
    if (xfer == NULL) {
        err = USBD_NOMEM;
        goto bad1;
    }
    usbd_setup_xfer(xfer, ipipe, priv, buffer, len, flags, USBD_NO_TIMEOUT, cb);

    if (iface->dev->speed == USBHOST_SPEED_HIGH)
        xfer->interval      = 1 << ((*pipe)->desc.bInterval - 1); // polling interval in uframes
    else
        xfer->interval      = (*pipe)->desc.bInterval;            // polling interval in frames

    err = usbd_transfer(xfer);
    *pipe = ipipe;
    if (err && err != USBD_IN_PROGRESS)
        goto bad2;
    return (USBD_NORMAL_COMPLETION);

 bad2:
    usbd_free_xfer(xfer);
 bad1:
    usbd_close_pipe(ipipe);
    return (err);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_clear_endpoint_stall(usbd_pipe_handle pipe)
{
    usbd_device_handle dev = pipe->dev;
    usb_device_request_t req;
    usbd_status err;

    DPRINTFN(8, ("usbd_clear_endpoint_stall\n"));

    /*
     * Clearing en endpoint stall resets the endpoint toggle, so
     * do the same to the HC toggle.
     */
    pipe->toggle = 0;

    req.bmRequestType = UT_WRITE_ENDPOINT;
    req.bRequest = UR_CLEAR_FEATURE;
    USETW(req.wValue, UF_ENDPOINT_HALT);
    USETW(req.wIndex, pipe->desc.bEndpointAddress);
    USETW(req.wLength, 0);
    err = usbd_do_request(dev, &req, 0);

    return (err);
}

////////////////////////////////////////////////////////////////////////////////
usb_endpoint_descriptor_t *usbd_get_endpoint_descriptor(usbd_interface_handle iface, u_int8_t address)
{
    usbhost_host_endpoint_t *ep;
    int i;

    for (i = 0; i < iface->curIntf->desc.bNumEndpoints; i++) {
        ep = &iface->curIntf->endpoint[i];
        if (ep->desc.bEndpointAddress == address)
            return (&iface->curIntf->endpoint[i].desc);
    }
    return (0);
}


////////////////////////////////////////////////////////////////////////////////
int
usbd_print(void *aux, const char *pnp)
{
    BSD_USB_DPRINTF(("USB Device Driver Not Found!"));
    return (UNCONF);
}

////////////////////////////////////////////////////////////////////////////////
int usbd_submatch(struct device *parent, void *match, void *aux)
{
    struct cfdata *cf = match;
    struct usb_attach_arg *uaa = aux;

#if 0
    BSD_USB_DPRINTFN(1,("usbd_submatch\nport=%d,%d\nconfigno=%d,%d\n"
        "ifaceno=%d,%d\nvendor=0x%x,0x%x\nproduct=0x%x,0x%x\nrelease=%d,%d\n",
        uaa->port, cf->uhubcf_port,
        uaa->configno, cf->uhubcf_configuration,
        uaa->ifaceno, cf->uhubcf_interface,
        uaa->vendor, cf->uhubcf_vendor,
        uaa->product, cf->uhubcf_product,
        uaa->release, cf->uhubcf_release));
#endif


    if (uaa->port != 0 &&   /* root hub has port 0, it should match */
        ((uaa->port != 0 && cf->uhubcf_port != UHUB_UNK_PORT && cf->uhubcf_port != uaa->port) ||
         (uaa->configno != UHUB_UNK_CONFIGURATION && cf->uhubcf_configuration != UHUB_UNK_CONFIGURATION && cf->uhubcf_configuration != uaa->configno) ||
         (uaa->ifaceno != UHUB_UNK_INTERFACE && cf->uhubcf_interface != UHUB_UNK_INTERFACE && cf->uhubcf_interface != uaa->ifaceno) ||
         (uaa->vendor != UHUB_UNK_VENDOR && cf->uhubcf_vendor != UHUB_UNK_VENDOR && cf->uhubcf_vendor != uaa->vendor) ||
         (uaa->product != UHUB_UNK_PRODUCT && cf->uhubcf_product != UHUB_UNK_PRODUCT && cf->uhubcf_product != uaa->product) ||
         (uaa->release != UHUB_UNK_RELEASE && cf->uhubcf_release != UHUB_UNK_RELEASE && cf->uhubcf_release != uaa->release)
         )
       ){
        return 0;
    }
    if (cf->uhubcf_vendor != UHUB_UNK_VENDOR &&
        cf->uhubcf_vendor == uaa->vendor &&
        cf->uhubcf_product != UHUB_UNK_PRODUCT &&
        cf->uhubcf_product == uaa->product) {
        /* We have a vendor&product locator match */
        if (cf->uhubcf_release != UHUB_UNK_RELEASE &&
            cf->uhubcf_release == uaa->release)
            uaa->matchlvl = UMATCH_VENDOR_PRODUCT_REV;
        else
            uaa->matchlvl = UMATCH_VENDOR_PRODUCT;
    } else {
        uaa->matchlvl = 0;
    }

    return ((*cf->cf_attach->ca_match)(parent, cf, aux));
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_set_config_index(usbd_device_handle dev, int index, int msg)
{
    usbhost_controlrequest_t myControlRequest;
    // BSD asks for 0 based index whilst request is 1 based index
    usbhost_buildsetconfiguration(index + 1, &myControlRequest);
    return usbhost_docontrolrequest(dev, &myControlRequest, 0, 0);
}

////////////////////////////////////////////////////////////////////////////////
usbd_status usbd_probe_and_attach(struct device *parent, usbd_device_handle dev, int port, int addr)
{
    struct usb_attach_arg uaa;
    usbhost_devicedescriptor_t *dd = &dev->desc;
    int found, i, confi, nifaces, len;
    usbd_status err;
    struct device *dv;
    usbd_interface_handle *ifaces;

    // BL[IMPL]
    //extern struct rwlock usbpalock;
    //rw_enter_write(&usbpalock);

    uaa.device          = dev;
    uaa.iface           = NULL;
    uaa.ifaces          = NULL;
    uaa.nifaces         = 0;
    uaa.usegeneric      = 0;
    uaa.port            = port;
    uaa.configno        = UHUB_UNK_CONFIGURATION;
    uaa.ifaceno         = UHUB_UNK_INTERFACE;
    uaa.vendor          = UGETW(dd->idVendor);
    uaa.product         = UGETW(dd->idProduct);
    uaa.release         = UGETW(dd->bcdDevice);

    /* First try with device specific drivers. */
    BSD_USB_DPRINTF(("usbd_probe_and_attach trying device specific drivers\n"));
    dv = config_found_sm(parent, &uaa, usbd_print, usbd_submatch);
    if (dv) {
        //dev->subdevs = malloc(2 * sizeof dv, M_USB, M_NOWAIT);
        dev->subdevs = malloc(2 * sizeof(dv));
        if (dev->subdevs == NULL) {
            err = USBD_NOMEM;
            goto fail;
        }
        dev->subdevs[0] = dv;
        dev->subdevs[1] = 0;
        err = USBD_NORMAL_COMPLETION;
        goto fail;
    }

    BSD_USB_DPRINTF(("usbd_probe_and_attach: no device specific driver found\n"));

    BSD_USB_DPRINTF(("usbd_probe_and_attach: looping over %d configurations\n", dd->bNumConfigurations));
    /* Next try with interface drivers. */
    for (confi = 0; confi < dd->bNumConfigurations; confi++) {
        BSD_USB_DPRINTFN(1,("usbd_probe_and_attach: trying config idx=%d\n", confi));
        err = usbd_set_config_index(dev, confi, 1);
        if (err) {
#ifdef USB_DEBUG
            BSD_USB_DPRINTF(("%s: port %d, set config at addr %d failed, "
                 "error=%s\n", parent->dv_xname, port,
                 addr, usbd_errstr(err)));
#else
            BSD_USB_DPRINTF(("%s: port %d, set config at addr %d failed\n", parent->dv_xname, port, addr));
#endif

            goto fail;
        }
        nifaces = dev->config->desc.bNumInterfaces;
        uaa.configno = dev->config->desc.bConfigurationValue;
        //ifaces = malloc(nifaces * sizeof(usbd_interface_handle), M_USB, M_NOWAIT);
        ifaces = malloc(nifaces * sizeof(usbd_interface_handle));
        if (ifaces == NULL) {
            err = USBD_NOMEM;
            goto fail;
        }
        for (i = 0; i < nifaces; i++)
            ifaces[i] = &dev->config->intf[i];
        uaa.ifaces = ifaces;
        uaa.nifaces = nifaces;
        len = (nifaces+1) * sizeof(dv);
        //dev->subdevs = malloc(len, M_USB, M_NOWAIT | M_ZERO);
        dev->subdevs = calloc(1, len);
        if (dev->subdevs == NULL) {
            //free(ifaces, M_USB);
            free(ifaces);
            err = USBD_NOMEM;
            goto fail;
        }

        found = 0;
        for (i = 0; i < nifaces; i++) {
            if (ifaces[i] == NULL)
                continue; /* interface already claimed */
            uaa.iface = ifaces[i];
            uaa.ifaceno = ifaces[i]->curIntf->desc.bInterfaceNumber;
            dv = config_found_sm(parent, &uaa, usbd_print, usbd_submatch);

            if (dv != NULL) {
                dev->subdevs[found++] = dv;
                ifaces[i] = NULL; /* consumed */
            }
        }
        //free(ifaces, M_USB);
        free(ifaces);
        if (found != 0) {
            err = USBD_NORMAL_COMPLETION;
            goto fail;
        }
        //free(dev->subdevs, M_USB);
        free(dev->subdevs);
        dev->subdevs = 0;
    }
    /* No interfaces were attached in any of the configurations. */

    if (dd->bNumConfigurations > 1) /* don't change if only 1 config */
        usbd_set_config_index(dev, 0, 0);

    BSD_USB_DPRINTF(("usbd_probe_and_attach: no interface drivers found\n"));

    /* Finally try the generic driver. */
    uaa.iface = NULL;
    uaa.usegeneric = 1;
    uaa.configno = UHUB_UNK_CONFIGURATION;
    uaa.ifaceno = UHUB_UNK_INTERFACE;
    dv = config_found_sm(parent, &uaa, usbd_print, usbd_submatch);
    if (dv != NULL) {
        //dev->subdevs = malloc(2 * sizeof dv, M_USB, M_NOWAIT);
        dev->subdevs = malloc(2 * sizeof dv);
        if (dev->subdevs == 0) {
            err = USBD_NOMEM;
            goto fail;
        }
        dev->subdevs[0] = dv;
        dev->subdevs[1] = 0;
        err = USBD_NORMAL_COMPLETION;
        goto fail;
    }

    /*
     * The generic attach failed, but leave the device as it is.
     * We just did not find any drivers, that's all.  The device is
     * fully operational and not harming anyone.
     */
    BSD_USB_DPRINTF(("usbd_probe_and_attach: generic attach failed\n"));
    //err = USBD_NORMAL_COMPLETION;
    err = USBD_NOT_CONFIGURED;
fail:
    //rw_exit_write(&usbpalock);
    return (err);
}

////////////////////////////////////////////////////////////////////////////////
/*
 * Search for a vendor/product pair in an array.  The item size is
 * given as an argument.
 */
const struct usb_devno *usb_match_device(const struct usb_devno *tbl, u_int nentries, u_int sz,
    u_int16_t vendor, u_int16_t product)
{
    while (nentries-- > 0) {
        u_int16_t tproduct = tbl->ud_product;
        if (tbl->ud_vendor == vendor &&
            (tproduct == product || tproduct == USB_PRODUCT_ANY))
            return (tbl);
        tbl = (const struct usb_devno *)((const char *)tbl + sz);
    }
    return (NULL);
}


////////////////////////////////////////////////////////////////////////////////
// USB TASK STUFF
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
pthread_cond_t  USBTASK_Cond         = PTHREAD_COND_INITIALIZER;
pthread_mutex_t USBTASK_list_mutex   = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t USBTASK_func_mutex   = PTHREAD_MUTEX_INITIALIZER;

////////////////////////////////////////////////////////////////////////////////
TAILQ_HEAD(, usb_task) usb_all_tasks;

////////////////////////////////////////////////////////////////////////////////
uint32_t taskThreadId;

////////////////////////////////////////////////////////////////////////////////
//
// Add a task to be performed by the task thread.  This function can be
// called from any context and the task will be executed in a process
// context ASAP.
//
////////////////////////////////////////////////////////////////////////////////
void usb_add_task(usbd_device_handle dev, struct usb_task *task)
{

    pthread_mutex_lock(&USBTASK_list_mutex);
        if (!task->onqueue) {
            //DPRINTFN(2,("usb_add_task: task=%p\n", task));
            //TAILQ_INSERT_HEAD(&usb_all_tasks, task, next);
            TAILQ_INSERT_TAIL(&usb_all_tasks, task, next);
            task->onqueue = 1;
        } else {
            BSD_USB_DPRINTFN(15,("usb_add_task: task=%p already on q\n", task));
        }
        pthread_cond_signal(&USBTASK_Cond);

    pthread_mutex_unlock(&USBTASK_list_mutex);

 }

////////////////////////////////////////////////////////////////////////////////
void usb_rem_task(usbd_device_handle dev, struct usb_task *task)
{
    pthread_mutex_lock(&USBTASK_list_mutex);
        if (task->onqueue) {
            BSD_USB_DPRINTFN(2,("usb_rem_task: task=%p\n", task));
            TAILQ_REMOVE(&usb_all_tasks, task, next);
            task->onqueue = 0;
        }
    pthread_mutex_unlock(&USBTASK_list_mutex);
}

////////////////////////////////////////////////////////////////////////////////
// arg = NULL
void* usb_task_thread(void *arg)
{
    struct usb_task *task;
    void (*task_func)(void *);
    void *task_arg;

    while(1){

        pthread_mutex_lock(&USBTASK_list_mutex);

            while((task = TAILQ_FIRST(&usb_all_tasks)) == NULL){
                pthread_cond_wait(&USBTASK_Cond, &USBTASK_list_mutex);
            }

            do {
                if (((task)->next.tqe_next) != ((void *) 0))
                    (task)->next.tqe_next->next.tqe_prev = (task)->next.tqe_prev;
                else
                    (&usb_all_tasks)->tqh_last = (task)->next.tqe_prev;
                *(task)->next.tqe_prev = (task)->next.tqe_next;

            } while (0);


                task->onqueue = 0;
                if(task->fun){
                    task_func = task->fun;
                    task_arg = task->arg;
                    pthread_mutex_unlock(&USBTASK_list_mutex);
                    BSD_USB_DPRINTFN(2,("usb_task_thread: task=%p\n", task));
                    task_func(task_arg);
                    continue;
                } else {
                    BSD_USB_DPRINTF(("usb_task_thread(): Invalid task!/n"));
                    assert(0);
                }

        pthread_mutex_unlock(&USBTASK_list_mutex);

    }

    return NULL;
}

////////////////////////////////////////////////////////////////////////////////
void usb_tasks_init(void)
{
    pthread_attr_t attr;
    struct sched_param sched_param;

    TAILQ_INIT(&usb_all_tasks);

    sched_param.sched_priority = POSIX_THREADS_MAIN_PRIORITY + 25;

    pthread_attr_init           (&attr                          );
    pthread_attr_setschedparam  (&attr, &sched_param            );
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED  );
    pthread_attr_setschedpolicy (&attr, SCHED_FIFO              );
#if (__POSIX_THREAD_ATTR_NAME != 0)
    pthread_attr_setname        (&attr, "USB_TASK"              );
#endif

    if ( pthread_create( &taskThreadId, &attr, usb_task_thread, (void *)NULL) != 0 ) {
        assert(0);
    }

    // This allows the thread to init
    posix_thread_yield();

}

////////////////////////////////////////////////////////////////////////////////
void usb_task_func_lock(void)
{
    pthread_mutex_lock(&USBTASK_func_mutex);
}

////////////////////////////////////////////////////////////////////////////////
void usb_task_func_unlock(void)
{
    pthread_mutex_unlock(&USBTASK_func_mutex);
}












