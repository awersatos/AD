/******************************************************************************
 * FILE:        @(#)pthread_attr_getstack.c     1.3 06/06/09
 * DESCRIPTION:    
 *      The pthread_attr_getstack() shall get the thread creation stack 
 *      attributes stackaddr and stacksize in the attr object.
 *      The stack attributes specify the area of storage to be used for the 
 *      created thread's stack. 
 *
 *      The base (lowest addressable byte) of the storage shall be stackaddr, 
 *      and the size of the storage shall be stacksize bytes. The stacksize 
 *      shall be at least {PTHREAD_STACK_MIN}. 
 *      The stackaddr shall be aligned appropriately to be used as a stack; 
 *      for example, pthread_attr_setstack() may fail with [EINVAL] if 
 *      ( stackaddr & 0x7) is not 0. 
 *      All pages within the stack described by stackaddr and stacksize shall
 *      be both readable and writable by the thread.
 *
 *      Upon successful completion, these functions shall return a value of 0;
 *      otherwise, an error number shall be returned to indicate the error.
 *
 *      The pthread_attr_getstack() function shall store the stack attribute 
 *      values in stackaddr and stacksize if successful.
 *
 *      The pthread_attr_getstack() function may fail if :
 *      [EINVAL] The value specified by attr does not refer to an initialized
 *              thread attribute object. 
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__XSI_THREAD_EXIT != 0)

int pthread_attr_getstack(const pthread_attr_t *attr,
       void ** stackaddr, size_t * stacksize)
{
        int ret = 0;
        
        if (    attr == NULL || stacksize == NULL ||
                (void*)stackaddr == NULL )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if (    attr->init != _ATTR_INIT_KEY  )
        {
                ret = EINVAL;
        }
        else
        {
                *stacksize = attr->stacksize;
                *stackaddr = attr->stackaddr;
        }

        posix_scheduler_unlock();

        return ret;

        
}

#endif
