/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2010, Altium
|*
|*  Description:        Create and install POSIX devices. The device will be
|*                      accessed through standard POSIX_DEVICEIO services.
|*
\*****************************************************************************/

#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <assert.h>

#include <devio_adaptor.h>      /* posix devices */
#include <serial.h>             /* serial dev_ctl() interfaces */
#include "serial_cfg_instance.h"
#include "cellular_to_serial_cfg_instance.h"

#include "drv_cellular_internal.h"

/* the io functions */
static int cellular_to_serial_open(devio_t *dev, int flags);
static ssize_t cellular_to_serial_write(devio_t *dev, ioreq_t *iotx);
static ssize_t cellular_to_serial_read(devio_t *dev, ioreq_t *iorx);
static int cellular_to_serial_ctl(devio_t *dev, int, void *, size_t, int *);

static int cellular_to_serial_mmap(devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret)
{
    return EINVAL;
}

typedef struct
{
    devio_t      dev;
    cellular_t * cellular;
} cellular_devio_t;

static devio_iofuns_t cellular_to_serial_iofuncs;
static cellular_devio_t cellular_to_serial_table[CELLULAR_TO_SERIAL_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           cellular_to_serial_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
 */
extern void cellular_to_serial_init(void)
{
    cellular_devio_t *device;
    const cellular_to_serial_cfg_instance_t *cfg;
    const char *name;

    /* register posix io functions */
    DEV_IOFUNS_CREATE(&cellular_to_serial_iofuncs,
                      cellular_to_serial_open,
                      cellular_to_serial_write,
                      cellular_to_serial_read,
                      cellular_to_serial_ctl,
                      cellular_to_serial_mmap,
                      NULL);

    /* posix device table (devio_t) */
    for (int i = 0; i < CELLULAR_TO_SERIAL_INSTANCE_COUNT; i++)
    {
        device = &cellular_to_serial_table[i];
        cfg = &cellular_to_serial_instance_table[i];
        name = serial_instance_table[cfg->serial_adaptor].name;

        DEV_CREATE((devio_t*)device, name, &cellular_to_serial_iofuncs, (void *)cfg->drv_cellular);

        devio_install((devio_t*)device);
    }
}

/*****************************************************************************
|*
|*  Function:           cellular_to_serial_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success, or an error code otherwise.
|*
|*  Description:        Open CELLULAR device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int cellular_to_serial_open(devio_t *dev, int flags)
{
    int id = (int) dev->device;
    cellular_devio_t *cellular_dev = (cellular_devio_t *)dev;

    cellular_dev->cellular = cellular_open(id);
    if (!cellular_dev->cellular)
        return EIOCONF;

    return 0;
}

/*****************************************************************************
|*
|*  Function:           cellular_to_serial_write
|*
|*  Parameters:         dev      : posix device
|*                      iotx     : write io request
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Write a number of bytes to the device.
 */
static ssize_t cellular_to_serial_write(devio_t *dev, ioreq_t *iotx)
{
    cellular_devio_t * cellular_dev = (cellular_devio_t *)dev;

    iotx->cnt = uart8_write(cellular_dev->cellular->uart8, (const char *)iotx->buf, iotx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           cellular_to_serial_read
|*
|*  Parameters:         dev      : posix device
|*                      iorx     : read io request
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Read a number of bytes from the device.
 */
static ssize_t cellular_to_serial_read(devio_t *dev, ioreq_t *iorx)
{
    cellular_devio_t *cellular_dev = (cellular_devio_t *)dev;

    iorx->cnt = uart8_read(cellular_dev->cellular->uart8, (char *)iorx->buf, iorx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           cellular_to_serial_ctl
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
static int cellular_to_serial_ctl(devio_t *dev, int cmd, void *buf, size_t size, int *res)
{
    int     id     = (int)dev->device;
    int     retval = 0;
    posix_devctl_serial_impl_t *cfg = (posix_devctl_serial_impl_t *) buf;

    cellular_devio_t *cellular_dev = (cellular_devio_t *)dev;

    switch ( cmd )
    {
    case DEVCTL_SERIAL_IMPL:
        cfg->device                   = (void *)                    cellular_dev->cellular->uart8;
        cfg->f_putchar                = (int (*)(void *, int))      uart8_putchar_internal;
        cfg->f_getchar                = (int (*)(void *))           uart8_getchar_internal;
        cfg->f_set_baudrate           = (void (*)(void *, int))     uart8_set_baudrate_internal;
        cfg->f_get_baudrate           = (int (*)(void *))           uart8_get_baudrate_internal;
        cfg->f_set_transmit_chardelay = (void (*)(void *, uint8_t)) uart8_set_transmit_chardelay;
        cfg->f_get_rx_mutex           = (void* (*)(void *))         uart8_get_rx_mutex;
        cfg->f_get_tx_mutex           = (void* (*)(void *))         uart8_get_tx_mutex;
        break;
    case DEVCTL_SERIAL_POWER_ON:
        cellular_pwr_on(cellular_dev->cellular);
        break;
    case DEVCTL_SERIAL_SUSPEND:
        cellular_dtr(cellular_dev->cellular);
        break;
    default:
        retval = EINVAL;
        break;
    }
    return retval;
}
