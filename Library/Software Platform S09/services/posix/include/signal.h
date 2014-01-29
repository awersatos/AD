/******************************************************************************
 * FILE:        @(#)signal.h    1.11 06/10/02
 * DESCRIPTION:
 *      signals posix interface
 *****************************************************************************/
#ifndef _SIGNAL_H
#define _SIGNAL_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <limits.h>
#include <sys/types.h>
#include <pal_arch.h>

/* supported signals */
#define SIGNULL         0               /* reserved                                     */
#define SIGABRT         1               /* abort()                                      */
#define SIGALRM         2               /* alarm clock                                  */
#define SIGBUS          3               /* bus error                                    */
#define SIGCHLD         4               /* child process terminated */
#define SIGCONT         5               /* continue a stopped process                   */
#define SIGFPE          6               /* floating point exception                     */
#define SIGHUP          7               /* hangup                                       */
#define SIGILL          8               /* illegal instruction                          */
#define SIGINT          9               /* interrupt                                    */
#define SIGKILL         10              /* kill (cannot be caught or ignored)           */
#define SIGPIPE         11              /* write on a pipe with no one to read it       */
#define SIGQUIT         12              /* quit                                         */
#define SIGSEGV         13              /* segmentation violation                       */
#define SIGSTOP         14              /* sendable stop signal not from tty            */
#define SIGTERM         15              /* Termination Signal                           */
#define SIGTSTP         16              /* Terminal stop signal */
#define SIGTTIN         17              /* Background process read */
#define SIGTTOU         18              /* Background process write */
#define SIGUSR1         19              /* user defined signal 1 */
#define SIGUSR2         20              /* user defined signal 2 */
#define SIGPOLL         21              /* Pollable event */
#define SIGPROF         22              /* Profiling timer expired */
#define SIGSYS          23              /* Bad system call */
#define SIGTRAP         24              /* trace trap */
#define SIGURG          25              /* high bandwith data */
#define SIGVTALRM       26              /* virtual timer expired  */
#define SIGXCPU         27              /* cpu time limit exceeded */ 
#define SIGXFSZ         28              /* file size limit exceeded */ 
#define SIGKRNL1        29              /* kernel reserved 1 */
#define SIGKRNL2        30              /* kernel reserved 2 */
#define SIGKRNL3        31              /* kernel reserved 3 */
#define SIGRTMIN        32              /* minimum value for the RT signals */
#define SIGRTMAX        63              /* maximum value for the RT signals */

#define VALID_SIGNAL(_sig_) ( (_sig_> 0) && (_sig_ <(sizeof(sigset_t)*8) ) )

#define SIG_DFL         (void (*)(int))1
#define SIG_IGN         (void (*)(int))2
#define SIG_ERR         (void (*)(int))3
#define SIG_HOLD        (void (*)(int))4

#define SIGTIMEDINTR    SIGKRNL2

typedef pal_arch_atomic_t sig_atomic_t;

typedef uint64_t         sigset_t;

union sigval
{
        int     sival_int;
        void    *sival_ptr;
};

struct sigevent {
        
        #define SIGEV_NONE              0
        #define SIGEV_SIGNAL            1 
        #define SIGEV_THREAD            2 
        int                             sigev_notify;
        
        int                             sigev_signo;
        union sigval                    sigev_value;

        void                            (*sigev_notify_function) (union sigval);
        pthread_attr_t                  *sigev_notify_attributes;
        
};


typedef struct
{
        int                     si_signo;
        /*      Values for si_code */
        # define SI_USER        1
        # define SI_QUEUE       2
        # define SI_TIMER       3
        # define SI_ASYNCIO     4
        # define SI_MESGQ       5
        # define SI_EXCEPT      6       
        int                     si_code;
        union sigval            si_value;
} siginfo_t;


typedef void (*sa_sighandler_t)(int);
typedef void (*sa_siginfoaction_t)(int, siginfo_t *,void *);

struct  sigaction {
        sigset_t                sa_mask;
        #define SA_NOCLDSTOP    (1<<0)   
        #define SA_ONSTACK      (1<<1)
        #define SA_RESETHAND    (1<<2)   
        #define SA_RESTART      (1<<3)   
        #define SA_SIGINFO      (1<<4)  
        #define SA_NOCLDWAIT    (1<<5)
        #define SA_NODEFER      (1<<6)
        int                     sa_flags;       
        union {
                sa_sighandler_t         handler;
                sa_siginfoaction_t      sigaction;
        } sigaction;
#define sa_handler      sigaction.handler
#define sa_sigaction    sigaction.sigaction
};

/* Values for the how arguments: */
#define SIG_BLOCK       1
#define SIG_UNBLOCK     2
#define SIG_SETMASK     3

#include <time.h>

#if ( (__POSIX_KERNEL__>0) && (__POSIX_SIGNALS != 0) )

extern int kill (pid_t pid, int sig);
extern int pthread_kill (pthread_t thread, int sig);
extern int sigaction  (int sig, const struct sigaction *act,
                struct sigaction *oact);
extern int sigprocmask  (int how, const sigset_t *set, sigset_t *oset);
extern int pthread_sigmask (int how, const sigset_t *set, sigset_t *oset);
extern int sigpending  (sigset_t *set);
extern int sigsuspend(const sigset_t *sigmask);
extern int sigwait  (const sigset_t *set, int *sig);

#if ( (__POSIX_KERNEL__>0) && (__POSIX_REALTIME_SIGNALS != 0) )
extern int sigqueue  (pid_t pid, int sig, const union sigval value);
extern int sigwaitinfo  (const sigset_t *set, siginfo_t *info);
extern int sigtimedwait  (const sigset_t *set, siginfo_t *info, 
                const struct timespec *timeout);
#endif

extern int sigemptyset  (sigset_t *set);
extern int sigfillset  (sigset_t *set);
extern int sigaddset  (sigset_t *set, int signo);
extern int sigdelset  (sigset_t *set, int signo);
extern int sigismember  (const sigset_t *set, int signo);

extern unsigned int     alarm( unsigned int seconds );
extern int              pause( void );
extern unsigned int     sleep( unsigned int seconds );
extern void             abort(void);
extern int              raise(int sig);
extern void             (*signal(int sig, void (*func)(int)))(int);

#endif /* __POSIX_SIGNALS */

#ifdef  __cplusplus
}
#endif

#endif /* _H_SIGNAL */
