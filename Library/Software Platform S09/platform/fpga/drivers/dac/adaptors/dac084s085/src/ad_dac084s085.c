#include "ad_dac_dac084s085_cfg_instance.h"
#include "drv_dac084s085_cfg_instance.h"
#include "dac_cfg_instance.h"
#include "dac_cfg.h"
#include <drv_dac084s085.h>
#include <dac.h>
#include <dac_i.h>

static bool ad_dac084s085_write(dac084s085_t *drv, unsigned channel, int value, bool flush);

void ad_dac084s085_init(void)
{
    int id;

    for (int drv_id = 0; drv_id < DRV_DAC084S085_INSTANCE_COUNT; drv_id++)
    {
        id = ad_dac_dac084s085_instance_table[drv_id].ad_dac;

        dac_table[id].drv_id    = drv_id;
        dac_table[id].drv_open  = (void*)dac084s085_open;
        dac_table[id].write      = (void*)ad_dac084s085_write;
    }
}


static bool ad_dac084s085_write(dac084s085_t *drv, unsigned channel, int value, bool flush)
{
    return dac084s085_write(drv, (uint8_t)channel, (uint16_t)value, flush) == 0 ? true : false;
}


