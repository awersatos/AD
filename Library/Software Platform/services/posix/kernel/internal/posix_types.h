/******************************************************************************
 * FILE:        @(#)posix_types.h       1.4 07/02/21
 * DESCRIPTION:
 *      internal posix typedefs of this implementation
 * REMARK:
 *****************************************************************************/

#ifndef _H_POSIX_TYPES
#define _H_POSIX_TYPES

#include <time.h>
#include <stdbool.h>
#include <pthread.h>

#if ( (__POSIX_TIMEOUTS != 0) || (__POSIX_TIMERS != 0) )

typedef struct __clock_t        posix_clock_t;
typedef struct __timer_t        posix_timer_t;
typedef struct __signal_queue_t posix_signal_queue_t;

/*
 * defines a set of actions to be performed as soon as the value of
 * the clock reaches a certain pre-defined value.
 * A EPOCH_SUPPORT timer is affected when the clock is set to a new value.
 * Three actions are currently possible: alarms, signals and timeouts.
 * Two more are added for SPORADIC_SERVER functionality.
 */
struct __timer_t
{
        uint32_t        armed:1,
                        pending:1,
                        alloc:1,
                        overrun:8,
#define NOT_EPOCH_SUPPORT                               0
#define EPOCH_SUPPORT                                   1
                        kind:2,
#define POSIX_TIMER_SIGNAL                              0
#define POSIX_TIMER_TIMEOUT                             1
#define POSIX_TIMER_ALARM                               2
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
#  define POSIX_TIMER_SPORADIC_SERVER_REPLENISHMENT     3
#  define POSIX_TIMER_SPORADIC_SERVER_BUDGET            4
#endif
                        type:4,
                        abs:1;

        /* timer action information */
        union {
                struct sigevent sigev;
                posix_thread_t  *thread;
        } action;

        /* timer actions to be taken upon expiration.
         * returns true when action has been delayed in an expiration
         * queue (signals) */
        bool (*handler)(posix_timer_t*);

        /* the clock that feeds the timer */
        posix_clock_t           *clock;

        /* Relative expire timer of in relation with its predecessor */
        clock_t                 trigger;
        /* Reload periodic time */
        clock_t                 reload;
        /* next queued timer */
        posix_timer_t           *queue;

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        struct timespec         replenishment;
#endif
};

/* something that measures "time" (happenings of a recurring event)
 * normally a hardware timer but we could have here just software clocks.
 *
 * A clock holds a list with active timers (i.e. pending actions).
 * A clock manages this list after every tick. When a timer expires, the clock
 * will remove the timer from the active list and put it in a expire list where
 * they will be processed by other components.
 * Clocks have no idea then about the intrinsics of timers.
 *
 * With support for _POSIX_CPUTIME_THREAD but not for _POSIX_CPUTIME),
 * the number of clocks in the system is:
 *      - one interrupt driven system clock
 *      - one cpuclock per pthread
 */
struct __clock_t
{
        /* resolution in nscs */
        long            res;
        /* absolute number of ticks */
        clock_t         ticks;
        /* offset ticks value at epoch (user defined) */
        clock_t         epoch;
        /* absolute number of ticks at epoch */
        clock_t         base;

        /* lock clock for updates */
        void (*lock)(void);
        /* unlock clock for updates */
        void (*unlock)(void);

        /* active timers queue based on this clock */
        posix_timer_t           *active;

#if ( __POSIX_SIGNALS != 0 )
        /* signal queue */
        posix_signal_queue_t*   signal;
#endif

        /* to be able to correct the trigger value for timers 
         * that are added before we're done updating the queue */
        clock_t         delta;
};


/* queue of expired timers. A clock leaves expired timers in an specific
 * queue for later processing since the update operation can always take
 * place at interrupt level. A dedicated thread will take care of processing
 * these queues.
 * (not applicable to timeouts)
 */
#if ( __POSIX_SIGNALS != 0 )
struct __signal_queue_t
{
        /* head/tail of expired signals to be process */
        posix_timer_t* head;
        posix_timer_t* tail;
        /* lock/unlock update operations on the queue */
        void (*lock)(void);
        void (*unlock)(void);

};
#endif

#endif

#endif

