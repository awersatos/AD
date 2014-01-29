/**
 * @file
 * USB-Host service
 *
 */
#define DEBUG_USBHOST 0

#if __POSIX_KERNEL__
#include <pthread.h>
#endif

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <timing.h>

#include <util_endian.h>

#include <usbhost_i.h>
#include <usbhost_cfg_instance.h>

#include <usbhost_core.h>
#include <usbhost_message.h>
#include <usbhost_device.h>
#include <usbhost_hub.h>

usbhost_t usbhost_table[USBHOST_INSTANCE_COUNT];

static usbhost_registereddriver_t *registereddriver_list = NULL;

/**
 * @brief    Register a device driver
 *
 * Register a USB Host device driver to the USB-Host service. Whenever a
 * new USB device is enumerated, the connect_test function will be called
 * to allow it to test if it can handle the device (in which case the
 * function should return true).
 * Upon disconnect of the device, the disconnect function will be called.
 *
 * @see usbhost_process
 *
 * @param usbhost        Pointer to USB-Host service
 * @param drv            Pointer to driver instance to be registered
 * @param connect_test   Pointer to driver function which tests if a USB device can be handled
 * @param disconnect     Pointer to driver function which handles a disconnect for a USB device
 *
 * @return Pointer to the driver registration
 */

usbhost_registereddriver_t *usbhost_registerdevicedriver(usbhost_t * restrict usbhost, void *drv,
            bool (*connect_test)(void *devicedrv, usbhost_device_t *usbdevice),
            void (*disconnect)(void *devicedrv, usbhost_device_t *usbdevice))
{
    usbhost_registereddriver_t *registereddriver = (usbhost_registereddriver_t *) malloc(sizeof(usbhost_registereddriver_t));

    registereddriver->connect_test = connect_test;
    registereddriver->disconnect = disconnect;
    registereddriver->drv = drv;
    registereddriver->next = registereddriver_list;
    registereddriver->devices = NULL;

    registereddriver_list = registereddriver;

    return registereddriver;
}


typedef struct _usbhost_daemon_inst_t {
    uint32_t    process;
#if __POSIX_KERNEL__
    pthread_t   daemon_thread;
#endif
} usbhost_daemon_inst_t;

#if __POSIX_KERNEL__
pthread_cond_t          usbhost_cond            = PTHREAD_COND_INITIALIZER;
pthread_mutex_t         usbhost_mutex           = PTHREAD_MUTEX_INITIALIZER;
#endif
usbhost_daemon_inst_t   usbhost_daemon_inst;


void usbhost_process_on_complete(usbhost_urb_t *urb)
{
    usbhost_daemon_inst_t   *dinst = urb->completecontext;
#if DEBUG_USBHOST
    printf("usbhost_process_on_complete()\n");
#endif
#if __POSIX_KERNEL__
    pthread_mutex_lock(&usbhost_mutex);
    dinst->process = 1;
    pthread_cond_signal(&usbhost_cond);
    pthread_mutex_unlock(&usbhost_mutex);
#else
    dinst->process = 1;
#endif
}

void *usbhost_daemon_thread(void *data)
{
#if __POSIX_KERNEL__
    int i, err;

    // run forever
    while (1)
    {
        err = pthread_mutex_lock(&usbhost_mutex);
        assert(!err);
        if(!usbhost_daemon_inst.process){
            if (pthread_cond_wait(&usbhost_cond, &usbhost_mutex) != 0)
            {
                usbhost_daemon_inst.daemon_thread = 0;
                err = pthread_mutex_unlock(&usbhost_mutex);
                assert(!err);
                break;
            }
        }
        err = pthread_mutex_unlock(&usbhost_mutex);
        assert(!err);

        // loop through all host instances and process
        for (i = 0; i < USBHOST_INSTANCE_COUNT; i++)
        {
            usbhost_process(&usbhost_table[i]);
        }
    }
#endif
    return NULL;
}

