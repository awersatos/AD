////////////////////////////////////////////////////////////////////////////////
// ioconf.c

#include <sys/bsdtypes.h>
#include <sys/device.h>
#include <dev/usb/usbdevs.h>

#include "BSD_USB_Adaptor.h"

///////////////////////////////////////////////////////////////////////////////
#define BSD_MAX_UHUBCF_COUNT    300
#define BSD_MAX_DEVICE_COUNT    300
#define BSD_MAX_DRIVER_COUNT    10

///////////////////////////////////////////////////////////////////////////////
short cfroots[]    ={ -1 };
struct cfdriver    *cfdriver_list_initial[BSD_MAX_DRIVER_COUNT+1];
struct cfdata       cfdata[BSD_MAX_DEVICE_COUNT+1];
static int          uhubcf_list[BSD_MAX_UHUBCF_COUNT+1][6];

///////////////////////////////////////////////////////////////////////////////
void bsd_device_subsystem_init(void)
{
    uint32_t i;

    memset(cfdriver_list_initial,   0, sizeof(cfdriver_list_initial));
    memset(cfdata,                  0, sizeof(cfdata)               );
    memset(uhubcf_list,            -1, sizeof(uhubcf_list)          );
}

///////////////////////////////////////////////////////////////////////////////
struct cfdriver *Add_BSD_USB_Driver(struct cfdriver *usbd_cfdriver)
{
    int32_t i;

    for(i=0;i<BSD_MAX_DRIVER_COUNT;i++){
        if(cfdriver_list_initial[i] == usbd_cfdriver){
            break;
        }
        if(cfdriver_list_initial[i] == NULL){
            cfdriver_list_initial[i] = usbd_cfdriver;
            break;
        }
    }
    return i<BSD_MAX_DRIVER_COUNT?cfdriver_list_initial[i]:NULL;
}

///////////////////////////////////////////////////////////////////////////////
struct cfdata *Add_BSD_USB_Device(struct cfdata *usbd_cfdata)
{
    int32_t i;

    for(i=0;i<BSD_MAX_DEVICE_COUNT;i++){
            if(memcmp(&cfdata[i], usbd_cfdata, sizeof(struct cfdata))==0){
                break;
            }
            if(cfdata[i].cf_attach == NULL && cfdata[i].cf_driver == NULL){
                memcpy(&cfdata[i], usbd_cfdata, sizeof(struct cfdata));
                break;
            }
        }
    return i<BSD_MAX_DEVICE_COUNT?&cfdata[i]:NULL;
}

///////////////////////////////////////////////////////////////////////////////
int *Add_BSD_USB_UHUBCF(int port, int configuration, int interface, int vendor, int product, int release)
{
    int32_t i,j;
    int uhubcf[6];

    uhubcf[UHUBCF_PORT]             = port;
    uhubcf[UHUBCF_CONFIGURATION]    = configuration;
    uhubcf[UHUBCF_INTERFACE]        = interface;
    uhubcf[UHUBCF_VENDOR]           = vendor;
    uhubcf[UHUBCF_PRODUCT]          = product;
    uhubcf[UHUBCF_RELEASE]          = release;

    for(i=0;i<BSD_MAX_UHUBCF_COUNT;i++){
        if(memcmp(&uhubcf_list[i], uhubcf, sizeof(uhubcf))==0){
            break;
        }

        // Check if we have an empty slot(all fields will be -1)
        for(j=0;j<6;j++){
            if(uhubcf_list[i][j] != -1) break;
        }

        // If we are here then current slot is available
        if(j>=6){
            //printf("Using Slot: %i\n", i);
            memcpy(&uhubcf_list[i][0], uhubcf, sizeof(uhubcf));
            break;
        }

    }
    return i<BSD_MAX_UHUBCF_COUNT?&uhubcf_list[i]:NULL;
}

///////////////////////////////////////////////////////////////////////////////
void usbd_Register_device(int port, int configuration, int interface, int vendor, int product, int release, struct cfattach *cf_attach, struct cfdriver *cf_driver)
{
    struct cfdata   usbd_cfdata;
    int            *usbd_cf_loc;

    memset(&usbd_cfdata,0,sizeof(usbd_cfdata));

    do{
        if(Add_BSD_USB_Driver(cf_driver)==NULL){
            BSD_USB_DPRINTF(("Add_BSD_USB_Driver(): Failed!\n"));
            break;
        }

        if((usbd_cf_loc = Add_BSD_USB_UHUBCF(port, configuration, interface, vendor, product, release))==NULL){
            BSD_USB_DPRINTF(("Add_BSD_USB_UHUBCF(): Failed!\n"));
            break;
        }

        usbd_cfdata.cf_attach   = cf_attach;
        usbd_cfdata.cf_driver   = cf_driver;
        usbd_cfdata.cf_loc      = usbd_cf_loc;

        // Driver handles multiple instances
        usbd_cfdata.cf_fstate   = FSTATE_STAR;

        if(Add_BSD_USB_Device(&usbd_cfdata)==NULL){
            BSD_USB_DPRINTF(("Add_BSD_USB_Device(): Failed!\n"));
            break;
        }

    }while(0);

}


