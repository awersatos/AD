/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    usbhost_msd blockio adaptor. Posix interface.
|*
\*****************************************************************************/

#include <limits.h>
#include <string.h>

#if ( __POSIX_DEVIO__ != 0 )

#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <errno.h>
#include <assert.h>

#include <devio_adaptor.h>
#include <blockio.h>
#include <devctl.h>
#include <usbhost_msd.h>

#if __POSIX_KERNEL__
#include <pthread.h>
#include <sched.h>
#include <init.h>
#endif

#include "usbhost_msd_cfg_instance.h"
#include "usbhost_msd_to_blockio_cfg.h"
#include "usbhost_msd_to_blockio_cfg_instance.h"
#include "blockio_cfg_instance.h"

#if USBHOST_MSD_INSTANCE_AUTOMOUNT_TRUE_USED
#include <fs.h>
#endif

/*
 *
 */
static ssize_t usbhost_msd_blockio_write_sectors( void *device, void *buf, uint32_t lba, size_t size );
static ssize_t usbhost_msd_blockio_clear_sectors( void *device, uint32_t lba, size_t size );
static ssize_t usbhost_msd_blockio_read_sectors( void *device, void *buf, uint32_t lba, size_t size );
static int blockio_usbhost_msd_blockio_flush( void *device, int invalidate_cache );
static bool blockio_usbhost_msd_blockio_sanity_check( void *device, uint32_t blkstart, uint32_t blkcnt, uint32_t blktotal );

/*
 *  Locals
 */
static void connect_cb(usbhost_msd_t *drv, int sid, bool on, void *data);

//............................................................................
// Device I/O functions

static int blockio_usbhost_msd_open( devio_t *dev, int flags );
static int blockio_usbhost_msd_ctl( devio_t *dev, int, void *, size_t, int * );
static ssize_t blockio_usbhost_msd_write( devio_t *dev, ioreq_t *iotx )
{
    return EINVAL;
}
static ssize_t blockio_usbhost_msd_read( devio_t *dev, ioreq_t *iorx )
{
    return EINVAL;
}
static int blockio_usbhost_msd_mmap( devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret )
{
    return EINVAL;
}
static int blockio_usbhost_msd_flush( devio_t *dev, int invalidate )
{
    return 0;
}

typedef struct _usbhost_msd_blockio_t usbhost_msd_blockio_t;

typedef struct _con_dev_t {
    devio_t                 devio;          // must be first element
    int                     sid;            // identification form usbhost_msd from connect_cb, -1 indicates free spot
    char                    name[16];
    usbhost_msd_blockio_t   *parent;
    int                     id;             // numbers used in device name "usb%d", id
    int                     num_read_retries;
    int                     num_write_retries;
    int                     num_clear_retries;
} con_dev_t;

struct _usbhost_msd_blockio_t {
    usbhost_msd_t      *usbhost_msd;
    con_dev_t       connected_devices[USBHOST_MSD_INSTANCE_NUMDEV_MAX];
#if USBHOST_MSD_INSTANCE_AUTOMOUNT_TRUE_USED
    bool            automount;
    bool            readonly;
#endif
};


static devio_iofuns_t blockio_usbhost_msd_iofuncs;
static usbhost_msd_blockio_t blockio_usbhost_msd_devio_table[USBHOST_MSD_TO_BLOCKIO_INSTANCE_COUNT];

/*
 *
 */
static usbhost_msd_blockio_t *driver_to_adaptor(usbhost_msd_t *driver)
{
    for (int i = 0; i < USBHOST_MSD_TO_BLOCKIO_INSTANCE_COUNT; i++)
    {
        if (blockio_usbhost_msd_devio_table[i].usbhost_msd == driver)
        {
            return &blockio_usbhost_msd_devio_table[i];
        }
    }
    return NULL;
}

/*
 *
 */
static con_dev_t *alloc_condev(usbhost_msd_blockio_t *adaptor, int sid)
{
    for (int i = 0; i < USBHOST_MSD_INSTANCE_NUMDEV_MAX; i++)
    {
        if (adaptor->connected_devices[i].sid == -1)
        {
            adaptor->connected_devices[i].sid = sid;
            return &adaptor->connected_devices[i];
        }
    }
    return NULL;
}

/*
 *
 */
static void free_condev(usbhost_msd_blockio_t *adaptor, con_dev_t *con_dev)
{
    for (int i = 0; i < USBHOST_MSD_INSTANCE_NUMDEV_MAX; i++)
    {
        if (&adaptor->connected_devices[i] == con_dev)
        {
            adaptor->connected_devices[i].sid = -1;
            return;
        }
    }
    return;
}

/*
 *
 */
static con_dev_t *find_condev(usbhost_msd_blockio_t *adaptor, int sid)
{
    for (int i = 0; i < USBHOST_MSD_INSTANCE_NUMDEV_MAX; i++)
    {
        if (adaptor->connected_devices[i].sid == sid)
        {
            return &adaptor->connected_devices[i];
        }
    }
    return NULL;
}

/*****************************************************************************
|*
|*  Function:           usbhost_msd_to_blockio_plugin_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and opens the drivers.
|*                      If we run with threads we need to create a initialzation
|*                      thread that will run before the main thread.
|*                      This is because interrupts are not enabled until switching
|*                      to the first thread. And we need interrupts for usb
|*                      device initialization code.
 */
extern void usbhost_msd_to_blockio_plugin_init_code( void )
{
    /* create posix io functions data structure */
    DEV_IOFUNS_CREATE( &blockio_usbhost_msd_iofuncs,
                       blockio_usbhost_msd_open,
                       blockio_usbhost_msd_write,
                       blockio_usbhost_msd_read,
                       blockio_usbhost_msd_ctl,
                       blockio_usbhost_msd_mmap,
                       blockio_usbhost_msd_flush );

    /* open usbhost_msd drivers */
    for (int i = 0; i < USBHOST_MSD_TO_BLOCKIO_INSTANCE_COUNT; i++)
    {
        usbhost_msd_t  *usbhost_msd;

        usbhost_msd = usbhost_msd_open( usbhost_msd_to_blockio_instance_table[i].usbhost_msd );
        if (usbhost_msd != NULL)
        {
            blockio_usbhost_msd_devio_table[i].usbhost_msd = usbhost_msd;
#if USBHOST_MSD_INSTANCE_AUTOMOUNT_TRUE_USED
            blockio_usbhost_msd_devio_table[i].automount = usbhost_msd_instance_table[usbhost_msd_to_blockio_instance_table[i].usbhost_msd].automount;
            blockio_usbhost_msd_devio_table[i].readonly = usbhost_msd_instance_table[usbhost_msd_to_blockio_instance_table[i].usbhost_msd].readonly;
#endif
            usbhost_msd_add_callback(usbhost_msd, connect_cb, NULL);
        }
        for (int j = 0; j < USBHOST_MSD_INSTANCE_NUMDEV_MAX; j++)
        {
            blockio_usbhost_msd_devio_table[i].connected_devices[j].id = j;
            blockio_usbhost_msd_devio_table[i].connected_devices[j].sid = -1;
            blockio_usbhost_msd_devio_table[i].connected_devices[j].parent = &blockio_usbhost_msd_devio_table[i];
        }
    }
}

#if __POSIX_KERNEL__
void *usbhost_msd_to_blockio_plugin_init_thread(void *data)
{
    usbhost_msd_to_blockio_plugin_init_code();
    return NULL;
}

extern void usbhost_msd_to_blockio_create_init_thread( void )
{
    pthread_t id;
    pthread_attr_t attr;
    struct sched_param sched_param;

    sched_param.sched_priority = POSIX_THREADS_MAIN_PRIORITY + 1;
    pthread_attr_init(&attr);
    pthread_attr_setschedparam(&attr, &sched_param);
    pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
    pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
    pthread_create(&id, &attr, usbhost_msd_to_blockio_plugin_init_thread, NULL);

    return;
}
#endif

extern void usbhost_msd_to_blockio_plugin_init( void )
{
#if __POSIX_KERNEL__
    posix_mainhook_install(usbhost_msd_to_blockio_create_init_thread, 1);
#else
    usbhost_msd_to_blockio_plugin_init_code();
#endif
}


/*****************************************************************************
|*
|*  Function:           blockio_usbhost_msd_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            0 on success, or an error code otherwise.
|*
|*  Description:        Open usbhost_msd device and install callbacks.
 */
static int blockio_usbhost_msd_open( devio_t *dev, int flags )
{
    // TODO add read only check ??
    return 0;
}

