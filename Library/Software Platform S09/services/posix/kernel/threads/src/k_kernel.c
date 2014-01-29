#include <limits.h>
#include <interrupts.h>
#include "kconf.h"
#include "kernel.h"
#include "k_schedule.h"
#include "k_readyqueue.h"

/* nested calls to clock suspend/resume */
pal_arch_atomic_t   clock_nested=0;


/* initilizes the thread's context at thread level */
void posix_thread_init_ctx(     posix_thread_t *thread,
                                int schedpolicy,
                                struct sched_param *schedparam,
                                void*(*start_routine)(void*),
                                void *start_arg, 
                                void* stackaddr, 
                                int stacksize,
                                void (*asrhandler)(void*), 
                                void (*exithandler)(void*) )
{
        thread->schedpolicy             = schedpolicy;
        thread->schedparam              = *schedparam;
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        if (thread->schedpolicy == POSIX_SCHED_SPORADIC)
        {
                thread->budget = schedparam->sched_ss_init_budget;
        }
#endif
        thread->priority                = schedparam->sched_priority;
        thread->stackaddr               = stackaddr;
        thread->stacksize               = stacksize;
        thread->start_routine           = start_routine;
        thread->start_arg               = start_arg;
        thread->asrhandler              = asrhandler;

#if (_hal_STACKDOWNWARDS>0)
        thread->sp                      = (void*)
                ( (((uintptr_t)stackaddr + stacksize) & ~0x3) - 4 );
#else
        thread->sp                      = (void*)
                ( ((uintptr_t)stackaddr & ~0x3) + 4 );
#endif
#if ( POSIX_THREADS_DEBUG != 0 )
        thread->spuser                  = (uint32_t)thread->sp;
#endif


        thread->retval                  = (void*)0;
        thread->state                   = POSIX_THREAD_READY;
        thread->asrpending              = 0;
        thread->timeslice               = POSIX_THREADS_TIMESLICE_MAX;
        thread->rc                      = 0;

        _hal_init_ctx(  start_routine, 
                        start_arg, 
                        exithandler, 
                        &thread->sp);
}


/* initilizes the thread at thread level only at thread level */
void posix_thread_init( posix_thread_t *thread, 
                        int schedpolicy,
                        struct sched_param *schedparam, 
                        void*(*start_routine)(void*),
                        void *start_arg, 
                        void *stackaddr, 
                        int stacksize,
                        void (*asrhandler)(void*), 
                        void (*exithandler)(void*))
{
        /* init the context */
        posix_thread_init_ctx(  thread,                         
                                schedpolicy, 
                                schedparam, 
                                start_routine,
                                start_arg, 
                                stackaddr, 
                                stacksize, 
                                asrhandler, 
                                exithandler );

        /* add thread to tail of priority level */
        posix_interrupts_disable();
        posix_rq_add_tail(      thread, 
                                schedparam->sched_priority );
        posix_interrupts_enable();

        /* re-schedule point */
        posix_schedule_point();

}
 
/* sets a new thread's priority at thread level */
void posix_thread_set_priority( posix_thread_t *thread,
                                int pri )
{
        if (    pri < POSIX_MIN_SCHED_PRIORITY ||
                pri > POSIX_MAX_SCHED_PRIORITY)
        {
                return;
        }

        posix_interrupts_disable();

        switch (thread->state)
        {
                case POSIX_THREAD_SUSPENDED:
                        /* absolutely nothing to do */
                        return;

                case POSIX_THREAD_WAITING:
                         /* thread awakes at new level */
                         break;

                case POSIX_THREAD_RUNNING:
                        /* will 're-schedule' if
                         * 'current_priority < rq_high_prio()' later */

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
                        /* changed from low to high priority ? */
                        if (thread->schedpolicy == POSIX_SCHED_SPORADIC)
                        {
                                if (    (thread->priority == 
                                        thread->schedparam.sched_ss_low_priority) &&
                                        (pri == thread->schedparam.sched_priority)
                                )
                                {
                                        clock_gettime(  CLOCK_MONOTONIC, 
                                                        &thread->activation_time);
                                        /* checked in ss_budget_timer */
                                        thread->priority = pri; 
                                        ss_budget_timer(thread);
                                }
                        }
#endif
                        _posix_current_priority = pri;
                         break;

                case POSIX_THREAD_READY:

                        if (pri < thread->priority)
                        {
                                /* remove it from its current ready level */
                                posix_rq_rm_thread(thread, thread->priority);
                                /* add it to head of new level */
                                posix_rq_add_head(thread, pri);
                        }
                        else if (pri > thread->priority)
                        {
                                /* remove it from its current ready level */
                                posix_rq_rm_thread(thread, thread->priority);
                                /* add it to tail of new level */
                                posix_rq_add_tail(thread, pri);

                        }
                        break;
        }

        /* new thread priority */
        thread->priority = pri;

        posix_interrupts_enable();

        /* re-schedule point */
        posix_schedule_point();

        return;
}

 
/* the thread undergoes a running->waiting transition 
 * only at thread level */
