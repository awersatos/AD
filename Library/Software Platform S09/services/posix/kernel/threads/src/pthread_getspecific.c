/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_getspecific
|*
\*****************************************************************************/


#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *      returns the value currently bound to the specified key 
 *
 * @param key
 *      key
 *
 * @return
 *		The pthread_getspecific() function shall return the thread-specific data 
 *		value associated with the given key. If no thread-specific data value 
 *		is associated with key, then the value NULL shall be returned.
 */
void *pthread_getspecific (pthread_key_t key)
{
        void*           ret;
        posix_thread_t* self;
        
        if( posix_valid_key(key)==false )
        {
                ret = NULL;
        }
        else
        {
                /* no concurrency problems */
                self = (posix_thread_t *)posix_self_thread();
                
                if( self->thread_data == NULL )
                {
                        ret = NULL;
                }
                else 
                {       
                        ret = self->thread_data[key];
                }
        }

        return ret;
}

