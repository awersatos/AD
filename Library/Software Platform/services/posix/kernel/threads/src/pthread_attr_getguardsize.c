/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_getguardsize
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__XSI_THREAD_EXIT != 0)

/**
 * @brief
 *      gets the guardsize attribute in the attr object
 *
 *          The pthread_attr_getguardsize() function shall get the guardsize
 *          attribute in the attr object. 
 *          This attribute shall be returned in the guardsize parameter.
 * 
 * @param attr
 *      pointer to the thread's attribute object
 * @param guardsize
 *		return (size_t *) parameter
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */

int pthread_attr_getguardsize(const pthread_attr_t * attr, size_t *guardsize)
{
        int ret =0;
        
        if ( attr == NULL || guardsize == NULL)
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();

        if (    attr->init != _ATTR_INIT_KEY )
        {
                ret = EINVAL;
        }
        else
        {
                *guardsize = attr->guardsize;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif

