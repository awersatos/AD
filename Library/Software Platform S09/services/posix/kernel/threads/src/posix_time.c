#include <errno.h>
#include <pthread.h>
#include <limits.h>
#include <pal.h>
#include <interrupts.h>
#include "posix_threads_cfg.h"
#include "pal_cfg.h"
#include "posix_main.h"
#include "posix_time.h"
#include "posix_signal.h"
#include "k_schedule.h"

#define _OSTICKNANOSCS  (1000L*POSIX_THREADS_OSTICKMICROSCS)

#if ( __POSIX_TIMEOUTS != 0 || __POSIX_TIMERS != 0 )

/* clock operations */
static void posix_system_clock_lock(void);
static void posix_system_clock_unlock(void);
#if ( __POSIX_THREAD_CPUTIME != 0 )
static void posix_cpuclock_lock(void);
static void posix_cpuclock_unlock(void);
static volatile int _posix_cpulock=0;
extern posix_thread_t*  _posix_old_thread;
extern int              _posix_irq_level;
#endif

/* signal queues */
#if ( __POSIX_SIGNALS != 0 )
/* signal queue for the hardware system clock */
static posix_signal_queue_t _posix_system_clock_signal_queue = 
{       NULL, 
        NULL,
        posix_system_clock_lock,
        posix_system_clock_unlock 
};

static void     posix_timer_signal_action(posix_timer_t* timer);

#if ( __POSIX_THREAD_CPUTIME != 0 )
/* signal queue for all cpu thread clocks */
static posix_signal_queue_t _posix_cpu_clock_signal_queue = 
{ 
        NULL, 
        NULL,
        posix_cpuclock_lock, 
        posix_cpuclock_unlock 
};

/* process the expiration queue */
static void posix_signal_queue_process(posix_signal_queue_t*);
#endif
#endif

/* timer handler: returns true if actions postponed to signal queue */
bool posix_timer_handler(posix_timer_t*);

/* array of user timers */
posix_timer_t   _posix_timer_table[TIMER_MAX];
pthread_mutex_t _posix_timers_mutex     = PTHREAD_MUTEX_INITIALIZER;
/* allocation */
static timer_t  _posix_timer_next = 0;
static void posix_timer_add ( posix_timer_t *);


/* system interrupt driven clock */
posix_clock_t   _posix_system_clock =
{
        _OSTICKNANOSCS,
        0, 0, 0,
        posix_system_clock_lock,
        posix_system_clock_unlock,
        0,
#if ( __POSIX_SIGNALS != 0 )
        NULL,
#endif
};

/* initialization for all cpuclocks in pthreads */
#if ( POSIX_THREADS_CPUTIME != 0 )
void posix_cpuclock_init(posix_clock_t *c)
{

        c->res          = 1000000000LL / (PAL_CLOCKHZ);
        c->ticks        = 0;
        c->epoch        = 0;
        c->base         = 0;
        c->lock         = posix_cpuclock_lock;
        c->unlock       = posix_cpuclock_unlock;
        c->active       = NULL;

#if ( __POSIX_SIGNALS != 0 )
        c->signal       = &_posix_cpu_clock_signal_queue;
#endif
}
#endif

/* updates a clock with a delta increment.
 * up to the users to take care of concurrency problems with queues, etc ..
 */
