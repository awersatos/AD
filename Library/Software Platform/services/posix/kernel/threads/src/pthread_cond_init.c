/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cond_init
|*
\*****************************************************************************/


#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      initialize the condition variable referenced by cond 
 *
 *      The function shall initialize the condition variable referenced by cond 
 *      with attributes referenced by attr. If attr is NULL, the default condition 
 *      variable attributes shall be used; the effect is the same as passing the address 
 *      of a default condition variable attributes object. 
 *      Upon successful initialization, the state of the condition variable shall become 
 *      initialized. The pthread_cond_destroy() function shall destroy the given condition 
 *      variable specified by cond; A destroyed condition variable object 
 *      can be reinitialized using pthread_cond_init(); the results of otherwise 
 *      referencing the object after it has been destroyed are undefined.
 *      In cases where default condition variable attributes are appropriate, 
 *      the macro PTHREAD_COND_INITIALIZER can be used to initialize condition 
 *      variables that are statically allocated. The effect shall be equivalent to 
 *      dynamic initialization by a call to pthread_cond_init() with parameter attr 
 *      specified as NULL, except that no error checks are performed.
 *
 * @param cond
 *      pointer to condition variable
 * @param attr
 *      pointer to read-only condition variable attributes
 *
 * @return
 *      Upon successful completion it shall return a value of 0; otherwise, an error number 
 *      shall be returned to indicate the error.     
 */
int pthread_cond_init(pthread_cond_t * cond, const pthread_condattr_t *attr)
{
        pthread_condattr_t      default_attr;
        int                     ret=0;
        int                     daf=0;
        
        if (attr==NULL)
        {
                /* default */
                pthread_condattr_init(&default_attr);
                attr = &default_attr;
                daf = 1;
        }
        else if (attr->init     != _ATTR_INIT_KEY)
        {
                return EINVAL;
        }

        posix_scheduler_lock();
                
        if (cond->initi == _ATTR_INIT_KEY)
        {
                ret = EBUSY;
        }
        else
        {
                cond->initi     = _ATTR_INIT_KEY;
        }
        
        if (ret==0)
        {
                cond->clock_id           = attr->clock_id; 
                cond->queue.head         = NULL;
                cond->queue.tail         = NULL;
        }

        posix_scheduler_unlock();

        if (daf)
        {
            pthread_condattr_destroy(&default_attr);
        }
        return ret;
}


