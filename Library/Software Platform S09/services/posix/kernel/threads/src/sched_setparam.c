/******************************************************************************
 * FILE:        @(#)sched_setparam.c    1.1 05/07/26
 * DESCRIPTION:
 *      The sched_setparam() function shall set the scheduling parameters 
 *      of the process specified by pid to the values specified by the 
 *      sched_param structure pointed to by param. The value of the
 *      sched_priority member in the sched_param structure shall be any 
 *      integer within the inclusive priority range for the current 
 *      scheduling policy of the process specified by pid. 
 *      Higher numerical values for the priority represent higher
 *      priorities. If the value of pid is negative, the behavior of 
 *      the sched_setparam() function is unspecified.
*****************************************************************************/
#include <pthread.h>
#include <sys/types.h>
#include <sched.h>

int sched_setparam(pid_t pid, const struct sched_param *param)
{
        return 0;
}