void posix_clock_update(posix_clock_t *c, clock_t delta)
{
#if ( __POSIX_SIGNALS != 0 )
        posix_timer_t   **tail;
        posix_timer_t   **next;
#endif
        posix_timer_t   *active;

        c->ticks += delta;
        if (c->active == NULL)
        {
                /* no timers to update */
                return;
        }
#if ( __POSIX_SIGNALS != 0 )
        tail = &c->signal->tail;
        if (c->signal->head == NULL)
        {
                next = &c->signal->head;
        }
        else
        {
                next = &c->signal->tail->queue;
        }
#endif
        /* correct the trigger value for timers 
         * that are added before we re done with
         * updating the queue */
        c->delta = delta;       
        while ( c->active && c->active->trigger <= c->delta )
        {
                active = c->active;
                c->active = c->active->queue;
                if ( active->handler(active) == false )
                {
#       if ( __POSIX_SIGNALS != 0 )
                        /* action to be postponed in an expiration queue */
                        *tail = active;
                        *next = active;
                        next = &(*next)->queue;
#       endif
                }
                c->delta -= active->trigger;
        }
        if (c->active)
        {
                c->active->trigger -= c->delta;
        }
        c->delta = 0;

#if ( __POSIX_SIGNALS != 0 )
        if (*tail != NULL)
        {
                (*tail)->queue = NULL;
        }
#endif
        return;
}


#if ( __POSIX_TIMERS != 0 )
/* sets a new epoch for a clock */
void posix_clock_set(posix_clock_t *c, clock_t val)
{

#if ( __POSIX_THREAD_CPUTIME != 0 )
        clock_t delta;
#endif

        clock_t offset = 0, current, temp = 0;
        posix_timer_t*  reorg           = NULL;
        posix_timer_t*  reorgptr        = NULL;
        posix_timer_t** pptr;

#if ( __POSIX_SIGNALS != 0 )
        posix_timer_t** tail;
        posix_timer_t** head;
#endif

        c->lock();

#if ( __POSIX_THREAD_CPUTIME != 0 )
        /* at thread level */
        current = clock();
        delta = current - _posix_current_thread->btime;
        _posix_current_thread->btime = current;
        posix_clock_update(&_posix_current_thread->clock, delta);
#endif

        if (c->active != NULL)
        {
#if ( __POSIX_SIGNALS != 0 )
                tail = &c->signal->tail;
                head = &c->signal->head;
#endif

                /* current time */
                current = c->ticks - c->base + c->epoch;

                /* let us dequeue all absolute timers with a new trigger value.
                 * We will dequeue them locally in '_reorg',
                 * a temporarily reorganization queue.
                 * A trigger value of 0 means that the timer will have
                 * expired with the new given value for the realtime clock.
                 */
                for (pptr = &c->active; *pptr != NULL; )
                {
                        offset += (*pptr)->trigger;

                        /* only affects realtime absolute timers */
                        if ( (*pptr)->abs && (*pptr)->kind == EPOCH_SUPPORT )
                        {
                                /* set timer in reorg queue */
                                if ( reorg == (posix_timer_t*)NULL)
                                {
                                        reorg                   = *pptr;
                                        reorgptr                = reorg;
                                }
                                else
                                {
                                        reorgptr->queue         = *pptr;
                                        reorgptr                = *pptr;
                                }

                                temp = (*pptr)->trigger;

                                if (offset + current <= val)
                                {
                                        (*pptr)->trigger = 0;
                                }
                                else
                                {
                                        (*pptr)->trigger = (offset + current) - val;
                                }

                                /* dequeue element finally in timers queue */
                                if ((*pptr)->queue != NULL)
                                {
                                        (*pptr)->queue->trigger +=  temp;
                                }
                                offset -= temp;
                                *pptr   = (*pptr)->queue;
                                /* reorg queue must end with NULL */
                                reorgptr->queue         = NULL;
                        }
                        else
                        {
                                pptr = &(*pptr)->queue;
                        }
                }

                /* we could .. enable timer here */


                /* let us work now the reorg queue */
                for (pptr = &reorg; *pptr != NULL; )
                {
                        if ((*pptr)->trigger == 0)
                        {
                                /* timer has expired with new clock value */
                                if ( (*pptr)->handler(*pptr) == false )
                                {
#                                       if ( __POSIX_SIGNALS != 0 )
                                        *tail       = *pptr;
                                        if (*head == (posix_timer_t *) NULL)
                                        {
                                                *head = *pptr;
                                        }
#                                       endif
                                        /* next in reorg queue */
                                        *pptr                   = (*pptr)->queue;

#                                       if ( __POSIX_SIGNALS != 0 )
                                        /* signal timers queue ends with NULL */
                                        (*tail)->queue  = NULL;
#                                       endif
                                }
                                else
                                {
                                        /* next in reorg queue */
                                        *pptr   = (*pptr)->queue;
                                }
                        }
                        else
                        {
                                reorgptr = *pptr;
                                /* dequeue element in reorg queue */
                                *pptr                   = (*pptr)->queue;
                                /* add timer again to the timers queue with
                                 * the new trigger value */
                                reorgptr->queue         = NULL;
                                posix_timer_add(reorgptr);
                        }
                }
        }
        /* new epoch value */
        c->epoch = val;
        /* epoch absolute ticks value */
        c->base  = c->ticks;

        c->unlock();
}
#endif

