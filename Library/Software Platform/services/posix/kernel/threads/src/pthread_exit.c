/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_exit
|*
\*****************************************************************************/

#include <pthread.h>
#include <limits.h>
#include <stdlib.h>
#include "posix_pthread.h"
#include "posix_time.h"
#include "kernel.h"
#include "k_schedule.h"

/**
 * @brief
 *      terminates the calling thread
 *
 *      The pthread_exit() function shall terminate the calling thread and
 *      make the value value_ptr available to any successful join with the
 *      terminating thread. Any cancellation cleanup handlers that have been
 *      pushed and not yet popped shall be popped in the reverse order that
 *      they were pushed and then executed. After all cancellation cleanup
 *      handlers have been executed, if the thread has any thread-specific data,
 *      appropriate destructor functions shall be called in an unspecified order.
 *      Thread termination does not release any application visible process resources,
 *      including, but not limited to, mutexes and file descriptors, nor does it
 *      perform any process-level cleanup actions, including, but not limited to,
 *      calling any atexit() routines that may exist.
 *      An implicit call to pthread_exit() is made when a thread other than the
 *      thread in which main() was first invoked returns from the start routine
 *      that was used to create it. The function's return value shall serve as
 *      the thread's exit status.
 *      The behavior of pthread_exit() is undefined if called from a cancellation
 *      cleanup handler or destructor function that was invoked as a result of
 *      either an implicit or explicit call to pthread_exit().
 *
 * @param retval
 *      thread's return value
 *
 */
void pthread_exit(void *retval)
{
    int             key;
    void            *pointer;
    bool            one_destructor;
    int             iterations = 0;
    posix_thread_t  *self = (posix_thread_t *)posix_self_thread();

    /* cancellation handlers */
    while (self->cancelbuffer != NULL)
    {
        struct pthread_cleanup_buffer *buffer;

        buffer = self->cancelbuffer;
        self->cancelbuffer = buffer->prev;
        buffer->routine(buffer->arg);
    }

    /*  per-thread data */
    if (self->thread_data != NULL)
    {
        do
        {
            one_destructor = false;

            /* all keys */
            for (key = 0; key < PTHREAD_KEYS_MAX; key++)
            {
                /* skip unallocated keys */
                if (_posix_key_table[key].alloc == 0)
                {
                    continue;
                }

                /* and NULL destructors */
                if (_posix_key_table[key].destructor == NULL)
                {
                    continue;
                }

                /* and NULL data values */
                if ((pointer = self->thread_data[key]) == NULL)
                {
                    continue;
                }

                self->thread_data[key]  = NULL;
                _posix_key_table[key].destructor(pointer);
                one_destructor = true;
            }

            iterations++;
        } while (one_destructor && iterations <= PTHREAD_DESTRUCTOR_ITERATIONS);
        free(self->thread_data);
    }

    /* We were using here:
     *      pthread_mutex_lock(&_threads_mutex);
     * But this gave us problems when 'pthread_exit' was reached
     * after returning from a thread with a local mutex still
     * locked by the exiting thread.
     * The validity of the mutex cannot be guaranteed since
     * the compiler could modify the stack in the 'ret'.
     * Locking the scheduler is safer.
     */
    posix_scheduler_lock();

    self->retval = retval;

    if (self->joinstate == PTHREAD_JOINSTATE_DETACH)
    {
        /* thread wont join */
        self->joinstate = PTHREAD_JOINSTATE_EXIT;
        /* pthread exits instead */
        _posix_pthread_no_exited++;
    }
    else if ( self->joinstate == PTHREAD_JOINSTATE_BUSY     ||
              self->joinstate == PTHREAD_JOINSTATE_FREE      )
    {
        /* thread is now joining */
        self->joinstate = PTHREAD_JOINSTATE_JOIN;
        _posix_pthread_no_joined++;

        /* signal to all possible joiners that this
         * thread is exiting */
        pthread_cond_broadcast(&self->joincond);
    }

    /* thread could not possibly be in JOIN or in EXIT */
#if (__POSIX_SIGNALS != 0)
    /* thread wont catch anymore signals */
    self->sigmask = ~0;
#endif
#if (__POSIX_THREAD_CPUTIME != 0)
    /*  */
    self->clock.active = NULL;
    self->btime  = 0;
#endif
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
    if (self->schedpolicy == POSIX_SCHED_SPORADIC)
    {
        ss_remove_all_timers(self);
        posix_free_timer(self->end_of_budget);
        self->end_of_budget = -1;
        for (int i = 0; i < self->schedparam.sched_ss_max_repl; i++)
        {
            posix_free_timer(self->repl[i]);
        }
        free(self->repl);
        self->repl = NULL;
    }
#endif

    /* If the only remaining threads are in join operations, the system
     * wont do anything else enymore (no thread creation from
     * interrupt level, thus, we simply exit here ) */
    if (_posix_pthread_no_exited + _posix_pthread_no_joined == _posix_pthread_no_active)
    {
        exit(0);
    }

    /* terminate actions at kernel level and re-schedule */
    posix_thread_exit();

    /* never here */
}

