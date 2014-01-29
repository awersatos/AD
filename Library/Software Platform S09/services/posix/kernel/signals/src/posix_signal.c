#include <errno.h>
#include <stdlib.h>
#include "posix_signal.h"
#include "posix_time.h"
#include "posix_main.h"
#include "kernel.h"
#include "pal.h"

#if ( __POSIX_SIGNALS != 0 )

/* signals critical code */
pthread_mutex_t         _posix_signals_mutex = PTHREAD_MUTEX_INITIALIZER;
/* thread synchronization in sigsuspend and sigwait */ 
pthread_cond_t          _posix_signals_cond;
/* signal pending masks */
sigset_t                _posix_sig_pending;

/* signal information table */
posix_signal_t  _posix_signal_table[sizeof(sigset_t)*8];

/* realtime signals queue: could be made static */
posix_siginfo_t         _posix_signal_queue[SIGQUEUE_MAX];
posix_siginfo_t*        _posix_siginfo_next = NULL;

/* init signals */
void    posix_signal_init(void)
{
        int i;
        
        /* signals_cond uses monotonic clock */
        _posix_signals_cond.initi       = _ATTR_INIT_KEY;
        _posix_signals_cond.clock_id    = CLOCK_MONOTONIC;
        _posix_signals_cond.queue.head = NULL;
        _posix_signals_cond.queue.tail = NULL;

        /* all realtime signals initially queued */
        for ( i=0; i<SIGQUEUE_MAX; i++ )
        {
                _posix_signal_queue[i].next     = _posix_siginfo_next;
                _posix_siginfo_next             = &_posix_signal_queue[i];
        }
        /* all signals to default action */
        for ( i=0;i<(sizeof(sigset_t)*8); i++)
        {
                _posix_signal_table[i].sa.sa_handler = SIG_DFL;
        }
        
        /* no signals initially pending */
        sigemptyset(&_posix_sig_pending);
}

/* realtime signals queue management */
bool    posix_queue_signal(     posix_signal_t* signal, 
                                const struct sigevent *sev, 
                                int code,
                                void* data)
{
        posix_siginfo_t*        siginfoptr;

        if (_posix_siginfo_next == NULL)
        {
                return false;
        }

        siginfoptr              = _posix_siginfo_next;
        _posix_siginfo_next     = siginfoptr->next;

        siginfoptr->siginfo.si_signo    = sev->sigev_signo;
        siginfoptr->siginfo.si_code     = code;
        siginfoptr->siginfo.si_value    = sev->sigev_value;
        siginfoptr->reserved            = data;


        if (signal->pending == NULL)
        {
                siginfoptr->next = siginfoptr;
        }
        else
        {
                siginfoptr->next = signal->pending->next;
                signal->pending->next = siginfoptr;
        }
        signal->pending = siginfoptr;
        return true;
}

bool    posix_dequeue_signal(   posix_signal_t* signal , 
                                siginfo_t* infoptr,
                                void ** data)
{
        posix_siginfo_t*        siginfoptr;
         
        if(signal->pending != NULL)
        {
                siginfoptr = signal->pending->next;

                infoptr->si_signo       = siginfoptr->siginfo.si_signo;
                infoptr->si_code        = siginfoptr->siginfo.si_code;
                infoptr->si_value       = siginfoptr->siginfo.si_value;
                if (data != (void**)NULL)
                {
                        *data           = siginfoptr->reserved;
                }
                if( signal->pending == siginfoptr )
                {
                    signal->pending = NULL;
                }
                else
                {
                    signal->pending->next = siginfoptr->next;
                }
                
                siginfoptr->next = _posix_siginfo_next;
                _posix_siginfo_next = siginfoptr;
                return true;
        }
        return false;
}

void    posix_free_signal(posix_signal_t* signal)
{
        posix_siginfo_t*        siginfoptr;
        
        while( signal->pending != NULL )
        {
                siginfoptr = signal->pending->next;

                if( signal->pending == siginfoptr )
                {
                        signal->pending = NULL;
                }
                else
                {
                    signal->pending->next = siginfoptr->next;
                }
                siginfoptr->next = _posix_siginfo_next;
                _posix_siginfo_next = siginfoptr;
        }
}

/* signal generation */

