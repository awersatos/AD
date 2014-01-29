/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_getvalue
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>

/**
 * @brief
 *      get the value of a semaphore
 *
 *      The sem_getvalue() function shall update the location referenced by the
 *      sval argument to have the value of the semaphore referenced by sem
 *      without affecting the state of the semaphore. The updated value
 *      represents an actual semaphore value that occurred at some unspecified
 *      time during the call, but it need not be the actual value of the
 *      semaphore when it is returned to the calling process.
 *
 *      If sem is locked, then the object to which sval points shall either be
 *      set to zero or to a negative number whose absolute value represents the
 *      number of processes waiting for the semaphore at some unspecified time
 *      during the call.
 *
 * @param sem
 *      pointer to the semaphore
 * @param sval
 *      semaphore value
 *
 * @return
 *      Upon successful completion, the sem_getvalue() function shall return a
 *      value of zero. Otherwise, it shall return a value of -1 and set errno
 *      to indicate the error.
 *
 *      [EINVAL]
 *           The sem argument does not refer to a valid semaphore.
 */
int sem_getvalue(sem_t *restrict sem, int *restrict sval)
{
        int result = 0;

        if (!sem || !sval)
        {
                result = EINVAL;
        }
        else if (!pthread_mutex_lock(&sem->mutex))
        {
                *sval = sem->value;
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

