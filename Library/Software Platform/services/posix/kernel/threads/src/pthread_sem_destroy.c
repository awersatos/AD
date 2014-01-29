/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    pthread_sem_destroy
|*
\*****************************************************************************/

#include <pthread.h>
#include <semaphore.h>
#include <errno.h>

/**
 * @brief
 *      destroy an unnamed semaphore
 *
 *      The sem_destroy() function shall destroy the unnamed semaphore
 *      indicated by sem. Only a semaphore that was created using sem_init()
 *      may be destroyed using sem_destroy(); the effect of calling
 *      sem_destroy() with a named semaphore is undefined. The effect of
 *      subsequent use of the semaphore sem is undefined until sem is
 *      reinitialized by another call to sem_init().
 *
 *      It is safe to destroy an initialized semaphore upon which no threads
 *      are currently blocked. The effect of destroying a semaphore upon which
 *      other threads are currently blocked is undefined.
 *
 * @param sem
 *      pointer to the unnamed semaphore
 *
 * @return
 *      Upon successful completion, a value of zero shall be returned.
 *      Otherwise, a value of -1 shall be returned and errno set to indicate
 *      the error.
 *
 *      [EINVAL]
 *           The sem argument is not a valid semaphore.
 *      [EBUSY]
 *           There are currently processes blocked on the semaphore.
 */
int sem_destroy(sem_t *sem)
{
        if (!sem) { errno = EINVAL; return -1; }

        pthread_cond_destroy(&(sem->cond));
        pthread_mutex_destroy(&(sem->mutex));

        return 0;
}

