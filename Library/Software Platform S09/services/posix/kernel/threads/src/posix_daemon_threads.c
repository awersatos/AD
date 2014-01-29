/******************************************************************************
 * FILE:        @(#)posix_pthread.c     1.40 07/06/06
 * DESCRIPTION:
 *      posix daemon pthreads installation
 *****************************************************************************/
#include <pthread.h>

#if ( POSIX_THREADS_INSTANCE_COUNT > 0 )
#include "posix_threads_cfg_instance.h"
#endif


void posix_daemon_threads(void)
{

#if ( POSIX_THREADS_INSTANCE_COUNT > 0 )

	int i;
    struct sched_param              schedparam;
    posix_threads_cfg_instance_t*   daemon;
    pthread_attr_t attr;

    for ( i=0; i < POSIX_THREADS_INSTANCE_COUNT; i++ )
    {
        daemon = &posix_threads_instance_table[i];

        schedparam.sched_priority = daemon->priority;
        pthread_attr_init( &attr );
        pthread_attr_setinheritsched(&attr,  PTHREAD_EXPLICIT_SCHED);
        pthread_attr_setschedparam  ( &attr, &schedparam );
        pthread_attr_setstacksize   ( &attr, daemon->stacksize );
        pthread_attr_setschedpolicy ( &attr, daemon->schedpolicy);

        if ( pthread_create( NULL, &attr,  daemon->startroutine, NULL ) != 0 )
            return;

    }

#endif
    return;

}



