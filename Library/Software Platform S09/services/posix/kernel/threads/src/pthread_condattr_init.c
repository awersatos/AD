/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_condattr_init
|*
\*****************************************************************************/


#include <errno.h>
#include <pthread.h>
#include <sys/types.h>
#include "kernel.h"

/**
 * @brief
 *      initializes a condition variable's attribute object
 *
 *		The pthread_condattr_init() function shall initialize a condition variable 
 *		attributes object attr with the default value for all of the attributes 
 *		defined by the implementation.
 *		Results are undefined if pthread_condattr_init() is called specifying 
 *		an already initialized attr attributes object.
 *		After a condition variable attributes object has been used to initialize 
 *		one or more condition variables, any function affecting the attributes 
 *		object (including destruction) shall not affect any previously initialized 
 *		condition variables.
 *
 * @param attr
 *      pointer to conditional variable's attributes object
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_condattr_init(pthread_condattr_t *attr)
{
        int ret = 0;

        if (attr == NULL)
        {
                return EINVAL;
        }

        posix_scheduler_lock();
        
        if (attr->init == _ATTR_INIT_KEY)
        {
                /* results are undefined: we return this error */
                ret = EBUSY;
        }
        else
        {
                /* no conditional variable attributes currently */
                attr->init              = _ATTR_INIT_KEY;
                attr->clock_id          = CLOCK_REALTIME;
        }
        
        posix_scheduler_unlock();

        return ret;
}

