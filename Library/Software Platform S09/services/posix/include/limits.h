/******************************************************************************
 * FILE:        @(#)limits.h    1.23 07/03/13
 * DESCRIPTION:
 *      'limits.h' posix interface
 *****************************************************************************/
#ifndef _LIMITS_H
#define _LIMITS_H


/* most restrictive POSIX values (the "at least" values) */
#define _POSIX_AIO_LISTIO_MAX                           2
#define _POSIX_AIO_MAX                                  0
#define _POSIX_ARG_MAX                                  4096
#define _POSIX_CHILD_MAX                                0
#define _POSIX_DELAYTIMER_MAX                           32
#define _POSIX_DEV_MAX                                  1
#define _POSIX_HOST_NAME_MAX                            255
#define _POSIX_LINK_MAX                                 8
#define _POSIX_LOGIN_NAME_MAX                           9
#define _POSIX_MAX_CANON                                255
#define _POSIX_MAX_INPUT                                255
#define _POSIX_MQ_OPEN_MAX                              8
#define _POSIX_MQ_PRIO_MAX                              32
#define _POSIX_NAME_MAX                                 14
#define _POSIX_NGROUPS_MAX                              8
#define _POSIX_OPEN_MAX                                 20
#define _POSIX_PATH_MAX                                 256
#define _POSIX_PIPE_BUF                                 512
#define _POSIX_RE_DUP_MAX                               255
#define _POSIX_RTSIG_MAX                                16
#define _POSIX_SCHED_PRIORITY_MAX                       32
#define _POSIX_SCHED_PRIORITY_MIN                       1
#define _POSIX_SEM_NSEMS_MAX                            256
#define _POSIX_SEM_VALUE_MAX                            32767
#define _POSIX_SIGQUEUE_MAX                             32
#define _POSIX_SSIZE_MAX                                32767
#define _POSIX_STREAM_MAX                               8
#define _POSIX_SS_REPL_MAX                              4
#define _POSIX_SYMLINK_MAX                              255
#define _POSIX_SYMLOOP_MAX                              8
#define _POSIX_THREAD_DESTRUCTOR_ITERATIONS             4
#define _POSIX_THREAD_KEYS_MAX                          16
#define _POSIX_THREAD_THREADS_MAX                       64
#define _POSIX_TIMER_MAX                                8
#define _POSIX_TRACE_EVENT_NAME_MAX                     30
#define _POSIX_TRACE_NAME_MAX                           8
#define _POSIX_TRACE_SYS_MAX                            8
#define _POSIX_TRACE_USER_EVENT_MAX                     32
#define _POSIX_TTY_NAME_MAX                             9
#define _POSIX_TZNAME_MAX                               6
#define _POSIX_CLOCKRES_MIN                             20000000

/* the following are non-configurable values:
 * most of them take their most restrictive values */
