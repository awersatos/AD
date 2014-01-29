/******************************************************************************
 * FILE:        @(#)posix_main.h        1.8 06/07/11
 * DESCRIPTION:
 *      'posix_main' prototypes
 *****************************************************************************/
#ifndef _H_POSIX_MAIN
#define _H_POSIX_MAIN

#include <limits.h>
#include "kconf.h"

#define _IDLE_THREAD_ID                         0
#define _MAIN_THREAD_ID                         1
#define _POSIX_KERNEL_THREAD                    2
#define _LAST_THREAD_ID                         _POSIX_KERNEL_THREAD

#define __POSIX_IDLE_PRIORITY                   POSIX_MIN_SCHED_PRIORITY
#define __POSIX_KERNEL_THREAD_PRIORITY          POSIX_MAX_SCHED_PRIORITY
#define __POSIX_KERNEL_THREAD_STACK             1000

/* timers deferred entry point */
extern void    posix_signals_thread_code(void);

#endif


