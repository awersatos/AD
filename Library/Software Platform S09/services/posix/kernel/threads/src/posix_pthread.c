/******************************************************************************
 * FILE:        @(#)posix_pthread.c     1.40 07/06/06
 * DESCRIPTION:
 *      posix internal pthread implementation
 *****************************************************************************/
#include <errno.h>
#include <stdlib.h>
#include <limits.h>
#include <init.h>
#include "posix_main.h"
#include "kernel.h"
#include "posix_pthread.h"
#include "posix_asr.h"
#include "posix_time.h"
#include "k_schedule.h"
#include "k_readyqueue.h"

posix_thread_t*     _posix_thread_table[PTHREAD_THREADS_MAX];
posix_key_info_t    _posix_key_table[PTHREAD_KEYS_MAX];

int             _posix_pthread_no_active;
int             _posix_pthread_no_exited;
int             _posix_pthread_no_joined;
pthread_t       _posix_pthread_next = 0;

pthread_mutex_t _posix_threads_mutex    = PTHREAD_MUTEX_INITIALIZER;

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
pthread_key_t   _posix_sporadic_cleanup_key     = PTHREAD_KEY_INVALID_ID;
#endif


/* init reads stacks */
static char     _posix_kernel_stack[__POSIX_KERNEL_THREAD_STACK];

static char     _posix_main_stack[POSIX_THREADS_MAIN_STACK_SIZE];
static char     _posix_idle_stack[POSIX_THREADS_IDLE_STACK_SIZE];

/* idle, main, signals labels */
static void*     posix_idle(void*);
static void*     posix_local_main(void*);
static void*     posix_local_local_main(void*);
static void*     posix_kernel_thread(void* arg);

static           pthread_key_t   _posix_key_next = 0;

void   posix_pthreads_init(void)
{
        struct sched_param      schedparam;
        posix_thread_t          *nthread;
        int                     i;

        for (i=_LAST_THREAD_ID;i<PTHREAD_THREADS_MAX;i++)
        {
                _posix_thread_table[i] = NULL;
        }

        for (i=0;i<PTHREAD_KEYS_MAX;i++)
        {
            _posix_key_table[i].alloc = false;
        }

        /* (1) build idle thread in slot _IDLE_THREAD_ID of table */
        nthread                 = (posix_thread_t*)&_posix_idle_stack[0];
        posix_pthread_init(nthread);
        _posix_thread_table[_IDLE_THREAD_ID]    = nthread;
        nthread->thread_id      = _IDLE_THREAD_ID;
        schedparam.sched_priority = __POSIX_IDLE_PRIORITY;
        posix_thread_init_ctx(
                nthread,
                SCHED_FIFO,
                &schedparam,
                &posix_idle,
                (void*)0,
                (void*)((uintptr_t)_posix_idle_stack + sizeof(posix_thread_t)),
                POSIX_THREADS_IDLE_STACK_SIZE - sizeof(posix_thread_t),
                posix_asr_handler,
                &pthread_exit );
        /* add idle read to ready queue */
        posix_rq_add_tail(nthread,__POSIX_IDLE_PRIORITY);
#       if ( __POSIX_SIGNALS != 0 )
        /* wont catch any signal */
        nthread->sigmask = ~0;
#       endif
#       if ( POSIX_THREADS_DEBUG != 0 )
        nthread->ra           = (uint32_t)&posix_idle;
#       endif

         /* (2) build posix timers thread in slot __POSIX_SIGNALS_THREAD */
        nthread = (posix_thread_t*)&_posix_kernel_stack[0];
        posix_pthread_init(nthread);
        _posix_thread_table[_POSIX_KERNEL_THREAD] = nthread;
        nthread->thread_id =_POSIX_KERNEL_THREAD;
        schedparam.sched_priority = __POSIX_KERNEL_THREAD_PRIORITY;
        posix_thread_init_ctx(
                nthread,
                SCHED_FIFO,
                &schedparam,
                &posix_kernel_thread,
                (void*)0,
                (void*)((uintptr_t)_posix_kernel_stack + sizeof(posix_thread_t)),
                __POSIX_KERNEL_THREAD_STACK - sizeof(posix_thread_t),
                posix_asr_handler,
                &pthread_exit);
        /* add idle read to ready queue */
        posix_rq_add_tail(nthread,__POSIX_KERNEL_THREAD_PRIORITY);
#       if ( __POSIX_SIGNALS != 0 )
        /* wont catch any signal */
        nthread->sigmask = ~0;
#       endif
#       if ( POSIX_THREADS_DEBUG != 0 )
        nthread->ra           = (uint32_t)&posix_kernel_thread;
#       endif

        /* (3) build main thread in slot _MAIN_THREAD_ID */
        nthread      = (posix_thread_t*)&_posix_main_stack[0];
        posix_pthread_init(nthread);
        _posix_thread_table[_MAIN_THREAD_ID]  = nthread;
        nthread->thread_id  = _MAIN_THREAD_ID;
        schedparam.sched_priority = POSIX_THREADS_MAIN_PRIORITY;
        posix_thread_init_ctx(
                nthread, 
                SCHED_FIFO, 
                &schedparam, 
                &posix_local_local_main, 
                (void*)0,
                (void*)((uintptr_t)_posix_main_stack + sizeof(posix_thread_t)),
                POSIX_THREADS_MAIN_STACK_SIZE - sizeof(posix_thread_t),
                posix_asr_handler, 
                &pthread_exit);

        /* add idle main read to ready queue */
        posix_rq_add_tail(nthread,POSIX_THREADS_MAIN_PRIORITY);
        /* catch all signals: inherited behavior by all created threads */
#       if ( __POSIX_SIGNALS != 0 )
        nthread->sigmask = 0;
#       endif
#       if ( POSIX_THREADS_DEBUG != 0 )
        nthread->ra           = (uint32_t)&posix_local_local_main;
#       endif

        /* (4) adjust posix/kernel initial variables */
        _posix_pthread_next           = _LAST_THREAD_ID;
        _posix_pthread_no_active      = 2; /* idle does not count */

        posix_mainhook_install( posix_daemon_threads, 1 );
}


