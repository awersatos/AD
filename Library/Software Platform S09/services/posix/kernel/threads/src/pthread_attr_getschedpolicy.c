/******************************************************************************
 * FILE:        @(#)pthread_attr_getschedpolicy.c       1.3 06/05/22
 * DESCRIPTION:
 *      The pthread_attr_getschedpolicy() function shall get the 
 *      schedpolicy attribute in the attr argument.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

int pthread_attr_getschedpolicy (const pthread_attr_t *attr,
                                         int *policy)
{
        int ret = 0;

        posix_scheduler_lock();
        
        if (attr == NULL || attr->init != _ATTR_INIT_KEY || policy == NULL )
        {
                ret = EINVAL;
        }
        else
        {
                *policy = attr->schedpolicy;
        }

        posix_scheduler_unlock();

        return ret;
}

