/******************************************************************************
 * FILE:        %W% %E%
 * DESCRIPTION:
 *      sys/uio.h - definitions for vector I/O operations
 *****************************************************************************/
#ifndef _UIO_H
#define _UIO_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <sys/types.h>

/*
 * TODO
 *      The implementation can put a limit on the number of scatter/gather
 *      elements which can be processed in one call. The symbol {IOV_MAX}
 *      defined in <limits.h> should always be used to learn about the limits
 *      instead of assuming a fixed value.
 */

struct iovec {
        void    *iov_base;      /* Base address of a memory region for input or output. */
        size_t  iov_len;        /* The size of the memory pointed to by iov_base. */
};

extern ssize_t readv(int, const struct iovec *, int);
extern ssize_t writev(int, const struct iovec *, int);

#ifdef  __cplusplus
}
#endif

#endif /* ndef _UIO_H */

