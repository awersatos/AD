/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Create and install POSIX devices. The device will be
|*                      accessed through standard POSIX_DEVICEIO services.
|*
\*****************************************************************************/

#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>

#include <stdbool.h>
#include <stdint.h>

#include <devio_adaptor.h>      /* posix devices */
#include <serial.h>             /* serial dev_ctl() interfaces */
#include <drv_uart8.h>       /* non-posix driver interface */
#include "drv_uart8_internal.h"
#include "serial_cfg_instance.h"
#include "uart8_to_serial_cfg_instance.h"

/* the io functions */
static int uart8_to_serial_open(devio_t *dev, int flags);
static ssize_t uart8_to_serial_write(devio_t *dev);
static ssize_t uart8_to_serial_read(devio_t *dev);
static int uart8_to_serial_ctl(devio_t *dev, int, void *, size_t, int *);

static int uart8_to_serial_mmap(devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret)
{
    return EINVAL;
}

typedef struct
{
    devio_t dev;
    uart8_t *uart8;
} uart8_devio_t;

static devio_iofuns_t uart8_to_serial_iofuncs;
static uart8_devio_t uart8_to_serial_table[UART8_TO_SERIAL_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           uart8_to_serial_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
 */
extern void uart8_to_serial_init(void)
{
    uart8_devio_t *device;
    uart8_to_serial_cfg_instance_t *cfg;
    const char *name;

    /* register posix io functions */
    DEV_IOFUNS_CREATE(&uart8_to_serial_iofuncs,
                      uart8_to_serial_open,
                      uart8_to_serial_write,
                      uart8_to_serial_read,
                      uart8_to_serial_ctl,
                      uart8_to_serial_mmap,
                      NULL);

    /* posix device table (devio_t) */
    for (int i = 0; i < UART8_TO_SERIAL_INSTANCE_COUNT; i++)
    {
        device = &uart8_to_serial_table[i];
        cfg = &uart8_to_serial_instance_table[i];

        /* get name from our parent instance */
        name = serial_instance_table[cfg->serial_adaptor].name;

        DEV_CREATE((devio_t*)device, name, &uart8_to_serial_iofuncs, (void *)cfg->drv_uart8);

        devio_install((devio_t*)device);
    }
}

/*****************************************************************************
|*
|*  Function:           uart8_to_serial_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success, or an error code otherwise.
|*
|*  Description:        Open UART8 device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int uart8_to_serial_open(devio_t *dev, int flags)
{
    int id = (int) dev->device;
    uart8_devio_t *uart8_dev = (uart8_devio_t *)dev;
    uart8_t *uart8;

    uart8 = uart8_open(id);
    if (uart8)
    {
        uart8_dev->uart8 = uart8;
        return 0;
    }

    return EIOCONF;
}

/*****************************************************************************
|*
|*  Function:           uart8_to_serial_write
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Write a number of bytes to the device.
 */
static ssize_t uart8_to_serial_write(devio_t *dev)
{
    uart8_devio_t *uart8_dev = (uart8_devio_t *)dev;

    dev->iotx->cnt = uart8_write(uart8_dev->uart8, (const char *)dev->iotx->buf, dev->iotx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           uart8_to_serial_read
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Read a number of bytes from the device.
 */
static ssize_t uart8_to_serial_read(devio_t *dev)
{
    uart8_devio_t *uart8_dev = (uart8_devio_t *)dev;

    dev->iorx->cnt = uart8_read(uart8_dev->uart8, (char *)dev->iorx->buf, dev->iorx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           uart8_to_serial_ctl
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
static int uart8_to_serial_ctl(devio_t *dev, int cmd, void *buf, size_t size, int *res)
{
    int     id     = (int)dev->device;
    int     retval = 0;
    posix_devctl_serial_impl_t *cfg = (posix_devctl_serial_impl_t *) buf;

    uart8_devio_t *uart8_dev = (uart8_devio_t *)dev;

    switch ( cmd )
    {
    case DEVCTL_SERIAL_IMPL:
        cfg->device = (void *)uart8_dev->uart8;
        cfg->f_putchar = (int (*)(void *, int))uart8_putchar_internal;
        cfg->f_getchar = (int (*)(void *))uart8_getchar_internal;
        cfg->f_set_baudrate = (void (*)(void *, int))uart8_set_baudrate_internal;
        cfg->f_get_baudrate = (int (*)(void *))uart8_get_baudrate_internal;
        cfg->f_set_transmit_chardelay = (void (*)(void *, uint8_t))uart8_set_transmit_chardelay;
        cfg->f_get_rx_mutex     = (void* (*)(void *))uart8_get_rx_mutex;
        cfg->f_get_tx_mutex     = (void* (*)(void *))uart8_get_tx_mutex;
        break;
    default:
        break;
    }
    return retval;
}
