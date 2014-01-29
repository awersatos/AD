
#include <time.h>
#include "pal.h"

#include "timing_cfg.h"

uint32_t arm_current_irq;

bool pal_variant_processor_init(void)
{
    #define RCPCCTRL_INIT         ( RCPC_CTRL_EP                | \
                                    RCPC_CTRL_EX                | \
                                    RCPC_PWRDWNSEL_ACTIVE       | \
                                    RCPC_OUTSEL_HCLK            | \
                                    RCPC_CTRL_CLKSEL_PLL        | \
                                    RCPC_CTRL_WRTLOCK_ENABLED )
    RCPC->rcpcctrl     = RCPCCTRL_INIT;

    #define IOCONMEMMUX_INIT    ( MEMMUX_MIDATA_X | MEMMUX_MICSN3    | \
                                  MEMMUX_MICSN4   | MEMMUX_MICSN5    | \
                                  MEMMUX_MICSN6   | MEMMUX_MIBLSN2   | \
                                  MEMMUX_MIBLSN3 )

    IOCON->memmux      = IOCONMEMMUX_INIT;

    #define IOCONMISCMUX_INIT   (  MISCMUX_RCCLKOUT | MISCMUX_INT0 | \
                                   MISCMUX_INT1     | MISCMUX_INT2 | \
                                   MISCMUX_INT5 )
    IOCON->miscmux     = IOCONMISCMUX_INIT;

    SMC->bcr0          = RBLE(1) | MW16 ;
    SMC->bcr1          = ( MW32 + WST2(2) + RBLE(1) + WST1(1) );
    SMC->bcr2          = ( MW32 + WST2(2) + RBLE(1) + WST1(1) );
    SMC->bcr3          = ( MW32 + WST2(2) + RBLE(1) + WST1(1) );
    SMC->bcr4          = ( MW32 + WST2(2) + RBLE(1) + WST1(1) );
    SMC->bcr5          = ( MW32 + WST2(2) + RBLE(1) + WST1(1) );
    SMC->bcr6          = ( MW32 + WST2(2) + RBLE(1) + WST1(1) );

    RCPC->hclkprescale   = ( RCPC_PRESCALER_DIV2 );
    RCPC->cpuclkprescale = ( RCPC_PRESCALER_DIV2 );
    RCPC->ahbclkctrl     = ( RCPC_CLKCTRL_U0_DISABLE + RCPC_CLKCTRL_U2_DISABLE );
    return true;
}

clock_t _clock ( clock_t t )
{
    uint32_t t2a, t2b, t1a, t1b, t0;
    do
    {
        t2a = TIMER2->value & 0xffff;
        t1a = TIMER1->value & 0xffff;
        t0 = TIMER0->value & 0xffff;

        t2b = TIMER2->value & 0xffff;
        t1b = TIMER1->value & 0xffff;

    } while (t2a!=t2b || t1a!=t1b);

      t = 0xFFFF;
      t <<= 16;
      t |= t2b;
      t <<= 16;
      t |= t1b;
      t <<= 16;
      t |= t0;

      return ~t;
}

clock_t clock ( void )
{
    return _clock( (clock_t)0 );
}

extern bool pal_variant_clock_init(void)
{

   /*  RCPC->rcpcctrl initialized at arm_startup */

    /* enable timers */
    RCPC->periphclkctrl &= ~( RCPC_CLKCTRL_CT01_DISABLE |           \
                             RCPC_CLKCTRL_CT23_DISABLE ) ;

#define TIMERCTRL_INIT             ( TMRCTRL_ENABLE |              \
                                     TMRCTRL_MODE_PERIODIC |       \
                                     TMRCTRL_CASCADE_ENABLE )
    TIMER0->load = 0xFFFF;
    TIMER0->control |= TIMERCTRL_INIT;
    TIMER1->load = 0xFFFF;
    TIMER1->control = TIMERCTRL_INIT;
    TIMER2->load = 0xFFFF;
    TIMER2->control = TIMERCTRL_INIT;
    return true;
}

void arm7_reset_clock(void)
{

    TIMER0->load = 0xFFFF;
    TIMER1->load = 0xFFFF;
    TIMER2->load = 0xFFFF;

}


static bool vic_set_vector_addr (uint32_t source, uint32_t priority,uint32_t addr)
{
    if (source >= VIC_BAD_SOURCE)
       return false;

    if (priority > 15)
       return false;

    /* Assign priority */
    VIC->vectcntl[priority] = (uint32_t)source;
    /* Enable VIC control */
    VIC->vectcntl[priority] |= VIC_VECTCNTL_ENABLE;
    /* set the vector handler */
    VIC->vectaddr[priority] = addr;

    return true;
}

extern void  arm_external_common_handler(uint32_t n);
extern void  arm_clock_common_handler(void);

