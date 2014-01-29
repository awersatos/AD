/**
 * @file
 *  USB Host Mass Storage Device service
 *
 */

#include <assert.h>
#include <stdio.h>
#include <string.h>

#include <usbhost_msd.h>
#include <usbhost_msd_i.h>
#include <usbhost_msd_print.h>
#include <usbhost_msd_cfg_instance.h>

#include <usbhost.h>
#include <usbhost_device.h>
#include <usbhost_message.h>
#include <usbhost_mass_storage.h>
#include <usbhost_msd_cache.h>
#include <usbhost_msd_direct.h>

#include <util_endian.h>
#include <timing.h>


static usbhost_msd_t usbhost_msd_driver_table[USBHOST_MSD_INSTANCE_COUNT];

static usbhost_msd_dev_info_t *get_free_dev(usbhost_msd_t *drv)
{
    int i;

    for (i = 0; i < USBHOST_MSD_INSTANCE_NUMDEV_MAX; i++)
    {
        if (drv->usbdevices[i].inuse == false)
        {
            drv->usbdevices[i].inuse = true;
            return &drv->usbdevices[i];
        }
    }
    return NULL;
}


static usbhost_msd_dev_info_t *find_device(usbhost_msd_t *drv, usbhost_device_t *usbdevice)
{
    for (int i = 0; i < USBHOST_MSD_INSTANCE_NUMDEV_MAX; i++)
    {
        if (drv->usbdevices[i].inuse)
        {
            if (drv->usbdevices[i].usbdevice == usbdevice)
            {
                return &drv->usbdevices[i];
            }
        }
    }
    return NULL;
}

static int dev_info_to_sid(usbhost_msd_t *drv, usbhost_msd_dev_info_t *dev_info)
{
    int i;

    for (i = 0; i < USBHOST_MSD_INSTANCE_NUMDEV_MAX; i++)
    {
        if (&drv->usbdevices[i] == dev_info)
        {
            return i;
        }
    }

    return -1;
}

/*
 * test new USB device for MSD
 */
static bool usbhost_msd_connect_test(void *devicedrv, usbhost_device_t *usbdevice)
{
    usbhost_msd_dev_info_t  *dev_info;
    usbhost_msd_t           *drv = (usbhost_msd_t *) devicedrv;
    int                     err;

    // verify if we are a driver for this device
    if (usbdevice->desc.bDeviceClass)
    {
        if (usbdevice->desc.bDeviceClass != USBHOST_BC_MASS_STORAGE) return false;
    }
    else
    {
        if (usbdevice->config->intf[0]->curIntf->desc.bInterfaceClass != USBHOST_BC_MASS_STORAGE) return false;
    }

    dev_info = get_free_dev(drv);
    if (dev_info == NULL)
    {
        /* table full, ignore it */
        return false;
    }

    /* store new device in free spot */
    dev_info->usbdevice = usbdevice;

    /*
     * Copy stuff from main here
     */
#if DEBUG_USBHOST_MSD
    printf("usbhost msd detected\n");
#endif
    dev_info->usbdevicedriver = usbhost_msd_get_instance(usbhost_getfunctioninterface(0, usbdevice));

    /* select interface ?? */


    err = usbhost_msd_get_max_lun(dev_info->usbdevicedriver);
#if DEBUG_USBHOST_MSD
    printf("usbhost_msd_get_max_lun(): %i\n", err);
#endif
    if (err)
    {
        // This function call is used to "start" some MSDs so it *must* be here,
        //      however, dont fail if its not supported
        //return false;
    }

#if 0
    /* new device, send reset */
    err = usbhost_msd_reset(dev_info->usbdevicedriver);
    printf("usbhost_msd_reset(): %i\n", err);
#endif

#if 0
    err = usbhost_msd_report_luns(dev_info->usbdevicedriver);
    printf("usbhost_msd_report_luns(): %i\n", err);
#endif

    __nop();

    err = usbhost_msd_inquiry(dev_info->usbdevicedriver);
#if DEBUG_USBHOST_MSD
    printf("usbhost_msd_inquiry(): %i\n", err);
#endif
    if (err)
    {
        return false;
    }

    __nop();

    err = usbhost_msd_test_unit_ready(dev_info->usbdevicedriver);
#if DEBUG_USBHOST_MSD
    printf("usbhost_msd_test_unit_ready(): %i\n", err);
#endif
    if (err)
    {
        uint8_t data[512];
        scsi_sense_response_t *response;
        bool not_ready = true;
        do
        {
            err = usbhost_msd_request_sense(dev_info->usbdevicedriver, data, sizeof(scsi_sense_response_t));
            if (err)
            {
                return err;
            }
            response = (scsi_sense_response_t *)data;
            if (response->additional_sense_lenght > sizeof(scsi_sense_response_t) - 7)
            {
                err = usbhost_msd_request_sense(dev_info->usbdevicedriver, (uint8_t *)data, response->additional_sense_lenght + 7);
                if (err)
                {
                    return err;
                }
            }
#if DEBUG_USBHOST_MSD
            usbhost_msd_print_sense_response(stdout, response);
#endif
            /* unit attention is returned by some stick after initial reset */
            if (response->valid && (response->sense_key == SCSI_SENSE_KEY_NOT_READY || response->sense_key == SCSI_SENSE_KEY_UNIT_ATTENTION))
            {
                err = usbhost_msd_test_unit_ready(dev_info->usbdevicedriver);
#if DEBUG_USBHOST_MSD
                printf("usbhost_msd_test_unit_ready(): %i\n", err);
#endif
                if (err == 0)
                {
                    not_ready = false;
                }
            }
            else
            {
                not_ready = false;
            }
        } while (not_ready);
    }

    /* read capacity */
    err = usbhost_msd_read_capacity(dev_info->usbdevicedriver, &dev_info->info.blkcount, &dev_info->info.blksize);
#if DEBUG_USBHOST_MSD
    printf("usbhost_msd_read_capacity(): %i\n", err);
#endif
    if (err)
    {
        return false;
    }
    else
    {
        /* returned value is lba of last block, add one to get number of blocks */
        dev_info->info.blkcount++;
    }

    if (drv->use_cache)
    {
        dev_info->cache = usbhost_msd_alloc_cache(dev_info->info.blksize);
    }

    __nop();

    for (int i = 0; i < MAX_NUM_CALLBACKS; i++)
    {
        if (drv->callback[i])
        {
            drv->callback[i](drv, dev_info_to_sid(drv, dev_info), true, drv->user_data[i]);
        }
    }

    return true;
}

