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

#ifndef _PER_EMAC32_H_
// copied from peripheral, used for emac32_setmode()

// Receiver command register bits
#define EMAC32_RX_CMD_ENABLE               0x00000001
#define EMAC32_RX_CMD_UNICAST              0x00000002
#define EMAC32_RX_CMD_BROADCAST            0x00000004
#define EMAC32_RX_CMD_MULTICAST            0x00000008
#define EMAC32_RX_CMD_PROMISC              0x00000010
#define EMAC32_RX_CMD_CLR_OVERFL           0x00000020
#define EMAC32_RX_CMD_CLR_CRCERR           0x00000040
#define EMAC32_RX_CMD_RESET                0x80000000

// Transmitter command bits
#define EMAC32_TX_CMD_ENABLE               0x00000001
#define EMAC32_TX_CMD_FULLDUPLEX           0x00000002
#define EMAC32_TX_CMD_RESET                0x80000000

#endif

typedef struct emac32_s emac32_t;

extern uint32_t *emac32_corebuf_alloc(emac32_t * restrict drv, int datasize);
extern void emac32_corebuf_send(emac32_t * restrict drv, uint32_t *corebuf);
extern uint32_t *emac32_corebuf_receive(emac32_t * restrict drv);
extern void emac32_corebuf_free(emac32_t * restrict drv, uint32_t *corebuf);

extern int emac32_send(emac32_t * restrict drv, uint8_t *buf, int size);
extern int emac32_receive(emac32_t * restrict drv, uint8_t *buf, int size);

extern void emac32_setmode(emac32_t * restrict drv, uint32_t rx_mode, uint32_t tx_mode);

extern void emac32_setmac(emac32_t * restrict drv, const uint8_t *mac);
extern void emac32_getmac(emac32_t * restrict drv, uint8_t *mac);

extern emac32_t *emac32_open(int id);

#if __POSIX_KERNEL__ == 0
inline void emac32_init(void) { /* empty */ }
#else
extern void emac32_init(void);
#endif

#ifdef  __cplusplus
}
#endif

#endif