#define __POSIX_AIO_LISTIO_MAX              _POSIX_AIO_LISTIO_MAX
#define __POSIX_AIO_MAX                     _POSIX_AIO_MAX
#define __POSIX_ARG_MAX                     _POSIX_ARG_MAX
#define __POSIX_CHILD_MAX                   _POSIX_CHILD_MAX
#define __POSIX_DELAYTIMER_MAX              _POSIX_DELAYTIMER_MAX
#define __POSIX_LINK_MAX                    _POSIX_LINK_MAX
#define __POSIX_HOST_NAME_MAX               _POSIX_HOST_NAME_MAX
#define __POSIX_LINK_MAX                    _POSIX_LINK_MAX
#define __POSIX_LOGIN_NAME_MAX              _POSIX_LOGIN_NAME_MAX
#define __POSIX_MAX_CANON                   _POSIX_MAX_CANON
#define __POSIX_MAX_INPUT                   _POSIX_MAX_INPUT
#define __POSIX_NGROUPS_MAX                 _POSIX_NGROUPS_MAX
#define __POSIX_PIPE_BUF                    _POSIX_PIPE_BUF
#define __POSIX_RE_DUP_MAX                  _POSIX_RE_DUP_MAX
#define __POSIX_RTSIG_MAX                   32
#define __POSIX_SCHED_PRIORITY_MAX          62
#define __POSIX_SCHED_PRIORITY_MIN          1
#define __POSIX_SEM_NSEMS_MAX               _POSIX_SEM_NSEMS_MAX
#define __POSIX_SEM_VALUE_MAX               _POSIX_SEM_VALUE_MAX
#define __POSIX_SSIZE_MAX                   _POSIX_SSIZE_MAX
#define __POSIX_STREAM_MAX                  _POSIX_STREAM_MAX
#define __POSIX_SS_REPL_MAX                 _POSIX_SS_REPL_MAX
#define __POSIX_SYMLINK_MAX                 _POSIX_SYMLINK_MAX
#define __POSIX_SYMLOOP_MAX                 _POSIX_SYMLOOP_MAX
#define __POSIX_TRACE_EVENT_NAME_MAX        _POSIX_TRACE_EVENT_NAME_MAX
#define __POSIX_TRACE_NAME_MAX              _POSIX_TRACE_NAME_MAX
#define __POSIX_TRACE_SYS_MAX               _POSIX_TRACE_SYS_MAX
#define __POSIX_TRACE_USER_EVENT_MAX        _POSIX_TRACE_USER_EVENT_MAX
#define __POSIX_TTY_NAME_MAX                _POSIX_TTY_NAME_MAX
#define __POSIX_TZNAME_MAX                  _POSIX_TZNAME_MAX

#include "limits_cfg.h"

/* number internal posix interrupts */
#define INTERNAL_NUMBER                     PAL_INTERNAL_NUMBER
/* number external posix interrupts */
#define EXTERNAL_NUMBER                     PAL_EXTERNAL_NUMBER
/* total number of posix interrupts */
#define INTR_MAX                            (EXTERNAL_NUMBER+INTERNAL_NUMBER)


/* contributors to __POSIX_THREAD_STACK_MIN :
 * (1)  _THREAD_T_SIZE:         sizeof(_thread_t) (generous)
 * (2)  _ASYNC_STACK:           some extra (generous) space for async handling
 * (3)  _PTHREAD_STACK:         default pthread user's stack size
 * (4)  _HAL_STACK:             hal reserved area to save cpu context
 */
#define _THREAD_T_SIZE                  0xF0
#define _ASYNC_STACK                    0xF0
#define _HAL_STACK                      0xF0
#define __POSIX_THREAD_STACK_MIN        ( _HAL_STACK +          \
                                          _THREAD_T_SIZE +      \
                                          POSIX_THREADS_DEFAULT_STACK_SIZE + \
                                          _ASYNC_STACK )


