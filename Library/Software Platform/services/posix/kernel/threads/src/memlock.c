/******************************************************************************
 * FILE:        @(#)memlock.c   1.2 06/06/09
 * DESCRIPTION:
 *      dummy interfaces for option requirements:
 *              _POSIX_MEMLOCK
 *              _POSIX_MEMLOCK_RANGE
 *      they are defined for source upwards compatibility
 *      (in PSE51 systems there is no MMU)
 *****************************************************************************/
#include <sys/mman.h>

#if (__POSIX_MEMLOCK != 0)
int mlockall(int flags){(void)flags;return 0;}
int munlockall(void){return 0;}
#endif

#if (__POSIX_MEMLOCK_RANGE != 0)
int mlock(const void *addr, size_t len){(void)addr;(void)len;return 0;}
int munlock(const void *addr, size_t len){(void)addr;(void)len;return 0;}
#endif


