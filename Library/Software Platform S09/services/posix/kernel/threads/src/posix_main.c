#include <pthread.h>
#include <limits.h>
#include <interrupts.h>
#include "pal.h"
#include "kernel.h"
#include "posix_pthread.h"
#include "posix_time.h"
#include "posix_signal.h"
#include "posix_mqueue.h"
#include "k_schedule.h"

/* main entry point from startup code */
void posix_threads_init(void)
{
        interrupts_disable();

        /* scheduler locked */
        _posix_sched_lock++;

        posix_pthreads_init();

#       if ( __POSIX_TIMEOUTS != 0 || __POSIX_TIMERS != 0 )
        posix_time_init();
#       endif

#       if ( __POSIX_SIGNALS != 0 )
        posix_signal_init();
#       endif

#       if ( __POSIX_MESSAGE_PASSING != 0 )
        posix_mqueue_init();
#       endif

#       if (__POSIX_SHARED_MEMORY_OBJECTS != 0)
        extern void shmio_init(void);
        shmio_init();
#       endif
#       if ( __POSIX_TIMEOUTS != 0 || __POSIX_TIMERS != 0 )
        pal_timer_interrupt_init();
        pal_timer_interrupt_start();
#       endif

        return;
}

void posix_main(void)
{
        /* thread level */
        _posix_irq_level = 0;
        /* finally enable interrupts */
        interrupts_enable();
        /* go to first thread */
        posix_schedule_next();
        /* never here */
        return;
}