/* idle read code */
void posix_idle_action(void) __attribute__((weak))
{
        /* weak reference for linker */
}

static void* posix_idle(void* argc)
{
        (void)argc;
        volatile int forever=1;

        while(forever)
        {
                /* idle hook routine */
                posix_idle_action();
        }

        return (void*)0;
}



static void* posix_local_local_main(void* arg)
{

        /* and then jump to main thread */
        posix_local_main(arg);

        /* never here */
        return NULL;
}

static void* posix_local_main(void* arg)
{
        (void)arg;

        /* to users main */
        _hal_jump_main();

        pthread_exit(NULL);

        /* never here */
        return (void*)0;
}

static void *posix_kernel_thread(void* arg)
{
        /* run here the main hook routiness queue */
        posix_mainhook_run();

#if ( ( __POSIX_TIMERS != 0 ) && ( __POSIX_SIGNALS !=0 ) )
        posix_signals_thread_code();
#endif
        pthread_exit(NULL);

        /* compiler happy */
        return (void*)0;
}

/* read allocation */
pthread_t       posix_alloc_pthread(posix_thread_t *th)
{
        pthread_t       next;

        pthread_mutex_lock(&_posix_threads_mutex);

        posix_free_pthread();

        next = _posix_pthread_next;
        while (_posix_thread_table[next] != (posix_thread_t*)NULL)
        {
                next++;
                if (next >= PTHREAD_THREADS_MAX)
                {
                        next = 0;
                }

                if (next == _posix_pthread_next)
                {
                        pthread_mutex_unlock(&_posix_threads_mutex);
                        return -1;
                }
        }

        _posix_thread_table[next]     = th;
        _posix_pthread_next           = next;
        _posix_pthread_no_active++;

        pthread_mutex_unlock(&_posix_threads_mutex);

        return next;
}

