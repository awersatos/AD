/******************************************************************************
 * FILE:        @(#)sched_rr_get_interval.c     1.1 05/07/26
 * DESCRIPTION:
 *      The sched_rr_get_interval() function shall update the timespec 
 *      structure referenced by the interval argument to contain the current
 *      execution time limit (that is, time quantum) for the process specified
 *      by pid. If pid is zero, the current execution time limit for the
 *      calling process shall be returned.
*****************************************************************************/
#include <pthread.h>
#include <sys/types.h>
#include <sched.h>

int sched_rr_getscheduler(pid_t pid)
{
        return 0;
}

