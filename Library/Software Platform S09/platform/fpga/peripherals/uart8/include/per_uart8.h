/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        UART8 peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the WB_UART8 peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the WB_UART8 peripheral, see the Core Reference
 * <a href="CR0157 WB_UART8 Serial Communications Port.PDF">CR0157 WB_UART8 Serial Communications Port</a>
 *
 */

#ifndef _PER_UART8_H
#define _PER_UART8_H

#include <stdint.h>

#define UART8_BASE(baseaddr)    ((volatile uint8_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define UART8_BRGHIGH(addr)      UART8_BASE(addr)[0]    /**< Baudrate register, bits 23-16 */
#define UART8_BRGMID(addr)       UART8_BASE(addr)[1]    /**< Baudrate register, bits 15-8 */
#define UART8_BRGLOW(addr)       UART8_BASE(addr)[2]    /**< Baudrate register, bits 7-0 */
#define UART8_LCR(addr)          UART8_BASE(addr)[3]    /**< Line Control */
#define UART8_STATUS(addr)       UART8_BASE(addr)[4]    /**< Device status */
#define UART8_INTMASK_SET(addr)  UART8_BASE(addr)[5]    /**< Interrupt mask read & set */
#define UART8_INTMASK_RST(addr)  UART8_BASE(addr)[6]    /**< Interrupt mask reset */
#define UART8_SBUF(addr)         UART8_BASE(addr)[7]    /**< Serial transmit / receive buffer */
#define UART8_TXLOWMARK(addr)    UART8_BASE(addr)[8]    /**< Transmitter low watermark (signals on underflow) */
#define UART8_RXHIGHMARK(addr)   UART8_BASE(addr)[9]    /**< Receiver high watermark (signals on overflow) */
#define UART8_RXLOWMARK(addr)    UART8_BASE(addr)[10]   /**< Receiver low watermark (resets overflow signalling) */
#define UART8_RXDTO(addr)        UART8_BASE(addr)[11]   /**< Receiver timeout (signals not empty) */
#define UART8_ICD(addr)          UART8_BASE(addr)[12]   /**< Inter character delay */
#define UART8_BRKLEN(addr)       UART8_BASE(addr)[13]   /**< Break length */
/** @} */


/**
 * @name Core LCR Register Bitmasks
 */
/** @{ */
#define UART8_LCR_CTSEN          0x01   /**< Use CTS/RTS handshake mechanism */
#define UART8_LCR_FORCERTS       0x02   /**< Force RTS to a known state */
#define UART8_LCR_RTSVAL         0x04   /**< State to force RTS to */
#define UART8_LCR_RXD            0x20   /**< RXD input */
#define UART8_LCR_BREAK          0x40   /**< Top character in receiver FIFO is a BREAK */
#define UART8_LCR_CTS            0x80   /**< CTS input*/
/** @} */


/**
 * @name Core STATUS/INTCTRL/INTSTATUS Register Bitmasks
 */
/** @{ */
#define UART8_STATUS_TXFULL      0x01   /**< Transmitter FIFO is full */
#define UART8_STATUS_TXEMPTY     0x02   /**< Transmitter FIFO is empty */
#define UART8_STATUS_TXLOW       0x04   /**< Transmitter FIFO is almost empty */
#define UART8_STATUS_TXSHEMPTY   0x08   /**< Transmitter shift register is empty */
#define UART8_STATUS_RXTIMEOUT   0x10   /**< Receiver FIFO has unread characters and delay time has passed */
#define UART8_STATUS_RXNEMPTY    0x20   /**< Receiver FIFO is not empty */
#define UART8_STATUS_RXHIGH      0x40   /**< Receiver FIFO is almost full */
#define UART8_STATUS_RXFULL      0x80   /**< Receiver FIFO is full */
/** @} */


#endif /* _UART8_H */

