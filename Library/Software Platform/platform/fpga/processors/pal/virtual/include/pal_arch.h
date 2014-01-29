#ifndef _H_PAL_ARCH
#define _H_PAL_ARCH

#define PAL_ARCH_INTERNAL_NUMBER               1
#define PAL_ARCH_EXTERNAL_NUMBER               1
#define PAL_ARCH_CLOCK_INTNO                   -1


typedef int pal_arch_atomic_t;

inline void     pal_architecture_interrupts_enable (void){
    return;
}

inline void     pal_architecture_interrupts_disable (void) {
    return;
}

inline void     pal_architecture_interrupts_set_mask(uint32_t mask) {
    (void)mask;
    return;
}

inline uint32_t pal_architecture_interrupts_get_mask(void){
    return 0;
}

inline void     pal_architecture_interrupt_enable  (uint32_t number){
    (void)number;
    return;
}

inline void     pal_architecture_interrupt_disable  (uint32_t number){
    (void)number;
    return;
}

inline void     pal_architecture_interrupt_acknowledge(uint32_t number){
    (void)number;
    return;
}

inline void     pal_architecture_interrupt_configure(   uint32_t number,
                                                        bool     edge,
                                                        bool     high){
    (void)number;
    (void)edge;
    (void)high;
    return;
}

inline void     pal_architecture_timers_start ( void ){
    return;
}

inline void     pal_architecture_timers_stop ( void ){
    return;
    }

inline void     pal_architecture_timer_interrupt_acknowledge(void){
    return;
}

inline bool     pal_architecture_interrupts_init( void ){
    return false;
}

inline bool     pal_architecture_timers_init( void ){
    return false;
}

inline bool     pal_architecture_processor_init ( void ){
    return false;
}

inline bool     pal_architecture_clock_init ( void ){
    return false;
}

#endif

