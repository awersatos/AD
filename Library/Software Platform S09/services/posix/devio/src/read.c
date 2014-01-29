/******************************************************************************
 * FILE:        @(#)read.c      1.9 07/03/13
 * DESCRIPTION:
 *      The read() function shall attempt to read nbyte bytes from the
 *      file associated with the open file descriptor, fildes,
 *      into the buffer pointed to by buf.
 *****************************************************************************/

#include <limits.h>

#if ( (__POSIX_DEVIO__ != 0) && (__POSIX_FILE_SYSTEM__ == 0) )

#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <devio.h>
#include <sysutils.h>

#pragma alias _read = read

extern ssize_t read(int fildes, void *buf, size_t nbyte)
{
        int ret = 0;
        void * dptr;
        ioreq_t io;
        io.buf  = buf;
        io.len  = nbyte;
        io.cnt  = 0;

        CANCELLATION_POINT();

        if ( nbyte > SSIZE_MAX )
        {
                errno = ERANGE; return -1;
        }
        else if ( nbyte < 0 || buf == NULL )
        {
            errno = EINVAL; return -1;
        }
        else if ( nbyte == 0 )
        {
                return 0;
        }

         if ( fildes < 0 || fildes >= DEV_MAX || (dptr = devio_getdev(fildes)) == NULL )
        {
            ret = EBADF;
         }
        else
        {
                ret = devio_readwrite ( dptr, &io, false );
        }

        CANCELLATION_POINT();

        if ( ret != 0 )
        {
                errno = ret; return -1;
        }

        return io.cnt;

}


#endif


