/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_getdetachstate
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      gets the detachstate attribute in the attr object
 *
 *      The pthread_attr_getdetachstate() function shall get the detachstate
 *      attribute in the attr object.
 *      For pthread_attr_getdetachstate(), detachstate shall be set to 
 *      either PTHREAD_CREATE_DETACHED or PTHREAD_CREATE_JOINABLE.
 * 
 * @param attr
 *      pointer to the thread's attribute object
 * @param detachstate
 *      return (int*) detachstate parameter
 *		
 *
 * @return
 *     Upon successful completion, pthread_attr_getdetachstate() shall return a value of 0; 
 *	   otherwise, an error number shall be returned to indicate the error.
 *     The pthread_attr_getdetachstate() function stores the value of the detachstate attribute 
 *	   in detachstate if successful.
 */
int pthread_attr_getdetachstate (const pthread_attr_t *attr, int *detachstate)
{
        int ret = 0;

        posix_scheduler_lock();
        
        if ( attr == NULL  || attr->init != _ATTR_INIT_KEY || detachstate == NULL )
        {
                ret = EINVAL;
        }
        else
        {
                *detachstate = attr->detachstate;
        }
        
        posix_scheduler_unlock();

        return ret;
}

