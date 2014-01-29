/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_init
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>

/**
 * @brief
 *      initialize an unnamed semaphore
 *
 *      The sem_init() function shall initialize the unnamed semaphore referred
 *      to by sem. The value of the initialized semaphore shall be value.
 *      Following a successful call to sem_init(), the semaphore may be used in
 *      subsequent calls to sem_wait(), sem_timedwait(), sem_trywait(),
 *      sem_post(), and sem_destroy(). This semaphore shall remain usable until
 *      the semaphore is destroyed.
 *
 *      If the pshared argument has a non-zero value, then the semaphore is
 *      shared between processes; in this case, any process that can access the
 *      semaphore sem can use sem for performing operations.
 *
 *      If the pshared argument is zero, then the semaphore is shared between
 *      threads of the process; any thread in this process can use sem for
 *      performing operations. The use of the semaphore by threads other than
 *      those created in the same process is undefined.
 *
 *      Only sem itself may be used for performing synchronization. The result
 *      of referring to copies of sem is undefined.
 *
 *      Attempting to initialize an already initialized semaphore results in
 *      undefined behavior.
 *
 * @param sem
 *      pointer to the unnamed semaphore
 * @param pshared
 *      processes shared flag ( see description )
 * @param value
 *      value for the semaphore to be initialized
 *
 * @return
 *      Upon successful completion, the sem_init() function shall initialize
 *      the semaphore in sem. Otherwise, it shall return -1 and set errno
 *      to indicate the error.
 *
 *      [EINVAL]
 *           The value argument exceeds {SEM_VALUE_MAX}.
 *      [ENOSPC]
 *           A resource required to initialize the semaphore has been exhausted,
 *           or the limit on semaphores ({SEM_NSEMS_MAX}) has been reached.
 *      [EPERM]
 *           The process lacks the appropriate privileges to initialize the
 *           semaphore.
 */
int sem_init(sem_t *sem, int pshared, unsigned value)
{
        int result = 0;

        if (!sem || (value > SEM_VALUE_MAX))
        {
                result = EINVAL;
        }
        else
        {
                /* Ignore pshared */

                pthread_mutex_init(&(sem->mutex), NULL);
                pthread_cond_init(&(sem->cond), NULL);
                sem->value = value;
        }

        if (result)
        {
                errno = result;
                return -1;
        }
        return 0;
}
