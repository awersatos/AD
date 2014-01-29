/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_key_create
|*
\*****************************************************************************/


#include <limits.h>
#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"


/**
 * @brief
 *      creates a thread-specific data key 
 *		
 *		Key values provided by pthread_key_create() are opaque objects used to 
 *		locate thread-specific data. Although the same key value may be used by 
 *		different threads, the values bound to the key by pthread_setspecific() 
 *		are maintained on a per-thread basis and persist for the life of the 
 *		calling thread.
 *		At thread exit, if a key value has a non-NULL destructor pointer, 
 *		and the thread has a non-NULL value associated with that key, 
 *		the value of the key is set to NULL, and then the function pointed to is 
 *		called with the previously associated value as its sole argument. 
 *		The order of destructor calls is unspecified if more than one destructor 
 *		exists for a thread when it exits.

 * @param key
 *      return parameter holding the created key identity
 * @param destructor
 *		destructor routine associated with the key
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_key_create(pthread_key_t *key, void (*destructor)(void*))
{
        int             ret = 0;
        pthread_t       thread;

        pthread_mutex_lock(&_posix_threads_mutex);

        if ( !posix_alloc_key(destructor, key) )
        {
                ret = EAGAIN;
        }
        else
        {
                for (thread = 0; thread < PTHREAD_THREADS_MAX; thread++)
                {
                        posix_thread_t *pthread = _posix_thread_table[thread];

                        if (pthread != NULL && pthread->thread_data != NULL)
                        {
                                pthread->thread_data[*key] = NULL;
                        }
                }
        }

        pthread_mutex_unlock(&_posix_threads_mutex);

        return ret;

}