static void usbhost_msd_disconnect_test(void *devicedrv, usbhost_device_t *usbdevice)
{
    usbhost_msd_dev_info_t  *dev_info;
    usbhost_msd_t           *drv = (usbhost_msd_t *) devicedrv;

#if DEBUG_USBHOST_MSD
    printf("usbhost msd disconnected\n");
#endif

    dev_info = find_device(drv, usbdevice);
    if (dev_info == NULL)
    {
        return;
    }

    usbdevice = dev_info->usbdevice;

    // verify if we are a driver for this device
    if (usbdevice->desc.bDeviceClass)
    {
        if (usbdevice->desc.bDeviceClass != USBHOST_BC_MASS_STORAGE)
        {
            return;
        }
    }
    else
    {
        if (usbdevice->config->intf[0]->curIntf->desc.bInterfaceClass != USBHOST_BC_MASS_STORAGE)
        {
            return;
        }
    }

    usbhost_msd_free_instance(dev_info->usbdevicedriver);
    if (dev_info->cache != NULL)
    {
        usbhost_msd_free_cache(dev_info->cache);
    }

    for (int i = 0; i < MAX_NUM_CALLBACKS; i++)
    {
        if (drv->callback[i])
        {
            drv->callback[i](drv, dev_info_to_sid(drv, dev_info), false, drv->user_data[i]);
        }
    }
    dev_info->inuse = false;

    return;
}

/**
 * @brief    Open an instance of the usbhost mass storage device service
 *
 * This function initializes the service and opens the driver beneath the first time the function is called.
 * Further attemps to open an already opened instance of the service simply returns the same pointer.
 *
 * @param  id  Valid service id
 *
 * @return Service pointer if succesful initialized
 */
usbhost_msd_t *usbhost_msd_open(int id)
{
    assert((id >= 0) && (id < USBHOST_MSD_INSTANCE_COUNT));

    usbhost_msd_t *restrict drv = &usbhost_msd_driver_table[id];
    usbhost_msd_cfg_instance_t *restrict drv_cfg = &usbhost_msd_instance_table[id];
    usbhost_t *usbhost;

    if (drv->usbhost) return drv;

    usbhost = usbhost_open(drv_cfg->usbhost);
    drv->usbhost = usbhost;
    drv->automount = drv_cfg->automount;
    drv->use_cache = drv_cfg->cache;

    usbhost_registerdevicedriver(usbhost, drv, &usbhost_msd_connect_test, &usbhost_msd_disconnect_test);

    return drv;
}

/**
 * @brief    Get Device Information
 *
 * This function returns information about a mass storage device.
 *
 * @param  drv      Service pointer as returned from usbhost_msd_open()
 * @param  sid      Id of a connected mass storage device, ids are returned via callback routine.
 *                  @see usbhost_msd_add_callback
 *
 * @return pointer to device information, this must be treated as read only data.
 */
usbhost_msd_info_t *usbhost_msd_get_info(usbhost_msd_t *drv, int sid)
{
    assert(drv != NULL);
    assert((sid >= 0) && (sid < USBHOST_MSD_INSTANCE_NUMDEV_MAX));

    if (drv->usbdevices[sid].inuse)
    {
        return &drv->usbdevices[sid].info;
    }

    return NULL;
}

/**
 * @brief    Read Blocks
 *
 * Read data blocks from a mass storage device.
 *
 * @param   drv         service pointer as returned from usbhost_msd_open()
 * @param   sid         id of a connected mass storage device
 * @param   data        data area to store read data
 * @param   lba         block address to start reading from
 * @param   blockcount  number of blocks to read
 *
 * @return number of blocks read or -1 in case of error
 */
