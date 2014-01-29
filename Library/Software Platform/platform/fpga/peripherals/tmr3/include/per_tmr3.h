/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        TMR3 peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the TMR3_W peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the TMR3_W peripheral, see the Core Reference
 * <a href="CR0112 TMR3 Dual Timer Unit.PDF">CR0106 TMR3 Dual Timer Unit</a>
 *
 */

#ifndef _PER_TMR3_H
#define _PER_TMR3_H

#include <stdint.h>

#define TMR3_BASE(baseaddr)    ((volatile uint8_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define TMR3_TCON(addr)         TMR3_BASE(addr)[0]    /**< Timer Control Register */
#define TMR3_TMOD(addr)         TMR3_BASE(addr)[1]    /**< Timer Mode Register */
#define TMR3_TLA(addr)          TMR3_BASE(addr)[2]    /**< TLA Register (functionality depends on current mode for Timer A) */
#define TMR3_TLB(addr)          TMR3_BASE(addr)[3]    /**< TLB Register (functionality depends on current mode for Timer B) */
#define TMR3_THA(addr)          TMR3_BASE(addr)[4]    /**< THA Register (functionality depends on current mode for Timer A) */
#define TMR3_THB(addr)          TMR3_BASE(addr)[5]    /**< THB Register (functionality depends on current mode for Timer B) */
/** @} */

/**
 * @name Timer Control Register
 */
/** @{ */
#define TCON_TFB    0x80    /**< Timer B overflow flag                      */
#define TCON_TRB    0x40    /**< Timer B Run control bit                    */
#define TCON_TFA    0x20    /**< Timer A overflow flag                      */
#define TCON_TRA    0x10    /**< Timer A Run control bit                    */
/** @} */

/**
 * @name Timer Mode Register
 */
/** @{ */
#define TB_GATE     0x80    /**< Use external trigger                                   */
#define TB_COUNTER  0x40    /**< Selects Counter operation (otherwise Timer operation)  */
#define TB_MODE3    0x30    /**< In this mode Timer B stops                             */
#define TB_MODE2    0x20    /**< 8 -bit auto-reload Timer/Counter                       */
#define TB_MODE1    0x10    /**< 16-bit Timer/Counter                                   */
#define TB_MODE0    0x00    /**< 13-bit Timer/Counter                                   */

#define TA_GATE     0x08    /**< Use external trigger                                   */
#define TA_COUNTER  0x04    /**< Selects Counter operation (otherwise Timer operation)  */
#define TA_MODE3    0x03    /**< If Timer B M1 and M0 bits are set to 1, Timer B stops. */
#define TA_MODE2    0x02    /**< 8 -bit auto-reload Timer/Counter                       */
#define TA_MODE1    0x01    /**< 16-bit Timer/Counter                                   */
#define TA_MODE0    0x00    /**< 13-bit Timer/Counter                                   */
/** @} */

#endif /* ndef _PER_TMR3_H */

