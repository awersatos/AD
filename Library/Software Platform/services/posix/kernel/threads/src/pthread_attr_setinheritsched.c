/******************************************************************************
 * FILE:        @(#)pthread_attr_setinheritsched.c      1.3 06/05/22
 * DESCRIPTION:
 *      The pthread_attr_setinheritsched() function shall set the 
 *      inheritsched attribute in the attr argument.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

int pthread_attr_setinheritsched (pthread_attr_t *attr, int inheritsched)
{       
        int ret = 0;

        if (    attr == NULL                            ||
                (inheritsched != PTHREAD_INHERIT_SCHED  &&
                 inheritsched != PTHREAD_EXPLICIT_SCHED )
        )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if (attr->init != _ATTR_INIT_KEY )
        {
                ret = EINVAL;
        }
        else
        {
                attr->inheritsched = inheritsched;
        }
        
        posix_scheduler_unlock();

        return ret;
}


