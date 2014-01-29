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
    int dac_id;
    int drv_id;

    for (int adaptor_id = 0; adaptor_id < AD_DAC_DAC084S085_INSTANCE_COUNT; adaptor_id++)
    {
        dac_id = ad_dac_dac084s085_instance_table[adaptor_id].ad_dac;
        drv_id = ad_dac_dac084s085_instance_table[adaptor_id].drv_dac084s085;

        dac_register_adaptor( dac_id,
                              drv_id,
                              (void*)dac084s085_open,
                              (void*)ad_dac084s085_write );
    }
}


static bool ad_dac084s085_write(dac084s085_t *drv, unsigned channel, int value, bool flush)
{
    return dac084s085_write(drv, (uint8_t)channel, (uint16_t)value, flush) == 0 ? true : false;
}


