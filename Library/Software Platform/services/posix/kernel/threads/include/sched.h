/******************************************************************************
 * FILE:        @(#)sched.h     1.3 05/09/15
 * DESCRIPTION:
 *      'sched.h' posix interface
 *****************************************************************************/
#ifndef _SCHED_H
#define _SCHED_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <sys/types.h>
#include <time.h>

/* see sched_param discussion in 'types.h' */

/* pthread_attr_t : policy */
#define SCHED_FIFO              0
#define SCHED_RR                1
#define SCHED_SPORADIC          2
#define SCHED_OTHER             SCHED_FIFO

extern int    sched_get_priority_max(int);
extern int    sched_get_priority_min(int);
extern int    sched_getparam(pid_t, struct sched_param *);
extern int    sched_getscheduler(pid_t);
extern int    sched_rr_get_interval(pid_t, struct timespec *);
extern int    sched_setparam(pid_t, const struct sched_param *);
extern int    sched_setscheduler(pid_t, int, const struct sched_param *);
extern int    sched_yield(void);


#ifdef  __cplusplus
}
#endif

#endif
