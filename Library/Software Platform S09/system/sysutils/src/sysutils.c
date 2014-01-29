/******************************************************************************
|*
|*  COPYRIGHT:          Copyright 2008, Altium
|*
|*  DESCRIPTION:        Utility functions for threading support.
|*
\******************************************************************************/

#if __POSIX_KERNEL__ != 0
#include <pthread.h>
#endif

extern void devsync_cleanup_mutexlock ( void * arg )
{
#if __POSIX_KERNEL__ != 0
    pthread_mutex_unlock ( (pthread_mutex_t*) arg );
#endif
}
