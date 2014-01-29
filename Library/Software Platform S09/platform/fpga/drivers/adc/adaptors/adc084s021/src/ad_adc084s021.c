#include "ad_adc_adc084s021_cfg_instance.h"
#include "drv_adc084s021_cfg_instance.h"
#include "adc_cfg_instance.h"
#include "adc_cfg.h"
#include <drv_adc084s021.h>
#include <adc.h>
#include <adc_i.h>


static int32_t ad_adc084s021_read(adc084s021_t *drv, unsigned channel);
static int32_t ad_adc084s021_read_multi(adc084s021_t *drv, int *data, size_t channels);


void ad_adc084s021_init(void)
{
    int id;

    for (int drv_id = 0; drv_id < DRV_ADC084S021_INSTANCE_COUNT; drv_id++)
    {
        id = ad_adc_adc084s021_instance_table[drv_id].ad_adc;

        adc_table[id].drv_id    = drv_id;
        adc_table[id].drv_open  = (void*)adc084s021_open;
        adc_table[id].read       = (void*)ad_adc084s021_read;
        adc_table[id].read_multi = (void*)ad_adc084s021_read_multi;
    }
}


static int32_t ad_adc084s021_read(adc084s021_t *drv, unsigned channel)
{
    int32_t val = 0;
    int next_channel;

    next_channel = adc084s021_get_next_channel(drv);

    if (next_channel != channel)
    {
        val = adc084s021_read(drv, channel);    // dummy read
    }

    if (val == -1)
    {
        return ADC_ERR;     // dummy read failed, return error code
    }

    val = adc084s021_read(drv, channel);
    return val == -1 ? ADC_ERR : val;   // return error code if read failed
}


static int32_t ad_adc084s021_read_multi(adc084s021_t *drv, int *data, size_t channels)
{
    int i = 0;
    int32_t val = 0;
    int next_channel;

    next_channel = adc084s021_get_next_channel(drv);

    if (next_channel != 0)
    {
        val = adc084s021_read(drv, 0);      // dummy read
    }

    while (val != -1 && i != channels)
    {
        val = adc084s021_read(drv, i);      // dummy read
        data[i] = val;
    }

    return val == -1 ? ADC_ERR : ADC_OK;
}
