/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    timer_settime
|*
\*****************************************************************************/

#include <errno.h>
#include "posix_time.h"

#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		sets the time until the next expiration of the timer
 *	
 *		The timer_settime() function shall set the time until the next expiration 
 *		of the timer specified by timerid from the it_value member of the value 
 *		argument and arm the timer if the it_value member of value is non-zero. 
 *		If the specified timer was already armed when timer_settime() is called, 
 *		this call shall reset the time until next expiration to the value specified. 
 *		If the it_value member of value is zero, the timer shall be disarmed. 
 *		The effect of disarming or resetting a timer with pending expiration 
 *		notifications is unspecified.
 *		If the flag TIMER_ABSTIME is not set in the argument flags, timer_settime() 
 *		shall behave as if the time until next expiration is set to be equal to the 
 *		interval specified by the it_value member of value. That is, the timer shall 
 *		expire in it_value nanoseconds from when the call is made. 
 *		If the flag TIMER_ABSTIME is set in the argument flags, timer_settime() 
 *		shall behave as if the time until next expiration is set to be equal to the 
 *		difference between the absolute time specified by the it_value member of value 
 *		and the current value of the clock associated with timerid. That is, the timer 
 *		shall expire when the clock reaches the value specified by the it_value member 
 *		of value. If the specified time has already passed, the function shall succeed 
 *		and the expiration notification shall be made.
 *		The reload value of the timer shall be set to the value specified by the 
 *		it_interval member of value. When a timer is armed with a non-zero it_interval, 
 *		a periodic (or repetitive) timer is specified.	
 * 		If the argument ovalue is not NULL, the timer_settime() function shall 
 *		store, in the location referenced by ovalue, a value representing the previous 
 *		amount of time before the timer would have expired, or zero if the timer was 
 *		disarmed, together with the previous timer reload value. 
 *		Timers shall not expire before their scheduled time.
 *
 * @param timerid
 *      identity of the posix timer
 * @param flags
 *		timer set flags
 * @param value
 *		pointer to a read-only struct itimerspec variable ( see description )
 * @param ovalue
 *		pointer to a struct itimerspec variable ( see description )
 * 
 * @return
 * 		If the function succeeds, a value of 0 shall be returned.
 *		If an error occurs for any of these functions, the value -1 shall be returned,
 *		and errno set to indicate the error.	
 *
 */
int timer_settime(timer_t timerid, int flags, const struct itimerspec * value, struct itimerspec * ovalue)
{
        bool                    armed;
        clock_t                 trigger, reload, otrigger=0, current=0;
        posix_timer_t *         timer;

        if (value == NULL ) {errno = EINVAL; return -1; }

        pthread_mutex_lock(&_posix_timers_mutex);
    
        if( (timer= posix_get_timer(timerid) ) == (posix_timer_t *) NULL )
        {
                pthread_mutex_unlock(&_posix_timers_mutex);
                errno = EINVAL; return -1;
        }
        
        trigger = posix_timespec_to_ticks (     timer->clock, 
                                                &value->it_value );
        reload  = posix_timespec_to_ticks (     timer->clock, 
                                                &value->it_interval );
        
        /* let us disarm the current one */
        armed =  (timer->armed == 1) ? true : false ;   
        if( armed)
        {
                otrigger = posix_timer_rm(timer);
        }
        else if( ovalue != NULL )
        {
                otrigger = 0;
        }

        if( ovalue != NULL )
        {
                posix_ticks_to_timespec( timer->clock,
                                         otrigger, 
                                         &ovalue->it_value );
                posix_ticks_to_timespec( timer->clock,
                                         timer->reload, 
                                         &ovalue->it_interval );
        }

        /* arm/reset the new expire value */ 
        if( trigger != 0 )
        {
                timer->reload = reload;
                if (posix_set_timer(trigger,timer, flags & TIMER_ABSTIME)!=0)
                {
                        if (reload)
                        {
                                /* already elapsed: let us start
                                 * the first reload*/
                                posix_set_timer(timer->reload,timer,false);
                        }
                }
        }

        pthread_mutex_unlock(&_posix_timers_mutex);

        return 0;
}

#endif