/* default configuration default values */
#if !defined( POSIX_THREADS_DEFAULT_STACK_SIZE )
#define POSIX_THREADS_DEFAULT_STACK_SIZE        0x300
#endif
#if     !defined(POSIX_MQUEUE_MQ_OPEN_MAX)
#define POSIX_MQUEUE_MQ_OPEN_MAX                _POSIX_MQ_OPEN_MAX
#endif
#if     !defined(POSIX_MQUEUE_MQ_PRIO_MAX)
#define POSIX_MQUEUE_MQ_PRIO_MAX                _POSIX_MQ_PRIO_MAX
#endif
#if     !defined(POSIX_SIGNALS_SIGQUEUE_MAX)
#define POSIX_SIGNALS_SIGQUEUE_MAX              _POSIX_SIGQUEUE_MAX
#endif
#if     !defined(POSIX_THREADS_DESTRUCTOR_ITERATIONS)
#define POSIX_THREADS_DESTRUCTOR_ITERATIONS     _POSIX_THREAD_DESTRUCTOR_ITERATIONS
#endif
#if     !defined(POSIX_THREADS_KEYS_MAX)
#define POSIX_THREADS_KEYS_MAX                  _POSIX_THREAD_KEYS_MAX
#endif
#if     !defined(POSIX_THREADS_THREADS_MAX)
#define POSIX_THREADS_THREADS_MAX               _POSIX_THREAD_THREADS_MAX
#endif
#if     !defined(POSIX_THREADS_TIMER_MAX)
#define POSIX_THREADS_TIMER_MAX                  _POSIX_TIMER_MAX
#endif
#if     !defined(POSIX_DEVIO_DEV_MAX)
#define POSIX_DEVIO_DEV_MAX                     _POSIX_DEV_MAX
#endif
#if !defined(POSIX_THREAD_IRQS_MAX )
#define _POSIX_THREAD_IRQS_MAX                  4
#endif
#if     defined(__POSIX_SHARED_MEMORY_OBJECTS)
#define __POSIX_SHARED_MEMORY_OBJECT_MAX                        16
#else
#define __POSIX_SHARED_MEMORY_OBJECT_MAX                        0
#endif
#if     !defined(POSIX_THREADS_MAIN_STACK_SIZE)
#define POSIX_THREADS_MAIN_STACK_SIZE __POSIX_THREAD_STACK_MIN
#endif
#if     !defined(POSIX_THREADS_MAIN_PRIORITY)
#define POSIX_THREADS_MAIN_PRIORITY   __POSIX_SCHED_PRIORITY_MAX
#endif
#if     !defined(POSIX_THREADS_IDLE_STACK_SIZE)
#define POSIX_THREADS_IDLE_STACK_SIZE __POSIX_THREAD_STACK_MIN
#endif
#if     !defined(POSIX_THREADS_TIMESLICE_MAX)
#define POSIX_THREADS_TIMESLICE_MAX   20
#endif
#if     !defined(POSIX_THREADS_OSTICKMICROSCS)
#define POSIX_THREADS_OSTICKMICROSCS  1000
#endif
#if     !defined(POSIX_THREADS_INTR_STACK_SIZE)
#define POSIX_THREADS_INTR_STACK_SIZE 1000
#endif

#if !defined(__XSI_THREAD_EXIT)
#define __XSI_THREAD_EXIT               1
#endif
#if !defined(__XSI_THREAD_MUTEX_EXT)
#define __XSI_THREAD_MUTEX_EXT          1
#endif
#if !defined(__POSIX_SIGNALS)
#define __POSIX_SIGNALS                 0
#endif
#if !defined(__POSIX_DEVIO__)
#define __POSIX_DEVIO__                 0
#endif
#if !defined(__POSIX_FILE_SYSTEM__)
#define __POSIX_FILE_SYSTEM__           0
#endif
#if !defined(__POSIX_NETWORKING)
#define __POSIX_NETWORKING              0
#endif
#if !defined(__POSIX_MEMLOCK)
#define __POSIX_MEMLOCK                 0
#endif
#if !defined(__POSIX_MEMLOCK_RANGE)
#define __POSIX_MEMLOCK_RANGE           0
#endif
#if !defined(__POSIX_REALTIME_SIGNALS)
#define __POSIX_REALTIME_SIGNALS        __POSIX_SIGNALS
#endif
#if !defined(__POSIX_SHARED_MEMORY_OBJECTS)
#define __POSIX_SHARED_MEMORY_OBJECTS   0
#endif
#if !defined(__POSIX_SYNCHRONIZED_IO)
#define __POSIX_SYNCHRONIZED_IO         0
#endif
#if !defined(__POSIX_THREAD_ATTR_STACKADDR)
#define __POSIX_THREAD_ATTR_STACKADDR   0
#endif
#if !defined(__POSIX_THREAD_ATTR_STACKSIZE)
#define __POSIX_THREAD_ATTR_STACKSIZE   0
#endif
#if !defined(__POSIX_THREAD_PRIO_INHERIT)
#define __POSIX_THREAD_PRIO_INHERIT     0
#endif
#if !defined(__POSIX_THREAD_PRIO_PROTECT)
#define __POSIX_THREAD_PRIO_PROTECT     0
#endif
#if !defined(POSIX_THREADS_SPORADIC_SERVER)
#define POSIX_THREADS_SPORADIC_SERVER  0
#endif
#if !defined(__POSIX_TIMERS)
#define __POSIX_TIMERS                  0
#endif
#if !defined(__POSIX_TIMEOUTS)
#define __POSIX_TIMEOUTS                0
#endif
#if !defined(__POSIX_CLOCK_SELECTION)
#define __POSIX_CLOCK_SELECTION         0
#endif
#if !defined(POSIX_THREADS_CPUTIME)
#define POSIX_THREADS_CPUTIME           0
#endif
#if !defined(__POSIX_MESSAGE_PASSING)
#define __POSIX_MESSAGE_PASSING         0
#endif
#if !defined(__POSIX_MAPPED_FILES)
#define __POSIX_MAPPED_FILES            0
#endif
#if !defined(__POSIX_IPV6)
#define __POSIX_IPV6                    0
#endif
#if !defined(__POSIX_RAW_SOCKETS)
#define __POSIX_RAW_SOCKETS             0
#endif

