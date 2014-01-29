#ifndef PAL_VIRTUAL_H
#define PAL_VIRTUAL_H

#define PAL_VARIANT_CLOCK_INTNO             (-1)


inline void     pal_variant_interrupts_set_mask(uint32_t mask)
{
}

inline uint32_t pal_variant_interrupts_get_mask(void)
{
    return 0;
}

inline void     pal_variant_interrupt_enable  (uint32_t number)
{
    return;
}

inline void     pal_variant_interrupt_disable  (uint32_t number){
    return;
}

inline void     pal_variant_interrupt_acknowledge(uint32_t number){
    return;
}

inline void     pal_variant_timers_start ( void ){

}

inline void     pal_variant_timers_stop ( void )
{

}

inline void     pal_variant_timer_interrupt_acknowledge(void){
    return;
}

inline void     pal_variant_interrupt_configure(   uint32_t number,
                                                        bool     edge,
                                                        bool     high){
}

#endif

