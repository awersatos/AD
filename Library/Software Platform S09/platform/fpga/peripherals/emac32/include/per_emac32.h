/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        EMAC32 peripheral direct access
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the EMAC32 peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * See also CR0122 EMACx Controller
 */


#ifndef _PER_EMAC32_H
#define _PER_EMAC32_H

#include "per_emac32_cfg.h"
#include "per_emac32_cfg_instance.h"

#define EMAC32_BASE(base)  ((volatile uint32_t *) base)

/**
 * @name Core Receive Registers
 */

/** @{ */
#define EMAC32_RX_CMD(base)      EMAC32_BASE(base)[0]  /**< Receiver Command Register */
#define EMAC32_RX_STATUS(base)   EMAC32_BASE(base)[1]  /**< Receiver Status Register */
#define EMAC32_RX_INT(base)      EMAC32_BASE(base)[2]  /**< Receiver Interrupt Register */
#define EMAC32_RX_CRCERR(base)   EMAC32_BASE(base)[3]  /**< Receiver CRC-Error Counter Register */
#define EMAC32_RX_START(base)    EMAC32_BASE(base)[4]  /**< Receiver Start Address Register */
#define EMAC32_RX_END(base)      EMAC32_BASE(base)[5]  /**< Receiver End Address Register */
#define EMAC32_RX_INPUT(base)    EMAC32_BASE(base)[6]  /**< Receiver Input Address Register */
#define EMAC32_RX_OUTPUT(base)   EMAC32_BASE(base)[7]  /**< Receiver Output Address Register */
#define EMAC32_RX_MAC1(base)     EMAC32_BASE(base)[8]  /**< Receiver MAC Address Register Part 1*/
#define EMAC32_RX_MAC2(base)     EMAC32_BASE(base)[9]  /**< Receiver MAC Address Register Part 2 */
/** @} */

/**
 * @name Version Register
 */
#define EMAC32_VERSION(base)     EMAC32_BASE(base)[15]  /**< EMAC32 Core Version Register */
/** @} */



/**
 * @name Core Transmit Registers
 */

/** @{ */
#define EMAC32_TX_CMD(base)      EMAC32_BASE(base)[16]  /**< Transmitter Command Register */
#define EMAC32_TX_STATUS(base)   EMAC32_BASE(base)[17]  /**< Transmitter Status Register */
#define EMAC32_TX_INT(base)      EMAC32_BASE(base)[18]  /**< Transmitter Interrupt Register */
#define EMAC32_TX_COLLERR(base)  EMAC32_BASE(base)[19]  /**< Transmitter Collision-Error Counter Register */
#define EMAC32_TX_START(base)    EMAC32_BASE(base)[20]  /**< Transmitter Start Address Register */
#define EMAC32_TX_END(base)      EMAC32_BASE(base)[21]  /**< Transmitter End Address Register */
#define EMAC32_TX_INPUT(base)    EMAC32_BASE(base)[22]  /**< Transmitter Input Address Register */
#define EMAC32_TX_OUTPUT(base)   EMAC32_BASE(base)[23]  /**< Transmitter Output Address Register */
/** @} */

/**
 * @name Core MDI (Management Data Interface) Registers
 */

/** @{ */
#define EMAC32_MDI_CMD(base)     EMAC32_BASE(base)[28]  /**< MDI PHY Command Register */
#define EMAC32_MDI_PHYADDR(base) EMAC32_BASE(base)[29]  /**< MDI PHY Address Register */
#define EMAC32_MDI_REGADDR(base) EMAC32_BASE(base)[30]  /**< MDI PHY Internal Address Register */
#define EMAC32_MDI_DATA(base)    EMAC32_BASE(base)[31]  /**< MDI PHY Data Output Register */
/** @} */


/**
 * @name Core receiver command register bitmasks
 */

/** @{ */
#define EMAC32_RX_CMD_ENABLE               0x00000001   /**< Receiver Enable */
#define EMAC32_RX_CMD_UNICAST              0x00000002   /**< Unicast Mode */
#define EMAC32_RX_CMD_BROADCAST            0x00000004   /**< Broadcast Mode */
#define EMAC32_RX_CMD_MULTICAST            0x00000008   /**< Multicast Mode */
#define EMAC32_RX_CMD_PROMISC              0x00000010   /**< Promiscuous Mode */
#define EMAC32_RX_CMD_CLR_OVERFL           0x00000020   /**< Clear Overflow */
#define EMAC32_RX_CMD_CLR_CRCERR           0x00000040   /**< Clear CRC Error Counter bit */
#define EMAC32_RX_CMD_RESET                0x80000000   /**< Receiver Software Reset */
/** @} */


