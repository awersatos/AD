/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        EMAC32 peripheral
|*
\*****************************************************************************/

#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#if __POSIX_KERNEL__
# include <pthread.h>
#else
# include <pal.h>
#endif

#include <interrupts.h>
#include <sysutils.h>

#include <per_emac32.h>
#include <drv_emac32.h>
#include <drv_emac32_cfg_instance.h>



// a few extra defines to improve readability

// if none are defined, waiting mode is NOP for both no kernel and kernel
#if __POSIX_KERNEL__

# if DRV_EMAC32_INSTANCE_TX_WAIT_MODE_NOP_USED
#  define TX_KERNEL_WAIT_NOP 1
#  define INTERRUPT_NATIVE 1
# endif
# if DRV_EMAC32_INSTANCE_TX_WAIT_MODE_NOTIFY_USED
#  define TX_KERNEL_WAIT_NOTIFY 1
#  define INTERRUPT_POSIX 1
# endif
# if DRV_EMAC32_INSTANCE_TX_WAIT_MODE_SLEEP_USED
#  define TX_KERNEL_WAIT_SLEEP 1
#  define INTERRUPT_NATIVE 1
# endif
# if DRV_EMAC32_INSTANCE_TX_WAIT_MODE_YIELD_USED
#  define TX_KERNEL_WAIT_YIELD 1
#  define INTERRUPT_NATIVE 1
# endif

#else

# if DRV_EMAC32_INSTANCE_TX_BLOCKING_FALSE_USED
#  define TX_NOKERNEL_WAIT_NOP 1
# endif
# define INTERRUPT_NATIVE 1

#endif

// if none are defined, waiting mode is NOP for both no kernel and kernel
#if __POSIX_KERNEL__

# if DRV_EMAC32_INSTANCE_RX_WAIT_MODE_NOP_USED
#  define RX_KERNEL_WAIT_NOP 1
#  define INTERRUPT_NATIVE 1
# endif
# if DRV_EMAC32_INSTANCE_RX_WAIT_MODE_NOTIFY_USED
#  define RX_KERNEL_WAIT_NOTIFY 1
#  define INTERRUPT_POSIX 1
# endif
# if DRV_EMAC32_INSTANCE_RX_WAIT_MODE_SLEEP_USED
#  define RX_KERNEL_WAIT_SLEEP 1
#  define INTERRUPT_NATIVE 1
# endif
# if DRV_EMAC32_INSTANCE_RX_WAIT_MODE_YIELD_USED
#  define RX_KERNEL_WAIT_YIELD 1
#  define INTERRUPT_NATIVE 1
# endif

#else

# if DRV_EMAC32_INSTANCE_RX_BLOCKING_FALSE_USED
#  define RX_NOKERNEL_WAIT_NOP 1
# endif
# define INTERRUPT_NATIVE 1

#endif

#if ((__POSIX_KERNEL__ != 0) && (DRV_EMAC32_INSTANCE_MUTEX_TRUE_USED != 0))

# define MUTEXES 1

# if DRV_UART8_INSTANCE_MUTEX_FALSE_USED
// TODO: should be with runtime test but current macros don't allow
#   define MUTEX_LOCK(mutex) DEV_MUTEX_LOCK(mutex)
#   define MUTEX_UNLOCK(mutex)    DEV_MUTEX_UNLOCK(mutex)
# else
#   define MUTEX_LOCK(mutex) DEV_MUTEX_LOCK(mutex)
#   define MUTEX_UNLOCK(mutex)    DEV_MUTEX_UNLOCK(mutex)
# endif

#else

# define MUTEX_LOCK(mutex)
# define MUTEX_UNLOCK(mutex)

#endif


#define MAC_SIZE  6

typedef struct __packed__
{
    uint32_t size;
    uint8_t destmac[MAC_SIZE];
    uint8_t sourcemac[MAC_SIZE];
    uint16_t type;
} emac32_buf_t;


struct emac32_s
{
#if MUTEXES
    pthread_mutex_t tx_mutex;
    pthread_mutex_t rx_mutex;
#endif
    // workcopies from driver configuration

    uint8_t mac[6];

