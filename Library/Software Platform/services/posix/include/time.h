/******************************************************************************
 * FILE:        time.h
 * DESCRIPTION:
 *      posix time.h interface
 *****************************************************************************/
#ifndef _TIME_H
#define _TIME_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <limits.h>
#include <sys/types.h>

/* Time expressed as seconds and fractions of a second + operations on it. */
struct bintime {
    time_t  sec;
    uint64_t frac;
};

struct itimerspec {
        /* timer period */
        struct timespec it_interval;    
        /* timer expiration */
        struct timespec it_value;
};

typedef unsigned long long      clock_t;
extern  clock_t     clock(void);

#define TIME_MAX (time_t)(-1)
#define TIME_MIN (time_t)(0)

/* starting point for calendar times
 * time is measured in seconds since 
 * 1 January 1970 
 */
#define _BIAS_TIME ((70 * 365LU + 17) * 86400)

#ifndef CLOCKS_PER_SEC
# define CLOCKS_PER_SEC  ((clock_t)__clocks_per_sec)    /* resolution of clock() */
#endif
extern  clock_t         __clocks_per_sec;

#ifndef _STRUCT_TM
#define _STRUCT_TM

struct tm
{
        int     tm_sec;         /* seconds after the minute - [0, 59]   */
        int     tm_min;         /* minutes after the hour - [0, 59]     */
        int     tm_hour;        /* hours since midnight - [0, 23]       */
        int     tm_mday;        /* day of the month - [1, 31]           */
        int     tm_mon;         /* months since January - [0, 11]       */
        int     tm_year;        /* year since 1900                      */
        int     tm_wday;        /* days since Sunday - [0, 6]           */
        int     tm_yday;        /* days since January 1 - [0, 365]      */
        int     tm_isdst;       /* Daylight Saving Time flag            */
};

#endif /*_STRUCT_TM */

extern  char      * asctime(const struct tm *);
extern  char      * ctime(const time_t *);
extern  double      difftime(time_t, time_t);
extern  struct tm * gmtime(const time_t *);
extern  struct tm * localtime(const time_t *);
extern  time_t      time(time_t *);
extern  time_t      mktime(struct tm *);
extern  clock_t     clock(void);
extern  void        _timer_start(void);         /* start timer */
extern  clock_t     _timer_stop(void);          /* stop timer, return elapsed time */
extern  size_t      strftime(char * restrict, size_t, const char * restrict,
                             const struct tm * restrict);

extern  void        _stime(time_t *);           /* sets system time */
extern  int         _tzset(const char *);       /* sets time zone */

#include <signal.h>

/* identifier of the system-wide realtime clock */
#define CLOCK_REALTIME                          0

/* identifier of the system-wide monotonic clock */
#define CLOCK_MONOTONIC                         1

#if ( (__POSIX_KERNEL__>0) && (__POSIX_THREAD_CPUTIME != 0) )
/* identifier of the CPU-time clock associated with the thread making a 
 * clock() or timer*() function call CPU-time clock of the calling thread */ 
#define CLOCK_THREAD_CPUTIME_ID                 2
#endif

/* Flag indicating time is absolute */
#define TIMER_ABSTIME           1

#if ( (__POSIX_KERNEL__>0) && (__POSIX_TIMERS != 0) )

/* creation */
extern int timer_create( clockid_t clock_id,
                         struct sigevent *evp,
                         timer_t *timer_id);
extern int timer_delete( timer_t timer_id );
/* set get */
extern int clock_settime( clockid_t clock_id, const struct timespec *tp);
extern int clock_gettime( clockid_t clock_id, struct timespec *tp);
extern int clock_getres( clockid_t clock_id, struct timespec *tp);
extern int timer_gettime( timer_t timerid, struct itimerspec *value );
extern int timer_getoverrun( timer_t timerid );
extern int timer_settime( timer_t timerid, int flags,
                             const struct itimerspec *value,
                             struct itimerspec *ovalue );
/* nanosleep */
extern int nanosleep( const struct timespec *rqtp,
                      struct timespec *rmtp);

#if (__POSIX_CLOCK_SELECTION!=0)
extern int clock_nanosleep(clockid_t clock_id, int flags,
       const struct timespec *rqtp, struct timespec *rmtp);
#endif

#endif

#ifdef  __cplusplus
}
#endif

#endif


