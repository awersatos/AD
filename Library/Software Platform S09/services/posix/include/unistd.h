/******************************************************************************
 * FILE:        @(#)unistd.h    1.8 07/03/13
 * DESCRIPTION:
 *      standard symbolic constants and types
 *****************************************************************************/         
#ifndef _UNISTD_H
#define _UNISTD_H

#include <sys/types.h>
#include <limits.h>

/* version of IEEE Std 1003.1 */
#define _POSIX_VERSION                          200112L

/* conformance to the Minimal Realtime System Profile */
#define _POSIX_AEP_REALTIME_MINIMAL             200312L

/* conformance to the POSIX.26 */
#define _POSIX_26_VERSION                       200312L

/* presence of C development environment */
#define _POSIX_AEP_REALTIME_LANG_C99

/* system configuration */

#define _POSIX2_C_BIND                          200112L
#define _POSIX2_C_DEV                           200112L
#define _POSIX2_SW_DEV                          200112L

/* not supported option requirements in PSE51 Profile */
#define _POSIX_ADVISORY_INFO                    -1
#define _POSIX_ASYNCHRONOUS_IO                  -1
#define _POSIX_BARRIERS                         -1
#define _POSIX_CHOWN_RESTRICTED                 -1
#define _POSIX_CPUTIME                          -1
#define _POSIX_IPV6                             -1
#define _POSIX_JOB_CONTROL                      -1
#define _POSIX_MEMORY_PROTECTION                -1              
#define _POSIX_NO_TRUNC                         -1
#define _POSIX_PRIORITIZED_IO                   -1
#define _POSIX_PRIORITY_SCHEDULING              -1
#define _POSIX_RAW_SOCKETS                      -1
#define _POSIX_READER_WRITER_LOCKS              -1
#define _POSIX_REGEXP                           -1
#define _POSIX_SAVED_IDS                        -1
#define _POSIX_SHELL                            -1
#define _POSIX_SPAWN                            -1
#define _POSIX_SPIN_LOCKS                       -1
#define _POSIX_THREAD_PROCESS_SHARED            -1
#define _POSIX_THREAD_SAFE_FUNCTIONS            -1
#define _POSIX_TRACE                            -1
#define _POSIX_TRACE_EVENT_FILTER               -1
#define _POSIX_TRACE_INHERIT                    -1
#define _POSIX_TRACE_LOG                        -1
#define _POSIX_TYPED_MEMORY_OBJECTS             -1
#define _POSIX_VDISABLE                         -1
#define _POSIX_SEMAPHORES                       -1
#define _POSIX_FSYNC                            -1

/* configurable option requirements (profiling) */

#if ( __POSIX_MESSAGE_PASSING==0 )
#define _POSIX_MESSAGE_PASSING                  -1
#else
#define _POSIX_MESSAGE_PASSING                  200112L
#endif

#if ( __POSIX_MAPPED_FILES==0 )
#define _POSIX_MAPPED_FILES                     -1
#else
#define _POSIX_MAPPED_FILES                     200112L
#endif

#if ( __POSIX_CLOCK_SELECTION==0 )
#define _POSIX_CLOCK_SELECTION                  -1
#else
#define _POSIX_CLOCK_SELECTION                  200112L
#endif

#if ( __POSIX_MEMLOCK==0 )
#define _POSIX_MEMLOCK                          -1
#else
#define _POSIX_MEMLOCK                          200112L
#endif

#if ( __POSIX_MEMLOCK_RANGE==0 )
#define _POSIX_MEMLOCK_RANGE                    -1
#else
#define _POSIX_MEMLOCK_RANGE                    200112L
#endif

#if (  __POSIX_REALTIME_SIGNALS==0 )
#define _POSIX_REALTIME_SIGNALS                 -1
#else
#define _POSIX_REALTIME_SIGNALS                 200112L
#endif

#if (  __POSIX_SHARED_MEMORY_OBJECTS==0 )
#define _POSIX_SHARED_MEMORY_OBJECTS            -1
#else
#define _POSIX_SHARED_MEMORY_OBJECTS            200112L
#endif

#if (  __POSIX_SYNCHRONIZED_IO==0 )
#define _POSIX_SYNCHRONIZED_IO                  -1
#else
#define _POSIX_SYNCHRONIZED_IO                  200112L
#endif

#if (  __POSIX_THREAD_ATTR_STACKADDR==0 )
#define _POSIX_THREAD_ATTR_STACKADDR            -1
#else
#define _POSIX_THREAD_ATTR_STACKADDR            200112L
#endif

#if (  __POSIX_THREAD_ATTR_STACKSIZE==0 )
#define _POSIX_THREAD_ATTR_STACKSIZE            -1
#else
#define _POSIX_THREAD_ATTR_STACKSIZE            200112L
#endif

#if (  __POSIX_THREAD_CPUTIME==0 )
#define _POSIX_THREAD_CPUTIME                   -1
#else
#define _POSIX_THREAD_CPUTIME                   200112L
#endif

#if (  __POSIX_THREAD_PRIO_INHERIT==0 )
#define _POSIX_THREAD_PRIO_INHERIT              -1
#else
#define _POSIX_THREAD_PRIO_INHERIT              200112L
#endif

