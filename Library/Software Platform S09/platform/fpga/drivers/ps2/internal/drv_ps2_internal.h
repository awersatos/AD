/*****************************************************************************
|*
|* Copyright:   Copyright (c) 2008, Altium
|*
|* Description: Internal interface for higher level drivers. This interface
|*              provides access to the driver mutex and the non-protected
|*              implementation of PS/2 driver functionality.
|*
\*****************************************************************************/

#ifndef _DRV_PS2_INTERNAL_H
#define _DRV_PS2_INTERNAL_H

#include <stdint.h>
#include <stdbool.h>

#include <sysutils.h>
#include <timing.h>
#include <per_ps2.h>
#include <drv_ps2.h>
#include "drv_ps2_cfg_instance.h"

#define PS2_TIMEOUT_MS          500
#define PS2_READ_TIMEOUT_MS     10

struct ps2_s
{
    uintptr_t base;
    uint8_t *buffer;
    size_t buffer_size;
    volatile size_t head;
    size_t tail;
    void (*interrupt_notify)(ps2_t *ps2_dev, void *user_data);
    void *user_data;
#if __POSIX_KERNEL__
    int wait_mode;
# if DRV_PS2_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
# endif
#endif
#if ( DRV_PS2_INSTANCE_USE_MUTEX_TRUE_USED )
# if ( DRV_PS2_INSTANCE_USE_MUTEX_FALSE_USED )
    bool use_mutex;
# endif
    pthread_mutex_t mutex;
#endif
};


inline void threadwait(ps2_t * restrict drv)
{
#if __POSIX_KERNEL__
#if DRV_PS2_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_PS2_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
#endif
#if DRV_PS2_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_PS2_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
#if DRV_PS2_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_PS2_WAIT_MODE_SLEEP)
    {
        struct timespec ts = { 0, drv->wait_sleepms * 1000 * 1000 };

        nanosleep (&ts, NULL);
    }
    else
#endif
    { /* never reached */ }
#else
    // without RTOS
    __nop();
#endif
}


// wait for busy flag to clear
inline int ps2_busywait(ps2_t *ps2_dev)
{
    uint64_t start_mark = clock_ms();

    do
    {
        if (!(PS2_CTRL(ps2_dev->base) & PS2_CTRL_BUSY_FLAG))
        {
            return 0;
        }
        threadwait(ps2_dev);
    }
    while (elapsed_time_ms(start_mark) < PS2_TIMEOUT_MS);

    return -1;
}

// read one byte
inline int ps2_get_byte(ps2_t *ps2_dev)
{
    int retval = -1;

    if (ps2_dev->head != ps2_dev->tail)
    {
        retval = ps2_dev->buffer[ps2_dev->tail++] & 0xFF;
        /* wrap buffer */
        if (ps2_dev->tail == ps2_dev->buffer_size)
        {
            ps2_dev->tail = 0;
        }
    }
    return retval;
}

// read one byte with timeout
inline int ps2_timed_get_byte(ps2_t *ps2_dev)
{
    int retval = -1;
    uint64_t start_mark;

    start_mark = clock_ms();
    do
    {
        retval = ps2_get_byte(ps2_dev);
        if (retval != -1)
        {
            break;
        }
        threadwait(ps2_dev);
    }
    while (elapsed_time_ms(start_mark) < PS2_READ_TIMEOUT_MS);

    return retval;
}

// wait for specific response
inline int ps2_wait_for_byte(ps2_t *ps2_dev, uint8_t val)
{
    int retval = -1;
    uint64_t start_mark;

    start_mark = clock_ms();
    do
    {
        if (ps2_get_byte(ps2_dev) == val)
        {
            retval = val;
            break;
        }
        threadwait(ps2_dev);
    }
    while (elapsed_time_ms(start_mark) < PS2_TIMEOUT_MS);

    return retval;
}

// write one byte
inline int ps2_put_byte(ps2_t *ps2_dev, uint8_t val)
{
    int retval = -1;

    if (ps2_busywait(ps2_dev) == 0)
    {
        PS2_CTRL(ps2_dev->base) = 0x00;
        PS2_DATA(ps2_dev->base) = val;
        PS2_CTRL(ps2_dev->base) |= PS2_CTRL_STROBE_FLAG;
        retval = 0;
        ps2_busywait(ps2_dev);
    }

    return retval;
}

// mutex support
#if ( DRV_PS2_INSTANCE_USE_MUTEX_TRUE_USED )
# if ( DRV_PS2_INSTANCE_USE_MUTEX_FALSE_USED )

# define PS2_MUTEX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(ps2_mutex_buffer)
# define PS2_MUTEX_LOCK(ps2_dev)        if (ps2_dev->use_mutex) { POSIX_DEV_MUTEX_LOCK(&ps2_dev->mutex, ps2_mutex_buffer); }
# define PS2_MUTEX_UNLOCK(ps2_dev)      if (ps2_dev->use_mutex) { POSIX_DEV_MUTEX_UNLOCK(&ps2_dev->mutex, ps2_mutex_buffer); }

# else

# define PS2_MUTEX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(ps2_mutex_buffer)
# define PS2_MUTEX_LOCK(ps2_dev)        POSIX_DEV_MUTEX_LOCK(&ps2_dev->mutex, ps2_mutex_buffer)
# define PS2_MUTEX_UNLOCK(ps2_dev)      POSIX_DEV_MUTEX_UNLOCK(&ps2_dev->mutex, ps2_mutex_buffer)

# endif
#else

# define PS2_MUTEX_PREPARE()            do {} while (0)
# define PS2_MUTEX_LOCK(ps2_dev)        do {} while (0)
# define PS2_MUTEX_UNLOCK(ps2_dev)      do {} while (0)

#endif

#if ( __POSIX_KERNEL__ != 0 && DRV_PS2_USE_MUTEX )
#else
#endif

#endif /* _DRV_PS2_INTERNAL_H */
