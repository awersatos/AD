#include "ad_dac_max5841_cfg_instance.h"
#include "drv_max5841_cfg_instance.h"
#include "dac_cfg_instance.h"
#include "dac_cfg.h"
#include <drv_max5841.h>
#include <dac.h>
#include <dac_i.h>

extern dac_t dac_table[DAC_INSTANCE_COUNT];
static bool ad_max5841_write(max5841_t *drv, unsigned channel, int value, bool flush);

void ad_max5841_init(void)
{
    int dac_id;
    int drv_id;

    for (int adaptor_id = 0; adaptor_id < AD_DAC_MAX5841_INSTANCE_COUNT; adaptor_id++)
    {
        dac_id = ad_dac_max5841_instance_table[adaptor_id].ad_dac;
        drv_id = ad_dac_max5841_instance_table[adaptor_id].drv_max5841;

        dac_register_adaptor( dac_id,
                              drv_id,
                              (void*)max5841_open,
                              (void*)ad_max5841_write );
    }
}

static bool ad_max5841_write(max5841_t *drv, unsigned channel, int value, bool flush)
{
    return max5841_out(drv, (uint8_t)channel, (uint16_t)value, flush) == 0 ? true : false;
}


