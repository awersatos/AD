/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_trywait
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>

/**
 * @brief
 *      lock a semaphore
 *
 *      The sem_trywait() function shall lock the semaphore referenced by sem
 *      only if the semaphore is currently not locked; that is, if the semaphore
 *      value is currently positive. Otherwise, it shall not lock the semaphore.
 *
 *      Upon successful return, the state of the semaphore shall be locked and
 *      shall remain locked until the sem_post() function is executed and
 *      returns successfully.
 *
 * @param sem
 *      pointer to the semaphore
 *
 * @return
 *      The sem_trywait() functions shall return zero if the calling process
 *      successfully performed the semaphore lock operation on the semaphore
 *      designated by sem. If the call was unsuccessful, the state of the
 *      semaphore shall be unchanged, and the function shall return a value
 *      of -1 and set errno to indicate the error.
 *
 *      [EAGAIN]
 *           The semaphore was already locked, so it cannot be immediately
 *           locked.
 *      [EDEADLK]
 *           A deadlock condition was detected.
 *      [EINTR]
 *           A signal interrupted this function.
 *      [EINVAL]
 *           The sem argument does not refer to a valid semaphore.
 */
int sem_trywait(sem_t *sem)
{
        int result = 0;

        if (!sem)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&sem->mutex))
        {
                if (sem->value > 0)
                        (sem->value)--;
                else
                        result = EAGAIN;
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