bool    posix_generate_signal(  const struct sigevent *sev, 
                                int code, 
                                void *data )
{
        posix_thread_t*         self    = posix_self_thread();
        bool                    locked  = false;
        posix_signal_t*         signal;
        int                     signo   = sev->sigev_signo;
        void*                   reserved;
        posix_thread_t*         thread;

        signal                  = &_posix_signal_table[signo];

        if (    sev->sigev_notify == SIGEV_NONE )
        {
                /* to implement: SIGEV_THREAD */
                return true;
        }

        /* SIGEV_THREAD */
        if ( sev->sigev_notify == SIGEV_THREAD )
        {
                posix_thread_ready(     
                        (posix_thread_t*)sev->sigev_notify_attributes, 
                        POSIX_WAKE_SIGNAL );

                return true;
        }

        
        /* SIGEV_SIGNAL */
        
        if (code==SI_TIMER)
        {
                reserved  = data;
                thread = (posix_thread_t*)NULL;
        }
        else
        {
                thread = (posix_thread_t*)data;
                reserved  = NULL;
        }
        
        pthread_mutex_lock(&_posix_signals_mutex);

        if (signal->sa.sa_flags & SA_SIGINFO)
        {
                /* queueable signal */
                if (! posix_queue_signal(signal,sev,code,reserved))
                {
                        pthread_mutex_unlock(&_posix_signals_mutex);
                        return false;   
                }
        }

        if (thread != NULL)
        {
                /* Signals generated for a specific thread, 
                 * using the pthread_kill or the raise subroutines, 
                 * are delivered to that thread. 
                 * If the thread has blocked the signal from delivery, 
                 * the signal is set pending on the thread until the signal
                 * is unblocked from delivery. 
                 * If the thread is terminated before the signal delivery,
                 * the signal will be ignored.
                 */
                sigaddset(&thread->sigpending,signo);
                
                if ( thread != self )
                {
                        if ( thread->sigpending & thread->sigwait )
                        {
                                /* thread in sigwait */
                                posix_qthread_rm( 
                                        thread,
                                        &_posix_signals_cond.queue );

                                posix_thread_ready(thread,POSIX_WAKE_SIGNAL);
                        }
                        else if (thread->sigpending & ~thread->sigmask ) 
                        {
                                /* thread handles signal asynchronously */
                                thread->asrpending = 1;
                                posix_thread_ready(thread,POSIX_WAKE_SIGNAL);
                        }
                }
        }
        else
        {
                /* signal to process */
                sigaddset(&_posix_sig_pending, signo);
                
                /* For sigwait to work reliably, the signals being waited for 
                 * must be blocked in all threads, not only in the calling thread,
                 * since otherwise the POSIX semantics for signal delivery do not
                 * guarantee that it's the thread doing the sigwait that will 
                 * receive the signal. 
                 * The best way to achieve this is block those signals before 
                 * any threads are created, and never unblock them in the program
                 * other than by calling sigwait.*/
                
                /* Signals generated for the process shall be delivered
                 * to exactly one of those threads within the process 
                 * which is in a call to a sigwait() function selecting 
                 * that signal or alternatively to a thread that has not blocked 
                 * delivery of the signal.
                 * If there are no threads in a call to a sigwait() function
                 * selecting that signal, and if all threads within the process
                 * block delivery of the signal, the signal shall remain pending
                 * on the process until:
                 * - a thread calls a sigwait() function selecting that signal
                 * - a thread unblocks delivery of the signal
                 * - the action associated with the signal is set to
                 *   "ignore" the signal. 
                 */
                
                if (posix_cond_thread_sigmask(  &_posix_signals_cond,
                                                &_posix_sig_pending) )
                {
                        /* we have at least one thread waiting on sigwait 
                         * for a pending signal */
                        pthread_cond_broadcast(&_posix_signals_cond);
                }
                else 
                {
                        /*  look for a thread (other than the caller) 
                         *  which is not blocking delivery of the signal */
                        posix_thread_signal(&_posix_sig_pending);
                }
        }
        
        pthread_mutex_unlock(&_posix_signals_mutex);
        
        return true;
}

/* signals delivery */

/* delivery point of signals for running thread */
void    posix_deliver_signals(void)
{
        pthread_mutex_lock(&_posix_signals_mutex);
        
        if (posix_deliver_signal_point() == true)
        {
                posix_try_deliver_signal();
        }

        pthread_mutex_unlock(&_posix_signals_mutex);
        return;
}

/* mutex '_signals_cond' must have been locked by caller */
bool    posix_deliver_signal_point(void)
{
        posix_thread_t* self    = posix_self_thread();
        if ( (_posix_sig_pending == 0 && self->sigpending == 0)         ||
             ( ((_posix_sig_pending | self->sigpending) & ~self->sigmask)==0)   
           )
        {
                return false;
        }
        return true;
}

