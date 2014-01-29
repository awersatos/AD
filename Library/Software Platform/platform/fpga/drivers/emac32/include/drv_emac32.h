/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        EMAC32 driver
|*
\*****************************************************************************/

/**
 * @file
 *
 * Driver for WB_EMAC32 peripheral. The API has a copying interface and a zero-copy interface.
 *
 * Copying interface:
 * |emac32_receive()|get & free received header and/or data|
 * |emac32_send()|allocate and send data|
 *
 * For both read and send using 16-bit aligned buffers will speed up the copying.
 *
 * Zero-copy interface:
 * |emac32_corebuf_receive()|get a pointer to a receive packet buffer|
 * |emac32_corebuf_free()|free the receive packet buffer|
 * |emac32_corebuf_alloc()|get a pointer to a transmit packet buffer|
 * |emac32_corebuf_send()|send the transmit packet buffer|
 *
 * After every succesfull emac32_corebuf_receive() call, a emac32_corebuf_free()
 * call must be made passing the pointer returned by the read call, before any
 * other emac32_corebuf_receive() call can be made.
 *
 * After any succesfull emac32_corebuf_alloc() call, a emac32_corebuf_send()
 * call must be made passing the pointer returned by the allocate call, before any
 * other emac32_corebuf_alloc() call can be made.
 *
 */


#ifndef _DRV_EMAC32_H
#define _DRV_EMAC32_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <per_emac32.h>

/**
 * @name Link Status flags
 */
/** @{ */
#define PHY_VALID_LINK              0x01    /**< Valid link detected */
#define PHY_FULL_DUPLEX             0x02    /**< Full duplex */
#define PHY_LINK_100MB              0x04    /**< Speed is 100Mb */
#define PHY_AUTO_NEG_COMPLETE       0x08    /**< Auto negotiation completed */
#define PHY_JABBER                  0x10    /**< Jabber detected */
/** @} */

typedef struct emac32_s emac32_t;

extern emac32_t *   emac32_open(unsigned int id);

extern void         emac32_setmode(emac32_t * restrict drv, uint32_t rx_cmd, uint32_t tx_cmd);

extern void         emac32_setmac(emac32_t * restrict drv, const uint8_t *mac);
extern void         emac32_getmac(emac32_t * restrict drv, uint8_t *mac);

// MDI API
extern void         emac32_write_md( emac32_t * restrict drv, uint8_t reg, uint16_t data );
extern uint16_t     emac32_read_md(emac32_t * restrict drv, uint8_t reg );
extern uint8_t      emac32_linkstatus(emac32_t * restrict drv);

// zero-copy API
extern uint32_t *   emac32_corebuf_alloc(emac32_t * restrict drv, int size);
extern void         emac32_corebuf_send(emac32_t * restrict drv, uint32_t *corebuf);
extern uint32_t *   emac32_corebuf_receive(emac32_t * restrict drv);
extern void         emac32_corebuf_free(emac32_t * restrict drv, uint32_t *corebuf);

// copying API
extern int          emac32_send(emac32_t * restrict drv, uint8_t *buf, int size);
extern int          emac32_receive(emac32_t * restrict drv, uint8_t *buf, int size);

#ifdef  __cplusplus
}
#endif

#endif

