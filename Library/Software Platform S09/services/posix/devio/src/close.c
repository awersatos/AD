/******************************************************************************
 * FILE:        @(#)close.c     1.19 07/03/13
 * DESCRIPTION:
 *      close shall deallocate the file descriptor indicated by fildes
 *****************************************************************************/

#include <limits.h>

#if ( __POSIX_FILE_SYSTEM__ == 0 )

#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <devio.h>
#include <sysutils.h>

# if (__POSIX_SHARED_MEMORY_OBJECTS != 0 )
# include "shmio.h"
# endif

#pragma alias _close=close

extern int close(int fildes)
{
        int ret = 0;
        void* file;

        CANCELLATION_POINT();

        /* try first devices */
        #if ( __POSIX_DEVIO__ != 0 && __POSIX_MAPPED_FILES != 0 )
        if (    (file = devio_getdev(fildes)) != NULL  )
        {
                ret = devio_close ( file );
                goto close_exit_label;
        }
        #endif

        /* else shared memory objects */
        #if (__POSIX_SHARED_MEMORY_OBJECTS != 0 )
        if (    (file = shmio_getshm(fildes)) != NULL  )
        {
                ret = shmio_close ( file );
                goto close_exit_label;
        }
        #endif
    
        /* wrong fildes */
        ret = EBADF;

close_exit_label: 
        if ( ret )
        {
                errno = ret;
                return -1;
        }

        return ret;
 
}

#endif
