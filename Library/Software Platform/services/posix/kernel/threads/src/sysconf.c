/*****************************************************************************
 * FILE:        @(#)sysconf.c   1.9 07/03/13
 * DESCRIPTION:
 *      The sysconf() function provides a method for the application to 
 *      determine the current value of a configurable system limit 
 *      or option ( variable).
 *****************************************************************************/
#include <errno.h>
#include <unistd.h>
#include <limits.h>

#define CASE(_name,_val) case _name: return _val

long sysconf( int name )
{
        switch( name )
        {
                /* limits */
                CASE( _SC_AIO_LISTIO_MAX,       AIO_LISTIO_MAX);
                CASE( _SC_AIO_MAX ,             AIO_MAX );
                CASE( _SC_AIO_PRIO_DELTA_MAX,   AIO_PRIO_DELTA_MAX);
                CASE( _SC_ARG_MAX,              ARG_MAX );
                CASE( _SC_CHILD_MAX,            CHILD_MAX);
                CASE( _SC_CLK_TCK,              (1000000L)/POSIX_THREADS_OSTICKMICROSCS );
                CASE( _SC_DELAYTIMER_MAX,       DELAYTIMER_MAX);
                CASE( _SC_HOST_NAME_MAX,        HOST_NAME_MAX );
                CASE( _SC_LOGIN_NAME_MAX,       LOGIN_NAME_MAX);
                CASE( _SC_GETGR_R_SIZE_MAX,     0 );
                CASE( _SC_GETPW_R_SIZE_MAX,     0 );
                CASE( _SC_MQ_OPEN_MAX ,         MQ_OPEN_MAX);
                CASE( _SC_MQ_PRIO_MAX,          MQ_PRIO_MAX );
                CASE( _SC_OPEN_MAX,             MQ_PRIO_MAX );
                CASE( _SC_PAGE_SIZE,            PAGESIZE );
                CASE( _SC_PAGESIZE,             PAGE_SIZE);
                CASE( _SC_THREAD_DESTRUCTOR_ITERATIONS, PTHREAD_DESTRUCTOR_ITERATIONS );
                CASE( _SC_THREAD_KEYS_MAX,      PTHREAD_KEYS_MAX );
                CASE( _SC_THREAD_STACK_MIN,     PTHREAD_STACK_MIN );
                CASE( _SC_THREAD_THREADS_MAX,   PTHREAD_THREADS_MAX );
                CASE( _SC_RE_DUP_MAX,           RE_DUP_MAX );
                CASE( _SC_RTSIG_MAX,            RTSIG_MAX );
                CASE( _SC_SEM_NSEMS_MAX,        SEM_NSEMS_MAX );
                CASE( _SC_SEM_VALUE_MAX,        SEM_VALUE_MAX);
                CASE( _SC_SIGQUEUE_MAX,         SIGQUEUE_MAX );
                CASE( _SC_SS_REPL_MAX,          SS_REPL_MAX);
                CASE( _SC_STREAM_MAX,           STREAM_MAX );
                CASE( _SC_SYMLOOP_MAX,          SYMLOOP_MAX );
                CASE( _SC_TIMER_MAX,            TIMER_MAX);
                CASE( _SC_TRACE_EVENT_NAME_MAX, TRACE_EVENT_NAME_MAX );
                CASE( _SC_TRACE_NAME_MAX,       TRACE_NAME_MAX );
                CASE( _SC_TRACE_SYS_MAX,        TRACE_SYS_MAX );
                CASE( _SC_TRACE_USER_EVENT_MAX, TRACE_USER_EVENT_MAX );
                CASE( _SC_TTY_NAME_MAX,         TTY_NAME_MAX );
                CASE( _SC_TZNAME_MAX,           TZNAME_MAX );
        
                /* options configuration */
                CASE( _SC_ADVISORY_INFO,        _POSIX_ADVISORY_INFO);                  
                CASE( _SC_ASYNCHRONOUS_IO,      _POSIX_ASYNCHRONOUS_IO);                        
                CASE( _SC_BARRIERS,             _POSIX_BARRIERS );              
                CASE( _SC_CPUTIME,              _POSIX_CPUTIME);                                
                CASE( _SC_IPV6,                 _POSIX_IPV6);                                   
                CASE( _SC_JOB_CONTROL,          _POSIX_JOB_CONTROL);                    
                CASE( _SC_MAPPED_FILES,         _POSIX_MAPPED_FILES);                   
                CASE( _SC_MEMORY_PROTECTION,    _POSIX_MEMORY_PROTECTION);                                      
                CASE( _SC_MESSAGE_PASSING,      _POSIX_MESSAGE_PASSING);                        
                CASE( _SC_PRIORITIZED_IO,       _POSIX_PRIORITIZED_IO);                 
                CASE( _SC_PRIORITY_SCHEDULING,  _POSIX_PRIORITY_SCHEDULING);                    
                CASE( _SC_RAW_SOCKETS,          _POSIX_RAW_SOCKETS);                            
                CASE( _SC_READER_WRITER_LOCKS,  _POSIX_READER_WRITER_LOCKS);                    
                CASE( _SC_REGEXP,               _POSIX_REGEXP);                         
                CASE( _SC_SAVED_IDS,            _POSIX_SAVED_IDS);                      
                CASE( _SC_SHELL,                _POSIX_SHELL);                  
                CASE( _SC_SPAWN,                _POSIX_SPAWN);                          
                CASE( _SC_SPIN_LOCKS,           _POSIX_SPIN_LOCKS);                             
                CASE( _SC_THREAD_PROCESS_SHARED,_POSIX_THREAD_PROCESS_SHARED);          
                CASE( _SC_THREAD_SAFE_FUNCTIONS,_POSIX_THREAD_SAFE_FUNCTIONS);                  
                CASE( _SC_TRACE,                _POSIX_TRACE);                          
                CASE( _SC_TRACE_EVENT_FILTER,   _POSIX_TRACE_EVENT_FILTER);                     
                CASE( _SC_TRACE_INHERIT,        _POSIX_TRACE_INHERIT);                  
                CASE( _SC_TRACE_LOG,            _POSIX_TRACE_LOG);                              
                CASE( _SC_TYPED_MEMORY_OBJECTS, _POSIX_TYPED_MEMORY_OBJECTS);                   
                CASE( _SC_CLOCK_SELECTION,      _POSIX_CLOCK_SELECTION);                        
                CASE( _SC_FSYNC,                -1);                            
                CASE( _SC_MEMLOCK,              _POSIX_MEMLOCK);                                        
                CASE( _SC_MEMLOCK_RANGE,        _POSIX_MEMLOCK_RANGE);                  
                CASE( _SC_SEMAPHORES,           -1);                            
                CASE( _SC_SHARED_MEMORY_OBJECTS,_POSIX_SHARED_MEMORY_OBJECTS);                  
                CASE( _SC_THREAD_SPORADIC_SERVER,_POSIX_THREAD_SPORADIC_SERVER);        
                CASE( _SC_THREAD_CPUTIME,       _POSIX_THREAD_CPUTIME); 
                CASE( _SC_MONOTONIC_CLOCK,      _POSIX_MONOTONIC_CLOCK);                        
                CASE( _SC_REALTIME_SIGNALS,     _POSIX_REALTIME_SIGNALS);                       
                CASE( _SC_SYNCHRONIZED_IO,      _POSIX_SYNCHRONIZED_IO);                        
                CASE( _SC_THREADS,              _POSIX_THREADS);                                
                CASE( _SC_THREAD_ATTR_STACKADDR,_POSIX_THREAD_ATTR_STACKADDR);                  
                CASE( _SC_THREAD_ATTR_STACKSIZE,_POSIX_THREAD_ATTR_STACKSIZE);          
                CASE( _SC_THREAD_PRIO_INHERIT,  _POSIX_THREAD_PRIO_INHERIT);                    
                CASE( _SC_THREAD_PRIO_PROTECT,  _POSIX_THREAD_PRIO_PROTECT);                    
                CASE( _SC_THREAD_PRIORITY_SCHEDULING,_POSIX_THREAD_PRIORITY_SCHEDULING);        
                CASE( _SC_TIMEOUTS,             _POSIX_TIMEOUTS );                      
                CASE( _SC_TIMERS,               _POSIX_TIMERS);         
                CASE( _SC_VERSION,              -1);            
                CASE( _SC_2_C_BIND,             _POSIX2_C_BIND);
                CASE( _SC_2_C_DEV,              _POSIX2_C_DEV);
                CASE( _SC_2_SW_DEV,             _POSIX2_SW_DEV);
                CASE( _SC_POSIX_26_VERSION,     _POSIX_26_VERSION);

                default:
                        errno = EINVAL;
                        return -1;
        }
}