/* mutex '_posix_signals_cond' must have been locked by caller */
void    posix_try_deliver_signal(void)
{
        int             signo;
        posix_signal_t* signal;

        sigset_t        sigtodo;
        sigset_t        sigmask;
        sigset_t        oldmask;
        siginfo_t       siginfo;

        void                    (*oldaction)(int);
        bool                    siginfoflag;
        sa_siginfoaction_t      sigaction;
        
        posix_thread_t* self    = posix_self_thread();
        void*           data    = NULL;
                
        /* need to loop until work is done, in signal catchers
         * new signals could be raised or unblocked */
        while ( 
            (sigtodo = ((_posix_sig_pending | self->sigpending) & ~self->sigmask))
            !=0
        )
        {
                /* priority given to low numbered signals: 
                 * - true for RT signals
                 * - undefined for the rest */
                signo   = pal_lsbit64_index(sigtodo);
                signal  = &_posix_signal_table[signo];
                sigmask = 1LL<<signo;
                
                /* dequeue signal with information in siginfo */
                if ( !posix_dequeue_signal(signal,&siginfo,&data) )
                {
                        siginfo.si_signo                = signo;
                        siginfo.si_code                 = SI_USER;
                        siginfo.si_value.sival_int      = 0;
                }
#               if ( __POSIX_TIMERS != 0 )
                if ( siginfo.si_code==SI_TIMER && data != NULL )
                {
                        ((posix_timer_t*)data)->pending = 0;            
                }
#               endif
                if (signal->sa.sa_handler != SIG_IGN)
                {
                        oldmask = self->sigmask;
        
                        /* not pending anymore: next threads wont catch this
                         * signal if not in their sigpending field */
                        if (signal->pending == NULL)
                        {
                                _posix_sig_pending &= ~sigmask;
                                self->sigpending &= ~sigmask;
                        }
                        
                        oldaction = signal->sa.sa_handler;
                        siginfoflag = signal->sa.sa_flags & SA_SIGINFO;
                        
                        if (signal->sa.sa_flags & SA_RESETHAND)
                        {
                                signal->sa.sa_handler = SIG_DFL;
                                signal->sa.sa_flags &= ~SA_SIGINFO;
                        }
                        
                        if ( signal->sa.sa_flags & SA_NODEFER   ||
                             signal->sa.sa_flags & SA_RESETHAND   )
                        {
                                self->sigmask = oldmask | signal->sa.sa_mask;
                        }
                        else
                        {
                                self->sigmask = oldmask | sigmask | signal->sa.sa_mask;
                        }

                        /* signal catcher */

                        if (oldaction == SIG_DFL)
                        {
                                /* default behavior: abnormal termination */
                                exit(-signo);
                        }
                        
                        pthread_mutex_unlock(&_posix_signals_mutex);
                        
                        if ( siginfoflag )
                        {
                                sigaction = (sa_siginfoaction_t)oldaction;
                                (*sigaction)(signo,&siginfo,NULL);
                        }
                        else
                        {
                                (*oldaction)(signo);
                        }
                        
                        pthread_mutex_lock(&_posix_signals_mutex);
                        
                        /* restore old values for next signal */
                        self->sigmask = oldmask;
                        signal->sa.sa_handler = oldaction;
                        if (siginfoflag)
                        {
                                signal->sa.sa_flags |= SA_SIGINFO;
                        }
                }
                else
                {
                        /* this signal is pending: clear it */
                        _posix_sig_pending &= ~sigmask;
                        self->sigpending &= ~sigmask;
                        /* dequeue all other pending values for signal */
                        posix_free_signal(signal);                      
                }
        }
        
        return;
}

void posix_thread_signal(sigset_t* mask)
{
        posix_thread_t* self = posix_self_thread();
        posix_thread_t* thread;
        int i;

        posix_scheduler_lock();

        for (i=_MAIN_THREAD_ID; i<PTHREAD_THREADS_MAX;i++)
        {
                thread = _posix_thread_table[i];

                if (    thread != NULL                  &&
                        self != thread                  &&
                        (*mask & ~thread->sigmask)              
                )               
                {
                        thread->asrpending = 1;
                        posix_thread_ready(thread,POSIX_WAKE_SIGNAL);
                        break;
                }
        }
        
        posix_scheduler_unlock();

        return;
}

#endif /* __POSIX_SIGNALS */


