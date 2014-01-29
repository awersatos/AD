/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_mutex_destroy
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      destroys the mutex variable referenced by mutex
 *
 * 		The pthread_mutex_destroy() function shall destroy the mutex object 
 *		referenced by mutex; the mutex object becomes, in effect, uninitialized. 
 *		An implementation may cause pthread_mutex_destroy() to set the object 
 *		referenced by mutex to an invalid value. A destroyed mutex object can 
 *		be reinitialized using pthread_mutex_init(); the results of otherwise 
 *		referencing the object after it has been destroyed are undefined.
 *		It shall be safe to destroy an initialized mutex that is unlocked. 
 *		Attempting to destroy a locked mutex results in undefined behavior.
 *
 * @param mutex
 *      pointer to mutex
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_mutex_destroy(pthread_mutex_t *mutex)
{
        int                     ret = 0;
        
        if (mutex==NULL)
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();

        if (mutex->initi != _ATTR_INIT_KEY)
        {
                /* The value specified by mutex is invalid */
                ret = EINVAL;
        }
        else if (mutex->owner != NULL)
        {
                /* mutex has been acquired */
                ret = EBUSY;
        }
        else
        {
                mutex->initi = 0;
        }
        
        posix_scheduler_unlock();
        
        return ret;
}


