/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        ISP1760 USB Host Controller direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the ISP1760 USB Host Controller.
 * Generally, application writers will use a higher level interface.
 *
 */

#ifndef _PER_ISP1760_H
#define _PER_ISP1760_H

#include <stdint.h>

#define ISP1760_BASE32(base)      ((volatile uint32_t *) (base))
#define ISP1760_BASE16(base)      ((volatile uint16_t *) (base))

/**
 * @name Core Registers
 */
/** @{ */
#define ISP1760_CAPLENGTH(base)           ISP1760_BASE16(base)[0x0000 >> 1] /**<  */
#define ISP1760_HCIVERSION(base)          ISP1760_BASE16(base)[0x0002 >> 1] /**<  */
#define ISP1760_HCSPARAMS(base)           ISP1760_BASE32(base)[0x0004 >> 2] /**<  */
#define ISP1760_HCCPARAMS(base)           ISP1760_BASE32(base)[0x0008 >> 2] /**<  */

#define ISP1760_USBCMD(base)              ISP1760_BASE32(base)[0x0020 >> 2] /**<  */
#define ISP1760_USBSTS(base)              ISP1760_BASE32(base)[0x0024 >> 2] /**<  */
#define ISP1760_USBINTR(base)             ISP1760_BASE32(base)[0x0028 >> 2] /**<  */
#define ISP1760_FRINDEX(base)             ISP1760_BASE32(base)[0x002C >> 2] /**<  */
#define ISP1760_CONFIGFLAG(base)          ISP1760_BASE32(base)[0x0060 >> 2] /**<  */
#define ISP1760_PORTSC1(base)             ISP1760_BASE32(base)[0x0064 >> 2] /**<  */

#define ISP1760_ISO_PTD_DONE_MAP(base)    ISP1760_BASE32(base)[0x0130 >> 2] /**<  */
#define ISP1760_ISO_PTD_SKIP_MAP(base)    ISP1760_BASE32(base)[0x0134 >> 2] /**<  */
#define ISP1760_ISO_PTD_LAST_PTD(base)    ISP1760_BASE32(base)[0x0138 >> 2] /**<  */
#define ISP1760_INT_PTD_DONE_MAP(base)    ISP1760_BASE32(base)[0x0140 >> 2] /**<  */
#define ISP1760_INT_PTD_SKIP_MAP(base)    ISP1760_BASE32(base)[0x0144 >> 2] /**<  */
#define ISP1760_INT_PTD_LAST_PTD(base)    ISP1760_BASE32(base)[0x0148 >> 2] /**<  */
#define ISP1760_ATL_PTD_DONE_MAP(base)    ISP1760_BASE32(base)[0x0150 >> 2] /**<  */
#define ISP1760_ATL_PTD_SKIP_MAP(base)    ISP1760_BASE32(base)[0x0154 >> 2] /**<  */
#define ISP1760_ATL_PTD_LAST_PTD(base)    ISP1760_BASE32(base)[0x0158 >> 2] /**<  */

#define ISP1760_MODE_CONTROL(base)        ISP1760_BASE32(base)[0x0300 >> 2] /**<  */
#define ISP1760_ALL_ATX_RESET             (1 << 31)
#define ISP1760_HW_ANA_DIGI_OC            (1 << 15)
#define ISP1760_HW_DATA_BUS_32BIT         (1 << 8)
#define ISP1760_HW_DACK_POL_HIGH          (1 << 6)
#define ISP1760_HW_DREQ_POL_HIGH          (1 << 5)
#define ISP1760_HW_INTR_HIGH_ACT          (1 << 2)
#define ISP1760_HW_INTR_EDGE_TRIG         (1 << 1)
#define ISP1760_HW_GLOBAL_INTR_EN         (1 << 0)

