#include <dac.h>
#include <dac_i.h>
#include <stdio.h>
#include <assert.h>
#include "dac_cfg_instance.h"
#include "dac_cfg.h"
#include <stdint.h>


dac_t dac_table[DAC_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the DAC device driver.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

dac_t *dac_open(unsigned int id)
{
    assert(id < DAC_INSTANCE_COUNT);

    dac_t * restrict srv = &dac_table[id];

    if (srv->drv == NULL)
    {
        srv->drv = srv->drv_open(srv->drv_id);
    }
    return srv->drv ? srv : NULL;
}


/**
 * @brief    Write a value to the DA converter
 *
 * This function writes a single value to the DAC. The value for the channel is stored internally. 
 * If flush is true the internally stored values of all channels are updated to the output.
 *
 * @param  dac      pointer to a valid device driver
 * @param  channel  DAC-channel to write to
 * @param  flush    update all outputs
 *
 * @return DAC_ERR on error, value read from ADC otherwise
 */

bool dac_write(dac_t *dac, unsigned channel, int value, bool flush)
{
    return dac->write(dac->drv, channel, value, flush);
}


