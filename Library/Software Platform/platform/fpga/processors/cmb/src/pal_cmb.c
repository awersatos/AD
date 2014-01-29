#include <pal.h>
#include "pal_cfg.h"

bool     pal_architecture_interrupts_init( void )
{
    pal_architecture_interrupts_disable();
    _INTC->mer = INTC_INT_MASTER_ENABLE_MASK | INTC_INT_HARDWARE_ENABLE_MASK;
    pal_architecture_interrupts_set_mask(0);
    microblaze_extract_vector_table();
    return true;
}

#if ( (__TIMERS__ > 0) || (__POSIX_TIMERS > 0 ) )

static inline void microblaze_set_interval_timer(uint32_t value)
{
    uint32_t load = (uint32_t)((float)value)*((float)PAL_CLOCKHZ)/((float)(1000*1000*1000L));
    _TMRC->tlr  =  load;
    _TMRC->tcsr =  XTC_CSR_INT_OCCURED_MASK | XTC_CSR_AUTO_RELOAD_MASK | XTC_CSR_DOWN_COUNT_MASK;
}

bool     pal_architecture_timer_interrupt_init(void)
{
#if ( __POSIX_TIMERS > 0 )
#include "posix_threads_cfg.h"
# define    PAL_TIMERSPERIODNSCS    (POSIX_THREADS_OSTICKMICROSCS)*(1000L)
#else
# define    PAL_TIMERSPERIODNSCS    (PAL_TIMERS_BASE)*(1000L)
#endif

    microblaze_timer_interrupt_acknowledge();
    microblaze_set_interval_timer(PAL_TIMERSPERIODNSCS);
    microblaze_enable_interval_timer();
    microblaze_timer_interrupt_enable();
    return true;
}

#endif

bool     pal_architecture_processor_init ( void ){
    return true;
}

bool     pal_architecture_interrupt_configure(   uint32_t number,
                                                 bool     edge,
                                                 bool     high){
    if (!edge && !high)
    {
        return false;
    }
    return true;
}


bool     pal_architecture_clock_init ( void ){
    /* clock() implemented by compiler */
    return true;
}




