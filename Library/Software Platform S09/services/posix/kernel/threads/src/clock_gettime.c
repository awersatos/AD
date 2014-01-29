/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    clock_gettime
|*
\*****************************************************************************/
#include <time.h>
#include <sys/types.h>
#include <errno.h>
#include "posix_time.h"

#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		gets the current value tp for the specified clock, clock_id.
 *	
 *
 * @param clock_id
 *      identity of clock
 * @param tp
 *		return parameter that holds the clock's time
 * 
 * @return
 * 		If the function succeeds, a value of 0 shall be returned.
 *		If an error occurs for any of these functions, the value -1 shall be returned,
 *		and errno set to indicate the error.	
 *
 */

int clock_gettime(clockid_t clock_id, struct timespec *tp)
{
        clock_t ticks;
        posix_clock_t*  clock;

        if (    !VALID_CLOCKID(clock_id) || tp == NULL )
        {
                errno = EINVAL;
                return -1;              
        }
        
        clock = posix_map_clock(clock_id);

        if ( clock_id == CLOCK_MONOTONIC)
        {
                ticks = posix_clock_get(clock,NOT_EPOCH_SUPPORT);
        }
        else
        {
                ticks = posix_clock_get(clock,EPOCH_SUPPORT);
        }
        
        posix_ticks_to_timespec(clock,ticks,tp);                
        
        return 0;
}

#endif