void posix_thread_wait(void)
{
        posix_interrupts_disable();

        if (_posix_current_thread->rc)
        {
                /* waiting-to-be thread has been
                 * already "readied" */
                _posix_current_thread->rc=0;

                posix_interrupts_enable();
                return;
        }

        _posix_current_thread->state = POSIX_THREAD_WAITING;

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        if ( ( _posix_current_thread->schedpolicy == 
                POSIX_SCHED_SPORADIC )                  &&
             ( _posix_current_thread->priority ==       
               _posix_current_thread->schedparam.sched_priority)
           )
        {
                ss_handle_blocking(_posix_current_thread);

        }
#endif

        /* force to go to 'posix_schedule_next' in routine below */
        _posix_sched_lock++;

#if ( POSIX_THREADS_DEBUG != 0 )
        _posix_current_thread->spuser  = (uint32_t)pal_architecture_get_current_sp();
#endif
        /* switch to next thread */
        posix_switch();

}

/* resets the thread's ready counter previous to a wait 
 * transition only at thread level */
void posix_thread_reset_rc(void)
{
        interrupts_disable();

        /* reset ready counter */
        _posix_current_thread->rc = 0;

        interrupts_enable();

}
 
/* -the thread undergoes a waiting->ready transition at thread 
 * and at interrupt level.
 * -nowhere in this routine should '_posix_current_thread' 
 * be accessed without checking first that it holds a non-NULL 
 * value (we could run at interrupt level on the grey area) */
void posix_thread_ready(posix_thread_t *thread, int reason)
{
        posix_interrupts_disable();

        thread->wake_reason     = reason;

        if (thread->state == POSIX_THREAD_RUNNING)
        {
                /* only increase ready counter */
                thread->rc++;
                posix_interrupts_enable();
        }
        else if (thread->state == POSIX_THREAD_WAITING)
        {
                /* add thread to tail of priority level */
                posix_rq_add_tail(thread, thread->priority);

                /* again a full quantum */
                posix_reset_timeslice(thread);
                thread->state = POSIX_THREAD_READY;

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
                /* sporadic server activation time */
                if (thread->schedpolicy == POSIX_SCHED_SPORADIC)
                {
                        clock_gettime(  CLOCK_MONOTONIC,
                                        &thread->activation_time);
                }
#endif

                posix_interrupts_enable();

                /* re-schedule point */
                posix_schedule_point();
        }
        else
        {
            posix_interrupts_enable();
        }

}

/* thread yields at thread level */
bool posix_thread_yield(void)
{
        posix_interrupts_disable();

        if (!posix_rq_empty(_posix_current_priority))
        {
                /* running thread to tail of priority list */
                posix_rq_add_tail( _posix_current_thread, 
                                   _posix_current_priority);

                _posix_current_thread->state = POSIX_THREAD_READY;

                _posix_sched_lock++;

#if ( POSIX_THREADS_DEBUG != 0 )
                _posix_current_thread->spuser  = (uint32_t)pal_architecture_get_current_sp();
#endif

                posix_switch();
        }
        else
        {
                posix_interrupts_enable();
                return false;
        }
        return true;
}

/* locks scheduler at posix thread level */
void posix_scheduler_lock(void)
{
        interrupts_disable();
        _posix_sched_lock++;
        interrupts_enable();
}

/* unlocks scheduler at posix thread level */
void posix_scheduler_unlock(void)
{
        bool ret;

        posix_interrupts_disable();

        ret = posix_schedule_reason();

        if (ret == true)
        {
                posix_interrupts_enable();
                /* allow possible pending posix interrupts */
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

/* running->suspended transition at thread level */
void posix_thread_exit(void)
{
        interrupts_disable();

        /* thread killed  */
        _posix_current_thread->state = POSIX_THREAD_SUSPENDED;

        interrupts_enable();
        
        /* switch to next thread */
        posix_schedule_next();

        /* never here */
}

/* indicates that an asr handler will execute in 
 * next execution of the thread */
void posix_thread_set_asrhandler(posix_thread_t* t)
{
        posix_interrupts_disable();

        if (    t->state == POSIX_THREAD_READY          ||
                t->state == POSIX_THREAD_WAITING)
        {
                t->asrpending = 1;
        }

        posix_interrupts_enable();
}

/* round-robin processing at clock handler */
void posix_round_robin(void)
{
        posix_thread_t * thread = _posix_current_thread;

        if (    thread != NULL &&
                thread->schedpolicy == POSIX_SCHED_RR)
        {
                if (thread->timeslice > 0)
                {
                        thread->timeslice--;
                }
        }
}

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
/* sporadic server processing at clock handler */
void posix_sporadic_server(void)
{
        posix_thread_t *thread = _posix_current_thread;

        if (    thread != NULL && 
                thread->schedpolicy == POSIX_SCHED_SPORADIC)
        {
                if (thread->timeslice > 0)
                {
                        thread->timeslice--;
                }
        }
}
#endif

