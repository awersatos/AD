/******************************************************************************
 * FILE:        @(#)pthread.h   1.8 06/07/11
 * DESCRIPTION:
 *      posix threads interface
 *****************************************************************************/
#ifndef _PTHREAD_H
#define _PTHREAD_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <limits.h>
#include <sched.h>
#include <sys/types.h>
#include <time.h>

/* pthread_attr_t: detachstate  */
#define PTHREAD_CREATE_JOINABLE         1
#define PTHREAD_CREATE_DETACHED         2

/* pthread_attr_t: inheritsched  */
#define PTHREAD_INHERIT_SCHED           1
#define PTHREAD_EXPLICIT_SCHED          2 

/* pthread_attr_t: contentionscope */
#define PTHREAD_SCOPE_SYSTEM            1
#define PTHREAD_SCOPE_PROCESS           2

extern int pthread_create ( pthread_t *thread,
                             const pthread_attr_t *attr,
                             void *(*start_routine) (void *),
                             void *arg);
extern pthread_t pthread_self ( void );
extern int pthread_equal (pthread_t thread1, pthread_t thread2);
extern void pthread_exit (void *retval);
extern int pthread_join (pthread_t thread, void **thread_return);
extern int pthread_detach (pthread_t thread);

extern int pthread_attr_init (pthread_attr_t *attr);
extern int pthread_attr_destroy (pthread_attr_t *attr);
extern int pthread_attr_setdetachstate (pthread_attr_t *attr,
                                         int detachstate);
extern int pthread_attr_getdetachstate (const pthread_attr_t *attr,
                                         int *detachstate);
extern int pthread_attr_setschedparam (pthread_attr_t *attr,
                                        const struct sched_param *param);
extern int pthread_attr_getschedparam (const pthread_attr_t *attr,
                                        struct sched_param *param);

/* _POSIX_THREAD_PRIORITY_SCHEDULING */
extern int pthread_attr_setscope (pthread_attr_t *attr, int scope);
extern int pthread_attr_getscope (const pthread_attr_t *attr, int *scope);
extern int pthread_attr_setinheritsched (pthread_attr_t *attr, int inherit);
extern int pthread_attr_getinheritsched (const pthread_attr_t *attr,
                                          int *inherit);
extern int pthread_attr_setschedpolicy (pthread_attr_t *attr, int policy);
extern int pthread_attr_getschedpolicy (const pthread_attr_t *attr,
                                         int *policy);
extern int pthread_setschedprio(pthread_t thread, int prio);

#if ( __POSIX_THREAD_ATTR_STACKADDR != 0 )
extern int pthread_attr_setstackaddr (pthread_attr_t *attr, void *stackaddr);
extern int pthread_attr_getstackaddr (const pthread_attr_t *attr,
                                       void **stackaddr);
#endif

#if (__POSIX_THREAD_ATTR_STACKSIZE != 0 )
extern int pthread_attr_setstacksize (pthread_attr_t *attr,
                                       size_t stacksize);
extern int pthread_attr_getstacksize (const pthread_attr_t *attr,
                                       size_t *stacksize);
#endif

#if (__XSI_THREAD_EXIT != 0)
extern int pthread_attr_getguardsize (const pthread_attr_t *attr, 
                size_t *guardsize);
extern int pthread_attr_setguardsize (pthread_attr_t *attr,
                size_t guardsize);
extern int pthread_attr_setstack (pthread_attr_t *attr, 
                void *stackaddr, size_t stacksize);
extern int pthread_attr_getstack (const pthread_attr_t *attr,
                void **stackaddr, size_t *stacksize);
extern int pthread_getconcurrency (void);
extern int pthread_setconcurrency (int level);
#endif

/* scheduling */

extern int pthread_setschedparam (pthread_t thread,
                                   int policy,
                                   const struct sched_param *param);
extern int pthread_getschedparam (pthread_t thread,
                                   int *policy,
                                   struct sched_param *param);

#define PTHREAD_ONCE_INIT       1
/*  Dynamic package initialization */
extern int pthread_once (pthread_once_t *once_control,
                          void (*init_routine) (void));

/* specific and key */

extern int pthread_key_create (pthread_key_t *key,
                                void (*destructor) (void *));
extern int pthread_key_delete (pthread_key_t key);
extern int pthread_setspecific (pthread_key_t key, const void *pointer);
extern void *pthread_getspecific (pthread_key_t key);

/* cancelation */

/* cancel state */
#define PTHREAD_CANCEL_ENABLE           1
#define PTHREAD_CANCEL_DISABLE          2
/* cancel type */
#define PTHREAD_CANCEL_DEFERRED         1
#define PTHREAD_CANCEL_ASYNCHRONOUS     2

extern int pthread_canceled_dummy_var;
#define PTHREAD_CANCELED                ((void *)(&pthread_canceled_dummy_var))