    uint32_t tx_cmd;
#if __POSIX_KERNEL__
    int tx_wait_mode;
# if TX_KERNEL_WAIT_SLEEP
    uint32_t tx_wait_sleepms;
# endif
# if INTERRUPT_POSIX
    volatile int tx_notify_count;
# endif
#else
    bool tx_blocking;
#endif

    uint32_t rx_cmd;
#if __POSIX_KERNEL__
    int rx_wait_mode;
# if RX_KERNEL_WAIT_SLEEP
    uint32_t rx_wait_sleepms;
# endif
# if INTERRUPT_POSIX
    volatile int rx_notify;
# endif
#else
    bool rx_blocking;
#endif

    // workcopies from peripheral configuration
    uintptr_t baseaddress;
    uint8_t interrupt;

};

/*
 * runtime driver properties,
 * compiletime properties and buffers are
 * located in drv_emac32_instance_cfg[]
 */
static emac32_t drv_table[DRV_EMAC32_INSTANCE_COUNT];


void memcpyfast(void* restrict destination, const void* restrict source, size_t num)
{
    uintptr_t dst = (uintptr_t) destination;
    uintptr_t src = (uintptr_t) source;

    if (((dst & 3) == 0) && ((src & 3) == 0))
    {
        while (num > 3)
        {
            *(uint32_t*) dst = *(uint32_t*) src;
            dst += 4;
            src += 4;
            num -= 4;
        }
    }
    else if (((dst & 1) == 0) && ((src & 1) == 0))
    {
        while (num > 1)
        {
            *(uint16_t*) dst = *(uint16_t*) src;
            dst += 2;
            src += 2;
            num -= 2;
        }
    }

    while (num > 0)
    {
        *(uint8_t*) dst = *(uint8_t*) src;
        dst += 1;
        src += 1;
        num -= 1;
    }
}


// test if packet of given size would fit in the packetbuffer
inline bool emac32_txbuffer_test(const uintptr_t base, int size)
{
    size += 4; // reserve leading word to store packetsize
    size += 4; // reserve space for packetsize of next packet
    size = (size + 3) & ~3; // round up to 32-bit border

    if (EMAC32_TX_INPUT(base) >= EMAC32_TX_OUTPUT(base))
    {
        if ((EMAC32_TX_INPUT(base) + size) < EMAC32_TX_END(base))
        {
            return true;
        }
        else if ((EMAC32_TX_START(base) + size) < EMAC32_TX_OUTPUT(base))
        {
            return true;
        }

        return false;
    }

    if ((EMAC32_TX_INPUT(base) + size) < EMAC32_TX_OUTPUT(base))
    {
        return true;
    }

    return false;
}


/*****************************************************************************
|*
|*  Function:           interrupt_handler_common
|*
|*  Parameters:         num : interrupt number
|*                      arg : pointer to driver
|*
|*  Description:        Handle transmit interrupts.
 */
inline void handler_common(uint32_t num, void *arg)
{
    emac32_t * restrict drv = (emac32_t *) arg;

    EMAC32_TX_STATUS(drv->baseaddress) = EMAC32_TX_STATUS_INT_EMPTY |
                                         EMAC32_TX_STATUS_INT_COLLISION |
                                         EMAC32_TX_STATUS_INT_LENGTH;

    EMAC32_RX_STATUS(drv->baseaddress) = EMAC32_RX_STATUS_INT_OVERFLOW |
                                         EMAC32_RX_STATUS_INT_LACKOFSPACE;

    // enable receiver again in case of errors
    EMAC32_TX_CMD(drv->baseaddress) = drv->tx_cmd;
    EMAC32_RX_CMD(drv->baseaddress) = drv->rx_cmd;
}


#if INTERRUPT_POSIX

// using two threaded interrupt wrappers as the same
// interrupt might wake up both rx and tx calls
// NOTE: make sure the handlers are registered in a way that guarantees the correct order of execution:
//       tx_handler first, rx_handler second.

// this handler must run first
static int tx_handler(uint32_t num, void *arg)
{
    int retvalue;

    // acknowledge as soon as possible, so we can pick up newly pending interrupts
    interrupt_acknowledge(num);

    retvalue = 0;

    if ((drv->tx_notify_count != 0) && (EMAC32_TX_STATUS(drv->baseaddress) & EMAC32_TX_STATUS_INT_FRAMESENT))
    {
        EMAC32_TX_STATUS(drv->baseaddress) = EMAC32_TX_STATUS_INT_FRAMESENT;
        if (emac32_txbuffer_test(drv->baseaddress, drv->tx_notify_count))
        {
            retvalue |= INTERRUPT_NOTIFY;
            drv->tx_notify = 0;
        }
    }

    return retvalue;
}


