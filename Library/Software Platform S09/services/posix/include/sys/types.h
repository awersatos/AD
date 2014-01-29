/******************************************************************************
 * FILE:        %W% %E%
 * DESCRIPTION:
 *      posix 'types.h' interface
 *****************************************************************************/
#ifndef _TYPES_H
#define _TYPES_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>
#include <limits.h>

#ifndef _OFF_T_DEF
typedef long            off_t;
#define _OFF_T_DEF
#endif

#ifndef _SIZE_T_DEF
typedef __size_t        size_t;
#define _SIZE_T_DEF
#endif

#ifndef _SSIZE_T_DEF
typedef __ssize_t       ssize_t;
#define _SSIZE_T_DEF
#endif

typedef unsigned short gid_t;
typedef unsigned short uid_t;
typedef int pid_t;

typedef signed long     time_t;
typedef int timer_t;

typedef signed long     suseconds_t;

/* better off in '_pthread_internal.h' */
#define _ATTR_INIT_KEY  (uint32_t)0x5AA56BB6

typedef struct thread_t posix_thread_t;

typedef struct  posix_threadqueue_t
{
        posix_thread_t*         head;
        posix_thread_t*         tail;
}       posix_threadqueue_t;

struct pthread_cleanup_buffer
{
        struct pthread_cleanup_buffer *prev;
        void (*routine) (void *);
        void *arg;
};

/* Strictly this should be in <time.h>, but the requirement
 * for struct sched_param to contain a struct timespec object means
 * that it must be here */
/* The time interval described by this structure is
 * (tv_sec * 10^9 + tv_nsec) nanoseconds */
struct timespec {
        /* time value in seconds */
        time_t          tv_sec;
        /* and nanoseconds (0,1000million) */
        long            tv_nsec;
};


/* Strictly this should be in <sched.h>, but the requirement
 * for pthread_attr_t to contain a sched_param object means
 * that it must be here */
struct sched_param
{
        int             sched_priority;
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        /* Low scheduling priority for sporadic server */
        int             sched_ss_low_priority;
        /* Replenishment period for sporadic server */
        struct timespec sched_ss_repl_period;
        /* Initial budget for sporadic server */
        struct timespec sched_ss_init_budget;
        /* Maximum pending replenishments for sporadic server */
        int             sched_ss_max_repl;
#endif
};

typedef struct pthread_attr_t
{
        size_t                  stacksize;
        void                    *stackaddr;
#if (__XSI_THREAD_EXIT != 0)
        size_t                  guardsize;
#endif
        struct sched_param      schedparam;

        uint16_t                detachstate:2,
                                scope:2,
                                inheritsched:2,
                                schedpolicy:2;
        uint32_t                init;
} pthread_attr_t;

typedef int pthread_t;

typedef int pthread_key_t;

typedef int pthread_once_t;

typedef struct pthread_mutexattr_t
{
        uint32_t        type : 4,
#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
                        prioceiling:16,
#endif
                        protocol : 4;
        int32_t         init;
} pthread_mutexattr_t;


#if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
#define PTHREAD_MUTEX_PROTOCOL          PTHREAD_PRIO_INHERIT
#elif ( __POSIX_THREAD_PRIO_PROTECT != 0 )
#define PTHREAD_MUTEX_PROTOCOL          PTHREAD_PRIO_PROTECT
#else
#define PTHREAD_MUTEX_PROTOCOL          PTHREAD_PRIO_NONE
#endif

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
#define PTHREAD_MUTEX_PRIOCEILING               0,
#else
#define PTHREAD_MUTEX_PRIOCEILING               
#endif

#if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
#define PTHREAD_MUTEX_INHERIT                   -1,
#else
#define PTHREAD_MUTEX_INHERIT           
#endif

#define PTHREAD_MUTEX_INITIALIZER       {                               \
                PTHREAD_MUTEX_DEFAULT,                                  \
                PTHREAD_MUTEX_PROTOCOL,                                 \
                PTHREAD_MUTEX_PRIOCEILING                               \
                0,                                                      \
                PTHREAD_MUTEX_INHERIT                                   \
                0,                                                      \
                _ATTR_INIT_KEY,                                         \
                (void*)0,                                               \
                (pthread_mutex_t *)0,                                   \
                (pthread_mutex_t *)0,                                   \
                { (void*)0, (void*)0},                                  \
                }

typedef struct _pthread_mutex_t pthread_mutex_t;

struct _pthread_mutex_t
{
        uint32_t                type: 2,
                                protocol: 2,
#                               if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
                                prioceiling:16,
#                               endif
                                recursive:8;
        int32_t                 
#                               if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
                                inherit: 16,
#                               endif
                                preprio: 16;

        int32_t                 initi;
        posix_thread_t*         owner;
        pthread_mutex_t *       nestup;
        pthread_mutex_t *       nestdown;
        posix_threadqueue_t     queue;
} ;

typedef int clockid_t;

typedef struct pthread_condattr_t
{
        uint32_t        init;
        clockid_t       clock_id;
} pthread_condattr_t;

#define PTHREAD_COND_INITIALIZER { _ATTR_INIT_KEY, CLOCK_REALTIME, { (void*)0, (void*)0}, }

typedef struct pthread_cond_t
{
        int32_t                 initi;
        uint32_t                clock_id:2;
        posix_threadqueue_t     queue;

} pthread_cond_t;


typedef unsigned short  mode_t;
typedef void*   mqd_t;

typedef unsigned long   blkcnt_t;
typedef unsigned long   blksize_t;
typedef unsigned short  dev_t;
typedef unsigned short  ino_t;
typedef unsigned short  nlink_t;

#define NODEV           ULONG_MAX
#define makedev(x,y)    ((dev_t)(((x)<<8) | (y)))       /* create dev_t */

#ifdef  __cplusplus
}
#endif

#endif
