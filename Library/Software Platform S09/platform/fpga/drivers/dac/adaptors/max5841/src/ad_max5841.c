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
    int id;

    for (int drv_id = 0; drv_id < DRV_MAX5841_INSTANCE_COUNT; drv_id++)
    {
        id = ad_dac_max5841_instance_table[drv_id].ad_dac;

        dac_table[id].drv_id     = drv_id;
        dac_table[id].drv_open   = (void*)max5841_open;
        dac_table[id].write      = (void*)ad_max5841_write;
    }
}

static bool ad_max5841_write(max5841_t *drv, unsigned channel, int value, bool flush)
{
    return max5841_out(drv, (uint8_t)channel, (uint16_t)value, flush) == 0 ? true : false;
}


