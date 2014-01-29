/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_destroy
|*
\*****************************************************************************/


#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>
#include "posix_pthread.h"
#include "posix_time.h"
#include "posix_asr.h"
#include "kernel.h"

/**
 *  @file pthread.h
 *      
 *      This plugin provides basic multithreading services based on the the POSIX Minimal 
 *      Realtime System (PSE51) Profile as described in the IEEE Std 1003.13-2001 edition. 
 *      The programming model is that of a single (implicit) POSIX process 
 *      (corresponding to the processor's hardware address space), containing one or more 
 *      threads of control (POSIX.1 threads or Ada tasks). 
 *      Special devices are operated and controlled either by memory-mapped I/O or by the basic I/O
 *      interface, which provides a standard way to access the intrinsically non-standard I/O 
 *      hardware and its non-portable control code.
 *      The hardware model for this profile assumes a single processor with its memory, 
 *      but no memorymanagement unit (MMU) is required. In multi-proces systems, typically also multiple
 *      instantiations of the operating system exist, possibly communicating via shared memory or a
 *      backplane channel, or perhaps isolated. 
 *      
 */


/**
 * @brief
 *      creates a new thread
 *
 *      The pthread_create() function shall create a new thread, with attributes 
 *      specified by attr, within a process. If attr is NULL, the default attributes
 *      shall be used. If the attributes specified by attr are modified later, 
 *      the thread's attributes shall not be affected. Upon successful completion, 
 *      pthread_create() shall store the ID of the created thread in the location 
 *      referenced by thread.
 *      The thread is created executing start_routine with arg as its sole argument. 
 *      If the start_routine returns, the effect shall be as if there was an implicit 
 *      call to pthread_exit() using the return value of start_routine as the exit status. 
 *      Note that the thread in which main() was originally invoked differs from this. 
 *      When it returns from main(), the effect shall be as if there was an implicit call 
 *      to exit() using the return value of main() as the exit status.
 *
 *      The signal mask shall be inherited from the creating thread and the set of signals 
 *      pending for the new thread shall be empty.
 *
 * @param thread
 *      return (pthread_t *) parameter that stores the created threads id
 * @param attr
 *      pointer to a read-only thread's attribute object
 * @param start_routine
 *      thread's start routine
 * @param arg
 *      thread's start argument
 *
 * @return
 *      Upon successful completion it shall return a value of 0; otherwise, an error number 
 *      shall be returned to indicate the error.     
 */
