/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_mutex_lock
|*
\*****************************************************************************/

#include <pthread.h>
#include <stdbool.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *      locks the mutex object referenced by mutex
 *
 *		The mutex object referenced by mutex shall be locked by calling pthread_mutex_lock(). 
 *		If the mutex is already locked, the calling thread shall block until the mutex 
 *		becomes available. This operation shall return with the mutex object referenced 
 *		by mutex in the locked state with the calling thread as its owner.
 *		If the mutex type is PTHREAD_MUTEX_ERRORCHECK, then error checking shall be provided. 
 *		If the mutex type is PTHREAD_MUTEX_RECURSIVE, then the mutex shall maintain 
 *		the concept of a lock count. If the mutex type is PTHREAD_MUTEX_DEFAULT, attempting to 
 *		recursively lock the mutex results in undefined behavior.
 *		If the mutex type is PTHREAD_MUTEX_ERRORCHECK, then error checking shall be provided.
 *
 * @param mutex
 *      pointer to the mutex variable
 *
 * @return
 * 		The funtion shall return zero if a lock on the mutex object referenced 
 *		by mutex is acquired. Otherwise, an error number is returned to indicate 
 *		the error.
 */
int pthread_mutex_lock(pthread_mutex_t *mutex)
{
        if (mutex == NULL)
        {
                /* The value specified by mutex does not refer to 
                 * an initialized mutex object */
                return EINVAL;
        }

        return  __pthread_mutex_timedlock(mutex, -1, 0);
}
