/******************************************************************************
 * FILE:        @(#)posix_pthread.h     1.24 07/06/06
 * DESCRIPTION:
 *      internal pthread implementation interface
 *****************************************************************************/
#ifndef _H_POSIX_PTHREAD
#define _H_POSIX_PTHREAD

#include <pthread.h>
#include <limits.h>
#include <stdbool.h>
#include <sys/types.h>
#include "posix_types.h"
#include "posix_threads_cfg.h"

/* invalid values */
#define PTHREAD_INVALID_ID              (pthread_t)-1
#define PTHREAD_KEY_INVALID_ID          (pthread_key_t)-1

/* joinstate values */
#define PTHREAD_JOINSTATE_DETACH        0
#define PTHREAD_JOINSTATE_FREE          1
#define PTHREAD_JOINSTATE_BUSY          2
#define PTHREAD_JOINSTATE_JOIN          3
#define PTHREAD_JOINSTATE_EXIT          4

/* wakeup reasons */
#define POSIX_WAKE_WAIT_MUTEX           1
#define POSIX_WAKE_WAIT_MQ              2
#define POSIX_WAKE_WAIT_COND            3
#define POSIX_WAKE_TIMEOUT              4
#define POSIX_WAKE_SIGNAL               5
#define POSIX_WAKE_TIMEDINTR            6
#define POSIX_WAKE_SIGIO                7
#define POSIX_WAKE_CANCEL               8
#define POSIX_WAKE_NONE                 9

struct thread_t
{
        /* kernel stuff */
        void                    *sp;
        uint32_t                priority:16,
                                schedpolicy:2,
                                asrpending:1,
                                state:2;
        uint32_t                sched_lock:16,
                                rc:16;
        uint32_t                timeslice;
        void                    *retval;
        void                    *(*start_routine)(void *);
        void                    *start_arg;
        size_t                  stacksize;
        void                    *stackaddr;
        void                    (*asrhandler)(void *);
        /* posix stuff */
        pthread_t               thread_id;
        posix_thread_t          *rq_queue;   /* for use in ready queue */
        posix_thread_t          *tq_queue;   /* for use in posix_threadqueue_t (condition/mutex) */
        pthread_mutex_t         *mutex;

        uint32_t                scope:2,
                                cancelstate:2,
                                canceltype:2,
                                cancelpending:1,
                                freestack:1,
                                intr_notify:1,
                                intr_wait:1,
                                inasrhandler:1,
                                osmutex:1,
                                preinherit:16;

        uint32_t                wake_reason:8,
                                joins:8,
                                joinstate:4;
#if     (__POSIX_SIGNALS != 0)
        sigset_t                sigmask;
        sigset_t                sigpending;
        sigset_t                sigwait;
#endif
        struct pthread_cleanup_buffer   *cancelbuffer;
        void                    **thread_data;
        pthread_cond_t          joincond;
#if ( __POSIX_THREAD_CPUTIME != 0 )
        posix_clock_t           clock;
        clock_t                 btime;
#endif
        struct sched_param      schedparam;
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        struct timespec         budget;
        /* activation time, to be used for calculating time for next replemishment */
        struct timespec         activation_time;
        /* time thread started, used for calculationg time used of budget */
        clock_t                 start_of_run_time;
        /* time thread executed since activation time */
        clock_t                 execution_time;
        int32_t                 next_repl:8,    /* index in array for next replenishment */
                                last_repl:8;    /* next free element in array */
        /* pointer to array of timers used for replenishments */
        timer_t                 *repl;
        /* timer for end of budget */
        timer_t                 end_of_budget;
#endif
#if (POSIX_THREADS_DEBUG != 0)
        uint32_t                ra;
        uint32_t                spuser;
        uint32_t                restores;
#endif
#if (__POSIX_THREAD_ATTR_NAME != 0)
        char                    name[POSIX_THREADS_THREAD_NAME_MAX];
#endif
#if (POSIX_THREADS_ERRNO != 0)
        int                     errno;
#endif
};

typedef struct posix_key_info_t
{
        bool    alloc;
        void    (*destructor)(void *);
} posix_key_info_t;

extern posix_thread_t   *_posix_thread_table[];
extern posix_key_info_t _posix_key_table[];
extern pthread_mutex_t  _posix_threads_mutex;

extern  int             _posix_pthread_no_active;
extern  int             _posix_pthread_no_exited;
extern  int             _posix_pthread_no_joined;
extern  pthread_t       _posix_pthread_next;

extern  int             posix_free_pthread_failed_init(pthread_t id);
extern  pthread_t       posix_alloc_pthread(posix_thread_t *);
extern  void            posix_free_pthread(void);
inline  bool            posix_valid_pthread(pthread_t th) {
        return (_posix_thread_table[th] != (posix_thread_t *)NULL);
}
inline posix_thread_t *posix_get_thread(pthread_t th) {
        return _posix_thread_table[th];
}

extern void             posix_pthreads_init(void);

extern bool             posix_alloc_key( void (*destructor)(void *), 
                                         pthread_key_t *);
extern bool             posix_free_key(pthread_key_t);
extern bool             posix_valid_key(pthread_key_t key);
extern void             posix_qthread_add( posix_thread_t *, 
                                           posix_threadqueue_t *,
                                           bool);
extern bool             posix_qthread_rm(  posix_thread_t *, 
                                           posix_threadqueue_t *);
extern posix_thread_t   *posix_qthread_rm_front(posix_threadqueue_t *);

inline bool             posix_qthread_empty(posix_threadqueue_t *q) {
        return (q->head == (posix_thread_t *)NULL);
}

inline posix_thread_t   *posix_qthread_front(posix_threadqueue_t *q) {
        return q->head;
}

#if     (__POSIX_SIGNALS != 0)
extern bool             posix_cond_thread_sigmask( pthread_cond_t *,
                                                   sigset_t *);
#endif

extern int              __pthread_cond_timedwait( pthread_cond_t *,
                                                  pthread_mutex_t *,
                                                  clock_t);

extern int              __pthread_mutex_timedlock( pthread_mutex_t *, 
                                                   clock_t,
                                                   int);

/* helpers to initialize rtos objects */
extern void             posix_mutex_init(pthread_mutex_t *);
extern void             posix_pthread_init(posix_thread_t *);
extern void             posix_cond_init(pthread_cond_t *);

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
extern pthread_key_t    _posix_sporadic_cleanup_key;
extern void             posix_sporadic_cleanup_function(void*);
#endif /* __POSIX_THREAD_SPORADIC_SERVER */

/* initializationf daemon threads: main hook */
extern void posix_daemon_threads(void);


#endif


