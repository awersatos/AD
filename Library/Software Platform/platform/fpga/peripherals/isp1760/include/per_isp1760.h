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

#define GETBIT(word, pos)                ((word >> pos) & 1)
#define GETBITS(word, pos, val)          ((word >> pos) & val)
#define TSTBIT(word, pos)                (word & (1 << pos))
#define TSTBITS(word, pos, val)          (word & (val << pos))
#define SETBIT(word, pos)                (word |= (1 << pos))
#define SETBITS(word, pos, val)          (word |= (val << pos))
#define RSTBIT(word, pos)                (word &= ~(1 << pos))
#define RSTBITS(word, pos, val)          (word &= ~(val << pos))
#define TGLBIT(word, pos)                (word ^= (1 << pos))
#define TGLBITS(word, pos, val)          (word ^= (val << pos))

#define ISP1760_BASE32(base)             ((volatile uint32_t *) (base))
#define ISP1760_BASE16(base)             ((volatile uint16_t *) (base))

/**
 * @name Core Registers
 */
/** @{ */
#define ISP1760_CAPLENGTH(base)           ISP1760_BASE16(base)[0x0000 >> 1] /**< Capability Length */
#define ISP1760_HCIVERSION(base)          ISP1760_BASE16(base)[0x0002 >> 1] /**< Host Controller Interface Version Number */
#define ISP1760_HCSPARAMS(base)           ISP1760_BASE32(base)[0x0004 >> 2] /**< Host Controller Structural Parameters */
#define ISP1760_HCCPARAMS(base)           ISP1760_BASE32(base)[0x0008 >> 2] /**< Host Controller Capability Parameters */
#define ISP1760_USBCMD(base)              ISP1760_BASE32(base)[0x0020 >> 2] /**< USB Command */
#define ISP1760_USBCMD_RS                 (1 << 0)    /**< Run/Stop */
#define ISP1760_USBCMD_HCRESET            (1 << 1)    /**< Host Controller Reset */
#define ISP1760_USBCMD_LHCR               (1 << 7)    /**< Light Host Controller Reset (optional) */
#define ISP1760_USBSTS(base)              ISP1760_BASE32(base)[0x0024 >> 2] /**< USB Status */
#define ISP1760_USBSTS_PCD                (1<<2)      /**< port change detect */
#define ISP1760_USBINTR(base)             ISP1760_BASE32(base)[0x0028 >> 2] /**< USB Interrupt */
#define ISP1760_FRINDEX(base)             ISP1760_BASE32(base)[0x002C >> 2] /**< Frame Index */
#define ISP1760_CONFIGFLAG(base)          ISP1760_BASE32(base)[0x0060 >> 2] /**< Configure Flag */
#define ISP1760_CONFIGFLAG_CF             (1<<0)      /**< true: we'll support "high speed" */
#define ISP1760_PORTSC1(base)             ISP1760_BASE32(base)[0x0064 >> 2] /**< Port Status and Control 1 */
#define ISP1760_PORTSC1_OWNER             (1<<13)     /**< true: companion hc owns this port */
#define ISP1760_PORTSC1_POWER             (1<<12)     /**< true: has power (see PPC) */
#define ISP1760_PORTSC1_USB11(x)          (((x) & (3 << 10)) == (1 << 10))  /**< USB 1.1 device */
#define ISP1760_PORTSC1_RESET             (1<<8)      /**< reset port */
#define ISP1760_PORTSC1_SUSPEND           (1<<7)      /**< suspend port */
#define ISP1760_PORTSC1_RESUME            (1<<6)      /**< resume it */
#define ISP1760_PORTSC1_ENABLED           (1<<2)      /**< port enabled */
#define ISP1760_PORTSC1_CONCHANGED        (1<<1)      /**< connect status changed */
#define ISP1760_PORTSC1_CONSTS            (1<<0)      /**< device connect status */
#define ISP1760_ISO_PTD_DONE_MAP(base)    ISP1760_BASE32(base)[0x0130 >> 2] /**< ISO PTD Done Map */
#define ISP1760_ISO_PTD_SKIP_MAP(base)    ISP1760_BASE32(base)[0x0134 >> 2] /**< ISO PTD Skip Map */
#define ISP1760_ISO_PTD_LAST_PTD(base)    ISP1760_BASE32(base)[0x0138 >> 2] /**< ISO PTD Last PTD */
#define ISP1760_INT_PTD_DONE_MAP(base)    ISP1760_BASE32(base)[0x0140 >> 2] /**< INT PTD Done Map */
#define ISP1760_INT_PTD_SKIP_MAP(base)    ISP1760_BASE32(base)[0x0144 >> 2] /**< INT PTD Skip Map */
#define ISP1760_INT_PTD_LAST_PTD(base)    ISP1760_BASE32(base)[0x0148 >> 2] /**< INT PTD Last PTD */
#define ISP1760_ATL_PTD_DONE_MAP(base)    ISP1760_BASE32(base)[0x0150 >> 2] /**< ATL PTD Done Map */
#define ISP1760_ATL_PTD_SKIP_MAP(base)    ISP1760_BASE32(base)[0x0154 >> 2] /**< ATL PTD Skip Map */
#define ISP1760_ATL_PTD_LAST_PTD(base)    ISP1760_BASE32(base)[0x0158 >> 2] /**< ATL PTD Last PTD */
#define ISP1760_MODE_CONTROL(base)        ISP1760_BASE32(base)[0x0300 >> 2] /**< Hardware Mode Control */
#define ISP1760_ALL_ATX_RESET             (1 << 31)   /**< All ATX Reset */  
#define ISP1760_HW_ANA_DIGI_OC            (1 << 15)   /**< Analog Digital Overcurren */  
#define ISP1760_HW_DATA_BUS_32BIT         (1 << 8)    /**< Data Bus Width */  
#define ISP1760_HW_DACK_POL_HIGH          (1 << 6)    /**< DACK Polarity */  
#define ISP1760_HW_DREQ_POL_HIGH          (1 << 5)    /**< DREQ Polarity */  
#define ISP1760_HW_INTR_POL_HIGH          (1 << 2)    /**< Interrupt Polarity */  
#define ISP1760_HW_INTR_LEVEL_EDGE        (1 << 1)    /**< Interrupt Level */  
#define ISP1760_HW_GLOBAL_INTR_EN         (1 << 0)    /**< Global Interrupt Enable */  
#define ISP1760_CHIP_ID(base)             ISP1760_BASE32(base)[0x0304 >> 2] /**< Chip Identifier */
#define ISP1760_SCRATCH(base)             ISP1760_BASE32(base)[0x0308 >> 2] /**< Scratch */
#define ISP1760_SW_RESET(base)            ISP1760_BASE32(base)[0x030C >> 2] /**< Software Reset */
#define ISP1760_SW_RESET_RESET_HC         (1 << 1)    /**< Reset Host Controller */
#define ISP1760_SW_RESET_RESET_ALL        (1 << 0)    /**< Reset All */  
#define ISP1760_ISO_IRQ_MASK_OR(base)     ISP1760_BASE32(base)[0x0318 >> 2] /**< ISO IRQ Mask OR */
#define ISP1760_INT_IRQ_MASK_OR(base)     ISP1760_BASE32(base)[0x031C >> 2] /**< INT IRQ Mask OR */
#define ISP1760_ATL_IRQ_MASK_OR(base)     ISP1760_BASE32(base)[0x0320 >> 2] /**< ATL IRQ Mask OR */
#define ISP1760_ISO_IRQ_MASK_AND(base)    ISP1760_BASE32(base)[0x0324 >> 2] /**< ISO IRQ Mask AND */
#define ISP1760_INT_IRQ_MASK_AND(base)    ISP1760_BASE32(base)[0x0328 >> 2] /**< INT IRQ Mask AND */
#define ISP1760_ATL_IRQ_MASK_AND(base)    ISP1760_BASE32(base)[0x032C >> 2] /**< ATL IRQ Mask AND */
#define ISP1760_DMA_CONFIG(base)          ISP1760_BASE32(base)[0x0330 >> 2] /**< DMA Configuration */
#define ISP1760_BUFFER_STAT(base)         ISP1760_BASE32(base)[0x0334 >> 2] /**< Buffer Status */
#define ISP1760_BUFFER_MAP                (0x7)
#define ISP1760_BUFFER_ISO                (1 << 2)    /**< ISO Buffer Filled */
#define ISP1760_BUFFER_INT                (1 << 1)    /**< INT Buffer Filled */
#define ISP1760_BUFFER_ATL                (1 << 0)    /**< ATL Buffer Filled */
#define ISP1760_ATL_DONE_TIMEOUT(base)    ISP1760_BASE32(base)[0x0338 >> 2] /**< ATL Done Timeout */
#define ISP1760_MEMORY(base)              ISP1760_BASE32(base)[0x033C >> 2] /**< Memory */
// Memory bank is a somewhat misleading term. Memory prefetch buffer would be better;
// the buffers prefetch data from one ISP1760 memory
#define ISP1760_MEM_BANK(x)               ((x) << 16)
#define ISP1760_EDGE_INT_COUNT(base)      ISP1760_BASE32(base)[0x0340 >> 2] /**< Edge Interrupt Count */
#define ISP1760_DMA_START_ADDR(base)      ISP1760_BASE32(base)[0x0344 >> 2] /**< DMA Start Address */
#define ISP1760_PWR_DOWN(base)            ISP1760_BASE32(base)[0x0354 >> 2] /**< Power Down Control */
#define ISP1760_PORT1_CONTROL(base)       ISP1760_BASE32(base)[0x0374 >> 2] /**< Port 1 Control */
#define ISP1760_PORT1_INIT2               (1 << 23)   /**< Port 1 Initialization 2 */
#define ISP1760_PORT1_INIT1               (1 << 7)    /**< Port 1 Initialization 1 */
#define ISP1760_PORT1_POWER               (3 << 3)    /**< Port 1 Power */
#define ISP1760_INT(base)                 ISP1760_BASE32(base)[0x0310 >> 2] /**< Interrupt */
#define ISP1760_INT_ENABLE(base)          ISP1760_BASE32(base)[0x0314 >> 2] /**< Interrupt Enable */
#define ISP1760_INT_ISO_IRQ               (1 << 9)    /**< ISO IRQ Enable */
#define ISP1760_INT_ATL_IRQ               (1 << 8)    /**< ATL IRQ Enable */
#define ISP1760_INT_INT_IRQ               (1 << 7)    /**< INT IRQ Enable */
#define ISP1760_INT_CLKREADY              (1 << 6)    /**< Clock Ready Enable */
#define ISP1760_INT_HC_SUSP               (1 << 5)    /**< Host Controller Suspend Enable */
#define ISP1760_INT_DMAEOTINT             (1 << 3)    /**< DMA EOT Interrupt Enable */
#define ISP1760_INT_SOFITLINT             (1 << 1)    /**< SOT ITL Interrupt Enable */
/** @} */

