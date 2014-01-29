#ifndef _H_PAL_ARCH
#define _H_PAL_ARCH


#include <stdint.h>
#include <stdbool.h>
#include "pal_cfg.h"
#include "pal_arch_cfg.h"

#define PAL_ARCH_INTERNAL_NUMBER               0
#define PAL_ARCH_EXTERNAL_NUMBER               32
#define PAL_ARCH_MAXINTRS                      PAL_ARCH_EXTERNAL_NUMBER
#define PAL_ARCH_CLOCK_INTNO                   PAL_ARCH_MB_TIMER_INTERRUPT_NUMBER
#define PAL_ARCH_INTERRUPT_NATIVE
#define PAL_ARCH_NESTING_INTERRUPTS_SUPPORT    1

#define Interrupt_Reset                         0x00
#define Interrupt_UserVector                    0x08
#define Interrupt_Interrupt                     0x10
#define Interrupt_Break                         0x18
#define Interrupt_HardwareException             0x20

#define FIX_ENDIANESS(x) (x)
#define FIX_ENDIANESS16(x) (x)

typedef struct INTC_REGS_TYPE
{
    /* Interrupt Status Register */
    volatile uint32_t isr;
    /* Interrupt Pending Register */
    volatile uint32_t ipr;
    /* Interrupt Enable Register */
    volatile uint32_t ier;
    /* Interrupt Acknowledge Register */
    volatile uint32_t iar;
    /* Set Interrupt Register */
    volatile uint32_t sie;
    /* Clear Interrupt Register */
    volatile uint32_t cie;
    /* Interrupt Vector Register */
    volatile uint32_t ivr;
    /* Master Enable Register */
    volatile uint32_t mer;
} INTC_REGS_TYPE;

#define INTC_BASE                        (0xFFFFFF00)
#define _INTC                            ((INTC_REGS_TYPE*)INTC_BASE)
#define INTC_INT_MASTER_ENABLE_MASK      0x1UL
#define INTC_INT_HARDWARE_ENABLE_MASK    0x2UL

#define XTC_CSR_ENABLE_ALL_MASK     0x00000400  /* Enables all timer counters */
#define XTC_CSR_ENABLE_PWM_MASK     0x00000200  /* Enables the Pulse Width
                                                   Modulation */
#define XTC_CSR_INT_OCCURED_MASK    0x00000100  /* If bit is set, an interrupt has
                                                   occured.*/
                                                /* If set and '1' is written
                                                   to this bit position,
                                                   bit is cleared. */
#define XTC_CSR_ENABLE_TMR_MASK     0x00000080  /* Enables only the specific timer */
#define XTC_CSR_ENABLE_INT_MASK     0x00000040  /* Enables the interrupt output. */
#define XTC_CSR_LOAD_MASK           0x00000020  /* Loads the timer using the load
                                                   value provided earlier in the
                                                   Load Register, XTC_TLR_OFFSET. */
#define XTC_CSR_AUTO_RELOAD_MASK    0x00000010  /* In compare mode, configures the
                                                   timer counter to reload from the
                                                   Load Register. The default mode
                                                   causes the timer counter to hold
                                                   when the compare value is hit. In
                                                   capture mode, configures the
                                                   timer counter to not hold the
                                                   previous capture value if a new
                                                   event occurs. The default mode
                                                   cause the timer counter to hold
                                                   the capture value until
                                                   recognized. */
#define XTC_CSR_EXT_CAPTURE_MASK    0x00000008  /* Enables the external input to
                                                   the timer counter. */
#define XTC_CSR_EXT_GENERATE_MASK   0x00000004  /* Enables the external generate
                                                   output for the timer. */
#define XTC_CSR_DOWN_COUNT_MASK     0x00000002  /* Configures the timer counter to
                                                   count down fromstart value, the
                                                   default is to count up. */
#define XTC_CSR_CAPTURE_MODE_MASK   0x00000001  /* Enables the timer to capture the
                                                   timer counter value when the
                                                   external capture line is asserted.
                                                   The default mode is compare mode.*/

typedef struct
{
    /* control/status register */
    volatile uint32_t tcsr;
    /* load register */
    volatile uint32_t tlr;
    /* timer counter register */
    volatile uint32_t tsr;
} TMRC_REGS_TYPE;

#define TMRC_BASE           (0xFFFFFE00)
#define _TMRC               ((TMRC_REGS_TYPE *)TMRC_BASE )


inline void* pal_architecture_get_current_sp(void)
{
    void* sp;
    __asm("addik    %0,r1, 0":"=r"(sp):);
    return sp;
}


#if ( __POSIX_KERNEL__ != 0 )
#include "pal_platform_posix.h"
#endif

typedef int pal_arch_atomic_t;


inline void     pal_architecture_interrupts_enable (void)
{
     uint32_t MSR;
     __asm( "mfs  %0,  rmsr" : "=r"(MSR));
     MSR |=  0x00000002;
     __asm( "mts  rmsr, %0" : :"r"(MSR));
}

