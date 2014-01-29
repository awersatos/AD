/*****************************************************************************
 *      %W% %E%
 *
 * NAME
 *
 *      sys/select.h - select types
 *
 * SYNOPSIS
 *
 *      #include <sys/select.h>
 ****************************************************************************/

#ifndef _SYS_SELECT_H
#define _SYS_SELECT_H

#ifdef  __cplusplus
extern "C" {
#endif

//#ifdef POSIX_EVENT_MGMT


#include <sys/types.h>
#include <limits.h>
#include <signal.h>
#include <time.h>


//struct timeval
//{
//      time_t          tv_sec;         /* Seconds. */
//      suseconds_t     tv_usec;        /* Microseconds. */
//};

/*
 * The following shall be defined as a macro:
 */
/*
 * Maximum number of file descriptors in an fd_set structure.
 */
#define FD_SETSIZE      _POSIX_OPEN_MAX

/*
 * The <sys/select.h> header shall define the fd_set type as a structure.
 */
typedef struct {
        unsigned int    fds[FD_SETSIZE/sizeof(unsigned int)+1];
} fd_set;

/*
 * Each of the following may be declared as a function, or defined as a macro, or both:
 */
/*
 * Clears the bit for the file descriptor fd in the file descriptor set fdset.
 */
inline void FD_CLR(int fd, fd_set *fdset)
{
        if (fdset != NULL && fd >=0 && fd < FD_SETSIZE)
        {
                fdset->fds[fd/sizeof(fdset->fds[0])] &= ~(1<<(fd%sizeof(fdset->fds[0])));
        }
}

/*
 * Returns a non-zero value if the bit for the file descriptor fd is set in the file descriptor set by fdset, and 0 otherwise.
 */
inline int FD_ISSET(int fd, fd_set *fdset)
{
        if (fdset != NULL && fd >=0 && fd < FD_SETSIZE)
        {
                return fdset->fds[fd/sizeof(fdset->fds[0])] & (1<<(fd%sizeof(fdset->fds[0])));
        }
        return 0;
}

/*
 * Sets the bit for the file descriptor fd in the file descriptor set fdset.
 */
inline void FD_SET(int fd, fd_set *fdset)
{
        if (fdset != NULL && fd >=0 && fd < FD_SETSIZE)
        {
                fdset->fds[fd/sizeof(fdset->fds[0])] |= (1<<(fd%sizeof(fdset->fds[0])));
        }
}

/*
 * Initializes the file descriptor set fdset to have zero bits for all file descriptors.
 */
inline void FD_ZERO(fd_set *fdset)
{
        for (int i = 0; i < FD_SETSIZE/sizeof(unsigned int)+1; i++)
        {
                fdset->fds[i] = 0;
        }
}

#include <sys/time.h>

/*
 * The following shall be declared as functions and may also be defined as macros. Function prototypes shall be provided.
 */
extern int      pselect(int, fd_set *restrict, fd_set *restrict, fd_set *restrict,
                        const struct timespec *restrict, const sigset_t *restrict);
extern int      select(int, fd_set *restrict, fd_set *restrict, fd_set *restrict,
                        struct timeval *restrict);


//#endif /* POSIX_EVENT_MGMT */

#ifdef  __cplusplus
}
#endif

#endif /* ndef _SYS_SELECT_H */

