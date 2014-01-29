/*
 *
 */

#include <assert.h>
#include <limits.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/mman.h>

#include <devio.h>
#include <devio_adaptor.h>


devlink_t devio_table[DEV_MAX];

void devio_install(devio_t *device)
{
	int free_spot = -1;

	assert(device != NULL);

	for (int i = 0; i < DEV_MAX; i++)
    {
    	if (devio_table[i].name == NULL)
        {
        	if (free_spot == -1)
            {
            	free_spot = i;
                continue;
            }
        }
        else
        {
        	if (strcmp(device->name, devio_table[i].name) == 0)
            {
            	// looks like two devices with the same name
            	return;
            }
        }
    }

	if (free_spot != -1)
    {
    	devio_table[free_spot].name = device->name;
        devio_table[free_spot].dev  = device;
    }

    return;
}

void devio_deinstall(devio_t* device)
{
	for (int i = 0; i < DEV_MAX; i++)
    {
    	if (devio_table[i].dev == device)
        {
        	devio_table[i].name = NULL;
            devio_table[i].dev  = NULL;
            return;
        }
    }
    // looks like we did not find it
    return;
}


int devio_lookup( const char* name )
{
    int i;

    if ( name )
    {
#if ( __POSIX_FILE_SYSTEM__ == 0 )
        // Allow users to specify '/dev' even without filesystem support
        if ( strncmp( name, "/dev/", 5 ) == 0 )
        {
            name += 5;
        }
#endif
        for ( i = 0; i < DEV_MAX; i++ )
        {
        	if (devio_table[i].name != NULL)
            {
            	if ( strcmp( devio_table[i].name, name ) == 0 )
                {
                	return i;
                }
            }
        }
    }
    return -1;
}

void* devio_getdev( int fildes )
{
    if ( fildes < 0 || fildes >= DEV_MAX )
    {
        return NULL;
    }
    return devio_table[fildes].dev;
}


int devio_open( void* dptr , int flags)
{
    int         ret    = 0;
    devio_t *   devptr = (devio_t*)dptr;

    if (devptr->iofuns->init != NULL)
    {
        ret = devptr->iofuns->init(devptr, flags);
    }

    if( ret != 0)
    {
        errno = ret;
        ret   = -1;
    }

    return ret;
}


int devio_close( void* dptr )
{
    return 0;
}

int devio_posix_devctl( void* dptr, int dcmd, void *dev_data_ptr, size_t nbyte, int *dev_info_ptr )
{
    devio_t *devptr = (devio_t*)dptr;

    if (devptr->iofuns->ctl != NULL)
    {
        return devptr->iofuns->ctl( devptr, dcmd, dev_data_ptr, nbyte, dev_info_ptr );
    }
    return -1;
}


ssize_t devio_readwrite( void* dptr, ioreq_t* io, bool write )
{
    devio_t *   devptr = (devio_t*)dptr;
    ssize_t     (*driver)(devio_t*);

    driver = write ? devptr->iofuns->write : devptr->iofuns->read;

    if ( driver == NULL )
    {
        errno = EBADF;
        return -1;
    }

    if ( write )
    {
        devptr->iotx = io;
    }
    else
    {
        devptr->iorx = io;
    }

    return driver( devptr );
}

#if ( __POSIX_MAPPED_FILES != 0 )

int devio_mmap( void* dptr, void* addr, size_t len, int flags, off_t off, void** retval )
{
    devio_t *   devptr = (devio_t*)dptr;
    int         ret    = 0;

    if ( devptr->iofuns->mmap  == NULL )
    {
        errno = EBADF;
    }
    else
    {
        if ( devptr->mmapaddr != NULL )
        {
            if ( flags & MAP_FIXED || len != devptr->mmaplen)
            {
                ret = EINVAL;
            }
            else
            {
                devptr->mmaps++;
                *retval = devptr->mmapaddr;
            }
        }
        else
        {
            if ( flags & MAP_FIXED )
            {
                devptr->mmapaddr = addr;
            }
            else
            {
                ret = devptr->iofuns->mmap( devptr, addr, len, flags, off, retval );
                if ( ret == 0 )
                {
                    devptr->mmapaddr = *retval;
                }
            }
            devptr->mmaps++;
            devptr->mmaplen = len;
        }
    }

    return ret;
}

int devio_munmap( void *addr, size_t len )
{
    int         i=0;
    int         ret = EINVAL;
    devio_t *   devptr;

    for ( i=0, devptr = devio_table[0].dev;
          devptr != NULL && i < DEV_MAX;
          i++, devptr = devio_table[i].dev )
    {
        if ( devptr->mmapaddr == addr )
        {
            if ( len == devptr->mmaplen )
            {
                if ( --devptr->mmaps == 0 )
                {
                    devptr->mmapaddr = 0;
                }

                ret = 0;
            }
        }
    }

    return ret;
}

#endif

extern int devio_flush( void *dptr, int invalidate )
{
    int         ret    = 0;
    devio_t *   devptr = (devio_t*)dptr;

    if ( devptr->iofuns->flush != NULL )
    {
        ret = devptr->iofuns->flush( devptr, invalidate );
    }

    if( ret != 0 )
    {
        errno = ret;
        ret   = -1;
    }

    return ret;
}
