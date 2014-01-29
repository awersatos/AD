/******************************************************************************
 * FILE:        @(#)sched_yield.c       1.3 06/05/22
 * DESCRIPTION:
 *      The sched_yield() function shall force the running thread to 
 *      relinquish the processor until it again becomes the head of 
 *      its thread list. It takes no arguments.
 *****************************************************************************/
#include <sched.h>
#include "kernel.h"

int sched_yield(void)
{
        int ret = ( posix_thread_yield()==true ) ? 0 : -1 ;
        return ret;
}

