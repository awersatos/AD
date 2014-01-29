#include <adc.h>
#include <adc_i.h>
#include <stdio.h>
#include <assert.h>
#include "adc_cfg_instance.h"
#include "adc_cfg.h"
#include <stdint.h>


adc_t adc_table[ADC_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the ADC device driver.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

adc_t *adc_open(unsigned int id)
{
    assert(id < ADC_INSTANCE_COUNT);

    adc_t * restrict srv = &adc_table[id];

    if (srv->drv == NULL)
    {
        srv->drv = srv->drv_open(srv->drv_id);
    }
    return srv->drv ? srv : NULL;
}


/**
 * @brief    Read a single value from the AD converter
 *
 * This function reads a single value from the given channnel of the AD device. 
 *
 * @param  adc      pointer to a valid device driver
 * @param  channel  AD-channel to read from
 *
 * @return ADC_ERR on error, value read from ADC otherwise
 */

int adc_read(adc_t *adc, unsigned channel)
{
    return adc->read(adc->drv, channel);
}


/**
 * @brief    Read multiple channels from the AD converter at once
 *
 * This function reads multiple channnels from the ADC. 
 * The provided buffer must be large enough to store the results.
 *
 * @param  adc      pointer to a valid device driver
 * @param  data     pointer to memory to store channel-data in
 * @param  nr       number of channels to read
 *
 * @return ADC_ERR on error, 0 on succes
 */

int adc_read_multichannel(adc_t *adc, int *data, int nr)
{
    return adc->read_multi(adc->drv, data, nr);
}