/**
 * @name Core receiver status register bitmasks
 */

/** @{ */
#define EMAC32_RX_STATUS_ENABLE            0x00000001   /**< Receiver Enable */
#define EMAC32_RX_STATUS_BUSY              0x00000002   /**< Busy */
#define EMAC32_RX_STATUS_LACKOFSPACE       0x00000004   /**< Lack Of Space */
#define EMAC32_RX_STATUS_OVERFLOW          0x00000008   /**< Overflow */
#define EMAC32_RX_STATUS_INT_FRAMEOK       0x00010000   /**< Frame OK Interrupt */
#define EMAC32_RX_STATUS_INT_LACKOFSPACE   0x00020000   /**< Lack Of Space Interrupt */
#define EMAC32_RX_STATUS_INT_OVERFLOW      0x00040000   /**< Overflow Interrupt */
#define EMAC32_RX_STATUS_RESET             0x80000000   /**< Receiver Reset */
/** @} */


/**
 * @name Core receiver interrupt enable register bitmasks
 */

/** @{ */
#define EMAC32_RX_INT_FRAMEOK              0x00000001   /**< Frame OK Interrupt Enable */
#define EMAC32_RX_INT_LACKOFSPACE          0x00000002   /**< Lack Of Space Interrupt Enable */
#define EMAC32_RX_INT_OVERFLOW             0x00000004   /**< Overflow Interrupt Enable */
/** @} */


/**
 * @name Core transmitter command register bitmasks
 */

/** @{ */
#define EMAC32_TX_CMD_ENABLE               0x00000001   /**< Transmitter Enable */
#define EMAC32_TX_CMD_FULLDUPLEX           0x00000002   /**< Full Duplex Mode */
#define EMAC32_TX_CMD_RESET                0x80000000   /**< Transmitter Software Reset */
/** @} */


/**
 * @name Core transmitter status register bitmasks
 */

/** @{ */
#define EMAC32_TX_STATUS_ENABLE            0x00000001   /**< Transmitter Enable */
#define EMAC32_TX_STATUS_BUSY              0x00000002   /**< Busy */
#define EMAC32_TX_STATUS_EMPTY             0x00000004   /**< Transmitter Buffer Empty */
#define EMAC32_TX_STATUS_COLLISION         0x00000008   /**< Collision Error */
#define EMAC32_TX_STATUS_LENGTH            0x00000010   /**< Length Error */
#define EMAC32_TX_STATUS_INT_FRAMESENT     0x00010000   /**< Frame Sent Interrupt */
#define EMAC32_TX_STATUS_INT_EMPTY         0x00020000   /**< Transmitter Empty Interrupt */
#define EMAC32_TX_STATUS_INT_COLLISION     0x00040000   /**< Collision Error Interrupt */
#define EMAC32_TX_STATUS_INT_LENGTH        0x00080000   /**< Length Error */
#define EMAC32_TX_STATUS_RESET             0x80000000   /**< Transmitter Reset */
/** @} */


/**
 * @name Core transmitter interrupt enable register bitmasks
 */

/** @{ */
#define EMAC32_TX_INT_FRAMESENT            0x00000001   /**< Frame Sent Interrupt Enable */
#define EMAC32_TX_INT_EMPTY                0x00000002   /**< Transmitter Empty Interrupt Enable */
#define EMAC32_TX_INT_COLLISION            0x00000004   /**< Collision Error Interrupt Enable */
#define EMAC32_TX_INT_LENGTH               0x00000008   /**< Length Error Interrupt Enable */
/** @} */


/**
 * @name Core MDI register bitmasks
 */

/** @{ */
#define EMAC32_MDI_CMD_WRITE               0x00000001   /**< PHY Register Write */
#define EMAC32_MDI_CMD_READ                0x00000002   /**< PHY Register Read */
#define EMAC32_MDI_CMD_RESET               0x80000000   /**< PHY Reset */
/** @} */


#endif

