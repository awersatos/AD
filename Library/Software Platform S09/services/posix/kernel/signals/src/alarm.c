/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    alarm
|*
\*****************************************************************************/

#include <errno.h>
#include <limits.h>
#include "posix_signal.h"
#include "posix_time.h"
#include "kernel.h"

#if ( __POSIX_SIGNALS != 0 )

#if ( __POSIX_TIMERS != 0 )
bool   _posix_sigalarm_armed = false;
static posix_timer_t  _posix_alarm_timer;
static pthread_mutex_t _posix_alarms_mutex = PTHREAD_MUTEX_INITIALIZER;
#endif

/**
 * @brief
 *		generate a SIGALRM signal for the process after a number of realtime seconds
 *	
 *		The alarm() function shall cause the system to generate a SIGALRM signal 
 *		for the process after the number of realtime seconds specified by seconds 
 *		have elapsed. Processor scheduling delays may prevent the process from handling 
 *		the signal as soon as it is generated.
 *		If seconds is 0, a pending alarm request, if any, is canceled.
 *		Alarm requests are not stacked; only one SIGALRM generation can be scheduled 
 *		in this manner. If the SIGALRM signal has not yet been generated, the call shall 
 *		result in rescheduling the time at which the SIGALRM signal is generated.
 *
 * @param seconds
 *      number of seconds
 * @return
 * 		If there is a previous alarm() request with time remaining, alarm() shall 
 *		return a non-zero value that is the number of seconds until the previous request 
 *		would have generated a SIGALRM signal. Otherwise, alarm() shall return 0.
 */
unsigned int alarm(unsigned int seconds)
{
        unsigned int            res = 0;

#if ( __POSIX_TIMERS != 0 )
        struct timespec         ts;
        clock_t                 trigger;
        static bool             alarminit = false;
        
        pthread_mutex_lock(&_posix_alarms_mutex);       

        if (alarminit==false)
        {
                alarminit = true;
                _posix_alarm_timer.action.sigev.sigev_notify = SIGEV_SIGNAL;
                _posix_alarm_timer.action.sigev.sigev_signo  = SIGALRM;
                _posix_alarm_timer.action.sigev.sigev_value.sival_int = 0;
        }

        if ( _posix_sigalarm_armed == true )
        {
                posix_timer_rm(&_posix_alarm_timer);
                posix_ticks_to_timespec( CLOCK_REALTIME,
                                        _posix_alarm_timer.trigger,
                                        &ts);
                res = ts.tv_sec;
        }
        
        if (seconds != 0)
        { 
                _posix_sigalarm_armed = true;

                ts.tv_sec               = seconds;
                ts.tv_nsec              = 0;
                
                posix_timer_init(       &_posix_alarm_timer, 
                                        CLOCK_REALTIME,POSIX_TIMER_ALARM );     
                
                trigger = posix_timespec_to_ticks( _posix_alarm_timer.clock,
                                                   &ts);
                
                posix_set_timer(trigger,&_posix_alarm_timer,false);
        }

        pthread_mutex_unlock(&_posix_alarms_mutex);     
#endif
        
        return res;
}

#endif