// this handler must run second as it does the actual handling
static int rx_handler(uint32_t num, void *arg)
{
    int retvalue = INTERRUPT_HANDLED;

    if (drv->rx_notify && (EMAC32_RX_STATUS(drv->baseaddress) & EMAC32_RX_STATUS_INT_FRAMEOK))
    {
        EMAC32_RX_STATUS(drv->baseaddress) = EMAC32_RX_STATUS_INT_FRAMEOK;
        retvalue |= INTERRUPT_NOTIFY;
        drv->rx_notify = false;
    }

    handler_common(num, arg);

    return retvalue;
}

#endif


#if INTERRUPT_NATIVE

// native interrupt wrapper
__INTERRUPT_NATIVE void handler_native(void)
{
    int num = interrupt_get_current();
    void *arg;

    // acknowledge as soon as possible, so we can pick up newly pending interrupts
    interrupt_acknowledge(num);

    arg = interrupt_native_context(num);

    handler_common(num, arg);
}

#endif


//*** internal lowlevel functions *********************************

// get address of oldest received packet,
// use emac32_rxbuffer_free() to release it
static uint32_t *emac32_rxbuffer(const uintptr_t base)
{
    if (EMAC32_RX_OUTPUT(base) == EMAC32_RX_INPUT(base)) return NULL;

    // wrap if needed
    if (*((uint32_t *) EMAC32_RX_OUTPUT(base)) == 0) EMAC32_RX_OUTPUT(base) = EMAC32_RX_START(base);     // JD+JEV

    if (EMAC32_RX_OUTPUT(base) == EMAC32_RX_INPUT(base)) return NULL;

    return (uint32_t*) EMAC32_RX_OUTPUT(base);
}


// release oldest received packetbuffer as given by emac32_rxbuffer()
// (size must be as packetbuffer says)
static void emac32_rxbuffer_free(const uintptr_t base, uint32_t *corebuf)
{
    EMAC32_RX_OUTPUT(base) += ((*corebuf + 7 ) & ~3);
}


// get address of empty packetbuffer to send data with given size
// use emac32_txbuffer_send() with same size to send it
static uint32_t *emac32_txbuffer(const uintptr_t base, int size)
{
    size += 4; // reserve leading word to store packetsize
    size += 4; // reserve space for packetsize of next packet
    size = (size + 3) & ~3; // round up to 32-bit border

    if (EMAC32_TX_INPUT(base) >= EMAC32_TX_OUTPUT(base))
    {
        if ((EMAC32_TX_INPUT(base) + size) < EMAC32_TX_END(base))
        {
            return (uint32_t*) EMAC32_TX_INPUT(base);
        }
        else if ((EMAC32_TX_START(base) + size) < EMAC32_TX_OUTPUT(base))
        {
            *((uint32_t*) EMAC32_TX_INPUT(base)) = 0;

            return (uint32_t*) EMAC32_TX_START(base);
        }

        return NULL;
    }

    if ((EMAC32_TX_INPUT(base) + size) < EMAC32_TX_OUTPUT(base))
    {
        return (uint32_t*) EMAC32_TX_INPUT(base);
    }

    return NULL;
}


// send the buffer given by emac32_txbuffer()
static void emac32_txbuffer_send(const uintptr_t base, uint32_t *corebuf)
{

//    EMAC32_TX_CMD(base) &= ~EMAC32_TX_CMD_ENABLE;
    EMAC32_TX_INPUT(base) = ((uintptr_t) corebuf) + ((*corebuf + 7) & ~3 );
    EMAC32_TX_CMD(base) |= EMAC32_TX_CMD_ENABLE;   // ERIK: SHOULD THIS REALLY BE HERE? USER COULD PUT MULTIPLE AND THEN ENABLE...
}



//*** blocking support *********************************

#if INTERRUPT_POSIX

