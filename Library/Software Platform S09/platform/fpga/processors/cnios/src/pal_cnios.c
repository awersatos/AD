#include <time.h>
#include <pal.h>
#include "pal_cfg.h"

bool     pal_architecture_interrupts_init( void )
{
    pal_architecture_interrupts_disable();
    pal_architecture_interrupts_set_mask(0);
    nios_set_vectored_interrupts();
    return true;
}

#if ( (__TIMERS__ > 0) || (__POSIX_TIMERS > 0 ) )

bool     pal_architecture_timer_interrupt_init(void)
{
#if ( __POSIX_TIMERS > 0 )
#include "posix_threads_cfg.h"
# define    PAL_TIMERSPERIODNSCS    (POSIX_THREADS_OSTICKMICROSCS)*(1000L)
#else
# define    PAL_TIMERSPERIODNSCS    (PAL_TIMERS_BASE)*(1000L)
#endif
    float   load = (float)(PAL_TIMERSPERIODNSCS)*(float)( PAL_CLOCKHZ ) / (float)(1000*1000*1000L);
    pal_architecture_timer_interrupt_acknowledge();
    nios_reset_interval_timer();
    nios_set_interval_timer( (uint32_t)load  );
    nios_enable_interval_timer();
    pal_timer_interrupt_enable();
    return true;
}

#endif

bool     pal_architecture_processor_init ( void ){
    return true;
}

bool     pal_architecture_clock_init ( void ){
    return true;
}

inline uint32_t nios_get_tb_lo(void)
{
    return *((volatile uint32_t*) NIOS2_TIMEBASE_LOW);
}

inline uint32_t nios_get_tb_hi(void)
{
    return *((volatile uint32_t*) NIOS2_TIMEBASE_HI);
}

clock_t clock ( void )
{
        volatile uint32_t tl,tua,tub;
        do
        {
            tua   = nios_get_tb_hi();
            tl    = nios_get_tb_lo();
            tub   = nios_get_tb_hi();

        } while ( tua != tub );
        return (clock_t) ((clock_t)tua << 32) | tl;
}



