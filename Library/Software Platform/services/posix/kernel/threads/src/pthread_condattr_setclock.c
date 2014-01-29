/*****************************************************************************
 * FILE:        @(#)pthread_condattr_setclock.c 1.3 07/02/21
 * DESCRIPTION:
 *      The pthread_condattr_getclock() function shall obtain the value of 
 *      the clock attribute from the attributes object referenced by attr.
 *****************************************************************************/
#include <errno.h>
#include <pthread.h>
#include <sys/types.h>
#include "kernel.h"

int pthread_condattr_setclock(pthread_condattr_t * attr,
       clockid_t clock_id)
{
        int ret = 0;

        posix_scheduler_lock();

        if ( attr == NULL || attr->init != _ATTR_INIT_KEY || 
                ( clock_id != CLOCK_REALTIME && 
                  clock_id != CLOCK_MONOTONIC) )
        {
                ret = EINVAL;
        }
        else 
        {
                attr->clock_id = clock_id;
        }
        
        posix_scheduler_unlock();
       
        return ret;

}
