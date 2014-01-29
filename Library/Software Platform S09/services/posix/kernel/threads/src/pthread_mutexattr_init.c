/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_mutexattr_init
|*
\*****************************************************************************/
#include <errno.h>
#include <pthread.h>
#include <sys/types.h>
#include "kernel.h"

/**
 * @brief
 *      initializes a mutex variable's attribute object
 *
 * 		The pthread_mutexattr_init() function shall initialize a mutex attributes 
 *		object attr with the default value for all of the attributes defined by 
 *		the implementation. Results are undefined if pthread_mutexattr_init() is 
 *		called specifying an already initialized attr attributes object.
 *		After a mutex attributes object has been used to initialize one or more mutexes, 
 *		any function affecting the attributes object (including destruction) shall 
 *		not affect any previously initialized mutexes.
 *
 * @param attr
 *      pointer to mutex variable's attributes object
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_mutexattr_init(pthread_mutexattr_t *attr)
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
                attr->init              = _ATTR_INIT_KEY;
                attr->type              = PTHREAD_MUTEX_DEFAULT;
                attr->protocol          = PTHREAD_MUTEX_PROTOCOL;
#               if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
                attr->prioceiling       = 0;
#               endif
}
        
        posix_scheduler_unlock();

        return ret;
}

