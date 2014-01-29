/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    UART8 serial communications device. Non-posix
|*                  interface.
|*
\*****************************************************************************/

#ifndef _DRV_UART8_H
#define _DRV_UART8_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <io.h>
#include <stdint.h>
#include <stdbool.h>

#define UART8_BREAK  0x100

typedef struct uart8_drv_s uart8_t;

extern int uart8_putbreak(uart8_t * restrict drv, uint8_t duration);
extern int uart8_putchar(uart8_t * restrict drv, int val);
extern int uart8_getchar(uart8_t * restrict drv);

extern bool uart8_transmit_idle(uart8_t * restrict drv);
extern size_t uart8_transmit_buf_free(uart8_t * restrict drv);
extern size_t uart8_receive_buf_available(uart8_t * restrict drv);

extern size_t uart8_write(uart8_t * restrict drv, const char *buf, size_t size);
extern size_t uart8_read(uart8_t * restrict drv, char *buf, size_t size);

extern void uart8_rts(uart8_t * restrict drv, bool pause);

extern void uart8_set_baudrate(uart8_t * restrict drv, uint32_t baudrate);
extern uint32_t uart8_get_baudrate(uart8_t * restrict drv);
extern void uart8_set_transmit_watermark(uart8_t * restrict drv, uint8_t lowmark);
extern void uart8_set_receive_watermark(uart8_t * restrict drv, uint8_t lowmark, uint8_t highmark, uint8_t timeout);
extern void uart8_set_transmit_chardelay(uart8_t * restrict drv, uint8_t delay);

extern void* uart8_get_tx_mutex     ( uart8_t * restrict drv );
extern void* uart8_get_rx_mutex     ( uart8_t * restrict drv );

uart8_t *uart8_open(int id);


#ifdef  __cplusplus
}
#endif

#endif /* _DRV_UART8_H */