int usbhost_msd_read_blocks( usbhost_msd_t * drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount )
{
    int ret = -1;

    assert(drv != NULL);
    assert((sid >= 0) && (sid < USBHOST_MSD_INSTANCE_NUMDEV_MAX));

    if (drv->usbdevices[sid].inuse)
    {
        if (drv->usbdevices[sid].cache)
        {
            ret = usbhost_msd_read_cache(drv, sid, data, lba, blockcount);
        }
        else
        {
            ret = usbhost_msd_read_direct(drv, sid, data, lba, blockcount);
        }
    }
    else
    {
        // TODO log error, device not connected, errno = ???
        __nop();
    }
    return ret;
}

/**
 * @brief    Write Blocks
 *
 * Write data blocks to a mass storage device.
 *
 * @param   drv         service pointer as returned from usbhost_msd_open()
 * @param   sid         id of a connected mass storage device
 * @param   data        data area to write to device
 * @param   lba         block address to start writing to
 * @param   blockcount  number of blocks to write
 *
 * @return number of blocks writen or -1 in case of error
 */
int usbhost_msd_write_blocks( usbhost_msd_t * drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount )
{
    int ret = -1;

    assert(drv != NULL);
    assert((sid >= 0) && (sid < USBHOST_MSD_INSTANCE_NUMDEV_MAX));

    if (drv->usbdevices[sid].inuse)
    {
        if (drv->usbdevices[sid].cache)
        {
            ret = usbhost_msd_write_cache(drv, sid, data, lba, blockcount);
        }
        else
        {
            ret = usbhost_msd_write_direct(drv, sid, data, lba, blockcount);
        }
    }

    return ret;
}

/**
 * @brief    Clear Blocks
 *
 * Clear data blocks on a mass storage device.
 *
 * @param   drv         service pointer as returned from usbhost_msd_open()
 * @param   sid         id of a connected mass storage device
 * @param   lba         block address
 * @param   blockcount  number of blocks to clear
 *
 * @return number of blocks writen or -1 in case of error
 */
int usbhost_msd_clear_blocks( usbhost_msd_t * drv, int sid, uint32_t lba, uint16_t blockcount )
{
    int ret = -1;

    assert(drv != NULL);
    assert((sid >= 0) && (sid < USBHOST_MSD_INSTANCE_NUMDEV_MAX));

    if (drv->usbdevices[sid].inuse)
    {
        if (drv->usbdevices[sid].cache)
        {
            ret = usbhost_msd_clear_cache(drv, sid, lba, blockcount);
        }
        else
        {
            ret = usbhost_msd_clear_direct(drv, sid, lba, blockcount);
        }
    }

    return -1;
}

/**
 * @brief    Flush Blocks
 *
 * Flush cached blocks to a mass storage device.
 *
 * @param   drv         service pointer as returned from usbhost_msd_open()
 * @param   sid         id of a connected mass storage device
 *
 * @return -1 in case of error, 0 otherwise
 */
int usbhost_msd_flush_blocks( usbhost_msd_t * drv, int sid )
{
    int ret = -1;

    assert(drv != NULL);
    assert((sid >= 0) && (sid < USBHOST_MSD_INSTANCE_NUMDEV_MAX));

    if (drv->usbdevices[sid].inuse)
    {
        if (drv->usbdevices[sid].cache)
        {
            ret = usbhost_msd_flush_cache(drv, sid);
        }
    }

    return ret;
}


/**
 * @brief    Add Callback
 *
 * Add a callback routine to be informed when a usb msd device in inserted or removed.
 *
 * @param   drv         service pointer as returned from usbhost_msd_open()
 * @param   callback    callback routine to be called when a mass storage device
 *                      is inserted or removed
 * @param   user_data   data to be passed to callback
 *
 * @return  0 sucess, -1 when internal table is full
 */
int usbhost_msd_add_callback( usbhost_msd_t * drv, usbhost_msd_callback_proc callback, void *user_data)
{
    assert(drv != NULL);

    for (int i = 0; i < MAX_NUM_CALLBACKS; i++)
    {
        if (drv->callback[i] == NULL)
        {
            drv->callback[i] = callback;
            drv->user_data[i] = user_data;
            return 0;
        }
    }

    return -1;
}

/**
 * @brief    Remove Callback
 *
 * Remove a previously added a callback routine.
 *
 * @param   drv         service pointer as returned from usbhost_msd_open()
 * @param   callback    callback routine to be called when a mass storage device
 *                      is inserted or removed
 * @param   user_data   same data that was passed when adding the callback
 *
 * @return  0 sucess, -1 when the callback routine could not be found
 */
int usbhost_msd_remove_callback( usbhost_msd_t * drv, usbhost_msd_callback_proc callback, void *user_data)
{
    assert(drv != NULL);

    for (int i = 0; i < MAX_NUM_CALLBACKS; i++)
    {
        if (drv->callback[i] == callback && drv->user_data[i] == user_data)
        {
            drv->callback[i] = NULL;
            drv->user_data[i] = NULL;
            return 0;
        }
    }

    return -1;
}

