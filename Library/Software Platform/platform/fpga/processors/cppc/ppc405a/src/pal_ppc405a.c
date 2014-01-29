
#include "pal_variant.h"

bool pal_variant_interrupt_configure   ( uint32_t number,
                                             bool     edge,
                                             bool     high)
{
    if ( edge)
    {
        ppc405a_set_intc_register(INT_MODE,
            ppc405a_get_intc_register(INT_MODE) | (1<<number));
    }
    else
    {
        ppc405a_set_intc_register(INT_MODE,
            ppc405a_get_intc_register(INT_MODE) & ~(1<<number));
    }
    if ( high)
    {
        ppc405a_set_intc_register(INT_POLAR,
            ppc405a_get_intc_register(INT_POLAR) | (1<<number));
    }
    else
    {
        ppc405a_set_intc_register(INT_POLAR,
            ppc405a_get_intc_register(INT_POLAR) & ~(1<<number));
    }
    return true;
}


void  pal_variant_interrupts_initialize(void)
{
    return;
}