#define ISP1760_FLAG_PORT1_DIS            (0x00000001)    /**< Port 1 disabled */
#define ISP1760_FLAG_BUS_WIDTH_16         (0x00000002)    /**< 16-bit data bus width */
#define ISP1760_FLAG_OTG_EN               (0x00000004)    /**< Port 1 supports OTG */
#define ISP1760_FLAG_ANALOG_OC            (0x00000008)    /**< Analog overcurrent */
#define ISP1760_FLAG_DACK_POL_HIGH        (0x00000010)    /**< DACK active high */
#define ISP1760_FLAG_DREQ_POL_HIGH        (0x00000020)    /**< DREQ active high */
#define ISP1760_FLAG_ISP1761              (0x00000040)    /**< Chip is ISP1761 */
#define ISP1760_FLAG_INTR_POL_HIGH        (0x00000080)    /**< Interrupt polarity active high */
#define ISP1760_FLAG_INTR_EDGE_TRIG       (0x00000100)    /**< Interrupt edge triggered */


#define ISP1760_CHIP_ID(base)             ISP1760_BASE32(base)[0x0304 >> 2] /**<  */
#define ISP1760_SCRATCH(base)             ISP1760_BASE32(base)[0x0308 >> 2] /**<  */
#define ISP1760_SW_RESET(base)            ISP1760_BASE32(base)[0x030C >> 2] /**<  */
#define ISP1760_DMA_CONFIG(base)          ISP1760_BASE32(base)[0x0330 >> 2] /**<  */

/* SW_RESET register bits */
#define ISP1760_SW_RESET_RESET_ALL          (1 << 0)
#define ISP1760_SW_RESET_RESET_HC           (1 << 1)

#define ISP1760_BUFFER_STAT(base)           ISP1760_BASE32(base)[0x0334 >> 2] /**<  */
#define ISP1760_ATL_BUFFER                  (0x1)
#define ISP1760_INT_BUFFER                  (0x2)
#define ISP1760_ISO_BUFFER                  (0x4)
#define ISP1760_BUFFER_MAP                  (0x7)

#define ISP1760_ATL_DONE_TIMEOUT(base)    ISP1760_BASE32(base)[0x0338 >> 2] /**<  */

#define ISP1760_MEMORY(base)              ISP1760_BASE32(base)[0x033C >> 2] /**<  */
#define ISP1760_MEM_BANK(x)               ((x) << 16)

#define ISP1760_EDGE_INT_COUNT(base)      ISP1760_BASE32(base)[0x0340 >> 2] /**<  */
#define ISP1760_DMA_START_ADDR(base)      ISP1760_BASE32(base)[0x0344 >> 2] /**<  */
#define ISP1760_PWR_DOWN(base)            ISP1760_BASE32(base)[0x0354 >> 2] /**<  */

#define ISP1760_PORT1_CONTROL(base)       ISP1760_BASE32(base)[0x0374 >> 2] /**<  */
#define ISP1760_PORT1_POWER               (3 << 3)
#define ISP1760_PORT1_INIT1               (1 << 7)
#define ISP1760_PORT1_INIT2               (1 << 23)

#define ISP1760_INT(base)                 ISP1760_BASE32(base)[0x0310 >> 2] /**<  */
#define ISP1760_INT_ENABLE(base)          ISP1760_BASE32(base)[0x0314 >> 2] /**<  */
//#define ISP1760_INTERRUPT_ENABLE_MASK   (ISP1760_HC_INTL_INT | ISP1760_HC_ATL_INT | ISP1760_HC_EOT_INT)
//#define ISP1760_INTERRUPT_ENABLE_MASK   (ISP1760_HC_INTL_INT | ISP1760_HC_ATL_INT | ISP1760_HC_SOF_INT)

#define ISP1760_INTERRUPT_ENABLE_MASK   ( ISP1760_INT_ISO_IRQ | ISP1760_INT_ATL_IRQ | ISP1760_INT_INT_IRQ )

/*
 * interrupt register bits and
 * interrupt enable register bits
 */
#define ISP1760_INT_ISO_IRQ             (1 << 9)
#define ISP1760_INT_ATL_IRQ             (1 << 8)
#define ISP1760_INT_INT_IRQ             (1 << 7)
#define ISP1760_INT_CLKREADY            (1 << 6)
#define ISP1760_INT_HC_SUSP             (1 << 5)
#define ISP1760_INT_DMAEOTINT           (1 << 3)
#define ISP1760_INT_SOFITLINT           (1 << 1)

#define ISP1760_ISO_IRQ_MASK_OR(base)     ISP1760_BASE32(base)[0x0318 >> 2] /**<  */
#define ISP1760_INT_IRQ_MASK_OR(base)     ISP1760_BASE32(base)[0x031C >> 2] /**<  */
#define ISP1760_ATL_IRQ_MASK_OR(base)     ISP1760_BASE32(base)[0x0320 >> 2] /**<  */

#define ISP1760_ISO_IRQ_MASK_AND(base)    ISP1760_BASE32(base)[0x0324 >> 2] /**<  */
#define ISP1760_INT_IRQ_MASK_AND(base)    ISP1760_BASE32(base)[0x0328 >> 2] /**<  */
#define ISP1760_ATL_IRQ_MASK_AND(base)    ISP1760_BASE32(base)[0x032C >> 2] /**<  */

#define ISP1760_ISO_MEMORY_MAP_OFFSET     0x0400 /**<  */
#define ISP1760_INT_MEMORY_MAP_OFFSET     0x0800 /**<  */
#define ISP1760_ATL_MEMORY_MAP_OFFSET     0x0C00 /**<  */

#define ISP1760_PAYLOAD_MEMORY_MAP_OFFSET 0x1000 /**<  */

/** @} */

/**
 * @name USBCMD register bits
 */
/** @{ */
#define ISP1760_USBCMD_RUNSTOP				(1 << 0)    /**< Run/Stop */
#define ISP1760_USBCMD_HCRESET              (1 << 1)    /**< Host Controller Reset */
#define ISP1760_USBCMD_LHCR                 (1 << 7)    /**< Light Host Controller Reset (optional) */
/** @} */

#define ISP1760_PAYLOAD_MEMORY_SIZE       (0xFFFF-0x1000)
#define ISP1760_MEMORY_SIZE               (0xFFFF-0x0400)



// Section 2.2 Host Controller Capability Registers
/**
 * @name Core Registers
 */
/** @{ */

#define ISP1760_HC_LENGTH(p)              (((p)>>00)&0x00ff)  /**< bits 7:0 */
#define ISP1760_HC_VERSION(p)             (((p)>>16)&0xffff)  /**< bits 31:16 */
#define ISP1760_HCS_INDICATOR(p)          ((p)&(1 << 16))     /**< true: has port indicators */
#define ISP1760_HCS_PPC(p)                ((p)&(1 << 4))      /**< true: port power control */
#define ISP1760_HCS_N_PORTS(p)            (((p)>>0)&0xf)      /**< bits 3:0, ports on HC */
#define ISP1760_HCC_ISOC_CACHE(p)         ((p)&(1 << 7))      /**< true: can cache isoc frame */
#define ISP1760_HCC_ISOC_THRES(p)         (((p)>>4)&0x7)      /**< bits 6:4, uframes cached */
/** @} */


// Section 2.3 Host Controller Operational Registers
/**
 * @name Core Registers
 */
/** @{ */
#define ISP1760_CMD_LRESET					(1<<7)		// partial reset (no ports, etc)
#define ISP1760_CMD_RESET					(1<<1)		// reset HC not bus
#define ISP1760_CMD_RUN						(1<<0)		// start/stop HC
#define ISP1760_STS_HCHALTED				(1<<12)
#define ISP1760_STS_PCD						(1<<2)		// port change detect
#define ISP1760_FLAG_CF						(1<<0)		// true: we'll support "high speed"

#define ISP1760_PORT_OWNER                (1<<13)     // true: companion hc owns this port
#define ISP1760_PORT_POWER                (1<<12)     // true: has power (see PPC)
#define ISP1760_PORT_USB11(x)             (((x) & (3 << 10)) == (1 << 10))  // USB 1.1 device
#define ISP1760_PORT_RESET                (1<<8)      // reset port
#define ISP1760_PORT_SUSPEND              (1<<7)      // suspend port
#define ISP1760_PORT_RESUME               (1<<6)      // resume it
#define ISP1760_PORT_PE                   (1<<2)      // port enable
#define ISP1760_PORT_CSC                  (1<<1)      // connect status change
#define ISP1760_PORT_CONNECT              (1<<0)      // device connected
#define ISP1760_PORT_RWC_BITS             (ISP1760_PORT_CSC)
/** @} */


