/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    clock_nanosleep
|*
\****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"
#include "posix_pthread.h"
#include "posix_time.h"

#if (__POSIX_CLOCK_SELECTION!=0)

/**
 * @brief
 *		causes the current thread to be temporarily suspended from execution
 *		
 *		The clock used to measure the time shall be the clock specified by clock_id.
 * 		If the flag TIMER_ABSTIME is not set in the flags argument, the clock_nanosleep() 
 *		function shall cause the current thread to be suspended from execution until the 
 *		time interval specified by the rqtp argument has elapsed. If the flag TIMER_ABSTIME 
 *		is set in the flags argument, the clock_nanosleep() function shall cause the current 
 *		thread to be suspended from execution until either the time value of the clock 
 *		specified by clock_id reaches the absolute time specified by the rqtp argument.
 *		The clock_nanosleep() function shall fail if the clock_id argument refers to the CPU-time 
 *		clock of the calling thread. It is unspecified whether clock_id values of other 
 *		CPU-time clocks are allowed
 *		
 * @param clock_id
 *		identity of the clock to nanosleep
 * @param flags
 *		call flags
 * @param rqtp
 *		pointer to a read-only struct timespec variable ( see description )
 * @param rmtp
 *		pointer to a struct timespec variable ( see description )
 * 
 * @return
 * 		If the clock_nanosleep() function returns because the requested time has elapsed, 
 *		its return value shall be zero.
 *	    If the clock_nanosleep() function returns because it has been interrupted by a signal, 
 *		it shall return a value of -1 and set errno to indicate the interruption. 
 *		If the rmtp argument is non-NULL, the timespec structure referenced by it is 
 *		updated to contain the amount of time remaining in the interval (the requested 
 *		time minus the time actually slept). 
 *		If the rmtp argument is NULL, the remaining time is not returned.
 *	    If clock_nanosleep() fails, it shall return a value of -1 and set errno to indicate the error.
 *
 */
int clock_nanosleep(    clockid_t clock_id, 
                        int flags,
                        const struct timespec *rqtp,
                        struct timespec *rmtp)
{       
        int             err = 0;
        clock_t         ticks, before=0, after =0;
        posix_timer_t   timer;
        posix_thread_t* self = (posix_thread_t*)posix_self_thread();
        int oldcanceltype;
        
        if ( !posix_valid_timespec( rqtp ) )
        {
                return EINVAL;
        }

        if (    clock_id != CLOCK_REALTIME      &&       
                clock_id != CLOCK_MONOTONIC   )
        {
                return ENOTSUP;
        }
                
        pthread_testcancel();
        
        if( rqtp->tv_sec != 0 || rqtp->tv_nsec != 0 )
        {
                posix_timer_init(       &timer, 
                                        clock_id, 
                                        POSIX_TIMER_TIMEOUT );  
                
                if ((ticks = posix_timespec_to_ticks(timer.clock,rqtp )))
                {       
                        /* all the way to the wait switch */
                        posix_scheduler_lock();

                        posix_thread_reset_rc();
                        
                        if(posix_set_timer(     ticks,
                                                &timer,
                                                flags & TIMER_ABSTIME )!=0)
                        {
                                /* time has elapsed */
                                posix_scheduler_unlock();
                                return 0;
                        }
                        
                        /* make sure timer_rm runs before thread exits */
                        oldcanceltype = self->canceltype;
                        self->canceltype = PTHREAD_CANCEL_DEFERRED;
                
                        /* wait */
                        posix_thread_wait();

                        /* scheduler still locked */

                        if (self->wake_reason != POSIX_WAKE_TIMEOUT)
                        {
                                after = posix_clock_get( timer.clock, 
                                                         timer.kind);
                               /* thread has been awaken but not due to 
                                * a delay reason but a signal or 
                                * cancellation */
                                posix_timer_rm(&timer);
                                err = EINTR;
                        }
                        
                        if (self->wake_reason == POSIX_WAKE_SIGNAL)
                        {
                                if( rmtp != NULL && before + ticks > after )
                                {       
                                        // Calculate remaining number of ticks.
                                        ticks -= (after-before);
        
                                        posix_ticks_to_timespec( timer.clock, 
                                                                 ticks, 
                                                                 rmtp );
                                }
                        }

                        posix_scheduler_unlock();
                        
                        /* restore old cancel type */
                        self->canceltype = oldcanceltype;

                        pthread_testcancel();
                }
        }       
        
        return err;
}

#endif
