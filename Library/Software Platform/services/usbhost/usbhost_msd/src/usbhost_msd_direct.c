/**
 * @file
 *  USB Host Mass Storage Device service direct (none cached) device access
 */

#include <usbhost_mass_storage.h>
#include <usbhost_msd.h>
#include <usbhost_msd_i.h>

#if DEBUG_USBHOST_MSD_DIRECT
#include <stdio.h>
#endif

int usbhost_msd_read_direct(usbhost_msd_t * drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount)
{
    int ret;

#if DEBUG_USBHOST_MSD_DIRECT
    printf("usbhost_msd_read_direct(drv=%p, sid=%d, data=%p, lba=%d, blockcount=%d)\n", drv, sid, data, (int)lba, (int)blockcount);
#endif

    ret = usbhost_msd_read10(drv->usbdevices[sid].usbdevicedriver, data, lba, blockcount, drv->usbdevices[sid].info.blksize);
    if (ret == 0)
    {
        return blockcount;
    }
    return -1;
}

int usbhost_msd_write_direct(usbhost_msd_t * drv, int sid, uint8_t *data, uint32_t lba, uint16_t blockcount)
{
    int ret;

#if DEBUG_USBHOST_MSD_DIRECT
    printf("usbhost_msd_write_direct(drv=%p, sid=%d, data=%p, lba=%d, blockcount=%d)\n", drv, sid, data, (int)lba, (int)blockcount);
#endif

    ret = usbhost_msd_write10(drv->usbdevices[sid].usbdevicedriver, data, lba, blockcount, drv->usbdevices[sid].info.blksize);
    if (ret == 0)
    {
        return blockcount;
    }

    return -1;
}

int usbhost_msd_clear_direct(usbhost_msd_t * drv, int sid, uint32_t lba, uint16_t blockcount)
{
    int err = -1, i;
    uint8_t *data;

#if DEBUG_USBHOST_MSD_DIRECT
    printf("usbhost_msd_clear_direct(drv=%p, sid=%d, lba=%d, blockcount=%d)\n", drv, sid, (int)lba, (int)blockcount);
#endif

    if (blockcount == 0)
    {
        return 0;
    }

    data  = calloc(sizeof(*data), drv->usbdevices[sid].info.blksize);
    if (data == NULL)
    {
        errno = ENOMEM;
        return -1;
    }

    for (i = 0; i < blockcount; i++)
    {
        err = usbhost_msd_write10(drv->usbdevices[sid].usbdevicedriver, data, lba + i, 1, drv->usbdevices[sid].info.blksize);
        if (err)
        {
            break;
        }
    }
    free(data);
    if (err)
    {
        if (i == 0)
        {
            return -1;
        }
        return i - 1;
    }

    return i;
}

