/******************************************************************************
 * FILE:                @(#)posix_time.h        1.19 07/03/16
 * DESCRIPTION:
 *      internal posix time interface: clocks, timers and some implementation
 *      specific utilities.
 *****************************************************************************/
#ifndef _H_POSIX_TIME
#define _H_POSIX_TIME

#include <time.h>
#include <pthread.h>
#include "kernel.h"
#include "posix_types.h"

#if ( __POSIX_THREAD_CPUTIME != 0 )
#define VALID_CLOCKID(var)      (var>=0 && var<=2)
#else
#define VALID_CLOCKID(var)      (var>=0 && var<=1)
#endif

#if ( (__POSIX_TIMEOUTS != 0) || (__POSIX_TIMERS != 0) )

/* to access the system clock: a static variable */
extern posix_clock_t    _posix_system_clock;
/* gets the current value of a clock */
extern clock_t  posix_clock_get(posix_clock_t*, int);
/* resets the clock to a new epoch */
extern void     posix_clock_set( posix_clock_t*, clock_t );

/* posix_system_clock_update, posix_cpu_clock_update
 * 
 * specific functions that update the system and the cpu clock
 * by a delta and manage their active timers queue. 
 * In both cases, expired timers run their handlers. 
 * Signal timers will queue up in a signal queue for later 
 * processing by a dedicated signal thread. 
 *
 * Both routines are wrappers around ' posix_clock_update' */
extern void     posix_clock_update( posix_clock_t*, clock_t );
inline void     posix_system_clock_update( void){
        posix_clock_update(&_posix_system_clock,1);
}
#if ( __POSIX_THREAD_CPUTIME != 0 )
extern void     posix_cpuclock_update( void );
#endif

#if ( __POSIX_THREAD_CPUTIME != 0 )
/* routine to initialize cpuclock clock objects 
 * (system clock object is initialized at compile time) */
extern void     posix_cpuclock_init(posix_clock_t *c);
#endif

/* system clock kernel handlers to must be available to lower layers */
extern void     posix_clock_handler(void);
extern void     __posix_clock_handler(void);


/* set of timers */
extern posix_timer_t    _posix_timer_table[];
/* timers component initialization */
extern void             posix_time_init(void);

/* timer allocation */
extern pthread_mutex_t _posix_timers_mutex;
/* must run with 'posix_time_lock' locked */
extern bool             posix_alloc_timer(timer_t*);
/* must run with 'posix_time_lock' locked */
extern bool             posix_free_timer(timer_t);
/* must run with '_posix_time_lock' locked */
extern posix_timer_t *  posix_get_timer(timer_t);

/* rm a timer in the active timer queue of a clock */
extern clock_t          posix_timer_rm(posix_timer_t *);

#if ( __POSIX_TIMERS != 0 )
/* sets a relative/absolute timer */
extern int posix_set_timer(clock_t time, 
                posix_timer_t* timer, bool abstime);
#endif

extern posix_clock_t    _posix_system_clock;

/* timespec to ticks routines: no need protection */
extern bool     posix_valid_timespec(const struct timespec *tp);

extern void     posix_ticks_to_timespec(const posix_clock_t *c, 
                                        clock_t,struct timespec* );

extern clock_t  posix_timespec_to_ticks(const posix_clock_t *c, 
                                        const struct timespec *tp );

extern void     posix_timespec_add(     struct timespec *, 
                                        struct timespec *, 
                                        struct timespec * );

extern int      posix_timespec_compare( struct timespec *, 
                                        struct timespec * );

extern void     posix_timespec_subtract(struct timespec *result, 
                                        struct timespec *a, 
                                        struct timespec *b );

inline posix_clock_t*   posix_map_clock(clockid_t id)
{
        #if ( __POSIX_THREAD_CPUTIME != 0 )
        if ( id == CLOCK_THREAD_CPUTIME_ID )
        {
                if ( _posix_current_thread != NULL )
                {
                        return  &_posix_current_thread->clock;
                }
                else 
                {
                        return NULL;
                }
        }
        else
        #endif
        
        return &_posix_system_clock;
}

/* These is helpful to initialize timer objects on the stack of system services 
 * that require timeout services. */
inline void posix_timer_init(posix_timer_t *t, clockid_t id, int type)
{
        extern bool posix_timer_handler(posix_timer_t* timer);
        if (t != NULL)
        {
                t->clock                = posix_map_clock(id);
                t->action.thread        = _posix_current_thread;
                t->type                 = type;
                t->kind                 = (id == CLOCK_MONOTONIC) ? NOT_EPOCH_SUPPORT : EPOCH_SUPPORT;
                t->reload               = 0;
                t->handler              = posix_timer_handler;
                t->armed                = false;
                t->overrun              = 0;
        }
}

#endif // TIMEOUTS TIMERS

#endif


