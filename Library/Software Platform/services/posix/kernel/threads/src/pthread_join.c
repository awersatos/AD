/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_join
|*
\*****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *		suspends execution of the calling thread until thread terminates
 *	
 *		The pthread_join() function shall suspend execution of the calling 
 *		thread until the target thread terminates, unless the target thread 
 *		has already terminated. On return from a successful pthread_join() 
 *		call with a non-NULL value_ptr argument, the value passed to pthread_exit() 
 *		by the terminating thread shall be made available in the location referenced 
 *		by value_ptr. When a pthread_join() returns successfully, the target thread 
 *		has been terminated. The results of multiple simultaneous calls to pthread_join() 
 *		specifying the same target thread are undefined. 
 *		If the thread calling pthread_join() is canceled, then the target thread 
 *		shall not be detached.
 *
 * @param thread
 *      identity of thread to join
 * @param thread_return
 *		returns the value returned by joined thread  
 * 
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 *
 */
int pthread_join (pthread_t thread, void **thread_return)
{
        int ret                 = 0;
        posix_thread_t          *joinee;
        bool                    reap = false;
        posix_thread_t *self    = (posix_thread_t*)posix_self_thread();
        
        if (thread<0 || thread>=PTHREAD_THREADS_MAX)
        {
                /* non-existing thread */
                return ESRCH;
        }

        /* pthread_join is cancellation point */
        pthread_testcancel();
        
        pthread_mutex_lock(&_posix_threads_mutex);

        joinee  = posix_get_thread(thread);

        if( joinee == NULL )
        {
                /* non-existing thread */
                ret = ESRCH;
        }
        else if ( joinee == self )
        {
                /* cannot join to itself */
                ret = EDEADLK;
        }
        else if ( joinee->joinstate == PTHREAD_JOINSTATE_DETACH ||
                  joinee->joinstate == PTHREAD_JOINSTATE_EXIT   )
        {
                /* joinee run detached || or already exited */
                ret = EINVAL;           
        }
        else
        {
                joinee->joins++;

                if (    joinee->joinstate == PTHREAD_JOINSTATE_FREE ||
                        joinee->joinstate == PTHREAD_JOINSTATE_BUSY )
                {
                        /* joinee could be still running and not still 
                         * joined by another thread */
                        joinee->joinstate = PTHREAD_JOINSTATE_BUSY;
        
                        /* let us sync with the exit of the joinee: 
                         * this is the condition variable*/
                         while( joinee->joinstate == PTHREAD_JOINSTATE_BUSY )
                        {
                                /* wait on the condition variable 
                                 * joinee->joincond.
                                 * it will be broadcasted to all joiners */
                                self->osmutex = 1;
                                 __pthread_cond_timedwait(
                                         &joinee->joincond,
                                         &_posix_threads_mutex,
                                         -1 );

                                 /* pthread_join is cancellation point */
                                 pthread_testcancel();
                        }       
                }       
                
                /* the joinee must have done 'pthread_exit' by now */
                if ( joinee->joinstate == PTHREAD_JOINSTATE_JOIN)
                {
                        /* sync data : return values */
                        if( thread_return != NULL )
                        {
                                *thread_return = joinee->retval;
                        }
                        /* The joinee will be labeled as 'exiting' 
                         * only with the last joiner.
                         * It will freed in next '_alloc_pthread' */
                        if ( --joinee->joins == 0 )
                        {
                                joinee->joinstate = PTHREAD_JOINSTATE_EXIT;
                                _posix_pthread_no_exited++;
                                _posix_pthread_no_joined--;
                        }
                }
        }
        
        pthread_mutex_unlock(&_posix_threads_mutex);


        return ret;
        
}




