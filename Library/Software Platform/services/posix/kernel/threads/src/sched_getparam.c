/******************************************************************************
 * FILE:        @(#)sched_getparam.c    1.1 05/07/26
 * DESCRIPTION:
 *      The sched_getparam() function shall return the scheduling parameters
 *      of a process specified by pid in the sched_param structure pointed
 *      to by param.
 *****************************************************************************/
#include <pthread.h>
#include <sys/types.h>
#include <sched.h>
 
int sched_getparam(pid_t pid, struct sched_param *param)
{
        return 0;
}