void usbhost_daemon(void)
{
#if __POSIX_KERNEL__
    pthread_attr_t attr;
    struct sched_param sched_param;

    // "There can be only one..."
    if(usbhost_daemon_inst.daemon_thread) return;

    sched_param.sched_priority = POSIX_THREADS_MAIN_PRIORITY + 10;

    pthread_attr_init           (&attr                          );
    pthread_attr_setschedparam  (&attr, &sched_param            );
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED  );
    pthread_attr_setschedpolicy (&attr, SCHED_FIFO              );
#if (__POSIX_THREAD_ATTR_NAME != 0)
    pthread_attr_setname        (&attr, "USB Host"              );
#endif

    if ( pthread_create( &usbhost_daemon_inst.daemon_thread, &attr, usbhost_daemon_thread, (void *)NULL) != 0 ) {
        assert(0);
    }
#if DEBUG_USBHOST
    printf("usbhost_daemon(): Running...\n");
#endif
#endif
}

/**
 * @brief    Entrypoint
 *
 * This function handles the insertion or removal of USB devices and
 * implements the bus enumeration procedure of USB2.0 $9.1.2. New
 * devices will be reported to all registered drivers until one accepts
 * it. Removed devices will be reported to their controlling driver.
 *
 * @see usbhost_registerdevicedriver
 *
 * @param usbhost        Pointer to USB-Host service
 *
 * @return nothing
 */

void usbhost_process(usbhost_t * restrict usbhost)
{
    usbhost_registereddriver_t  *registereddriver;
    usbhost_daemon_inst_t       *dinst = usbhost->hub_urb.completecontext;
#if __POSIX_KERNEL__
    int err;
#endif

    if (!usbhost->drv) return;
#if __POSIX_KERNEL__
    err = pthread_mutex_lock(&usbhost_mutex);
    assert(!err);
#endif

    if (dinst->process)
    {
        uint32_t portStatusMap;
        uint8_t activePort;
        uint32_t activePortStatus;
        usbhost_controlrequest_t myControlRequest;
        int32_t ret;
        usbhost_device_t *myDevice;

        dinst->process = 0;

        portStatusMap = usbhost->hub_status;

        // Find out what port changed
        activePort = (uint8_t)usbhost_hub_getnextportchange(&portStatusMap);
#if DEBUG_USBHOST
        printf("Something happended on port: 0x%x %i\n", portStatusMap, activePort);
#endif

        // Debounce connection
        delay_ms(100);

        // Telling hub to reset the port
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_SET, activePort, USBHOST_PORT_RESET, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);

        delay_ms(50);

        // Get port status - brings port out of reset
        usbhost_buildgetportstatus(activePort, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, &activePortStatus, sizeof(activePortStatus));
        activePortStatus = little32(activePortStatus);

#if DEBUG_USBHOST
        printf("wPortStatus=0x%x(%s), wPortChange=0x%x\n", activePortStatus & 0xFFFF, (activePortStatus & 0x400)? "HS Device" : "Not a HS Device", activePortStatus >> 16);
#endif

        // Clear connection status and reset status (otherwise next call to find out status of the hub will report that something has changed)
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_CLR, activePort, USBHOST_PORT_C_CONNECTION, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_CLR, activePort, USBHOST_PORT_C_ENABLE, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_CLR, activePort, USBHOST_PORT_C_RESET, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);

        if ((activePortStatus & (1 << USBHOST_PORT_CONNECTION)) && !(activePortStatus & (1 << USBHOST_PORT_C_ENABLE)))
        {
            // get device structure etc. and set it up
            myDevice = usbhost_devicealloc(usbhost, usbhost_hub_getportspeed(activePortStatus));
            // Enumerate device, fills in descriptor fields under myDevice
            ret = usbhost_hub_enumeratedevice(myDevice, usbhost->hub, activePort);

            // TODO: support multiple interfaces to multiple drivers

            // find a registered driver which want to control this device
            registereddriver = registereddriver_list;
            while (registereddriver)
            {
                if (registereddriver->connect_test(registereddriver->drv, myDevice)) break;
                registereddriver = registereddriver->next;
            }

            if (registereddriver)
            {
                myDevice->registereddriver = registereddriver;

                // add to list of devices for the driver
                myDevice->nextregistered = registereddriver->devices;
                registereddriver->devices = myDevice;
            }
            else
            {
#if DEBUG_USBHOST
                printf("No devicedriver found\n");
#endif
                usbhost_devicefree(myDevice);
            }
        }
        else
        {
            /* disconnected ? */

            // find which device was connected to this port on the hub
            myDevice = usbhost->hub->children;

            while (myDevice)
            {
                if (myDevice->parentport == activePort) break;
                myDevice = myDevice->nextchild;
            }

            if (myDevice)
            {
                usbhost_device_t *link;

                registereddriver = myDevice->registereddriver;

                if (registereddriver->disconnect)
                {
                    myDevice->registereddriver->disconnect(myDevice->registereddriver->drv, myDevice);
                }

                // remove from list of devices for the driver
                link = registereddriver->devices;
                if (link == myDevice)
                {
                    // device was the head
                    registereddriver->devices = myDevice->nextregistered;
                }
                else
                {
                    while (link)
                    {
                        if (link->nextregistered == myDevice)
                        {
                            // cut device from list
                            link->nextregistered = myDevice->nextregistered;
                            break;
                        }
                        link = link->nextregistered;
                    }
                }

                usbhost_devicefree(myDevice);
            }
            else
            {
#if DEBUG_USBHOST
                printf("Could not find a device to disconnect\n");
#endif
            }
            if (activePortStatus & (1 << USBHOST_PORT_C_ENABLE)) // severe ISP1760 hardware bug...
            {
                // Telling hub to reset the port
                usbhost_buildportfeaturecmd(USBHOST_FEATURE_SET, activePort, USBHOST_PORT_RESET, &myControlRequest);
                usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);
            }
        }

