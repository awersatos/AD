/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_setdetachstate
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      sets the detachstate attribute in the attr object
 *
 * 		The application shall set detachstate to either PTHREAD_CREATE_DETACHED or 
 *		PTHREAD_CREATE_JOINABLE.
 *		A value of PTHREAD_CREATE_DETACHED shall cause all threads created with attr 
 *		to be in the detached state, whereas using a value of PTHREAD_CREATE_JOINABLE 
 *		shall cause all threads created with attr to be in the joinable state. 
 *		The default value of the detachstate attribute shall be PTHREAD_CREATE_JOINABLE
 * 
 * @param attr
 *      pointer to the thread's attribute object
 * @param detachstate
 *		value of the detachstate attribute
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_attr_setdetachstate (pthread_attr_t *attr, int detachstate)
{       
        int ret = 0;

        if (    attr == NULL                             || 
                (detachstate != PTHREAD_CREATE_JOINABLE  &&
                 detachstate != PTHREAD_CREATE_DETACHED )
          )
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
                attr->detachstate = detachstate;
        }

        posix_scheduler_unlock();

        return ret;
}

