/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    UART8 serial communications driver.
|*                  Internal code, no mutexes.
|*
\*****************************************************************************/

#include <interrupts.h>
#include <timing.h>

#include <per_uart8.h>
#include <drv_uart8.h>

#include "drv_uart8_internal.h"

// used by serial adaptor
void* uart8_get_tx_mutex( uart8_t * restrict drv )
{
#if MUTEXES
    return &drv->tx_mutex;
#else
    return NULL;
#endif
}

// used by serial adaptor
void* uart8_get_rx_mutex( uart8_t * restrict drv )
{
#if MUTEXES
    return &drv->rx_mutex;
#else
    return NULL;
#endif
}

// internal for uart_putbreak()
int uart8_putbreak_internal(uart8_t * restrict drv, uint8_t duration)
{
    int result = 0;

    if (drv->tx_buffer_size == 0)
    {
        // using only core buffer
        if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL)
        {
            // core tx buffer full
            result = -1;
        }
        else
        {
            UART8_BRKLEN(drv->baseaddress) = duration;
        }
    }
    else
    {
        // using driver buffer and interrupthandler
        int next = uart8_buffer_get_next(drv->tx_head, drv->tx_buffer_size);

        interrupt_disable(drv->tx_interrupt);
        if (next == drv->tx_tail)
        {
            // driver buffer full
            drv->status |= DRV_UART8_TXSTALLED;
            result = -1;
        }
        else
        {
            if (drv->tx_busy)
            {
                // put break in driver buffer
                drv->tx_buffer[drv->tx_head] = UART8_BREAK | duration;
                drv->tx_head = next;
                if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXLOW)
                {
                    UART8_INTMASK_SET(drv->baseaddress) = UART8_STATUS_TXEMPTY;
                    UART8_INTMASK_RST(drv->baseaddress) = UART8_STATUS_TXLOW;
                }
                else
                {
                    UART8_INTMASK_SET(drv->baseaddress) = TX_INT;
                }
            }
            else
            {
                // put break in the core
                drv->tx_busy = true;
                UART8_BRKLEN(drv->baseaddress) = duration;
                UART8_INTMASK_SET(drv->baseaddress) = UART8_STATUS_TXEMPTY;
            }

            // (re-)enable interrupts
            interrupt_enable(drv->tx_interrupt);
        }
    }

    return result;
}


// internal for uart_putchar()
int uart8_putchar_internal(uart8_t * restrict drv, int val)
{
    int result = 0;

    if (drv->tx_buffer_size == 0)
    {
        // using only core buffer
        if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL)
        {
            return -1; // core tx buffer full
        }
        UART8_SBUF(drv->baseaddress) = val & 0xFF;
    }
    else
    {
        // using driver buffer and interrupthandler
        int next = uart8_buffer_get_next(drv->tx_head, drv->tx_buffer_size);

        interrupt_disable(drv->tx_interrupt);
        if (next == drv->tx_tail)
        {
            // driver buffer full
            drv->status |= DRV_UART8_TXSTALLED;
            result = -1;
        }
        else
        {
            if (drv->tx_busy)
            {
                // put data in driver buffer
                drv->tx_buffer[drv->tx_head] = (val & 0xFF) | (drv->tx_parityval ? UART8_PARERR : 0);
                drv->tx_head = next;
                if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXLOW)
                {
                    UART8_INTMASK_SET(drv->baseaddress) = UART8_STATUS_TXEMPTY;
                    UART8_INTMASK_RST(drv->baseaddress) = UART8_STATUS_TXLOW;
                }
                else
                {
                    UART8_INTMASK_SET(drv->baseaddress) = TX_INT;
                }
            }
            else
            {
                // put data in core buffer
                drv->tx_busy = true;

                if ( drv->tx_parityval )
                {
                    UART8_PARM( drv->baseaddress ) |= UART8_PARM_PARITYVAL;
                }
                else
                {
                    UART8_PARM( drv->baseaddress ) &= ~UART8_PARM_PARITYVAL;
                }

                UART8_SBUF(drv->baseaddress) = val & 0xFF;
                UART8_INTMASK_SET(drv->baseaddress) = UART8_STATUS_TXEMPTY;
            }
        }
        interrupt_enable(drv->tx_interrupt);
    }

    return result;
}

// internal for uart8_getchar()
int uart8_getchar_internal(uart8_t * restrict drv)
{
    int result = -1;
    uint8_t lcr = 0;

    if (drv->rx_buffer_size == 0)
    {
        while ( UART8_STATUS(drv->baseaddress) & UART8_STATUS_RXNEMPTY )
        {
            lcr = UART8_LCR(drv->baseaddress);
            if ( lcr & drv->rx_mask )
            {
                // Ignore errors that fall in ignore mask
                UART8_SBUF(drv->baseaddress);
                continue;
            }
            result = UART8_SBUF(drv->baseaddress);
            break;
        }
    }
    else
    {
        // Read from interrupt buffer
        int next = uart8_buffer_get_next(drv->rx_tail, drv->rx_buffer_size );

        interrupt_disable(drv->rx_interrupt);
        // using driver buffer and interrupthandler
        if (drv->rx_head != drv->rx_tail)
        {
            // read data from tail of ringbuffer
            result = drv->rx_buffer[drv->rx_tail];
            lcr = (result >> 8) & 0xFF;
            result &= 0xFF;
            drv->rx_tail = next;
        }

#if RTSSOFT
        if (drv->handshake == DRV_UART8_HANDSHAKE_RTSSOFT)
        {
            if (UART8_LCR(drv->baseaddress) & UART8_LCR_RTSVAL)
            {
                // test free space in buffer
                int rx_free = uart8_buffer_get_free(drv->rx_head, drv->rx_tail, drv->rx_buffer_size);

                if (rx_free >= drv->rx_margin)
                {
                    // lower RTS
                    UART8_LCR(drv->baseaddress) &= ~UART8_LCR_RTSVAL;
                }
            }
        }
#endif

        if ( drv->status & DRV_UART8_RXSTALLED )
        {
            // test free space in rx buffer
            int rx_free = uart8_buffer_get_free(drv->rx_head, drv->rx_tail, drv->rx_buffer_size);

            if ((rx_free >= RX_STALLED_RESTART) || (rx_free >= (drv->rx_buffer_size - 1)))
            {
                // we can use more data in the rx buffer, enable interrupt again
                drv->status &= ~DRV_UART8_RXSTALLED;
                UART8_INTMASK_SET(drv->baseaddress) = RX_INT;
            }
        }
        interrupt_enable(drv->rx_interrupt);
    }

    if (lcr & UART8_LCR_BREAK) result |= UART8_BREAK;
    if ( lcr & UART8_LCR_FRAMERR ) result |= UART8_FRAMERR;
    if ( lcr & UART8_LCR_PARERR ) result |= UART8_PARERR;

    return result;
}

// internal for set_baudrate()
void uart8_set_baudrate_internal(uart8_t * restrict drv, uint32_t baudrate)
{

    uint32_t clk = freq_hz();
    uint32_t brg = (uint32_t)((baudrate * 0x8000000ULL) / clk);

    UART8_BRGLOW(drv->baseaddress)  = brg & 0xFF;
    brg >>= 8;
    UART8_BRGMID(drv->baseaddress)  = brg & 0xFF;
    brg >>= 8;
    UART8_BRGHIGH(drv->baseaddress) = brg & 0xFF;
    drv->baudrate = baudrate;
}

// internal for get_baudrate()
uint32_t uart8_get_baudrate_internal(uart8_t * restrict drv)
{
    return drv->baudrate;
}

