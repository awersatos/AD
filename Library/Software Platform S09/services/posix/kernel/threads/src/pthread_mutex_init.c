/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_mutex_init
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      initializes the mutex referenced by mutex
 *
 *		The pthread_mutex_init() function shall initialize the mutex referenced 
 *		by mutex with attributes specified by attr. If attr is NULL, the default 
 *		mutex attributes are used; the effect shall be the same as passing the 
 *		address of a default mutex attributes object. 
 *		Upon successful initialization, the state of the mutex becomes 
 *		initialized and unlocked.
 *
 *		In cases where default mutex attributes are appropriate, the macro 
 *		PTHREAD_MUTEX_INITIALIZER can be used to initialize mutexes that are 
 *		statically allocated. The effect shall be equivalent to dynamic 
 *		initialization by a call to pthread_mutex_init() with parameter attr 
 *		specified as NULL, except that no error checks are performed.
 *
 * @param mutex
 *      pointer to mutex
 * @param attr
 *      pointer to a read-only mutex attributes object
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_mutex_init (pthread_mutex_t *mutex, const pthread_mutexattr_t *attr)
{
        pthread_mutexattr_t     default_attr;
        int                     ret=0;
        
        if (attr==NULL)
        {
                /* default */
                pthread_mutexattr_init(&default_attr);
                attr = &default_attr;
        }
        else if ( attr->init    != _ATTR_INIT_KEY )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if (mutex->initi == _ATTR_INIT_KEY)
        {
                ret = EBUSY;
        }
        else
        {
                mutex->initi            = _ATTR_INIT_KEY;
        }
        
        if (ret==0)
        {
                mutex->type              = attr->type;
                mutex->protocol          = attr->protocol;
#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
                mutex->prioceiling       = attr->prioceiling;
#endif
                mutex->recursive         = 0;
                mutex->preprio           = 0;
#if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
                mutex->inherit           = -1;
#endif
                mutex->owner             = (void*)0;
                mutex->nestup            = (pthread_mutex_t*)0;
                mutex->nestdown          = (pthread_mutex_t*)0;
                mutex->queue.head        = NULL;
                mutex->queue.tail        = NULL;
        }
        
        posix_scheduler_unlock();
        
        return ret;
}