#if __POSIX_KERNEL__
        {
            int err;
            struct timespec ts;
            ts.tv_sec = 0;
            ts.tv_nsec = 20000000;
            err = nanosleep(&ts, NULL);
            assert(!err);
        }
#else
        delay_ms(20);
#endif
        // re-commit the URB to monitor new changes on the hub
        usbhost_enqueueurb(&usbhost->hub_urb);
    }
#if __POSIX_KERNEL__
    err = pthread_mutex_unlock(&usbhost_mutex);
    assert(!err);
#endif
}

inline uint16_t usbhost_getnextdevicenum(usbhost_t * restrict usbhost)
{
    return usbhost->devicenum++;
}

inline usbhost_urb_t *usbhost_allocurb(int iso_packets)
{
    usbhost_urb_t *urb;
    urb = (usbhost_urb_t *)calloc(1, sizeof(usbhost_urb_t) + iso_packets * sizeof(usbhost_isoframedesc_t));
    return urb;
}

void usbhost_initurb(usbhost_urb_t *urb, int notify)
{
    memset(urb, 0, sizeof(usbhost_urb_t));
#if __POSIX_KERNEL__
    if (notify == USBHOST_URB_NOTIFY_COND)
    {
        int err;
        pthread_mutexattr_t attr;

        urb->notify = USBHOST_URB_NOTIFY_COND;
        pthread_mutexattr_init(&attr);

        err = pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK);
        assert(!err);
        err = pthread_mutex_init(&urb->mutex, &attr);
        assert(!err);
        err = pthread_mutexattr_destroy(&attr);
        assert(!err);
        err = pthread_cond_init(&urb->cond, NULL);
        assert(!err);
    }
    else
    {
        urb->notify = USBHOST_URB_NOTIFY_POLL;
    }
#endif
}

inline void usbhost_freeurb(usbhost_urb_t **urb)
{
    if (*urb)
    {
        free (*urb);
        *urb = NULL;
    }
}

int32_t usbhost_enqueueurb(usbhost_urb_t *urb)
{
    usbhost_t *usbhost = urb->dev->usbhost;
#if __POSIX_KERNEL__
    int err, err2;

    if (urb->notify == USBHOST_URB_NOTIFY_COND)
    {
        err = pthread_mutex_lock(&urb->mutex);
        assert(!err);
    }
    err = usbhost->enqueue_urb(usbhost->drv, urb);
    if (err && urb->notify == USBHOST_URB_NOTIFY_COND)
    {
        err2 = pthread_mutex_unlock(&urb->mutex);
        assert(!err2);
    }
    return err;
#else
    return usbhost->enqueue_urb(usbhost->drv, urb);
#endif
}