int pthread_create ( pthread_t *thread,
                     const pthread_attr_t *attr,
                     void *(*start_routine) (void *),
                     void *arg)
{
        posix_thread_t          *nthread;
        posix_thread_t          *self;
        void                    *stackaddr;
        int                     stacksize;
        uint8_t                 schedpolicy;
        struct sched_param      schedparam;
        pthread_attr_t          default_attr;
        bool                    dyn = false;
        pthread_t               id;

        /* attributes */
        if (attr==NULL)
        {
                /* default */
                memset(&default_attr, 0, sizeof(default_attr));
                pthread_attr_init(&default_attr);
                attr = &default_attr;
        }
        else  if (attr->init != _ATTR_INIT_KEY)
        {
                /* not initialized yet */
                return EINVAL;
        }

        /* stack allocation */
        if (attr->stackaddr == NULL)
        {
                if (attr->stacksize > 0)
                {
                        stackaddr = (void*) malloc(attr->stacksize);
                }
                else
                {
                        stackaddr = (void*) malloc(PTHREAD_STACK_MIN);
                }

                if (stackaddr == NULL)
                {
                        return EAGAIN;
                }
                dyn = true;
        }
        else
        {
                stackaddr = attr->stackaddr;
        }
        nthread = (posix_thread_t*)stackaddr;

        /* thread table entry */
        if ( (id = posix_alloc_pthread(nthread)) == -1 )
        {
                if (dyn)
                {
                        free(stackaddr);
                }
                return EAGAIN;
        }

        /* evth is okay now */

        /* could be optional */
        memset((void *) stackaddr, 0, attr->stacksize);

        /* build thread internal data */
        self = ( posix_thread_t *) posix_self_thread();

        schedpolicy = (attr->inheritsched == PTHREAD_INHERIT_SCHED) ?
            self != NULL ? self->schedpolicy : SCHED_FIFO : attr->schedpolicy;

#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        if (schedpolicy == POSIX_SCHED_SPORADIC)
        {
                nthread->repl = calloc(__POSIX_SS_REPL_MAX, sizeof(timer_t));
                if (nthread->repl == NULL)
                {
                        if (dyn)
                        {
                                free(stackaddr);
                        }
                        free(nthread->repl);
                        posix_free_pthread_failed_init(id);
                        return EAGAIN;
                }
                for (int i = 0; i < attr->schedparam.sched_ss_max_repl; i++)
                {
                        if (posix_alloc_timer(&nthread->repl[i]) == false)
                        {
                                /* not enough timers in the system */
                                if (dyn)
                                {
                                        free(stackaddr);
                                }
                                for (--i; i >= 0; i--)
                                {
                                    posix_free_timer(nthread->repl[i]);
                                }
                                free(nthread->repl);
                                posix_free_pthread_failed_init(id);
                                return EAGAIN;
                        }
                }
                if (posix_alloc_timer(&nthread->end_of_budget) == false)
                {
                        /* not enough timers in the system */
                        if (dyn)
                        {
                                free(stackaddr);
                        }
                        for (int i = 0; i < attr->schedparam.sched_ss_max_repl; i++)
                        {
                                posix_free_timer(nthread->repl[i]);
                        }
                        free(nthread->repl);
                        posix_free_pthread_failed_init(id);
                        return EAGAIN;
                }
                pthread_setspecific(_posix_sporadic_cleanup_key, nthread);
                nthread->budget = nthread->schedparam.sched_ss_init_budget;
                nthread->last_repl = -1;
        }
#endif

        nthread->freestack      = (dyn==true) ? 1 : 0;

        nthread->joinstate      = (attr->detachstate==PTHREAD_CREATE_JOINABLE)?
                        PTHREAD_JOINSTATE_FREE: PTHREAD_JOINSTATE_DETACH;
        nthread->scope          = attr->scope;

        nthread->cancelstate    = PTHREAD_CANCEL_ENABLE;
        nthread->canceltype     = PTHREAD_CANCEL_DEFERRED;
        nthread->cancelpending  = 0;
        nthread->intr_notify    = 0;
        nthread->intr_wait      = 0;
        nthread->inasrhandler   = 0;
        nthread->osmutex        = 0;
        nthread->cancelbuffer   = NULL;
        nthread->thread_data    = NULL;
        #if     (__POSIX_SIGNALS != 0)
        nthread->sigpending     = 0;
        nthread->sigwait        = 0;
        nthread->sigmask        = self != NULL ? self->sigmask : 0;
        #endif
        #if ( __POSIX_THREAD_CPUTIME != 0 )
        nthread->btime          = 0;
        posix_cpuclock_init(&nthread->clock);
        #endif
        nthread->rq_queue       = NULL;
        nthread->tq_queue       = NULL;
        nthread->mutex          = NULL;
        nthread->sched_lock     = 0;
        nthread->thread_id      = id;
#if (__POSIX_THREAD_ATTR_NAME != 0)
        strcpy(nthread->name, attr->name);
#endif

        if (thread != NULL)
        {
            *thread             = id;
        }
        pthread_cond_init(&nthread->joincond, NULL);

        if (attr->inheritsched == PTHREAD_INHERIT_SCHED)
        {
            if (self != NULL)
            {
                schedparam  = self->schedparam;
            }
            else
            {
                schedparam.sched_priority = 1;
            }
        }
        else
        {
            schedparam  = attr->schedparam;
        }
        stackaddr   = (void*)((uintptr_t)stackaddr + sizeof(posix_thread_t));
        stacksize   = attr->stacksize - sizeof(posix_thread_t);

        /* init thread */
        posix_thread_init(      nthread,
                                schedpolicy,
                                &schedparam,
                                start_routine,
                                arg,
                                stackaddr,
                                stacksize,
                                posix_asr_handler,
                                &pthread_exit );

    #if ( POSIX_THREADS_DEBUG != 0 )
        nthread->ra             = (uint32_t)start_routine;
        nthread->restores       = 0;
    #endif

        return 0;
}