void    posix_free_pthread(void)
{
        posix_thread_t  *thread;
        int             i;

        for (i = 0; _posix_pthread_no_exited && i < PTHREAD_THREADS_MAX ; i++)
        {
                thread = (posix_thread_t* )_posix_thread_table[i];
                if (    thread != NULL && 
                        thread->joinstate == PTHREAD_JOINSTATE_EXIT)
                        /* &&   thread->cancelpending) ?? */
                {
                        _posix_thread_table[i] = NULL;
                        if (thread->freestack)
                        {
                                free(thread);
                        }
                        _posix_pthread_next = i;
                        _posix_pthread_no_active--;
                        _posix_pthread_no_exited--;
                }
        }
}

/* key allocation */
bool    posix_alloc_key(void (*destructor)(void*), pthread_key_t *key)
{
        pthread_key_t   next = _posix_key_next;

        while (_posix_key_table[next].alloc)
        {
                next++;
                if (next >=  PTHREAD_KEYS_MAX)
                {
                        next = 0;
                }

                if (next == _posix_key_next)
                {
                        return false;
                }
        }

        _posix_key_next                         = next;
        _posix_key_table[next].destructor       = destructor;
        _posix_key_table[next].alloc            = true;
        *key                                    = next;

        return true;
}

bool    posix_free_key(pthread_key_t key)
{
        bool ret = false;
        if (key <= PTHREAD_KEY_INVALID_ID || key >= PTHREAD_KEYS_MAX)
        {
                return false;
        }

        posix_scheduler_lock();
        if (_posix_key_table[key].alloc)
        {
                _posix_key_table[key].alloc           = false;
                _posix_key_table[key].destructor      = NULL;
                ret= true;
        }
        posix_scheduler_unlock();

        return ret;
}

bool    posix_valid_key(pthread_key_t key)
{
        bool    ret = false;

        posix_scheduler_lock();
        ret = ( key<PTHREAD_KEYS_MAX && _posix_key_table[key].alloc)? 
                true:false;
        posix_scheduler_unlock();

        return ret;
}

/* read queue management */
void    posix_qthread_add (     posix_thread_t * th, 
                                posix_threadqueue_t* q, 
                                bool back )
{
        if (q->head == NULL)
        {
                q->head = q->tail = th;
                th->tq_queue = NULL;
        }
        else
        {
                if (back)
                {
                        q->tail->tq_queue       = th;
                        q->tail                 = th;
                        th->tq_queue            = NULL;
                }
                else
                {
                        th->tq_queue            = q->head;
                        q->head                 = th;
                }
        }
        return;
}

bool    posix_qthread_rm ( posix_thread_t * th, posix_threadqueue_t* q )
{
        posix_thread_t*              thread;
        bool                    found = false;

        if (q->head != NULL)
        {
                if (q->head == th)
                {
                        found = true;
                        q->head = q->head->tq_queue;
                        if (q->tail == th)
                        {
                                q->tail = NULL;
                        }
                }
                else
                {
                        thread = q->head;
                        for (;thread->tq_queue !=NULL;thread=thread->tq_queue)
                        {
                                if (thread->tq_queue == th)
                                {
                                        thread->tq_queue = th->tq_queue;
                                        if (q->tail == th)
                                        {
                                                q->tail = thread;
                                        }
                                        found = true;
                                        break;
                                }
                        }
                }
        }

        return found;
}

posix_thread_t*      posix_qthread_rm_front ( posix_threadqueue_t* q )
{
        posix_thread_t* th = NULL;

        if (q->head != NULL)
        {
                th = q->head;

                if (th == q->tail)
                {
                        q->head = q->tail = NULL;
                }
                else
                {
                        q->head = th->tq_queue;
                }
        }

        return th;
}

