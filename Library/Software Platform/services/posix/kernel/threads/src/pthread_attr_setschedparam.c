/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_setschedparam
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *      sets the scheduling parameter attributes in the attr object
 *
 * 		The contents of the param structure are defined in the <sched.h> header. 
 *		For the SCHED_FIFO and SCHED_RR policies, the only required member of param 
 *		is sched_priority. 
 *		
 *		For the SCHED_SPORADIC policy, the required members of the param structure 
 *		are sched_priority, sched_ss_low_priority, sched_ss_repl_period, sched_ss_init_budget, 
 *		and sched_ss_max_repl. The specified sched_ss_repl_period must be greater than or 
 *		equal to the specified sched_ss_init_budget for the function to succeed; 
 *		if it is not, then the function shall fail. The value of sched_ss_max_repl shall 
 *		be within the inclusive range [1, {SS_REPL_MAX}] for the function to succeed; 
 *		if not, the function shall fail.  		
 * 
 * @param attr
 *      pointer to the thread's attribute object
 * @param sched_param
 *		pointer to read-only scheduling parameters
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_attr_setschedparam ( pthread_attr_t *attr, const struct sched_param *param )
{
        int ret = 0;
        
        if (    attr == NULL                                    || 
                param == NULL                                   ||
                param->sched_priority > SCHED_PRIORITY_MAX      ||
                param->sched_priority < SCHED_PRIORITY_MIN      
        )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if ( attr->init != _ATTR_INIT_KEY )
        {
                ret = EINVAL;
        }
        else
        {
                (attr->schedparam).sched_priority = 
                        param->sched_priority;
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
                (attr->schedparam).sched_ss_low_priority = 
                        param->sched_ss_low_priority;
                (attr->schedparam).sched_ss_repl_period = 
                        param->sched_ss_repl_period;
                (attr->schedparam).sched_ss_init_budget = 
                        param->sched_ss_init_budget;
                (attr->schedparam).sched_ss_max_repl = 
                        param->sched_ss_max_repl;
#endif /* __POSIX_THREAD_SPORADIC_SERVER */
        }
        
        posix_scheduler_unlock();

        return ret;
}