/****
 * Wait for interrupthandler to signal available buffer
 *
 * Wait for count bytes free space to become available in the transmit buffer
 * (by using interrupt waiting)
 *
 * param       drv       emac32 driver pointer
 * param       size      number of bytes free space to wait for
 *
 * return Errorcode from posix_interrupt_timedwait() if failed or interrupted, 0 otherwise.
 */
static int emac32_transmit_buf_free_timedwait(emac32_t * restrict drv, int size)
{
    int tx_interrupt = drv->interrupt;

    // associate, but thread can be interrupted before the association completes
    pthread_interrupt_associate(tx_interrupt, &tx_handler, (void*) drv);

    // test free space with the interrupt disabled
    interrupt_disable(tx_interrupt);

    if (emac32_txbuffer_test(drv->baseaddress, count))
    {
        // enough free space after all, waiting not needed
        interrupt_enable(tx_interrupt);
        pthread_interrupt_disassociate(tx_interrupt, &tx_handler, (void*) drv);
    }
    else
    {
        // tell interrupthandler how much we want and wait for its notification
        drv->tx_notify_count = count;
        interrupt_enable(tx_interrupt);
        err = pthread_interrupt_timedwait(NULL);
        pthread_interrupt_disassociate(tx_interrupt, &tx_handler, (void*) drv);
    }

    return err;
}

#endif


/*****
 * Wait (or not) for space in transmit buffer data according to plugin blocking mode
 *
 * param       drv       emac32 driver pointer
 * param       count     number of bytes to wait for
 *
 * return true if continuing, false if aborting
 */

