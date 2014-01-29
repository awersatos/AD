/******************************************************************************
 * FILE:                @(#)k_readyqueue.h      1.5 06/05/22
 * DESCRIPTION:         
 *      kernel ready-queue interface
 *      - caller is responsible for avoiding concurrency problems
 *****************************************************************************/
#ifndef _H_K_READYQUEU
#define _H_K_READYQUEU

#include "posix_pthread.h"
#include "kernel.h"
#include "pal.h"

/* see k_readyqueue.c */
extern int64_t                  _posix_levelmask;
extern posix_thread_t **        _posix_readyqueue[];

/* return 'true' if the priority level is populated */
inline bool             posix_rq_empty(int level)
{
        if (_posix_levelmask & ( 1LL << level))
        {
                return false;
        }
        return true;
}
/* calculates the highest priority from given level */
inline  int posix_rq_high_prio(void)
{
        return pal_msbit64_index(_posix_levelmask);
}

/* return (and remove) head of priority level or NULL if level is empty */
extern posix_thread_t*  posix_rq_rm_head(int);
/* remove thread from level */
extern void             posix_rq_rm_thread(posix_thread_t*,int);
/* add thread to tail position */
extern void             posix_rq_add_tail(posix_thread_t*, int);
/* add thread to head position */
extern void             posix_rq_add_head(posix_thread_t*, int);

#endif

