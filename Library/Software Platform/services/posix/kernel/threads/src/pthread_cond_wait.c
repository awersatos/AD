/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cond_wait
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"

/**
 * @brief
 *      blocks on a condition variable (with timeout)
 *
 *		The function shall be called with mutex locked by the calling thread or undefined 
 *		behavior results. These functions atomically release mutex and cause the calling 
 *		thread to block on the condition variable cond; atomically here means "atomically 
 *		with respect to access by another thread to the mutex and then the condition variable"
 * 		Upon successful return, the mutex shall have been locked and shall be owned 
 *		by the calling thread.
 *
 *		When using condition variables there is always a Boolean predicate involving 
 *		shared variables associated with each condition wait that is true if the thread 
 *		should proceed. Spurious wakeups may occur and since the return from 
 *		pthread_cond_timedwait() or pthread_cond_wait() does not imply anything about 
 *		the value of this predicate, the predicate should be re-evaluated upon such return.
 *
 *		During the condition/mutex bindind time, the effect of an attempt by any thread 
 *		to wait on that condition variable using a different mutex is undefined. 
 *
 * 		A condition wait (whether timed or not) is a cancellation point.
 *		
 *		A thread that has been unblocked because it has been canceled while blocked in a 
 *		call to pthread_cond_timedwait() or pthread_cond_wait() shall not consume any condition 
 *		signal that may be directed concurrently at the condition variable if there are 
 *		other threads blocked on the condition variable. 
 *
 * @param cond
 *      pointer to condition variable
 * @param mutex
 *		pointer to mutex
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_cond_wait(pthread_cond_t * cond, pthread_mutex_t *mutex)
{

        int retval;
        if ( cond == (pthread_cond_t *)0 || mutex == (pthread_mutex_t *)0 )
        { 
                return EINVAL; 
        }

        retval =  __pthread_cond_timedwait(cond,mutex,-1);

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

