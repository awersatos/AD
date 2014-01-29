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
#include "gps_nmea_to_serial_cfg_instance.h"
#include "drv_gps_nmea_internal.h"

/* the io functions */
static int gps_nmea_to_serial_open(devio_t *dev, int flags);
static ssize_t gps_nmea_to_serial_write(devio_t *dev, ioreq_t *iotx);
static ssize_t gps_nmea_to_serial_read(devio_t *dev, ioreq_t *iorx);
static int gps_nmea_to_serial_ctl(devio_t *dev, int, void *, size_t, int *);

static int gps_nmea_to_serial_mmap(devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret)
{
    return EINVAL;
}

typedef struct
{
    devio_t      dev;
    drv_gps_nmea_t * gps_nmea;
} gps_nmea_devio_t;

static devio_iofuns_t gps_nmea_to_serial_iofuncs;
static gps_nmea_devio_t gps_nmea_to_serial_table[GPS_NMEA_TO_SERIAL_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_serial_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
 */
extern void gps_nmea_to_serial_init(void)
{
    gps_nmea_devio_t *device;
    const gps_nmea_to_serial_cfg_instance_t *cfg;
    const char *name;

    /* register posix io functions */
    DEV_IOFUNS_CREATE(&gps_nmea_to_serial_iofuncs,
                      gps_nmea_to_serial_open,
                      gps_nmea_to_serial_write,
                      gps_nmea_to_serial_read,
                      gps_nmea_to_serial_ctl,
                      gps_nmea_to_serial_mmap,
                      NULL);

    /* posix device table (devio_t) */
    for (int i = 0; i < GPS_NMEA_TO_SERIAL_INSTANCE_COUNT; i++)
    {
        device = &gps_nmea_to_serial_table[i];
        cfg = &gps_nmea_to_serial_instance_table[i];
        name = serial_instance_table[cfg->serial_adaptor].name;

        DEV_CREATE((devio_t*)device, name, &gps_nmea_to_serial_iofuncs, (void *)cfg->drv_gps_nmea);

        devio_install((devio_t*)device);
    }
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_serial_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            '0' on success, or an error code otherwise.
|*
|*  Description:        Open gps_nmea device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int gps_nmea_to_serial_open(devio_t *dev, int flags)
{
    int id = (int) dev->device;
    gps_nmea_devio_t *gps_nmea_dev = (gps_nmea_devio_t *)dev;

    gps_nmea_dev->gps_nmea = drv_gps_nmea_open(id);
    if (!gps_nmea_dev->gps_nmea)
        return EIOCONF;

    return 0;
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_serial_write
|*
|*  Parameters:         dev      : posix device
|*                      iotx     : write io request
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Write a number of bytes to the device.
 */
static ssize_t gps_nmea_to_serial_write(devio_t *dev, ioreq_t *iotx)
{
    gps_nmea_devio_t * gps_nmea_dev = (gps_nmea_devio_t *)dev;

    iotx->cnt = uart8_write(gps_nmea_dev->gps_nmea->uart8, (const char *)iotx->buf, iotx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_serial_read
|*
|*  Parameters:         dev      : posix device
|*                      iorx     : read io request
|*
|*  Returns:            '0' on success or an error code otherwise.
|*
|*  Description:        Read a number of bytes from the device.
 */
static ssize_t gps_nmea_to_serial_read(devio_t *dev, ioreq_t *iorx)
{
    gps_nmea_devio_t *gps_nmea_dev = (gps_nmea_devio_t *)dev;

    iorx->cnt = uart8_read(gps_nmea_dev->gps_nmea->uart8, (char *)iorx->buf, iorx->len);

    return 0;
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_serial_ctl
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
static int gps_nmea_to_serial_ctl(devio_t *dev, int cmd, void *buf, size_t size, int *res)
{
    int     id     = (int)dev->device;
    int     retval = 0;
    posix_devctl_serial_impl_t *serial = (posix_devctl_serial_impl_t *) buf;

    gps_nmea_devio_t *gps_nmea_dev = (gps_nmea_devio_t *)dev;

    switch ( cmd )
    {
    case DEVCTL_SERIAL_IMPL:
        serial->device                   = (void *)                    gps_nmea_dev->gps_nmea->uart8;
        serial->f_putchar                = (int (*)(void *, int))      uart8_putchar_internal;
        serial->f_getchar                = (int (*)(void *))           uart8_getchar_internal;
        serial->f_set_baudrate           = (void (*)(void *, int))     uart8_set_baudrate_internal;
        serial->f_get_baudrate           = (int (*)(void *))           uart8_get_baudrate_internal;
        serial->f_set_transmit_chardelay = (void (*)(void *, uint8_t)) uart8_set_transmit_chardelay;
        serial->f_get_rx_mutex           = (void* (*)(void *))         uart8_get_rx_mutex;
        serial->f_get_tx_mutex           = (void* (*)(void *))         uart8_get_tx_mutex;
        break;
    default:
        retval = EINVAL;
        break;
    }
    return retval;
}
