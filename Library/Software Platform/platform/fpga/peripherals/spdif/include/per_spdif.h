/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        SPDIF peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the WB_SPDIF peripheral.
 * Generally, application writers will use a higher level interface.
 *
 */

#ifndef _PER_SPDIF_H
#define _PER_SPDIF_H

#include <stdint.h>

#define SPDIF_BASE(baseaddr)      ((volatile uint32_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define SPDIF_VERSION(addr)             SPDIF_BASE(addr)[0]         /**< Version Register */
#define SPDIF_RX_CONFIG(addr)           SPDIF_BASE(addr)[1]         /**< Receiver Configuration Register */
#define SPDIF_RX_STATUS(addr)           SPDIF_BASE(addr)[2]         /**< Receiver Status Register */
#define SPDIF_RX_DATA(addr)             SPDIF_BASE(addr)[3]         /**< Receiver Data Register */
#define SPDIF_RX_DATA_COUNT(addr)       SPDIF_BASE(addr)[4]         /**< Receiver FIFO Data Count Register */
#define SPDIF_RX_FIFO_WATERMARK(addr)   SPDIF_BASE(addr)[5]         /**< Receiver "Allmost Full" Watermark Register */
#define SPDIF_RX_CHANNEL_STATUS(addr)   SPDIF_BASE(addr)[6]         /**< Receiver Channel Status bits */
#define SPDIF_RX_USER_DATA(addr)        SPDIF_BASE(addr)[7]         /**< Receiver User Data bits */

#define SPDIF_TX_CONFIG(addr)           SPDIF_BASE(addr)[8]         /**< Transmitter Configuration Register */
#define SPDIF_TX_STATUS(addr)           SPDIF_BASE(addr)[9]         /**< Transmitter Status Register */
#define SPDIF_TX_DATA(addr)             SPDIF_BASE(addr)[10]        /**< Transmitter Data Register */
#define SPDIF_TX_FIFO_FREE_SLOTS(addr)  SPDIF_BASE(addr)[11]        /**< Transmitter FIFO Data Count Register */
#define SPDIF_TX_PRESCALER(addr)        SPDIF_BASE(addr)[12]        /**< Transmitter Prescaler Register */
#define SPDIF_TX_FIFO_WATERMARK(addr)   SPDIF_BASE(addr)[13]        /**< Transmitter "Allmost Empty" Watermark Register */
#define SPDIF_TX_CHANNEL_STATUS(addr)   SPDIF_BASE(addr)[14]        /**< Transmitter Channel Status bits */
#define SPDIF_TX_USER_DATA(addr)        SPDIF_BASE(addr)[15]        /**< Transmitter User Data bits */
/** @} */                                                       

/**
 * @name Receiver Configuration Register Bit Masks
 */
/** @{ */
#define SPDIF_RX_ENABLE                 (0x00000001 << 31)          /**< Receiver enable */
#define SPDIF_RX_IE                     (0x00000001 << 30)          /**< Receiver interrupt enable */
#define SPDIF_RX_RST                    (0x00000001 << 29)          /**< Receiver reset */
#define SPDIF_RX_FIFO_RST               (0x00000001 << 28)          /**< Receiver FIFO reset */
#define SPDIF_RX_IE_BLOCK_START         (0x00000001 << 7)           /**< Receiver stream synchronization lost interrupt enable */
#define SPDIF_RX_IE_PARITY_ERROR        (0x00000001 << 6)           /**< Receiver stream synchronization lost interrupt enable */
#define SPDIF_RX_IE_SYNC_ERROR          (0x00000001 << 4)           /**< Receiver stream synchronization lost interrupt enable */
#define SPDIF_RX_IE_FIFO_F              (0x00000001 << 1)           /**< Receiver FIFO full interrupt enable */
#define SPDIF_RX_IE_FIFO_AF             (0x00000001 << 0)           /**< Receiver FIFO almost full interrupt enable */

/**
 * @name Receiver Status Register Bit Masks
 */