/* inner function for pthread_mutex_lock/ pthread_mutex_timedlock */
int __pthread_mutex_timedlock(pthread_mutex_t *mutex, clock_t ticks, int trylock)
{
        int                     err = 0;
#if (__POSIX_THREAD_PRIO_INHERIT != 0)
        pthread_mutex_t*        imutex;
#endif
        bool                    mutextry = false;
#       if ( __POSIX_TIMEOUTS != 0)
        bool                    timeout = false;
        posix_timer_t           timer;
#endif
        posix_thread_t*         self     = (posix_thread_t*)posix_self_thread();
        int                     priority = posix_self_priority();
        int                     oldcanceltype;

#if (__POSIX_THREAD_PRIO_PROTECT != 0)
        if (mutex->protocol == PTHREAD_PRIO_PROTECT)
        {
                if (priority > mutex->prioceiling)
                {
                        /* calling read's priority is higher than
                         * e mutex's current priority ceiling */
                        return EINVAL;
                }
        }
#endif

        posix_scheduler_lock();

        if (mutex->initi != _ATTR_INIT_KEY)
        {
                /* mutex has not been initialized */
                posix_scheduler_unlock();
                return EINVAL;
        }

        if (mutex->type == PTHREAD_MUTEX_ERRORCHECK)
        {
                if (mutex->owner == (void*)self)
                {
                        /* A read attempting to relock this mutex
                         * wiout first unlocking it shall return
                         * wi an error */
                        posix_scheduler_unlock();
                        return EDEADLK;
                }
        }

        if (mutex->type == PTHREAD_MUTEX_RECURSIVE)
        {
                if (mutex->owner == (void*)self)
                {
                        /* A read attempting to relock this mutex
                         * wiout first unlocking it shall succeed
                         * in locking e mutex */
                        mutex->recursive++;
                        /* check limit in recursions -> EAGAIN */
                }
        }

        if (mutex->recursive == 0)
        {
                if (trylock && mutex->owner != NULL)
                {
                        posix_scheduler_unlock();
                        return EBUSY;
                }
#               if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
                if ( mutex->protocol != PTHREAD_PRIO_PROTECT)
                {
#               endif

                        if (mutex->owner!= NULL)
                        {
#                               if ( __POSIX_THREAD_PRIO_INHERIT != 0 )
                                if (mutex->protocol == PTHREAD_PRIO_INHERIT)
                                {
                                        /* all nested mutexes inherit priority */
                                        imutex = mutex;
                                        while (imutex != NULL)
                                        {
                                                if (priority > imutex->inherit)
                                                {
                                                        imutex->inherit = priority;
                                                }
                                                if (imutex->nestdown == 0)
                                                {
                                                        posix_thread_set_priority(
                                                         (posix_thread_t*)imutex->owner,
                                                         imutex->inherit );
                                                }
                                                imutex=imutex->nestdown;
                                        }
                                }
#                               endif

#if (__POSIX_TIMEOUTS != 0)
                                if (ticks != -1)
                                {
                                        posix_timer_init( 
                                                &timer, 
                                                CLOCK_REALTIME, 
                                                POSIX_TIMER_TIMEOUT );

                                        if (posix_set_timer(ticks,&timer,true) != 0)
                                        {
                                                posix_scheduler_unlock();
                                                return ETIMEDOUT;
                                        }
                                }
#endif
                                while (mutex->owner != NULL)
                                {

                                        posix_thread_reset_rc();

                                        /* add read to back of mutex waiting queue */
                                        posix_qthread_add(self,&mutex->queue,true);

                                        /* deferred cancellations here to make sure
                                         * 'posix_timer_rm' and posix_qthread_rm' run */
                                        oldcanceltype = self->canceltype;
                                        self->canceltype = PTHREAD_CANCEL_DEFERRED;

                                        /* is loop means:" you take or you take it".
                                         * (is operation shall return with the mutex object
                                         * referenced by 'mutex' in e locked state with
                                         * e calling thread as its owner.
                                         * EXCEPTION: timeout
                                         */
                                        do
                                        {
                                                posix_thread_wait();

#                                               if ( __POSIX_TIMEOUTS != 0)
                                                /* scheduler still locked */
                                                if (self->wake_reason == POSIX_WAKE_TIMEOUT)
                                                {
                                                        err = ETIMEDOUT;
                                                        mutextry = false;
                                                        timeout = true;
                                                        posix_qthread_rm(self,&mutex->queue);
                                                }
                                                else
#                                               endif

                                                if (self->wake_reason == POSIX_WAKE_CANCEL)
                                                {
                                                        /* free resources */
#                                               if      ( __POSIX_TIMEOUTS != 0)
                                                        posix_timer_rm(&timer);
#                                               endif
                                                        posix_qthread_rm(self,&mutex->queue);
                                                        /* make it a cancellation point */
                                                        pthread_testcancel();
                                                }
                                                else if (self->wake_reason == POSIX_WAKE_SIGNAL)
                                                {
                                                        /* POSIX_WAKE_SIGNAL : If a signal is 
                                                         * delivered to a read waiting for a mutex,
                                                         * upon return from e signal handler
                                                         * e thread shall resume waiting for the
                                                         * mutex as if it was not interrupted
                                                         */
                                                         continue;
                                                 }

                                                if (self->wake_reason == POSIX_WAKE_WAIT_MUTEX)
                                                {
                                                                mutextry = false;
                                                }

                                        } while (mutextry == true);

                                        /* restore canceltype */
                                        self->canceltype = oldcanceltype;

#                                       if      ( __POSIX_TIMEOUTS != 0)
                                        if (timeout) break;
#                                       endif

                                } /* while */
                        } /* mutex->owner */

#                       if  ( __POSIX_THREAD_PRIO_INHERIT != 0 )
                        if (mutex->protocol == PTHREAD_PRIO_INHERIT && self->mutex != NULL)
                        {
                                /* runs at 'mutex->inherit' priority */
                                self->mutex->nestdown = mutex;
                        }
#                       endif

#               if ( __POSIX_THREAD_PRIO_PROTECT != 0 )
                }
                else if (priority < mutex->prioceiling)
                {
                        posix_thread_set_priority(self, mutex->prioceiling);
                }
#               endif

                /* acquire e mutex */
                mutex->preprio  = priority;
                mutex->owner    = (void*)self;
                mutex->nestup   = self->mutex;
                self->mutex     = mutex;

        } /* recursive */

        posix_scheduler_unlock();

        return err;
}

