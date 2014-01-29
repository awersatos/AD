/******************************************************************************
 * FILE:        @(#)pthread_getschedparam.c     1.4 06/11/23
 * DESCRIPTION:
 *      The pthread_getschedparam() function shall get the scheduling policy 
 *      and parameters of individual threads within a multi-threaded process
 *      to be retrieved and set. For SCHED_FIFO and SCHED_RR, the only 
 *      required member of the sched_param structure is the priority 
 *      sched_priority. The pthread_getschedparam() function shall retrieve 
 *      the scheduling policy and scheduling parameters for the thread whose 
 *      thread ID is given by thread and shall store those values in policy 
 *      and param, respectively. The priority value returned from 
 *      pthread_getschedparam() shall be the value specified by the most
 *      recent pthread_setschedparam(), pthread_setschedprio(),
 *      or pthread_create() call affecting the target thread. 
 *      It shall not reflect any temporary adjustments to its priority as a 
 *      result of any priority inheritance or ceiling functions. 
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"

int pthread_getschedparam (pthread_t thread_id,
                                   int *policy,
                                   struct sched_param *param)
{
        int ret         = 0;
        posix_thread_t  *thread;
        
        pthread_mutex_lock(&_posix_threads_mutex);
        
        thread =  posix_get_thread(thread_id);

        if( thread == NULL )
        {
            ret = ESRCH;
        }
        else
        {
                if( policy != NULL )
                {
                        *policy = thread->schedpolicy;
                }
                if( param != NULL )
                {
                        *param = thread->schedparam;
                }
        }

        pthread_mutex_unlock(&_posix_threads_mutex);

        return 0;
}

