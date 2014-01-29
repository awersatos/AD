/*
 *      %W% %E%
 *
 * NAME
 *      sys/time.h - time types
 *
 * SYNOPSIS
 *      [XSI] [Option Start] #include <sys/time.h> [Option End]
 */

#ifndef _SYS_TIME_H
#define _SYS_TIME_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <sys/types.h>


struct timeval {
        time_t          tv_sec;         /* Seconds. */
        suseconds_t     tv_usec;        /* Microseconds. */
};

struct itimerval {
        struct timeval  it_interval;    /* Timer interval. */
        struct timeval  it_value;       /* Current value. */
};

#define ITIMER_REAL     0
        /* Decrements in real time. */

#define ITIMER_VIRTUAL  1
        /* Decrements in process virtual time. */

#define ITIMER_PROF     2
        /* Decrements both in process virtual time and when the system is running on behalf of the process. */

#include <sys/select.h>

extern int      getitimer(int, struct itimerval *);
extern int      gettimeofday(struct timeval *restrict, void *restrict);
extern int      select(int, fd_set *restrict, fd_set *restrict, fd_set *restrict, struct timeval *restrict);
extern int      setitimer(int, const struct itimerval *restrict, struct itimerval *restrict);
extern int      utimes(const char *, const struct timeval [2]); /* (LEGACY ) */

#ifdef  __cplusplus
}
#endif

#endif /* ndef _SYS_TIME_H */