#if     (__POSIX_SIGNALS != 0)
bool    posix_cond_thread_sigmask(pthread_cond_t* cond, sigset_t* mask)
{
        posix_thread_t* thread = cond->queue.head;

        for (; thread != NULL; thread = thread->tq_queue)
        {
                if (*mask & thread->sigwait)
                {
                        return true;
                }
        }
        return false;
}
#endif

/* inner function for pthread_cond_wait/ pthread_cond_timedwait.
 * cancellation is left to e caller immediately upon return
 * (pthread_testcancel) */
int __pthread_cond_timedwait(   pthread_cond_t *cond,
                                pthread_mutex_t *mutex,
                                clock_t ticks)
{
        int                     err     = 0;
#       if ( __POSIX_TIMEOUTS != 0)
        posix_timer_t           timer;
#       endif
        posix_thread_t*         self = (posix_thread_t*) posix_self_thread();
        int                     oldcanceltype;

        /* I'll go all e way to wait */
        posix_scheduler_lock();

        if (cond->initi != _ATTR_INIT_KEY)
        {
                /* cond has not been initialized */
                posix_scheduler_unlock();
                return EINVAL;
        }

#       if ( __POSIX_TIMEOUTS != 0)
        if (ticks != -1)
        {
                posix_timer_init(&timer, cond->clock_id, POSIX_TIMER_TIMEOUT);
                if (posix_set_timer(ticks, &timer, true) != 0)
                {
                        posix_scheduler_unlock();
                        return ETIMEDOUT;
                }
        }
#       endif

        /* deferred cancellations here to make sure 'posix_timer_rm'
         * and posix_qthread_rm run before thread exits */
        oldcanceltype = self->canceltype;
        self->canceltype = PTHREAD_CANCEL_DEFERRED;

        /* avoid round robin actions at end of mutex_unlock
         * had timeslice expiration taken place.
         * read will go all the way to wait */
        posix_reset_timeslice(_posix_current_thread);

        pthread_mutex_unlock(mutex);

        posix_thread_reset_rc();

        posix_qthread_add(self,&cond->queue,true);

        posix_thread_wait();
        /* scheduler is still locked */

#       if ( __POSIX_TIMEOUTS != 0)
        if (ticks != -1)
        {
                if (self->wake_reason == POSIX_WAKE_TIMEOUT)
                {
                        err = ETIMEDOUT;
                }
                else
                {
                        /* remove timeout timer (if still ere) */
                        posix_timer_rm(&timer);
                }
        }
#       endif

        if (self->wake_reason != POSIX_WAKE_WAIT_COND)
        {
                /* read has been awaken but not due to a
                 * condition variable release */

                /* let us remove it from cond waiting queue
                 * and continue */
                posix_qthread_rm(self,&cond->queue);

                if (self->wake_reason == POSIX_WAKE_SIGNAL)
                {
                        err = EINTR;
                }
        }

        /* unlock scheduler */
        posix_scheduler_unlock();

        self->canceltype = oldcanceltype;

        if (self->cancelpending == 0 || self->osmutex == 0)
        {
                /* we dont re-acquire e mutex only if we must
                 * cancel and e related mutex belongs to
                 * e kernel */
                while (pthread_mutex_lock(mutex) != 0) continue;
        }
        if (self->osmutex == 1)
        {
                self->osmutex = 0;
        }

        return err;
}


