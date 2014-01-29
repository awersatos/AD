/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigtimedwait
|*
\*****************************************************************************/

#include <errno.h>
#include <signal.h>
#include "posix_signal.h"
#include "posix_time.h"
#include "kernel.h"
#include "pal.h"

#if ( __POSIX_SIGNALS != 0 && __POSIX_REALTIME_SIGNALS!=0 )

/**
 * @brief
 *      selects a pending signal from set (with timeout)
 *  
 *      The sigtimedwait() function shall be equivalent to sigwaitinfo() except 
 *      that if none of the signals specified by set are pending, sigtimedwait() 
 *      shall wait for the time interval specified in the timespec structure referenced 
 *      by timeout. If the timespec structure pointed to by timeout is zero-valued and if 
 *      none of the signals specified by set are pending, then sigtimedwait() shall return 
 *      immediately with an error. If timeout is the NULL pointer, the behavior is unspecified.
 *      If the Monotonic Clock option is supported, the CLOCK_MONOTONIC clock shall be used 
 *      to measure the time interval specified by the timeout argument.
 *
 * @param set
 *      pointer to a read-only sigset_t variable
 * @param info
 *      return parameter that holds the signals info
 * @param timeoput
 *      pointer to a read-only timespec variable with the timeout
 * @return
 *      Upon successful completion (that is, one of the signals specified by set is 
 *      pending or is generated) it shall return the selected signal number. Otherwise, 
 *      the function shall return a value of -1 and set errno to indicate the error
 * 
 */
int sigtimedwait(const sigset_t *set, siginfo_t *info, const struct timespec *timeout)
{

        int                     err     = 0;
        clock_t                 ticks   = 0;
        posix_thread_t          *self = posix_self_thread();
        
        posix_signal_t* signal;
        sigset_t        sigtodo;
        sigset_t        sigmask;
        int             signo = 0;

        /* 'sigwait/sigtimedwait/sigwaitinfo' 
         * are cancellation points */
        pthread_testcancel();
        
        pthread_mutex_lock(&_posix_signals_mutex);

        /* wait until signal in set becomes pending */
        while( (sigtodo = (*set & (_posix_sig_pending | self->sigpending))) == 0 )
        {

#if ( __POSIX_TIMEOUTS != 0 )
                if ( timeout )
                {
                        if ( !posix_valid_timespec(timeout)             || 
                             (ticks = posix_timespec_to_ticks(
                                                &_posix_system_clock,timeout)
                                        )==0 )
                        {
                                err = EAGAIN;
                                break;
                        }
        
                        /* avoid preemptions while setting the timeout clock */
                        posix_scheduler_lock();

                        ticks += posix_clock_get(
                                &_posix_system_clock,
                                NOT_EPOCH_SUPPORT );
                }
                else
                {
#endif

                        ticks = -1;

#if ( __POSIX_TIMEOUTS != 0 )                   
                }
#endif
        
                self->sigwait = *set;
                self->osmutex = 1;
                
                err = __pthread_cond_timedwait( &_posix_signals_cond,
                                                &_posix_signals_mutex,ticks);
                
                if (err== ETIMEDOUT)
                {
                        err = EAGAIN;
                        break;
                }
                else if (err == EINTR)
                {
                        err = 0;
                }
                if (timeout)
                {
                        posix_scheduler_unlock();
                }
        }

        if (err ==0)
        {
                /* sigtodo contains at least a pending signal */

                /* lowest numbered signal has higher preference */
                signo   = pal_lsbit64_index(sigtodo);
                signal  = &_posix_signal_table[signo];
                sigmask = (1LL<<signo);

                /* dequeue signal with information in siginfo */
                if ( !posix_dequeue_signal(signal,info,(void**)NULL) )
                {
                        info->si_signo                  = signo;
                        info->si_code                   = SI_USER;
                        info->si_value.sival_int        = 0;
                }
                        
                /* not pending anymore: next threads wont catch this
                 * signal if not in their sigpending field */
                if (signal->pending == NULL)
                {
                        _posix_sig_pending &= ~sigmask;
                        self->sigpending &= ~sigmask;
                }
        }
        
        self->sigwait = 0;

        pthread_mutex_unlock(&_posix_signals_mutex);

        /* 'sigwait/sigtimedwait/sigwaitinfo' are cancellation points */
          pthread_testcancel();

        if (err)
        {
                errno = err;
                return -1;
        }

        return signo;
}

#endif
