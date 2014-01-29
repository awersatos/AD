
#include <time.h>
#include <stdbool.h>

#include <pal.h>

bool pal_init (void)
{
	/* c-library implementation */
    __clocks_per_sec = PAL_CLOCKHZ;

	if (!pal_architecture_processor_init()) {
    	return false;
    }

    if (!pal_architecture_interrupts_init()) {
    	return false;
    }

#if (__TIMERS__ > 0) && ( __POSIX_KERNEL__ == 0 )
	if (!pal_architecture_timer_interrupt_init()) {
    	return false;
    }
#endif

	if (!pal_architecture_clock_init()) {
    	return false;
    }

#if ( __POSIX_KERNEL__ == 0 )
    pal_architecture_interrupts_enable();
#endif

    return true;
}

