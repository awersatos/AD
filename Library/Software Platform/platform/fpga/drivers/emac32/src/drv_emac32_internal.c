/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2010, Altium
|*
|*  Description:        EMAC32 driver internal interface: interrupts and
|*                      data transfer.
|*
\*****************************************************************************/

#if __POSIX_KERNEL__
# include <pthread.h>
#endif

#include <interrupts.h>
#include "drv_emac32_internal.h"
#include <pal.h>

/* Management Data Interface */

static void emac32_update_duplex_mode( emac32_t * restrict drv )
{
    bool full_duplex;

    full_duplex = drv->linkstatus(drv) & PHY_FULL_DUPLEX;
    if (!full_duplex && (drv->tx_cmd & EMAC32_TX_CMD_FULLDUPLEX))
    {
        drv->tx_cmd &= ~EMAC32_TX_CMD_FULLDUPLEX;
        EMAC32_TX_CMD(drv->baseaddress) = drv->tx_cmd;
    }
    else if (full_duplex && !(drv->tx_cmd & EMAC32_TX_CMD_FULLDUPLEX))
    {
        drv->tx_cmd |= EMAC32_TX_CMD_FULLDUPLEX;
        EMAC32_TX_CMD(drv->baseaddress) = drv->tx_cmd;
    }
}


/* ethernet packet */

// size is first field in packet
inline size_t corebuf_get_packet_size(const uint32_t * restrict corebuf)
{
    return ((*corebuf + 7 ) & ~3);
}

/* TX buffer */

// This function is used both for testing free space and actually reserving
// space for a new packet in the buffer.
static uint32_t *emac32_real_get_txbuffer(const uintptr_t base, int size, bool wrap)
{
    uint32_t input, output, start;

    size += 4; // reserve leading word to store packetsize
    size += 4; // reserve space for packetsize of next packet
    size = (size + 3) & ~3; // round up to 32-bit border

    input = EMAC32_TX_INPUT(base);
    output = EMAC32_TX_OUTPUT(base);
    if ( input >= output)
    {
        if ((input + size) < EMAC32_TX_END(base))
        {
            return (uint32_t *)input;
        }
        else
        {
            start = EMAC32_TX_START(base);
            if ((start + size) < output)
            {
                // wrap
                if (wrap)
                {
                    *(uint32_t *)input = 0;
                }
                return (uint32_t *)start;
            }
        }
    }
    else if ((input + size) < output)
    {
        return (uint32_t *)input;
    }

    return NULL;
}

// get address of empty packetbuffer to send data with given size
// use emac32_txbuffer_send() with same size to send it
static inline uint32_t *emac32_txbuffer(const uintptr_t base, int size)
{
    return emac32_real_get_txbuffer(base, size, true);
}

// test if packet of given size would fit in the packetbuffer
static inline bool emac32_txbuffer_test(const uintptr_t base, int size)
{
    return (emac32_real_get_txbuffer(base, size, false) != NULL);
}

/* RX buffer */

// This function is used both for testing data availability and actually
// claiming a packet to handle.
inline uint32_t *emac32_real_get_rxbuffer(const uintptr_t base, bool wrap)
{
    uint32_t *buf = (uint32_t*)EMAC32_RX_OUTPUT(base);
    uint32_t *input = (uint32_t*)EMAC32_RX_INPUT(base);

    if (buf == input) return NULL;

    // wrap if needed
    if (*buf == 0)
    {
        buf = (uint32_t*)EMAC32_RX_START(base);
        if (wrap)
        {
            EMAC32_RX_OUTPUT(base) = (uint32_t)buf;
        }
        if (buf == input) return NULL;
    }

    return buf;
}

// get address of oldest received packet,
// use emac32_rxbuffer_free() to release it
static uint32_t *emac32_rxbuffer(const uintptr_t base)
{
    return emac32_real_get_rxbuffer(base, true);
}

// test if there is data in the receive buffer
inline bool emac32_rxbuffer_test(const uintptr_t base)
{
    return (emac32_real_get_rxbuffer(base, false) != NULL);
}


/*
 * Interrupt handling
 */

