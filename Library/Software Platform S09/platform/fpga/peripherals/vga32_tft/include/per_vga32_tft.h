
#ifndef _PER_VGA32_TFT_H
#define _PER_VGA32_TFT_H

/**
 * @file
 * Direct access to the VGA32_TFT peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * @see
 *     CR0166 - VGA32_TFT - 32-bit VGA Controller with TFT Interface
 */

#include <stdint.h>

#define VGA32_TFT_WORD( BASE )          ((volatile uint32_t * const) (BASE) )

/**
 * @name Core Registers
 */

/** @{ */
#define VGA32_TFT_CTRL_REG( BASE )      VGA32_TFT_WORD( BASE )[0]     /**< Control register */
#define VGA32_TFT_HTIM_REG( BASE )      VGA32_TFT_WORD( BASE )[2]     /**< Horizontal timing register */
#define VGA32_TFT_VTIM_REG( BASE )      VGA32_TFT_WORD( BASE )[3]     /**< Vertical timing register */
#define VGA32_TFT_HVLEN_REG( BASE )     VGA32_TFT_WORD( BASE )[4]     /**< Horizontal and vertical length register */
#define VGA32_TFT_VMBA_REG( BASE )      VGA32_TFT_WORD( BASE )[5]     /**< Video Memory Base Address register */
#define VGA32_TFT_CDIV_REG( BASE )      VGA32_TFT_WORD( BASE )[6]     /**< System clock division register */
/** @} */


/**
 * @name Core Control Register Bitmasks
 */
/** @{ */
#define VGA32_TFT_VSE       0x0001   /**< Video System Enable */
#define VGA32_TFT_HOP       0x0100   /**< Horizontal Synchronization Output Polarity */
#define VGA32_TFT_VOP       0x0200   /**< Vertical Synchronization Output Polarity */
#define VGA32_TFT_COP       0x0400   /**< Composite Synchronization Output Polarity */
#define VGA32_TFT_BOP       0x0800   /**< Blanking Synchronization Output Polarity */
#define VGA32_TFT_CKDE      0x1000   /**< Clock Division Enable */
/** @} */


/**
 * @name Core Horizontal Timing Register Bitmasks
 */
/** @{ */
#define VGA32_TFT_HVISIBLE  0x0000FFFF   /**< Horizontal Visible Area */
#define VGA32_TFT_HBPORCH   0x00FF0000   /**< Horizontal Back Porch length */
#define VGA32_TFT_HSYNC     0xFF000000   /**< Horizontal Synch Pulse length */
/** @} */


/**
 * @name Core Vertical Timing Register Bitmasks
 */
/** @{ */
#define VGA32_TFT_VVISIBLE  0x0000FFFF   /**< Vertical Visible Area */
#define VGA32_TFT_VBPORCH   0x00FF0000   /**< Vertical Back Porch length */
#define VGA32_TFT_VSYNC     0xFF000000   /**< Vertical Synch Pulse length */
/** @} */


/**
 * @name Core Horizontal and Vertical Length Register Bitmasks
 */
/** @{ */
#define VGA32_TFT_VLEN      0x0000FFFF   /**< Number of lines in a frame */
#define VGA32_TFT_HLEN      0xFFFF0000   /**< Number of pixel in a line */
/** @} */


#endif
