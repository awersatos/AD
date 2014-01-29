/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    UART8 serial communications driver.
|*                  Interrupt handling.
|*
\*****************************************************************************/

#include <interrupts.h>

#include <per_uart8.h>
#include <drv_uart8.h>

#include "drv_uart8_internal.h"

/*
 * TX interrupt
 */

/*****************************************************************************
|*
|*  Function:           tx_handler_common
|*
|*  Parameters:         num : interrupt number
|*                      drv : pointer to driver
|*
|*  Description:        Handle transmit interrupts.
 */
static inline void tx_handler_common(uint32_t num, uart8_t * restrict drv)
{
    int txtail;
    int txhead;

    // acknowledge as soon as possible
    interrupt_acknowledge(num);

    // cache volatile values
    txtail  = drv->tx_tail;
    txhead  = drv->tx_head;

    drv->status &= ~DRV_UART8_TXSTALLED;

    while (!((UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL)) && (txtail != txhead))
    {
        uint16_t val = drv->tx_buffer[txtail];

        if (val & UART8_BREAK)
        {
            UART8_BRKLEN(drv->baseaddress) = val & 0xFF;
        }
        else
        {
            if ( val & UART8_PARERR )
            {
                UART8_PARM( drv->baseaddress ) |= UART8_PARM_PARITYVAL;
            }
            else
            {
                UART8_PARM( drv->baseaddress ) &= ~UART8_PARM_PARITYVAL;
            }

            UART8_SBUF(drv->baseaddress) = val & 0xFF;
        }
        txtail = uart8_buffer_get_next(txtail, drv->tx_buffer_size);
    }

    if (txtail == txhead)
    {
        /* no need to check for status low when there is no more to transmit    */
        UART8_INTMASK_RST(drv->baseaddress) = UART8_STATUS_TXLOW;
    }
    else if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL)
    {
        drv->status |= DRV_UART8_TXSTALLED;
    }

    if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXEMPTY)
    {
        // buffer empty, disable transmit interrupts
        drv->tx_busy = false;
        UART8_INTMASK_RST(drv->baseaddress) = TX_INT;
    }

    // update final tail value
    drv->tx_tail = txtail;
}


#if TX_INTERRUPT_POSIX

// threaded interrupt wrapper
static uint32_t tx_handler(uint32_t num, void *arg)
{
    uart8_t * restrict drv = (uart8_t*) arg;
    int retvalue = INTERRUPT_HANDLED;
    int tx_free;

    tx_handler_common(num, drv);

    if (drv->tx_notify_count)
    {
        // test free space in buffer
        tx_free = uart8_buffer_get_free(drv->tx_head, drv->tx_tail, drv->tx_buffer_size);
        if (tx_free >= drv->tx_notify_count)
        {
            retvalue |= INTERRUPT_NOTIFY;
            drv->tx_notify_count = 0;
        }
    }

    return retvalue;
}

#endif


#if TX_INTERRUPT_NATIVE

// native interrupt wrapper
__INTERRUPT_NATIVE void uart8_tx_handler_native(void)
{
    int num = interrupt_get_current();

    uart8_t * restrict drv = (uart8_t*) interrupt_native_context(num);

    tx_handler_common(num, drv);
}

#endif

/*
 * RX interrupt
 */

/*****************************************************************************
|*
|*  Function:           rx_handler_common
|*
|*  Parameters:         num : interrupt number
|*                      drv : pointer to driver
|*
|*  Description:        Handle interrupts from receiver.
 */
