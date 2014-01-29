#ifndef _PER_VGA32_ILI9320_H
#define _PER_VGA32_ILI9320_H

/**
 * @file
 * Direct access to the VGA32_ILI9320 peripheral.
 * Generally, application writers will use a higher level interface.
 *
 */

#include <stdint.h>

#define VGA32_ILI9320_WORD( BASE )          ((volatile uint32_t * const) (BASE) )

/**
 * @name Core Registers
 */

/** @{ */
#define VGA32_ILI9320_REFR_REG( BASE )      VGA32_ILI9320_WORD( BASE )[0]     /**< Refresh Control register */
#define VGA32_ILI9320_ARP_REG( BASE )       VGA32_ILI9320_WORD( BASE )[1]     /**< Repeatedly Refresh Period register, refresh interval */
#define VGA32_ILI9320_WPULSE_REG( BASE )    VGA32_ILI9320_WORD( BASE )[2]     /**< Write Pulse timing register */
#define VGA32_ILI9320_VMBA_REG( BASE )      VGA32_ILI9320_WORD( BASE )[3]     /**< Video Memory Base Address register */
#define VGA32_ILI9320_PIX_REG( BASE )       VGA32_ILI9320_WORD( BASE )[4]     /**< Total Pixels register */
#define VGA32_ILI9320_GRAM_REG( BASE )      VGA32_ILI9320_WORD( BASE )[5]     /**< GRAM Address register */
/** @} */


/**
 * @name Refresh Control Register Bitmasks
 */
/** @{ */
#define VGA32_ILI9320_RO        0x0001   /**< Refresh Once */
#define VGA32_ILI9320_RR        0x0002   /**< Refresh Repeatedly */
/** @} */


/**
 * @name Write Pulse Timing Register Bitmasks
 */
/** @{ */
#define VGA32_ILI9320_WL        0x000F   /**< Write Pulse Low  */
#define VGA32_ILI9320_WR        0x00F0   /**< Write Pulse High */
/** @} */





#endif
