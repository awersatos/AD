/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        IRRC peripheral driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Driver for the Infrared Remote Control WB_IRRC peripheral. This driver enables you
 * to transmit and receive infrared signals used in remote control enabled consumer
 * electronics. Besides a raw mode, this driver supports RC5(receive only) and the NEC 
 * IR protocol/codec. After configuring this driver, open the hardware by using 
 * irrc_open(). 
 *
 * For a detailed description of the WB_IRRC peripheral, see the Core Reference
 * <a href="CR0188 WB_IRRC Infrared Coder.pdf">CR0188 WB_IRRC Infrared coder</a>
 */
#ifndef _DRV_IRRC_H
#define _DRV_IRRC_H

#ifdef  __cplusplus
extern "C" {
#endif

/**
 * @name Transmission codec
 */
/** @{ */
#define IRRC_CODEC_RAW          0   /**< RAW transmission format */
#define IRRC_CODEC_NEC          1   /**< NEC transmission format */
#define IRRC_CODEC_RC5          2   /**< RC5 transmission format */
/** @} */

#include <stdint.h>

typedef struct irrc_drv_s irrc_t;

extern uint32_t irrc_getcodec(irrc_t * restrict drv);
extern uint32_t irrc_getstatus(irrc_t * restrict drv);
extern uint32_t irrc_getctrl(irrc_t * restrict drv);
extern void irrc_setctrl(irrc_t * restrict drv, uint32_t value);
extern int irrc_rxrepeat(irrc_t * restrict drv);
extern int irrc_rxdata(irrc_t * restrict drv);
extern uint32_t irrc_data(irrc_t * restrict drv);
extern int irrc_rxrawdata(irrc_t * restrict drv, int usecs, uint32_t *pcount, uint32_t *scount);
extern int irrc_rxrc5data(irrc_t * restrict drv, uint16_t *address, uint16_t *command);
extern int irrc_rxnecdata(irrc_t * restrict drv, uint16_t *address, uint16_t *command);
extern void irrc_txrawdata(irrc_t * restrict drv, uint32_t pcount, uint32_t scount);
extern void irrc_txnecdata(irrc_t * restrict drv, int count, uint16_t address, uint16_t command);
extern irrc_t *irrc_open(int id);

#ifdef  __cplusplus
}
#endif

#endif // _DRV_IRRC_H


