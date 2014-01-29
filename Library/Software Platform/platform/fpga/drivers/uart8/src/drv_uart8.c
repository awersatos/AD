/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    UART8 serial communications driver.
|*
\*****************************************************************************/

#include <assert.h>
#include <timing.h>
#include <interrupts.h>
#include <string.h>

#if __POSIX_KERNEL__
# include <pthread.h>
#endif

#include <sysutils.h>

#include <per_uart8.h>
#include <drv_uart8.h>

#include "per_uart8_cfg_instance.h"
#include "drv_uart8_cfg_instance.h"
#include "drv_uart8_internal.h"

// runtime driver table
static uart8_t uart8_driver_table[DRV_UART8_INSTANCE_COUNT];

/*
 * Blocking modes
 */

/*
 * Wait (or not) for space in transmit buffer data according to plugin blocking mdoe
 *
 * param       drv       uart8 driver pointer
 * param       count     number of bytes to wait for
 *
 * return true if continuing, false if aborting
 */

static inline bool uart8_transmit_block(uart8_t * restrict drv, int size)
{
    switch(drv->tx_blocking_mode)
    {
    case DRV_UART8_TX_BLOCKING_MODE_NONE:
        return false;
#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NOTIFY_USED
    case DRV_UART8_TX_BLOCKING_MODE_NOTIFY:
        return (uart8_transmit_buf_free_timedwait(drv, size) == 0);
#endif
#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_POLL_USED
    case DRV_UART8_TX_BLOCKING_MODE_POLL:
    {
        struct timespec ts = { 0, 0};
        ts.tv_nsec = drv->tx_pollmscs * NSEC_PER_MSEC;
        return (nanosleep (&ts, NULL) != -1);
    }
#endif
#if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_YIELD_USED
    case DRV_UART8_TX_BLOCKING_MODE_YIELD:
        sched_yield();
        return true;
#endif
    case DRV_UART8_TX_BLOCKING_MODE_LOOP:
        return true;
    default:
        return true; // never reached
    }
}

/*
 * Wait (or not) for space in transmit buffer data according to plugin blocking mdoe
 *
 * param       drv       uart8 driver pointer
 * param       count     number of bytes to wait for
 *
 * return true if continuing, false if aborting
 */
static inline bool uart8_receive_block(uart8_t * restrict drv, int size)
{
    switch(drv->rx_blocking_mode)
    {
    case DRV_UART8_RX_BLOCKING_MODE_NONE:
        return false;
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NOTIFY_USED
    case DRV_UART8_RX_BLOCKING_MODE_NOTIFY:
        return (uart8_receive_buf_available_timedwait(drv, size) == 0);
#endif
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_POLL_USED
    case DRV_UART8_RX_BLOCKING_MODE_POLL:
    {
        struct timespec ts = { 0, 0};
        ts.tv_nsec = drv->rx_pollmscs * NSEC_PER_MSEC;
        return (nanosleep (&ts, NULL) != -1);
    }
#endif
#if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_YIELD_USED
    case DRV_UART8_RX_BLOCKING_MODE_YIELD:
        sched_yield();
        return true;
#endif
    case DRV_UART8_RX_BLOCKING_MODE_LOOP:
        return true;
    default:
        return true;
    }
}

