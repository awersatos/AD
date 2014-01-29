/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_condattr_destroy
|*
\*****************************************************************************/

#include <errno.h>
#include <pthread.h>
#include <sys/types.h>
#include "kernel.h"

/**
 * @brief
 *      destroys the condition variable's attribute object
 *
 *      The pthread_condattr_destroy() function shall destroy a condition variable 
 *      attributes object; the object becomes, in effect, uninitialized. 
 *      An implementation may cause pthread_condattr_destroy() to set the object 
 *      referenced by attr to an invalid value. A destroyed attr attributes object 
 *      can be reinitialized using pthread_condattr_init(); the results of otherwise 
 *      referencing the object after it has been destroyed are undefined.
 *
 * @param attr
 *      pointer to condition variable's attributes object
 *
 * @return
 *      Upon successful completion it shall return a value of 0; otherwise, an error number 
 *      shall be returned to indicate the error.     
 */
int pthread_condattr_destroy (pthread_condattr_t *attr)
{
    int ret = 0;

    if (attr == NULL)
    {
        return EINVAL;
    }

    posix_scheduler_lock();

    if (attr->init != _ATTR_INIT_KEY)
    {
        /* it has been initialized */
        ret = EINVAL;
    }
    else
    {
        attr->init = 0;
    }

    posix_scheduler_unlock();

    return ret;
}

