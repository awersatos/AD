/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         IR remote control device driver
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Interface to WB_IRRC peripheral
|*
 */
/**
 * @file
 * Direct access to the IrRC hardware registers of the IRRC perihperal.
 * Generally, you will use a higher level interface.
 *
 * For a detailed description of the IrRC peripheral, see the Core Reference
 * <a href="CR0188 WB_IRRC Infrared coder.PDF">CR0188 WB_IRRC Infrared coder</a>
 *
 */

#ifndef _PERIRRC_H
#define _PERIRRC_H


#define IRRC_BASE(base)           ((volatile uint32_t *) (base))
#define IRRC_CLK(base)            IRRC_BASE(base)[0]            // Clock register
#define IRRC_CTRL(base)           IRRC_BASE(base)[1]            // Control register (see below)
#define IRRC_STATUS(base)         IRRC_BASE(base)[2]            // Status register (see below)
#define IRRC_DATA(base)           IRRC_BASE(base)[3]            // Data register

/*
 * Contents of control register
 */

#define IRRC_CTRL_INTEN    0x01                // Interrupt enable
#define IRRC_CTRL_RXINTRST 0x02                // RX Interrupt reset / acknowledge data reception
#define IRRC_CTRL_CODEC    (0x40 + 0x80)       // Codec selection

#define IRRC_CTRL_RAW  (0 << 6)                // RAW 'codec'
#define IRRC_CTRL_NEC  (1 << 6)                // NEC codec
#define IRRC_CTRL_RC5  (2 << 6)                // RC5 codec

/*
 * Contents of status register
 */

#define IRRC_STATUS_RXINT     0x01             // Receive Interrupt
#define IRRC_STATUS_RXPDET    0x02             // Pulse was detected
#define IRRC_STATUS_RXOVERRUN 0x04             // rx overflow
#define IRRC_STATUS_RXREPEAT  0x08             // Last received code was a repeat code
#define IRRC_STATUS_TXBUSY    0x10             // Trasnmitter busy; donot try to send data

#endif /* _PERIRRC_H */
