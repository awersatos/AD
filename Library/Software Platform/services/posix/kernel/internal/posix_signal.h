/******************************************************************************
 * FILE:        @(#)posix_signal.h      1.7 07/02/21
 * DESCRIPTION:
 *      signal posix internal interface
 *****************************************************************************/
#ifndef _H_POSIX_SIGNAL
#define _H_POSIX_SIGNAL

#include <pthread.h>
#include <signal.h>
#include <stdbool.h>
#include "posix_pthread.h"

#if ( __POSIX_SIGNALS != 0 )

/* information for SA_SIGINFO queued signals */
typedef struct posix_siginfo_t
{
        struct posix_siginfo_t  *next;  
        siginfo_t               siginfo;
        void*                   reserved;
} posix_siginfo_t;

/* a signal: 
 * - signal's actions (sigaction)
 * - information of first queued pending signal (when applicable) */
typedef struct posix_signal_t
{
        struct sigaction        sa;
        posix_siginfo_t         *pending; 
} posix_signal_t ;

/* array of signals */
extern posix_signal_t   _posix_signal_table[];

/* mutex protects signal critical code */
extern pthread_mutex_t  _posix_signals_mutex;
/* condition variable for all threads waiting in sigsuspend()
 * and sigwait() */
extern pthread_cond_t   _posix_signals_cond;
/* masks with global pending signals */
extern sigset_t         _posix_sig_pending;

/* alarm() is armed */
extern bool             _posix_sigalarm_armed;

/* signals initialization */
extern void     posix_signal_init(void);

/* signal generation:
 * - SI_USER/SI_QUEUE:  data is _thread_t* (to a thread) 
 *                      or NULL (to a process)
 * - SI_TIMER:          data contains _timer_t* 
 */
extern bool     posix_generate_signal(const struct sigevent *sev, int code,
                       void* data);

/* delivery point of signals for running thread */
extern void     posix_deliver_signals(void);
/* are there reasons to deliver a signal */
extern  bool    posix_deliver_signal_point(void);
/* running thread delivers signals */
extern void     posix_try_deliver_signal(void);

/*  look for a thread (other than the caller) 
 *  which is not blocking delivery of the signal */ 
extern void     posix_thread_signal(sigset_t*);

/* allocate a _siginfo_t object with the signal information */
extern bool     posix_queue_signal(posix_signal_t*, 
                        const struct sigevent*, int ,void*);

/* dequeue signal with information in siginfo */
extern bool     posix_dequeue_signal(posix_signal_t*,siginfo_t*,void**);

/* free all pending actions of a signal */
extern void     posix_free_signal(posix_signal_t*);


#endif /*  __POSIX_SIGNALS != 0 */

#endif /* _H_POSIX_SIGNAL */