inline clock_t posix_clock_get_ticks(posix_clock_t *c, int kind)
{
        return ( kind == EPOCH_SUPPORT ? c->ticks - c->base + c->epoch : c->ticks );
}


clock_t posix_clock_get(posix_clock_t *c, int kind)
{
#if ( __POSIX_THREAD_CPUTIME != 0 )
        clock_t current, delta;
#endif

        clock_t ret;

        c->lock();

#if ( __POSIX_THREAD_CPUTIME != 0 )
        /* at thread level */
        current = clock();
        delta = current - _posix_current_thread->btime;
        _posix_current_thread->btime = current;
        posix_clock_update(&_posix_current_thread->clock, delta);
#endif

        ret = posix_clock_get_ticks(c, kind);

        c->unlock();

        return ret;
}


/* lock operations for the system clock:
 * - disable clock interrupt so no update on the clock can happen
 * - lock scheduler so no othr thread can start clock/timer
 *   operations
 */
static void posix_system_clock_lock(void)
{
        posix_scheduler_lock();
        pal_timer_interrupt_disable();
}

static void posix_system_clock_unlock(void)
{
        pal_timer_interrupt_enable();
        posix_scheduler_unlock();
}

#if ( __POSIX_THREAD_CPUTIME != 0 )
/* lock operations for the system clock:
 * - lock scheduler so no other thread can start clock/timer
 *   operations
 * - sets internal lock to avoid undesired update operations .
 */
static void posix_cpuclock_lock(void)
{
        posix_scheduler_lock();
        _posix_cpulock++;
}


static void posix_cpuclock_unlock(void)
{
        _posix_cpulock--;
        posix_scheduler_unlock();
}

/* this routine runs in the grey area (exiting threads) and from
 * first interrupt nesting level (ONLY) */
void posix_cpuclock_update(void)
{
        clock_t current, delta;
        posix_clock_t * c;

        posix_interrupts_disable();
        if ( _posix_cpulock++ > 0 )
        {
                /* some thread is busy with cpu clock services */
                goto posix_cpuclock_update_return;
        }
        posix_interrupts_enable();

        if ( _posix_irq_level==0 && _posix_old_thread!= NULL )
        {
                /* in posix_switch : '_posix_old_thread' variable
                 * holds exiting thread. the scheduler is already locked */
                c = &_posix_old_thread->clock;
                current = clock();
                delta = current - _posix_old_thread->btime;
                _posix_old_thread->btime = current;
        }
        else if ( _posix_irq_level == 1 && _posix_current_thread != NULL)
        {
                /* at first interrupt level */
                c = &_posix_current_thread->clock;
                current = clock();
                delta = current - _posix_current_thread->btime;
                _posix_current_thread->btime = current;
        }
        else
        {
                /* nothing otherwise */
                goto posix_cpuclock_update_return;
        }

        posix_clock_update(c, delta);

        posix_interrupts_disable();

posix_cpuclock_update_return:
        _posix_cpulock--;
        posix_interrupts_enable();
        return;
}

