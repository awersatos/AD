/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    SDCARD blockio adaptor. Posix interface.
|*
\*****************************************************************************/

#include <limits.h>

#if ( __POSIX_DEVIO__ != 0 )

#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <errno.h>

#include <devio_adaptor.h>
#include <blockio.h>
#include <devctl.h>
#include <drv_sdcard.h>

#include "sdcard_to_blockio_cfg_instance.h"
#include "blockio_cfg_instance.h"

//............................................................................
// Device I/O functions

static int blockio_sdcard_open( devio_t *dev, int flags );
static int blockio_sdcard_ctl( devio_t *dev, int, void *, size_t, int * );
static ssize_t blockio_sdcard_write( devio_t *dev, ioreq_t *iotx )
{
    return EINVAL;
}
static ssize_t blockio_sdcard_read( devio_t *dev, ioreq_t *iorx )
{
    return EINVAL;
}
static int blockio_sdcard_mmap( devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret )
{
    return EINVAL;
}
static int blockio_sdcard_flush( devio_t *dev, int invalidate )
{
    return 0;
}

typedef struct
{
    devio_t dev;
    sdcard_t *sdcard;
}
sdcard_devio_t;

static devio_iofuns_t blockio_sdcard_iofuncs;
static sdcard_devio_t blockio_sdcard_devio_table[SDCARD_TO_BLOCKIO_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           sdcard_to_blockio_plugin_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
|*
 */
extern void sdcard_to_blockio_plugin_init( void )
{
    const sdcard_to_blockio_cfg_instance_t *cfg;
    devio_t *dev;
    int sdcard_id;
    const char *name;

    /* create posix io functions data structure */
    DEV_IOFUNS_CREATE( &blockio_sdcard_iofuncs,
                       blockio_sdcard_open,
                       blockio_sdcard_write,
                       blockio_sdcard_read,
                       blockio_sdcard_ctl,
                       blockio_sdcard_mmap,
                       blockio_sdcard_flush );

    /* fill posix device table (devio_t) and register devices */
    for ( int i = 0; i < SDCARD_TO_BLOCKIO_INSTANCE_COUNT; i++ )
    {
        cfg = &sdcard_to_blockio_instance_table[i];
        dev = (devio_t *) & blockio_sdcard_devio_table[i];

        /* get the name from our parent blockio intstance */
        name = blockio_instance_table[cfg->blockio_adaptor].name;

        /* we get a link to the associated sdcard instance id */
        sdcard_id = cfg->drv_sdcard;

        /* check if we got an actual link to a driver instance */
        if ( sdcard_id != -1 )
        {
            DEV_CREATE( dev, name, &blockio_sdcard_iofuncs, ( void * ) sdcard_id );
            devio_install( dev );
        }
    }
}

/*****************************************************************************
|*
|*  Function:           blockio_sdcard_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            0' on success, or an error code otherwise.
|*
|*  Description:        Open SDCARD device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int blockio_sdcard_open( devio_t *dev, int flags )
{
    unsigned int id = (unsigned int)dev->device;
    sdcard_devio_t *sdcard_dev = (sdcard_devio_t *)dev;
    sdcard_t *sdcard;

    sdcard = sdcard_open( id );

    if ( sdcard )
    {
        sdcard_dev->sdcard = sdcard;
        return 0;
    }

    return EIOCONF;
}

/*****************************************************************************
|*
|*  Function:           blockio_sdcard_ctl
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
static int blockio_sdcard_ctl( devio_t *dev, int cmd, void *buf, size_t size, int *res )
{
    sdcard_devio_t *sdcard_dev = (sdcard_devio_t *) dev;
    int retval = 0;

    switch ( cmd )
    {
    case DEVCTL_BLOCKIO_CFG:
        {
            posix_devctl_blockio_cfg_t *cfg = (posix_devctl_blockio_cfg_t *) buf;
            const sdcard_info_t *info;

            info = sdcard_get_info( sdcard_dev->sdcard );
            if (info->blksize == 0 || info->blkcount == 0)
            {
                if (sdcard_device_init( sdcard_dev->sdcard ) == SD_ERR_OK)
                {
                    info = sdcard_get_info( sdcard_dev->sdcard );
                }
            }
            cfg->blkstart = 0;
            cfg->blksize = info->blksize;
            cfg->blktotal = info->blkcount;
        }
        break;

    case DEVCTL_BLOCKIO_IMPL:
        {
            posix_devctl_blockio_impl_t *impl = (posix_devctl_blockio_impl_t *) buf;

            impl->device = (void*)sdcard_dev->sdcard;
            impl->write_sectors = (ssize_t (*)( void *, const void*, uint32_t, size_t ))sdcard_write_sectors;
            impl->clear_sectors = (ssize_t (*)( void *, uint32_t, size_t ))sdcard_clear_sectors;
            impl->read_sectors = (ssize_t (*)( void *, void*, uint32_t, size_t ))sdcard_read_sectors;
            impl->flush_data = (int (*)( void *, int ))blockio_sdcard_flush;
            impl->sanity_check = NULL;
        }
        break;

    default:
        retval = ENOTSUP;
        break;
    }

    return retval;
}

#endif // __POSIX_DEVIO__
