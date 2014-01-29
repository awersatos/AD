/******************************************************************************
 * FILE:        @(#)semaphore.h 1.3 05/10/17
 * DESCRIPTION:
 *      posix semaphores interface
 *****************************************************************************/
#ifndef _H_SEMAPHORE
#define _H_SEMAPHORE

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <time.h>

#define SEM_FAILED      ((sem_t *)NULL)

typedef struct sem_t
{
        int value;
        pthread_mutex_t mutex;
        pthread_cond_t cond;
} sem_t;

extern int sem_init(sem_t *sem, int pshared, unsigned value);
extern sem_t *sem_open(const char *name, int oflag, ...);
extern int sem_close(sem_t *sem);
extern int sem_destroy(sem_t *sem);
extern int sem_getvalue(sem_t *restrict sem, int *restrict sval);
extern int sem_post(sem_t *sem);
extern int sem_unlink(const char *name);
extern int sem_wait(sem_t *sem);
extern int sem_trywait(sem_t *sem);
#if ( __POSIX_TIMEOUTS != 0 )
extern int sem_timedwait(sem_t *restrict sem,
       const struct timespec *restrict abs_timeout);
#endif

#ifdef  __cplusplus
}
#endif

#endif
