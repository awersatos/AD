/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_setprioceiling.c 1.7
 * DESCRIPTION:
 *      The 'pthread_mutexattr_setprioceiling()' function shall  set 
 *      the priority ceiling attribute of a mutex attributes object 
 *      pointed to by attr which was previously created by the 
 *      function 'pthread_mutexattr_init()'.
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include <limits.h>
#include "kernel.h"

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )

int pthread_mutexattr_setprioceiling(pthread_mutexattr_t *attr,
                        int prioceiling)
{
        int ret = 0;
        
        if ( attr == NULL || prioceiling <  SCHED_PRIORITY_MIN  ||
                             prioceiling >  SCHED_PRIORITY_MAX )
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();

        if (attr->init != _ATTR_INIT_KEY)
        {
                ret = EINVAL; 
        }
        else
        {
                attr->prioceiling = prioceiling;
        }
        
        posix_scheduler_unlock();

        return ret;
}

#endif

