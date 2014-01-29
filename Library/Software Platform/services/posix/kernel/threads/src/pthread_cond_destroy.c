/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cond_destroy
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      destroys the given condition variable specified by cond
 *
 *		The pthread_cond_destroy() function shall destroy the given condition 
 *		variable specified by cond; the object becomes, in effect, uninitialized. 
 *		An implementation may cause pthread_cond_destroy() to set the object 
 *		referenced by cond to an invalid value. A destroyed condition variable object 
 *		can be reinitialized using pthread_cond_init(); the results of otherwise 
 *		referencing the object after it has been destroyed are undefined.
 *
 * @param cond
 *      pointer to condition variable
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_cond_destroy(pthread_cond_t *cond)
{
        int                     ret = 0;
        
        if (cond==NULL)
        {
                return EINVAL;
        }

        posix_scheduler_lock();
        
        if ( cond->initi != _ATTR_INIT_KEY )
        {
                /* The value specified by cond is invalid.*/
                ret = EINVAL;
        } else if ( cond->queue.head != NULL )
        {
                /* threads are blocked on the condition */
                ret = EBUSY;
        }
        else 
        {
                cond->initi = 0;
        }
        
        posix_scheduler_unlock();

        return ret;
}



