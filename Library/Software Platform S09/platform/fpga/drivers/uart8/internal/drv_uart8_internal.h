#ifndef _DRV_UART8_INTERNAL_H
#define _DRV_UART8_INTERNAL_H

#define TXLOWMARK_DEFAULT     4
#define RXLOWMARK_DEFAULT     2
#define RXHIGHMARK_DEFAULT    8
#define RXDTO_DEFAULT         32

#define RX_STALLED_RESTART 16

// a few extra defines to improve readability

#define TX_INTERRUPT_NATIVE 1

// if none are defined, blocking mode is looping for both no kernel and kernel
#if __POSIX_KERNEL__

# if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NONE_USED
#  define TX_KERNEL_BLOCK_NONE 1
# endif
# if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_NOTIFY_USED
#  define TX_KERNEL_BLOCK_NOTIFY 1
#  undef TX_INTERRUPT_NATIVE
#  define TX_INTERRUPT_POSIX 1
# endif
# if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_POLL_USED
#  define TX_KERNEL_BLOCK_POLL 1
# endif
# if DRV_UART8_INSTANCE_TX_BLOCKING_MODE_YIELD_USED
#  define TX_KERNEL_BLOCK_YIELD 1
# endif

#else // __POSIX_KERNEL__

#define TX_INTERRUPT_NATIVE 1

# if DRV_UART8_INSTANCE_TX_BLOCKING_FALSE_USED
#  define TX_NOKERNEL_BLOCK_NONE 1
# endif

#endif // __POSIX_KERNEL__

#  define RX_INTERRUPT_NATIVE 1

// if none are defined, blocking mode is looping for both no kernel and kernel
#if __POSIX_KERNEL__

# if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NONE_USED
#  define RX_KERNEL_BLOCK_NONE 1
# endif
# if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_NOTIFY_USED
#  define RX_KERNEL_BLOCK_NOTIFY 1
#  undef RX_INTERRUPT_NATIVE
#  define RX_INTERRUPT_POSIX 1
# endif
# if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_POLL_USED
#  define RX_KERNEL_BLOCK_POLL 1
#  define RX_INTERRUPT_NATIVE 1
# endif
# if DRV_UART8_INSTANCE_RX_BLOCKING_MODE_YIELD_USED
#  define RX_KERNEL_BLOCK_YIELD 1
#  define RX_INTERRUPT_NATIVE 1
# endif

#else // __POSIX_KERNEL__

# if DRV_UART8_INSTANCE_RX_BLOCKING_FALSE_USED
#  define RX_NOKERNEL_BLOCK_NONE 1
# endif

#endif // __POSIX_KERNEL__


#if TX_INTERRUPT_NATIVE && (DRV_UART8_INSTANCE_TX_BUFFER_MAX == 0)
// no driver buffers: no interrupt support needed after all
#undef TX_INTERRUPT_NATIVE
#endif

#if RX_INTERRUPT_NATIVE && (DRV_UART8_INSTANCE_RX_BUFFER_MAX == 0)
// no driver buffers: no interrupt support needed after all
#undef RX_INTERRUPT_NATIVE
#endif

#if DRV_UART8_INSTANCE_HANDSHAKE_RTSSOFT_USED
// optionally use margin in RX buffer to handle handshaking
# define RTSSOFT 1
#endif


#if ((__POSIX_KERNEL__ != 0) && (DRV_UART8_INSTANCE_MUTEX_TRUE_USED != 0))

# define MUTEXES 1

#define UART8_MUTEXRX_PREPARE()                                         \
        POSIX_DEV_MUTEX_PREPARE(rxbuffer)
#define UART8_MUTEXRX_LOCK(drv)                                         \
        if ( drv->mutexes )   {                                         \
        POSIX_DEV_MUTEX_LOCK(&drv->rx_mutex, rxbuffer)                   \
    }
#define UART8_MUTEXRX_UNLOCK(drv)                                       \
        if ( drv->mutexes )                     {                       \
        POSIX_DEV_MUTEX_UNLOCK(&drv->rx_mutex,rxbuffer)                  \
    }

#define UART8_MUTEXTX_PREPARE()                                         \
        POSIX_DEV_MUTEX_PREPARE(txbuffer)
#define UART8_MUTEXTX_LOCK(drv)                                         \
        if ( drv->mutexes )   {                                         \
        POSIX_DEV_MUTEX_LOCK(&drv->tx_mutex, txbuffer)                   \
    }
#define UART8_MUTEXTX_UNLOCK(drv)                                       \
        if ( drv->mutexes )   {                                         \
        POSIX_DEV_MUTEX_UNLOCK(&drv->tx_mutex,txbuffer)                  \
    }

#else

#define UART8_MUTEXRX_PREPARE()
#define UART8_MUTEXRX_LOCK(drv)
#define UART8_MUTEXRX_UNLOCK(drv)
#define UART8_MUTEXTX_PREPARE()
#define UART8_MUTEXTX_LOCK(drv)
#define UART8_MUTEXTX_UNLOCK(drv)

#endif


// runtime driver properties
struct uart8_drv_s
{
    int handshake;

    int tx_head;
    volatile int tx_tail;
    volatile int tx_break;
    uint8_t tx_break_duration;
    volatile bool tx_busy;
#if __POSIX_KERNEL__
    int tx_blocking_mode;
# if TX_KERNEL_BLOCK_POLL
    uint32_t tx_pollmscs;
# endif
# if TX_INTERRUPT_POSIX
    volatile int tx_notify_count;
# endif
#else
    bool tx_blocking;
#endif

    volatile int rx_head;
    volatile int rx_break;
    int rx_tail;
    volatile bool rx_stalled;
    int rx_margin;
#if __POSIX_KERNEL__
    int rx_blocking_mode;
# if RX_KERNEL_BLOCK_POLL
    uint32_t rx_pollmscs;
# endif
# if RX_INTERRUPT_POSIX
    volatile int rx_notify_count;
# endif
#else
    bool rx_blocking;
#endif

#if MUTEXES
    pthread_mutex_t tx_mutex;
    pthread_mutex_t rx_mutex;
    bool            mutexes;
#endif

    // workcopies from driver configuration
    uint8_t *tx_buffer;
    int tx_buffer_size;
#if TX_INTERRUPT_POSIX
    bool tx_notify;
#endif

    uint8_t *rx_buffer;
    int rx_buffer_size;
#if RX_INTERRUPT_POSIX
    bool rx_notify;
#endif

    // workcopies from configuration
    uint32_t baudrate;
    uintptr_t baseaddress;
    uint8_t tx_interrupt;
    uint8_t rx_interrupt;

};

extern int      uart8_putbreak_internal(uart8_t * restrict drv, uint8_t duration);
extern int      uart8_putchar_internal(uart8_t * restrict drv, int val);
extern int      uart8_getchar_internal(uart8_t * restrict drv);
extern void     uart8_set_baudrate_internal(uart8_t * restrict drv, uint32_t baudrate);
extern uint32_t uart8_get_baudrate_internal(uart8_t * restrict drv);


#endif
