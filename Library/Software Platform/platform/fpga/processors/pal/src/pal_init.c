/******************************************************************************\
|*
|*  PACKAGE:        PAL
|*
|*  DESCRIPTION:    Initialize the processor
|*
|*  COPYRIGHT:      Copyright (c) 2009 Altium
|*
\******************************************************************************/

#include <time.h>
#include <stdbool.h>

#include <pal.h>

// Software Platform init handler
void pal_init (void)
{
    /* c-library implementation */
    __clocks_per_sec = PAL_CLOCKHZ;

    pal_architecture_processor_init();

    pal_architecture_interrupts_init();

#if (__TIMERS__ > 0) && ( __POSIX_KERNEL__ == 0 )
    pal_architecture_timer_interrupt_init();
#endif

    pal_architecture_clock_init();

#if ( __POSIX_KERNEL__ == 0 )
    pal_architecture_interrupts_enable();
#endif
}

