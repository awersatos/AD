/*****************************************************************************\
|*
|*  IN PACKAGE:         Custom Instrument Driver
|*
|*  COPYRIGHT:          Copyright (c) 2010, Altium
|*
|*  DESCRIPTION:        Custom Instrument and Digital I/O Driver Interface
 */

#include <stddef.h>
#include <assert.h>

#include <drv_instrument.h>
#include <per_instrument.h>

#include "drv_instrument_cfg_instance.h"

// driver table
static instrument_t instrument_driver_table[DRV_INSTRUMENT_INSTANCE_COUNT];


/**
 * @brief
 *      Writes a value to a specific input signal
 *
 * This function writes a value to a specific input signal in the Custom Instrument or
 * Digital I/O device.
 * Note that if the specified signal ID is invalid, the function will do nothing. Use
 * the signal IDs in the generated header file instruments.h, which are in the format
 * WrapperInstanceName_SignalName.
 * Note that if the data width of the device is actually lower than 32 bits, the value
 * to be written will be truncated.
 *
 * @param  drv
 *      Driver configuration data as returned from instrument_open()
 * @param  signal_id
 *      Signal to write the value to; must be from 0 to (drv->input_signal_count - 1);
 *      valid signal IDs can be found in instruments.h
 * @param  value
 *      Value to be written
 *
 * @return none
 */
void instrument_set_value(instrument_t * restrict drv, unsigned int signal_id, uint32_t value)
{
    assert(drv != NULL);

    // write the data if the signal id and the base address are valid
    if ((signal_id < drv->input_signal_count) && (drv->base_address != 0))
    {
        switch (drv->data_width)
        {
        case DRV_INSTRUMENT_DATA_WIDTH_8:
            INSTRUMENT_BASE8(drv->base_address)[signal_id] = (uint8_t) value;
            break;
        case DRV_INSTRUMENT_DATA_WIDTH_16:
            INSTRUMENT_BASE16(drv->base_address)[signal_id] = (uint16_t) value;
            break;
        case DRV_INSTRUMENT_DATA_WIDTH_32:
            INSTRUMENT_BASE32(drv->base_address)[signal_id] = value;
            break;
        default:
            /* should not happen */
            break;
        }
    }
}


/**
 * @brief
 *      Read a value from a specific output signal
 *
 * This function reads a value from a specific output signal in the Custom Instrument or
 * Digital I/O device.
 * Note that if the specified signal ID is invalid, the function will return 0. Use the
 * signal IDs in the generated header file instruments.h, which are in the format
 * WrapperInstanceName_SignalName.
 *
 * @param  drv
 *      Driver configuration data
 * @param  signal_id
 *      Signal to retrieve the value from; must be from 0 to (drv->output_signal_count - 1);
 *      valid signal IDs can be found in instruments.h
 *
 * @return the value of the signal if the signal ID is valid, or 0 otherwise.
 */
uint32_t instrument_get_value(instrument_t * restrict drv, unsigned int signal_id)
{
    assert(drv != NULL);

    uint32_t value = 0;

    // read the data if the signal id and base address are valid
    if ((signal_id < drv->output_signal_count) && (drv->base_address != 0))
    {
        switch (drv->data_width)
        {
        case DRV_INSTRUMENT_DATA_WIDTH_8:
            value = INSTRUMENT_BASE8(drv->base_address)[signal_id];
            break;
        case DRV_INSTRUMENT_DATA_WIDTH_16:
            value = INSTRUMENT_BASE16(drv->base_address)[signal_id];
            break;
        case DRV_INSTRUMENT_DATA_WIDTH_32:
            value = INSTRUMENT_BASE32(drv->base_address)[signal_id];
            break;
        default:
            /* should not happen */
            break;
        }
    }

    return value;
}


/**
 * @brief
 *      Open an instance of the Custom Instrument driver
 *
 * This function opens an instance of a Custom Instrument driver. The properties of the
 * Custom Instrument or Digital I/O device are stored in the configuration data returned.
 *
 * @param  id
 *      Valid driver ID (see devices.h)
 *
 * @return pointer to configuration data for the specified device, or NULL for invalid id
 */
instrument_t *instrument_open(unsigned int id)
{
    if (id < DRV_INSTRUMENT_INSTANCE_COUNT)
    {
        instrument_t *restrict drv = &instrument_driver_table[id];

        if (drv->base_address == 0)
        {
            // get the configuration of the driver and wrapper created by the plugin system
            const drv_instrument_cfg_instance_t *restrict drv_cfg;
            const per_instrument_cfg_instance_t *restrict per_cfg;

            drv_cfg = &drv_instrument_instance_table[id];
            per_cfg = &per_instrument_instance_table[drv_cfg->per_instrument];

            // copy the configuration to the driver
            drv->base_address        = per_cfg->baseaddress;
            drv->input_signal_count  = per_cfg->inputsignalscount;
            drv->output_signal_count = per_cfg->outputsignalscount;

            switch (per_cfg->datawidth)
            {
            case PER_INSTRUMENT_DATAWIDTH_8:
                drv->data_width = DRV_INSTRUMENT_DATA_WIDTH_8;
                break;
            case PER_INSTRUMENT_DATAWIDTH_16:
                drv->data_width = DRV_INSTRUMENT_DATA_WIDTH_16;
                break;
            case PER_INSTRUMENT_DATAWIDTH_32:
                drv->data_width = DRV_INSTRUMENT_DATA_WIDTH_32;
                break;
            default:
                /* should not happen */
                break;
            }

            // check the configuration of the driver
            assert(drv->base_address != 0);
        }
        return drv;
    }
    return NULL;
}

