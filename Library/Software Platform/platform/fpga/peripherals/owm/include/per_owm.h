///////////////////////////////////////////////////////////////////////////////
//
//  IN PACKAGE:         Low Level Peripheral Interface
//
//  COPYRIGHT:          Copyright (c) 2007, Altium
//
//  DESCRIPTION:        Device driver interface for Wishbone One Wire Master Controller
//
///////////////////////////////////////////////////////////////////////////////

/**
 * @file
 * Direct access to the WB_OWM peripheral.
 * Generally, application writers will use a higher level interface.
 *
 */


#ifndef __PER_OWM_H
#define __PER_OWM_H

/**
 * @name Core Registers
 */

/** @{ */
#define OWM_CMD(base)     (*(volatile uint8_t*)(base + 0)) /**< Command Register            */
#define OWM_DATA(base)    (*(volatile uint8_t*)(base + 1)) /**< Data Register               */
#define OWM_INT(base)     (*(volatile uint8_t*)(base + 2)) /**< Interrupt Register          */
#define OWM_INTEN(base)   (*(volatile uint8_t*)(base + 3)) /**< Interrupt Enable Register   */
#define OWM_CLKDIV(base)  (*(volatile uint8_t*)(base + 4)) /**< Clock Divider Register      */
#define OWM_BUS_SEL(base) (*(volatile uint8_t*)(base + 8)) /**< Bus Select                  */
/** @} */

#endif // __PER_OWM_H