/**
 * @name DW0
 */
/** @{ */
#define ISP1760_PTD_VALID               (1)
#define ISP1760_PTD_LENGTH(x)           (((uint32_t) x) << 3)
#define ISP1760_PTD_MAXPACKET(x)        (((uint32_t) x) << 18)
#define ISP1760_PTD_MULTI(x)            (((uint32_t) x) << 29)
#define ISP1760_PTD_ENDPOINT(x)         (((uint32_t) x) << 31)
/** @} */


/**
 * @name DW1
 */
/** @{ */
#define ISP1760_PTD_DEVICE_ADDR(x)      (((uint32_t) x) << 3)
#define ISP1760_PTD_PID_TOKEN(x)        (((uint32_t) x) << 10)
#define ISP1760_PTD_TRANS_BULK          ((uint32_t) 2 << 12)
#define ISP1760_PTD_TRANS_INT           ((uint32_t) 3 << 12)
#define ISP1760_PTD_TRANS_SPLIT         ((uint32_t) 1 << 14)
#define ISP1760_PTD_SE_USB_LOSPEED      ((uint32_t) 2 << 16)
#define ISP1760_PTD_PORT_NUM(x)         (((uint32_t) x) << 18)
#define ISP1760_PTD_HUB_NUM(x)          (((uint32_t) x) << 25)
#define ISP1760_PTD_PING(x)             (((uint32_t) x) << 26)
/** @} */


/**
 * @name DW2
 */
/** @{ */
#define ISP1760_PTD_RL_CNT(x)           (((uint32_t) x) << 25)
#define ISP1760_PTD_DATA_START_ADDR(x)  (((uint32_t) x) <<  8)
#define ISP1760_BASE_ADDR               0x1000
/** @} */


/**
 * @name DW3
 */
/** @{ */
#define ISP1760_PTD_CERR(x)             (((uint32_t) x) << 23)
#define ISP1760_PTD_NAC_CNT(x)          (((uint32_t) x) << 19)
#define ISP1760_PTD_ACTIVE              ((uint32_t) 1 << 31)
#define ISP1760_PTD_DATA_TOGGLE(x)      (((uint32_t) x) << 25)

#define ISP1760_DW3_HALT_BIT            (1 << 30)
#define ISP1760_DW3_ERROR_BIT           (1 << 28)
#define ISP1760_DW3_SC_BIT              (1 << 27)
#define ISP1760_DW3_QTD_ACTIVE          (1 << 31)
/** @} */


/**
 * @name INT
 */
/** @{ */
#define ISP1760_INT_UNDERRUN            (1 << 2)
#define ISP1760_INT_BABBLE              (1 << 1)
#define ISP1760_INT_EXACT               (1 << 0)
/** @} */

#define ISP1760_DW1_GET_PID(x)              (((x) >> 10) & 0x3)
#define ISP1760_PTD_XFERRED_LENGTH(x)       ((x) & 0x7fff)
#define ISP1760_PTD_XFERRED_LENGTH_LO(x)    ((x) & 0x7ff)

#define ISP1760_SETUP_PID               (2)
#define ISP1760_IN_PID                  (1)
#define ISP1760_OUT_PID                 (0)
#define ISP1760_GET_QTD_TOKEN_TYPE(x)   ((x) & 0x3)

#define ISP1760_DATA_TOGGLE             (1 << 31)
#define ISP1760_GET_DATA_TOGGLE(x)      ((x) >> 31)

// MISC
#define ISP1760_RL_COUNTER  (0)
#define ISP1760_NAK_COUNTER (0)
#define ISP1760_ERR_COUNTER (2)

#define ISP1760_HC_ATL_PL_SIZE          (8192)

#define ISP1760_NO_TRANSFER_ACTIVE      (0xFFFFFFFF)


////////////////////////////////////////////////////////////////////////////////
typedef struct __packed__ {
    uint32_t dw0;
    uint32_t dw1;
    uint32_t dw2;
    uint32_t dw3;
    uint32_t dw4;
    uint32_t dw5;
    uint32_t dw6;
    uint32_t dw7;
} isp1760_ptd_t;


#endif /* _ISP1760_H */

