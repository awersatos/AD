/******************************************************************************
 * FILE:        @(#)synchronized.c      1.2 06/06/09
 * DESCRIPTION:
 *      dummy interfaces for option requirements:
 *              _POSIX_SYNCHRONIZED_IO
 *      they are defined only for source upwards compatibility
 *      in pse51 systems all device i/o is synchronous by default
 *****************************************************************************/
#include <unistd.h>
#include <sys/mman.h>

#if (__POSIX_SYNCHRONIZED_IO != 0)
int fdatasync(int fildes) { (void) fildes; return 0; }
int msync(void *addr,size_t len, int flags) { (void)addr;(void)len;(void)flags; return 0; }
#endif