static inline void rx_handler_common(uint32_t num, uart8_t * restrict drv)
{
    uint16_t lcr;
    uint8_t data;
    int next;
    int rxtail;
    int rxhead;

    // acknowledge as soon as possible
    interrupt_acknowledge(num);

    // cache volatile values
    rxtail  = drv->rx_tail;
    rxhead  = drv->rx_head;

    while (UART8_STATUS(drv->baseaddress) & UART8_STATUS_RXNEMPTY)
    {
        lcr = UART8_LCR(drv->baseaddress);
        if ( lcr & drv->rx_mask )
        {
            // There's an error or break that was flagged as "ignore"
            UART8_SBUF(drv->baseaddress);   // Clear from buffer
            continue;
        }

        next = uart8_buffer_get_next(rxhead, drv->rx_buffer_size);

        if (next == rxtail)
        {
            // buffer full, disable receive interrupts
            UART8_INTMASK_RST(drv->baseaddress) = RX_INT;
            drv->status |= DRV_UART8_RXSTALLED;
            break;
        }

        data = UART8_SBUF(drv->baseaddress);
        drv->rx_buffer[rxhead] = data | (lcr << 8);
        rxhead = next;
    }

#if RTSSOFT
    if (drv->handshake == DRV_UART8_HANDSHAKE_RTSSOFT)
    {
        // test free space in buffer
        int rx_free = uart8_buffer_get_free(rxhead,rxtail,drv->rx_buffer_size);
        if (rx_free < drv->rx_margin)
        {
            // raise RTS
            UART8_LCR(drv->baseaddress) |= UART8_LCR_RTSVAL;
        }
    }
#endif

    // update rxhead from cache
    drv->rx_head = rxhead;
}


#if RX_INTERRUPT_POSIX // thread notification

// threaded interrupt wrapper
static uint32_t rx_handler(uint32_t num, void *arg)
{
    uart8_t * restrict drv = (uart8_t*) arg;
    int retvalue = INTERRUPT_HANDLED;

    rx_handler_common(num, drv);

    if (drv->rx_notify_count)
    {
        // used space in buffer
        int rx_used = uart8_buffer_get_available(drv->rx_head,drv->rx_tail,drv->rx_buffer_size);
        if (rx_used >= drv->rx_notify_count)
        {
            retvalue |= INTERRUPT_NOTIFY;
            drv->rx_notify_count = 0;
        }
    }

    return retvalue;
}

#endif


#if RX_INTERRUPT_NATIVE

// native interrupt wrapper
__INTERRUPT_NATIVE void uart8_rx_handler_native(void)
{
    int num = interrupt_get_current();
    uart8_t * restrict drv = (uart8_t*) interrupt_native_context(num);

    rx_handler_common(num, drv);
}

#endif

// used from drv_uart8.c for interrupt notification
#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NOTIFY_USED
/*
 * Wait for interrupt notification of space in transmit buffer
 *
 * Wait for count bytes free space to become available in the transmit buffer
 * (by using interrupt waiting), or for the optional timeout to pass.
 * This function requires a non-zero sized transmit buffer.
 *
 * param       drv       uart8 driver pointer
 * param       count     number of bytes free space to wait for
 *
 * return Errorcode from posix_interrupt_timedwait() if failed or interrupted, 0 otherwise.
 */
int uart8_transmit_buf_free_timedwait(uart8_t * restrict drv, int count)
{
    int err = 0;
    int tx_free;
    int tx_interrupt = drv->tx_interrupt;

    if (count > (drv->tx_buffer_size - 1))
    {
        // limit count to buffersize
        count = drv->tx_buffer_size - 1;
    }

    // using driver buffer and interrupt handler
//    interrupt_disable(tx_interrupt);
    tx_free = uart8_buffer_get_free(drv->tx_head, drv->tx_tail, drv->tx_buffer_size);
//    interrupt_enable(tx_interrupt);

    if (tx_free < count)
    {
        // not enough free space, we need to wait

        // associate, but thread can be interrupted before the association completes
        pthread_interrupt_associate(tx_interrupt, &tx_handler, (void*) drv);

        // test free space again, but this time with the interrupt disabled
        interrupt_disable(tx_interrupt);
        tx_free = uart8_buffer_get_free(drv->tx_head, drv->tx_tail, drv->tx_buffer_size);

        if (tx_free >= count)
        {
            // enough free space after all, waiting not needed
            pthread_interrupt_disassociate(tx_interrupt, &tx_handler, (void*) drv);
            interrupt_enable(tx_interrupt);
        }
        else
        {
            // tell interrupthandler how much we want and wait for its notification
            drv->tx_notify_count = count;
            interrupt_enable(tx_interrupt);
            err = pthread_interrupt_timedwait(NULL);
            pthread_interrupt_disassociate(tx_interrupt, &tx_handler, (void*) drv);
        }
    }

    return err;
}
#endif // DRV_UART8_TX_BLOCKING_MODE_NOTIFY_USED