#endif


/* timers component initialization */
void posix_time_init(void)
{
        for (int i=0;i<TIMER_MAX;i++)
        {
                _posix_timer_table[i].handler = posix_timer_handler;
        }
#if ( __POSIX_SIGNALS != 0 )
        _posix_system_clock.signal = &_posix_system_clock_signal_queue;
#endif
}

/* timers allocation */
bool    posix_alloc_timer(timer_t* timer)
{
        timer_t next;

        next = _posix_timer_next;
        while( _posix_timer_table[next].alloc == 1)
        {
                next++;
                if( next >= TIMER_MAX )
                        next = 0;

                if( next == _posix_timer_next )
                {
                        *timer = -1;
                        return false;
                }
        }
        _posix_timer_next               = next;
        _posix_timer_table[next].alloc  = 1;
        *timer                          = next;

        return true;
}

bool posix_free_timer(timer_t timer)
{
        bool ret = false;
        if (timer >= 0 && timer < TIMER_MAX)
        {
                if (_posix_timer_table[timer].alloc)
                {
                        _posix_timer_table[timer].alloc = 0;
                        ret = true;
                }
        }
        return ret;
}

posix_timer_t *posix_get_timer(timer_t timer)
{
        posix_timer_t *ret = (posix_timer_t *)NULL;

        if (timer >= 0 && timer < TIMER_MAX)
        {
                if (_posix_timer_table[timer].alloc)
                {
                        ret = &_posix_timer_table[timer];
                }
        }
        return ret;
}

/* ticks - timespec */
bool posix_valid_timespec(const struct timespec *tmspec)
{
        if (tmspec == NULL              ||
                tmspec->tv_sec < 0      ||
                tmspec->tv_nsec < 0     ||
                tmspec->tv_nsec >= 1000000000)
        {
                return false;
        }

        return true;
}

void posix_ticks_to_timespec(   const posix_clock_t *c,
                                clock_t ticks,
                                struct timespec *tmspec)
{
        unsigned long long nsecs;
        long res = c->res;

        if( ticks == 0 )
        {
                tmspec->tv_sec = 0;
                tmspec->tv_nsec = 0;
                return;
        }
        nsecs = res * ticks;
        tmspec->tv_sec = (long)(nsecs / 1000000000ll);
        tmspec->tv_nsec = (long)(nsecs % 1000000000ll);

        return;
}

clock_t posix_timespec_to_ticks( const posix_clock_t *c, 
                                 const struct timespec *tmspec)
{
        clock_t ticks;
        long res = c->res;

        if (tmspec->tv_sec == 0 && tmspec->tv_nsec == 0)
        {
                return 0;
        }
        /* scs */
        ticks = (clock_t)tmspec->tv_sec * (1000000000L/(res));
        /* roundup to next tick */
        ticks += (tmspec->tv_nsec + res - 1)/(res);

        return ticks;
}

/* assumes valid timespecs */
void posix_timespec_subtract(   struct timespec *result, 
                                struct timespec *a, 
                                struct timespec *b)
{
        if (a->tv_nsec < b->tv_nsec)
        {
                result->tv_nsec = 1000000000 - b->tv_nsec;
                result->tv_sec = a->tv_sec - b->tv_sec - 1;
        }
        else
        {
                result->tv_nsec = a->tv_nsec - b->tv_nsec;
                result->tv_sec = a->tv_sec - b->tv_sec;
        }
}

/* assumes valid timespecs */
void posix_timespec_add(        struct timespec *result, 
                                struct timespec *a, 
                                struct timespec *b)
{
        result->tv_nsec = a->tv_nsec + b->tv_nsec;
        result->tv_sec = a->tv_sec + b->tv_sec;
        if (result->tv_nsec >= 1000000000)
        {
                result->tv_sec += 1;
                result->tv_nsec -= 1000000000;
        }
}

