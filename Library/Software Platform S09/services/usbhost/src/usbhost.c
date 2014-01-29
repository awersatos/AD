/**
 * @file
 * USB-Host service
 *
 */

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



/**
 * @brief    Entrypoint
 *
 * This function handles the insertion or removal of USB devices. New
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
    usbhost_registereddriver_t *registereddriver;

    if (!usbhost->drv) return;

    if (usbhost->hub_urb.completeContext)
    {
        uint32_t portStatusMap;
        uint8_t activePort;
        uint32_t activePortStatus;
        usbhost_controlrequest_t myControlRequest;
        int32_t ret;
        usbhost_device_t *myDevice;

        portStatusMap = usbhost->hub_status;

        // Find out what port changed
        activePort = usbhost_hub_getnextportchange(&portStatusMap);
#if DEBUG_USBHOST
        printf("Something happended on port: %i\n", activePort);
#endif

        // Debounce connection
        delay_ms(100);

        // Telling hub to reset the port
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_SET, activePort, USBHOST_PORT_FEAT_RESET, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);

        delay_ms(50);

        // Get port status - brings port out of reset
        usbhost_buildgetportstatus(activePort, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, &activePortStatus, sizeof(activePortStatus));
        activePortStatus = little32(activePortStatus);

#if DEBUG_USBHOST
        printf("Port status=%04X change=%04X\n", activePortStatus & 0xFFFF, activePortStatus >> 16);
#endif

        // Clear connection status and reset status (otherwise next call to find out status of the hub will report that something has changed)
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_CLR, activePort, USBHOST_PORT_FEAT_C_CONNECTION, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_CLR, activePort, USBHOST_PORT_FEAT_C_RESET, &myControlRequest);
        ret = usbhost_docontrolrequest(usbhost->hub, &myControlRequest, 0, 0);

        if (activePortStatus & USBHOST_HUB_PORT_CONNECTED)
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
        }

        // re-commit the URB to monitor new changes on the hub
        usbhost->hub_urb.completeContext = 0;
        delay_ms(20);
        usbhost_enqueueurb(&usbhost->hub_urb);
    }
}


extern uint32_t usbhost_getnextdevicenum(usbhost_t * restrict usbhost)
{
    return usbhost->devicenum++;
}


extern void usbhost_initurb(usbhost_urb_t *urb)
{
    memset(urb, 0, sizeof(usbhost_urb_t));
}

int32_t usbhost_enqueueurb(usbhost_urb_t *urb)
{
    usbhost_t *usbhost = urb->dev->usbhost;

    return usbhost->enqueue_urb(usbhost->drv, urb);
}

int32_t usbhost_dequeueurb(usbhost_urb_t *urb)
{
    usbhost_t *usbhost = urb->dev->usbhost;

    return usbhost->dequeue_urb(usbhost->drv, urb, 0);
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
    usbhost_controlrequest_t cntl_req;
    int32_t ret;
    usbhost_t *usbhost;
    usbhost_cfg_instance_t *usbhost_cfg;

    assert((id >= 0) && (id < USBHOST_INSTANCE_COUNT));

    usbhost = &usbhost_table[id];

    if (usbhost->drv) return usbhost;

    usbhost_cfg = &usbhost_instance_table[id];

    // open lowlevel driver
    usbhost->drv = usbhost->open(usbhost->drv_id);
    usbhost->reset(usbhost->drv);
    usbhost->start(usbhost->drv);

    // Enumerate the "root" hub
    usbhost->devicenum = 2;
    usbhost->hub = usbhost_devicealloc(usbhost, USBHOST_SPEED_HIGH);
    ret = usbhost_hub_enumeratedevice(usbhost->hub, NULL, 0); // TODO errorcheck

    // Turn power on to the ports
    for (uint16_t i = 1; i < 4; i++)
    {
        usbhost_buildportfeaturecmd(USBHOST_FEATURE_SET, i, USBHOST_PORT_FEAT_POWER, &cntl_req);
        ret = usbhost_docontrolrequest(usbhost->hub, &cntl_req, 0, 0);  // TODO errorcheck
    }

    // Wait until something happens on one of the hub ports
    usbhost_initurb(&usbhost->hub_urb);
    usbhost_buildsyncinterrupturb(usbhost->hub, &usbhost->hub->config->intf[0]->curIntf->endpoint[0], &usbhost->hub_status, sizeof(usbhost->hub_status), &usbhost->hub_urb);
    usbhost_enqueueurb(&usbhost->hub_urb);

    return usbhost;
}


