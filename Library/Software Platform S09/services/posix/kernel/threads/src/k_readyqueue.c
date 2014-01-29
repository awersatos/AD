/******************************************************************************
 * FILE:                @(#)k_readyqueue.c      1.9 07/02/21
 * DESCRIPTION:         
 *      ready queue implementation
 *****************************************************************************/
#include <sys/types.h>
#include "kconf.h"
#include "k_readyqueue.h"

#define POSIX_NO_PRIORITIES             (POSIX_MAX_SCHED_PRIORITY+1)

/* 'ready' threads are queued in a circular linear linked list */
posix_thread_t **  _posix_readyqueue[ POSIX_NO_PRIORITIES];

/* bit in this 64-bit mask is set if level is populated, zero otherwise */
int64_t         _posix_levelmask = 0;

posix_thread_t*         posix_rq_rm_head(int pri)
{
        posix_thread_t* thread;
        
        if (    pri < POSIX_MIN_SCHED_PRIORITY || 
                pri > POSIX_MAX_SCHED_PRIORITY ||
                posix_rq_empty(pri) == true
        ) 
        {
                return (posix_thread_t*)0;
        }
        
        thread = *_posix_readyqueue[pri];
        
        /* dequeue head  */
        *_posix_readyqueue[pri]         = thread->rq_queue;

        /* old 'head' is not queued anymore */
        thread->rq_queue           = (posix_thread_t*)0;

        /* If 'head' was the only item in the queue,
         * we must indicate that the queue is empty */
        if ( *_posix_readyqueue[pri] == (posix_thread_t*)0 )
        {
                _posix_readyqueue[pri]  = (posix_thread_t**)0;
                _posix_levelmask                &= ~(1LL<<pri);
        }

        return thread;
}

void    posix_rq_rm_thread(posix_thread_t* thread,int pri)
{
        posix_thread_t**        ptr;
        
        if (    pri<POSIX_MIN_SCHED_PRIORITY || 
                pri>POSIX_MAX_SCHED_PRIORITY ||
                posix_rq_empty(pri) == true
        ) 
        {
                return;
        }
        
        ptr = _posix_readyqueue[pri];

        while(*ptr!=thread) { ptr = &(*ptr)->rq_queue; }
        
        *ptr            = (posix_thread_t*) thread->rq_queue;
        thread->rq_queue   = (posix_thread_t*) 0;
        
        if (*ptr == (posix_thread_t*)0)
        {
                /* empty queue */
                _posix_readyqueue[pri] = (posix_thread_t**)0;
                _posix_levelmask                &= ~(1LL<<pri);
        }

        return;
}

void posix_rq_add_tail(posix_thread_t* thread, int pri)
{
        if (    pri<POSIX_MIN_SCHED_PRIORITY || 
                pri>POSIX_MAX_SCHED_PRIORITY) 
        {
                return;
        }

        if (_posix_readyqueue[pri])
        {
                /* not empty */
                thread->rq_queue = *_posix_readyqueue[pri];
                *_posix_readyqueue[pri] = thread;
                _posix_readyqueue[pri] = (posix_thread_t**)&thread->rq_queue;
        }
        else
        {
                /* empty */
                _posix_readyqueue[pri] = (posix_thread_t**)&thread->rq_queue;
                thread->rq_queue = thread;
        }
        
        _posix_levelmask |= (1LL << pri);
        
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        if (thread->schedpolicy == POSIX_SCHED_SPORADIC)
        {
                clock_gettime(  CLOCK_MONOTONIC, 
                                &thread->activation_time);
        }
#endif

        return;
}

void posix_rq_add_head(posix_thread_t* thread, int pri)
{
        if (    pri<POSIX_MIN_SCHED_PRIORITY || 
                pri>POSIX_MAX_SCHED_PRIORITY) 
        {
                return;
        }

        if (_posix_readyqueue[pri])
        {
                /* not empty */
                thread->rq_queue = *_posix_readyqueue[pri];
                *_posix_readyqueue[pri] = thread;
        }
        else
        {
                /* empty */
                _posix_readyqueue[pri] = (posix_thread_t**) &thread->rq_queue;
                thread->rq_queue = thread;
        }

        _posix_levelmask |= (1LL << pri);
        
        return;
}

