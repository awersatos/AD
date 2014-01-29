/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    timer_gettime
|*
\*****************************************************************************/

#include <errno.h>
#include "posix_time.h"

#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		gets information from the a posix timer
 *		
 *		The timer_gettime() function shall store the amount of time until the 
 *		specified timer, timerid, expires and the reload value of the timer 
 *		into the space pointed to by the value argument. The it_value member 
 *		of this structure shall contain the amount of time before the timer expires, 
 *		or zero if the timer is disarmed. This value is returned as the interval 
 *		until timer expiration, even if the timer was armed with absolute time. 
 *		The it_interval member of value shall contain the reload value last 
 *		set by timer_settime().
 *
 * @param timerid
 *      identity of the posix timer
 * @param value
 *		pointer to a struct itimerspec variable ( see description )
 * 
 * @return
 * 		If the function succeeds, a value of 0 shall be returned.
 *		If an error occurs for any of these functions, the value -1 shall be returned,
 *		and errno set to indicate the error.	
 *
 */
int timer_gettime(timer_t timerid, struct itimerspec *value)
{
        posix_timer_t*  timer;
        int             err = 0;
        
        if( value == NULL )
        {
                errno = EINVAL; return -1;
        }
        
        pthread_mutex_lock(&_posix_timers_mutex);

        if( (timer= posix_get_timer(timerid) ) == (posix_timer_t *) NULL )
        {
                err = EINVAL;
        }
        else
        {
                timer->clock->lock();
                        
                if( timer->armed )
                {
                        posix_ticks_to_timespec( timer->clock, 
                                                 timer->trigger, 
                                                 &value->it_value );
                }
                else 
                {
                        posix_ticks_to_timespec( timer->clock,
                                                 0, 
                                                 &value->it_value );
                }

                timer->clock->unlock();
                
                posix_ticks_to_timespec( timer->clock, 
                                         timer->reload, 
                                         &value->it_interval );
        }

        pthread_mutex_unlock(&_posix_timers_mutex);
        
        if (err)
        {
                errno = err; return -1;
        }

        return 0;
}

#endif
