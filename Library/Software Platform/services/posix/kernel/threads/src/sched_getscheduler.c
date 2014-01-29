/******************************************************************************
 * FILE:        @(#)sched_getscheduler.c        1.1 05/07/26
 * DESCRIPTION:
 *      The sched_getscheduler() function shall return the scheduling policy
 *      of the process specified by pid. If the value of pid is negative, 
 *      the behavior of the sched_getscheduler() function is unspecified.
*****************************************************************************/
#include <pthread.h>
#include <sys/types.h>
#include <sched.h>

int sched_getscheduler(pid_t pid)
{
        return 0;
}

