#ifndef _H_PAL_VARIANT
#define _H_PAL_VARIANT

#include <stdint.h>
#include <stdbool.h>

//Interrupt controller registers
#define INT_ENABLE 0
#define INT_ACK    1
#define INT_MODE   2
#define INT_POLAR  3
#define INT_VECTOR 4
#define INT_DEBUG  5

inline void ppc405a_set_intc_register(int address, unsigned int value)
{
     switch  (address) {
         case 0: __asm("mtdcr %0, %1 \n": :"i"(0), "r"(value):); break;
         case 1: __asm("mtdcr %0, %1 \n": :"i"(1), "r"(value):); break;
         case 2: __asm("mtdcr %0, %1 \n": :"i"(2), "r"(value):); break;
         case 3: __asm("mtdcr %0, %1 \n": :"i"(3), "r"(value):); break;
         case 4: __asm("mtdcr %0, %1 \n": :"i"(4), "r"(value):); break;
         case 5: __asm("mtdcr %0, %1 \n": :"i"(5), "r"(value):); break;
     }
}

inline unsigned int ppc405a_get_intc_register(int address)
{
     unsigned int ret = 0;

     switch  (address) {
         case 0: __asm("mfdcr %0, %1 \n":"=r"(ret): "i"(0):); break;
         case 1: __asm("mfdcr %0, %1 \n":"=r"(ret): "i"(1):); break;
         case 2: __asm("mfdcr %0, %1 \n":"=r"(ret): "i"(2):); break;
         case 3: __asm("mfdcr %0, %1 \n":"=r"(ret): "i"(3):); break;
         case 4: __asm("mfdcr %0, %1 \n":"=r"(ret): "i"(4):); break;
         case 5: __asm("mfdcr %0, %1 \n":"=r"(ret): "i"(5):); break;
     }

    return ret;
}

inline uint32_t     pal_variant_current_interrupt(void){
    return ppc405a_get_intc_register(INT_VECTOR);
}

inline void     pal_variant_interrupts_set_mask(uint32_t mask)
{
    ppc405a_set_intc_register(INT_ENABLE, mask);
}

inline uint32_t pal_variant_interrupts_get_mask(void)
{
    return ppc405a_get_intc_register(INT_ENABLE);
}

inline void     pal_variant_interrupt_enable      ( uint32_t number){
        ppc405a_set_intc_register(INT_ENABLE, ppc405a_get_intc_register(INT_ENABLE) | (1<<number));
    return;
}

inline void     pal_variant_interrupt_disable     ( uint32_t number){
        ppc405a_set_intc_register(INT_ENABLE, ppc405a_get_intc_register(INT_ENABLE) & ~(1<<number));
    return;
}

inline void     pal_variant_interrupt_acknowledge ( uint32_t number){
    ppc405a_set_intc_register(INT_ACK, (1<<number) );
    return;
}

inline void pal_variant_processor_init ( void ) {
}

extern bool    pal_variant_interrupt_configure   ( uint32_t number,
                                                    bool     edge,
                                                    bool     high);

extern void  pal_variant_interrupts_initialize(void);


#endif
