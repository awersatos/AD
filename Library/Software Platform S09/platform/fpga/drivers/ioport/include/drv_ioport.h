/*****************************************************************************\
|*
|*  IN PACKAGE:         IOPORT driver
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        IOPORT driver interface
 */

/**
 * @file
 * This is the driver for the General Purpose I/O Port.
 *
 * An I/O Port is used for transferring data to and from a device. To open an I/O
 * Port for reading and/or writing, use the ioport_open() function. The struct
 * returned by this function will contain the properties of the I/O Port.
 * Use ioport_get_value() and ioport_set_value() to read and write values to the
 * I/O Port.
 *
 * For a detailed description of the I/O Port, see the Core Reference
 * <a href="CR0154 WB_PRTIO Configurable Wishbone Parallel Port Unit.PDF">
 * CR0154 WB_PRTIO Configurable Wishbone Parallel Port Unit</a>.
 */


#ifndef _DRV_IOPORT_H_
#define _DRV_IOPORT_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>


/**
 * @brief
 *  I/O Port data widths
 *
 *  The I/O Port data widths supported.
 */
typedef enum ioport_drv_datawidth_e
{
    DRV_IOPORT_DATA_WIDTH_8  = 8,       /**< 8  bit data width */
    DRV_IOPORT_DATA_WIDTH_16 = 16,      /**< 16 bit data width */
    DRV_IOPORT_DATA_WIDTH_32 = 32       /**< 32 bit data width */
}
ioport_datawidth_t;


/**
 * @brief
 *  I/O Port driver configuration data
 *
 *  Configuration data for the I/O Port driver.
 */
typedef struct ioport_drv_s
{
    uint8_t            port_count;      /**< The total number of ports that can be accessed in the I/O Port.
                                             Use port numbers 0 to (port_count - 1) when reading and writing. */
    ioport_datawidth_t data_width;      /**< The data width of the I/O Port */
    uintptr_t          base_address;    /**< The base address of the I/O Port */
}
ioport_t;


extern ioport_t *ioport_open(const int id);

extern void     ioport_set_value(ioport_t * restrict drv, const uint8_t port, const uint32_t value);
extern uint32_t ioport_get_value(ioport_t * restrict drv, const uint8_t port);


#ifdef  __cplusplus
}
#endif

#endif /* _DRV_IOPORT_H_ */
