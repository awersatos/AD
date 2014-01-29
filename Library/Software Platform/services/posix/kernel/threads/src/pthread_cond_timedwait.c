/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cond_timedwait
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "posix_time.h"

/**
 * @brief
 *      blocks on a condition variable (with timeout)
 *
 * 		The function shall be equivalent to pthread_cond_wait(), except that an 
 *		error is returned if the absolute time specified by abstime passes 
 *		(that is, system time equals or exceeds abstime) before the condition 
 *		cond is signaled or broadcasted, or if the absolute time specified by 
 *		abstime has already been passed at the time of the call.
 *
 * 		The condition variable shall have a clock attribute which specifies the 
 *		clock that shall be used to measure the time specified by the abstime argument. 
 *		When such timeouts occur, the funtion shall nonetheless release and re-acquire 
 *		the mutex referenced by mutex. 
 *		The pthread_cond_timedwait() function is also a cancellation point.
 *
 * @param cond
 *      pointer to condition variable
 * @param mutex
 *		pointer to mutex
 * @param abstime
 *		pointer to read-only timeout information
 *
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */

#if ( __POSIX_TIMEOUTS != 0 )

int pthread_cond_timedwait(pthread_cond_t *cond, pthread_mutex_t *mutex, const struct timespec * abstime)
{
        clock_t                 trigger;
        int                     retval;
        if ( cond               == (pthread_cond_t *)NULL       || 
                 mutex          == (pthread_mutex_t *)NULL      ||
                 abstime        == (struct timespec *)NULL)
        { 
                return EINVAL; 
        }
        
        trigger                 = posix_timespec_to_ticks (&_posix_system_clock,abstime);

        retval = __pthread_cond_timedwait(cond,mutex,trigger);
        /* cancellation point */
        pthread_testcancel();
        if (retval==EINTR)
        {
                /* If a signal is delivered to a thread waiting for a 
                 * condition variable, upon return from the signal handler
                 * the thread resumes returning zero due to spurious wakeup 
                 */
                retval = 0;
        }

        return retval;  
}

#endif



