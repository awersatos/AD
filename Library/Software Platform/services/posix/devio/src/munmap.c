/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    munmmap
|*
\*****************************************************************************/

#if ( __POSIX_FILE_SYSTEM__ == 0 )

#include <sys/mman.h>
#include <stdlib.h>
#include <fcntl.h>
#include <limits.h>
#include <errno.h>
#include <devio.h>

#if (__POSIX_SHARED_MEMORY_OBJECTS != 0 || __POSIX_MAPPED_FILES != 0 )

# include "shmio.h"

/**
 * @brief
 *		removes any mapping starting at addr and continuing for len bytes
 *	
 *		The munmap() function shall remove any mappings for those entire pages 
 *		containing any part of the address space of the process starting at addr 
 *		and continuing for len bytes. Further references to these pages shall result 
 *		in the generation of a SIGSEGV signal to the process. 
 *		If there are no mappings in the specified address range, then munmap()
 *	    has no effect.
 *
 * @param addr
 *      address to unmap
 * @param len
 *		length in bytes of the mapped area
 * 
 * @return
 *		Upon successful completion, munmap() shall return 0; otherwise, 
 *		it shall return -1 and set errno to indicate the error.
 */

int munmap(void *addr, size_t len)
{
        int ret         = EINVAL;
        if ( len == 0 || addr == NULL )
        {
                errno = EINVAL;
                return -1;
        }

        #if ( __POSIX_DEVIO__ != 0 && __POSIX_MAPPED_FILES != 0 )
        ret = devio_munmap ( addr, len );
        if ( ret != 0 )
        {
        #endif

		#if (__POSIX_SHARED_MEMORY_OBJECTS != 0 )
        ret = shmio_munmap ( addr, len );
        #endif

        #if ( __POSIX_DEVIO__ != 0 && __POSIX_MAPPED_FILES != 0 )
        }
        #endif

        if ( ret )
        {
                errno = ret; return -1;
        }
        return ret;
}

#endif // (__POSIX_SHARED_MEMORY_OBJECTS != 0 || __POSIX_MAPPED_FILES != 0 )

#endif // ( __POSIX_FILE_SYSTEM__ == 0 )
