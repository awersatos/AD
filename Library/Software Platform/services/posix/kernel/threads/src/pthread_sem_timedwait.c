/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_timedwait
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>

/**
 * @brief
 *      lock a semaphore
 *
 *      The sem_timedwait() function shall lock the semaphore referenced by sem
 *      as in the sem_wait() function. However, if the semaphore cannot be
 *      locked without waiting for another process or thread to unlock the
 *      semaphore by performing a sem_post() function, this wait shall be
 *      terminated when the specified timeout expires.
 *      The timeout shall expire when the absolute time specified by abs_timeout
 *      passes, as measured by the clock on which timeouts are based (that is,
 *      when the value of that clock equals or exceeds abs_timeout), or if the
 *      absolute time specified by abs_timeout has already been passed at the
 *      time of the call.
 *      If the Timers option is supported, the timeout shall be based on the
 *      CLOCK_REALTIME clock. If the Timers option is not supported, the timeout
 *      shall be based on the system clock as returned by the time() function.
 *      The resolution of the timeout shall be the resolution of the clock on
 *      which it is based. The timespec data type is defined as a structure in
 *      the <time.h> header.
 *
 *      Under no circumstance shall the function fail with a timeout if the
 *      semaphore can be locked immediately. The validity of the abs_timeout
 *      need not be checked if the semaphore can be locked immediately.
 *
 * @param sem
 *      pointer to the semaphore
 * @param abs_timeout
 *      timeout
 *
 * @return
 *      The sem_timedwait() function shall return zero if the calling process
 *      successfully performed the semaphore lock operation on the semaphore
 *      designated by sem. If the call was unsuccessful, the state of the
 *      semaphore shall be unchanged, and the function shall return a value
 *      of -1 and set errno to indicate the error.
 *
 *      [EINVAL]
 *           The process or thread would have blocked, and the abs_timeout
 *           parameter specified a nanoseconds field value less than zero or
 *           greater than or equal to 1000 million.
 *      [ETIMEDOUT]
 *           The semaphore could not be locked before the specified timeout expired.
 *      [EDEADLK]
 *           A deadlock condition was detected.
 *      [EINTR]
 *           A signal interrupted this function.
 *      [EINVAL]
 *           The sem argument does not refer to a valid semaphore.
 */

#if ( __POSIX_TIMEOUTS != 0 )

int sem_timedwait(sem_t *restrict sem,
       const struct timespec *restrict abs_timeout)
{
        int result = 0;

        if (!sem || !abs_timeout)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&sem->mutex))
        {
                if (--(sem->value) < 0)
                {
                        if (pthread_cond_timedwait(&sem->cond, &sem->mutex, abs_timeout))
                        {
                                ++(sem->value);
                                result = ETIMEDOUT;
                        }
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

#endif