/** @{ */
#define SPDIF_RX_FIFO_SIZE              0xFFFF0000                  /**< RX FIFO size (ReadOnly) */
#define SPDIF_RX_FIFO_FULL              (0x00000001 << 9)           /**< Receiver FIFO full */
#define SPDIF_RX_FIFO_AFULL             (0x00000001 << 8)           /**< Receiver FIFO almost full */
#define SPDIF_RX_INT_BLOCK_START        (0x00000001 << 7)           /**< RX FIFO empty */
#define SPDIF_RX_INT_PARITY_ERROR       (0x00000001 << 6)           /**< RX FIFO empty */
#define SPDIF_RX_FIFO_EMPTY             (0x00000001 << 5)           /**< RX FIFO empty */
#define SPDIF_RX_SYNCH_ERROR            (0x00000001 << 4)           /**< Receiver stream synchronization lost */
#define SPDIF_RX_INT_FIFO_FULL          (0x00000001 << 1)           /**< Receiver Interrupt FIFO full */
#define SPDIF_RX_INT_FIFO_AFULL         (0x00000001 << 0)           /**< Receiver Interrupt FIFO almost full */
/** @} */

/**
 * @name Transmitter Configuration Register Bits
 */
/** @{ */
#define SPDIF_TX_ENABLE                 (0x00000001 << 31)          /**< Transmitter enable */
#define SPDIF_TX_IE                     (0x00000001 << 30)          /**< Transmitter interrupt enable */
#define SPDIF_TX_RST                    (0x00000001 << 29)          /**< Transmitter reset */
#define SPDIF_TX_FIFO_RST               (0x00000001 << 28)          /**< Transmitter FIFO reset */
#define SPDIF_TX_PRESCALER_EN           (0x00000001 << 27)          /**< Transmitter prescaler enable */
#define SPDIF_TX_FRAME_ENABLE           (0x00000001 << 26)          /**< Transmitter enable hardware framing */
#define SPDIF_TX_PARITY_ENABLE          (0x00000001 << 25)          /**< Transmitter hardware generates parity */
#define SPDIF_TX_USE_USER_DATA          (0x00000001 << 24)          /**< Transmitter uses user provided userdata / channelstatus */
#define SPDIF_TX_IE_FIFO_EMPTY          (0x00000001 << 1)           /**< Transmitter FIFO empty interrupt enable */
#define SPDIF_TX_IE_FIFO_ALMOST_EMPTY   (0x00000001 << 0)           /**< Transmitter FIFO almost empty interrupt enable */
/** @} */

/**
 * @name Transmitter Status Register Bits
 */
/** @{ */
#define SPDIF_TX_FIFO_SIZE              0xFFFF0000                  /**< Mask for transmitter fifo size */
#define SPDIF_TX_FIFO_EMPTY             (0x00000001 << 4)           /**< Transmit FIFO empty */
#define SPDIF_TX_FIFO_ALMOST_EMPTY      (0x00000001 << 3)           /**< Transmit FIFO almost empty */
#define SPDIF_TX_FIFO_FULL              (0x00000001 << 2)           /**< Transmit FIFO full */
#define SPDIF_TX_INT_FIFO_EMPTY         (0x00000001 << 1)           /**< Transmit Interrupt FIFO empty */
#define SPDIF_TX_INT_FIFO_ALMOST_EMPTY  (0x00000001 << 0)           /**< Transmit Interrupt FIFO almost empty */
/** @} */

/**
 * @name Data Format Bits
 */
 
/** @{ */
#define SPDIF_DATA_FLAG_BS              (0x00000001 << 31)      /**< 0 = Subframe, 1 = Block start - TX needs this only if TX_FRAME_ENABLE is off */
#define SPDIF_DATA_FLAG_CC              (0x00000001 << 30)      /**< 0 = Left channel (channel 'A'), 1 = Right channel (channel 'B') - TX needs this only if TX_FRAME_ENABLE if off */
#define SPDIF_DATA_FLAG_PE              (0x00000001 << 29)      /**< 1 = Parity error, receiver only (set to 0 for transmitter) */
#define SPDIF_DATA_DV                   (0x00000001 << 27)      /**< 0 = Data valid, 1 = data invalid */
#define SPDIF_DATA_UD                   (0x00000001 << 26)      /**< User data bit */
#define SPDIF_DATA_CS                   (0x00000001 << 25)      /**< Channel status bit */
#define SPDIF_DATA_P                    (0x00000001 << 24)      /**< Parity bit */
#define SPDIF_DATA_MASK                 0x00FFFFFF              /**< Data mask, 24 bit data */
/** @} */

#endif /* _SPDIF_H */

