#include <time.h>
#include <pal.h>

extern bool     pal_architecture_interrupts_init( void )
{
    pal_architecture_interrupts_disable();
    pal_variant_interrupts_init();
    pal_architecture_interrupts_set_mask(0);
    arm7_extract_vector_table();
    return true;
}

extern bool pal_architecture_clock_init(void)
{
    pal_variant_clock_init();
    return true;
}

extern bool pal_architecture_processor_init(void)
{
    pal_variant_processor_init();

    // add stacks init
    // add -> svc mode
    return true;
}
