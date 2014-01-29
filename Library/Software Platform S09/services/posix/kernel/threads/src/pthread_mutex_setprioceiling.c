/*****************************************************************************
 * FILE:        @(#)pthread_mutex_setprioceiling.c      1.7 07/02/21
 * DESCRIPTION:
 *      The 'pthread_mutex_setprioceiling()' function shall either lock the 
 *      mutex if it is unlocked, or block until it can successfully lock 
 *      the mutex, then it shall change the mutex's priority ceiling 
 *      and release the mutex. 
  *****************************************************************************/
#include <errno.h>
#include <pthread.h>
#include <sys/types.h>
#include "kernel.h"

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )

int pthread_mutex_setprioceiling( pthread_mutex_t *mutex, 
                int prioceiling,int *old_ceiling)
{
        if ( mutex == NULL || old_ceiling == NULL       || 
             prioceiling <  SCHED_PRIORITY_MIN  ||
             prioceiling >  SCHED_PRIORITY_MAX )
        {
                return EINVAL;
        }
                
        posix_scheduler_lock();
        *old_ceiling = mutex->prioceiling;
        mutex->prioceiling = prioceiling;
        posix_scheduler_unlock();

        return 0;
}

#endif