/*****************************************************************************
|*
|*  Function:           blockio_usbhost_msd_ctl
|*
|*  Parameters:         dev     : posix device
|*                      cmd     : device control command
|*                      buf     : data pointer
|*                      size    : size of the data buffer
|*                      res     : location for a return value
|*
|*  Returns:            Depends on the command.
|*
|*  Description:        Implementation of posix_dev_ctl() interface.
 */
static int blockio_usbhost_msd_ctl( devio_t *dev, int cmd, void *buf, size_t size, int *res )
{
    con_dev_t *con_dev = (con_dev_t *) dev;
    int retval = 0;

    switch ( cmd )
    {
    case DEVCTL_BLOCKIO_CFG:
        {
            posix_devctl_blockio_cfg_t *cfg = (posix_devctl_blockio_cfg_t *) buf;
            const usbhost_msd_info_t *info;

            info = usbhost_msd_get_info( con_dev->parent->usbhost_msd, con_dev->id );
            cfg->blkstart = 0;
            cfg->blksize = info->blksize;
            assert(info->blkcount <= UINT32_MAX);
            cfg->blktotal = (uint32_t)info->blkcount;
        }
        break;

    case DEVCTL_BLOCKIO_IMPL:
        {
            posix_devctl_blockio_impl_t *impl = (posix_devctl_blockio_impl_t *) buf;

            impl->device = con_dev;
            impl->write_sectors = (ssize_t (*)( void *, const void*, uint32_t, size_t ))usbhost_msd_blockio_write_sectors;
            impl->clear_sectors = (ssize_t (*)( void *, uint32_t, size_t ))usbhost_msd_blockio_clear_sectors;
            impl->read_sectors = (ssize_t (*)( void *, void*, uint32_t, size_t ))usbhost_msd_blockio_read_sectors;
            impl->flush_data = (int (*)( void *, int ))blockio_usbhost_msd_blockio_flush;
            impl->sanity_check = blockio_usbhost_msd_blockio_sanity_check;
        }
        break;

    default:
        retval = ENOTSUP;
        break;
    }

    return retval;
}


/*
 * Handle connect/disconnect of usb mass storage devices
 */
static void connect_cb(usbhost_msd_t *drv, int sid, bool on, void *data)
{
    usbhost_msd_blockio_t   *adaptor;
    con_dev_t               *condev;

    adaptor = driver_to_adaptor(drv);
    if (adaptor == NULL)
    {
        // TODO check/report this is an error condition ??
        return;
    }

    if (on)
    {
        condev = alloc_condev(adaptor, sid);
        if (condev == NULL)
        {
            // TODO check/report this is an errr condition ??
            return;
        }

        /* fill in blockio data and add new device to block io */
        sprintf(condev->name, "usb%d", condev->id);
        DEV_CREATE( &condev->devio, condev->name, &blockio_usbhost_msd_iofuncs, condev );
        devio_install(&condev->devio);     // TODO return value to install routine to be able to check for full table

#if USBHOST_MSD_INSTANCE_AUTOMOUNT_TRUE_USED
        if (adaptor->automount)
        {
            char mountpoint[16];
            char device[16];
            int ret, flag;

            flag = adaptor->readonly ? MOUNT_FLAG_RDONLY : MOUNT_FLAG_RDWR;

            sprintf(mountpoint, "/usb%d", condev->id);
            sprintf(device, "/dev/usb%d", condev->id);
            ret = mount(device, mountpoint, "fatfs", 1, flag);
            if (ret != 0)
            {
#if DEBUG_USBHOST_MSD
                printf("mount 1 failed\n");
#endif
                ret = mount(device, mountpoint, "fatfs", 2, flag);
                if (ret != 0)
                {
#if DEBUG_USBHOST_MSD
                    printf("mount 2 failed\n");
#endif
                    ret = mount(device, mountpoint, "fatfs", 3, flag);
                    if (ret != 0)
                    {
#if DEBUG_USBHOST_MSD
                        printf("mount 3 failed\n");
#endif
                        ret = mount(device, mountpoint, "fatfs", 4, flag);
                        if (ret != 0)
                        {
#if DEBUG_USBHOST_MSD
                            printf("mount 4 failed\n");
#endif
                            ret = mount(device, mountpoint, "fatfs", 0, flag);
                            if (ret != 0)
                            {
#if DEBUG_USBHOST_MSD
                                printf("mount 0 failed\n");
#endif
                            }
                            else
                            {
#if DEBUG_USBHOST_MSD
                                printf("usb msd device mount 0 successfull\n");
#endif
                            }
                        }
                        else
                        {
#if DEBUG_USBHOST_MSD
                            printf("usb msd device mount 4 successfull\n");
#endif
                        }
                    }
                    else
                    {
#if DEBUG_USBHOST_MSD
                        printf("usb msd device mount 3 successfull\n");
#endif
                    }
                }
                else
                {
#if DEBUG_USBHOST_MSD
                    printf("usb msd device mount 2 successfull\n");
#endif
                }
            }
            else
            {
#if DEBUG_USBHOST_MSD
                printf("usb msd device mount 1 successfull\n");
#endif
            }
        }
#endif
    }
    else    /* device disconnected */
    {
        condev = find_condev(adaptor, sid);
#if USBHOST_MSD_INSTANCE_AUTOMOUNT_TRUE_USED
        if (adaptor->automount)
        {
            int ret;
            char buf[16];

            sprintf(buf, "/usb%d", condev->id);

            ret = unmount(buf, MOUNT_FLAG_FORCE);
            if (ret != 0)
            {
#if DEBUG_USBHOST_MSD
                printf("Error unmounting \"%s\"\n", buf);
#endif
            }
        }
#endif
        devio_deinstall(&condev->devio);
        free_condev(adaptor, condev);
    }
}