// POSIX_FILE_SYSTEM
#ifndef POSIX_FILESYSTEM_NAME_MAX
#define POSIX_FILESYSTEM_NAME_MAX           _POSIX_NAME_MAX
#endif
#ifndef POSIX_FILESYSTEM_OPEN_MAX
#define POSIX_FILESYSTEM_OPEN_MAX           _POSIX_OPEN_MAX
#endif
#ifndef POSIX_FILESYSTEM_PATH_MAX
#define POSIX_FILESYSTEM_PATH_MAX           _POSIX_PATH_MAX
#endif

#define __POSIX_THREAD_CPUTIME          POSIX_THREADS_CPUTIME
#define __POSIX_THREAD_SPORADIC_SERVER  POSIX_THREADS_SPORADIC_SERVER


#if ( __POSIX_DEVIO__ == 0 && __POSIX_SHARED_MEMORY_OBJECTS == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_SHARED_MEMORY_OBJECTS == 1"
#endif

#if ( __POSIX_DEVIO__ == 0 && __POSIX_MAPPED_FILES == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_MAPPED_FILES == 1"
#endif

#if ( __POSIX_DEVIO__ == 0 && __POSIX_FILE_SYSTEM__ == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_FILE_SYSTEM__ == 1"
#endif

#if ( __POSIX_DEVIO__ == 0 && __POSIX_NETWORKING == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_NETWORKING == 1"
#endif

#if ( __POSIX_NETWORKING == 0 && __POSIX_RAW_SOCKETS == 1 )
#error "POSIX conf error:__POSIX_NETWORKING == 0 && __POSIX_RAW_SOCKETS == 1"
#endif

#if ( __POSIX_NETWORKING == 0 && __POSIX_IPV6 == 1 )
#error "POSIX conf error:__POSIX_NETWORKING == 0 && __POSIX_IPV6 == 1"
#endif


#if 0
/* check validity of configurable values */
#if     (POSIX_MQUEUE_MQ_OPEN_MAX<_POSIX_MQ_OPEN_MAX)
#error "POSIX conf error: POSIX_MQUEUE_OPEN_MAX"
#endif
#if     (POSIX_MQUEUE_MQ_PRIO_MAX<_POSIX_MQ_PRIO_MAX)
#error "POSIX conf error: POSIX_MQUEUE_MQ_PRIO_MAX"
#endif
#if     (POSIX_SIGNALS_SIGQUEUE_MAX<_POSIX_SIGQUEUE_MAX)
#error "POSIX conf error: POSIX_SIGNALS_SIGQUEUE_MAX"
#endif
#if     (POSIX_THREADS_DESTRUCTOR_ITERATIONS<_POSIX_THREAD_DESTRUCTOR_ITERATIONS)
#error "POSIX conf error: POSIX_THREADS_DESTRUCTOR_ITERATIONS"
#endif
#if     (POSIX_THREADS_KEYS_MAX<_POSIX_THREAD_KEYS_MAX)
#error "POSIX conf error: __POSIX_THREAD_KEYS_MAX"
#endif
#if     (POSIX_THREADS_THREADS_MAX< _POSIX_THREAD_THREADS_MAX)
#error "POSIX conf error: __POSIX_THREAD_THREADS_MAX"
#endif
#if     (POSIX_THREADS_TIMER_MAX<_POSIX_TIMER_MAX)
#error "POSIX conf error: __POSIX_TIMER_MAX"
#endif
#if     (POSIX_DEVIO_DEV_MAX<_POSIX_DEV_MAX)
#error "POSIX conf error: __POSIX_DEV_MAX"
#endif
#if     (__POSIX_SHARED_MEMORY_OBJECTS && __POSIX_SHARED_MEMORY_OBJECT_MAX < 1)
#error "POSIX conf error: __POSIX_SHARED_MEMORY_OBJECT_MAX "
#endif
#if     (POSIX_THREADS_MAIN_STACK_SIZE<__POSIX_THREAD_STACK_MIN)
#error "POSIX conf error: __POSIX_MAIN_STACK_SIZE < PTHREAD_STACK_MIN"
#endif
#if     (POSIX_THREADS_MAIN_PRIORITY > __POSIX_SCHED_PRIORITY_MAX )
#error "POSIX conf error: __POSIX_MAIN_PRIORITY > SCHED_PRIORITY_MAX"
#endif
#if     (POSIX_THREADS_IDLE_STACK_SIZE<__POSIX_THREAD_STACK_MIN)
#error "POSIX conf error: __POSIX_IDLE_STACK_SIZE < PTHREAD_STACK_MIN"
#endif
#if     (POSIX_THREADS_OSTICKMICROSCS < 100)
#error "POSIX conf error: __POSIX_OSTICKMICROSCS < 100"
#endif