// used from drv_uart8.c for interrupt notification
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NOTIFY_USED
/*
 * Wait for interrupt notification of received data
 *
 * Wait for count bytes to become available in the receiver buffer
 * (by using interrupt waiting), or for the optional timeout to pass.
 * This function requires a non-zero sized receive buffer.
 *
 * param       drv       uart8 driver pointer
 * param       count     number of bytes to wait for
 *
 * return Errorcode from posix_interrupt_timedwait() if failed or interrupted, 0 otherwise.
 */
int uart8_receive_buf_available_timedwait(uart8_t * restrict drv, int count)
{
    int err = 0;
    int available;
    int rx_interrupt = drv->rx_interrupt;

    if (count > (drv->rx_buffer_size - 1))
    {
        // limit count to buffersize
        count = drv->rx_buffer_size - 1;
    }

    // see how much data
//    interrupt_disable(rx_interrupt);
    available = uart8_buffer_get_available(drv->rx_head, drv->rx_tail, drv->rx_buffer_size);
//    interrupt_enable(rx_interrupt);

    if (available < count)
    {
        // not enough data, we need to wait

        // associate, but thread can be interrupted before the association completes
        pthread_interrupt_associate(rx_interrupt, &rx_handler, (void*) drv);

        // see again how much data, but this time with the interrupt disabled
        interrupt_disable(rx_interrupt);
        available = uart8_buffer_get_available(drv->rx_head, drv->rx_tail, drv->rx_buffer_size);

        if (available >= count)
        {
            // enough data after all, waiting not needed
            interrupt_enable(rx_interrupt);
            pthread_interrupt_disassociate(rx_interrupt, &rx_handler, (void*) drv);
        }
        else
        {
            // tell interrupthandler how much we want and wait for its notification
            drv->rx_notify_count = count;
            interrupt_enable(rx_interrupt);
            err = pthread_interrupt_timedwait(NULL);
            pthread_interrupt_disassociate(rx_interrupt, &rx_handler, (void*) drv);
        }
    }

    return err;
}
#endif // DRV_UART8_RX_BLOCKING_MODE_NOTIFY_USED

// called from drv_uart.c
void uart8_connect_interrupts( uart8_t * restrict drv )
{
    // TX interrupt
    if (drv->tx_buffer_size != 0)
    {
#if TX_INTERRUPT_POSIX
        if (drv->tx_blocking_mode == DRV_UART8_TX_BLOCKING_MODE_NOTIFY)
        {
            // driver can use interrupt notification to a thread, use posix interrupt
            drv->tx_notify_count = 0;
            interrupt_set_posix(drv->tx_interrupt, true);
            interrupt_register(drv->tx_interrupt, (void*) drv, tx_handler);
        }
#endif
#if TX_INTERRUPT_NATIVE
        if (drv->tx_blocking_mode != DRV_UART8_TX_BLOCKING_MODE_NOTIFY)
        {
            // driver has a software buffer, use native interrupt
            interrupt_register_native(drv->tx_interrupt, (void*) drv, uart8_tx_handler_native);
        }
#endif
        interrupt_configure(drv->tx_interrupt, LEVEL_HIGH);
        interrupt_acknowledge(drv->tx_interrupt);
        interrupt_enable(drv->tx_interrupt);
    }

    // RX interrupt
    if (drv->rx_buffer_size != 0)
    {
#if RX_INTERRUPT_POSIX
        if (drv->rx_blocking_mode == DRV_UART8_RX_BLOCKING_MODE_NOTIFY)
        {
            // driver can use interrupt notification to a thread, use posix interrupt
            drv->rx_notify_count = 0;
            interrupt_set_posix(drv->rx_interrupt, true);
            interrupt_register(drv->rx_interrupt, (void*) drv, rx_handler);
        }
#endif
#if RX_INTERRUPT_NATIVE
        if (drv->rx_blocking_mode != DRV_UART8_RX_BLOCKING_MODE_NOTIFY)
        {
            // driver has a software buffer, use native interrupt
            interrupt_register_native(drv->rx_interrupt, (void*) drv, uart8_rx_handler_native);
        }
#endif
        interrupt_configure(drv->rx_interrupt, LEVEL_HIGH);
        interrupt_acknowledge(drv->rx_interrupt);
        interrupt_enable(drv->rx_interrupt);

        UART8_INTMASK_SET(drv->baseaddress) = RX_INT;
    }
}
