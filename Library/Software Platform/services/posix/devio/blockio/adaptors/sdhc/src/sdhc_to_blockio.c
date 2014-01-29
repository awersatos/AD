/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    SD memory card blockio adaptor. Posix interface.
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
#include <drv_sdhc.h>

#include "sdhc_to_blockio_cfg_instance.h"
#include "blockio_cfg_instance.h"

//............................................................................
// Device I/O functions

static int blockio_sdhc_open( devio_t *dev, int flags );
static int blockio_sdhc_ctl( devio_t *dev, int, void *, size_t, int * );
static ssize_t blockio_sdhc_write( devio_t *dev, ioreq_t *iotx )
{
    return EINVAL;
}
static ssize_t blockio_sdhc_read( devio_t *dev, ioreq_t *iorx )
{
    return EINVAL;
}
static int blockio_sdhc_mmap( devio_t *dev, void *addr, size_t len, int flag, off_t off, void **ret )
{
    return EINVAL;
}
static int blockio_sdhc_flush( devio_t *dev, int invalidate )
{
    return 0;
}

static bool blockio_sdhc_sanity_check( devio_t *dev, uint32_t blkstart, uint32_t blkcnt, uint32_t blktotal )
{
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

typedef struct
{
    devio_t dev;
    sdhc_t *sdcard;
}
sdhc_devio_t;

static devio_iofuns_t blockio_sdhc_iofuncs;
static sdhc_devio_t blockio_sdhc_devio_table[SDHC_TO_BLOCKIO_INSTANCE_COUNT];

/*****************************************************************************
|*
|*  Function:           sdhc_to_blockio_plugin_init
|*
|*  Description:        Plugin initialization. Initializes the device table
|*                      and installs a posix device for every instance.
|*
 */
extern void sdhc_to_blockio_plugin_init( void )
{
    const sdhc_to_blockio_cfg_instance_t *cfg;
    devio_t *dev;
    int sdhc_id;
    const char *name;

    /* create posix io functions data structure */
    DEV_IOFUNS_CREATE( &blockio_sdhc_iofuncs,
                       blockio_sdhc_open,
                       blockio_sdhc_write,
                       blockio_sdhc_read,
                       blockio_sdhc_ctl,
                       blockio_sdhc_mmap,
                       blockio_sdhc_flush );

    /* fill posix device table (devio_t) and register devices */
    for ( int i = 0; i < SDHC_TO_BLOCKIO_INSTANCE_COUNT; i++ )
    {
        cfg = &sdhc_to_blockio_instance_table[i];
        dev = (devio_t *) & blockio_sdhc_devio_table[i];

        /* get the name from our parent blockio intstance */
        name = blockio_instance_table[cfg->blockio_adaptor].name;

        /* we get a link to the associated sdcard instance id */
        sdhc_id = cfg->drv_sdhc;

        /* check if we got an actual link to a driver instance */
        if ( sdhc_id != -1 )
        {
            DEV_CREATE( dev, name, &blockio_sdhc_iofuncs, ( void * ) sdhc_id );
            devio_install( dev );
        }
    }
}

/*****************************************************************************
|*
|*  Function:           blockio_sdhc_open
|*
|*  Parameters:         dev      : posix device
|*
|*  Returns:            0' on success, or an error code otherwise.
|*
|*  Description:        Open SDCARD device. Initializes a device and
|*                      registers interrupt handlers.
 */
static int blockio_sdhc_open( devio_t *dev, int flags )
{
    unsigned int id = (unsigned int)dev->device;
    sdhc_devio_t *sdhc_dev = (sdhc_devio_t *)dev;
    sdhc_t *sdcard;

    sdcard = sdhc_open( id );

    if ( sdcard && sdhc_is_memcard(sdhc_card_init( sdcard, 0 )) && sdhc_set_blocklength( sdcard, 512 ) )
    {
        sdhc_dev->sdcard = sdcard;
        return 0;
    }

    return EIOCONF;
}

/*****************************************************************************
|*
|*  Function:           blockio_sdhc_ctl
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
static int blockio_sdhc_ctl( devio_t *dev, int cmd, void *buf, size_t size, int *res )
{
    sdhc_devio_t *sdhc_dev = (sdhc_devio_t *) dev;
    int retval = 0;

    switch ( cmd )
    {
    case DEVCTL_BLOCKIO_CFG:
        {
            posix_devctl_blockio_cfg_t *cfg = (posix_devctl_blockio_cfg_t *) buf;
            const sdhc_info_t *info;

            info = sdhc_get_info( sdhc_dev->sdcard );
            cfg->blkstart = 0;
            cfg->blksize = info->blksize;
            cfg->blktotal = info->blkcount;
        }
        break;

    case DEVCTL_BLOCKIO_IMPL:
        {
            posix_devctl_blockio_impl_t *impl = (posix_devctl_blockio_impl_t *) buf;

            impl->device = (void*)sdhc_dev->sdcard;
            impl->write_sectors = (ssize_t (*)( void *, const void*, uint32_t, size_t ))sdhc_write_sectors;
            impl->clear_sectors = (ssize_t (*)( void *, uint32_t, size_t ))sdhc_clear_sectors;
            impl->read_sectors = (ssize_t (*)( void *, void*, uint32_t, size_t ))sdhc_read_sectors;
            impl->flush_data = (int (*)( void *, int ))blockio_sdhc_flush;
            impl->sanity_check = (bool (*) (void *, uint32_t, uint32_t, uint32_t )) blockio_sdhc_sanity_check;
        }
        break;

    default:
        retval = ENOTSUP;
        break;
    }

    return retval;
}

#endif // __POSIX_DEVIO__