#if (  __POSIX_THREAD_PRIO_PROTECT==0 )
#define _POSIX_THREAD_PRIO_PROTECT              -1
#else
#define _POSIX_THREAD_PRIO_PROTECT              200112L
#endif

#if (  __POSIX_THREAD_SPORADIC_SERVER==0 )
#define _POSIX_THREAD_SPORADIC_SERVER           -1
#else
#define _POSIX_THREAD_SPORADIC_SERVER           200112L
#endif

#if (  __POSIX_TIMEOUTS==0 )
#define _POSIX_TIMEOUTS                         -1
#else
#define _POSIX_TIMEOUTS                         200112L
#endif

#if ( __POSIX_TIMERS==0 )
#define _POSIX_TIMERS                           -1
#else
#define _POSIX_TIMERS                           200112L
#endif



/* the option shall always be supported when the 
 * application is executed */ 
#define _POSIX_THREADS                          200112L 
#define _POSIX_THREAD_PRIORITY_SCHEDULING       200112L
#define _POSIX_MONOTONIC_CLOCK                  200112L


/* mode definitions for acess() */
#define R_OK    4               
#define W_OK    2               
#define X_OK    1               
#define F_OK    0               

/* constants for lseek */
#ifndef SEEK_SET
#define SEEK_SET        0
#define SEEK_CUR        1
#define SEEK_END        2
#endif 

/* symbolic constants for file streams */
#define STDIN_FILENO    0
#define STDOUT_FILENO   1
#define STDERR_FILENO   2

/* Variable names for sysconf()         */
#define _SC_ADVISORY_INFO                       1
#define _SC_AIO_LISTIO_MAX                      2
#define _SC_AIO_MAX                             3
#define _SC_AIO_PRIO_DELTA_MAX                  4
#define _SC_ARG_MAX                             5
#define _SC_ASYNCHRONOUS_IO                     6
#define _SC_ATEXIT_MAX                          7
#define _SC_BARRIERS                            8
#define _SC_BC_BASE_MAX                         9
#define _SC_BC_DIM_MAX                          10
#define _SC_BC_SCALE_MAX                        11
#define _SC_BC_STRING_MAX                       12
#define _SC_CHILD_MAX                           13
#define _SC_CLK_TCK                             14
#define _SC_CLOCK_SELECTION                     15
#define _SC_COLL_WEIGHTS_MAX                    15
#define _SC_CPUTIME                             16
#define _SC_DELAYTIMER_MAX                      17
#define _SC_EXPR_NEST_MAX                       18
#define _SC_FSYNC                               19
#define _SC_GETGR_R_SIZE_MAX                    20
#define _SC_GETPW_R_SIZE_MAX                    21
#define _SC_HOST_NAME_MAX                       22
#define _SC_IOV_MAX                             23
#define _SC_IPV6                                24
#define _SC_JOB_CONTROL                         25
#define _SC_LINE_MAX                            26
#define _SC_LOGIN_NAME_MAX                      27
#define _SC_MAPPED_FILES                        28
#define _SC_MEMLOCK                             29
#define _SC_MEMLOCK_RANGE                       30
#define _SC_MEMORY_PROTECTION                   31
#define _SC_MESSAGE_PASSING                     32
#define _SC_MONOTONIC_CLOCK                     33
#define _SC_MQ_OPEN_MAX                         34
#define _SC_MQ_PRIO_MAX                         35
#define _SC_NGROUPS_MAX                         36
#define _SC_OPEN_MAX                            37
#define _SC_PAGE_SIZE                           38
#define _SC_PAGESIZE                            39
#define _SC_PRIORITIZED_IO                      40
#define _SC_PRIORITY_SCHEDULING                 41
#define _SC_RAW_SOCKETS                         42
#define _SC_RE_DUP_MAX                          43
#define _SC_READER_WRITER_LOCKS                 44
#define _SC_REALTIME_SIGNALS                    45
#define _SC_REGEXP                              46
#define _SC_RTSIG_MAX                           47
#define _SC_SAVED_IDS                           48
#define _SC_SEM_NSEMS_MAX                       49
#define _SC_SEM_VALUE_MAX                       50
#define _SC_SEMAPHORES                          51
#define _SC_SHARED_MEMORY_OBJECTS               52
#define _SC_SHELL                               53
#define _SC_SIGQUEUE_MAX                        54
#define _SC_SPAWN                               55
#define _SC_SPIN_LOCKS                          56
#define _SC_SPORADIC_SERVER                     57
#define _SC_SS_REPL_MAX                         58
#define _SC_STREAM_MAX                          59
#define _SC_SYMLOOP_MAX                         60
#define _SC_SYNCHRONIZED_IO                     61
#define _SC_THREAD_ATTR_STACKADDR               62
#define _SC_THREAD_ATTR_STACKSIZE               63
#define _SC_THREAD_CPUTIME                      64
#define _SC_THREAD_DESTRUCTOR_ITERATIONS        65
#define _SC_THREAD_KEYS_MAX                     66
#define _SC_THREAD_PRIO_INHERIT                 67
#define _SC_THREAD_PRIO_PROTECT                 68
#define _SC_THREAD_PRIORITY_SCHEDULING          69
#define _SC_THREAD_PROCESS_SHARED               70
#define _SC_THREAD_SAFE_FUNCTIONS               71
#define _SC_THREAD_SPORADIC_SERVER              72
#define _SC_THREAD_STACK_MIN                    73
#define _SC_THREAD_THREADS_MAX                  74
#define _SC_THREADS                             75
#define _SC_TIMEOUTS                            76
#define _SC_TIMER_MAX                           77
#define _SC_TIMERS                              78
#define _SC_TRACE                               79
#define _SC_TRACE_EVENT_FILTER                  80
#define _SC_TRACE_EVENT_NAME_MAX                81
#define _SC_TRACE_INHERIT                       82
#define _SC_TRACE_LOG                           83
#define _SC_TRACE_NAME_MAX                      84
#define _SC_TRACE_SYS_MAX                       85
#define _SC_TRACE_USER_EVENT_MAX                86
#define _SC_TTY_NAME_MAX                        87
#define _SC_TYPED_MEMORY_OBJECTS                88
#define _SC_TZNAME_MAX                          89
#define _SC_V6_ILP32_OFF32                      90
#define _SC_V6_ILP32_OFFBIG                     91
#define _SC_V6_LP64_OFF64                       92
#define _SC_V6_LPBIG_OFFBIG                     93
#define _SC_VERSION                             94
#define _SC_2_C_BIND                            95
#define _SC_2_C_DEV                             96
#define _SC_2_SW_DEV                            97
#define _SC_POSIX_26_VERSION                    98


