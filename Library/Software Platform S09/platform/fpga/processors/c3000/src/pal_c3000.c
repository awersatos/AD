#include <pal.h>
#include "pal_cfg.h"



bool     pal_architecture_interrupts_init( void )
{
    pal_architecture_interrupts_disable();
    tsk3000_set_vectored_interrupts();
    tsk3000_extract_vector_table();
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
#endif    /* reset PIT timer */
    tsk3000_reset_interval_timer();
    /* sets initial reload value */
   tsk3000_set_interval_timer( PAL_TIMERSPERIODNSCS  );
    /* enable PIT timer */
    __mtc0( __mfc0(TSK3000_COP_Status) | TSK3000_Status_IntervalTimerEnable , TSK3000_COP_Status);
    return true;
}

#endif

bool     pal_architecture_processor_init ( void ){
    return true;
}

bool     pal_architecture_interrupt_configure(   uint32_t number,
                                                 bool     edge,
                                                 bool     high){
    if (edge)
    {
        tsk3000_set_interrupt_mode(tsk3000_get_interrupt_mode() | (1<<number)) ;
        pal_architecture_interrupt_acknowledge ( number );
    }
    return true;
}


bool     pal_architecture_clock_init ( void ){
    /* clock() implemented by compiler */
    return true;
}

#if 0
/* extra */
uint64_t tsk3000_get_timebase ( void )
{
    uint32_t hiword_1;
    uint32_t hiword_2;
    uint32_t loword;

    do
    {
         hiword_1 = tsk3000_get_timebase_hi ();
         loword   = tsk3000_get_timebase_lo ();
         hiword_2 = tsk3000_get_timebase_hi ();
    } while (hiword_1 != hiword_2);

    return ((unsigned long long) hiword_1 << 32) + loword;
}
#endif

extern void tsk3000_set_interval_timer(uint32_t value)
{
    uint32_t load = (uint32_t)((float)value)*((float)PAL_CLOCKHZ)/((float)(1000*1000*1000L));
    __mtc0(load,TSK3000_COP_Compare);
}



