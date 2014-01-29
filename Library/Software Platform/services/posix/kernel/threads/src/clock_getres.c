/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    clock_getres
|*
\*****************************************************************************/

#include <time.h>
#include <sys/types.h>
#include <errno.h>
#include "posix_time.h"

#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		returns the resolution of any clock
 *	
 *		The clock_getres() function shall return the resolution of any clock. 
 *		Clock resolutions are implementation-defined and cannot be set by a process. 
 *		If the argument res is not NULL, the resolution of the specified clock shall 
 *		be stored in the location pointed to by res. If res is NULL, the clock resolution 
 *		is not returned. If the time argument of clock_settime() is not a multiple of res, 
 *		then the value is truncated to a multiple of res.
 *
 * @param clock_id
 *      identity of clock
 * @param res
 *		return parameter that holds the clock's resolution
 * 
 * @return
 * 		If the function succeeds, a value of 0 shall be returned.
 *		If an error occurs for any of these functions, the value -1 shall be returned,
 *		and errno set to indicate the error.	
 *
 */
int clock_getres(clockid_t clock_id, struct timespec *res)
{
        int err = 0;
        
        if (    !VALID_CLOCKID(clock_id) || res == NULL )
        {
                errno = EINVAL;
                return -1;              
        }
        else
        {
                posix_ticks_to_timespec( posix_map_clock(clock_id),1,res );
                return 0;
        }
}

#endif


