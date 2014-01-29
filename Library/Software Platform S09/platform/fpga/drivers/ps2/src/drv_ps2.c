/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
\*****************************************************************************/

/**
 * @file drv_ps2.h
 *
 * @brief
 *      PS/2 driver
 *
 * This driver for the PS2_W peripheral provides low level access to a PS/2
 * controller. For access to mouse or keyboard devices, higher level
 * interfaces are available.
 *
 * Requires: <a href="per_ps2.chm::/index.htm">PS/2 peripheral</a>.
 *
 * For a detailed description of the PS2_W peripheral, see the Core
 * Reference <a href="CR0109 PS2 Controller.PDF">PS2 Controller</a>.
 */

#include <sysutils.h>
#include <assert.h>
#include <pal.h>
#include <interrupts.h>
#include <per_ps2.h>
#include <drv_ps2.h>
#include "drv_ps2_internal.h" // also contains definition of struct ps2_s
#include "drv_ps2_cfg_instance.h"

static ps2_t ps2_table[DRV_PS2_INSTANCE_COUNT];

/*
 * Interrupt handling
 */

// native interrupt handler
__INTERRUPT_NATIVE void drv_ps2_interrupt_native_handler(void)
{
    uint8_t intr = interrupt_get_current();
    ps2_t *ps2_dev = interrupt_native_context(intr);
    size_t next;

    next = ps2_dev->head + 1;

    /* wrap if necessary */
    if (next == ps2_dev->buffer_size)
    {
        next = 0;
    }
    /* update buffer */
    if (next != ps2_dev->tail)
    {
        ps2_dev->buffer[ps2_dev->head] = PS2_DATA(ps2_dev->base);
        ps2_dev->head = next;
    }

    interrupt_acknowledge(intr);

    /* notification callback */
    if (ps2_dev->interrupt_notify)
    {
        // enable interrupts to allow callback to send ps2 commands // this is probably prone to errors -- JH
        interrupts_enable();
        ps2_dev->interrupt_notify(ps2_dev, ps2_dev->user_data);
    }
}

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize the PS/2 controller
 *
 * This function initializes the PS/2 controller and registers the interrupt
 * handler.
 *
 * @param id
 *      Driver id (defined in devices.h)
 *
 * @return
 *      The ps2 driver pointer for the specified device.
 */
extern ps2_t *ps2_open(int id)
{
    ps2_t *ps2_dev;
    drv_ps2_cfg_instance_t *cfg;
    per_ps2_cfg_instance_t *per_cfg;
#if ( DRV_PS2_INSTANCE_USE_MUTEX_TRUE_USED )
    pthread_mutexattr_t mutexattr;
#endif

    assert(id >= 0 && id < DRV_PS2_INSTANCE_COUNT);
    ps2_dev = &ps2_table[id];
    cfg = &drv_ps2_instance_table[id];
    per_cfg = &per_ps2_instance_table[cfg->per_ps2];

    assert(per_cfg->baseaddress != 0);
    ps2_dev->base = per_cfg->baseaddress;
    ps2_dev->buffer = cfg->buffer;
    ps2_dev->buffer_size = (size_t)cfg->buffer_size;
    ps2_dev->head = 0;
    ps2_dev->tail = 0;
    ps2_dev->interrupt_notify = NULL;
    ps2_dev->user_data = NULL;

#if ( DRV_PS2_INSTANCE_USE_MUTEX_TRUE_USED )
# if ( DRV_PS2_INSTANCE_USE_MUTEX_FALSE_USED )
    ps2_dev->use_mutex = cfg->use_mutex;
    if ( ps2_dev->use_mutex )
    {
# endif
        pthread_mutexattr_init( &mutexattr );
        pthread_mutex_init( &ps2_dev->mutex, &mutexattr );
# if ( DRV_PS2_INSTANCE_USE_MUTEX_FALSE_USED )
    }
# endif
#endif

    interrupt_register_native(per_cfg->interrupt0, (void *)ps2_dev, drv_ps2_interrupt_native_handler);
    interrupt_configure(per_cfg->interrupt0, EDGE_RISING);
    interrupt_enable(per_cfg->interrupt0);

    return ps2_dev;
}

