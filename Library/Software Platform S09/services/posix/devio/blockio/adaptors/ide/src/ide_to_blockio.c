/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    IDE blockio adaptor. Posix interface.
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
#include <drv_ide.h>

#include "ide_to_blockio_cfg_instance.h"
#include "blockio_cfg_instance.h"

//............................................................................
// Device I/O functions

static int blockio_ide_open( devio_t *dev, int flags );
static int blockio_ide_ctl( devio_t *dev, int, void *, size_t, int * );
static ssize_t blockio_ide_write( devio_t *dev )
{
    return EINVAL;
}
static ssize_t blockio_ide_read( devio_t *dev )
{
    return EINVAL;
}
static int blockio_ide_mmap( devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret )
{
    return EINVAL;
}
static int blockio_ide_flush( devio_t *dev, int invalidate )
{
    return 0;
}

typedef struct
{
    devio_t dev;
    ide_t *ide;
}
ide_devio_t;

static devio_iofuns_t blockio_ide_iofuncs;
static ide_devio_t blockio_ide_devio_table[IDE_TO_BLOCKIO_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           ide_to_blockio_plugin_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
|*
 */
extern void ide_to_blockio_plugin_init( void )
{
    ide_to_blockio_cfg_instance_t *cfg;
    devio_t *dev;
    int ide_id;
    const char *name;

    /* create posix io functions data structure */
    DEV_IOFUNS_CREATE( &blockio_ide_iofuncs,
                       blockio_ide_open,
                       blockio_ide_write,
                       blockio_ide_read,
                       blockio_ide_ctl,
                       blockio_ide_mmap,
                       blockio_ide_flush );

    /* fill posix device table (devio_t) and register devices */
    for ( int i = 0; i < IDE_TO_BLOCKIO_INSTANCE_COUNT; i++ )
    {
        cfg = &ide_to_blockio_instance_table[i];
        dev = (devio_t *) & blockio_ide_devio_table[i];

        /* get the name from our parent blockio intstance */
        name = blockio_instance_table[cfg->blockio_adaptor].name;

        /* we get a link to the associated ide instance id */
        ide_id = cfg->drv_ide;

        /* check if we got an actual link to a driver instance */
        if ( ide_id != -1 )
        {
            DEV_CREATE( dev, name, &blockio_ide_iofuncs, ( void * ) ide_id );
            devio_install( dev );
        }
    }
}

/*****************************************************************************
|*
|*  Function:           blockio_ide_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            0' on success, or an error code otherwise.
|*
|*  Description:        Open IDE device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int blockio_ide_open( devio_t *dev, int flags )
{
    int id = ( int ) dev->device;
    ide_devio_t *ide_dev = (ide_devio_t *) dev;
    int ret = EIOCONF;
    ide_t *ide;

    ide = ide_open( id );

    if ( ide && ide_open_device( ide ) == 0 )
    {
        ide_dev->ide = ide;
        ret = 0;
    }

    return ret;
}

/*****************************************************************************
|*
|*  Function:           blockio_ide_ctl
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
static int blockio_ide_ctl( devio_t *dev, int cmd, void *buf, size_t size, int *res )
{
    ide_devio_t *ide_dev = (ide_devio_t *) dev;
    int retval = 0;

    switch ( cmd )
    {
    case DEVCTL_BLOCKIO_CFG:
        {
            posix_devctl_blockio_cfg_t *cfg = (posix_devctl_blockio_cfg_t *) buf;
            const ide_info_t *info;

            info = ide_get_info( ide_dev->ide );
            cfg->blkstart = 0;
            cfg->blksize = info->blksize;
            cfg->blktotal = info->blkcount;
        }
        break;

    case DEVCTL_BLOCKIO_IMPL:
        {
            posix_devctl_blockio_impl_t *impl = (posix_devctl_blockio_impl_t *) buf;

            impl->device = (void*)ide_dev->ide;
            impl->write_sectors = (ssize_t (*)( void *, const void*, uint32_t, size_t ))ide_write_sectors;
            impl->clear_sectors = (ssize_t (*)( void *, uint32_t, size_t ))ide_clear_sectors;
            impl->read_sectors = (ssize_t (*)( void *, void*, uint32_t, size_t ))ide_read_sectors;
            impl->flush_data = (int (*)( void *, int ))blockio_ide_flush;
			impl->sanity_check = NULL;
        }
        break;

    default:
        retval = ENOTSUP;
        break;
    }

    return 0;
}

#endif // __POSIX_DEVIO__
