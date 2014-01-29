/******************************************************************************
 * FILE:        @(#)pthread_attr_getstacksize.c 1.4 06/06/09
 * DESCRIPTION:
 *      The pthread_attr_getstacksize() function shall get the thread 
 *      creation stacksize attribute in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__POSIX_THREAD_ATTR_STACKSIZE != 0 )

int pthread_attr_getstacksize (const pthread_attr_t *attr,
                                       size_t *stacksize)
{       
        int ret = 0;
        
        posix_scheduler_lock();

        if (attr == NULL || attr->init != _ATTR_INIT_KEY || stacksize == NULL )
        {
                ret = EINVAL;
        }
        else
        {
                *stacksize = attr->stacksize;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif


