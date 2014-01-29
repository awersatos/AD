/*****************************************************************************\
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        WB_CAN device driver: In CAN, devices are addressed
|*                      using an id. After declaring the can device and two 
|*                      arrays of transmit and receive message objects,
|*                      you can set up the driver using can_open. Now setup 
|*                      individual message objects in the can arrays using 
|*                      can_init_txmo/can_init_rxmo.
 */

/**
 * @file
 * Direct access to the CAN hardware registers.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the CAN peripheral, see the Core Reference
 * <a href="CR0104 CAN Controller.pdf">CR0104 CAN Controller</a>
 *
 */

#ifndef _PERCAN_H
#define _PERCAN_H

#include <stdint.h>

#define CAN_BASE(baseaddr) ((volatile uint8_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define CAN_MOD(addr)   CAN_BASE(addr)[0]    /**< MODe register */
#define CAN_CMR(addr)   CAN_BASE(addr)[1]    /**< CoMmand Register */
#define CAN_SR(addr)    CAN_BASE(addr)[2]    /**< Status Register */
#define CAN_IR(addr)    CAN_BASE(addr)[3]    /**< Interrupt Register */
#define CAN_IER(addr)   CAN_BASE(addr)[4]    /**< Interrupt Enable Register */
#define CAN_BTR0(addr)  CAN_BASE(addr)[6]    /**< Bus Timing Register 0 */
#define CAN_BTR1(addr)  CAN_BASE(addr)[7]    /**< Bus Timing Register 1 */
#define CAN_OCR(addr)   CAN_BASE(addr)[8]    /**< Output Control Register */
#define CAN_ALC(addr)   CAN_BASE(addr)[11]   /**< Arbitration Lost capture Register */
#define CAN_ECC(addr)   CAN_BASE(addr)[12]   /**< ErrorCode Capture Register */
#define CAN_EWL(addr)   CAN_BASE(addr)[13]   /**< Error Warning Limit */
#define CAN_REC(addr)   CAN_BASE(addr)[14]   /**< Rx Error Counter */
#define CAN_TEC(addr)   CAN_BASE(addr)[15]   /**< Tx Error Counter */
#define CAN_ACR0(addr)  CAN_BASE(addr)[16]   /**< Acceptance Code Register */
#define CAN_ACR1(addr)  CAN_BASE(addr)[17]
#define CAN_ACR2(addr)  CAN_BASE(addr)[18]
#define CAN_ACR3(addr)  CAN_BASE(addr)[19]
#define CAN_AMR0(addr)  CAN_BASE(addr)[20]   /**< Acceptance Mask Register */
#define CAN_AMR1(addr)  CAN_BASE(addr)[21]
#define CAN_AMR2(addr)  CAN_BASE(addr)[22]
#define CAN_AMR3(addr)  CAN_BASE(addr)[23]
#define CAN_TB0(addr)   CAN_BASE(addr)[16]   /**< Transmit Buffer, Frame info */
#define CAN_TB1(addr)   CAN_BASE(addr)[17]   /**< Can ID */
#define CAN_TB2(addr)   CAN_BASE(addr)[18]   /**< Can ID */
#define CAN_TB3(addr)   CAN_BASE(addr)[19]   /**< Extended Can ID/data */
#define CAN_TB4(addr)   CAN_BASE(addr)[20]   /**< Extended Can ID/data */
#define CAN_TB5(addr)   CAN_BASE(addr)[21]   /**< Transmit data */
#define CAN_TB6(addr)   CAN_BASE(addr)[22]
#define CAN_TB7(addr)   CAN_BASE(addr)[23]
#define CAN_TB8(addr)   CAN_BASE(addr)[24]
#define CAN_TB9(addr)   CAN_BASE(addr)[25]
#define CAN_TB10(addr)  CAN_BASE(addr)[26]
#define CAN_TB11(addr)  CAN_BASE(addr)[27]
#define CAN_TB12(addr)  CAN_BASE(addr)[28]
#define CAN_RB0(addr)   CAN_BASE(addr)[16]   /**< Receive Buffer, Frame info */
#define CAN_RB1(addr)   CAN_BASE(addr)[17]   /**< Can ID */
#define CAN_RB2(addr)   CAN_BASE(addr)[18]   /**< Can ID */
#define CAN_RB3(addr)   CAN_BASE(addr)[19]   /**< Extended Can ID/data */
#define CAN_RB4(addr)   CAN_BASE(addr)[20]   /**< Extended Can ID/data */
#define CAN_RB5(addr)   CAN_BASE(addr)[21]   /**< Receive data */
#define CAN_RB6(addr)   CAN_BASE(addr)[22]
#define CAN_RB7(addr)   CAN_BASE(addr)[23]
#define CAN_RB8(addr)   CAN_BASE(addr)[24]
#define CAN_RB9(addr)   CAN_BASE(addr)[25]
#define CAN_RB10(addr)  CAN_BASE(addr)[26]
#define CAN_RB11(addr)  CAN_BASE(addr)[27]
#define CAN_RB12(addr)  CAN_BASE(addr)[28]
#define CAN_MC(addr)    CAN_BASE(addr)[29]   /**< Message Counter */
#define CAN_RBSA(addr)  CAN_BASE(addr)[30]   /**< Receive Buffer Start Address */
#define CAN_CDR(addr)   CAN_BASE(addr)[31]   /**< Clock Divide Register */
#define CAN_RM(addr)    CAN_BASE(addr)[32]   /**< Receive Memory */
#define CAN_TM(addr)    CAN_BASE(addr)[96]   /**< Transmit Memory */
/** @} */

/**
 * @name Core CAN_MOD Register Bitmasks
 */
/** @{ */
// WARNING: the chip automatically enters Reset (bus off) mode when Transmit error counter > 255 
#define    MOD_RM  0x01  /**< 0=Operating Mode, 1=Reset Mode */
#define    MOD_LOM 0x02  /**< 0=Listen Only Mode disabled,1=Listen Only Mode enabled */
#define    MOD_STM 0x04  /**< 0=Self Test Mode disabled, 1=Self Test Mode enabled */
#define    MOD_AFM 0x08  /**< Acceptance Filter Mode -> 0=dual filter, 1=single filter */
#define    MOD_SM  0x10  /**< 0= Sleep Mode disabled, 1=Sleep Mode enabled(only writable in Operating mode) */
/** @} */

/**
 * @name Core CAN_CMR Register Bitmasks
 */
/** @{ */
#define    CMR_TR  0x01  /**< Transmission Request */
#define    CMR_AT  0x02  /**< Abort Transmission */
#define    CMR_RRB 0x04  /**< Release Receive Buffer */
#define    CMR_CDO 0x08  /**< Clear data Overrun */
#define    CMR_SRR 0x10  /**< Self Reception Request (GoToSleep in BASIC mode) */
/** @} */

/**
 * @name Core CAN_SR Register Bitmasks
 */
/** @{ */
#define    SR_RBS 0x01    /**< Receive Buffer status -> 1=there is at least one message av. in the FIFO */
#define    SR_DOS 0x02    /**< data Overrun status */
#define    SR_TBS 0x04    /**< Transmit Buffer status -> 1=you may write a message into the TX buffer */
#define    SR_TCS 0x08    /**< Transmission Complete status */
#define    SR_RS  0x10    /**< Receive status -> 1=CAN is receiving */
#define    SR_TS  0x20    /**< Transmit status ->1=CAN is transmitting */
#define    SR_ES  0x40    /**< Error status -> 1=at least one of the errorcounters has reached EWL */
#define    SR_BS  0x80    /**< Bus status -> 1=bus-off state entered -> chip/mode register enters Reset mode */
/** @} */

/**
 * @name Core CAN_IR Register Bitmasks
 */
/** @{ */
#define    IR_RI  0x01  /**< Receive Interrupt */
#define    IR_TI  0x02  /**< Transmit Interrupt */
#define    IR_EI  0x04  /**< Error Warning Interrupt */
#define    IR_DOI 0x08  /**< data Overrun Interrupt */
#define    IR_WUI 0x10  /**< Wake-Up Interrupt */
#define    IR_EPI 0x20  /**< Error Passive Interrupt (entered error passive state or error active state) */
#define    IR_ALI 0x40  /**< Arbitration Lost Interrupt */
#define    IR_BEI 0x80  /**< Bus Error Interrupt */
/** @} */

/**
 * @name Core CAN_IER Register Bitmasks
 */
/** @{ */
#define    IER_RI  0x01  /**< Receive Interrupt Enable */
#define    IER_TI  0x02  /**< Transmit Interrupt Enable */
#define    IER_EI  0x04  /**< Error Warning Interrupt Enable */
#define    IER_DOI 0x08  /**< data Overrun Interrupt Enable */
#define    IER_WUI 0x10  /**< Wake-Up Interrupt Enable */
#define    IER_EPI 0x20  /**< Error Passive Interrupt Enable */
#define    IER_ALI 0x40  /**< Arbitration Lost Interrupt Enable */
#define    IER_BEI 0x80  /**< Bus Error Interrupt Enable */
/** @} */

/**
 * @name Core CAN_RB0/CAN_TB0 Register Bitmasks (Frame format)
 */
/** @{ */
#define    FRM_DLC 0x0F /**< Length Mask */
#define    FRM_RB0 0x10 /**< Reserved Bit 0 */
#define    FRM_RB1 0x20 /**< Reserved Bit 1 */
#define    FRM_RTR 0x40 /**< Remote request */
#define    FRM_IDE 0x80 /**< Frame Format -> 1=extended, 0=standard */
/** @} */
#endif /* _PERCAN_H */
