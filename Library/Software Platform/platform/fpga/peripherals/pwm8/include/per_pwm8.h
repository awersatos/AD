/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        PWM8 peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the WB_PWM8 peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the WB_PWM8 peripheral, see the Core Reference
 * <a href="CR0155 WB_PWMx Pulse Width Modulation Controller.PDF">WB_PWMx Pulse Width Modulation Controller</a>
 *
 */

#ifndef _PER_PWM8_H
#define _PER_PWM8_H

#include <stdint.h>

#define PWM8_BASE(baseaddr)    ((volatile uint8_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define PWM8_PWMRG(addr)        PWM8_BASE(addr)[0]    /**< Pulse width 00h is full-off and FFh is full-on */
#define PWM8_PWPLO(addr)        PWM8_BASE(addr)[1]    /**< Low Byte of the 16-bit Pre-scaler Counter reload value */
#define PWM8_PWPHI(addr)        PWM8_BASE(addr)[2]    /**< High Byte of the 16-bit Pre-scaler Counter reload value */
#define PWM8_PWCON(addr)        PWM8_BASE(addr)[3]    /**< Control Register */
/** @} */

/**
 * @name Control Register
 */
/** @{ */
#define PWCON_PWI   0x80    /**< PWM Counter Interrupt flag                             */
#define PWCON_PRI   0x40    /**< Pre-Scaler Counter Interrupt flag                      */
#define PWCON_PFL1  0x20    /**< Spare bit(can be used as a general purpose flag)       */
#define PWCON_PFL0  0x10    /**< Spare bit(can be used as a general purpose flag)       */
#define PWCON_PWIE  0x08    /**< PWM counter interrupt enable                           */
#define PWCON_PRIE  0x04    /**< Pre-scaler counter interrupt enable                    */
#define PWCON_PIEN  0x02    /**< Interrupt enable                                       */
#define PWCON_PWEN  0x01    /**< Controller enable                                      */
/** @} */

#endif /* ndef _PER_PWM8_H */