static inline void clear_error_causes(const emac32_t * restrict drv)
{
    // clear error interrupt causes
    EMAC32_TX_STATUS(drv->baseaddress) = EMAC32_TX_STATUS_INT_COLLISION |
                                         EMAC32_TX_STATUS_INT_LENGTH    |
                                         EMAC32_TX_STATUS_INT_CHANGE;

    EMAC32_RX_STATUS(drv->baseaddress) = EMAC32_RX_STATUS_INT_OVERFLOW  |
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
#define TX_STATUS_NOTIFY_MASK   (EMAC32_TX_STATUS_INT_FRAMESENT | EMAC32_TX_STATUS_INT_EMPTY)
static uint32_t tx_handler(uint32_t num, void *arg)
{
    // acknowledge as soon as possible, so we can pick up newly pending interrupts
    interrupt_acknowledge(num);

    int retvalue = INTERRUPT_NOT_HANDLED;
    emac32_t * restrict drv = (emac32_t *)arg;
    int count = drv->tx_notify_count;

    if ((count != 0){

        if(EMAC32_TX_STATUS(drv->baseaddress) & EMAC32_TX_STATUS_INT_CHANGE){
            // Clear int
            EMAC32_TX_STATUS(drv->baseaddress) = EMAC32_TX_STATUS_INT_CHANGE;
            // Notify upper layer of state change
            ifconfig_link_state_callback(&drv->ifconfig, emac32_getlink(drv) & EMAC32_VALID_LINK?IFCONFIG_LINK_S_UP:IFCONFIG_LINK_S_DOWN);
        }


        if(EMAC32_TX_STATUS(drv->baseaddress) & TX_STATUS_NOTIFY_MASK)){
            // check if there is enough space
            if (emac32_txbuffer_test(drv->baseaddress, count))
            {
                retvalue = INTERRUPT_NOT_HANDLED | INTERRUPT_NOTIFY;
                drv->tx_notify_count = 0;
            }
        }
    }
    // clear causes
    EMAC32_TX_STATUS(drv->baseaddress) = TX_STATUS_NOTIFY_MASK;

    return retvalue;
}


// this handler must run second because it calls the common
// clear_error_causes()
static uint32_t rx_handler(uint32_t num, void *arg)
{
    int retvalue = INTERRUPT_HANDLED;
    emac32_t * restrict drv = (emac32_t *)arg;

    if (drv->rx_notify && (EMAC32_RX_STATUS(drv->baseaddress) & EMAC32_RX_STATUS_INT_FRAMEOK))
    {
        retvalue = INTERRUPT_HANDLED | INTERRUPT_NOTIFY;
        drv->rx_notify = false;
    }
    // clear causes
    EMAC32_RX_STATUS(drv->baseaddress) = EMAC32_RX_STATUS_INT_FRAMEOK;

    clear_error_causes(drv);

    return retvalue;
}

#endif

#if INTERRUPT_NATIVE

// native interrupt wrapper
__INTERRUPT_NATIVE void handler_native(void)
{
    int num = interrupt_get_current();
    emac32_t *drv;

    drv = (emac32_t *)interrupt_native_context(num);

    if(EMAC32_TX_STATUS(drv->baseaddress) & EMAC32_TX_STATUS_INT_CHANGE){
        // Clear int
        EMAC32_TX_STATUS(drv->baseaddress) = EMAC32_TX_STATUS_INT_CHANGE;
        // Notify upper layer of state change
        ifconfig_link_state_callback(&drv->ifconfig, emac32_linkstatus(drv) & PHY_VALID_LINK?IFCONFIG_LINK_S_UP:IFCONFIG_LINK_S_DOWN);
    }

    // acknowledge as soon as possible, so we can pick up newly pending interrupts
    interrupt_acknowledge(num);

    clear_error_causes(drv);
}

#endif

void emac32_connect_interrupts(const emac32_t * restrict drv)
{
    // interrupts
    EMAC32_TX_INT(drv->baseaddress) = 0;
    EMAC32_RX_INT(drv->baseaddress) = 0;

#if INTERRUPT_POSIX
    if (drv->tx_wait_mode == DRV_EMAC32_TX_WAIT_MODE_NOTIFY ||
        drv->rx_wait_mode == DRV_EMAC32_RX_WAIT_MODE_NOTIFY)
    {
        // NOTE: we need posix interrupts if either tx or rx handlers need
        //       thread notification.

        // handlers are called in reverse order of registration:
        // register transmit handler last so it runs first
        interrupt_set_posix(drv->interrupt, true);
        interrupt_register(drv->interrupt, (void*) drv, rx_handler);
        interrupt_register(drv->interrupt, (void*) drv, tx_handler);

        // NOTE: We enable EMAC32_TX_INT_EMPTY, EMAC32_TX_INT_FRAMESENT and EMAC32_RX_INT_FRAMEOK
        //       for posix handlers only, i.e. when thread notification is used.
        EMAC32_TX_INT(drv->baseaddress) = EMAC32_TX_INT_EMPTY       |
                                          EMAC32_TX_INT_FRAMESENT   |
                                          EMAC32_TX_INT_EMPTY       |
                                          EMAC32_TX_INT_COLLISION   |
                                          EMAC32_TX_INT_LENGTH      |
                                          EMAC32_TX_STATUS_INT_CHANGE;
        EMAC32_RX_INT(drv->baseaddress) = EMAC32_RX_INT_FRAMEOK     |
                                          EMAC32_RX_INT_OVERFLOW    |
                                          EMAC32_RX_INT_LACKOFSPACE;
    }
    else
#endif
    {
#if INTERRUPT_NATIVE
        // driver only uses interrupt to reset error conditions, use native interrupt
        interrupt_register_native(drv->interrupt, (void*) drv, handler_native);

        EMAC32_TX_INT(drv->baseaddress) = EMAC32_TX_INT_COLLISION   |
                                          EMAC32_TX_INT_LENGTH      |
                                          EMAC32_TX_STATUS_INT_CHANGE;
        EMAC32_RX_INT(drv->baseaddress) = EMAC32_RX_INT_OVERFLOW    |
                                          EMAC32_RX_INT_LACKOFSPACE;
#endif
    }
    // level interrupt: we must clear causes manually
    interrupt_configure(drv->interrupt, LEVEL_HIGH);
    interrupt_enable(drv->interrupt);
}


/* 
 * TX Buffer
 */

#if TX_KERNEL_WAIT_NOTIFY

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
    int err = 0;

    // tell interrupthandler how much we want
    drv->tx_notify_count = size;

    // associate, but thread can be interrupted before the association completes
    pthread_interrupt_associate(tx_interrupt, &tx_handler, (void*) drv);

    if (emac32_txbuffer_test(drv->baseaddress, size))
    {
        // enough free space after all, waiting not needed
        drv->tx_notify_count = 0;
        pthread_interrupt_disassociate(tx_interrupt, &tx_handler, (void*) drv);
    }
    else
    {
        err = pthread_interrupt_timedwait(NULL);
        pthread_interrupt_disassociate(tx_interrupt, &tx_handler, (void*) drv);
    }

    return err;
}

