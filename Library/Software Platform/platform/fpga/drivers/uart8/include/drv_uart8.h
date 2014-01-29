/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    UART8 serial communications device driver.
|*
\*****************************************************************************/

/**
 * @file
 * Driver for WB_UART8 peripheral.
 *
 * The driver can either use the UART core buffer, or it can use an additional,
 * interrupt controlled software buffer.
 *
 * Buffer settings and blocking behavior can be changed independently for
 * receive and transmit.
 *
 */

#ifndef _DRV_UART8_H
#define _DRV_UART8_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

// Special characters from uart8_getchar()
#define UART8_PARERR            0x100   /**< Parity error (see uart8_getchar()). Note: in user parity, this does not indicate an error but reflects the value of parity bit! */
#define UART8_BREAK             0x200   /**< BREAK detected (see uart8_getchar()) */
#define UART8_FRAMERR           0x400   /**< Framing error (see uart8_getchar()) */

// Parity parameters in uart8_set_parameters()
/**
 * @brief
 *  Parity modes
 *
 *  This enum defines all parity modes.
 */
typedef enum
{
    UART8_NO_PARITY,                    /**< No parity (see uart8_set_parameters()) */
    UART8_ODD_PARITY,                   /**< Odd parity (see uart8_set_parameters()) */
    UART8_EVEN_PARITY,                  /**< Even parity (see uart8_set_parameters()) */
    UART8_USER_PARITY                   /**< User parity (see uart8_set_parameters()) */
} uart8_parity_t;

// Bits in the driver status word as returned by uart8_get_drvstat()
#define DRV_UART8_INITIALIZED   0x01    /**< UART driver initialized (see uart8_get_drvstat()) */
#define DRV_UART8_RXSTALLED     0x02    /**< UART receiver full, stalled (see uart8_get_drvstat()) */
#define DRV_UART8_TXSTALLED     0x04    /**< UART transmitter full, stalled (see uart8_get_drvstat()) */

typedef struct uart8_drv_s uart8_t;

extern int      uart8_putbreak(uart8_t * restrict drv, uint8_t duration);
extern int      uart8_putchar(uart8_t * restrict drv, int val);
extern int      uart8_getchar(uart8_t * restrict drv);

extern bool     uart8_transmit_idle(uart8_t * restrict drv);
extern size_t   uart8_transmit_buf_free(uart8_t * restrict drv);
extern size_t   uart8_receive_buf_available(uart8_t * restrict drv);

extern size_t   uart8_write(uart8_t * restrict drv, const char *buf, size_t size);
extern size_t   uart8_read(uart8_t * restrict drv, char *buf, size_t size);

extern void     uart8_rts(uart8_t * restrict drv, bool pause);

extern void     uart8_set_baudrate(uart8_t * restrict drv, uint32_t baudrate);
extern uint32_t uart8_get_baudrate(uart8_t * restrict drv);
extern void     uart8_set_transmit_watermark(uart8_t * restrict drv, uint8_t lowmark);
extern void     uart8_set_receive_watermark(uart8_t * restrict drv, uint8_t lowmark, uint8_t highmark, uint8_t timeout);
extern void     uart8_set_transmit_chardelay(uart8_t * restrict drv, uint8_t delay);

extern uart8_t *uart8_open(unsigned int id);
extern void     uart8_reset(uart8_t * restrict drv);

extern uint8_t uart8_get_drvstat(uart8_t * restrict drv);
extern uint8_t uart8_get_version(uart8_t * restrict drv);

extern void     uart8_set_parameters(uart8_t * restrict drv, uint32_t baudrate, uart8_parity_t parity, uint8_t databits, uint8_t stopbits);
extern uint8_t  uart8_get_parity( uart8_t * restrict drv );
extern uint8_t  uart8_get_databits( uart8_t * restrict drv );
extern uint8_t  uart8_get_stopbits( uart8_t * restrict drv );
extern void     uart8_ignore(uart8_t * restrict drv, uint16_t rx_mask);
extern void     uart8_set_user_parity( uart8_t * restrict drv, int val );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_UART8_H */