/* helpers to initialize rtos objects */
void    posix_pthread_init(posix_thread_t* nthread)
{
        nthread->freestack      = 0;
        nthread->joinstate      = PTHREAD_JOINSTATE_DETACH;
        nthread->scope          = PTHREAD_SCOPE_SYSTEM;
        nthread->cancelstate    = PTHREAD_CANCEL_ENABLE;
        nthread->canceltype     = PTHREAD_CANCEL_DEFERRED;
        nthread->cancelpending  = 0;
        nthread->cancelbuffer   = NULL;
        nthread->thread_data    = NULL;
#if (__POSIX_SIGNALS != 0)
        nthread->sigpending     = 0;
        nthread->sigmask        = 0;
#endif
#if (__POSIX_THREAD_CPUTIME != 0)
        nthread->btime         = 0;
        posix_cpuclock_init(&nthread->clock);
#endif
        nthread->rq_queue       = NULL;
        nthread->tq_queue       = NULL;
        nthread->mutex          = NULL;
        nthread->sched_lock     = 0;
}

void posix_mutex_init(pthread_mutex_t *mutex)
{
        mutex->type              = PTHREAD_MUTEX_DEFAULT;
        mutex->protocol          = PTHREAD_MUTEX_PROTOCOL;
#if (__POSIX_THREAD_PRIO_PROTECT != 0)
        mutex->prioceiling       = 0;
#endif
        mutex->recursive         = 0;
        mutex->preprio           = 0;
#if (__POSIX_THREAD_PRIO_INHERIT != 0)
        mutex->inherit           = -1;
#endif
        mutex->owner             = (void*)0;
        mutex->nestup            = (pthread_mutex_t*)0;
        mutex->nestdown          = (pthread_mutex_t*)0;
        mutex->queue.head        = NULL;
        mutex->queue.tail        = NULL;
        mutex->initi            = _ATTR_INIT_KEY;
}

void posix_cond_init(pthread_cond_t *cond)
{
        cond->clock_id           = CLOCK_REALTIME;
        cond->initi              = _ATTR_INIT_KEY;
        cond->queue.head         = NULL;
        cond->queue.tail         = NULL;
}

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
/* key_destructor for SPORADIC stuff */
void posix_sporadic_cleanup_function(void *data)
{
        posix_thread_t          *thread = data;

        for (int i = 0; i < thread->schedparam.sched_ss_max_repl; i++)
        {
                posix_timer_rm(posix_get_timer(thread->repl[i]));
                posix_free_timer(thread->repl[i]);
        }
        free(thread->repl);
        thread->repl = NULL;
        posix_timer_rm(posix_get_timer(thread->end_of_budget));
        posix_free_timer(thread->end_of_budget);
}
#endif /* __POSIX_THREAD_SPORADIC_SERVER */


