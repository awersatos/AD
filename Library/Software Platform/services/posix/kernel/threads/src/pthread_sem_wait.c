/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_wait
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>

/**
 * @brief
 *      lock a semaphore
 *
 *      The sem_wait() function shall lock the semaphore referenced by sem by
 *      performing a semaphore lock operation on that semaphore. If the
 *      semaphore value is currently zero, then the calling thread shall not
 *      return from the call to sem_wait() until it either locks the semaphore
 *      or the call is interrupted by a signal.
 *
 *      Upon successful return, the state of the semaphore shall be locked and
 *      shall remain locked until the sem_post() function is executed and
 *      returns successfully.
 *
 *      The sem_wait() function is interruptible by the delivery of a signal.
 *
 * @param sem
 *      pointer to the semaphore
 *
 * @return
 *      The sem_wait() functions shall return zero if the calling process
 *      successfully performed the semaphore lock operation on the semaphore
 *      designated by sem. If the call was unsuccessful, the state of the
 *      semaphore shall be unchanged, and the function shall return a value
 *      of -1 and set errno to indicate the error.
 *
 *      [EDEADLK]
 *           A deadlock condition was detected.
 *      [EINTR]
 *           A signal interrupted this function.
 *      [EINVAL]
 *           The sem argument does not refer to a valid semaphore.
 */
int sem_wait(sem_t *sem)
{
        int result = 0;

        if (!sem)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&sem->mutex))
        {
                if (--(sem->value) < 0)
                {
                        pthread_cond_wait(&sem->cond, &sem->mutex);
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

