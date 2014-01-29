/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    UART8 serial communications drv.
|*
\*****************************************************************************/

#include <assert.h>
#include <timing.h>
#include <interrupts.h>

#if __POSIX_KERNEL__
# include <pthread.h>
#endif

#include <sysutils.h>

#include <per_uart8.h>
#include <drv_uart8.h>
#include "drv_uart8_cfg_instance.h"
#include "drv_uart8_internal.h"


// runtime driver table
static uart8_t uart8_driver_table[DRV_UART8_INSTANCE_COUNT];

#define TX_INT   (UART8_STATUS_TXEMPTY | UART8_STATUS_TXLOW)
#define RX_INT   (UART8_STATUS_RXTIMEOUT | UART8_STATUS_RXHIGH)


/*****************************************************************************
|*
|*  Function:           tx_handler_common
|*
|*  Parameters:         num : interrupt number
|*                      drv : pointer to driver
|*
|*  Description:        Handle transmit interrupts.
 */
inline void tx_handler_common(uint32_t num, uart8_t * restrict drv)
{
    while (!((UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL)) &&
           ((drv->tx_tail != drv->tx_head) || (drv->tx_tail == drv->tx_break)))
    {
        if (drv->tx_tail == drv->tx_break)
        {
            UART8_BRKLEN(drv->baseaddress) = drv->tx_break_duration;
            drv->tx_break = -1;
        }
        else
        {
            UART8_SBUF(drv->baseaddress) = drv->tx_buffer[drv->tx_tail];
            if (drv->tx_tail + 1 == drv->tx_buffer_size)
            {
                drv->tx_tail = 0; // wrap
            }
            else
            {
                drv->tx_tail = drv->tx_tail + 1;
            }
        }
    }

    if (drv->tx_tail == drv->tx_head)
    {
        /* no need to check for status low when there is no more to transmit    */
        UART8_INTMASK_RST(drv->baseaddress) = UART8_STATUS_TXLOW;
    }
    else if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL)
    {
    }

    if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXEMPTY)
    {
        // buffer empty, disable transmit interrupts
        drv->tx_busy = false;
        UART8_INTMASK_RST(drv->baseaddress) = TX_INT;
    }
    interrupt_acknowledge(num);
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
        if (drv->tx_notify_count == -1)
        {
            // test if room to store break
            if (drv->tx_break == -1)
            {
                retvalue |= INTERRUPT_NOTIFY;
                drv->tx_notify_count = 0;
            }
        }
        else
        {
            // test free space in buffer
            tx_free = drv->tx_head - drv->tx_tail - 1;
            if (tx_free < 0) tx_free += drv->tx_buffer_size;

            if (tx_free >= drv->tx_notify_count)
            {
                retvalue |= INTERRUPT_NOTIFY;
                drv->tx_notify_count = 0;
            }
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


/*****************************************************************************
|*
|*  Function:           rx_handler_common
|*
|*  Parameters:         num : interrupt number
|*                      drv : pointer to driver
|*
|*  Description:        Handle interrupts from receiver.
 */
inline void rx_handler_common(uint32_t num, uart8_t * restrict drv)
{
    while (UART8_STATUS(drv->baseaddress) & UART8_STATUS_RXNEMPTY)
    {
        int next = drv->rx_head + 1;
        if (next == drv->rx_buffer_size) next = 0; // wrap

        if (next == drv->rx_tail)
        {
            // buffer full, disable receive interrupts
            UART8_INTMASK_RST(drv->baseaddress) = RX_INT;
            drv->rx_stalled = true;
            break;
        }

        if ((UART8_LCR(drv->baseaddress) & UART8_LCR_BREAK))
        {
            if (drv->rx_break != -1)
            {
                // cannot buffer two pending breaks, disable receive interrupts
                UART8_INTMASK_RST(drv->baseaddress) = RX_INT;
                drv->rx_stalled = true;
                break;
            }

            drv->rx_break = drv->rx_head;
            UART8_SBUF(drv->baseaddress); // discard data
        }
        else
        {
            drv->rx_buffer[drv->rx_head] = UART8_SBUF(drv->baseaddress);
            drv->rx_head = next;
        }
    }

#if RTSSOFT
    if (drv->handshake == DRV_UART8_HANDSHAKE_RTSSOFT)
    {
        // test free space in buffer
        int rx_free = drv->rx_tail - drv->rx_head - 1;
        if (rx_free < 0) rx_free += drv->rx_buffer_size;

        if (rx_free < drv->rx_margin)
        {
            // raise RTS
            UART8_LCR(drv->baseaddress) |= UART8_LCR_RTSVAL;
        }
    }
#endif

    interrupt_acknowledge(num);
}


#if RX_INTERRUPT_POSIX

// threaded interrupt wrapper
static uint32_t rx_handler(uint32_t num, void *arg)
{
    uart8_t * restrict drv = (uart8_t*) arg;
    int retvalue = INTERRUPT_HANDLED;

    rx_handler_common(num, drv);

    if (drv->rx_notify_count)
    {
        // used space in buffer
        int rx_used = drv->rx_head - drv->rx_tail;
        if (rx_used < 0) rx_used += drv->rx_buffer_size;

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



// internal for uart_putchar()
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
        if (drv->tx_break != -1)
        {
            // already a pending break
            result = -1;
        }
        else
        {
            // in case txbusy: temporarily disable interrupts
            interrupt_disable(drv->tx_interrupt);

            if (drv->tx_busy)
            {
                // put break in driver buffer
                drv->tx_break = drv->tx_head;
                drv->tx_break_duration = duration;
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
        int next = drv->tx_head + 1;
        if (next == drv->tx_buffer_size)
        {
            next = 0; // wrap
        }

        interrupt_disable(drv->tx_interrupt);
        if (next == drv->tx_tail)
        {
            // driver buffer full
            result = -1;
        }
        else
        {
            if (drv->tx_busy)
            {
                // put data in driver buffer
                drv->tx_buffer[drv->tx_head] = val & 0xFF;
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

    if (drv->rx_buffer_size == 0)
    {
        // using only core buffer
        if ((UART8_LCR(drv->baseaddress) & UART8_LCR_BREAK))
        {
            // received a break
            UART8_SBUF(drv->baseaddress); // discard
            result = UART8_BREAK;
        }

        else if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_RXNEMPTY)
        {
            // received normal data
            result = UART8_SBUF(drv->baseaddress);
        }
    }
    else
    {
        interrupt_disable(drv->rx_interrupt);
        // using driver buffer and interrupthandler
        if (drv->rx_break == drv->rx_tail)
        {
            // break at read position of ringbuffer
            result = UART8_BREAK;
            drv->rx_break = -1;
        }
        else if (drv->rx_head != drv->rx_tail)
        {
            // read data from head of ringbuffer
            result = drv->rx_buffer[drv->rx_tail];
            if (drv->rx_tail + 1 == drv->rx_buffer_size)
            {
                drv->rx_tail = 0;
            }
            else
            {
                drv->rx_tail = drv->rx_tail + 1;
            }
        }

#if RTSSOFT
        if (drv->handshake == DRV_UART8_HANDSHAKE_RTSSOFT)
        {
            if (UART8_LCR(drv->baseaddress) & UART8_LCR_RTSVAL)
            {
                // test free space in buffer
                int rx_free = drv->rx_tail - drv->rx_head - 1;
                if (rx_free < 0) rx_free += drv->rx_buffer_size;

                if (rx_free >= drv->rx_margin)
                {
                    // lower RTS
                    UART8_LCR(drv->baseaddress) &= ~UART8_LCR_RTSVAL;
                }
            }
        }
#endif

        if (drv->rx_stalled && (drv->rx_break == -1))
        {
            // test free space in rx buffer
            int rx_free = drv->rx_tail - drv->rx_head - 1;
            if (rx_free < 0) rx_free += drv->rx_buffer_size;

            if ((rx_free >= RX_STALLED_RESTART) || (rx_free >= (drv->rx_buffer_size - 1)))
            {
                // we can use more data in the rx buffer, enable interrupt again
                drv->rx_stalled = false;
                UART8_INTMASK_SET(drv->baseaddress) = RX_INT;
            }
        }
        interrupt_enable(drv->rx_interrupt);
    }

    return result;
}


#if TX_INTERRUPT_POSIX

/****
 * Wait for interrupt notification of space in transmit buffer
 *
 * Wait for count bytes free space to become available in the transmit buffer
 * (by using interrupt waiting), or for the optional timeout to pass.
 * This function requires a non-zero sized transmit buffer.
 *
 * param       drv       uart8 driver pointer
 * param       count     number of bytes free space to wait for (-1 means wait for break to be transmitted)
 *
 * return Errorcode from posix_interrupt_timedwait() if failed or interrupted, 0 otherwise.
 */
static int uart8_transmit_buf_free_timedwait(uart8_t * restrict drv, int count)
{
    int tx_free;
    int err = 0;
    int tx_interrupt = drv->tx_interrupt;

    if (count > (drv->tx_buffer_size - 1))
    {
        // limit count to buffersize
        count = drv->tx_buffer_size - 1;
    }


    // using driver buffer and interrupthandler
    interrupt_disable(tx_interrupt);
    if (drv->tx_head == drv->tx_tail)
    {
        tx_free = drv->tx_buffer_size - 1;
    }
    else if (drv->tx_head > drv->tx_tail)
    {
        tx_free = drv->tx_buffer_size - (drv->tx_head - drv->tx_tail + 1);
    }
    else
    {
        tx_free = drv->tx_tail - drv->tx_head - 1;
    }
    interrupt_enable(tx_interrupt);

    if (tx_free < count)
    {
        // not enough free space, we need to wait

        // associate, but thread can be interrupted before the association completes
        pthread_interrupt_associate(tx_interrupt, &tx_handler, (void*) drv);

        // test free space again, but this time with the interrupt disabled
        interrupt_disable(tx_interrupt);
        if (drv->tx_head == drv->tx_tail)
        {
            tx_free = drv->tx_buffer_size - 1;
        }
        else if (drv->tx_head > drv->tx_tail)
        {
            tx_free = drv->tx_buffer_size - (drv->tx_head - drv->tx_tail + 1);
        }
        else
        {
            tx_free = drv->tx_tail - drv->tx_head - 1;
        }

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

#endif


/*****
 * Wait (or not) for space in transmit buffer data according to plugin blocking mdoe
 *
 * param       drv       uart8 driver pointer
 * param       count     number of bytes to wait for
 *
 * return true if continuing, false if aborting
 */

static bool uart8_transmit_block(uart8_t * restrict drv, int size)
{
#if TX_NOKERNEL_BLOCK_NONE
    if (!drv->tx_blocking)
    {
        return false;
    }
    else
#endif
#if TX_KERNEL_BLOCK_NONE
    if (drv->tx_blocking_mode == DRV_UART8_TX_BLOCKING_MODE_NONE)
    {
        return false;
    }
    else
#endif
#if TX_KERNEL_BLOCK_NOTIFY
    if (drv->tx_blocking_mode == DRV_UART8_TX_BLOCKING_MODE_NOTIFY)
    {
        if (uart8_transmit_buf_free_timedwait(drv, size) != 0)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if TX_KERNEL_BLOCK_POLL
    if (drv->tx_blocking_mode == DRV_UART8_TX_BLOCKING_MODE_POLL)
    {
        struct timespec ts = { 0, drv->tx_pollmscs * 1000 * 1000 };

        if (nanosleep (&ts, NULL) == -1)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if TX_KERNEL_BLOCK_YIELD
    if (drv->tx_blocking_mode == DRV_UART8_TX_BLOCKING_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
    {
        /* default mode: just loop */
    }

    return true;
}



#if RX_INTERRUPT_POSIX

/*****
 * Wait for interrupt notification of received data
 *
 * Wait for count bytes to become available in the receiver buffer
 * (by using interrupt waiting), or for the optional timeout to pass.
 * This function requires a non-zero sized receive buffer.
 *
 * @param       drv       uart8 driver pointer
 * @param       count     number of bytes to wait for
 *
 * @return Errorcode from posix_interrupt_timedwait() if failed or interrupted, 0 otherwise.
 */
static int uart8_receive_buf_available_timedwait(uart8_t * restrict drv, int count)
{
    int available;
    int err = 0;
    int rx_interrupt = drv->rx_interrupt;

    if (count > (drv->rx_buffer_size - 1))
    {
        // limit count to buffersize
        count = drv->rx_buffer_size - 1;
    }

    // see how much data
    interrupt_disable(drv->rx_interrupt);
    available = drv->rx_head - drv->rx_tail;
    if (available < 0) available += drv->rx_buffer_size;
    interrupt_enable(drv->rx_interrupt);

    if (available < count)
    {
        // not enough data, we need to wait

        // associate, but thread can be interrupted before the association completes
        pthread_interrupt_associate(rx_interrupt, &rx_handler, (void*) drv);

        // see again how much data, but this time with the interrupt disabled
        interrupt_disable(rx_interrupt);
        available = drv->rx_head - drv->rx_tail;
        if (available < 0) available += drv->rx_buffer_size;

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

#endif


/*****
 * Wait (or not) for received data according to plugin blocking mdoe
 *
 * param       drv       uart8 driver pointer
 * param       count     number of bytes to wait for
 *
 * return true if continuing, false if aborting
 */

static bool uart8_receive_block(uart8_t * restrict drv, int size)
{
#if RX_NOKERNEL_BLOCK_NONE
    if (!drv->rx_blocking)
    {
        return false;
    }
    else
#endif
#if RX_KERNEL_BLOCK_NONE
    if (drv->rx_blocking_mode == DRV_UART8_RX_BLOCKING_MODE_NONE)
    {
        return false;
    }
    else
#endif
#if RX_KERNEL_BLOCK_NOTIFY
    if (drv->rx_blocking_mode == DRV_UART8_RX_BLOCKING_MODE_NOTIFY)
    {
        if (uart8_receive_buf_available_timedwait(drv, size) != 0)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if RX_KERNEL_BLOCK_POLL
    if (drv->rx_blocking_mode == DRV_UART8_RX_BLOCKING_MODE_POLL)
    {
        struct timespec ts = { 0, drv->rx_pollmscs * 1000 * 1000 };

        if (nanosleep (&ts, NULL) == -1)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if RX_KERNEL_BLOCK_YIELD
    if (drv->rx_blocking_mode == DRV_UART8_RX_BLOCKING_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
    {
        /* default mode: just loop */
    }

    return true;
}


/**
 * @brief Write a break to the UART8
 *
 * Have the UART8 generate a breakcondition of @em length bits long.
 * The break-instruction is added to the transmit buffer, but there can only be one
 * pending break-instruction at a time.
 * This function can be blocking or non-blocking depending on the plugin settings.
 *
 * @param      drv       uart8 driver pointer
 * @param      duration  length of break in bits
 *
 * @return 0 if succes, -1 if there is no space or already a pending break
 */
extern int uart8_putbreak(uart8_t * restrict drv, uint8_t duration)
{
    assert(drv != NULL);

    int result = 0;

    UART8_MUTEXTX_PREPARE()

    if (duration < 10) duration = 10;
    --duration;

    UART8_MUTEXTX_LOCK(drv);

    do
    {
        result = uart8_putbreak_internal(drv, duration);

        if (result != -1)
        {
            break;
        }
    } while (uart8_transmit_block(drv, -1))

    UART8_MUTEXTX_UNLOCK(drv);

    return result;
}


/**
 * @brief Write a single byte to the UART8
 *
 * Put a single byte @em val in the transmit buffer
 * (or in the core if the buffer size is zero).
 * This function can be blocking or non-blocking depending on the plugin settings.
 *
 * @see uart8_getchar
 *
 * @param      drv     uart8 driver pointer
 * @param      val     byte to transmit.
 *
 * @return 0 if succes, -1 if no space.
 */
extern int uart8_putchar(uart8_t * restrict drv, int val)
{
    assert(drv != NULL);
    assert((val >= 0) && (val <= 0xFF));

    int result = 0;
    UART8_MUTEXTX_PREPARE()
    UART8_MUTEXTX_LOCK(drv);

    do
    {
        result = uart8_putchar_internal(drv, val);

        if (result != -1)
        {
            break;
        }
    } while (uart8_transmit_block(drv, 1))

    UART8_MUTEXTX_UNLOCK(drv);

    return result;
}


/**
 * @brief Read a single byte or break from the UART8
 *
 * Return a single byte or break from the receive buffer
 * (or from the core if the buffer size is zero).
 * This function can be blocking or non-blocking depending on the plugin settings.
 *
 * @see uart8_putchar
 *
 * @param       drv     uart8 driver pointer
 *
 * @return The byte read, UART8_BREAK (0x100) if a breakcondition occurred, -1 if none available.
 */
extern int uart8_getchar(uart8_t * restrict drv)
{
    assert(drv != NULL);

    int result;
    UART8_MUTEXRX_PREPARE()
    UART8_MUTEXRX_LOCK(drv);

    do
    {
        result = uart8_getchar_internal(drv);

        if (result != -1)
        {
            break;
        }
    } while (uart8_receive_block(drv, 1))


    UART8_MUTEXRX_UNLOCK(drv);

    return result;
}


/**
 * @brief Write multiple characters to the UART8
 *
 * Write @em size characters from buffer @em data to the UART8.
 * This function can be blocking or non-blocking depending on the plugin settings.
 *
 * @see uart8_read
 *
 * @param       drv    uart8 driver pointer
 * @param       buf    start address of data to write
 * @param       size   number of characters to write
 *
 * @return The number of bytes written.
 * This can be below @em size if interrupted by a POSIX signal or if
 * using blocking mode NONE and no more data can be written.
 */
extern size_t uart8_write(uart8_t * restrict drv, const char *buf, size_t size)
{
    assert(drv != NULL);
    assert(buf != NULL);

    int result;
    int count = 0;

    UART8_MUTEXTX_PREPARE()
    UART8_MUTEXTX_LOCK(drv);

    while (count != size)
    {
        result = uart8_putchar_internal(drv, buf[count]);

        if (result >= 0)
        {
            ++count;
        }
        else
        {
            if (!uart8_transmit_block(drv, size - count))
            {
                break;
            }
        }
    }

    UART8_MUTEXTX_UNLOCK(drv);

    return count;
}


/**
 * @brief Read multiple characters from the UART8
 *
 * Read @em size characters from the UART8 and place them into @em buf.
 * This function can be blocking or non-blocking depending on the plugin settings.
 *
 * @see uart8_read
 *
 * @param        drv    uart8 driver pointer
 * @param        buf    destination buffer
 * @param        size   maximum number of bytes to read
 *
 * @return The number of bytes read.
 * This can be below @em size if interrupted by a POSIX signal or
 * if using blocking mode NONE and no more data is available.
 */
extern size_t uart8_read(uart8_t * restrict drv, char *buf, size_t size)
{
    assert(drv != NULL);
    assert(buf != NULL);

    int result;
    int count = 0;

    UART8_MUTEXRX_PREPARE()
    UART8_MUTEXRX_LOCK(drv);

    while (count != size)
    {
        result = uart8_getchar_internal(drv);

        if (result >= 0)
        {
            buf[count++] = result & 0xFF;
        }
        else
        {
            if (!uart8_receive_block(drv, size - count))
            {
                break;
            }
        }
    }

    UART8_MUTEXRX_UNLOCK(drv);

    return count;
}


/**
 * @brief Test if transmitter has output all data.
 *
 * Test if transmitter has output all data.
 *
 * @param       drv       uart8 driver pointer
 *
 * @return True if no more pending data to write, false otherwise.
 */
extern bool uart8_transmit_idle(uart8_t * restrict drv)
{
    assert(drv != NULL);

    bool result = true;

    UART8_MUTEXTX_PREPARE()
    UART8_MUTEXTX_LOCK(drv);

    if (drv->tx_buffer_size != 0)
    {
        // using driver buffer and interrupthandler
        if (drv->tx_head != drv->tx_tail)
        {
            result = false; // buffer has data
        }
    }

    if (result)
    {
        if (!(UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXSHEMPTY))
        {
            result = false; // core buffer has data
        }
    }

    UART8_MUTEXTX_UNLOCK(drv);

    return result;
}


/**
 * @brief Test if space left to write more data
 *
 * Test if transmitter has free space left to write more data.
 * If there is no transmit buffer configured, the maximum returned
 * value will be 1 if any data at all can be written to the core.
 *
 * @param       drv       uart8 driver pointer
 *
 * @return Amount of free data available in the transmit buffer.
 */
extern size_t uart8_transmit_buf_free(uart8_t * restrict drv)
{
    assert(drv != NULL);

    int available = 0;

    UART8_MUTEXTX_PREPARE()
    UART8_MUTEXTX_LOCK(drv);

    if (drv->tx_buffer_size == 0)
    {
        // using only core buffer
        if (!(UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL))
        {
            available = 1; // core buffer not full
        }
    }
    else
    {
        interrupt_disable(drv->tx_interrupt);
        // using driver buffer and interrupthandler
        if (drv->tx_head == drv->tx_tail)
        {
            available = drv->tx_buffer_size - 1;
        }
        else if (drv->tx_head > drv->tx_tail)
        {
            available = drv->tx_buffer_size - (drv->tx_head - drv->tx_tail + 1);
        }
        else
        {
            available = drv->tx_tail - drv->tx_head - 1;
        }
        interrupt_enable(drv->tx_interrupt);
    }

    UART8_MUTEXTX_UNLOCK(drv);

    return (size_t) available;
}


/**
 * @brief Test if any data available
 *
 * Test if receiver has any data available to read.
 * If there is no receive buffer configured, the maximum returned
 * value will be 1 if there is any data at all can be read from the core.
 *
 * @param       drv       uart8 driver pointer
 *
 * @return Amount of data available in the receiver buffer.
 */
extern size_t uart8_receive_buf_available(uart8_t * restrict drv)
{
    assert(drv != NULL);

    int available = 0;

    UART8_MUTEXRX_PREPARE()
    UART8_MUTEXRX_LOCK(drv);

    if (drv->rx_buffer_size == 0)
    {
        // using only core buffer
        if (UART8_STATUS(drv->baseaddress) & UART8_STATUS_RXNEMPTY) available = 1; // core buffer has data
    }
    else
    {
        // using driver buffer and interrupthandler
        interrupt_disable(drv->rx_interrupt);
        available = drv->rx_head - drv->rx_tail;
        if (available < 0)
        {
            available += drv->rx_buffer_size;
        }
        interrupt_enable(drv->rx_interrupt);
    }

    UART8_MUTEXRX_UNLOCK(drv);

    return (size_t) available;
}


/**
 * @brief Pause the remote transmitter by raising RTS
 *
 * Either pause the remote transmitter by forcing the RTS line active,
 * or release the RTS line again to the control of the core.
 *
 * @param       drv     uart8 driver pointer
 * @param       pause   true to stop remote transmitter,
 *                      false to enable remote transmitter
 *
 * @return Nothing.
 */
extern void uart8_rts(uart8_t * restrict drv, bool pause)
{
    assert(drv != NULL);

    UART8_MUTEXRX_PREPARE()
    UART8_MUTEXRX_LOCK(drv);

    if (pause)
    {
        UART8_LCR(drv->baseaddress) |= UART8_LCR_RTSVAL;
    }
    else
    {
        UART8_LCR(drv->baseaddress) &= UART8_LCR_RTSVAL;
    }

    UART8_MUTEXRX_UNLOCK(drv);
}

extern void uart8_set_baudrate_internal(uart8_t * restrict drv, uint32_t baudrate)
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


/**
 * @brief Set a new uart baudrate
 *
 * The baudrate changes instantly and will invalidate any character
 * that is currently being received or transmitted over the line.
 *
 * @param       drv       uart8 driver pointer
 * @param       baudrate  new baudrate
 *
 * @return Nothing.
 */
extern void uart8_set_baudrate(uart8_t * restrict drv, uint32_t baudrate)
{
    UART8_MUTEXTX_PREPARE()
    UART8_MUTEXRX_PREPARE()

    assert(drv != NULL);
    assert(baudrate != 0);

    UART8_MUTEXTX_LOCK(drv)
    UART8_MUTEXRX_LOCK(drv)
    uart8_set_baudrate_internal(drv,baudrate);
    UART8_MUTEXRX_UNLOCK(drv)
    UART8_MUTEXTX_UNLOCK(drv)

}

extern uint32_t uart8_get_baudrate_internal(uart8_t * restrict drv)
{
    return drv->baudrate;
}

/**
 * @brief Get the uart baudrate
 *
 * @param       drv       uart8 driver pointer
 *
 * @return baudrate.
 */
extern uint32_t uart8_get_baudrate(uart8_t * restrict drv)
{
    uint32_t baudrate;
    assert(drv != NULL);

    UART8_MUTEXTX_PREPARE()
    UART8_MUTEXRX_PREPARE()

    UART8_MUTEXTX_LOCK(drv)
    UART8_MUTEXRX_LOCK(drv)
    baudrate = uart8_get_baudrate_internal(drv);
    UART8_MUTEXRX_UNLOCK(drv)
    UART8_MUTEXTX_UNLOCK(drv)

    return baudrate;
}


/**
 * @brief Set transmitter low watermark
 *
 * With this function you can specify a lower threshold value for the core receive buffer.
 * If the number of bytes in the core receive buffer is less than the specified threshold
 * (@em lowmark), an interrupt will be generated.
 *
 * @see uart8_set_receive_watermark
 *
 * @param       drv       uart8 driver pointer
 * @param       lowmark   number of bytes in core receive buffer
 *                        below which an interrupt will be generated
 *
 * @return Nothing.
 */
extern void uart8_set_transmit_watermark(uart8_t * restrict drv, uint8_t lowmark)
{
    UART8_TXLOWMARK(drv->baseaddress) = lowmark;
}


/**
 * @brief Set transmitter low/high watermarks and timeout
 *
 * With this function you can specify upper and lower threshold values for the core receive buffer.
 * If the number of bytes in the core receive buffer is more than @em highmark, an interrupt will be generated
 * and (if running in automatic mode) the RTS line will be made active.
 * If the number of bytes in the core receive buffer is less than @em lowmark, the RTS line will be made inactive.
 * With @em timeout you specify a number of idle bit-times after which an interrupt will be generated.
 *
 * @see uart8_set_transmit_watermark
 *
 * @param       drv       uart8 driver pointer
 * @param       lowmark   number of bytes below which RTS is lowered
 * @param       highmark  number of bytes above which RTS is raised and an interrupt is generated
 * @param       timeout   number of idle bit-times after which an interrupt is generated
 *
 * @return Nothing.
 */
extern void uart8_set_receive_watermark(uart8_t * restrict drv, uint8_t lowmark, uint8_t highmark, uint8_t timeout)
{
    assert(drv != NULL);

    UART8_MUTEXRX_PREPARE()
    UART8_MUTEXRX_LOCK(drv);

    UART8_RXLOWMARK(drv->baseaddress)  = lowmark;
    UART8_RXHIGHMARK(drv->baseaddress) = highmark;
    UART8_RXDTO(drv->baseaddress)      = timeout;

    UART8_MUTEXRX_PREPARE()
    UART8_MUTEXRX_UNLOCK(drv);
}


/**
 * @brief Set idle time between characters
 *
 * Set the number of stopbits, thus creating inter-character delay.
 *
 * @param       drv       uart8 driver pointer
 * @param       delay     number of stopbits to add to each transmitted character
 *
 * @return Nothing.
 */
extern void uart8_set_transmit_chardelay(uart8_t * restrict drv, uint8_t delay)
{
    assert(drv != NULL);

    UART8_ICD(drv->baseaddress) = delay;
}





/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a UART8 core and its driver.
 * You should call it only once per id.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise.
 */
uart8_t *uart8_open(int id)
{
    assert((id >= 0) && (id < DRV_UART8_INSTANCE_COUNT));

    uart8_t * restrict drv = &uart8_driver_table[id];
    // get configuration of driver (created by plugin system)
    drv_uart8_cfg_instance_t * restrict drv_cfg = &drv_uart8_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    per_uart8_cfg_instance_t * restrict per_cfg = &per_uart8_instance_table[drv_cfg->per_uart8];

    // copy all configuration needed to driver
    drv->handshake        = drv_cfg->handshake;

    drv->tx_buffer        = drv_cfg->tx_buffer;
    drv->tx_buffer_size   = drv_cfg->tx_buffer_size;
#if __POSIX_KERNEL__
//    drv->tx_blocking_mode = drv_cfg->tx_blocking_mode;
#else
//    drv->tx_blocking      = drv_cfg->tx_blocking;
#endif
#if TX_KERNEL_BLOCK_POLL
    drv->tx_pollmscs      = drv_cfg->tx_pollmscs;
#endif

    drv->rx_buffer        = drv_cfg->rx_buffer;
    drv->rx_buffer_size   = drv_cfg->rx_buffer_size;
#if __POSIX_KERNEL__
//    drv->rx_blocking_mode = drv_cfg->rx_blocking_mode;
#else
//    drv->rx_blocking      = drv_cfg->rx_blocking;
#endif
#if RX_KERNEL_BLOCK_POLL
    drv->rx_pollmscs      = drv_cfg->rx_pollmscs;
#endif
    drv->rx_margin        = drv_cfg->rx_margin;

    assert(per_cfg->baseaddress != 0);
    drv->baseaddress      = per_cfg->baseaddress;
    drv->tx_interrupt     = per_cfg->tx_interrupt;
    drv->rx_interrupt     = per_cfg->rx_interrupt;

    // set up hardware based on configuration
    UART8_TXLOWMARK(drv->baseaddress)  = TXLOWMARK_DEFAULT;
    UART8_RXLOWMARK(drv->baseaddress)  = RXLOWMARK_DEFAULT;
    UART8_RXHIGHMARK(drv->baseaddress) = RXHIGHMARK_DEFAULT;
    UART8_RXDTO(drv->baseaddress)      = RXDTO_DEFAULT;
    uart8_set_baudrate(drv, drv_cfg->baudrate);

    switch (drv->handshake)
    {
    case DRV_UART8_HANDSHAKE_RTSHARD:
        UART8_LCR(drv->baseaddress) = UART8_LCR_CTSEN;
        break;

    case DRV_UART8_HANDSHAKE_RTSSOFT:
        UART8_LCR(drv->baseaddress) = UART8_LCR_FORCERTS;
        break;

    default:
        UART8_LCR(drv->baseaddress) = 0;
        break;

    }

    // ringbuffers
    drv->tx_head    = 0;
    drv->tx_tail    = 0;
    drv->tx_break   = -1;
    drv->tx_busy    = false;
    drv->rx_head    = 0;
    drv->rx_tail    = 0;
    drv->rx_break   = -1;
    drv->rx_stalled = false;

    // disable all interrupts
    UART8_INTMASK_RST(drv->baseaddress) = 0xFF;

#if TX_KERNEL_BLOCK_NOTIFY
    if (drv->tx_blocking_mode == DRV_UART8_TX_BLOCKING_MODE_NOTIFY)
    {
        // driver can use interrupt notification to a thread, use pal interrupt with posix support
        drv->tx_notify_count = 0;
        interrupt_set_posix(drv->tx_interrupt, true);
        interrupt_register(drv->tx_interrupt, (void*) drv, tx_handler);
        interrupt_configure(drv->tx_interrupt, LEVEL_HIGH);
        interrupt_acknowledge(drv->tx_interrupt);
        interrupt_enable(drv->tx_interrupt);
    }
    else
#endif
    if (drv->tx_buffer_size != 0)
    {
#if TX_INTERRUPT_NATIVE
        // driver has a software buffer, use native interrupt
        interrupt_register_native(drv->tx_interrupt, (void*) drv, uart8_tx_handler_native);
        interrupt_configure(drv->tx_interrupt, LEVEL_HIGH);
        interrupt_acknowledge(drv->tx_interrupt);
        interrupt_enable(drv->tx_interrupt);
#endif
    }

#if RX_KERNEL_BLOCK_NOTIFY
    if (drv->rx_blocking_mode == DRV_UART8_RX_BLOCKING_MODE_NOTIFY)
    {
        // driver can use interrupt notification to a thread, use pal interrupt with posix support
        drv->rx_notify_count = 0;
        interrupt_set_posix(drv->rx_interrupt, true);
        interrupt_register(drv->rx_interrupt, (void*) drv, rx_handler);
        interrupt_configure(drv->rx_interrupt, LEVEL_HIGH);
        interrupt_acknowledge(drv->rx_interrupt);
        interrupt_enable(drv->rx_interrupt);
        UART8_INTMASK_SET(drv->baseaddress) = RX_INT;
    }
    else
#endif
    if (drv->rx_buffer_size != 0)
    {
#if RX_INTERRUPT_NATIVE
        // driver has a software buffer, use native interrupt
        interrupt_register_native(drv->rx_interrupt, (void*) drv, uart8_rx_handler_native);
        interrupt_configure(drv->rx_interrupt, LEVEL_HIGH);
        interrupt_acknowledge(drv->rx_interrupt);
        interrupt_enable(drv->rx_interrupt);
        UART8_INTMASK_SET(drv->baseaddress) = RX_INT;
#endif
    }

    return drv;
}

extern void*    uart8_get_tx_mutex     ( uart8_t * restrict drv )
{
#if MUTEXES
    return &drv->tx_mutex;
#else
    return NULL;
#endif
}

extern void*    uart8_get_rx_mutex     ( uart8_t * restrict drv )
{
#if MUTEXES
    return &drv->rx_mutex;
#else
    return NULL;
#endif
}


