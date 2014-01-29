
#ifndef _PER_VGA32_16BPP_H
#define _PER_VGA32_16BPP_H

/**
 * @file
 * Direct access to the VGA32_16BPP peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * @see
 *     CR0165 - VGA32_16BPP - 32-bit VGA Controller with 16bpp Data Support
 */

#include <stdint.h>

#define VGA32_16BPP_WORD(BASE)          ((volatile uint32_t*)BASE)

/**
 * @name Core Registers
 */

/** @{ */
#define VGA32_16BPP_CTRL_REG(BASE)      VGA32_16BPP_WORD(BASE)[0]   /**< Control register */
#define VGA32_16BPP_HTIM_REG(BASE)      VGA32_16BPP_WORD(BASE)[2]   /**< Horizontal timing register */
#define VGA32_16BPP_VTIM_REG(BASE)      VGA32_16BPP_WORD(BASE)[3]   /**< Vertical timing register */
#define VGA32_16BPP_HVLEN_REG(BASE)     VGA32_16BPP_WORD(BASE)[4]   /**< Horizontal and vertical lenght register */
#define VGA32_16BPP_VMBA_REG(BASE)      VGA32_16BPP_WORD(BASE)[5]   /**< Video Memory Base Address register */
#define VGA32_16BPP_CDIV_REG(BASE)      VGA32_16BPP_WORD(BASE)[6]   /**< System clock division register */
/** @} */


/**
 * @name Core Control Register Bitmasks
 */
/** @{ */
#define VGA32_16BPP_VSE       0x0001   /**< Video System Enable */
#define VGA32_16BPP_HOP       0x0100   /**< Horizontal Synchronization Output Polarity */
#define VGA32_16BPP_VOP       0x0200   /**< Vertical Synchronization Output Polarity */
#define VGA32_16BPP_COP       0x0400   /**< Composite Synchronization Output Polarity */
#define VGA32_16BPP_BOP       0x0800   /**< Blanking Synchronization Output Polarity */
#define VGA32_16BPP_CKDE      0x1000   /**< Clock Division Enable */
/** @} */


/**
 * @name Core Horizontal Timing Register Bitmasks
 */
/** @{ */
#define VGA32_16BPP_HVISIBLE  0x0000FFFF   /**< Horizontal Visible Area */
#define VGA32_16BPP_HBPORCH   0x00FF0000   /**< Horizontal Back Porch length */
#define VGA32_16BPP_HSYNC     0xFF000000   /**< Horizontal Synch Pulse length */
/** @} */


/**
 * @name Core Vertical Timing Register Bitmasks
 */
/** @{ */
#define VGA32_16BPP_VVISIBLE  0x0000FFFF   /**< Vertical Visible Area */
#define VGA32_16BPP_VBPORCH   0x00FF0000   /**< Vertical Back Porch length */
#define VGA32_16BPP_VSYNC     0xFF000000   /**< Vertical Synch Pulse length */
/** @} */


/**
 * @name Core Horizontal and Vertical Length Register Bitmasks
 */
/** @{ */
#define VGA32_16BPP_VLEN      0x0000FFFF   /**< Number of lines in a frame */
#define VGA32_16BPP_HLEN      0xFFFF0000   /**< Number of pixel in a line */
/** @} */


#endif