#if ( __POSIX_CLOCK_SELECTION == 1 && __POSIX_TIMERS == 0 )
#error "POSIX conf error:__POSIX_CLOCK_SELECTION == 1 && __POSIX_TIMERS == 0"
#endif

#if ( __POSIX_TIMEOUTS == 1 && __POSIX_TIMERS == 0 )
#error "POSIX conf error:__POSIX_TIMEOUTS == 1 && __POSIX_TIMERS == 0"
#endif
#if ( __POSIX_THREAD_CPUTIME==1  && __POSIX_TIMERS == 0)
#error "POSIX conf error:__POSIX_THREAD_CPUTIME == 1 && __POSIX_TIMERS == 0"
#endif


#if ( __POSIX_REALTIME_SIGNALS == 1 && __POSIX_SIGNALS == 0 )
#error "POSIX conf error:__POSIX_REALTIME_SIGNALS == 1 && __POSIX_SIGNALS == 0"
#endif

#if ( __POSIX_DEVIO__ == 0 && __POSIX_SHARED_MEMORY_OBJECTS == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_SHARED_MEMORY_OBJECTS == 1"
#endif

#if ( __POSIX_DEVIO__ == 0 && __POSIX_MAPPED_FILES == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_MAPPED_FILES == 1"
#endif

#if ( __POSIX_DEVIO__ == 0 && __POSIX_FILE_SYSTEM__ == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_FILE_SYSTEM__ == 1"
#endif

#if ( __POSIX_DEVIO__ == 0 && __POSIX_NETWORKING == 1 )
#error "POSIX conf error:__POSIX_DEVIO__ == 0 && __POSIX_NETWORKING == 1"
#endif

#if ( __POSIX_NETWORKING == 0 && __POSIX_RAW_SOCKETS == 1 )
#error "POSIX conf error:__POSIX_NETWORKING == 0 && __POSIX_RAW_SOCKETS == 1"
#endif

#if ( __POSIX_NETWORKING == 0 && __POSIX_IPV6 == 1 )
#error "POSIX conf error:__POSIX_NETWORKING == 0 && __POSIX_IPV6 == 1"
#endif

#endif

