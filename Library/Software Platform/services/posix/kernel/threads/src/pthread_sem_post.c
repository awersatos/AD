/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_post
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>

/**
 * @brief
 *      unlock a semaphore
 *
 *      The sem_post() function shall unlock the semaphore referenced by sem by
 *      performing a semaphore unlock operation on that semaphore.
 *
 *      If the semaphore value resulting from this operation is positive, then
 *      no threads were blocked waiting for the semaphore to become unlocked;
 *      the semaphore value is simply incremented.
 *
 *      If the value of the semaphore resulting from this operation is zero,
 *      then one of the threads blocked waiting for the semaphore shall be
 *      allowed to return successfully from its call to sem_wait(). If the
 *      Process Scheduling option is supported, the thread to be unblocked
 *      shall be chosen in a manner appropriate to the scheduling policies and
 *      parameters in effect for the blocked threads. In the case of the
 *      schedulers SCHED_FIFO and SCHED_RR, the highest priority waiting thread
 *      shall be unblocked, and if there is more than one highest priority
 *      thread blocked waiting for the semaphore, then the highest priority
 *      thread that has been waiting the longest shall be unblocked. If the
 *      Process Scheduling option is not defined, the choice of a thread to
 *      unblock is unspecified.
 *
 *      If the Process Sporadic Server option is supported, and the scheduling
 *      policy is SCHED_SPORADIC, the semantics are as per SCHED_FIFO above.
 *
 *      The sem_post() function shall be reentrant with respect to signals and
 *      may be invoked from a signal-catching function.
 *
 * @param sem
 *      pointer to the semaphore
 *
 * @return
 *      If successful, the sem_post() function shall return zero; otherwise,
 *      the function shall return -1 and set errno to indicate the error.
 *
 *      [EINVAL]
 *           The sem argument does not refer to a valid semaphore.
 */
int sem_post(sem_t *sem)
{
        int result = 0;

        if (!sem)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&sem->mutex))
        {
                if (++(sem->value) <= 0)
                {
                        pthread_cond_signal(&(sem->cond));
                }
                pthread_mutex_unlock(&sem->mutex);
        }
        else
        {
                result = EINVAL;
        }

        if (result)
        {
                errno = result;
                return -1;
        }
        return 0;
}

