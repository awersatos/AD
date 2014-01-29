/******************************************************************************
 * FILE:        @(#)fcntl.h     1.2 07/02/21
 * DESCRIPTION:
 *      posix 'fcntl.h' interface
 *****************************************************************************/
#ifndef _FCNTL_H
#define _FCNTL_H

#include <sys/types.h>

#ifdef  __cplusplus
extern "C" {
#endif  /* defined(__cplusplus) */

/* open(2) flags -- compatible with standard TASKING C library, as well as newlib */
#define O_RDONLY        0x0000  /* read only -- NOTE: O_RDONLY is defined as the absence of any flags! To test, use: (flags & O_ACCMODE) == O_RDONLY */
#define O_WRONLY        0x0001  /* write only */
#define O_RDWR          0x0002  /* read and write */
#define O_NDELAY        0x0004  /* non blocking I/O */
#define O_APPEND        0x0008  /* append mode */
#define O_SYNC          0x0010  /* synchronized file update */
#define O_NONBLOCK      0x0080  /* non blocking I/O */
#define O_CREAT         0x0100  /* create file */
#define O_TRUNC         0x0200  /* truncate file */
#define O_EXCL          0x0400  /* exclusive open */
#define O_NOCTTY        0x0800  /* don't allocate controlling tty */
#define O_BINARY        0x8000  /* binary file */

#define O_ACCMODE       (O_RDONLY|O_WRONLY|O_RDWR)

/*
 * Values for cmd used by fcntl() (the following values are unique) are as follows:
 */
#define F_DUPFD     0   /* Duplicate file descriptor.   */
#define F_GETFD     1   /* Get file descriptor flags.   */
#define F_SETFD     2   /* Set file descriptor flags.   */
#define F_GETFL     3   /* Get file status flags and file access modes. */
#define F_SETFL     4   /* Set file status flags.   */
#define F_GETOWN    5   /* Get process or process group ID to receive SIGURG signals.   */
#define F_SETOWN    6   /* Set process or process group ID to receive SIGURG signals.   */
#define F_GETLK     7   /* Get record locking information.  */
#define F_SETLK     8   /* Set record locking information.  */
#define F_SETLKW    9   /* Set record locking information; wait if blocked. */

/*
 * File descriptor flags used for fcntl() are as follows:
 */
#define FD_CLOEXEC  1   /* Close the file descriptor upon execution of an exec family function. */

/*
 * Values for l_type used for record locking with fcntl() (the following values are unique) are as follows:
 */
#define F_RDLCK     1   /* Shared or read lock.         */
#define F_WRLCK     2   /* Exclusive or write lock.     */
#define F_UNLCK     3   /* Unlock.              */

#define F_WAIT      0x010   /* Wait until lock is granted       */
#define F_FLOCK     0x020   /* Use flock(2) semantics for lock  */
#define F_POSIX     0x040   /* Use POSIX semantics for lock     */

/* extra posix flags, not in the standard TASKING C library */
#if SIO_SYNCHRONIZED_INPUT_AND_OUTPUT
#define O_DSYNC     (1<<16)  /* Write according to synchronized I/O data integrity completion.   */
#define O_RSYNC     (1<<17)  /* Synchronized read I/O operations.    */
#define FMASK   (O_RDONLY|O_RDWR|O_WRONLY|O_APPEND|O_DSYNC|O_RSYNC|O_SYNC|O_NONBLOCK);
#else
#define FMASK   (O_RDONLY|O_RDWR|O_WRONLY|O_APPEND|O_SYNC|O_NONBLOCK);
#endif


#if ADV_ADVISORY_INFORMATION
/*
 * Values for advice used by posix_fadvise() are as follows:
 */
#define POSIX_FADV_NORMAL   1
#define POSIX_FADV_SEQUENTIAL   2
#define POSIX_FADV_RANDOM   3
#define POSIX_FADV_WILLNEED 4
#define POSIX_FADV_DONTNEED 5
#define POSIX_FADV_NOREUSE  6
#endif /**/

/*
 * The structure flock describes a file lock. It shall include the following members:
 */

struct flock {
    short   l_type;     /* Type of lock; F_RDLCK, F_WRLCK, F_UNLCK. */
    short   l_whence;   /* Flag for starting offset.            */
    off_t   l_start;    /* Relative offset in bytes.            */
    off_t   l_len;      /* Size; if 0 then until EOF.           */
    pid_t   l_pid;      /* Process ID of the process holding the lock; returned with F_GETLK.   */
};

extern int  creat(const char *, mode_t);
extern int  fcntl(int, int, ...);
extern int  open(const char *, int, ...);
#if ADV_ADVISORY_INFORMATION
extern int  posix_fadvise(int, off_t, off_t, int);
extern int  posix_fallocate(int, off_t, off_t);
#endif

#ifdef  __cplusplus
}
#endif /* defined(__cplusplus) */

#endif /* _FCNTL_H */