/* assumes valid timespecs */
int posix_timespec_compare(struct timespec *a, struct timespec *b)
{
        if (a->tv_sec != b->tv_sec)
        {
                if (a->tv_sec > b->tv_sec)
                {
                        return 1;
                }
                return -1;
        }
        if (a->tv_nsec == b->tv_nsec)
        {
                return 0;
        }
        else
        {
                if (a->tv_nsec > b->tv_nsec)
                {
                        return 1;
                }
                return -1;
        }
}

/* Timer management */
static void posix_timer_add(posix_timer_t *th)
{
        posix_timer_t   **pptr =  &th->clock->active;

        /* correct the trigger value when we're not yet done
         * updating the timer queue */
        if (th->clock->delta != 0)
        {
                th->trigger += th->clock->delta;
        }

        for ( ; *pptr != NULL; pptr = &(*pptr)->queue)
        {
                if (th->trigger < (*pptr)->trigger)
                {
                        (*pptr)->trigger -= th->trigger;
                        break;
                }
                th->trigger -= (*pptr)->trigger;
        }
        th->queue = *pptr;
        *pptr     = th;
        th->armed = 1;

        return;
}

clock_t posix_timer_rm(posix_timer_t *th)
{
        clock_t ret = 0;
        
        posix_timer_t **pptr = &th->clock->active;

        if (th != NULL)
        {
                pptr = &th->clock->active;

                th->clock->lock();

                for ( ; *pptr != NULL; pptr = &(*pptr)->queue)
                {
                        ret += (*pptr)->trigger;

                        if (*pptr == th)
                        {
                                if (th->queue)
                                {
                                        th->queue->trigger += (*pptr)->trigger;
                                }
                                *pptr           = th->queue;
                                th->queue       = NULL;
                                th->armed       = 0;
                                break;
                        }
                }
        }

        th->clock->unlock();

        return ret;
}


int posix_set_timer(clock_t ticks, posix_timer_t* timer, bool abstime)
{
        clock_t         current;

        timer->clock->lock();

        current = posix_clock_get_ticks(timer->clock, timer->kind);

        if (abstime == true)
        {
                if (ticks <= current)
                {
                        /* has already elapsed */
                        timer->clock->unlock();
                        return ETIMEDOUT;
                }

                if (timer->type != NOT_EPOCH_SUPPORT)
                {
                        timer->abs = 1;
                }
                else
                {
                        ticks -= current;
                        timer->abs = 0;
                }
        }
        else
        {
                timer->abs = 0;
        }

        if (timer->abs)
        {
                /* this is the new relative timeout */
                timer->trigger = ticks-current;
        }
        else
        {
                timer->trigger = ticks;
        }

        /* set the timer */
        posix_timer_add(timer);

        timer->clock->unlock();

        return 0;
}


/* timer handler: the same for all timers in all clocks
 *
 * timeouts: to be processed immediately : returns true
 * signals:  to be processed later in a dedicated thread (we want to prevent
 *           us from handling signals at interrupt level) : returns false
 *
 * system clock: runs only from clock handler (no concurrency problems)
 * cpu clock:    can run from both thread/interrupt level, must be protected
 *               with lock/unlock operations.
 */
