/*****************************************************************************
 * FILE:                @(#)kernel.h    1.21 07/02/21
 * DESCRIPTION:
 *                      kernel services interface
 ****************************************************************************/

#ifndef _H_KERNEL
#define _H_KERNEL

#include <stdint.h>
#include <stdbool.h>
#include <sched.h>
#include <limits.h>
#include "kconf.h"
#include "posix_pthread.h"

/* thread states */
#define POSIX_THREAD_SUSPENDED                  0
#define POSIX_THREAD_WAITING                    1
#define POSIX_THREAD_READY                      2
#define POSIX_THREAD_RUNNING                    3

/* scheduling policies  */
#define POSIX_SCHED_FIFO                        SCHED_FIFO
#define POSIX_SCHED_RR                          SCHED_RR
#define POSIX_SCHED_SPORADIC                    SCHED_SPORADIC


extern posix_thread_t *         _posix_current_thread;

/* returns handler to current running thread */
inline posix_thread_t *         posix_self_thread(void) { 
return _posix_current_thread;
}

/* returns current priority */
inline int              posix_self_priority(void) {
        return _posix_current_thread->priority;
}

/* thread's initialization */
extern void posix_thread_init(  posix_thread_t* thread, 
                                int schedpolicy,
                                struct sched_param *schedparam, 
                                void*(*start_routine)(void*),
                                void *start_arg, 
                                void* stackaddr, 
                                int stacksize,
                                void (*asrhandler)(void*), 
                                void (*exithandler)(void*));

/* accessors */
extern void posix_thread_set_priority(posix_thread_t* thread,int pri);

inline int posix_thread_get_priority(posix_thread_t* thread){
        return thread->priority;
}

inline void posix_set_schedpolicy(      posix_thread_t* thread,
                                        int schedpolicy){
        thread->schedpolicy = schedpolicy;
}

inline int posix_get_schedpolicy(posix_thread_t* thread){
        return thread->schedpolicy;
}
inline int  posix_get_max_prio(void) { 
return POSIX_MAX_SCHED_PRIORITY;
}

inline int  posix_get_min_prio(void) { 
return POSIX_MIN_SCHED_PRIORITY;
}

inline int  posix_get_rr_max_interval(void) {
        return POSIX_THREADS_TIMESLICE_MAX;
}

/* scheduling */        

/* running -> wait transition */
extern void posix_thread_wait(void);
/* tells current thread to catch next wakeups */
extern void posix_thread_reset_rc(void);
/* waiting -> ready transition (with reason) */
extern void posix_thread_ready(posix_thread_t*,int);
/* yields the thread */
extern bool posix_thread_yield(void);
/* locks scheduler */
extern void posix_scheduler_lock(void);
/* unlocks scheduler -scheduling point- */
extern void posix_scheduler_unlock(void);

/* threads termination */
extern void posix_thread_exit(void);

/* installs the asynchronous handler on threads stack */
extern void posix_thread_set_asrhandler(posix_thread_t* t);

/* round robin process */
extern void posix_round_robin(void);
inline void posix_reset_timeslice(posix_thread_t* thread){
        thread->timeslice = POSIX_THREADS_TIMESLICE_MAX;
}


#endif