/*
 *
 */
static ssize_t usbhost_msd_blockio_write_sectors( void *device, void *buf, uint32_t lba, size_t size )
{
    con_dev_t *con_dev = (con_dev_t *)device;
    ssize_t ret;

    ret = usbhost_msd_write_blocks(con_dev->parent->usbhost_msd, con_dev->id, buf, lba, (uint16_t)size);
    if (ret != size)
    {
        con_dev->num_write_retries++;
        ret = usbhost_msd_write_blocks(con_dev->parent->usbhost_msd, con_dev->id, buf, lba, (uint16_t)size);
    }
    return ret;
}

/*
 *
 */
static ssize_t usbhost_msd_blockio_clear_sectors( void *device, uint32_t lba, size_t size )
{
    con_dev_t *con_dev = (con_dev_t *)device;
    ssize_t ret;

    ret = usbhost_msd_clear_blocks(con_dev->parent->usbhost_msd, con_dev->id, lba, (uint16_t)size);
    if (ret != size)
    {
        con_dev->num_clear_retries++;
        ret = usbhost_msd_clear_blocks(con_dev->parent->usbhost_msd, con_dev->id, lba, (uint16_t)size);
    }
    return ret;
}

/*
 *
 */
static ssize_t usbhost_msd_blockio_read_sectors( void *device, void *buf, uint32_t lba, size_t size )
{
    con_dev_t *con_dev = (con_dev_t *)device;
    ssize_t ret;

    ret = usbhost_msd_read_blocks(con_dev->parent->usbhost_msd, con_dev->id, buf, lba, (uint16_t)size);
    if (ret != size)
    {
        con_dev->num_read_retries++;
        ret = usbhost_msd_read_blocks(con_dev->parent->usbhost_msd, con_dev->id, buf, lba, (uint16_t)size);
    }
    return ret;
}

/*
 *
 */
static int blockio_usbhost_msd_blockio_flush( void *device, int invalidate_cache )
{
    con_dev_t *con_dev = (con_dev_t *)device;

    return usbhost_msd_flush_blocks(con_dev->parent->usbhost_msd, con_dev->id);
}

/*
 * There are usb sticks that contain wrong information in the partition table (of by 1 errors)
 */
static bool blockio_usbhost_msd_blockio_sanity_check( void *device, uint32_t blkstart, uint32_t blkcnt, uint32_t blktotal )
{
    con_dev_t *con_dev = (con_dev_t *)device;

    /*
     * skip the start + count < total check
     * some devices have error in partition table (start + size > total)
     */
    if ( blkstart == 0 || blkcnt == 0 || blkstart > blktotal )
    {
        return false;
    }
    return true;
}

#endif /* __POSIX_DEVIO__ */

