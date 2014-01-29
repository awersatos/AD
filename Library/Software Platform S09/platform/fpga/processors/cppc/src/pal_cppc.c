
#include <time.h>
#include <stdbool.h>
#include <pal.h>


uint32_t pal_cppc_pit_reload_value=0;

bool     pal_architecture_interrupts_init( void ){
    pal_variant_interrupts_initialize();
    ppc405_set_exception_vector_prefix(0);
    ppc405_extract_vector_table();
    return true;
}

#if ( __TIMERS__ > 0 ) || ( __POSIX_KERNEL__ != 0 )

bool     pal_architecture_timer_interrupt_init( void ){
#if ( __POSIX_KERNEL__ != 0 )
#include "posix_threads_cfg.h"
# define    PAL_TIMERSPERIODNSCS    (POSIX_THREADS_OSTICKMICROSCS)*(1000L)
#else
# define    PAL_TIMERSPERIODNSCS    (PAL_TIMERS_BASE)*(1000L)
#endif
    float   load = (float)(PAL_TIMERSPERIODNSCS)*(float)( PAL_CLOCKHZ) / (float)(1000*1000*1000L);
    pal_cppc_pit_reload_value  = (uint32_t)load;
    ppc405_pit_interrupt_disable();
    ppc405_pit_set_interval(0);
    ppc405_pit_interrupt_acknowledge();
    ppc405_pit_set_interval((uint32_t)load);
    return true;
}
#endif

bool     pal_architecture_processor_init ( void ){
    pal_variant_processor_init();   
    return true;
}

bool     pal_architecture_clock_init ( void ){
    return true;
}

__noinline uint32_t _get_tbl(void){  return __mfspr(_TBL); }
__noinline uint32_t _get_tbu(void){  return __mfspr(_TBU); }

clock_t _clock ( void )
{

        volatile uint32_t tl,tua,tub;
        clock_t ticks = 0;

        do
        {
            tua   = _get_tbu();
            tl    = _get_tbl();
            tub   = _get_tbu();

        } while ( tua != tub );

        ticks |= tub;
        ticks <<= 32;
        ticks |= tl;

        return ticks;
}

clock_t clock ( void )
{
        return _clock();
}





