/******************************************************************************
 * FILE:        @(#)pthread_attr_setstackaddr.c 1.6 06/06/09
 * DESCRIPTION:
 *      The pthread_attr_setstackaddr() function shall set the thread 
 *      creation stackaddr attribute in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if ( __POSIX_THREAD_ATTR_STACKADDR != 0 )

int pthread_attr_setstackaddr (pthread_attr_t *attr, void *stackaddr)
{
        int ret = 0;

        if (attr==NULL || stackaddr == NULL)
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if ( attr->init != _ATTR_INIT_KEY) 
        {
                ret = EINVAL;
        }
        else
        {
                attr->stackaddr       = stackaddr;
#if (__XSI_THREAD_EXIT != 0)    
                attr->guardsize       = 0;
#endif
        }

        posix_scheduler_unlock();
        
        return ret;
}

#endif
