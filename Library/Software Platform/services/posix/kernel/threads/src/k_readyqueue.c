/******************************************************************************
 * FILE:                @(#)k_readyqueue.c      1.9 07/02/21
 * DESCRIPTION:         
 *      ready queue implementation
 *****************************************************************************/
#include <sys/types.h>
#include "kconf.h"
#include "k_readyqueue.h"

#define POSIX_NO_PRIORITIES             (POSIX_MAX_SCHED_PRIORITY+1)

/* */
typedef struct posix_readyqueue_t {
    posix_thread_t  *first;
    posix_thread_t  *last;
} posix_readyqueue_t;

/*
 * threads are queued in a NULL terminated list with
 * a first and last pointer for the head of the list
 */
static posix_readyqueue_t  _posix_readyqueue[POSIX_NO_PRIORITIES];

/* bit in this 64-bit mask is set if level is populated, zero otherwise */
static int64_t _posix_levelmask = 0;

posix_thread_t*         posix_rq_rm_head(int pri)
{
        posix_thread_t* thread;
        
    if (pri < POSIX_MIN_SCHED_PRIORITY || pri > POSIX_MAX_SCHED_PRIORITY || posix_rq_empty(pri) == true)
        {
        return NULL;
        }
        
    thread = _posix_readyqueue[pri].first;
        
        /* dequeue head  */
    _posix_readyqueue[pri].first = thread->rq_queue;

        /* old 'head' is not queued anymore */
    thread->rq_queue = NULL;

        /* If 'head' was the only item in the queue,
         * we must indicate that the queue is empty */
    if (_posix_readyqueue[pri].last == thread)
        {
        _posix_readyqueue[pri].last = NULL;
                _posix_levelmask                &= ~(1LL<<pri);
        }

        return thread;
}

void    posix_rq_rm_thread(posix_thread_t* thread,int pri)
{
    posix_thread_t *ptr;
        
    if (pri < POSIX_MIN_SCHED_PRIORITY || pri > POSIX_MAX_SCHED_PRIORITY || posix_rq_empty(pri) == true)
        {
                return;
        }
        
    if (_posix_readyqueue[pri].first == thread)
    {
        _posix_readyqueue[pri].first = thread->rq_queue;
        if (_posix_readyqueue[pri].last == thread)
        {
            _posix_readyqueue[pri].last = NULL;
            _posix_levelmask &= ~(1LL << pri);
        }
    }
    else
    {
        ptr = _posix_readyqueue[pri].first;
        while (ptr != NULL && ptr->rq_queue != thread)
        {
            ptr = ptr->rq_queue;
        }

        if (ptr != NULL)
        {
            ptr->rq_queue = ptr->rq_queue->rq_queue;
            if (_posix_readyqueue[pri].last == thread)
        {
                _posix_readyqueue[pri].last = ptr;
            }
            thread->rq_queue = NULL;
        }
        }

        return;
}

void posix_rq_add_tail(posix_thread_t* thread, int pri)
{
    if (pri < POSIX_MIN_SCHED_PRIORITY || pri > POSIX_MAX_SCHED_PRIORITY)
        {
                return;
        }

    if (_posix_readyqueue[pri].first == NULL)
        {
        _posix_readyqueue[pri].first = thread;
        _posix_readyqueue[pri].last = thread;
        thread->rq_queue = NULL;
        _posix_levelmask |= (1LL << pri);
        }
        else
        {
        thread->rq_queue = NULL;
        _posix_readyqueue[pri].last->rq_queue = thread;
        _posix_readyqueue[pri].last = thread;
        }
        
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
        if (thread->schedpolicy == POSIX_SCHED_SPORADIC)
        {
        clock_gettime(CLOCK_MONOTONIC, &thread->activation_time);
        }
#endif

        return;
}

void posix_rq_add_head(posix_thread_t* thread, int pri)
{
    if (pri < POSIX_MIN_SCHED_PRIORITY || pri > POSIX_MAX_SCHED_PRIORITY)
        {
                return;
        }

    thread->rq_queue = _posix_readyqueue[pri].first;
    _posix_readyqueue[pri].first = thread;
    if (_posix_readyqueue[pri].last == NULL)
        {
        _posix_readyqueue[pri].last = thread;
        _posix_levelmask |= (1LL << pri);
    }

    return;
        }

/* return 'true' if the priority level is populated */
bool posix_rq_empty(int level)
        {
    return !(_posix_levelmask & (1LL << level));
        }

/* calculates the highest priority from given level */
int posix_rq_high_prio(void)
{
    return pal_msbit64_index(_posix_levelmask);
}

