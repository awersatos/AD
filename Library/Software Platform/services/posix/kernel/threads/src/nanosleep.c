/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    nanosleep
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "kernel.h"
#include "posix_time.h"
#include "posix_pthread.h"

#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		causes the current thread to be temporarily suspended from execution
 *		
 *		The nanosleep() function shall cause the current thread to be suspended 
 *		from execution until either the time interval specified by the rqtp argument 
 *		has elapsed or a signal is delivered to the calling thread, and its action is 
 *		to invoke a signal-catching function or to terminate the process. 
 *		The suspension time may be longer than requested because the argument value 
 *		is rounded up to an integer multiple of the sleep resolution or because of the 
 *		scheduling of other activity by the system. But, except for the case of being 
 *		interrupted by a signal, the suspension time shall not be less than the time 
 *		specified by rqtp, as measured by the system clock CLOCK_REALTIME.
 *
 * @param rqtp
 *		pointer to a read-only struct timespec variable ( see description )
 * @param rmtp
 *		pointer to a struct timespec variable ( see description )
 * 
 * @return
 * 		If the nanosleep() function returns because the requested time has elapsed, 
 *		its return value shall be zero.
 *	    If the nanosleep() function returns because it has been interrupted by a signal, 
 *		it shall return a value of -1 and set errno to indicate the interruption. 
 *		If the rmtp argument is non-NULL, the timespec structure referenced by it is 
 *		updated to contain the amount of time remaining in the interval (the requested 
 *		time minus the time actually slept). 
 *		If the rmtp argument is NULL, the remaining time is not returned.
 *	    If nanosleep() fails, it shall return a value of -1 and set errno to indicate the error.
 *
 */
int nanosleep(const struct timespec *rqtp, struct timespec *rmtp)
{
        int             err = 0;
        clock_t ticks, before=0, after = 0;
        posix_timer_t   timer;
        posix_thread_t* self = (posix_thread_t*)posix_self_thread();
        int oldcanceltype;

        pthread_testcancel();

        if( !posix_valid_timespec( rqtp ) )
        {
                errno = EINVAL; return -1;
        }

        if( rqtp->tv_sec != 0 || rqtp->tv_nsec != 0 )
        {
                /* non-zero delay */
                posix_timer_init(       &timer, 
                                        CLOCK_REALTIME, 
                                        POSIX_TIMER_TIMEOUT );  

                if ((ticks = posix_timespec_to_ticks( timer.clock, rqtp )))
                {       
                        /* all the way to the wait switch */
                        posix_scheduler_lock();
                        
                        posix_thread_reset_rc();
                        
                        if (posix_set_timer(ticks,&timer,false)!=0)
                        {
                                /* time has elapsed */
                                posix_scheduler_unlock();
                                return 0;
                        }
                        
                        /* deferred cancellations here to make sure 
                         * 'posix_timer_rm' can run before thread exits */
                        oldcanceltype = self->canceltype;
                        self->canceltype = PTHREAD_CANCEL_DEFERRED;
                
                        posix_thread_wait();
        
                        /* scheduler still locked */

                        if (self->wake_reason != POSIX_WAKE_TIMEOUT)
                        {
                                after = posix_clock_get(timer.clock,timer.kind);
                               /* thread has been awaken but not due to 
                                * a delay reason but a signal or cancellation */
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
                        
                        /* restore canceltype */
                        self->canceltype = oldcanceltype;

                        pthread_testcancel();
                }
        }

        if (err)
        {
                errno = err; return -1;
        }
        return 0;
}

#endif
