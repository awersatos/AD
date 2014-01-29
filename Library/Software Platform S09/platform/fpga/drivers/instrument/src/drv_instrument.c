/*****************************************************************************\
|*
|*  IN PACKAGE:         Custom Instrument Driver
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        Custom Instrument Driver Interface
 */

#include <stdlib.h>
#include <assert.h>

#include <drv_instrument.h>
#include <per_instrument.h>

#include "drv_instrument_cfg_instance.h"

// table of Custom Instrument driver instances
static instrument_t instrument_driver_table[DRV_INSTRUMENT_INSTANCE_COUNT];


/**
 * @brief
 * Writes a value to a specific input signal of the Custom Instrument device
 *
 * This function writes a value to a specific input signal in the Custom Instrument device.
 * Note that if the specified signal ID is invalid, the function will do nothing. Use the
 * signal IDs in the generated header file instruments.h, which are in the format
 * WrapperInstanceName_SignalName.
 * Note that if the data width of the Custom Instrument device is actually lower than
 * 32 bits, the value to be written will be truncated.
 *
 * @param  drv         Custom Instrument driver configuration data
 * @param  signal_id   the signal to write the value to; must be from 0 to (drv->input_signal_count - 1); valid signal IDs can be found in instruments.h
 * @param  value       the value to be written
 * @return none
 */
void instrument_set_value(instrument_t * restrict drv, const uint32_t signal_id, const uint32_t value)
{
    assert(drv != NULL);

    // write the data if the signal id and the base address are valid
    if ((signal_id < drv->input_signal_count) && (drv->base_address != 0))
    {
         if (drv->data_width == DRV_INSTRUMENT_DATA_WIDTH_8)
         {
              INSTRUMENT_BASE8(drv->base_address)[signal_id] = (uint8_t) value;
         }
         else if (drv->data_width == DRV_INSTRUMENT_DATA_WIDTH_16)
         {
              INSTRUMENT_BASE16(drv->base_address)[signal_id] = (uint16_t) value;
         }
         else if (drv->data_width == DRV_INSTRUMENT_DATA_WIDTH_32)
         {
              INSTRUMENT_BASE32(drv->base_address)[signal_id] = value;
         }
    }
}


/**
 * @brief
 * Read a value from a specific output signal of the Custom Instrument device
 *
 * This function reads a value from a specific output signal in the Custom Instrument device.
 * Note that if the specified signal ID is invalid, the function will return zero. Use the
 * signal IDs in the generated header file instruments.h, which are in the format
 * WrapperInstanceName_SignalName.
 *
 * @param  drv        Custom Instrument driver configuration data
 * @param  signal_id  the signal to retrieve the value from; must be from 0 to (drv->output_signal_count - 1); valid signal IDs can be found in instruments.h
 * @return            the value of the signal if the signal ID is valid, otherwise returns zero
 */
uint32_t instrument_get_value(instrument_t * restrict drv, const uint32_t signal_id)
{
    assert(drv != NULL);

    uint32_t value = 0;

    // read the data if the signal id and base address are valid
    if ((signal_id < drv->output_signal_count) && (drv->base_address != 0))
    {
         if (drv->data_width == DRV_INSTRUMENT_DATA_WIDTH_8)
         {
              value = INSTRUMENT_BASE8(drv->base_address)[signal_id];
         }
         else if (drv->data_width == DRV_INSTRUMENT_DATA_WIDTH_16)
         {
              value = INSTRUMENT_BASE16(drv->base_address)[signal_id];
         }
         else if (drv->data_width == DRV_INSTRUMENT_DATA_WIDTH_32)
         {
              value = INSTRUMENT_BASE32(drv->base_address)[signal_id];
         }
    }

    return value;
}


/**
 * @brief
 * Open an instance of a Custom Instrument driver
 *
 * This function opens an instance of a Custom Instrument driver. The Custom
 * Instrument device's properties are stored in the configuration data returned.
 *
 * @param  id   a valid driver ID
 * @return      configuration data for the Custom Instrument driver
 */
instrument_t *instrument_open(const int id)
{
    assert((id >= 0) && (id < DRV_INSTRUMENT_INSTANCE_COUNT));

    // get the configuration of the driver and wrapper created by the plugin system
    instrument_t *restrict drv = &instrument_driver_table[id];
    drv_instrument_cfg_instance_t *restrict drv_cfg = &drv_instrument_instance_table[id];
    per_instrument_cfg_instance_t *restrict per_cfg = &per_instrument_instance_table[drv_cfg->per_instrument];

    // copy the configuration to the driver
    drv->base_address = per_cfg->baseaddress;
    drv->input_signal_count = per_cfg->inputsignalscount;
    drv->output_signal_count = per_cfg->outputsignalscount;
    if (per_cfg->datawidth == PER_INSTRUMENT_DATAWIDTH_8)
    {
        drv->data_width = DRV_INSTRUMENT_DATA_WIDTH_8;
    }
    else if (per_cfg->datawidth == PER_INSTRUMENT_DATAWIDTH_16)
    {
        drv->data_width = DRV_INSTRUMENT_DATA_WIDTH_16;
    }
    else if (per_cfg->datawidth == PER_INSTRUMENT_DATAWIDTH_32)
    {
        drv->data_width = DRV_INSTRUMENT_DATA_WIDTH_32;
    }

    // check the configuration of the driver
    assert(drv->base_address != 0);

    return drv;
}

