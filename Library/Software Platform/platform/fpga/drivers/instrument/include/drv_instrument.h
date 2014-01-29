/*****************************************************************************\
|*
|*  IN PACKAGE:         Custom Instrument Driver
|*
|*  COPYRIGHT:          Copyright (c) 2010, Altium
|*
|*  DESCRIPTION:        Custom Instrument Driver Interface
 */

/**
 * @file
 *      Driver for Custom Instrument and Digital I/O devices
 *
 * The CUSTOM_INSTRUMENT and DIGITAL_IO components are a fully-customizable 'virtual'
 * instruments with which to monitor and control signals within an FPGA design.
 *
 * To open a driver instance for reading and/or writing, use the instrument_open()
 * function. Use instrument_get_value() and instrument_set_value() to read and write
 * values to the device.
 *
 * The generated header file instruments.h defines the signal IDs of the input
 * and output signals of each Custom Instrument and Digital I/O compoment. The IDs are
 * in the format WrapperInstanceName_SignalName.
 *
 * For a detailed description of the Custom Instrument, see the Core Reference
 * <a href="TR0176 Custom Instrument Reference">Custom Instrument Reference</a>.
 *
 * For Digital I/O see the Core Reference
 * <a href="CR0179 DIGITAL_IO Configurable Digital IO Module.PDF">Configurable Digital IO Module</a>
 */

#ifndef _DRV_INSTRUMENT_H_
#define _DRV_INSTRUMENT_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>


/**
 * @brief
 *      Device data width
 *
 *  The data width supported by the Custom Instrument or Digital I/O device.
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
 *      Driver configuration data
 *
 *  Configuration data for the Custom Instrument driver.
 */
typedef struct instrument_drv_s
{
    unsigned int           input_signal_count;         /**< The total number of input signals available in the device.
                                                            Use signal numbers 0 to (input_signal_count - 1) when writing values to these signals.
                                                            The IDs for the input signals can be found in the generated header file instruments.h. */
    unsigned int           output_signal_count;        /**< The total number of output signals available in the device.
                                                            Use signal numbers 0 to (output_signal_count - 1) when reading values of these signals.
                                                            The IDs for the output signals can be found in the generated header file instruments.h. */
    instrument_datawidth_t data_width;                 /**< The data width of the device */
    uintptr_t              base_address;               /**< The base address of the device */
}
instrument_t;


extern instrument_t *instrument_open(unsigned int id);

extern void     instrument_set_value(instrument_t * restrict drv, unsigned int signal_id, uint32_t value);
extern uint32_t instrument_get_value(instrument_t * restrict drv, unsigned int signal_id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_INSTRUMENT_H_ */
