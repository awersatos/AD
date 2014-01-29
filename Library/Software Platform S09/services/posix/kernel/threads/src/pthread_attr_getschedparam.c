/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_getschedparam
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      gets the scheduling parameter attributes in the attr argument
 *
 *      The pthread_attr_getschedparam() function shall get the scheduling
 *      parameter attributes in the attr argument. 
 *      The contents of the param structure are defined in 
 *      the <sched.h> header. 
 *      For the SCHED_FIFO and SCHED_RR policies, the only required member 
 *      of param is sched_priority.
 * 
 * @param attr
 *      pointer to the thread's attribute object
 * @param param
 *		return (struct sched_param *) parameter
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_attr_getschedparam (const pthread_attr_t *attr,struct sched_param *param)
{       
        int ret = 0;

        if (attr == NULL || param == NULL ) { return EINVAL; }
        
        posix_scheduler_lock();

        if (attr->init != _ATTR_INIT_KEY)
        { 
                ret = EINVAL;
        }
        else
        {
                param->sched_priority = attr->schedparam.sched_priority;
        }
        
        posix_scheduler_unlock();       

        return ret;
}


