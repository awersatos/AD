#ifndef _DRV_EMAC32_INTERNAL_H
#define _DRV_EMAC32_INTERNAL_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <per_emac32.h>
#include <drv_emac32.h>
#include <time.h>

#include <swp_ifconfig.h>

#include "per_emac32_cfg_instance.h"
#include "drv_emac32_cfg_instance.h"

/* constants */

#define MAC_SIZE        6
#define MAX_DATA_SIZE   1500
#define MAX_FRAME_SIZE  MAX_DATA_SIZE + 14

/* PHY constants */

#define RTL8201_SPD_SET             (1 << 13)
#define RTL8201_DUPLEX_MODE         (1 << 8)
#define RTL8201_AUTO_NEG_COMPLETE   (1 << 5)
#define RTL8201_LINK_STATUS         (1 << 2)
#define RTL8201_JABBER_DETECT       (1 << 1)

#define DUPLEX_MODE_UPDATE_INTERVAL (2 * PAL_CLOCKHZ)


/*
 * Configuration
 */

// (blocking) waiting modes
// if none are defined, waiting mode is NOP for both no kernel and kernel
// NOTE: different instances may use different blocking modes, so all may be defined independently
//-----------------------------------------------------------------------------
#undef TX_NOKERNEL_WAIT_NOP     // use __nop()
#undef TX_KERNEL_WAIT_NOP       // use __nop()
#undef TX_KERNEL_WAIT_NOTIFY    // use pthread_notify
#undef TX_KERNEL_WAIT_SLEEP     // use nanosleep
#undef TX_KERNEL_WAIT_YIELD     // use yield
#undef TX_WAIT_ALWAYS_BLOCK

#undef RX_NOKERNEL_WAIT_NOP     // use __nop()
#undef RX_KERNEL_WAIT_NOP       // use __nop()
#undef RX_KERNEL_WAIT_NOTIFY    // use pthread_notify
#undef RX_KERNEL_WAIT_SLEEP     // use nanosleep
#undef RX_KERNEL_WAIT_YIELD     // use yield
#undef RX_WAIT_ALWAYS_BLOCK
//-----------------------------------------------------------------------------

// interrupt handlers
// NOTE: different instances may have different handler types, so both may be defined
//-----------------------------------------------------------------------------
#undef INTERRUPT_POSIX          // posix interrupts
#undef INTERRUPT_NATIVE         // native interrupts
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// TX blocking modes and interrupt handling
//-----------------------------------------------------------------------------
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

#else // no kernel (single threaded)

# if DRV_EMAC32_INSTANCE_TX_BLOCKING_FALSE_USED
#  define TX_NOKERNEL_WAIT_NOP 1
# endif
# define INTERRUPT_NATIVE 1

#endif

// always blocking behavior:
// no defines or only TX_KERNEL_WAIT_NOP
#if !defined(TX_NOKERNEL_WAIT_NOP)  && \
    !defined(TX_KERNEL_WAIT_NOTIFY) && \
    !defined(TX_KERNEL_WAIT_SLEEP)  && \
    !defined(TX_KERNEL_WAIT_YIELD)
# define TX_WAIT_ALWAYS_BLOCK 1
#endif
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// RX blocking modes and interrupt handling
//-----------------------------------------------------------------------------
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

#else // no kernel (single threaded)

# if DRV_EMAC32_INSTANCE_RX_BLOCKING_FALSE_USED
#  define RX_NOKERNEL_WAIT_NOP 1
# endif
# define INTERRUPT_NATIVE 1

#endif

// always blocking behavior:
// no defines or only RX_KERNEL_WAIT_NOP
#if !defined(RX_NOKERNEL_WAIT_NOP)  && \
    !defined(RX_KERNEL_WAIT_NOTIFY) && \
    !defined(RX_KERNEL_WAIT_SLEEP)  && \
    !defined(RX_KERNEL_WAIT_YIELD)
# define RX_WAIT_ALWAYS_BLOCK 1
#endif
//-----------------------------------------------------------------------------

// NOTE: For thread notification we need two handlers for one hardware interrupt,
//       so we check here if the interrupt configuration supports that.
#if INTERRUPT_POSIX
#include "interrupts_cfg.h"
#if (INTERRUPTS_ISR_MAX < 2)
#error "Thread notification needs support for multiple interrupt handlers"
#endif
#endif

//-----------------------------------------------------------------------------
// Mutexes
//-----------------------------------------------------------------------------
#undef USE_MUTEX
#if ( DRV_EMAC32_INSTANCE_USE_MUTEX_TRUE_USED != 0 )
# define USE_MUTEX   1
# if ( DRV_EMAC32_INSTANCE_USE_MUTEX_FALSE_USED != 0 ) // conditional mutexes
// TX
#  define EMAC32_TX_MUTEX_PREPARE()          POSIX_DEV_MUTEX_PREPARE(emac32_tx_mutex_buffer)
#  define EMAC32_TX_MUTEX_LOCK(emac32_dev)   if (emac32_dev->use_mutex) POSIX_DEV_MUTEX_LOCK(&emac32_dev->tx_mutex, emac32_tx_mutex_buffer)
#  define EMAC32_TX_MUTEX_UNLOCK(emac32_dev) if (emac32_dev->use_mutex) POSIX_DEV_MUTEX_UNLOCK(&emac32_dev->tx_mutex, emac32_tx_mutex_buffer)
// RX
#  define EMAC32_RX_MUTEX_PREPARE()          POSIX_DEV_MUTEX_PREPARE(emac32_rx_mutex_buffer)
#  define EMAC32_RX_MUTEX_LOCK(emac32_dev)   if (emac32_dev->use_mutex) POSIX_DEV_MUTEX_LOCK(&emac32_dev->rx_mutex, emac32_rx_mutex_buffer)
#  define EMAC32_RX_MUTEX_UNLOCK(emac32_dev) if (emac32_dev->use_mutex) POSIX_DEV_MUTEX_UNLOCK(&emac32_dev->rx_mutex, emac32_rx_mutex_buffer)
# else // unconditional mutexes
// TX
#  define EMAC32_TX_MUTEX_PREPARE()          POSIX_DEV_MUTEX_PREPARE(emac32_tx_mutex_buffer)
#  define EMAC32_TX_MUTEX_LOCK(emac32_dev)   POSIX_DEV_MUTEX_LOCK(&emac32_dev->tx_mutex, emac32_tx_mutex_buffer)
#  define EMAC32_TX_MUTEX_UNLOCK(emac32_dev) POSIX_DEV_MUTEX_UNLOCK(&emac32_dev->tx_mutex, emac32_tx_mutex_buffer)
// RX
#  define EMAC32_RX_MUTEX_PREPARE()          POSIX_DEV_MUTEX_PREPARE(emac32_rx_mutex_buffer)
#  define EMAC32_RX_MUTEX_LOCK(emac32_dev)   POSIX_DEV_MUTEX_LOCK(&emac32_dev->rx_mutex, emac32_rx_mutex_buffer)
#  define EMAC32_RX_MUTEX_UNLOCK(emac32_dev) POSIX_DEV_MUTEX_UNLOCK(&emac32_dev->rx_mutex, emac32_rx_mutex_buffer)
# endif

#else // no mutexes

// TX
# define EMAC32_TX_MUTEX_PREPARE()          do {} while (0)
# define EMAC32_TX_MUTEX_LOCK(emac32_dev)   do {} while (0)
# define EMAC32_TX_MUTEX_UNLOCK(emac32_dev) do {} while (0)
// TX
# define EMAC32_RX_MUTEX_PREPARE()          do {} while (0)
# define EMAC32_RX_MUTEX_LOCK(emac32_dev)   do {} while (0)
# define EMAC32_RX_MUTEX_UNLOCK(emac32_dev) do {} while (0)

#endif

//-----------------------------------------------------------------------------
/* END Configuration defines */

typedef struct __packed__
{
    uint32_t size;
    uint8_t destmac[MAC_SIZE];
    uint8_t sourcemac[MAC_SIZE];
    uint16_t type;
} emac32_buf_t;

struct emac32_s
{
    uint32_t        ident;
    void            *(*get_ifconfig)(void *);
    ifconfig_t      ifconfig;
    uint8_t mac[MAC_SIZE];
    uintptr_t baseaddress;
    uint8_t interrupt;
    uint8_t phy;
    uint8_t (*linkstatus)(emac32_t * drv);
    clock_t next_duplex_check;

    // TX
    uint32_t tx_cmd;
#if __POSIX_KERNEL__
    int tx_wait_mode;
# if TX_KERNEL_WAIT_SLEEP
    uint32_t tx_wait_sleepms;
# endif
# if INTERRUPT_POSIX
    volatile int tx_notify_count;
# endif
#else // no kernel
    bool tx_blocking;
#endif

    // RX
    uint32_t rx_cmd;
#if __POSIX_KERNEL__
    int rx_wait_mode;
# if RX_KERNEL_WAIT_SLEEP
    uint32_t rx_wait_sleepms;
# endif
# if INTERRUPT_POSIX
    volatile bool rx_notify;
# endif
#else // no kernel
    bool rx_blocking;
#endif

#if USE_MUTEX
# if DRV_EMAC32_INSTANCE_USE_MUTEX_FALSE_USED
    bool use_mutex;
# endif
    pthread_mutex_t tx_mutex;
    pthread_mutex_t rx_mutex;
#endif
};

// initialize and connect interrupt handlers
extern void emac32_connect_interrupts(const emac32_t * restrict drv);

// transmit:
// - emac32_transmit_getbuffer() : reserve buffer for data of specified size
// - *fill buffer*
// - emac32_txbuffer_send() : let emac core send the data
extern uint32_t * emac32_transmit_getbuf(emac32_t * restrict drv, uint32_t size);
extern void emac32_txbuffer_send(emac32_t * restrict drv, uint32_t *corebuf);

// receive:
// - emac32_receive_getbuf() : get pointer to next packet in buffer (if any)
// - *use data*
// - emac32_rxbuffer_free() : release ownership and make space available to receive new packets
extern uint32_t * emac32_receive_getbuf(emac32_t * restrict drv);
extern void emac32_rxbuffer_free(const uintptr_t base, uint32_t *corebuf);

#ifdef __cplusplus
}
#endif

#endif /* _DRV_EMAC32_INTERNAL_H */