#endif /* TX_KERNEL_WAIT_NOTIFY */


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

/*****************************************************************************
|*
|*  Function:           emac32_transmit_getbuf
|*
|*  Parameters:         drv     : driver
|*                      size    : data size of packet buffer to allocate
|*
|*  Returns:            pointer to free corebuf or NULL
|*
|*  Description:        optionally blocking wrapper around emac32_txbuffer()
 */
uint32_t * emac32_transmit_getbuf(emac32_t * restrict drv, uint32_t size)
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

// send the buffer given by emac32_txbuffer()
void emac32_txbuffer_send(emac32_t * restrict drv, uint32_t *corebuf)
{
    if (pal_clock() > drv->next_duplex_check)
    {
        drv->next_duplex_check = pal_clock() + DUPLEX_MODE_UPDATE_INTERVAL;
        emac32_update_duplex_mode(drv);
    }
    EMAC32_TX_INPUT(drv->baseaddress) = ((uintptr_t) corebuf) + corebuf_get_packet_size(corebuf);
    EMAC32_TX_CMD(drv->baseaddress) |= EMAC32_TX_CMD_ENABLE;
}


/*
 * RX Buffer
 */

#if RX_KERNEL_WAIT_NOTIFY

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
    int err = 0;

    // tell interrupthandler we want a packet and wait for its notification
    drv->rx_notify = true;
    
    // associate, but thread can be interrupted before the association completes
    pthread_interrupt_associate(rx_interrupt, &rx_handler, (void*) drv);

    if (emac32_rxbuffer_test(drv->baseaddress))
    {
        // waiting packet after all, waiting not needed
        drv->rx_notify = false;
        pthread_interrupt_disassociate(rx_interrupt, &rx_handler, (void*) drv);
    }
    else
    {
        err = pthread_interrupt_timedwait(NULL);
        pthread_interrupt_disassociate(rx_interrupt, &rx_handler, (void*) drv);
    }

    return err;
}

#endif /* RX_KERNEL_WAIT_NOTIFY */


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



/*****************************************************************************
|*
|*  Function:           emac32_receive_getbuf
|*
|*  Parameters:         drv     : driver
|*
|*  Returns:            pointer to new received corebuf NULL
|*
|*  Description:        optionally blocking wrapper around emac32_rxbuffer()
 */
uint32_t * emac32_receive_getbuf(emac32_t * restrict drv)
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

// release oldest received packetbuffer as given by emac32_rxbuffer()
// (size must be as packetbuffer says)
void emac32_rxbuffer_free(const uintptr_t base, uint32_t *corebuf)
{
    EMAC32_RX_OUTPUT(base) += corebuf_get_packet_size(corebuf);
}


