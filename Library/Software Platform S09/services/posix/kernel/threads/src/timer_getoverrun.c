/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    timer_getoverrun
|*
\*****************************************************************************/

#include <errno.h>
#include <limits.h>
#include "posix_time.h"

#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		return the timer expiration overrun count
 *	
 *		The function shall return the timer expiration overrun count for the specified timer. 
 *		The overrun count returned contains the number of extra timer expirations that 
 *		occurred between the time the signal was generated (queued) and when it was delivered 
 *		or accepted, up to but not including an implementation-defined maximum of {DELAYTIMER_MAX}.
 *
 * @param timerid
 *      identity of the posix timer
 * 
 * @return
 * 		If the timer_getoverrun() function succeeds, it shall return the timer expiration 
 *		overrun count as explained above.
 *
 */
int timer_getoverrun(timer_t timerid)
{
        int                     err = 0;
        int                     overrun = 0;
        posix_timer_t*          timer;

        pthread_mutex_lock(&_posix_timers_mutex);

        if( (timer= posix_get_timer(timerid) ) == (posix_timer_t *) NULL )
        {       
                err = EINVAL;
        }
        else
        {
                overrun = (timer->overrun < DELAYTIMER_MAX)?
                        timer->overrun : DELAYTIMER_MAX;
        }
        
        pthread_mutex_unlock(&_posix_timers_mutex);
        
        if (err)
        {
                errno = err; return -1;
        }
        
        return overrun;

}

#endif