/* Public interface */

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
int uart8_putbreak(uart8_t * restrict drv, uint8_t duration)
{
    assert(drv != NULL);

    int result = 0;

    UART8_MUTEXTX_PREPARE();

    if (duration < 10)
        duration = 9;
    else
        --duration;

    UART8_MUTEXTX_LOCK(drv);

    do
    {
        result = uart8_putbreak_internal(drv, duration);

        if (result != -1)
        {
            break;
        }
    } while (uart8_transmit_block(drv, -1));

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
int uart8_putchar(uart8_t * restrict drv, int val)
{
    assert(drv != NULL);
    assert((val >= 0) && (val <= 0xFF));

    int result = 0;
    UART8_MUTEXTX_PREPARE();
    UART8_MUTEXTX_LOCK(drv);

    do
    {
        result = uart8_putchar_internal(drv, val);

        if (result != -1)
        {
            break;
        }
    } while (uart8_transmit_block(drv, 1));

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
 * @return The byte read, -1 if none available. Note: UART8_BREAK may be set to indicate a break, UART8_FRAMERR may be set to indicate a frame error has occured or UART8_PARERR may be set to indicate a parity error was received.
 */
int uart8_getchar(uart8_t * restrict drv)
{
    int result;

    assert(drv != NULL);

    UART8_MUTEXRX_PREPARE();
    UART8_MUTEXRX_LOCK(drv);

    do
    {
        result = uart8_getchar_internal(drv);

        if (result != -1)
        {
            break;
        }
    } while (uart8_receive_block(drv, 1));

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
size_t uart8_write(uart8_t * restrict drv, const char *buf, size_t size)
{
    int result;
    int count;

    assert(drv != NULL);
    assert(buf != NULL);

    UART8_MUTEXTX_PREPARE();
    UART8_MUTEXTX_LOCK(drv);

    count = 0;
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
size_t uart8_read(uart8_t * restrict drv, char *buf, size_t size)
{
    int result;
    int count;

    assert(drv != NULL);
    assert(buf != NULL);

    UART8_MUTEXRX_PREPARE();
    UART8_MUTEXRX_LOCK(drv);

    count = 0;
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
bool uart8_transmit_idle(uart8_t * restrict drv)
{
    bool result;

    assert(drv != NULL);

    UART8_MUTEXTX_PREPARE();
    UART8_MUTEXTX_LOCK(drv);

    // idle if no data in buffer (always true when buffer size is 0) AND hardware buffers empty
    result = (drv->tx_head == drv->tx_tail) &&
              ((UART8_STATUS(drv->baseaddress) & (UART8_STATUS_TXSHEMPTY | UART8_STATUS_TXEMPTY)) == (UART8_STATUS_TXSHEMPTY | UART8_STATUS_TXEMPTY));

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
size_t uart8_transmit_buf_free(uart8_t * restrict drv)
{
    int available;

    assert(drv != NULL);

    UART8_MUTEXTX_PREPARE();
    UART8_MUTEXTX_LOCK(drv);

    if (drv->tx_buffer_size == 0)
    {
        // using only core buffer
        available = (UART8_STATUS(drv->baseaddress) & UART8_STATUS_TXFULL) ? 0 : 1;
    }
    else
    {
        // Use variables from software buffer. Note: there is no need to disable interrupts since only 1 variable
        // can change, the others are guaranteed to remain constant this point!
        int tx_head = drv->tx_head;
        int tx_tail = drv->tx_tail;
        int tx_buffer_size = drv->tx_buffer_size;
        available = uart8_buffer_get_free(tx_head, tx_tail, tx_buffer_size);
    }

    UART8_MUTEXTX_UNLOCK(drv);

    return (size_t) available;
}

/**
 * @brief Test if any data available
 *
 * Test if receiver has any data available to read.
 * If there is no receive buffer configured, the maximum returned
 * value will be 1 if there is any data at all that can be read from the core.
 *
 * @param       drv       uart8 driver pointer
 *
 * @return Amount of data available in the receiver buffer.
 */
size_t uart8_receive_buf_available(uart8_t * restrict drv)
{
    int available;

    assert(drv != NULL);

    UART8_MUTEXRX_PREPARE();
    UART8_MUTEXRX_LOCK(drv);

    if (drv->rx_buffer_size == 0)
    {
        // using only core buffer
        available = (UART8_STATUS(drv->baseaddress) & UART8_STATUS_RXNEMPTY) ? 1 : 0; // core buffer has data
    }
    else
    {
        // Use variables from software buffer. Note: there is no need to disable interrupts since only 1 variable
        // can change, the others are guaranteed to remain constant this point!
        int rx_head = drv->rx_head;
        int rx_tail = drv->rx_tail;
        int rx_buffer_size = drv->rx_buffer_size;
        available = uart8_buffer_get_available( rx_head, rx_tail, rx_buffer_size );
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
void uart8_rts(uart8_t * restrict drv, bool pause)
{
    assert(drv != NULL);

    UART8_MUTEXRX_PREPARE();
    UART8_MUTEXRX_LOCK(drv);

    if (pause)
    {
        UART8_LCR(drv->baseaddress) |= UART8_LCR_RTSVAL;
    }
    else
    {
        UART8_LCR(drv->baseaddress) &= ~UART8_LCR_RTSVAL;
    }

    UART8_MUTEXRX_UNLOCK(drv);
}

/**
 * @brief Set a new uart baudrate
 *
 * The baudrate changes instantly and will invalidate any character
 * that is currently being received or transmitted over the line.
 *
 *
 * @param       drv       uart8 driver pointer
 * @param       baudrate  new baudrate
 *
 * @return Nothing.
 */
void uart8_set_baudrate(uart8_t * restrict drv, uint32_t baudrate)
{
    assert(drv != NULL);
    assert(baudrate != 0);

    UART8_MUTEXTX_PREPARE();
    UART8_MUTEXRX_PREPARE();

    UART8_MUTEXTX_LOCK(drv);
    UART8_MUTEXRX_LOCK(drv);

    uart8_set_baudrate_internal(drv,baudrate);

    UART8_MUTEXRX_UNLOCK(drv);
    UART8_MUTEXTX_UNLOCK(drv);

}

/**
 * @brief Get the uart baudrate
 *
 * @param       drv       uart8 driver pointer
 *
 * @return baudrate.
 */
uint32_t uart8_get_baudrate(uart8_t * restrict drv)
{
    assert(drv != NULL);

    return drv->baudrate;
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
void uart8_set_transmit_watermark(uart8_t * restrict drv, uint8_t lowmark)
{
    UART8_TXLOWMARK(drv->baseaddress) = lowmark;
}


/**
 * @brief Set receiver low/high watermarks and timeout
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
void uart8_set_receive_watermark(uart8_t * restrict drv, uint8_t lowmark, uint8_t highmark, uint8_t timeout)
{
    assert(drv != NULL);

    UART8_MUTEXRX_PREPARE();
    UART8_MUTEXRX_LOCK(drv);

    UART8_RXLOWMARK(drv->baseaddress)  = lowmark;
    UART8_RXHIGHMARK(drv->baseaddress) = highmark;
    UART8_RXDTO(drv->baseaddress)      = timeout;

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
void uart8_set_transmit_chardelay(uart8_t * restrict drv, uint8_t delay)
{
    assert(drv != NULL);

    UART8_ICD(drv->baseaddress) = delay;
}

/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a UART8 core and its driver.
 *
 * @param      id    valid driver id
 *
 * @return NULL if invalid id is passed, pointer to initialized driver otherwise
 */
uart8_t *uart8_open( unsigned int id )
{
    uart8_t * drv = &uart8_driver_table[id];

    if ( id >= DRV_UART8_INSTANCE_COUNT ) return NULL;

    if (drv->baseaddress == 0)
    {
        uart8_reset(drv);
    }
    return drv;
}

/**
 * @brief Initialize the UART core
 *
 * This function resets and initializes a UART8 core and its driver to initial state
 *
 * @param   drv Driver pointer
 *
 * @return Nothing
 */
void uart8_reset(uart8_t * drv)
{
    unsigned int id;
    const drv_uart8_cfg_instance_t * restrict drv_cfg;
    const per_uart8_cfg_instance_t * restrict per_cfg;

    assert(drv != NULL);

    /*
     * Set configuration
     */

    id      = drv - &uart8_driver_table[0];
    drv_cfg = &drv_uart8_instance_table[id];
    per_cfg = &per_uart8_instance_table[drv_cfg->per_uart8];

    memset( drv, 0, sizeof( uart8_t ));

    assert(per_cfg->baseaddress);
    drv->baseaddress      = per_cfg->baseaddress;

    // disable interrupts
    UART8_INTMASK_RST(drv->baseaddress) = 0xFF;

    drv->tx_interrupt     = per_cfg->tx_interrupt;
    drv->rx_interrupt     = per_cfg->rx_interrupt;
    drv->handshake        = drv_cfg->handshake;

    drv->tx_buffer        = drv_cfg->tx_buffer;
    drv->tx_buffer_size   = drv_cfg->tx_buffer_size;

    drv->rx_buffer        = drv_cfg->rx_buffer;
    drv->rx_buffer_size   = drv_cfg->rx_buffer_size;
#if RTSSOFT
    drv->rx_margin        = drv_cfg->rx_margin;
#endif

#if __POSIX_KERNEL__
# if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_POLL_USED
    drv->tx_pollmscs      = drv_cfg->tx_pollmscs;
# endif
# if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_POLL_USED
    drv->rx_pollmscs      = drv_cfg->rx_pollmscs;
# endif
    drv->tx_blocking_mode = drv_cfg->tx_blocking_mode;
    drv->rx_blocking_mode = drv_cfg->rx_blocking_mode;
#else // no kernel
    drv->tx_blocking_mode = drv_cfg->tx_blocking ? DRV_UART8_TX_BLOCKING_MODE_LOOP : DRV_UART8_TX_BLOCKING_MODE_NONE;
    drv->rx_blocking_mode = drv_cfg->rx_blocking ? DRV_UART8_RX_BLOCKING_MODE_LOOP : DRV_UART8_RX_BLOCKING_MODE_NONE;
#endif

#if MUTEXES
# if DRV_UART8_INSTANCE_MUTEX_FALSE_USED
    if (drv->mutexes)
# endif
    {
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init(&mutexattr);

        pthread_mutex_init(&drv->tx_mutex, &mutexattr);
        pthread_mutex_init(&drv->rx_mutex, &mutexattr);
    }
#endif

    // ringbuffers
    drv->tx_head    = 0;
    drv->tx_tail    = 0;
    drv->tx_busy    = false;
    drv->rx_head    = 0;
    drv->rx_tail    = 0;
    drv->rx_mask    = 0;

    // default user parity bit for transmitting under interrupt
    drv->tx_parityval = false;

    /*
     * Initialize WB_UART core
     */

    // Reset the core and disable receiver
    UART8_BRGLOW (drv->baseaddress) = 0;
    UART8_BRGMID (drv->baseaddress) = 0;
    UART8_BRGHIGH(drv->baseaddress) = 0;

    // handshake mode
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

    // set up hardware based on configuration
    UART8_TXLOWMARK(drv->baseaddress)  = TXLOWMARK_DEFAULT;
    UART8_RXLOWMARK(drv->baseaddress)  = RXLOWMARK_DEFAULT;
    UART8_RXHIGHMARK(drv->baseaddress) = RXHIGHMARK_DEFAULT;
    UART8_RXDTO(drv->baseaddress)      = RXDTO_DEFAULT;

    // interrupts
    uart8_connect_interrupts(drv);

    // settings the baudrate also clears all hardware buffers
    uart8_set_parameters(drv, drv_cfg->baudrate, drv_cfg->parity, drv_cfg->databits, drv_cfg->stopbits);

    // we're done
    drv->status = DRV_UART8_INITIALIZED;
}

/**
 * @brief Set serial communication parameters
 *
 * @param   drv      uart8 driver pointer
 * @param   baudrate communication speed to be used (in bps)
 * @param   parity   parity to be used
 * @param   databits data bits to be used, minimal 5 and maximal 8 bits per serial word
 * @param   stopbits number of stopbits, must be 1 or 2
 */
void uart8_set_parameters( uart8_t * restrict drv, uint32_t baudrate, uart8_parity_t parity, uint8_t databits, uint8_t stopbits )
{
    uint8_t parms;

    assert( drv != 0 );
    assert( parity < 4 );
    assert( databits > 4 && databits < 9 );
    assert( (stopbits > 0) && (stopbits < 3) );
    assert( baudrate != 0 );

    UART8_MUTEXRX_PREPARE();
    UART8_MUTEXRX_LOCK(drv);

    uart8_set_baudrate_internal( drv, baudrate );

    parms = databits - 5;
    if ( stopbits == 2 ) parms |= UART8_PARM_STOPBITS;
    switch( parity )
    {
    case UART8_ODD_PARITY : // Odd parity
        parms |= UART8_PARM_ODDPARITY;
        break;
    case UART8_EVEN_PARITY : // Even parity
        parms |= UART8_PARM_EVENPARITY;
        break;
    case UART8_USER_PARITY : // User parity
        parms |= UART8_PARM_USERPARITY;
        break;
    default:    // No parity
        parms |= UART8_PARM_NOPARITY;
        break;
    }
    UART8_PARM(drv->baseaddress) = parms;
    UART8_MUTEXRX_UNLOCK(drv);

}

/**
 * @brief Get parity
 *
 * @param       drv       uart8 driver pointer
 *
 * @return parity.
 */
uint8_t uart8_get_parity(uart8_t * restrict drv)
{
    uint8_t parms;

    assert(drv != NULL);

    parms = UART8_PARM(drv->baseaddress);

    switch (parms & UART8_PARM_PARMASK)
    {
    case UART8_PARM_ODDPARITY : return UART8_ODD_PARITY;
    case UART8_PARM_EVENPARITY : return UART8_EVEN_PARITY;
    case UART8_PARM_USERPARITY : return UART8_USER_PARITY;
    }

    return UART8_NO_PARITY;
}

/**
 * @brief Get databits per serial word
 *
 * @param       drv       uart8 driver pointer
 *
 * @return number of databits per serial word
 */
uint8_t uart8_get_databits(uart8_t * restrict drv)
{
    assert(drv != NULL);

    return 5 + (UART8_PARM(drv->baseaddress) & UART8_PARM_WORDLEN);
}

/**
 * @brief Get stopbits
 *
 * @param       drv       uart8 driver pointer
 *
 * @return stopbits.
 */
uint8_t uart8_get_stopbits(uart8_t * restrict drv)
{
    assert(drv != NULL);

    return (UART8_PARM(drv->baseaddress) & UART8_PARM_STOPBITS) ? 2 : 1;
}

/**
 * @brief Set user parity
 *
 * Use this function to set the value of the parity bit when parity is set to "user parity"
 *
 * @param   drv     uart8 driver pointer
 * @param   val     Value to be set (0 or 1)
 *
 * @return  Driver status
 */
void uart8_set_user_parity( uart8_t * restrict drv, int val )
{
    assert( drv != NULL );
    assert( val == 0 || val == 1 );

    UART8_MUTEXRX_PREPARE();
    UART8_MUTEXRX_LOCK(drv);

    if (drv->tx_buffer_size == 0)
    {
        if ( val )
        {
            UART8_PARM( drv->baseaddress ) |= UART8_PARM_PARITYVAL;
        }
        else
        {
            UART8_PARM( drv->baseaddress ) &= ~UART8_PARM_PARITYVAL;
        }
    }
    else
    {
        drv->tx_parityval = (val != 0);
    }

    UART8_MUTEXRX_UNLOCK(drv);
}

/**
 * @brief   Define what exceptions should be ignored
 *
 * Use this function to define a mask of exceptional conditions to be ignored (skipped) from the receiver.
 * The mask consists of UART8_BREAK, UART8_PARERR and UART8_FRAMERR bits. For example, to ignore parity-
 * and framing errors, call <code>uart8_ignore( uart, UART8_PARERR | UART8_FRAMERR );</code>
 *
 * Default, no error conditions and/or breaks are ignored.
 *
 * @param   drv     uart8 driver pointer
 * @param   rx_mask Conditions to ignore
 *
 * @return  Nothing
 */
void uart8_ignore( uart8_t * restrict drv, uint16_t rx_mask )
{
    assert( drv != NULL );
    if ( rx_mask & UART8_BREAK )
    {
        drv->rx_mask |= UART8_LCR_BREAK;
    }
    else
    {
        drv->rx_mask &= ~UART8_LCR_BREAK;
    }

    if ( rx_mask & UART8_PARERR )
    {
        drv->rx_mask |= UART8_LCR_PARERR;
    }
    else
    {
        drv->rx_mask &= ~UART8_LCR_PARERR;
    }

    if ( rx_mask & UART8_FRAMERR )
    {
        drv->rx_mask |= UART8_LCR_FRAMERR;
    }
    else
    {
        drv->rx_mask &= ~UART8_LCR_FRAMERR;
    }
}

/**
 * @brief   Get core version number
 *
 * Use this function to retreive the core version. For older versions, the functions always returns
 * version 2, indicating it's either a UART8 or UART8_V2 core with fixed communication parameters (N81).
 * Version 3 indicates a core supporting different wordlengths, parity and multiple stopbits.
 *
 * @param   drv     uart8 driver pointer
 *
 * @return  Core version number
 */
uint8_t uart8_get_version( uart8_t * restrict drv )
{
    uint8_t v1, v2;
    v1 = UART8_VERSION( drv->baseaddress );
    v2 = UART8_VERSION( drv->baseaddress );
    if ( (v1 ^ v2)  == 0x80 ) return v1 & 0x7F;
    else return 2;
}

/**
 * @brief Get driver status
 *
 * Use this function to get status information from the driver.  The return
 * value is a combination of the following flags: DRV_UART8_INITIALIZED,
 * DRV_UART8_RXSTALLED, and DRV_UART8_TXSTALLED
 *
 * @param   drv     uart8 driver pointer
 *
 * @return  Driver status
 */
uint8_t uart8_get_drvstat( uart8_t * restrict drv )
{
    assert( drv != NULL );
    return drv->status;
}

