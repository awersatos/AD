/******************************************************************************
 * FILE:        @(#)mman.h      1.5 06/06/09
 * DESCRIPTION:
 *      mman.h posix interface
 *****************************************************************************/
#ifndef _MMAN_H
#define _MMAN_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <limits.h>
#include <unistd.h>
#include <sys/types.h>

/* protection options */
#define PROT_READ   0x1     /* page can be read */
#define PROT_WRITE  0x2     /* page can be written */
#define PROT_EXEC   0x4     /* page can be executed */
#define PROT_NONE   0x0     /* page can not be accessed */

/* flag options */
#define MAP_SHARED  0x01        /* Share changes */
#define MAP_PRIVATE 0x02        /* Changes are private */
#define MAP_FIXED   0x10        /* Interpret addr exactly */    
/* mlockall */
#define MCL_CURRENT 1   /* lock all current mappings */
#define MCL_FUTURE  2

/* mmap failure */
#define MAP_FAILED      ((void *) -1)

#if (__POSIX_MEMLOCK != 0)
extern int mlockall(int flags);
extern int munlockall(void);
#endif
#if (__POSIX_MEMLOCK_RANGE != 0)
extern int mlock(const void *addr, size_t len);
extern int munlock(const void *addr, size_t len);
#endif
#if (__POSIX_SHARED_MEMORY_OBJECTS != 0)
extern void *mmap(void *addr, size_t len, int prot, int flags,
       int fildes, off_t off);
extern int munmap(void *addr, size_t len);
extern int shm_open(const char *name, int oflag, mode_t mode);
extern int shm_unlink(const char *name);
#endif
#if (__POSIX_SYNCHRONIZED_IO != 0)
extern int msync(void* start, size_t length, int flags);
#endif

#ifdef  __cplusplus
}
#endif

#endif /* _MMAN_H */