int32_t usbhost_dequeueurb(usbhost_urb_t *urb)
{
    usbhost_t *usbhost = urb->dev->usbhost;

    return usbhost->dequeue_urb(usbhost->drv, urb);
}

inline int32_t usbhost_abort_endpoint(usbhost_host_endpoint_t *ep)
{
    usbhost_t *usbhost = ep->dev->usbhost;

    return usbhost->abort_endpoint(usbhost->drv, ep);
}

/**
 * @brief Initialize the USB-Host service
 *
 * @param     id         USB-Host service id
 *
 * @return    pointer to the initialized driver structure or NULL on failure.
 */
usbhost_t *usbhost_open(int id)
{
    usbhost_controlrequest_t creq;
    int32_t ret;
    usbhost_t *usbhost;
    const usbhost_cfg_instance_t *usbhost_cfg;
#if __POSIX_KERNEL__
    int err;
#endif

    assert((id >= 0) && (id < USBHOST_INSTANCE_COUNT));

    usbhost = &usbhost_table[id];

#if __POSIX_KERNEL__
    if (usbhost->lock == NULL)
    {
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init(&mutexattr);
        err = pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_ERRORCHECK);
        assert(!err);
        err = pthread_mutex_init(&usbhost->mutex, &mutexattr);
        assert(!err);
        err = pthread_mutexattr_destroy(&mutexattr);
        assert(!err);
        usbhost->lock = &usbhost->mutex;
    }
    err = pthread_mutex_lock(usbhost->lock);
    assert(!err);
#endif

    if (usbhost->drv)
    {
#if __POSIX_KERNEL__
        err = pthread_mutex_unlock(usbhost->lock);
        assert(!err);
#endif
        return usbhost;
    }

    usbhost_cfg = &usbhost_instance_table[id];

    // open lowlevel driver
    usbhost->drv = usbhost->open(usbhost->drv_id);
    // reset and initialize (start) the host controller
    usbhost->reset(usbhost->drv);
    usbhost->start(usbhost->drv);

    usbhost->devicenum = 2;
    // allocate the root hub
    usbhost->hub = usbhost_devicealloc(usbhost, USBHOST_SPEED_HIGH);

    do{
        // Now enumerate the "root" hub (it has no parent and no physical portnumber -> NULL, 0)
        ret = usbhost_hub_enumeratedevice(usbhost->hub, NULL, 0); // TODO errorcheck
    } while(ret != 0);

    // Turn power on to the ports
    for (uint16_t i = 1; i < 4; i++)
    {
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_SET, i, USBHOST_PORT_POWER, &creq);
        ret = usbhost_docontrolrequest(usbhost->hub, &creq, 0, 0);  // TODO errorcheck
    }
#if __POSIX_KERNEL__
    {
        // Init driver lock
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init( &mutexattr );
        pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&usbhost_mutex, &mutexattr);
        pthread_mutexattr_destroy(&mutexattr);
    }
#endif

    // Wait until something happens on one of the hub ports
    usbhost_initurb(&usbhost->hub_urb, USBHOST_URB_NOTIFY_POLL);
    usbhost_buildinterrupturb(usbhost->hub, &usbhost->hub->config->intf[0].curIntf->endpoint[0], &usbhost->hub_status, sizeof(usbhost->hub_status), &usbhost_process_on_complete, &usbhost_daemon_inst, &usbhost->hub_urb);
    usbhost_enqueueurb(&usbhost->hub_urb);

#if __POSIX_KERNEL__
    err = pthread_mutex_unlock(usbhost->lock);
    assert(!err);
#endif
    return usbhost;
}

uint32_t usbhost_get_interrupt(usbhost_t * restrict usbhost)
{
    return usbhost->getinterrupt(usbhost->drv);
}


