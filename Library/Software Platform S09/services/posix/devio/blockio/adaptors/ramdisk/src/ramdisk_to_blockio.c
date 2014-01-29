/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    ramdisk blockio adaptor. Posix interface.
|*
\*****************************************************************************/

#include <limits.h>

#if ( __POSIX_DEVIO__ != 0 )

#include <string.h>
#include <fcntl.h>
#include <stdbool.h>
#include <stdint.h>
#include <errno.h>

#include <devio_adaptor.h>
#include <blockio.h>
#include <devctl.h>
#include <ramdisk.h>

#include "ramdisk_to_blockio_cfg_instance.h"
#include "blockio_cfg_instance.h"

//............................................................................
// Device I/O functions

static int blockio_ramdisk_open( devio_t *dev, int flags );
static int blockio_ramdisk_ctl( devio_t *dev, int, void *, size_t, int * );
static ssize_t blockio_ramdisk_write( devio_t *dev )
{
    return EINVAL;
}
static ssize_t blockio_ramdisk_read( devio_t *dev )
{
    return EINVAL;
}
static int blockio_ramdisk_mmap( devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret )
{
    return EINVAL;
}
static int blockio_ramdisk_flush( devio_t *dev, int invalidate )
{
    return 0;
}

typedef struct
{
    devio_t dev;
    uint8_t *base;
    size_t size;
}
ramdisk_devio_t;

static devio_iofuns_t blockio_ramdisk_iofuncs;
static ramdisk_devio_t blockio_ramdisk_devio_table[RAMDISK_TO_BLOCKIO_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           ramdisk_to_blockio_plugin_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
|*
 */
extern void ramdisk_to_blockio_plugin_init( void )
{
    ramdisk_to_blockio_cfg_instance_t *adaptor_cfg;
    ramdisk_cfg_instance_t *cfg;
    ramdisk_devio_t *dev;
    int ramdisk_id;
    const char *name;

    /* create posix io functions data structure */
    DEV_IOFUNS_CREATE( &blockio_ramdisk_iofuncs,
                       blockio_ramdisk_open,
                       blockio_ramdisk_write,
                       blockio_ramdisk_read,
                       blockio_ramdisk_ctl,
                       blockio_ramdisk_mmap,
                       blockio_ramdisk_flush );

    /* fill posix device table (devio_t) and register devices */
    for ( int i = 0; i < RAMDISK_TO_BLOCKIO_INSTANCE_COUNT; i++ )
    {
        adaptor_cfg = &ramdisk_to_blockio_instance_table[i];
        dev = & blockio_ramdisk_devio_table[i];

        /* get the name from our parent blockio intstance */
        name = blockio_instance_table[adaptor_cfg->blockio_adaptor].name;

        /* we get a link to the associated ramdisk instance id */
        ramdisk_id = adaptor_cfg->ramdisk;

        /* check if we got an actual link to a driver instance */
        if ( ramdisk_id != -1 )
        {
            cfg  = &ramdisk_instance_table[ramdisk_id];

            dev->base = cfg->ramdisk;
            dev->size = cfg->ramdisk_size * sizeof(cfg->ramdisk[0]);

            DEV_CREATE( (devio_t *)dev, name, &blockio_ramdisk_iofuncs, NULL );
            devio_install( (devio_t *)dev );
        }
    }
}

/*****************************************************************************
|*
|*  Function:           blockio_ramdisk_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            0 (it always succeeds).
|*
|*  Description:        Open ramdisk device.
 */
static int blockio_ramdisk_open( devio_t *dev, int flags )
{
    /* always succeeds */
    return 0;
}


static ssize_t blockio_ramdisk_write_sectors( void *device, const void *buf, uint32_t lba, size_t size )
{
    ramdisk_devio_t *ramdisk_dev = (ramdisk_devio_t *) device;

    if ( lba + size <= ramdisk_dev->size / RAMDISK_SECTOR_SIZE )
    {
        memcpy( ramdisk_dev->base + lba * RAMDISK_SECTOR_SIZE / sizeof(ramdisk_dev->base[0]), buf,
                size * RAMDISK_SECTOR_SIZE );

        return size;
    }

    return 0;
}


static ssize_t blockio_ramdisk_clear_sectors( void *device, uint32_t lba, size_t size )
{
    ramdisk_devio_t *ramdisk_dev = (ramdisk_devio_t *) device;

    if ( lba + size <= ramdisk_dev->size / RAMDISK_SECTOR_SIZE )
    {
        memset( ramdisk_dev->base + lba * RAMDISK_SECTOR_SIZE / sizeof(ramdisk_dev->base[0]), 0,
                size * RAMDISK_SECTOR_SIZE );

        return size;
    }

    return 0;
}


static ssize_t blockio_ramdisk_read_sectors( void *device, void *buf, uint32_t lba, size_t size )
{
    ramdisk_devio_t *ramdisk_dev = (ramdisk_devio_t *) device;

    if ( lba + size <= ramdisk_dev->size / RAMDISK_SECTOR_SIZE )
    {
        memcpy( buf, ramdisk_dev->base + lba * RAMDISK_SECTOR_SIZE / sizeof(ramdisk_dev->base[0]),
                size * RAMDISK_SECTOR_SIZE );

        return size;
    }

    return 0;
}


/*****************************************************************************
|*
|*  Function:           blockio_ramdisk_ctl
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
static int blockio_ramdisk_ctl( devio_t *dev, int cmd, void *buf, size_t size, int *res )
{
    ramdisk_devio_t *ramdisk_dev = (ramdisk_devio_t *) dev;
    int retval = 0;

    switch ( cmd )
    {
    case DEVCTL_BLOCKIO_CFG:
        {
            posix_devctl_blockio_cfg_t *cfg = (posix_devctl_blockio_cfg_t *) buf;

            cfg->blkstart = 0;
            cfg->blksize  = RAMDISK_SECTOR_SIZE;
            cfg->blktotal = ramdisk_dev->size / RAMDISK_SECTOR_SIZE;
        }
        break;

    case DEVCTL_BLOCKIO_IMPL:
        {
            posix_devctl_blockio_impl_t *impl = (posix_devctl_blockio_impl_t *) buf;

            impl->device        = ramdisk_dev;
            impl->write_sectors = blockio_ramdisk_write_sectors;
            impl->clear_sectors = blockio_ramdisk_clear_sectors;
            impl->read_sectors  = blockio_ramdisk_read_sectors;
            impl->flush_data    = (int (*)( void *, int ))blockio_ramdisk_flush;
			impl->sanity_check	= NULL; 
        }
        break;

    default:
        retval = ENOTSUP;
        break;
    }

    return 0;
}

#endif // __POSIX_DEVIO__
