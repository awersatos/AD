/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    ETHERNET services: Generic Interface
|*
\*****************************************************************************/

/**
 * @file
 *
 * Service for ETHERNET peripherals. The API has a copying interface and a zero-copy interface.
 *
 * Copying interface:
 * |ethernet_receive()|get & free received header and/or data|
 * |ethernet_send()|allocate and send data|
 *
 * For both read and send using 16-bit aligned buffers will speed up the copying.
 *
 * Zero-copy interface:
 * |ethernet_corebuf_receive()|get a pointer to a receive packet buffer|
 * |ethernet_corebuf_free()|free the receive packet buffer|
 * |ethernet_corebuf_alloc()|get a pointer to a transmit packet buffer|
 * |ethernet_corebuf_send()|send the transmit packet buffer|
 *
 * After every succesfull ethernet_corebuf_receive() call, a ethernet_corebuf_free()
 * call must be made passing the pointer returned by the read call, before any
 * other ethernet_corebuf_receive() call can be made.

 *
 * After any succesfull ethernet_corebuf_alloc() call, a ethernet_corebuf_send()
 * call must be made passing the pointer returned by the allocate call, before any
 * other ethernet_corebuf_alloc() call can be made.
 *
 */


#ifndef _ETHERNET_H_
#define _ETHERNET_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

typedef struct ethernet_s ethernet_t;

extern uint32_t *ethernet_corebuf_alloc(ethernet_t * restrict srv, int datasize);
extern void ethernet_corebuf_send(ethernet_t * restrict srv, uint32_t *corebuf);
extern uint32_t *ethernet_corebuf_receive(ethernet_t * restrict srv);
extern void ethernet_corebuf_free(ethernet_t * restrict srv, uint32_t *corebuf);

extern int ethernet_send(ethernet_t * restrict srv, uint8_t *buf, int size);
extern int ethernet_receive(ethernet_t * restrict srv, uint8_t *buf, int size);

extern void ethernet_setmac(ethernet_t * restrict srv, const uint8_t *mac);
extern void ethernet_getmac(ethernet_t * restrict srv, uint8_t *mac);

extern ethernet_t *ethernet_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _ETHERNET_H */
