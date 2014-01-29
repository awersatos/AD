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
#include <drv_terminal.h>       /* non-posix driver interface */

#include "serial_cfg_instance.h"
#include "terminal_to_serial_cfg_instance.h"

/* the io functions */
static int terminal_to_serial_open(devio_t *dev, int flags);
static ssize_t terminal_to_serial_write(devio_t *dev, ioreq_t *iotx);
static ssize_t terminal_to_serial_read(devio_t *dev, ioreq_t *iorx);
static int terminal_to_serial_ctl(devio_t *dev, int, void *, size_t, int *);

static int terminal_to_serial_mmap(devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret)
{
    return EINVAL;
}

typedef struct
{
    devio_t dev;
    terminal_t *terminal;
} terminal_devio_t;

static devio_iofuns_t terminal_to_serial_iofuncs;
static terminal_devio_t terminal_to_serial_table[TERMINAL_TO_SERIAL_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           terminal_to_serial_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
 */
extern void terminal_to_serial_init(void)
{
    terminal_devio_t *device;
    const terminal_to_serial_cfg_instance_t *cfg;
    const char *name;

    /* register posix io functions */
    DEV_IOFUNS_CREATE(&terminal_to_serial_iofuncs,
                      terminal_to_serial_open,
                      terminal_to_serial_write,
                      terminal_to_serial_read, terminal_to_serial_ctl, terminal_to_serial_mmap, NULL);

    /* posix device table (devio_t) */
    for (int i = 0; i < TERMINAL_TO_SERIAL_INSTANCE_COUNT; i++)
    {
        device = &terminal_to_serial_table[i];
        cfg = &terminal_to_serial_instance_table[i];

        /* get name from our parent instance */
        name = serial_instance_table[cfg->serial_adaptor].name;

        DEV_CREATE((devio_t*)device, name, &terminal_to_serial_iofuncs, (void *)cfg->drv_terminal);

        devio_install((devio_t*)device);
    }
}

/*****************************************************************************
|*
|*  Function:           terminal_to_serial_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success, or an error code otherwise.
|*
|*  Description:        Open TERMINAL device. Initializes a device and 
|*                      registers interrupt handlers.
 */
static int terminal_to_serial_open(devio_t *dev, int flags)
{
    int id = (int) dev->device;
    terminal_devio_t *terminal_dev = (terminal_devio_t *)dev;
    terminal_t *terminal;

    terminal = terminal_open(id);
    if (terminal)
    {
        terminal_dev->terminal = terminal;
        return 0;
    }

    return EIOCONF;
}

/*****************************************************************************
|*
|*  Function:           terminal_to_serial_write
|*
|*  Parameters:         dev      : posix device
|*                      iotx     : write io request
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Write a number of bytes to the device.
 */
static ssize_t terminal_to_serial_write(devio_t *dev, ioreq_t *iotx)
{
    terminal_devio_t *terminal_dev = (terminal_devio_t *)dev;

    iotx->cnt = terminal_write(terminal_dev->terminal, (const char *)iotx->buf, iotx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           terminal_to_serial_read
|*
|*  Parameters:         dev      : posix device
|*                      iorx     : read io request
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Read a number of bytes from the device.
 */
static ssize_t terminal_to_serial_read(devio_t *dev, ioreq_t *iorx)
{
    terminal_devio_t *terminal_dev = (terminal_devio_t *)dev;

    iorx->cnt = terminal_read(terminal_dev->terminal, (char *)iorx->buf, iorx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           terminal_to_serial_ctl
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
static int terminal_to_serial_ctl(devio_t *dev, int cmd, void *buf, size_t size, int *res)
{
    terminal_devio_t *terminal_dev = (terminal_devio_t *)dev;
    int retval = 0;

    switch (cmd)
    {
    default:
        break;
    }
    return retval;
}
