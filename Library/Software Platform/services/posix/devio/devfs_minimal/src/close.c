/******************************************************************************
 * FILE:        @(#)close.c     1.19 07/03/13
 * DESCRIPTION:
 *      close shall deallocate the file descriptor indicated by fildes
 *****************************************************************************/

#include <limits.h>

#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <devio.h>
#include <sysutils.h>

#pragma alias _close=close

extern int close(int fildes)
{
        int ret = 0;
        void* file;

        CANCELLATION_POINT();

        /* try first devices */
        if ((file = devio_getdev(fildes)) != NULL)
        {
                ret = devio_close ( file );
                goto close_exit_label;
        }

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