inline void     pal_architecture_interrupts_disable (void)
{
     uint32_t MSR;
     __asm( "mfs  %0,  rmsr" : "=r"(MSR));
     MSR &= ~0x00000002;
     __asm( "mts  rmsr, %0" : :"r"(MSR));
}

inline uint32_t pal_architecture_current_interrupt(void)
{
    return _INTC->ivr;
}

inline void     pal_architecture_interrupts_set_mask(uint32_t mask)
{
     _INTC->ier = mask;
}

inline uint32_t  pal_architecture_interrupts_get_mask(void)
{
    return _INTC->ier;
}

inline void pal_architecture_interrupt_acknowledge (uint32_t number){
    _INTC->iar = (1<<number);
}

inline void pal_architecture_interrupt_enable  (uint32_t int_num){
     _INTC->sie = (1 << int_num);
}

inline void pal_architecture_interrupt_disable (uint32_t int_num){
     _INTC->cie = (1 << int_num);
}


#if ( __POSIX_KERNEL__ != 0 )
extern uint32_t  posix_interrupts_bitmask;
extern volatile  uint32_t  microblaze_posix_interrupts_savemask;
inline void microblaze_posix_interrupts_internal_disable() {
    uint32_t mask = pal_architecture_interrupts_get_mask();
    pal_architecture_interrupts_set_mask( mask & ~(posix_interrupts_bitmask) & ~(1<<PAL_ARCH_MB_TIMER_INTERRUPT_NUMBER) );
    microblaze_posix_interrupts_savemask = mask;
    return;
}
inline void microblaze_posix_interrupts_internal_enable() {
    pal_architecture_interrupts_set_mask( microblaze_posix_interrupts_savemask  );
    return;
}
#endif

extern void microblaze_extract_vector_table(void);
extern bool pal_architecture_set_native_handler( uint32_t number, void* handler );
extern bool pal_architecture_interrupt_configure(   uint32_t number, bool edge, bool high);

inline uint32_t   pal_architecture_interrupts_mask_levels_below (uint32_t level)
{
     uint32_t oldmask = pal_architecture_interrupts_get_mask();
#if ( __POSIX_KERNEL__ == 0 )
    pal_architecture_interrupts_set_mask ( oldmask & (0xffffffffU >> (32 - level) ) & ~(1<<PAL_ARCH_MB_TIMER_INTERRUPT_NUMBER) );
#else
    extern uint32_t         posix_interrupts_bitmask;
    pal_architecture_interrupts_set_mask ( oldmask & (0xffffffffU >> (32 - level) ) & (~(posix_interrupts_bitmask))
            & ~(1<<PAL_ARCH_MB_TIMER_INTERRUPT_NUMBER)  );
#endif
    return oldmask;
}


#if ( __POSIX_KERNEL__ != 0 )
#define     pal_architecture_posix_interrupts_enable    microblaze_posix_interrupts_internal_enable
#define     pal_architecture_posix_interrupts_disable   microblaze_posix_interrupts_internal_disable
#endif


inline void microblaze_enable_interval_timer(void){
    volatile uint32_t csr = _TMRC->tcsr;
    _TMRC->tcsr           = XTC_CSR_INT_OCCURED_MASK | XTC_CSR_LOAD_MASK;
    _TMRC->tcsr           = csr | XTC_CSR_ENABLE_TMR_MASK;
}
inline void microblaze_disable_interval_timer(void){
    volatile uint32_t csr = _TMRC->tcsr;
    _TMRC->tcsr = csr & ~XTC_CSR_ENABLE_TMR_MASK;
}
inline void microblaze_timer_interrupt_acknowledge(void){
    volatile unsigned int csr = _TMRC->tcsr;
    _TMRC->tcsr = csr | XTC_CSR_INT_OCCURED_MASK | XTC_CSR_ENABLE_TMR_MASK | XTC_CSR_ENABLE_INT_MASK;
}
inline void microblaze_timer_interrupt_enable(void){
    volatile uint32_t csr = _TMRC->tcsr;
    _TMRC->tcsr = csr |  XTC_CSR_ENABLE_INT_MASK;
}
inline void microblaze_timer_interrupt_disable(void){
    volatile uint32_t csr = _TMRC->tcsr;
    _TMRC->tcsr = csr & ~XTC_CSR_ENABLE_INT_MASK;
}

#define pal_architecture_timer_interrupt_start          microblaze_enable_interval_timer
#define pal_architecture_timer_interrupt_stop           microblaze_disable_interval_timer
#define pal_architecture_timer_interrupt_enable         microblaze_enable_interval_timer
#define pal_architecture_timer_interrupt_disable        microblaze_disable_interval_timer
#define pal_architecture_timer_interrupt_acknowledge    microblaze_timer_interrupt_acknowledge

extern bool     pal_architecture_interrupts_init( void );
extern bool     pal_architecture_timer_interrupt_init( void );
extern bool     pal_architecture_processor_init ( void );
extern bool     pal_architecture_clock_init ( void );




#endif

