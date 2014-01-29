/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    TERMINAL serial communications drv.
|*
\*****************************************************************************/

/**
 * @file
 * Driver for WB_TERMINAL peripheral.
 *
 * The driver can either use the TERMINAL core buffer, or it can use an additional, interrupt
 * controlled software buffer.
 *
 * You can configure these buffer settings independently for receive and transmit.
 *
 * For a detailed description of the WB_TERMINAL peripheral, see the Core Reference
 * <a href="CR0180 TERMINAL Debug Console Instrument.PDF">CR0180 TERMINAL Debug Console Instrument</a>
 */

#include <assert.h>

#include <pal.h>
#include <interrupts.h>

#include <sysutils.h>

#include <per_terminal.h>
#include <drv_terminal_cfg_instance.h>


// a few extra defines to improve readability

#if ((__POSIX_KERNEL__ != 0) && (DRV_UART8_INSTANCE_MUTEX_TRUE_USED != 0))
# define MUTEXES 1
# if (DRV_UART8_INSTANCE_MUTEX_FALSE_USED != 0)
// TODO: should be with runtime test but current macros don't allow
#   define MUTEX_PREPARE()      POSIX_DEV_MUTEX_PREPARE(terminal_mutex_buffer)
#   define MUTEX_LOCK(mutex)    POSIX_DEV_MUTEX_LOCK(mutex, terminal_mutex_buffer)
#   define MUTEX_UNLOCK(mutex)  POSIX_DEV_MUTEX_UNLOCK(mutex, terminal_mutex_buffer)
# else
#   define MUTEX_PREPARE()      POSIX_DEV_MUTEX_PREPARE(terminal_mutex_buffer)
#   define MUTEX_LOCK(mutex)    POSIX_DEV_MUTEX_LOCK(mutex, terminal_mutex_buffer)
#   define MUTEX_UNLOCK(mutex)  POSIX_DEV_MUTEX_UNLOCK(mutex, terminal_mutex_buffer)
# endif
#else
# define MUTEX_PREPARE()
# define MUTEX_LOCK(mutex)
# define MUTEX_UNLOCK(mutex)
#endif


// runtime driver properties
typedef struct terminal_drv_s
{
#if MUTEXES
    pthread_mutex_t tx_mutex;
    pthread_mutex_t rx_mutex;
#endif

    // workcopies from peripheral configuration
    uintptr_t baseaddress;

} terminal_t;


// runtime driver table
static terminal_t drv_table[DRV_TERMINAL_INSTANCE_COUNT];


// internal for terminal_putchar()
static int terminal_putchar_internal(terminal_t * restrict drv, int val)
{
    if (TERMINAL_STATUS(drv->baseaddress) & TERMINAL_STATUS_TXFULL) return -1; // core tx buffer full

    TERMINAL_SBUF(drv->baseaddress) = val & 0xFF;

    return 0;
}


/**
 * @brief Write a single byte to the TERMINAL
 *
 * If free space available Put a single byte @em val in the transmit buffer
 * (or in the core if the buffer size is zero).
 *
 * @see terminal_getchar
 *
 * @param      drv     terminal driver pointer
 * @param      val     byte to transmit.
 *
 * @return 0 if succes, -1 if no space
 */
extern int terminal_putchar(terminal_t * restrict drv, int val)
{
    assert(drv != NULL);
    assert((val >= 0) && (val <= 0xFF));

    int result = 0;

    MUTEX_PREPARE()
    MUTEX_LOCK(drv->tx_mutex);

    result = terminal_putchar_internal(drv, val);

    MUTEX_UNLOCK();

    return result;
}


// internal for terminal_getchar()
static int terminal_getchar_internal(terminal_t * restrict drv)
{
    // using only core buffer
    if (!(TERMINAL_STATUS(drv->baseaddress) & TERMINAL_STATUS_RXNEMPTY)) return -1; // no data

    // received normal data
    return TERMINAL_SBUF(drv->baseaddress);
}


/**
 * @brief Read a single byte or break from the TERMINAL
 *
 * If available return a single byte or break from the receive buffer
 * (or from the core if the buffer size is zero).
 *
 * @see terminal_putchar
 *
 * @param       drv     terminal driver pointer
 *
 * @return The byte read, TERMINAL_BREAK (0x100) if a breakcondition occurred, -1 if none available
 */
extern int terminal_getchar(terminal_t * restrict drv)
{
    assert(drv != NULL);

    int result;

    MUTEX_PREPARE()
    MUTEX_LOCK(drv->rx_mutex);

    result = terminal_getchar_internal(drv);

    MUTEX_UNLOCK();

    return result;
}



/**
 * @brief Write multiple characters to the TERMINAL
 *
 * Write @em size characters from buffer @em data to the TERMINAL. This function is blocking.
 *
 * @see terminal_read
 *
 * @param       drv    terminal driver pointer
 * @param       buf   start address of data to write
 * @param       size   number of characters to write
 *
 * @return The number of bytes written.
 */
extern size_t terminal_write(terminal_t * restrict drv, const char *buf, size_t size)
{
    assert(drv != NULL);
    assert(buf != NULL);

    int result;
    int count = 0;

    MUTEX_PREPARE()
    MUTEX_LOCK(drv->tx_mutex);

    while (count != size)
    {
        result = terminal_putchar_internal(drv, buf[count]);

        if (result >= 0)
        {
            ++count;
        }
        else
        {
#if __POSIX_KERNEL__
            sched_yield();
#endif
        }
    }

    MUTEX_UNLOCK(drv->tx_mutex);

    return count;
}


/**
 * @brief Read multiple characters from the TERMINAL
 *
 * Read @em size characters from the TERMINAL and place them into @em buf. This function is blocking.
 *
 * @see terminal_write
 *
 * @param        drv    terminal driver pointer
 * @param        buf    destination buffer
 * @param        size   maximum number of bytes to read
 *
 * @return The number of bytes read.
 */
extern size_t terminal_read(terminal_t * restrict drv, char *buf, size_t size)
{
    assert(drv != NULL);
    assert(buf != NULL);

    int result;
    int count = 0;

    MUTEX_PREPARE()
    MUTEX_LOCK(drv->rx_mutex);

    while (count != size)
    {
        result = terminal_getchar_internal(drv);

        if (result >= 0)
        {
            // Fix for terminal: pressing Enter returns CR, not LF
            if (result == 0x0D) result = '\n';
            buf[count++] = result & 0xFF;
        }
        else
        {
#if __POSIX_KERNEL__
            sched_yield();
#endif
        }
    }

    MUTEX_UNLOCK(drv->rx_mutex);

    return count;
}


/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a TERMINAL core and its driver.
 * You should call it only once per id.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise.
 */
terminal_t *terminal_open(int id)
{
    assert((id >= 0) && (id < DRV_TERMINAL_INSTANCE_COUNT));

    terminal_t * restrict drv = &drv_table[id];
    // get configuration of driver (created by plugin system)
    drv_terminal_cfg_instance_t * restrict drv_cfg = &drv_terminal_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    per_terminal_cfg_instance_t * restrict per_cfg = &per_terminal_instance_table[drv_cfg->per_terminal];

#ifdef MUTEXES
    if (driver->mutexes)
    {
        pthread_mutexattr_t mutexattr;

        pthread_mutexattr_init(&mutexattr);

        pthread_mutex_init(&drv->tx_mutex, &mutexattr);
        pthread_mutex_init(&drv->rx_mutex, &mutexattr);
    }
#endif

    // copy peripheral configuration needed to driver
    assert(per_cfg->baseaddress != 0);
    drv->baseaddress  = per_cfg->baseaddress;


    return drv;
}


