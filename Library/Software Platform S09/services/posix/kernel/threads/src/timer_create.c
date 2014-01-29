/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    timer_create
|*
\*****************************************************************************/

#include <errno.h>
#include "posix_time.h"

#if ( __POSIX_TIMERS != 0 )

static void * sigevthreads (void * arg);

/**
 * @brief
 *      creates a per-process timer using the specified clock
 *  
 *      The function shall create a per-process timer using the specified clock,
 *      clock_id, as the timing base. The timer_create() function shall return, 
 *      in the location referenced by timerid, a timer ID of type timer_t used to 
 *      identify the timer in timer requests. This timer ID shall be unique within 
 *      the calling process until the timer is deleted. The timer whose ID is 
 *      returned shall be in a disarmed state upon return from timer_create().
 *      The evp argument, if non-NULL, points to a sigevent structure. 
 *      This structure, allocated by the application, defines the asynchronous 
 *      notification to occur as specified in Signal Generation and Delivery 
 *      when the timer expires.
 *      
 * @param clockid
 *      identity of the specified clock
 * @param evp
 *      pointer to a struct sigevent variable
 * @param timerid
 *      return parameter holding the identity of the created timer
 * 
 * @return
 *      If the call succeeds, timer_create() shall return zero and update the 
 *      location referenced by timerid to a timer_t, which can be passed to the 
 *      per-process timer calls. If an error occurs, the function shall return 
 *      a value of -1 and set errno to indicate the error. 
 *      The value of timerid is undefined if an error occurs.       
 *
 */
 int timer_create(clockid_t clockid, struct sigevent * evp, timer_t * timerid)
{
        posix_timer_t*  timer = NULL;
        int             err = 0;
        bool            sigevthread = false;
        pthread_t       threadid;

        if( clockid != CLOCK_REALTIME   
                &&  clockid != CLOCK_MONOTONIC
#if ( __POSIX_THREAD_CPUTIME != 0 )
                &&  clockid != CLOCK_THREAD_CPUTIME_ID
#endif
                )
        {
                errno = EINVAL; return -1;
        }
        
        pthread_mutex_lock(&_posix_timers_mutex);
        
        if ( posix_alloc_timer(timerid)==false )
        {
                err = EAGAIN;
        }
        
        if ( err == 0 )
        {
                timer = &_posix_timer_table[*timerid];

                if( evp == NULL )
                {
                        timer->action.sigev.sigev_notify = SIGEV_SIGNAL;
                        timer->action.sigev.sigev_signo  = SIGALRM;
                        timer->action.sigev.sigev_value.sival_int = 
                                                           *timerid;
                }
                else
                {
                        timer->action.sigev.sigev_notify = evp->sigev_notify;
                        timer->action.sigev.sigev_signo  = evp->sigev_signo;
                        timer->action.sigev.sigev_value.sival_int = 
                                                evp->sigev_value.sival_int;
                        
                        if ( evp->sigev_notify == SIGEV_THREAD )
                        {
                                sigevthread = true;
                        }
                }

                timer->armed        = false;
                timer->overrun      = 0;
                timer->clock        = posix_map_clock(clockid);
                timer->kind         = (clockid==CLOCK_MONOTONIC)?
                                NOT_EPOCH_SUPPORT:EPOCH_SUPPORT;
        }
        
        if ( sigevthread )
        {
                if ( pthread_create (   &threadid, 
                                        evp->sigev_notify_attributes, 
                                        sigevthreads,
                                        (void*)timer ) != 0 )
                {
                        posix_free_timer(*timerid);

                        err = EAGAIN;
                }
                else
                {
                        /* sigev thread always runs detached */
                        _posix_thread_table[threadid]->joinstate = 
                                        PTHREAD_JOINSTATE_DETACH;
                        
                        timer->action.sigev.sigev_notify_function       =
                                evp->sigev_notify_function;

                        timer->action.sigev.sigev_notify_attributes     = 
                                (pthread_attr_t*)_posix_thread_table[threadid];
                }
        }
        
        pthread_mutex_unlock(&_posix_timers_mutex);
        
        if (err)
        {
                errno = err; return -1;
        }

        
        return 0;
}


static void * sigevthreads (void * arg) 
{
        posix_timer_t * timer = (posix_timer_t *) arg;
        volatile int forever = 1;

        while ( forever ) 
        {
                /* wait until timer expires */
                posix_thread_reset_rc();
                posix_thread_wait();
                
                /* deferred cancellation */
                pthread_testcancel();

                /* timer has expired: signals thread has awaken this thread. 
                 * run notification. */
                (*timer->action.sigev.sigev_notify_function)
                        (timer->action.sigev.sigev_value);
        }

        return NULL;

}


#endif



