 /******************************************************************************
 * FILE:                @(#)k_schedule.h        1.12 06/12/01
 * DESCRIPTION:         
 *      kernel scheduling internal interface
 *****************************************************************************/
#ifndef _H_K_SCHEDULE
#define _H_K_SCHEDULE

#include "posix_pthread.h"

/* running thread/priority */
extern posix_thread_t*  _posix_current_thread;
extern int              _posix_current_priority;
/* scheduler lock counter */
extern int              _posix_sched_lock;
#if ( POSIX_THREADS_DEBUG != 0 )
/* resume address of saved context */
extern uint32_t        _posix_resume_address;
extern uint32_t        _posix_user_stack;
#endif


/* thread's ctx initialization */
extern void posix_thread_init_ctx(posix_thread_t* thread, int schedpolicy,
                struct sched_param *schedparam, void*(*start_routine)(void*),
                void *start_arg, void* stackaddr, int stacksize,
                void (*asrhandler)(void*), void (*exithandler)(void*));

/* check wether reasons to schedule a new thread exists.
 * - thread and interrupt level 
 * - interrupts must be disabled */
extern bool posix_schedule_reason(void);

/* Implements a re-schedule point at thread level */
extern void     posix_schedule_point(void);
/* Implements a re-schedule point at interrupt level */
extern void     posix_interrupt_schedule_point(void);

/* kernel must do a full switch 
 * - thread level 
 * - interrupts must be disabled */
extern void posix_switch(void);

/* current ctxt saved, kernel resumes next thread 
 * - thread and interrupt level */
extern void posix_schedule_next(void);

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
extern void ss_replenish(posix_thread_t *thread, struct timespec *replenish_amount);
extern void ss_schedule_replenishment(posix_thread_t *thread);
extern void ss_handle_preemption(posix_thread_t *thread);
extern void ss_handle_blocking(posix_thread_t *thread);
extern void ss_update_budget(posix_thread_t *thread);
extern void ss_budget_timer(posix_thread_t *thread);
extern void ss_remove_all_timers(posix_thread_t *thread);
#endif /* __POSIX_THREAD_SPORADIC_SERVER */

#endif