/**
 * @brief
 *      Install an interrupt callback
 *
 * Install a callback function @em interrupt_callback that will be called after
 * a byte has been received by the PS/2 controller. In addition you can specify
 * a pointer to a data object @em user_data which is passed as the second
 * argument to the callback function. If the callback function does not need to
 * access any data, pass a NULL pointer instead.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 * @param interrupt_callback
 *      Callback function, or NULL to disable the interrupt callback
 * @param user_data
 *      Data to be accessed by the callback handler, or NULL
 *
 * @return
 *      Nothing.
 */
extern void ps2_install_interrupt_callback(ps2_t *ps2_dev,
                                           void (*interrupt_callback)(ps2_t *ps2_dev, void *data),
                                           void *user_data)
{
    ps2_dev->interrupt_notify = interrupt_callback;
    ps2_dev->user_data = user_data;
}

/**
 * @brief
 *      Send a single byte to the PS/2 controller
 *
 * This function waits until the controller is ready and then sends the
 * specified byte @em val.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 * @param val
 *      Byte value to send
 *
 * @return
 *      0 if successful, -1 otherwise.
 *
 * @see
 *      ps2_getchar
 */
extern int ps2_putchar(ps2_t *ps2_dev, uint8_t val)
{
    /* NOTE: no need for mutex: busy check takes care of locking */
    return ps2_put_byte(ps2_dev, val);
}

/**
 * @brief
 *      Read a single byte from the PS/2 buffer
 *
 * This function reads one byte from the PS/2 driver buffer if there is data
 * available. Note that unlike <code>ps2_putchar()</code> this function uses
 * buffered data.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 *
 * @return
 *      Byte value, or -1 if no data is available.
 *
 * @see
 *      ps2_putchar
 */
extern int ps2_getchar(ps2_t *ps2_dev)
{
    int retval;
    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2_dev);
    retval = ps2_timed_get_byte(ps2_dev);
    PS2_MUTEX_UNLOCK(ps2_dev);

    return retval;
}

/**
 * @brief
 *      Get the number of bytes in the PS/2 buffer
 *
 * Check how many bytes are still available for reading in the PS/2 buffer.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 *
 * @return
 *      The number of bytes in the buffer.
 */
extern int ps2_available_bytes(ps2_t *ps2_dev)
{
    int bytes;

    bytes = ps2_dev->head - ps2_dev->tail;
    if (bytes < 0)
    {
        bytes += ps2_dev->buffer_size;
    }
    return bytes;
}

/**
 * @brief
 *      Reset the PS/2 buffer
 *
 * Empty the PS/2 buffer and discard any data currently available.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 *
 * @return
 *      Nothing.
 */
extern void ps2_reset_buffer(ps2_t *ps2_dev)
{
    ps2_dev->tail = ps2_dev->head;
}

/**
 * @brief
 *      Check if the PS/2 buffer is full
 *
 * Check if the PS/2 buffer is currently full. This means bytes that were
 * received from the device, may have been lost.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 *
 * @return
 *      True when buffer is full, false otherwise.
 */
extern bool ps2_check_buffer_full(ps2_t *ps2_dev)
{
    size_t next = ps2_dev->head + 1;
    if (next == ps2_dev->buffer_size)
    {
        next = 0;
    }
    return (ps2_dev->tail == next);
}

/**
 * @brief
 *      Read bytes from the PS/2 buffer until specified byte found
 *
 * This function continuously reads a byte from the PS/2 buffer until the
 * requested value @em val is received or a fixed timeout is reached.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 * @param val
 *      byte value to wait for
 *
 * @return
 *      The requested byte value, or -1 if there was a timeout.
 */
extern int ps2_waitfor(ps2_t *ps2_dev, uint8_t val)
{
    int retval;

    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2_dev);
    retval = ps2_wait_for_byte(ps2_dev, val);
    PS2_MUTEX_UNLOCK(ps2_dev);

    return retval;
}

/**
 * @brief
 *      Wait while PS/2 device is busy
 *
 * This functions waits while the PS/2 controller is busy or until a fixed
 * timeout is reached.
 *
 * @param ps2_dev
 *      ps2 driver pointer
 *
 * @return
 *      0 if the controller is available again, or -1 if there was a timeout.
 */
extern int ps2_wait_until_not_busy(ps2_t *ps2_dev)
{
    /* NOTE: no need for mutex */
    return ps2_busywait(ps2_dev);
}
