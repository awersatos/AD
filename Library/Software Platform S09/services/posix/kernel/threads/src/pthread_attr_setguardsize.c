/******************************************************************************
 * FILE:        @(#)pthread_attr_setguardsize.c 1.4 07/02/21
 * DESCRIPTION:
 *          The pthread_attr_setguardsize() function shall set the guardsize
 *          attribute in the attr object. 
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__XSI_THREAD_EXIT != 0)

/* the 'guardsize' mechanism is not implemented yet */

int pthread_attr_setguardsize(pthread_attr_t * attr, size_t guardsize)
{
        int ret =0;

        if ( attr == NULL || guardsize < PAGESIZE)
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();

        if (    attr->init != _ATTR_INIT_KEY )
        {
                ret = EINVAL;
        }
        else
        {
                attr->guardsize = guardsize;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif
