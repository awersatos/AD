/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    timer_delete
|*
\*****************************************************************************/

#include <errno.h>
#include "posix_time.h"
 
#if ( __POSIX_TIMERS != 0 )

/**
 * @brief
 *		deletes the specified timer
 *
 *		The timer_delete() function deletes the specified timer, timerid, 
 *		previously created by the timer_create() function. If the timer 
 *		is armed when timer_delete() is called, the behavior shall be as 
 *		if the timer is automatically disarmed before removal. 
 *		The disposition of pending signals for the deleted timer is unspecified.
 *
 * @param timerid
 *      identity of the posix timer
 * 
 * @return
 * 		If the function succeeds, a value of 0 shall be returned.
 *		If an error occurs for any of these functions, the value -1 shall be returned,
 *		and errno set to indicate the error.	
 *
 */
int timer_delete(timer_t timerid)
{
        int ret                 = 0;
        posix_timer_t*          timer;
        posix_thread_t *        th = NULL;
        
        pthread_mutex_lock(&_posix_timers_mutex);

        if( (timer= posix_get_timer(timerid) ) == (posix_timer_t *) NULL )
        {
                ret = EINVAL;
        }
        else
        {
                if (timer->armed)
                {
                        posix_timer_rm(timer);
                }

                if ( timer->action.sigev.sigev_notify == SIGEV_THREAD )
                {
                        
                        th = (posix_thread_t*)
                                (timer->action.sigev.sigev_notify_attributes);
                
                        posix_scheduler_lock();
        
                        if ( th->cancelpending == 0 )
                        {       
                                th->cancelpending = 1;
        
                                if ( th->cancelstate == PTHREAD_CANCEL_ENABLE )
                                {
                                        if (    th->canceltype == 
                                                PTHREAD_CANCEL_ASYNCHRONOUS )
                                        {
                                                th->asrpending = 1;
                                        }
                                
                                        posix_thread_ready(th,POSIX_WAKE_CANCEL);
                                }
                        }
        
                        posix_scheduler_unlock();

                }
                
                posix_free_timer(timerid);
        }
        
        pthread_mutex_unlock(&_posix_timers_mutex);

        if (ret!=0)
        {
                errno = ret; return -1;
        }
        return 0;

}

#endif

