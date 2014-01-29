/*****************************************************************************\
|*
|*  IN PACKAGE:         Custom Instrument Driver
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        Custom Instrument Driver Interface
 */

/**
 * @file
 * This is the driver for the Custom Instrument
 *
 * The CUSTOM_INSTRUMENT component is a fully-customizable 'virtual' instrument
 * with which to monitor and control signals within an FPGA design.
 *
 * To open a Custom Instrument driver for reading and/or writing, use the
 * instrument_open() function. Use instrument_get_value() and instrument_set_value()
 * to read and write values to the Custom Instrument.
 *
 * The generated header file instruments.h defines the signal IDs of the input
 * and output signals of each Custom Instrument instance. The IDs are in the
 * format WrapperInstanceName_SignalName.
 *
 * For a detailed description of the Custom Instrument, see the Core Reference
 * <a href="TR0176 Custom Instrument Reference">Custom Instrument Reference</a>.
 */


#ifndef _DRV_INSTRUMENT_H_
#define _DRV_INSTRUMENT_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>


/**
 * @brief
 *  Custom Instrument data widths
 *
 *  The data widths supported by the Custom Instrument.
 */
typedef enum instrument_drv_datawidth_e
{
    DRV_INSTRUMENT_DATA_WIDTH_8  = 8,       /**< 8  bit data width */
    DRV_INSTRUMENT_DATA_WIDTH_16 = 16,      /**< 16 bit data width */
    DRV_INSTRUMENT_DATA_WIDTH_32 = 32       /**< 32 bit data width */
}
instrument_datawidth_t;


/**
 * @brief
 *  Custom Instrument driver configuration data
 *
 *  Configuration data for the Custom Instrument driver.
 */
typedef struct instrument_drv_s
{
    uint32_t               input_signal_count;         /**< The total number of input signals available in the Custom Instrument device.
                                                            Use signal numbers 0 to (input_signal_count - 1) when writing values to these signals.
                                                            The IDs for the input signals can be found in the generated header file instruments.h. */
    uint32_t               output_signal_count;        /**< The total number of output signals available in the Custom Instrument device.
                                                            Use signal numbers 0 to (output_signal_count - 1) when reading values of these signals.
                                                            The IDs for the output signals can be found in the generated header file instruments.h. */
    instrument_datawidth_t data_width;                 /**< The data width of the Custom Instrument device */
    uintptr_t              base_address;               /**< The base address of the Custom Instrument device */
}
instrument_t;


extern instrument_t *instrument_open(const int id);

extern void     instrument_set_value(instrument_t * restrict drv, const uint32_t signal_id, const uint32_t value);
extern uint32_t instrument_get_value(instrument_t * restrict drv, const uint32_t signal_id);


#ifdef  __cplusplus
}
#endif

#endif /* _DRV_INSTRUMENT_H_ */
