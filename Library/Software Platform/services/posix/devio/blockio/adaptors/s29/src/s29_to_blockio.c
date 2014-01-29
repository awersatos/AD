/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    S29 I/O driver. Posix interface.
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
#include <drv_s29_blockio.h>

#include "s29_to_blockio_cfg_instance.h"
#include "blockio_cfg_instance.h"

//............................................................................
// Device I/O functions

static int devio_s29_open( devio_t *dev, int flags );
static int devio_s29_ctl( devio_t *dev, int, void *, size_t, int * );
static int devio_s29_flush( devio_t *dev, int invalidate );
static ssize_t devio_s29_write( devio_t *dev, ioreq_t *iotx )
{
    return EINVAL;
}
static ssize_t devio_s29_read( devio_t *dev, ioreq_t *iorx )
{
    return EINVAL;
}
static int devio_s29_mmap( devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret )
{
    return EINVAL;
}

typedef struct
{
    devio_t dev;
    s29_blockio_t *s29_blockio;
}
s29_devio_t;

static devio_iofuns_t devio_s29_iofuncs;
static s29_devio_t devio_s29_devio_table[S29_TO_BLOCKIO_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           s29_to_blockio_plugin_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
|*
 */
extern void s29_to_blockio_plugin_init( void )
{
    const s29_to_blockio_cfg_instance_t *cfg;
    devio_t *dev;
    int s29_blockio_id;
    const char *name;

    /* create posix io functions data structure */
    DEV_IOFUNS_CREATE( &devio_s29_iofuncs,
                       devio_s29_open,
                       devio_s29_write,
                       devio_s29_read,
                       devio_s29_ctl,
                       devio_s29_mmap,
                       devio_s29_flush );

    /* fill posix device table (devio_t) and register devices */
    for ( int i = 0; i < S29_TO_BLOCKIO_INSTANCE_COUNT; i++ )
    {
        cfg = &s29_to_blockio_instance_table[i];
        dev = (devio_t *) & devio_s29_devio_table[i];

        /* get the name from our parent blockio intstance */
        name = blockio_instance_table[cfg->blockio_adaptor].name;

        /* we get a link to the associated s29 instance id */
        s29_blockio_id = cfg->drv_s29_blockio;

        DEV_CREATE( dev, name, &devio_s29_iofuncs, ( void * ) s29_blockio_id );
        devio_install( dev );
    }
}

/*****************************************************************************
|*
|*  Function:           devio_s29_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            0' on success, or an error code otherwise.
|*
|*  Description:        Open S29 device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int devio_s29_open( devio_t *dev, int flags )
{
    int id = ( int ) dev->device;
    s29_devio_t * restrict s29_dev = (s29_devio_t *) dev;
    int retval = EIOCONF;
    s29_blockio_t *s29_blockio;

    s29_blockio = s29_blockio_open( id );

    if ( s29_blockio )
    {
        s29_dev->s29_blockio = s29_blockio;
        retval = 0;
    }

    return retval;
}

/*****************************************************************************
|*
|*  Function:           devio_s29_ctl
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
static int devio_s29_ctl( devio_t *dev, int cmd, void *buf, size_t size, int *res )
{
    s29_devio_t * restrict s29_dev = (s29_devio_t *) dev;
    int retval = 0;

    switch ( cmd )
    {
    case DEVCTL_BLOCKIO_CFG:
        {
            posix_devctl_blockio_cfg_t *cfg = (posix_devctl_blockio_cfg_t *) buf;
            const s29_blockio_info_t *info;

            info = s29_blockio_get_info( s29_dev->s29_blockio );
            cfg->blkstart = 0;
            cfg->blksize = info->blksize;
            cfg->blktotal = info->blkcount;
        }
        break;

    case DEVCTL_BLOCKIO_IMPL:
        {
            posix_devctl_blockio_impl_t *impl = (posix_devctl_blockio_impl_t *) buf;

            impl->device = (void*)s29_dev->s29_blockio;
            impl->write_sectors = (ssize_t (*)( void *, const void*, uint32_t, size_t ))s29_blockio_write_sectors;
            impl->clear_sectors = (ssize_t (*)( void *, uint32_t, size_t ))s29_blockio_clear_sectors;
            impl->read_sectors = (ssize_t (*)( void *, void*, uint32_t, size_t ))s29_blockio_read_sectors;
            impl->flush_data = (int (*)( void *, int ))s29_blockio_flush;
            impl->sanity_check = NULL;
        }
        break;

    default:
        retval = ENOTSUP;
        break;
    }

    return 0;
}

static int devio_s29_flush( devio_t *dev, int invalidate )
{
    s29_devio_t * restrict s29_dev = (s29_devio_t *) dev;
    return s29_blockio_flush( s29_dev->s29_blockio );
}

#endif // __POSIX_DEVIO__
