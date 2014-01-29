/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cond_signal
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *      shall unblock at least one of the threads that are blocked on the 
 *		specified condition variable cond (if any threads are blocked on cond).
 *
 * 		If more than one thread is blocked on a condition variable, the scheduling policy shall 
 *		determine the order in which threads are unblocked. When each thread unblocked as a 
 *		result of returns from its call to pthread_cond_wait() or pthread_cond_timedwait(), 
 *		the thread shall own the mutex with which it called pthread_cond_wait() or 
 *		pthread_cond_timedwait(). The thread(s) that are unblocked shall contend for the mutex 
 *		according to the scheduling policy (if applicable), and as if each had called pthread_mutex_lock().
 *		The function shall have no effect if there are no threads currently blocked on cond.
 *
 * @param cond
 *      pointer to condition variable
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_cond_signal(pthread_cond_t *cond)
{
        posix_thread_t* thread;

        /* The caller must have locked the cond's mutex */

        if (cond->initi !=_ATTR_INIT_KEY)
        {
                /* cond has not been initialized */
                return EINVAL;
        }

        if( 
         (thread = (posix_thread_t*)posix_qthread_rm_front(&cond->queue) )
         != NULL 
        )
        {       
                posix_thread_ready(thread,POSIX_WAKE_WAIT_COND);         
        }
        

        return 0;
}


