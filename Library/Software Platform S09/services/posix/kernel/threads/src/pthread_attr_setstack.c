/******************************************************************************
 * FILE:        @(#)pthread_attr_setstack.c     1.6 07/02/21
 * DESCRIPTION:    
 *      
 *      The pthread_attr_setstack() shall set the thread creation stack 
 *      attributes stackaddr and stacksize in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__XSI_THREAD_EXIT != 0)

int pthread_attr_setstack(      pthread_attr_t *attr,
                                void *stackaddr, 
                                size_t stacksize )
{
        int ret = 0;
        
        if (    attr == NULL       || 
                stacksize < PTHREAD_STACK_MIN ||
                stackaddr == NULL  || 
                ((uintptr_t)stackaddr & 0x3 ) ||
                (((uintptr_t)stackaddr + stacksize) & 0x3)
                )
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
                attr->stacksize = stacksize;
                attr->stackaddr = stackaddr;
                attr->guardsize = 0;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif

