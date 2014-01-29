/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_mutex_trylock
|*
\*****************************************************************************/

#include <pthread.h>
#include <stdbool.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *      tries to lock the mutex object referenced by mutex
 *
 *		The pthread_mutex_trylock() function shall be equivalent to pthread_mutex_lock(), 
 *		except that if the mutex object referenced by mutex is currently locked 
 *		(by any thread, including the current thread), the call shall return immediately. 
 *		If the mutex type is PTHREAD_MUTEX_RECURSIVE and the mutex is currently owned by 
 *		the calling thread, the mutex lock count shall be incremented by one and the 
 *		pthread_mutex_trylock() function shall immediately return success.
 *
 * @param mutex
 *      pointer to the mutex variable
 *
 * @return
 * 		The funtion shall return zero if a lock on the mutex object referenced 
 *		by mutex is acquired. Otherwise, an error number is returned to indicate 
 *		the error.
 */
int pthread_mutex_trylock(pthread_mutex_t *mutex)
{
	if (mutex == NULL)
	{
		/* The value specified by mutex does not refer to
		 * an initialized mutex object */
		return EINVAL;
	}

	return __pthread_mutex_timedlock(mutex, -1, 1);
}