extern int pthread_setcancelstate (int state, int *oldstate);
extern int pthread_setcanceltype (int type, int *oldtype);
extern int pthread_cancel (pthread_t thread);
extern void pthread_testcancel (void);

extern void __pthread_cleanup_push(struct pthread_cleanup_buffer*,
                void (*routine) (void *), void *arg);

#define pthread_cleanup_push(routine,arg)                       \
    {                                                           \
        struct pthread_cleanup_buffer _buffer_;                 \
        __pthread_cleanup_push(&_buffer_, (routine), (arg));    
            
extern void __pthread_cleanup_pop(
                struct pthread_cleanup_buffer*, int execute);

#define pthread_cleanup_pop(execute)                            \
        __pthread_cleanup_pop(&_buffer_, (execute));            \
    }

#if ( __POSIX_THREAD_CPUTIME != 0 )
extern int pthread_getcpuclockid(pthread_t thread_id, clockid_t *clock_id);
#endif

/* mutex */

/* pthread_mutexattr_t: type */
#define PTHREAD_MUTEX_NORMAL            1 
#define PTHREAD_MUTEX_RECURSIVE         2 
#define PTHREAD_MUTEX_ERRORCHECK        3
#define PTHREAD_MUTEX_DEFAULT           PTHREAD_MUTEX_NORMAL    

/*  pthread_mutexattr_t: protocol */
#define PTHREAD_PRIO_NONE               1
#define PTHREAD_PRIO_INHERIT            2
#define PTHREAD_PRIO_PROTECT            3

/* pthread_mutexattr_t, pthread_condattr_t: pshared */
#define PTHREAD_PROCESS_SHARED          1
#define PTHREAD_PROCESS_PRIVATE         2

extern int pthread_mutex_init (pthread_mutex_t *mutex,
                                const pthread_mutexattr_t *mutex_attr);
extern int pthread_mutex_destroy (pthread_mutex_t *mutex);
extern int pthread_mutex_lock (pthread_mutex_t *mutex);

#if ( __POSIX_TIMEOUTS != 0 )
extern int pthread_mutex_timedlock(pthread_mutex_t * mutex,
       const struct timespec * abs_timeout);
#endif

extern int pthread_mutex_trylock (pthread_mutex_t *mutex);
extern int pthread_mutex_unlock (pthread_mutex_t *mutex);

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
extern int pthread_mutex_setprioceiling( pthread_mutex_t *mutex,
                                          int prioceiling,
                                          int *old_ceiling);
extern int pthread_mutex_getprioceiling( const pthread_mutex_t *mutex,
                                          int *prioceiling);
#endif

extern int pthread_mutexattr_init ( pthread_mutexattr_t *attr);
extern int pthread_mutexattr_destroy ( pthread_mutexattr_t *attr);

#if ( (__POSIX_THREAD_PRIO_INHERIT != 0) || (__POSIX_THREAD_PRIO_PROTECT != 0) )
extern int pthread_mutexattr_setprotocol ( pthread_mutexattr_t *attr,
                                            int protocol);
extern int pthread_mutexattr_getprotocol ( const pthread_mutexattr_t *attr,
                                            int *protocol);
#endif
        
#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
extern int pthread_mutexattr_setprioceiling ( pthread_mutexattr_t *attr,
        int prioceiling);
extern int pthread_mutexattr_getprioceiling ( const pthread_mutexattr_t *attr,
                                               int *prioceiling);
#endif

#if (__XSI_THREAD_MUTEX_EXT!=0)
extern int pthread_mutexattr_gettype(const pthread_mutexattr_t * attr,int *type);
extern int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int type);
#endif

/* condition variables */
extern int pthread_cond_init (pthread_cond_t *cond,
                               const pthread_condattr_t *attr);
extern int pthread_cond_destroy (pthread_cond_t *cond);
extern int pthread_cond_signal (pthread_cond_t *cond);
extern int pthread_cond_broadcast (pthread_cond_t *cond);
extern int pthread_cond_wait (pthread_cond_t *cond,
                               pthread_mutex_t *mutex);
#if ( __POSIX_TIMEOUTS != 0 )
extern int pthread_cond_timedwait (pthread_cond_t *cond,
                                    pthread_mutex_t *mutex,
                                    const struct timespec *abstime);
#endif

extern int pthread_condattr_init (pthread_condattr_t *attr);
extern int pthread_condattr_destroy (pthread_condattr_t *attr);
extern int pthread_condattr_getclock(const pthread_condattr_t *attr,
                                        clockid_t *clock_id);
extern int pthread_condattr_setclock(pthread_condattr_t *attr,
                                        clockid_t clock_id);

#if ( __POSIX_THREAD_CPUTIME != 0)
extern int   pthread_getcpuclockid(pthread_t, clockid_t *);
#endif


#ifdef  __cplusplus
}
#endif

#endif /* _H_PTHREAD */ 
