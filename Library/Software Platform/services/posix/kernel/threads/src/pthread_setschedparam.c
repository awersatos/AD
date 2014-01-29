/******************************************************************************
 * FILE:        @(#)pthread_setschedparam.c     1.12 07/02/21
 * DESCRIPTION:
 *      The pthread_setschedparam() function shall set the scheduling policy
 *      and parameters of individual threads within a multi-threaded process
 *      to be retrieved and set. 
 *****************************************************************************/         
#include <pthread.h>
#include <errno.h>
#include <pal.h>
#include "posix_pthread.h"
#include "kernel.h"

int pthread_setschedparam (pthread_t thread_id,
                           int policy, 
                           const struct sched_param *param)
{
        int                     ret = 0;
        posix_thread_t          *thread;

        if( param == NULL               ||
            (policy != SCHED_OTHER  &&
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
             policy != SCHED_SPORADIC &&
#endif
             policy != SCHED_FIFO   &&
             policy != SCHED_RR )   
          )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        if (    policy == SCHED_SPORADIC                                && 
                _posix_sporadic_cleanup_key == PTHREAD_KEY_INVALID_ID)
        {
                pthread_key_create(     &_posix_sporadic_cleanup_key, 
                                        posix_sporadic_cleanup_function );
        }
#endif

        thread = posix_get_thread(thread_id);
        
        if( thread == NULL )
        {
                ret = ESRCH;
        }
        else
        {
                pal_timer_interrupt_stop();
                
                if (thread->schedpolicy != policy)
                {
#if (__POSIX_THREAD_SPORADIC_SERVER != 0 && 0)
                        if (thread->schedpolicy == SCHED_SPORADIC)
                        {
                                /* clean up the budget and 
                                 * replenishment timers */
                                ss_remove_all_timers(thread);
                        }
#endif
                        /* change policy */
                        thread->schedpolicy = policy;
                        /* reset timeslice */
                        thread->timeslice = POSIX_THREADS_TIMESLICE_MAX;
                }

                pal_timer_interrupt_start();

                thread->schedparam = *param;
                posix_thread_set_priority(thread, param->sched_priority);

        }

        posix_scheduler_unlock();

        return ret;
}


