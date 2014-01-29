/******************************************************************************
 * FILE:                @(#)k_schedule.c        1.24 07/02/21
 * DESCRIPTION:
 *      scheduler routines implementation
 *****************************************************************************/
#include <sys/types.h>
#include <time.h>
#include <interrupts.h>
#include "posix_time.h"
#include "kernel.h"
#include "k_schedule.h"
#include "k_readyqueue.h"
#include "pal.h"

/* pointer to the running thread (NULL in grey area) */
posix_thread_t* _posix_current_thread   = (posix_thread_t*) 0;

#if ( __POSIX_THREAD_CPUTIME != 0 )
posix_thread_t* _posix_old_thread       = (posix_thread_t*) 0;
#endif

/* running priority (or the last thread's in grey area) */
int             _posix_current_priority = 0;

/* scheduler lock counter:
 * a thread can preempt the running thread only when the lock is one:
 * (1) end of a first nested interrupt that has preempted a thread
 *      running outside the grey area.
 * (2) transition running->waiting
 * (3) transition ready->running 
 */     
int             _posix_sched_lock       = 0;

/* nested interrupt level
 * -1: no-thread / no-interrupt
 * 0 : thread level
 * n : n nested interrupt level
 */

int             _posix_irq_level        = -1;

#if ( POSIX_THREADS_DEBUG != 0 )
/* resume address of saved context */
uint32_t        _posix_resume_address   = 0;
uint32_t        _posix_user_stack       = 0;
#endif


/* runs at thread and interrupt level to find out whether reasons to 
 * preempt the running thread are found. if so, running thread becomes
 * ready.
 * interrupts must be disabled 
 */
bool posix_schedule_reason(void)
{
        posix_thread_t *thread  = _posix_current_thread;
        bool            ret     = false;
        int high                = posix_rq_high_prio();
        
        if (_posix_sched_lock == 1)
        {
                if (_posix_current_priority < high)
                {
                        /* running thread to head of priority */
                        posix_rq_add_head(      thread,
                                                _posix_current_priority);

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
                        if (    _posix_current_thread->schedpolicy == 
                                POSIX_SCHED_SPORADIC)
                        {
                                ss_handle_preemption(_posix_current_thread);
                        }
#endif /* __POSIX_THREAD_SPORADIC_SERVER */

                        ret = true;
                }
                else if ( thread->schedpolicy == POSIX_SCHED_RR         &&
                          thread->timeslice == 0                        &&
                          thread->mutex == NULL )
                {       
                        /* reset always the quantum */
                        posix_reset_timeslice(thread);

                        if ( !posix_rq_empty(_posix_current_priority))
                        {
                                /* rr: add thread to tail */
                                posix_rq_add_tail( _posix_current_thread,
                                                   _posix_current_priority);

                                ret = true;
                        }
                }
                
                if (ret == true)
                {
                        _posix_current_thread->state = POSIX_THREAD_READY;
                }       
        }
        return ret;
}

/* thread level 're-schedule' point: set manually */
void    posix_schedule_point(void)
{
        bool ret;
        
        posix_interrupts_disable();

        /* force to always go to 'posix_switch' below if ret=true */
        _posix_sched_lock++;
        
        ret = posix_schedule_reason();
        
        if (ret == true)
        {
                posix_interrupts_enable();
                /* allow possible pending interrupts */
                posix_interrupts_disable();

#if ( POSIX_THREADS_DEBUG != 0 )
                _posix_current_thread->spuser  = (uint32_t)pal_architecture_get_current_sp();
#endif
                /* save this context and go for next thread */
                posix_switch();
        }
        else
        {
                _posix_sched_lock--;
                posix_interrupts_enable();
        }

}

/* interrupt level 're-schedule' point at the end of first 
 * nested interrupts 
 */
void    posix_interrupt_schedule_point(void)
{
        if (posix_schedule_reason())
        {
                /* scheduler lock must be saved per 
                 * thread basis */
                _posix_current_thread->sched_lock = 0;
        
                /* preempted context was saved upon 
                 * entering the interrupt */
                posix_schedule_next();
                
        }
        else
        {
                #if ( __POSIX_THREAD_CPUTIME != 0 )
                if (_posix_current_thread != NULL)
                {
                        /* new quantum for the old thread */
                        _posix_current_thread->btime = clock(); 
                }
                #endif  

                _posix_sched_lock--;
        }
        
        /* with interrupts disabled all the way to 'reti' */
}

#if ( __POSIX_THREAD_CPUTIME != 0 )
static void _posix_update_old_thread_value(void)
{
        _posix_old_thread     = _posix_current_thread;
}
#endif

#ifdef __C3000__
#pragma optimize 02
#endif

/* reasons to re-schedule at thread level were found and
 * the old thread was brought back to the ready queue */
