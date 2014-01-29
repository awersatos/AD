/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_setspecific
|*
\*****************************************************************************/

#include <limits.h>
#include <pthread.h>
#include <errno.h>
#include <stdlib.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *      associate a thread-specific value with a key
 *
 *		The pthread_setspecific() function shall associate a thread-specific 
 *		value with a key obtained via a previous call to pthread_key_create(). 
 *		Different threads may bind different values to the same key. 
 *		These values are typically pointers to blocks of dynamically allocated 
 *		memory that have been reserved for use by the calling thread.
 *
 * @param key
 *      key
 * @param pointer
 *      key's associated data
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_setspecific (pthread_key_t key, const void *pointer)
{
        int ret         = 0;
        posix_thread_t *self;
        pthread_key_t   i;
        
        if( posix_valid_key(key)== false )
        {
                ret = EINVAL;
        }
        else
        {
                /* no concurrency problems */
                self = (posix_thread_t * )posix_self_thread();
                
                if( self->thread_data == NULL )
                {
                        /* create it now for the first time */
                        self->thread_data =
                            (void **)malloc(PTHREAD_KEYS_MAX * sizeof(void *));
        
                        for( i  = 0; i < PTHREAD_KEYS_MAX; i++ )
                            self->thread_data[i] = NULL;
                }
        
                self->thread_data[key] = (void *)pointer;
        }
        
        return ret;
}



