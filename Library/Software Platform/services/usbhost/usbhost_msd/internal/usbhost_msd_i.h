
#include <usbhost_msd_cfg.h>
#include <usbhost_msd_cfg_instance.h>
#include <usbhost_msd_cache.h>
#include <usbhost_core.h>
#include <usbhost_mass_storage.h>

#ifndef _USBHOST_MSD_I_H
#define _USBHOST_MSD_I_H

/* one for the application of for the blockio adaptor */
#define MAX_NUM_CALLBACKS   2


typedef struct usbhost_msd_dev_info_s usbhost_msd_dev_info_t;

/* struct for each connected usb msd device */
struct usbhost_msd_dev_info_s {
    usbhost_urb_t           urb;
    usbhost_device_t        *usbdevice;
    usbhost_msd_device_t    *usbdevicedriver;
    usbhost_msd_info_t      info;
    char                    name[8];        /* must fit sprintf(x->name, "usb%d", USBHOST_MSD_INSTANCE_NUMDEV_MAX) */
    bool                    inuse;
    usbhost_msd_cache_t     *cache;
};

/* usbh msd driver structure */
struct usbhost_msd_s {
    usbhost_t                   *usbhost;
    bool                        automount;
    bool                        use_cache;
    usbhost_msd_callback_proc   callback[MAX_NUM_CALLBACKS];
    void                        *user_data[MAX_NUM_CALLBACKS];
    usbhost_msd_dev_info_t      usbdevices[USBHOST_MSD_INSTANCE_NUMDEV_MAX];
};

#endif /* _USBHOST_MSD_I_H */