void posix_switch(void)
{
        /* save current thread */
        _hal_save_ctx();

        #if ( POSIX_THREADS_DEBUG != 0 )
        _posix_current_thread->ra = _posix_resume_address;
        #endif

        /* scheduler lock saved per thread basis */
        _posix_current_thread->sched_lock = _posix_sched_lock-1;

        /* no running thread */
#if ( __POSIX_THREAD_CPUTIME != 0 )
        _posix_update_old_thread_value();
#endif

        _posix_current_thread = (posix_thread_t*)0;

        /* grey area: allow preemptions */
        posix_interrupts_enable();

#if ( __POSIX_THREAD_CPUTIME != 0 )
        /* last action of thread: check expirations of cpuclocks */
        posix_cpuclock_update();
#endif

        /* next thread */
        posix_schedule_next();

}

/* execution will resume in the highest ready thread available.
 * thread or interrupt level. */
void posix_schedule_next(void)
{
         posix_interrupts_disable();

        /* new highest priority */
        _posix_current_priority = posix_rq_high_prio();

        /* get new thread from head of priority list */
        _posix_current_thread = posix_rq_rm_head(_posix_current_priority);

        _posix_current_thread->state    = POSIX_THREAD_RUNNING;

        /* restore scheduler lock as it was at thread's last preemption */
        _posix_sched_lock       = _posix_current_thread->sched_lock;

        if (    _posix_current_thread->asrpending &&
                _posix_current_thread->inasrhandler == 0)
        {
                /* not pending anymore */
                _posix_current_thread->asrpending = 0;
                /* we are in asr handler */
                 _posix_current_thread->inasrhandler = 1;
                /* load asr handler context */
                _hal_load_asr_ctx(&_posix_current_thread->sp,
                                _posix_current_thread->asrhandler);
        }

        #if ( __POSIX_THREAD_CPUTIME != 0 )
        /* next thread starts now: start counting cycles for
         * this quantum */
        _posix_current_thread->btime = clock();
        #endif

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        if (_posix_current_thread->schedpolicy == POSIX_SCHED_SPORADIC)
        {
                ss_budget_timer(_posix_current_thread);
        }
#endif

        if (_posix_irq_level==0)
        {
                /* load next context if at thread level */
                _hal_load_ctx(_posix_current_thread->sp);
        }

}

#ifdef __C3000__
#pragma endoptimize
#endif

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)

static void ticks_to_timespec(  long res,
                                clock_t ticks, 
                                struct timespec *tmspec)
{
        unsigned long long nsecs;

        nsecs = res * ticks;
        tmspec->tv_sec = (long)(nsecs / 1000000000ll);
        tmspec->tv_nsec = (long)(nsecs % 1000000000ll);

        return;
}

static int ss_repl_get_next_index(posix_thread_t *thread)
{
        int ret = -1;

        if (    thread->schedparam.sched_ss_max_repl <= 0       || 
                thread->last_repl == thread->next_repl)
        {
                return ret;
        }

        if (thread->last_repl == -1)
        {
                if (    thread->next_repl + 1 != 
                        thread->schedparam.sched_ss_max_repl)
                {
                        ret = thread->next_repl++;
                }
                else
                {
                        /* we got to the end but none 
                         * have been handled yet */
                        ret = thread->next_repl;
                        thread->next_repl = -1;
                }
        }
        else
        {
                ret = thread->next_repl++;
                if (    thread->next_repl == 
                        thread->schedparam.sched_ss_max_repl)
                {
                        thread->next_repl = 0;
                }
        }

        return ret;
}

void ss_schedule_replenishment(posix_thread_t *thread)
{
        struct timespec replenish_amount;
        struct timespec current_time;
        struct timespec repl_time;
        int             i;
        posix_timer_t   *timer;

        /* amount to replenish */
        ticks_to_timespec(      1000000000LL / ((uint32_t)PAL_CLOCKHZ),
                                thread->execution_time, 
                                &replenish_amount);

        /* get current time */
        clock_gettime(CLOCK_MONOTONIC, &current_time);

        /* time for replenishment action is activation time + replenishment period */
        posix_timespec_add(     &repl_time, 
                                &thread->activation_time, 
                                &thread->schedparam.sched_ss_repl_period );

        /* if time is in the past then add repl amount directly */
        if (posix_timespec_compare(     &repl_time, 
                                        &current_time) <= 0)
        {
                posix_timespec_add(     &thread->budget, 
                                        &thread->budget, 
                                        &replenish_amount);

                /* reset execution time */
                thread->execution_time = 0;
        }
        else
        {
                /* otherwise schedule repl operation */
                i = ss_repl_get_next_index(thread);
                if (i != -1)
                {
                        posix_timer_init(posix_get_timer(thread->repl[i]),
                                CLOCK_MONOTONIC, 
                                POSIX_TIMER_SPORADIC_SERVER_REPLENISHMENT);

                        timer = posix_get_timer(thread->repl[i]);
                        timer->replenishment = replenish_amount;
                        
                        posix_set_timer(
                                posix_timespec_to_ticks(timer->clock, &repl_time),
                                timer,
                                true);
                        
                        /* reset execution time */
                        thread->execution_time = 0;
                }
                else
                {
                        /* we're out of replenishments so switch to lower priority */
                        posix_thread_set_priority( 
                                thread, 
                                thread->schedparam.sched_ss_low_priority);
                }
        }

}

