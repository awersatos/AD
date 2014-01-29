/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    UART8 serial communications device driver.
|*                  Internal (private) interface.
|*
\*****************************************************************************/

#ifndef _DRV_UART8_INTERNAL_H
#define _DRV_UART8_INTERNAL_H

#include <drv_uart8.h>

#include "per_uart8_cfg_instance.h"
#include "drv_uart8_cfg_instance.h"

#define TXLOWMARK_DEFAULT   4
#define RXLOWMARK_DEFAULT   2
#define RXHIGHMARK_DEFAULT  8
#define RXDTO_DEFAULT       32

#define RX_STALLED_RESTART  16

#define TX_INT   (UART8_STATUS_TXEMPTY | UART8_STATUS_TXLOW)
#define RX_INT   (UART8_STATUS_RXTIMEOUT | UART8_STATUS_RXHIGH)

/* TX Interrupt */

// we need posix interrupts for thread notification
#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NOTIFY_USED
# define TX_INTERRUPT_POSIX 1
#endif

// for non-threaded operation or any other blocking mode besides NOTIFY we use native interrupts
#if (__POSIX_KERNEL__ != 1)                         || \
    DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NONE_USED   || \
    DRV_UART8_INSTANCE_TX_BLOCKING_MODE_LOOP_USED   || \
    DRV_UART8_INSTANCE_TX_BLOCKING_MODE_POLL_USED   || \
    DRV_UART8_INSTANCE_TX_BLOCKING_MODE_YIELD_USED
# if DRV_UART8_INSTANCE_TX_BUFFER_MAX > 0
#  define TX_INTERRUPT_NATIVE 1
# endif
#endif

/* RX Interrupt */

// we need posix interrupts for thread notification
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NOTIFY_USED
# define RX_INTERRUPT_POSIX 1
#endif

// for non-threaded operation or any other blocking mode besides NOTIFY we use native interrupts
#if (__POSIX_KERNEL__ != 1)                         || \
    DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NONE_USED   || \
    DRV_UART8_INSTANCE_RX_BLOCKING_MODE_LOOP_USED   || \
    DRV_UART8_INSTANCE_RX_BLOCKING_MODE_POLL_USED   || \
    DRV_UART8_INSTANCE_RX_BLOCKING_MODE_YIELD_USED
# if DRV_UART8_INSTANCE_RX_BUFFER_MAX > 0
#  define RX_INTERRUPT_NATIVE 1
# endif
#endif

/* RTS */

#if DRV_UART8_INSTANCE_HANDSHAKE_RTSSOFT_USED
// optionally use margin in RX buffer to handle handshaking
# define RTSSOFT 1
#endif

/* Mutex support */

#if __POSIX_KERNEL__ && DRV_UART8_INSTANCE_MUTEX_TRUE_USED

# define MUTEXES 1

# define UART8_MUTEXRX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(rxbuffer)
# define UART8_MUTEXTX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(txbuffer)

# if DRV_UART8_INSTANCE_MUTEX_FALSE_USED // conditional mutexes
#  define UART8_MUTEXTX_LOCK(drv)           if (drv->mutexes) POSIX_DEV_MUTEX_LOCK(&drv->tx_mutex, txbuffer)
#  define UART8_MUTEXTX_UNLOCK(drv)         if (drv->mutexes) POSIX_DEV_MUTEX_UNLOCK(&drv->tx_mutex, txbuffer)
#  define UART8_MUTEXRX_LOCK(drv)           if (drv->mutexes) POSIX_DEV_MUTEX_LOCK(&drv->rx_mutex, rxbuffer)
#  define UART8_MUTEXRX_UNLOCK(drv)         if (drv->mutexes) POSIX_DEV_MUTEX_UNLOCK(&drv->rx_mutex, rxbuffer)
# else // unconditional mutexes
#  define UART8_MUTEXTX_LOCK(drv)           POSIX_DEV_MUTEX_LOCK(&drv->tx_mutex, txbuffer)
#  define UART8_MUTEXTX_UNLOCK(drv)         POSIX_DEV_MUTEX_UNLOCK(&drv->tx_mutex, txbuffer)
#  define UART8_MUTEXRX_LOCK(drv)           POSIX_DEV_MUTEX_LOCK(&drv->rx_mutex, rxbuffer)
#  define UART8_MUTEXRX_UNLOCK(drv)         POSIX_DEV_MUTEX_UNLOCK(&drv->rx_mutex, rxbuffer)
# endif

