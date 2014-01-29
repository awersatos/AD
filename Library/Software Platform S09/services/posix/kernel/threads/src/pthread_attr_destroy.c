/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_destroy
|*
\*****************************************************************************/

#include <errno.h>
#include <limits.h>
#include <pthread.h>
#include <sys/types.h>
#include "kernel.h"

/**
 * @brief
 *      destroy a thread's attributes object
 *
 *      The pthread_attr_destroy() function shall destroy a thread 
 *      attributes object. An implementation may cause pthread_attr_destroy() 
 *      to set attr to an implementation-defined invalid value. 
 *      A destroyed attr attributes object can be reinitialized using
 *      pthread_attr_init(); the results of otherwise referencing the object
 *      after it has been destroyed are undefined.
 * 
 * @param attr
 *      pointer to the thread's attribute object
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */

int pthread_attr_destroy (pthread_attr_t *attr)
{
        int ret = 0;

        if (attr == NULL) 
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();

        if (attr->init != _ATTR_INIT_KEY)
        {
                ret = EINVAL;
        }
        else
        {
                attr->init = 0;
        }       
        
        posix_scheduler_unlock();       
        
    return ret;
}


