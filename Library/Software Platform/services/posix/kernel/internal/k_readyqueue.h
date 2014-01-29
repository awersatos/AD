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

/* return 'true' if the priority level is empty */
extern bool             posix_rq_empty(int level);
/* calculates the highest populated priority level */
extern int              posix_rq_high_prio(void);
/* return (and remove) head of priority level or NULL if level is empty */
extern posix_thread_t   *posix_rq_rm_head(int pri);
/* remove thread from priority level */
extern void             posix_rq_rm_thread(posix_thread_t *thread, int pri);
/* add thread to tail position */
extern void             posix_rq_add_tail(posix_thread_t *thread, int pri);
/* add thread to head position */
extern void             posix_rq_add_head(posix_thread_t *thread, int pri);

#endif