/* final limits configuration */
#define AIO_LISTIO_MAX                                  __POSIX_AIO_LISTIO_MAX
#define AIO_MAX                                         __POSIX_AIO_MAX
#define AIO_PRIO_DELTA_MAX                              0
#define ARG_MAX                                         __POSIX_ARG_MAX
#define ATEXIT_MAX                                      32
#define CHILD_MAX                                       __POSIX_CHILD_MAX
#define DELAYTIMER_MAX                                  __POSIX_DELAYTIMER_MAX
#define DEV_MAX                                         POSIX_DEVIO_DEV_MAX
#define HOST_NAME_MAX                                   __POSIX_HOST_NAME_MAX
#define LOGIN_NAME_MAX                                  __POSIX_LOGIN_NAME_MAX
#define MQ_OPEN_MAX                                     POSIX_MQUEUE_MQ_OPEN_MAX
#define MQ_PRIO_MAX                                     POSIX_MQUEUE_MQ_PRIO_MAX
#define NAME_MAX                                        POSIX_FILESYSTEM_NAME_MAX
#define OPEN_MAX                                        POSIX_FILESYSTEM_OPEN_MAX
#define PATH_MAX                                        POSIX_FILESYSTEM_PATH_MAX
#define PAGESIZE                                        1
#define PAGE_SIZE                                       PAGESIZE
#define PTHREAD_DESTRUCTOR_ITERATIONS                   POSIX_THREADS_DESTRUCTOR_ITERATIONS
#define PTHREAD_KEYS_MAX                                POSIX_THREADS_KEYS_MAX
#define PTHREAD_STACK_MIN                               __POSIX_THREAD_STACK_MIN
#define PTHREAD_THREADS_MAX                             POSIX_THREADS_THREADS_MAX
#define RE_DUP_MAX                                      __POSIX_RE_DUP_MAX
#define RTSIG_MAX                                       __POSIX_RTSIG_MAX
#define SCHED_PRIORITY_MAX                              __POSIX_SCHED_PRIORITY_MAX
#define SCHED_PRIORITY_MIN                              __POSIX_SCHED_PRIORITY_MIN
#define SEM_NSEMS_MAX                                   __POSIX_SEM_NSEMS_MAX
#define SEM_VALUE_MAX                                   __POSIX_SEM_VALUE_MAX
#define SIGQUEUE_MAX                                    POSIX_SIGNALS_SIGQUEUE_MAX
#define SS_REPL_MAX                                     __POSIX_SS_REPL_MAX
#define STREAM_MAX                                      __POSIX_STREAM_MAX
#define SSIZE_MAX                                       __POSIX_SSIZE_MAX
#define SYMLOOP_MAX                                     __POSIX_SYMLOOP_MAX
#define TIMER_MAX                                       POSIX_THREADS_TIMER_MAX
#define TRACE_EVENT_NAME_MAX                            __POSIX_TRACE_EVENT_NAME_MAX
#define TRACE_NAME_MAX                                  __POSIX_TRACE_NAME_MAX
#define TRACE_SYS_MAX                                   __POSIX_TRACE_SYS_MAX
#define TRACE_USER_EVENT_MAX                            __POSIX_TRACE_USER_EVENT_MAX
#define TTY_NAME_MAX                                    __POSIX_TTY_NAME_MAX
#define TZNAME_MAX                                      __POSIX_TZNAME_MAX
#define MAX_CANON                                       __POSIX_MAX_CANON
#define MAX_INPUT                                       __POSIX_MAX_INPUT
#define PIPE_BUF                                        __POSIX_PIPE_BUF

/* sizes of Integral Types: taken from 'limits.h' in library */
#define CHAR_BIT        (8)
#define SCHAR_MIN       (-SCHAR_MAX-1)
#define SCHAR_MAX       (0x7f)
#define UCHAR_MAX       (0xffU)
#define CHAR_MIN        (SCHAR_MIN)
#define CHAR_MAX        (SCHAR_MAX)

#define MB_LEN_MAX      (1)

#define SHRT_MIN        (-SHRT_MAX-1)
#define SHRT_MAX        (0x7fff)
#define USHRT_MAX       (0xffffU)

#define INT_MIN         (-INT_MAX-1)
#define INT_MAX         (0x7fffffff)
#define UINT_MAX        (0xffffffffU)

#define LONG_MIN        (-LONG_MAX-1)
#define LONG_MAX        (0x7fffffffL)
#define ULONG_MAX       (0xffffffffUL)

#define LLONG_MIN       (-LLONG_MAX-1)
#define LLONG_MAX       (0x7fffffffffffffffLL)
#define ULLONG_MAX      (0xffffffffffffffffULL)

#endif





