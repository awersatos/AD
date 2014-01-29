/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        TERMINAL peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
|* For a detailed description of the WB_TERMINAL peripheral, see the Core Reference
|* <a href="CR0180 TERMINAL Debug Console Instrument.PDF">CR0180 TERMINAL Debug Console Instrument</a>|*
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the TERMINAL peripheral.
 * Generally, application writers will use a higher level interface.
 *
 *
 */

#ifndef _PER_TERMINAL_H
#define _PER_TERMINAL_H

#include <stdint.h>

#define TERMINAL_BASE(baseaddr)    ((volatile uint8_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define TERMINAL_STATUS(addr)       TERMINAL_BASE(addr)[4]    /**< Device status */
#define TERMINAL_INTCTRL(addr)      TERMINAL_BASE(addr)[5]    /**< Interrupt control */
#define TERMINAL_INTSTATUS(addr)    TERMINAL_BASE(addr)[6]    /**< Interrupt status */
#define TERMINAL_SBUF(addr)         TERMINAL_BASE(addr)[7]    /**< Serial transmit / receive buffer */
/** @} */


/**
 * @name Core STATUS/INTCTRL/INTSTATUS Register Bitmasks
 */
/** @{ */
#define TERMINAL_STATUS_TXFULL      0x01   /**< Transmitter FIFO is full */
#define TERMINAL_STATUS_TXEMPTY     0x02   /**< Transmitter FIFO is empty */
#define TERMINAL_STATUS_TXSHEMPTY   0x08   /**< Transmitter shift register is empty */
#define TERMINAL_STATUS_RXNEMPTY    0x20   /**< Receiver FIFO is not empty */
#define TERMINAL_STATUS_RXFULL      0x80   /**< Receiver FIFO is full */
/** @} */


#endif /* _TERMINAL_H */