static bool emac32_transmit_block(emac32_t * restrict drv, int size)
{
#if TX_NOKERNEL_WAIT_NOP
    if (!drv->tx_blocking)
    {
        return false;
    }
    else
#endif
#if TX_KERNEL_WAIT_NOP
    if (drv->tx_wait_mode == DRV_EMAC32_TX_WAIT_MODE_NOP)
    {
        return true;
    }
    else
#endif
#if TX_KERNEL_WAIT_NOTIFY
    if (drv->tx_wait_mode == DRV_EMAC32_TX_WAIT_MODE_NOTIFY)
    {
        if (emac32_transmit_buf_free_timedwait(drv, size) != 0)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if TX_KERNEL_WAIT_SLEEP
    if (drv->tx_wait_mode == DRV_EMAC32_TX_WAIT_MODE_SLEEP)
    {
        struct timespec ts = { 0, drv->tx_wait_sleepms * 1000 * 1000 };

        if (nanosleep (&ts, NULL) == -1)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if TX_KERNEL_WAIT_YIELD
    if (drv->tx_wait_mode == DRV_EMAC32_TX_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
    {
        /* no special mode, just loop */
    }

    return true;
}


#if INTERRUPT_POSIX

/****
 * Wait for interrupthandler to signal available received packet (by using interrupt waiting)
 *
 * param       drv       emac32 driver pointer
 *
 * return Errorcode from posix_interrupt_timedwait() if failed or interrupted, 0 otherwise.
 */
static int emac32_receive_buf_available_timedwait(emac32_t * restrict drv)
{
    int rx_interrupt = drv->interrupt;

    // associate, but thread can be interrupted before the association completes
    pthread_interrupt_associate(rx_interrupt, &rx_handler, (void*) drv);

    // test free space with the interrupt disabled
    interrupt_disable(rx_interrupt);

    if (emac32_rxbuffer_test(drv->baseaddress))
    {
        // waiting packet after all, waiting not needed
        interrupt_enable(rx_interrupt);
        pthread_interrupt_disassociate(rx_interrupt, &rx_handler, (void*) drv);
    }
    else
    {
        // tell interrupthandler we want a packet and wait for its notification
        drv->rx_notify = true;
        interrupt_enable(rx_interrupt);
        err = pthread_interrupt_timedwait(NULL);
        pthread_interrupt_disassociate(rx_interrupt, &rx_handler, (void*) drv);
    }

    return err;
}

#endif


/*****
 * Wait (or not) for next received packet according to plugin blocking mode
 *
 * param       drv       emac32 driver pointer
 *
 * return true if continuing, false if aborting
 */

static bool emac32_receive_block(emac32_t * restrict drv)
{
#if RX_NOKERNEL_WAIT_NOP
    if (!drv->rx_blocking)
    {
        return false;
    }
    else
#endif
#if RX_KERNEL_WAIT_NOP
    if (drv->rx_wait_mode == DRV_EMAC32_RX_WAIT_MODE_NOP)
    {
        return true;
    }
    else
#endif
#if RX_KERNEL_WAIT_NOTIFY
    if (drv->rx_wait_mode == DRV_EMAC32_RX_WAIT_MODE_NOTIFY)
    {
        if (emac32_receive_buf_available_timedwait(drv) != 0)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if RX_KERNEL_WAIT_SLEEP
    if (drv->rx_wait_mode == DRV_EMAC32_RX_WAIT_MODE_SLEEP)
    {
        struct timespec ts = { 0, drv->rx_wait_sleepms * 1000 * 1000 };

        if (nanosleep (&ts, NULL) == -1)
        {
            // signal or error
            return false;
        }
    }
    else
#endif
#if RX_KERNEL_WAIT_YIELD
    if (drv->rx_wait_mode == DRV_EMAC32_RX_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
    {
        /* no special mode, just loop */
    }

    return true;
}


//*** blocking get rxbuffer & alloc txbuffer *********************************


/*****************************************************************************
|*
|*  Function:           emac32_transmit_getbuf
|*
|*  Parameters:         drv     : driver
|*                      size    : data size of packet buffer to allocate
|*
|*  Returns:            pointer to free corebuf or NULL
|*
|*  Description:        optionally blocking shell around emac32_txbuffer()
 */
static uint32_t * emac32_transmit_getbuf(emac32_t * restrict drv, uint32_t size)
{
    uint32_t *corebuf;

    do
    {
        corebuf = emac32_txbuffer(drv->baseaddress, size);
        if (corebuf != NULL)
        {
            *corebuf = size;
            break;
        }
    } while (emac32_transmit_block(drv, size));

    return corebuf;
}


/*****************************************************************************
|*
|*  Function:           emac32_receive_getbuf
|*
|*  Parameters:         drv     : driver
|*
|*  Returns:            pointer to new received corebuf NULL
|*
|*  Description:        optionally blocking shell around emac32_rxbuffer()
 */
static uint32_t * emac32_receive_getbuf(emac32_t * restrict drv)
{
    uint32_t *corebuf;

    do
    {
        corebuf = emac32_rxbuffer(drv->baseaddress);
        if (corebuf != NULL)
        {
            break;
        }
    } while (emac32_receive_block(drv));

    return corebuf;
}


//*** zero-copy interface **********************************************************

/**
 * @brief Allocate an empty sendbuffer
 *
 * Returns pointer to free core buffer (uint32 size plus ethernetframe) for packet
 * with given frame size, initialized with originating MAC.
 * After allocating a buffer must be send using emac32_corebuf_send().
 * Part of the zero-copy interface.
 *
 * @param      drv         valid emac32 driver pointer
 * @param      size        size of packet (including ethernet header) to send
 *
 * @return     pointer to core buffer, NULL if not enough free space available
 *
 * @see        emac32_corebuf_send
 */
extern uint32_t *emac32_corebuf_alloc(emac32_t * restrict drv, int size)
{
    uint32_t *corebuf;

    MUTEX_LOCK(drv->tx_mutex);

    corebuf = emac32_transmit_getbuf(drv, size);

    if (corebuf)
    {
         memcpy(((emac32_buf_t *) corebuf)->sourcemac, drv->mac, MAC_SIZE);
    }

    MUTEX_UNLOCK(drv->tx_mutex);

    return corebuf;
}



/**
 * @brief Transmit a sendbuffer
 *
 * Send corebuffer (uint32 size plus ethernetframe).
 * The corebuffer must be the one returned from last emac32_corebuf_alloc() call.
 * Part of the zero-copy interface.
 *
 * @param      drv       valid emac32 driver pointer
 * @param      corebuf   pointer to corebuffer last allocated
 *
 * @return     void
 *
 * @see        emac32_corebuf_alloc
 */
extern void emac32_corebuf_send(emac32_t * restrict drv, uint32_t *corebuf)
{
    MUTEX_LOCK(drv->tx_mutex);

    emac32_txbuffer_send(drv->baseaddress, corebuf);

    MUTEX_UNLOCK(drv->tx_mutex);
}


/**
 * @brief Get a receivebuffer if available
 *
 * Returns pointer to corebuffer (uint32 size plus ethernetframe) with next
 * received packet.
 * After receiving a buffer must be freed using emac32_corebuf_free().
 * Part of the zero-copy interface.
 *
 * @param      drv           valid emac32 driver pointer
 *
 * @return     pointer to corebuffer, NULL none available
 *
 * @see        emac32_corebuf_free
 */
extern uint32_t *emac32_corebuf_receive(emac32_t * restrict drv)
{
    uint32_t *corebuf;

    MUTEX_LOCK(drv->mutex);

    corebuf = emac32_receive_getbuf(drv);

    MUTEX_UNLOCK();

    return corebuf;
}


/**
 * @brief Release a receivebuffer
 *
 * Release corebuffer (uint32 size plus ethernetframe).
 * The corebuffer must be the one returned from last emac32_corebuf_receive() call.
 * Part of the zero-copy interface.
 *
 * @param      drv       valid emac32 driver pointer
 * @param      corebuf   pointer to corebuffer last received
 *
 * @return     void
 *
 * @see        emac32_corebuf_receive
 */
extern void emac32_corebuf_free(emac32_t * restrict drv, uint32_t *corebuf)
{
    MUTEX_LOCK(drv->mutex);

    emac32_rxbuffer_free(drv->baseaddress, corebuf);

    MUTEX_UNLOCK();
}


//*** copying interface **********************************************************


/**
 * @brief Transmit data
 *
 * Send packet, data is copied to core buffer.
 * Part of the copying interface.
 *
 * @param      drv        valid emac32 driver pointer
 * @param      buf        user supplied buffer containing ethernet frame
 *                        (use 16-bit or 32-bit aligned buffers to speed up copying)
 * @param      size       number of bytes to send
 *
 * @return     size of data send, -1 for error
 */
extern int emac32_send(emac32_t * restrict drv, uint8_t *buf, int size)
{
    uint32_t *corebuf;

    MUTEX_LOCK(drv->mutex);

    corebuf = emac32_transmit_getbuf(drv, size);

   if (corebuf)
    {
        memcpyfast(corebuf + 1, buf, size);
        memcpy(((emac32_buf_t *) corebuf)->sourcemac, drv->mac, MAC_SIZE);

        emac32_txbuffer_send(drv->baseaddress, corebuf);
    }
    else
    {
        size = -1;
    }

    MUTEX_UNLOCK();

    return size;
}


/**
 * @brief Receive data if available
 *
 * Get received ethernet frame, data is copied to user buffer.
 * Part of the zero-copy interface.
 *
 * @param      drv        valid emac32 driver pointer
 * @param      buf        user supplied buffer to store received data
 *                        (use 16-bit or 32-bit aligned buffers to speed up copying)
 * @param      size       size of buffer
 *
 * @return     size of data received (might be more than what was copied in buffer), 0 for no data
 */
extern int emac32_receive(emac32_t * restrict drv, uint8_t *buf, int size)
{
    uint32_t *corebuf;

    MUTEX_LOCK(drv->mutex);

    corebuf = emac32_receive_getbuf(drv);

   if (corebuf)
    {
        int copysize = *corebuf;

        if (copysize > size) copysize = size;

        memcpyfast(buf, corebuf + 1, copysize);

        emac32_rxbuffer_free(drv->baseaddress, corebuf);
    }

    MUTEX_UNLOCK();

    return corebuf ? *corebuf : 0;
}


/**
 * @brief Change receive and transmit modes
 *
 * Sets the receive mode to @em rx_cmd and the transmit mode to @em tx_cmd.
 *
 * @param      drv           valid emac32 driver pointer
 * @param      rx_cmd        receive mode (see RX_CMD register documentation)
 * @param      tx_cmd        transmit mode (see TX_CMD register documentation)
 *
 * @return     Nothing.
 */
extern void emac32_setmode(emac32_t * restrict drv, uint32_t rx_cmd, uint32_t tx_cmd)
{
    MUTEX_LOCK(drv->mutex);

    // reset EMAC
    EMAC32_RX_CMD(drv->baseaddress)    = 0;
    EMAC32_TX_CMD(drv->baseaddress)    = 0;

    drv->rx_cmd = rx_cmd;
    drv->tx_cmd = tx_cmd;

    EMAC32_RX_CMD(drv->baseaddress)    = rx_cmd;
    EMAC32_TX_CMD(drv->baseaddress)    = tx_cmd;

    MUTEX_UNLOCK();
}


/**
 * @brief Set MAC address
 *
 * Set a new MAC address as given in the buffer @em mac.
 *
 * @param      drv           valid emac32 driver pointer
 * @param      mac           6-byte array with new receiver MAC address
 *
 * @return     Nothing.
 */
extern void emac32_setmac(emac32_t * restrict drv, const uint8_t *mac)
{
    uint32_t rx_cmd_org = EMAC32_RX_CMD(drv->baseaddress);

    if (rx_cmd_org & EMAC32_RX_CMD_ENABLE)
    {
        // MAC changes are only accepted when receiver is inactive
        EMAC32_RX_CMD(drv->baseaddress) = 0;
        while (EMAC32_RX_STATUS(drv->baseaddress) & EMAC32_RX_STATUS_BUSY) {}
    }

    // set MAC address
    EMAC32_RX_MAC1(drv->baseaddress) = ((uint32_t) mac[0] << 24) | (((uint32_t) mac[1]) << 16) |
                                        (((uint32_t) mac[2]) << 8) | (((uint32_t) mac[3]) << 0);
    EMAC32_RX_MAC2(drv->baseaddress) = ((uint32_t) mac[4] << 8) | (((uint32_t) mac[5]) << 0);

    EMAC32_RX_CMD(drv->baseaddress) = rx_cmd_org;

    memcpy(drv->mac, mac, MAC_SIZE);
}


/**
 * @brief Get MAC address
 *
 * Copy the current MAC address to the buffer @em mac.
 *
 * @param      drv           valid emac32 driver pointer
 * @param      mac           pointer to 6-byte array where current MAC address will be stored
 *
 * @return     Nothing.
 */
extern void emac32_getmac(emac32_t * restrict drv, uint8_t *mac)
{
    memcpy(mac, drv->mac, MAC_SIZE);
}


/**
 * @brief Open the driver
 *
 * Open an instance of the driver. This function must be called once before any other
 * driver function can be used.
 *
 * @param      id    valid drv id
 *
 * @return     driver pointer if ok, otherwise NULL
 */
extern emac32_t *emac32_open(int id)
{
    assert((id >= 0) && (id < DRV_EMAC32_INSTANCE_COUNT));

    emac32_t * restrict drv = &drv_table[id];
    drv_emac32_cfg_instance_t * restrict drv_cfg = &drv_emac32_instance_table[id];
    per_emac32_cfg_instance_t * restrict per_cfg = &per_emac32_instance_table[drv_cfg->per_emac32];

#if MUTEXES
    if (driver->mutexes)
    {
        pthread_mutexattr_t mutexattr;

        pthread_mutexattr_init(&mutexattr);

        pthread_mutex_init(&drv->tx_mutex, &mutexattr);
        pthread_mutex_init(&drv->rx_mutex, &mutexattr);
    }
#endif

    // copy driver configuration needed to driver
    memcpy(drv->mac, drv_cfg->mac, MAC_SIZE);

    drv->tx_cmd             = drv_cfg->tx_cmd;
#if __POSIX_KERNEL__
    drv->tx_wait_mode = drv_cfg->tx_wait_mode;
#else
    drv->tx_blocking      = drv_cfg->tx_blocking;
#endif
#if TX_KERNEL_WAIT_SLEEP
    drv->tx_wait_sleepms      = drv_cfg->tx_wait_sleepms;
#endif

    drv->rx_cmd             = drv_cfg->rx_cmd;
#if __POSIX_KERNEL__
    drv->rx_wait_mode = drv_cfg->rx_wait_mode;
#else
    drv->rx_blocking      = drv_cfg->rx_blocking;
#endif
#if RX_KERNEL_WAIT_SLEEP
    drv->rx_wait_sleepms      = drv_cfg->rx_wait_sleepms;
#endif

    // copy peripheral configuration needed to driver
    assert(per_cfg->baseaddress != 0);
    drv->baseaddress = per_cfg->baseaddress;
    drv->interrupt   = per_cfg->interrupt0;

    // reset EMAC
    EMAC32_TX_CMD(drv->baseaddress)    = EMAC32_TX_CMD_RESET;
    EMAC32_RX_CMD(drv->baseaddress)    = EMAC32_RX_CMD_RESET;
    EMAC32_MDI_CMD(drv->baseaddress)   = EMAC32_MDI_CMD_RESET;
    EMAC32_TX_CMD(drv->baseaddress)    = 0;
    EMAC32_RX_CMD(drv->baseaddress)    = 0;
    EMAC32_MDI_CMD(drv->baseaddress)   = 0;

    // set MAC address
    EMAC32_RX_MAC1(drv->baseaddress) =  ((uint32_t) drv->mac[0] << 24) | (((uint32_t) drv->mac[1]) << 16) |
                                         (((uint32_t) drv->mac[2]) << 8) | (((uint32_t) drv->mac[3]) << 0);
    EMAC32_RX_MAC2(drv->baseaddress) =  ((uint32_t) drv->mac[4] << 8) | (((uint32_t) drv->mac[5]) << 0);

    // set external buffer registers
    EMAC32_TX_START(drv->baseaddress)  = (int32_t) drv_cfg->tx_buffer;
    EMAC32_TX_END(drv->baseaddress)    = (int32_t) drv_cfg->tx_buffer + (drv_cfg->tx_buffer_size << 2) - 4;
    EMAC32_TX_INPUT(drv->baseaddress)  = (int32_t) drv_cfg->tx_buffer;
    EMAC32_TX_OUTPUT(drv->baseaddress) = (int32_t) drv_cfg->tx_buffer;
    EMAC32_RX_START(drv->baseaddress)  = (int32_t) drv_cfg->rx_buffer;
    EMAC32_RX_END(drv->baseaddress)    = (int32_t) drv_cfg->rx_buffer + (drv_cfg->rx_buffer_size << 2) - 4;
    EMAC32_RX_INPUT(drv->baseaddress)  = (int32_t) drv_cfg->rx_buffer;
    EMAC32_RX_OUTPUT(drv->baseaddress) = (int32_t) drv_cfg->rx_buffer;

    EMAC32_TX_INT(drv->baseaddress)    = 0;
    EMAC32_RX_INT(drv->baseaddress)    = 0;

#if INTERRUPT_POSIX
    if (drv->tx_wait_mode == DRV_EMAC32_TX_WAIT_MODE_NOTIFY)
    {
        // driver uses interrupt notification to a thread, use pal interrupt with posix support
        // register transmit handler last so it runs first
        drv->tx_notify_count = 0;
        drv->rx_notify = 0;
        interrupt_set_posix(drv->interrupt, true);
        interrupt_register(drv->interrupt, (void*) drv, rx_handler);
        interrupt_register(drv->interrupt, (void*) drv, tx_handler);
        interrupt_notify(drv->interrupt, true);
        interrupt_configure(drv->interrupt, EDGE_RISING);
        interrupt_enable(drv->interrupt);

        EMAC32_TX_INT(drv->baseaddress) = EMAC32_TX_INT_FRAMESENT |
                                          EMAC32_TX_INT_EMPTY |
                                          EMAC32_TX_INT_COLLISION |
                                          EMAC32_TX_INT_LENGTH;

        EMAC32_RX_INT(drv->baseaddress) = EMAC32_RX_INT_FRAMEOK |
                                          EMAC32_RX_INT_OVERFLOW |
                                          EMAC32_RX_INT_LACKOFSPACE;
    }
    else
#endif
    {
#if INTERRUPT_NATIVE
        // driver only uses interrupt to reset error conditions, use native interrupt
        interrupt_register_native(drv->interrupt, (void*) drv, handler_native);
        interrupt_configure(drv->interrupt, EDGE_RISING);
        interrupt_enable(drv->interrupt);

        EMAC32_TX_INT(drv->baseaddress) = EMAC32_TX_INT_EMPTY |
                                          EMAC32_TX_INT_COLLISION |
                                          EMAC32_TX_INT_LENGTH;

        EMAC32_RX_INT(drv->baseaddress) = EMAC32_RX_INT_OVERFLOW |
                                          EMAC32_RX_INT_LACKOFSPACE;
#endif
    }

    EMAC32_TX_CMD(drv->baseaddress) = drv->tx_cmd;
    EMAC32_RX_CMD(drv->baseaddress) = drv->rx_cmd;

    return drv;
}