void ss_replenish(      posix_thread_t *thread, 
                        struct timespec *replenish_amount)
{
        posix_timespec_add(     &thread->budget, 
                                &thread->budget, 
                                replenish_amount);

        if (posix_timespec_compare( 
                        &thread->budget, 
                        &thread->schedparam.sched_ss_init_budget) > 0)
        {
                thread->budget = thread->schedparam.sched_ss_init_budget;
        }

        if (thread->priority == thread->schedparam.sched_ss_low_priority)
        {
                posix_thread_set_priority( 
                                thread, 
                                thread->schedparam.sched_priority);
        }

        /* update last_repl field */
        if (thread->last_repl + 1 == thread->schedparam.sched_ss_max_repl)
        {
                thread->last_repl = 0;
        }
        else
        {
                thread->last_repl++;
        }
}

/* 3
 * When the running thread with assigned priority equal to sched_priority becomes
 * a preempted thread, it becomes the head of the thread list for its priority,
 * and the execution time consumed is subtracted from the available execution
 * capacity. If the available execution capacity would become negative by this
 * operation, it shall be set to zero.
 */
void ss_handle_preemption(posix_thread_t *thread)
{
        /*
         * only when we are running at 'high' priority
         */
        if (thread->priority == thread->schedparam.sched_priority)
        {
                ss_update_budget(thread);
                /* remove budget timer */
                posix_timer_rm(posix_get_timer(thread->end_of_budget));
        }
}

/* 4
 * When the running thread with assigned priority equal to sched_priority becomes
 * a blocked thread, the execution time consumed is subtracted from the available
 * execution capacity, and a replenishment operation is scheduled, as described
 * in 6 and 7. If the available execution capacity would become negative by this
 * operation, it shall be set to zero.
 */
void ss_handle_blocking(posix_thread_t *thread)
{
        /*
         * only when we are running at 'high' priority
         */
        if (thread->priority == thread->schedparam.sched_priority)
        {
                /* update the budget */
                ss_update_budget(thread);

                /* schedule replenishment operation */
                ss_schedule_replenishment(thread);

                /* remove budget timer */
                posix_timer_rm(posix_get_timer(thread->end_of_budget));
        }
}

void ss_update_budget(posix_thread_t *thread)
{
        struct timespec ts;
        clock_t         this_run;

        this_run = clock() - thread->start_of_run_time;
        thread->execution_time += this_run;

        ticks_to_timespec(
                1000000000LL / ((uint32_t)PAL_CLOCKHZ), 
                this_run, 
                &ts);

        if (posix_timespec_compare(&ts, &thread->budget) >= 0)
        {
                thread->budget.tv_sec = 0;
                thread->budget.tv_nsec = 0;
        }
        else
        {
                posix_timespec_subtract( &thread->budget, 
                                         &thread->budget, 
                                         &ts);
        }
        /* not here still needed in ss_schedule_replenishment
         * thread->execution_time = 0;
         * thread->start_of_run_time = 0;
         */
}

void ss_budget_timer(posix_thread_t *thread)
{
        if (thread->priority == thread->schedparam.sched_priority)
        {
                posix_timer_t *budget_timer;
                struct timespec ts;

                posix_timer_init( 
                        posix_get_timer(thread->end_of_budget), 
                        CLOCK_MONOTONIC, 
                        POSIX_TIMER_SPORADIC_SERVER_BUDGET);

                budget_timer = posix_get_timer(thread->end_of_budget);

                if (budget_timer != NULL)
                {
                        /* add one time the resolution (we might be half 
                         * way to the next tick) */
                        ts.tv_sec = 0;
                        ts.tv_nsec = budget_timer->clock->res;
                        posix_timespec_add( &ts, &ts, &thread->budget );

                        posix_set_timer(
                                posix_timespec_to_ticks(budget_timer->clock, &ts),
                                budget_timer,
                                false);
                }
                else
                {
                        /* need to oeps here? */
                }
                thread->start_of_run_time = clock();
        }
}

void ss_remove_all_timers(posix_thread_t *thread)
{
        /* posix_rm_timer can handle timers that are not in the queue */

        if (thread->schedpolicy == POSIX_SCHED_SPORADIC)
        {
                posix_timer_rm(posix_get_timer(thread->end_of_budget));
        }
        for (int i = 0; i < thread->schedparam.sched_ss_max_repl; i++)
        {
                posix_timer_rm(posix_get_timer(thread->repl[i]));
        }
}

#endif /* __POSIX_THREAD_SPORADIC_SERVER */

