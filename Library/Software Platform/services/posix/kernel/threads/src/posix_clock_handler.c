#include <stdint.h>
#include <pal.h>
#include "posix_main.h"
#include "posix_time.h"
#include "kernel.h"
#include "k_schedule.h"

#if ( (__POSIX_TIMEOUTS != 0) || (__POSIX_TIMERS != 0) )

void posix_clock_interrupt_handler(void)
{

     _posix_sched_lock++;

#if ( POSIX_THREADS_DEBUG != 0 )
     if( _posix_current_thread != NULL )
     {
        _posix_current_thread->ra      = _posix_resume_address;
        _posix_current_thread->spuser  = _posix_user_stack;
     }
#endif

#if ( __POSIX_THREAD_CPUTIME != 0 )
    /* last action of thread: check expirations of cpuclocks */
    posix_cpuclock_update();
#endif

    /* update system clock */
    posix_clock_update(&_posix_system_clock,1);

#if __TIMERS__ != 0
    /* update pal timers */
    pal_timers_common_handler();
#endif

    /* process round robin */
    posix_round_robin();

    if( _posix_current_thread != NULL )
    {
        posix_interrupt_schedule_point();
    }

    return;
}

#endif
        
