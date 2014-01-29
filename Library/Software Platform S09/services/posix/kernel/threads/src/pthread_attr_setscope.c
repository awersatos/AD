/******************************************************************************
 * FILE:        @(#)pthread_attr_setscope.c     1.3 06/05/22
 * DESCRIPTION:
 *      The pthread_attr_setscope() function shall set the 
 *      scope attribute in the attr argument.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

int pthread_attr_setscope (pthread_attr_t *attr, int contentionscope)
{
        int ret = 0;

        if (    attr == NULL                            ||
                ( contentionscope != PTHREAD_SCOPE_SYSTEM       &&
                  contentionscope != PTHREAD_SCOPE_PROCESS )
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
                attr->scope = contentionscope;
        }

        posix_scheduler_unlock();


        return ret;
}