/* Variable names for pathconf() */
#define _PC_2_SYMLINKS                          1
#define _PC_ALLOC_SIZE_MIN                      2
#define _PC_ASYNC_IO                            3
#define _PC_CHOWN_RESTRICTED                    4
#define _PC_FILESIZEBITS                        5
#define _PC_LINK_MAX                            6
#define _PC_MAX_CANON                           7
#define _PC_MAX_INPUT                           8
#define _PC_NAME_MAX                            9
#define _PC_NO_TRUNC                            10
#define _PC_PATH_MAX                            11
#define _PC_PIPE_BUF                            12
#define _PC_PRIO_IO                             13
#define _PC_REC_INCR_XFER_SIZE                  14
#define _PC_REC_MIN_XFER_SIZE                   15
#define _PC_REC_XFER_ALIGN                      16
#define _PC_SYMLINK_MAX                         17
#define _PC_SYNC_IO                             18
#define _PC_VDISABLE                            19

/* Standard function prototypes */

#ifdef __cplusplus
extern "C" {
#endif


extern int              access(const char *, int);
extern unsigned int     alarm(unsigned);
extern int              chdir(const char *);
extern int              chown(const char *, uid_t, gid_t);
extern int              close(int);
extern size_t           confstr(int, char *, size_t);
extern int              dup(int);
extern int              dup2(int, int);
extern int              execl(const char *, const char *, ...);
extern int              execle(const char *, const char *, ...);
extern int              execlp(const char *, const char *, ...);
extern int              execv(const char *, char *const []);
extern int              execve(const char *, char *const [], char *const []);
extern int              execvp(const char *, char *const []);
extern void            _exit(int);
extern int              fchown(int, uid_t, gid_t);
extern int              fdatasync(int);
extern pid_t            fork(void);
extern long             fpathconf(int, int);
extern int              fsync(int);
extern int              ftruncate(int, off_t);
extern char            *getcwd(char *, size_t);
extern gid_t            getegid(void);
extern uid_t            geteuid(void);
extern gid_t            getgid(void);
extern int              getgroups(int, gid_t []);
extern int              gethostname(char *, size_t);
extern char            *getlogin(void);
extern int              getlogin_r(char *, size_t);
extern int              getopt(int, char * const [], const char*);
extern pid_t            getpgrp(void);
extern pid_t            getpid(void);
extern pid_t            getppid(void);
extern uid_t            getuid(void);
extern int              isatty(int);
extern int              link(const char *, const char *);
extern off_t            lseek(int, off_t, int);
extern long             pathconf(const char *, int);
extern int              pause(void);
extern int              pipe(int [2]);
extern ssize_t          read(int, void *, size_t);
extern ssize_t          readlink(const char *restrict, char *restrict, size_t);
extern int              rmdir(const char *);
extern int              setegid(gid_t);
extern int              seteuid(uid_t);
extern int              setgid(gid_t);
extern int              setpgid(pid_t, pid_t);
extern pid_t            setsid(void);
extern int              setuid(uid_t);
extern unsigned int     sleep(unsigned int);
extern int              symlink(const char *, const char *);            
extern long             sysconf(int);
extern pid_t            tcgetpgrp(int);
extern int              tcsetpgrp(int, pid_t);
extern char             *ttyname(int);
extern int              ttyname_r(int, char *, size_t);
extern int              unlink(const char *);
extern ssize_t          write(int, const void *, size_t);

#ifdef __cplusplus
}   /* extern "C" */
#endif

#endif 
