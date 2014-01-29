/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_key_delete
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"

/**
 * @brief
 *      deletes a thread-specific data key 
 *		
 * 		The pthread_key_delete() function shall delete a thread-specific data 
 *		key previously returned by pthread_key_create(). The thread-specific data 
 *		values associated with key need not be NULL at the time pthread_key_delete() 
 *		is called. It is the responsibility of the application to free any application 
 *		storage or perform any cleanup actions for data structures related to the deleted 
 *		key or associated thread-specific data in any threads; 
 *		this cleanup can be done either before or after pthread_key_delete() is called. 
 *		Any attempt to use key following the call to pthread_key_delete() results 
 *		in undefined behavior.
 *
 * @param key
 *      key's identity
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_key_delete (pthread_key_t key)
{
        if (posix_free_key(key))
        {
                return 0;
        }
        else 
        {
                return EINVAL;
        }
}