bool posix_timer_handler(posix_timer_t* timer)
{
        bool ret = true;
        switch (timer->type)
        {

#if ( __POSIX_SIGNALS != 0 )
                /* alarm and signals to be processed in later thread */
        case POSIX_TIMER_ALARM:
        case POSIX_TIMER_SIGNAL:
                posix_thread_ready(
                        _posix_thread_table[_POSIX_KERNEL_THREAD], 
                        POSIX_WAKE_NONE );
                ret = false;
                break;
#endif
                /* time out */
        case POSIX_TIMER_TIMEOUT:
                posix_thread_ready(
                        timer->action.thread, 
                        POSIX_WAKE_TIMEOUT );
                break;

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)

        case POSIX_TIMER_SPORADIC_SERVER_REPLENISHMENT:
                ss_replenish(timer->action.thread, &(timer->replenishment));
                break;

        case POSIX_TIMER_SPORADIC_SERVER_BUDGET:
                /* update execution time */
                // done in update 
                // timer->action.thread->execution_time += 
                // clock() - timer->action.thread->start_of_run_time;

                /* update budget */
                ss_update_budget(timer->action.thread);

                /* schedule replenishment */
                ss_schedule_replenishment(timer->action.thread);

                /* keep running and install timer if there is 
                 * budget left (should not happen but just incase it does) */
                if (    timer->action.thread->budget.tv_sec != 0 || 
                        timer->action.thread->budget.tv_nsec != 0)
                {
                        ss_budget_timer(timer->action.thread);
                }
                else
                {
                        /* else swith to low priority */
                        posix_thread_set_priority( 
                                timer->action.thread, 
                                timer->action.thread->schedparam.sched_ss_low_priority 
                                );
                }

                break;
#endif

        default:
                break;
        }
        return ret;
}



/* timers signal processing */
#if ( __POSIX_SIGNALS != 0 )

static void posix_timer_signal_action(posix_timer_t *timer)
{
        int signo;
        bool generate = true;

        switch (timer->type)
        {
                /* alarm */
                case POSIX_TIMER_ALARM:
                        _posix_sigalarm_armed = false;
                        posix_generate_signal(  &timer->action.sigev, 
                                                SI_USER, 
                                                NULL);

                        break;

                /* timer_settime */
                case POSIX_TIMER_SIGNAL:

                        signo = timer->action.sigev.sigev_signo;

                        if (    _posix_signal_table[signo].sa.sa_flags & 
                                SA_SIGINFO)
                        {
                                /* queueud timer signals */

                                if (timer->pending)
                                {
                                        /* the signal of this timer is 
                                         * still pending */
                                        timer->overrun++;
                                        generate = false;
                                }
                                else
                                {
                                        /* the signal of this timer is 
                                         * not pending */
                                        timer->pending = 1;
                                }
                        }
                        else if ((_posix_sig_pending & (1LL << signo)))
                        {
                                /* the signal still pending */
                                timer->overrun++;
                                generate=false;
                        }

                        if (generate)
                        {
                                posix_generate_signal(
                                        &timer->action.sigev, 
                                        SI_TIMER, 
                                        timer);

                                timer->overrun = 0;
                        }
                        break;
                default: break;
        }

        if (timer->reload)
        {
                timer->trigger = timer->reload;
                timer->clock->lock();
                posix_timer_add(timer);
                timer->clock->unlock();
        }
}

/* this function processes all the expired timers for a given expiry queue */
static void posix_signal_queue_process(posix_signal_queue_t *q)
{
        posix_timer_t *timer = NULL;

        /* lock updates */
        q->lock();

        while (q->head != (posix_timer_t *)NULL)
        {
                /* dequeue head */
                timer = q->head;
                q->head = q->head->queue;
                /* unlock updates */
                q->unlock();
                /* process signal */
                posix_timer_signal_action(timer);

                q->lock();
        }

        q->tail = NULL;

        q->unlock();
}

/* The thread that processes all expired timers */
void posix_signals_thread_code(void)
{
        posix_timer_t*  timer = (posix_timer_t*)NULL;
 
        while (1)
        {
                #if ( __POSIX_THREAD_CPUTIME != 0 )
                /* process expired thread cpu timers */
                posix_signal_queue_process(&_posix_cpu_clock_signal_queue);
                #endif
                /* process monotonic and realtime timers */
                posix_signal_queue_process(&_posix_system_clock_signal_queue);

                /* finish processin expired timers */
                posix_thread_reset_rc();
                posix_thread_wait();
        }

}
#endif /* __POSIX_SIGNALS */

#endif