/* vectored handlers: launch to interrupts_common_handler */
void  defvectaddr0(void)  {   arm_external_common_handler(VIC_EXINT0); }
void  defvectaddr1(void)  {   arm_external_common_handler(VIC_EXINT1); }
void  defvectaddr2(void)  {   arm_external_common_handler(VIC_EXINT2); }
void  defvectaddr3(void)  {   arm_external_common_handler(VIC_EXINT3); }
void  defvectaddr4(void)  {   arm_external_common_handler(VIC_EXINT4); }
void  defvectaddr5(void)  {   arm_external_common_handler(VIC_EXINT5); }
void  defvectaddr6(void)  {   arm_external_common_handler(VIC_EXINT6); }
void  defvectaddr7(void)  {   arm_external_common_handler(VIC_EXINT7); }
void  defvectaddr17(void) {   arm_external_common_handler(VIC_TIMER0); }
void  defvectaddr18(void) {   arm_external_common_handler(VIC_TIMER1); }
void  defvectaddr19(void) {   arm_external_common_handler(VIC_TIMER2); }
void  defvectaddr30(void) {   arm_external_common_handler(VIC_RTCINT); }
void  defvectaddr20(void) {   arm_clock_common_handler();  }


bool  pal_variant_interrupts_init(void)
{
    /* disable VIC channels */
    VIC->intenclear = ~0;
    /* clears all bits in softint register */
    VIC->softintclear = ~0;

    /* reset vector address registers and control registers */
    for (uint32_t priority = 0; priority <= 15; priority++)
    {
        VIC->vectcntl[priority] = 0;
        VIC->vectaddr[priority] = 0;
    }

    /* select all channels as IRQs */
    VIC->intselect = 0;
    /* set all vector addresses */
    VIC->defvectaddr = 0;
    VIC->vectoraddr = 0;

    /* set all vector addresses */
    vic_set_vector_addr (VIC_EXINT0, 0, (uint32_t)&defvectaddr0);
    vic_set_vector_addr (VIC_EXINT1, 1, (uint32_t)&defvectaddr1);
    vic_set_vector_addr (VIC_EXINT2, 2, (uint32_t)&defvectaddr2);
    vic_set_vector_addr (VIC_EXINT3, 3, (uint32_t)&defvectaddr3);
    vic_set_vector_addr (VIC_EXINT4, 4, (uint32_t)&defvectaddr4);
    vic_set_vector_addr (VIC_EXINT5, 5, (uint32_t)&defvectaddr5);
    vic_set_vector_addr (VIC_EXINT6, 6, (uint32_t)&defvectaddr6);
    vic_set_vector_addr (VIC_EXINT7, 7, (uint32_t)&defvectaddr7);
    vic_set_vector_addr (VIC_TIMER0, 8, (uint32_t)&defvectaddr17);
    vic_set_vector_addr (VIC_TIMER1, 9, (uint32_t)&defvectaddr18);
    vic_set_vector_addr (VIC_TIMER2, 10, (uint32_t)&defvectaddr19);
    vic_set_vector_addr (VIC_TIMER3, 11, (uint32_t)&defvectaddr20);
    vic_set_vector_addr (VIC_RTCINT, 12, (uint32_t)&defvectaddr30);
    return true;
}

extern bool     pal_variant_interrupt_configure( uint32_t number, bool edge, bool high )
{
    if ( number >= PAL_VARIANT_EXTERNAL_NUMBER ) return false;
    unsigned int cfg  = RCPC->intconfig;
    unsigned int value=0;
    if (edge)
    {
        value |= 2;
    }
    if (high)
    {
        value |= 1;
    }
    value = value << (number * 2);
    RCPC->intconfig = cfg | value ;
    return true;
}

void pal_variant_irq_handler(void)
{
   void (*launcher)(void);
    launcher = (void(*)(void))VIC->vectoraddr;
   (*launcher)();
    VIC->vectoraddr = 0;
}

#if (TIMING_USETIMERS > 0) || (__POSIX_KERNEL__ != 0)
extern bool pal_variant_timer_interrupt_init( void )
{

#if ( __POSIX_TIMERS > 0 )
#include "posix_threads_cfg.h"
# define    PAL_TIMERSPERIODNSCS    (POSIX_THREADS_OSTICKMICROSCS)*(1000L)
#else
# define    PAL_TIMERSPERIODNSCS    (PAL_TIMERS_BASE)*(1000L)
#endif

    /*   The final periodicity depends on the value of the clock
     *   frequency, the more the frequence the smaller periodicity.
     *   There is always an upper limit for the periodicity due to the fact
     *   that we work with a 16bit counter.
     */
    unsigned int    load = (uint32_t)((float)PAL_TIMERSPERIODNSCS)*((float)PAL_CLOCKHZ)/((float)(1000*1000*1000L));
    unsigned int    prescale = 0;
    if (load > 0xffffU)
    {
        prescale = 1;
        load = (uint32_t)((float)PAL_TIMERSPERIODNSCS)*((float)PAL_CLOCKHZ/16)/((float)(1000*1000*1000L));
        if (load > 0xffffU)
        {
            prescale = 2;
            load = (uint32_t)((float)PAL_TIMERSPERIODNSCS)*((float)PAL_CLOCKHZ/256)/((float)(1000*1000*1000L));
        }
    }

    TIMER3->load = (unsigned int)(load & 0xFFFF);
    TIMER3->control = (TMRCTRL_ENABLE | TMRCTRL_MODE_PERIODIC | (prescale << 2));

    return true;
}
#endif






