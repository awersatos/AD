/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    clock_settime
|*
\*****************************************************************************/

#include <time.h>
#include <sys/types.h>
#include <errno.h>
#include "posix_threads_cfg.h"
#include "posix_time.h"

#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		sets the specified clock, clock_id, to the value specified by tp
 *	
 *		Time values that are between two consecutive non-negative integer multiples 
 *		of the resolution of the specified clock shall be truncated down to the smaller 
 *		multiple of the resolution. 
 *		If the value of the CLOCK_REALTIME clock is set via clock_settime(), the new value 
 *		of the clock shall be used to determine the time of expiration for absolute time 
 *		services based upon the CLOCK_REALTIME clock. This applies to the time at which armed 
 *		absolute timers expire. If the absolute time requested at the invocation of such a time 
 *		service is before the new value of the clock, the time service shall expire immediately 
 *		as if the clock had reached the requested time normally. Setting the value of the 
 *		CLOCK_REALTIME clock via clock_settime() shall have no effect on threads that are blocked 
 *		waiting for a relative time service based upon this clock, including the nanosleep() function; 
 *		nor on the expiration of relative timers based upon this clock.
 *		The value of the CLOCK_MONOTONIC clock cannot be set via clock_settime(). 
 *
 * @param clock_id
 *      identity of the clock
 * @param tp
 *		pointer to a read-only struct timespec variable
 * 
 * @return
 * 		If the function succeeds, a value of 0 shall be returned.
 *		If an error occurs for any of these functions, the value -1 shall be returned,
 *		and errno set to indicate the error.	
 *
 */
int clock_settime( clockid_t clock_id, const struct timespec *tp)
{
        posix_clock_t* clock = NULL;
        bool res = 0;
        
        clock = &_posix_system_clock;

        if (    (clock_id != CLOCK_REALTIME

#if ( POSIX_THREADS_CPUTIME != 0 )
                && clock_id != CLOCK_THREAD_CPUTIME_ID
#endif

                ) || !posix_valid_timespec(tp) )
        {
                errno = EINVAL;
                return -1;
        }

#if ( POSIX_THREADS_CPUTIME != 0 )
        else if (clock_id == CLOCK_THREAD_CPUTIME_ID)
        {
                clock = &_posix_current_thread->clock;
        }
#endif

        posix_clock_set(clock,posix_timespec_to_ticks(clock,tp));
        
        return 0;
}

#endif

