/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        I2S peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the WB_I2S peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the WB_I2S peripheral, see the Core Reference
 * <a href="CR0186 WB_I2S Configurable Audio Streaming Controller.PDF">CR0186 WB_I2S Configurable Audio Streaming Controller</a>
 *
 */

#ifndef _PER_I2S_H
#define _PER_I2S_H

#include <stdint.h>

#define I2S_BASE(baseaddr)      ((volatile uint32_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define I2S_CONTROL(addr)       I2S_BASE(addr)[0]       /**< Control Register */
#define I2S_MODE(addr)          I2S_BASE(addr)[1]       /**< Mode Register */
#define I2S_STATUS(addr)        I2S_BASE(addr)[2]       /**< Status Register */
#define I2S_DATA(addr)          I2S_BASE(addr)[3]       /**< Data Register */
#define I2S_RX_POINTERS(addr)   I2S_BASE(addr)[4]       /**< Receiver FIFO Pointers Register */
#define I2S_TX_POINTERS(addr)   I2S_BASE(addr)[5]       /**< Transmitter FIFO Pointers Register */
/** @} */

/**
 * @name Mode Register Bit Masks
 */
/** @{ */
#define I2S_WWIDTH              0x003F  /**< Word Width (16,20,24,32) */
#define I2S_MONO_OUT            0x0100  /**< Stereo Out(0) or Mono Out(1) */
#define I2S_MONO_IN             0x0200  /**< Stereo In(0) or Mono In(1) */
#define I2S_MONO_IN_LR          0x0400  /**< Left(0) or Right(1) Mono In */
#define I2S_ENABLE_TX           0x0800  /**< Transmitter Disable(0) or Enable(1) */
#define I2S_ENABLE_RX           0x1000  /**< Receiver Disable(0) or Enable(1) */
#define I2S_ENABLE_TX_INT       0x2000  /**< Transmitter Interrupt Disable(0) or Enable(1) */
#define I2S_ENABLE_RX_INT       0x4000  /**< Receiver Interrupt Disable(0) or Enable(1) */
/** @} */

/**
 * @name Status Register Bits
 */
/** @{ */
#define I2S_FIFO_OUT_LR         0x01    /**< Transmit FIFO State is Left(0) or Right(1) */
#define I2S_FIFO_OUT_EMPTY      0x02    /**< Transmit FIFO is Not-Empty(0) or Empty(1) */
#define I2S_FIFO_OUT_FULL       0x04    /**< Transmit FIFO is Not-Full(0) or Full(1) */
#define I2S_FIFO_OUT_WATERMARK  0x08    /**< Transmit FIFO Watermark is Not-Reached(0) or Reached(1) */
#define I2S_FIFO_IN_LR          0x10    /**< Receive FIFO State is Left(0) or Right(1) */
#define I2S_FIFO_IN_EMPTY       0x20    /**< Receive FIFO is Not-Empty(0) or Empty(1) */
#define I2S_FIFO_IN_FULL        0x40    /**< Receive FIFO is Not-Full(0) or Full(1) */
#define I2S_FIFO_IN_WATERMARK   0x80    /**< Receive FIFO Watermark is Not-Reached(0) or Reached(1) */
/** @} */

#endif /* _I2S_H */

