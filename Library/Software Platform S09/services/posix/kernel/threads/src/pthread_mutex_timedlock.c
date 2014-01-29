/******************************************************************************
 * FILE:        @(#)pthread_mutex_timedlock.c   1.9 07/06/06
 * DESCRIPTION:
 *       The pthread_mutex_timedlock() function shall lock the mutex object
 *       referenced by mutex. 
 *****************************************************************************/
#include <pthread.h>
#include <stdbool.h>
#include <errno.h>
#include "posix_pthread.h"
#include "posix_time.h"
#include "kernel.h"

#if ( __POSIX_TIMEOUTS != 0 )

int pthread_mutex_timedlock(    pthread_mutex_t *mutex,
                                const struct timespec * abstime )
{
        clock_t                 trigger;

        if ( mutex      == (pthread_mutex_t *)NULL      ||
             abstime    == (struct timespec *)NULL)
        { 
                return EINVAL; 
        }
        
        trigger = posix_timespec_to_ticks (&_posix_system_clock,abstime);

        return  __pthread_mutex_timedlock(mutex, trigger, 0);
}

#endif
