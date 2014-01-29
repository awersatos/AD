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

#define SEM_FAILED      ((sem_t *)NULL)

typedef struct sem_t
{
        uintptr_t       sem_value; 
} sem_t;


extern int sem_init  (sem_t *sem, int pshared, unsigned int value);
extern int sem_destroy  (sem_t *sem);
extern int sem_wait  (sem_t *sem);
extern int sem_timedwait(sem_t * sem,
       const struct timespec * abs_timeout);
extern int sem_trywait  (sem_t *sem);
extern int sem_post  (sem_t *sem);
extern int sem_getvalue  (sem_t *sem, int *sval);
extern sem_t *sem_open  (const char *name, int oflag, ...);
extern int sem_close  (sem_t *sem);
extern int sem_unlink  (const char *name);


#ifdef  __cplusplus
}
#endif

#endif