#define ISP1760_INT_ENABLEMSK             (ISP1760_INT_ISO_IRQ | ISP1760_INT_ATL_IRQ | ISP1760_INT_INT_IRQ)
#define ISP1760_ISO_MEMORY_MAP_OFFSET     0x0400
#define ISP1760_INT_MEMORY_MAP_OFFSET     0x0800
#define ISP1760_ATL_MEMORY_MAP_OFFSET     0x0C00
#define ISP1760_PAYLOAD_MEMORY_MAP_OFFSET 0x1000

// MISC
#define ISP1760_RL_COUNTER  (0)
#define ISP1760_NAK_COUNTER (0)
#define ISP1760_ERR_COUNTER (2)

#define ISP1760_NO_TRANSFER_ACTIVE      (0xFFFFFFFF)

////////////////////////////////////////////////////////////////////////////////
typedef struct __packed__ {
    uint32_t dw0;
#define ISP1760_DW0_VALID               0
#define ISP1760_DW0_NRBYTES             3
#define ISP1760_DW0_NRBYTES_MSK         0x7FFF
#define ISP1760_DW0_MAXPACKET           18
#define ISP1760_DW0_MAXPACKET_MSK       0x3FF
#define ISP1760_DW0_MULT                29
#define ISP1760_DW0_MULT_MSK            0x3
#define ISP1760_DW0_ENDPT0              31
    uint32_t dw1;
#define ISP1760_DW1_ENDPT               0
#define ISP1760_DW1_ENDPT_MSK           0x7
#define ISP1760_DW1_DEVICEADDRESS       3
#define ISP1760_DW1_DEVICEADDRESS_MSK   0x7F
#define ISP1760_DW1_TOKEN               10
#define ISP1760_DW1_TOKEN_MSK           0x3
#define ISP1760_DW1_TOKEN_PING          0x3
#define ISP1760_DW1_TOKEN_SETUP         0x2
#define ISP1760_DW1_TOKEN_IN            0x1
#define ISP1760_DW1_TOKEN_OUT           0x0
#define ISP1760_DW1_EPTYPE              12
#define ISP1760_DW1_EPTYPE_MSK          0x3
// eptypes are not ISP1760 defined but are USB defined types. So they're
// defined int the USBHOST layer!
#define ISP1760_DW1_SPLIT               14
#define ISP1760_DW1_SELOSPEED           17
#define ISP1760_DW1_PORTNUMBER          18
#define ISP1760_DW1_PORTNUMBER_MSK      0x7F
#define ISP1760_DW1_HUBADDRESS          25
#define ISP1760_DW1_HUBADDRESS_MSK      0x7F
    uint32_t dw2;
#define ISP1760_DW2_UFRAME              0
#define ISP1760_DW2_UFRAME_MSK          0xF8
#define ISP1760_DW2_DATASTARTADDR       8
#define ISP1760_DW2_DATASTARTADDR_MSK   0xFFFF
#define ISP1760_DW2_RL                  25
#define ISP1760_DW2_RL_MSK              0xF
    uint32_t dw3;
#define ISP1760_DW3_NRBYTESTRANS        0
// DW3_NR_BYTESTRANS_MSK is 0x7FFF except for ISO and INT low and full speed
// in which it is 0xFFF. To keep the driver generic we use the lowest value (4k)
#define ISP1760_DW3_NRBYTESTRANS_HIMSK  0x7FFF
#define ISP1760_DW3_NRBYTESTRANS_LOMSK  0xFFF
#define ISP1760_DW3_NAKCNT              19
#define ISP1760_DW3_NAKCNT_MSK          0xF
#define ISP1760_DW3_CERR                23
#define ISP1760_DW3_CERR_MSK            0x3
#define ISP1760_DW3_DT                  25
#define ISP1760_DW3_PING                26
#define ISP1760_DW3_ERROR               28
#define ISP1760_DW3_BABBLE              29
#define ISP1760_DW3_HALT                30
#define ISP1760_DW3_ACTIVE              31
    uint32_t dw4;
#define ISP1760_DW4_NEXTPTD             0
#define ISP1760_DW4_NEXTPTD_MSK         0x1F
#define ISP1760_DW4_USA                 0
#define ISP1760_DW4_USA_MSK             0xFF
#define ISP1760_DW4_JUMP                5
#define ISP1760_DW4_STATUS0             8
#define ISP1760_DW4_STATUS1             11
#define ISP1760_DW4_STATUS2             14
#define ISP1760_DW4_STATUS3             17
#define ISP1760_DW4_STATUS4             20
#define ISP1760_DW4_STATUS5             23
#define ISP1760_DW4_STATUS6             26
#define ISP1760_DW4_STATUS7             29
#define ISP1760_DW4_STATUS_MSK          0x7
#define ISP1760_DW4_STATUS_XERR         0
#define ISP1760_DW4_STATUS_BABBLE       1
#define ISP1760_DW4_STATUS_UNDERRUN     2
    uint32_t dw5;
#define ISP1760_DW5_ISOIN0              0
#define ISP1760_DW5_ISOIN1              12
#define ISP1760_DW5_ISOIN270            24
#define ISP1760_ISOIN_MSK               0xFFF
    uint32_t dw6;
#define ISP1760_DW6_ISOIN2118           0
#define ISP1760_DW6_ISOIN3              4
#define ISP1760_DW6_ISOIN4              16
#define ISP1760_DW6_ISOIN530            28
    uint32_t dw7;
#define ISP1760_DW7_ISOIN5114           0
#define ISP1760_DW7_ISOIN6              8
#define ISP1760_DW7_ISOIN7              20
} isp1760_hw_ptd_t;


////////////////////////////////////////////////////////////////////////////////
// Not an ISP1760 internal register but a wrapper register
#define ISP1760_ENDIAN(base)            ISP1760_BASE32(base)[0x03FC >> 2] /**<  */
#define ISP1760_LITTLE_ENDIAN           0x80000000
#define ISP1760_BIG_ENDIAN              0

#endif /* _ISP1760_H */


