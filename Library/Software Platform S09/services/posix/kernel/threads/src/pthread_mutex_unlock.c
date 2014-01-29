/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_mutex_unlock
|*
\*****************************************************************************/

#include <pthread.h>
#include <stdbool.h>
#include <errno.h>
#include "kernel.h"
#include "posix_pthread.h"
#include "posix_time.h"

/**
 * @brief
 *      releases the mutex object referenced by mutex
 *
 *      The pthread_mutex_unlock() function shall release the mutex object
 *      referenced by mutex. The manner in which a mutex is released is
 *      dependent upon the mutex's type attribute. If there are threads
 *      blocked on the mutex object referenced by mutex when pthread_mutex_unlock()
 *      is called, resulting in the mutex becoming available, the scheduling policy
 *      shall determine which thread shall acquire the mutex.
 *
 * @param mutex
 *      pointer to the mutex variable
 *
 * @return
 *      Upon successful completion it shall return a value of 0; otherwise, an error number
 *      shall be returned to indicate the error.
 */
int pthread_mutex_unlock(pthread_mutex_t *mutex)
{
    posix_thread_t *self    = (posix_thread_t*)posix_self_thread();
    posix_thread_t *thread;
    int            priority = posix_self_priority();

    posix_scheduler_lock();

    if (mutex == NULL)
    {
        /* The value specified by mutex does not refer
         * to an initialized mutex object */
        posix_scheduler_unlock();
        return EINVAL;
    }

    if (mutex->type == PTHREAD_MUTEX_ERRORCHECK || mutex->type == PTHREAD_MUTEX_RECURSIVE)
    {
        if (mutex->owner == NULL)
        {
            /* A thread attempting to unlock an unlocked mutex shall return with an error */
            posix_scheduler_unlock();
            return EINVAL;
        }
        if (mutex->owner != self)
        {
            /* A thread attempting to unlock a mutex which
             * another thread has locked shall return with
             *  an error */
            posix_scheduler_unlock();
            return EPERM;
        }
    }

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
    if (mutex->protocol == PTHREAD_PRIO_PROTECT && priority < mutex->prioceiling)
    {
        /* wrong priority access to mutex */
        posix_scheduler_unlock();
        return EINVAL;
    }
#endif

    if (mutex->type == PTHREAD_MUTEX_RECURSIVE)
    {
        if (mutex->owner == (void*)self)
        {
            /* Multiple locks of this mutex shall require the
             * same number of unlocks to release the mutex
             * before another thread can acquire the mutex */
            if (mutex->recursive)
            {
                mutex->recursive--;
            }
        }
    }

    if (mutex->recursive == 0)
    {

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
        if (mutex->protocol == PTHREAD_PRIO_PROTECT)
        {
            if (priority > mutex->prioceiling)
            {
                posix_thread_set_priority(self, mutex->preprio);
            }
        }
        else
        {
#endif
            if (!posix_qthread_empty(&mutex->queue))
            {
                thread = (posix_thread_t*)posix_qthread_rm_front(&mutex->queue);
#if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
                if (mutex->protocol == PTHREAD_PRIO_INHERIT)
                {
                    posix_thread_set_priority(thread, mutex->inherit);
                }
#endif
                posix_thread_ready(thread, POSIX_WAKE_WAIT_MUTEX);
            }

#if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
            if (mutex->protocol == PTHREAD_PRIO_INHERIT)
            {
                if (mutex->nestup == NULL)
                {
                    posix_thread_set_priority(self, mutex->preprio);
                }
                else
                {
                    mutex->nestup->nestdown = NULL;
                    if (mutex->nestup->inherit != -1)
                    {
                        posix_thread_set_priority(self, mutex->nestup->inherit);
                    }
                    else
                    {
                        posix_thread_set_priority(self, mutex->preprio);
                    }
                }
            }
#endif

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
        }
#endif

        /* release mutex */
        self->mutex = mutex->nestup;
        mutex->nestup = NULL;
        mutex->owner = NULL;
        mutex->preprio = 0;
#if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
        mutex->inherit  = -1;
#endif
    }

    posix_scheduler_unlock();

    return 0;
}