#else // no mutexes

#define UART8_MUTEXRX_PREPARE()             do {} while (0)
#define UART8_MUTEXRX_LOCK(drv)             do {} while (0)
#define UART8_MUTEXRX_UNLOCK(drv)           do {} while (0)
#define UART8_MUTEXTX_PREPARE()             do {} while (0)
#define UART8_MUTEXTX_LOCK(drv)             do {} while (0)
#define UART8_MUTEXTX_UNLOCK(drv)           do {} while (0)

#endif

/* Driver structure */

struct uart8_drv_s
{
    uint8_t status;
    uint8_t rx_mask;

    int handshake;

    /* TX */
    int tx_head;
    volatile int tx_tail;
    volatile bool tx_busy;
    bool tx_parityval;
    int tx_blocking_mode;
#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_POLL_USED
    uint32_t tx_pollmscs;
#endif
#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NOTIFY_USED
    volatile int tx_notify_count;
#endif

    /* RX */
    volatile int rx_head;
    int rx_tail;
#if RTSSOFT
    int rx_margin;
#endif
    int rx_blocking_mode;
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_POLL_USED
    uint32_t rx_pollmscs;
#endif
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NOTIFY_USED
    volatile int rx_notify_count;
#endif

    /* mutexes */
#if MUTEXES
    pthread_mutex_t tx_mutex;
    pthread_mutex_t rx_mutex;
# if DRV_UART8_MUTEX_FALSE_USED
    bool            mutexes;
# endif
#endif
    // workcopies from driver configuration
    uint16_t *tx_buffer;
    int tx_buffer_size;

    uint16_t *rx_buffer;
    int rx_buffer_size;

    uint32_t baudrate;
    uintptr_t baseaddress;
    uint8_t tx_interrupt;
    uint8_t rx_interrupt;
};

/* buffer convenience functions */

// how ring buffers work:
// - write to head, read from tail, wrap if pointer reaches the end
// - head == tail : buffer empty
// - head + 1 == tail : buffer full
//   NOTE: this means we can only store size - 1 bytes,
//         because otherwise we can't distinguish between full and empty buffers
// free/used space calculations:
// - available = head - tail ; if (available < 0) available += size;
// - free = tail - head - 1 ; if (free < 0) free += size;

inline int uart8_buffer_get_next(int pointer, int size)
{
    int result = pointer + 1;
    if (result == size) result = 0; // wrap
    return result;
}

inline int uart8_buffer_get_available(int head, int tail, int size)
{
    int result = head - tail;
    if (result < 0) result += size;
    return result;
}

inline int uart8_buffer_get_free(int head, int tail, int size)
{
    int result = tail - head - 1;
    if (result < 0) result += size;
    return result;
}

/* drv_uart8_internal.c */

extern void*    uart8_get_tx_mutex(uart8_t * restrict drv);
extern void*    uart8_get_rx_mutex(uart8_t * restrict drv);
extern int      uart8_putbreak_internal(uart8_t * restrict drv, uint8_t duration);
extern int      uart8_putchar_internal(uart8_t * restrict drv, int val);
extern int      uart8_getchar_internal(uart8_t * restrict drv);
extern void     uart8_set_baudrate_internal(uart8_t * restrict drv, uint32_t baudrate);
extern uint32_t uart8_get_baudrate_internal(uart8_t * restrict drv);

/* drv_uart8_interrupts.c */

#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NOTIFY_USED
extern int      uart8_transmit_buf_free_timedwait(uart8_t * restrict drv, int count);
#endif
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NOTIFY_USED
extern int      uart8_receive_buf_available_timedwait(uart8_t * restrict drv, int count);
#endif
extern void     uart8_connect_interrupts(uart8_t * restrict drv);

#endif /* _DRV_UART8_INTERNAL_H */

