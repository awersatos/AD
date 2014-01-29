/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        PWMX peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the WB_PWMX peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the WB_PWMX peripheral, see the Core Reference
 * <a href="CR0155 WB_PWMx Pulse Width Modulation Controller.PDF">WB_PWMx Pulse Width Modulation Controller</a>
 *
 */

#ifndef _PER_PWMX_H
#define _PER_PWMX_H

#include <stdint.h>

#define PWMX_BASE(baseaddr)    ((volatile uint8_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define PWMX_PWMRG(addr)        PWMX_BASE(addr)[0]    /**< Pulse width low byte                                     */
#define PWMX_PWPLO(addr)        PWMX_BASE(addr)[1]    /**< Low Byte of the 16-bit Pre-scaler Counter reload value   */
#define PWMX_PWPHI(addr)        PWMX_BASE(addr)[2]    /**< High Byte of the 16-bit Pre-scaler Counter reload value  */
#define PWMX_PWCON(addr)        PWMX_BASE(addr)[3]    /**< Control Register                                         */
#define PWMX_PWMRGH(addr)       PWMX_BASE(addr)[4]    /**< Upper bits of the pulse width                            */
/** @} */

/**
 * @name Control Register
 */
/** @{ */
#define PWCON_PWI   0x80    /**< PWM Counter Interrupt flag                             */
#define PWCON_PRI   0x40    /**< Pre-Scaler Counter Interrupt flag                      */
#define PWCON_MOD1  0x20    /**< 00 - 8-bit, 01 - 10 bit, 10 - 12 bit, 11 - 14 bit      */
#define PWCON_MOD0  0x10    /**< see MOD1                                               */
#define PWCON_PWIE  0x08    /**< PWM counter interrupt enable                           */
#define PWCON_PRIE  0x04    /**< Pre-scaler counter interrupt enable                    */
#define PWCON_PIEN  0x02    /**< Interrupt enable                                       */
#define PWCON_PWEN  0x01    /**< Controller enable                                      */
/** @} */

#endif /* ndef _PER_PWMX_H */

