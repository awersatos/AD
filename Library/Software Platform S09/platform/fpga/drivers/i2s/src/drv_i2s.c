/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        I2S peripheral device driver.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver for WB_I2S peripheral.
 */

#include <assert.h>
#include <pal.h>
#include <interrupts.h>
#include <per_i2s.h>
#include <drv_i2s.h>

#include "drv_i2s_cfg_instance.h"

// runtime driver data
struct i2s_s
{
    uintptr_t           base_addr;
    int32_t             *tx_buffer;
    uint32_t            tx_buffer_size;
    int32_t             tx_buffer_head;
    volatile int32_t    tx_buffer_tail;
    int32_t             *rx_buffer;
    uint32_t            rx_buffer_size;
    volatile int32_t    rx_buffer_head;
    int32_t             rx_buffer_tail;
    uint16_t            hw_fifo_size;
    bool                stereo_output;
    bool                stereo_input;
    uint8_t             wordwidth;
    uint8_t             revision;
};

// runtime driver table
static i2s_t drv_table[DRV_I2S_INSTANCE_COUNT];

// native interrupt handler
static void __INTERRUPT_NATIVE i2s_isr(void);

/**
 * @brief set prescaler for specified sample rate and clcok frequency
 *
 * This function caluclates and sets the prescaler value for the specified
 * samplerate and clock frequency.
 *
 * @param   i2s_drv         device pointer obtained from the i2s_open routine
 * @param   samplerate      sample rate
 * @param   clock_frequency clock frequency
 *
 * @return  none
 */
void i2s_calculate_and_set_prescaler(i2s_t * restrict i2s_drv, uint32_t samplerate, uint32_t clock_frequency)
{
    i2s_set_prescaler(i2s_drv, (uint8_t)((((clock_frequency / 128) / samplerate) + 1) / 2));
}


/**
 * @brief Open an instance of the driver
 *
 * This function initializes both an I2S core and its driver.
 * You should call it only once per driver instance id.
 *
 * @param id
 *          Valid driver id (defined in devices.h)
 *
 * @return  Driver pointer if successful initialization, NULL otherwise.
 */
i2s_t * i2s_open(int id)
{
    assert((id >= 0) && (id < DRV_I2S_INSTANCE_COUNT));

    i2s_t * restrict drv = &drv_table[id];
    // get configuration of driver (created by plugin system)
    drv_i2s_cfg_instance_t * restrict drv_cfg = &drv_i2s_instance_table[id];
    // get configuration of peripheral below driver (created by plugin system)
    per_i2s_cfg_instance_t * restrict per_cfg = &per_i2s_instance_table[drv_cfg->per_i2s];

    // copy driver configuration data to driver table
    drv->tx_buffer      = drv_cfg->tx_buffer;
    drv->tx_buffer_size = drv_cfg->tx_buffer_size & ~1;     // make even
    drv->rx_buffer      = drv_cfg->rx_buffer;
    drv->rx_buffer_size = drv_cfg->rx_buffer_size & ~1;     // make even
    drv->stereo_output  = (drv_cfg->tx_mode == 0);
    drv->stereo_input   = (drv_cfg->rx_mode == 0);
    drv->wordwidth      = drv_cfg->quantization;

    // copy peripheral configuration data to driver table
    assert(per_cfg->baseaddress != 0);
    drv->base_addr      = per_cfg->baseaddress;

    // software ring buffers init
    drv->tx_buffer_head = 0;
    drv->tx_buffer_tail = 0;
    drv->rx_buffer_head = 0;
    drv->rx_buffer_tail = 0;

    // set-up and cache hardware registers based on configuration

    I2S_MODE(per_cfg->baseaddress) = 0;
    I2S_MODE(per_cfg->baseaddress) = drv_cfg->quantization | drv_cfg->tx_mode | drv_cfg->rx_mode;

    drv->revision = (I2S_STATUS(per_cfg->baseaddress) >> 8) & 0xFF;

    if (drv->revision == 0)
    {
        // small legacy built-in FIFO buffer
        drv->hw_fifo_size = 32;
    }
    else
    {
        // HW FIFO size equals 1k, 2k, 4k, or 8k
        drv->hw_fifo_size = 1 << (I2S_STATUS(per_cfg->baseaddress) >> 16);
    }

    // We may get a revision other than 0 with a 32-words HW FIFO
    // so check on size here in stead of on revision
    if (drv->hw_fifo_size == 32)
    {
        // small legacy built-in FIFO buffer (32 words)
        // make sure software buffer sizes are non-zero
        if(drv->tx_buffer_size < 32)
        {
            drv->tx_buffer_size = 32;
        }
        if(drv->rx_buffer_size < 32)
        {
            drv->rx_buffer_size = 32;
        }
    }

    i2s_set_watermark(drv, drv_cfg->watermark);

    i2s_calculate_and_set_prescaler(drv, drv_cfg->samplerate, pal_freq_hz());

    if ((drv->tx_buffer_size != 0) || (drv->rx_buffer_size != 0))
    {
        // driver has a software buffer, use native interrupt
        interrupt_register_native(per_cfg->wm_interrupt, (void*) drv, i2s_isr);
        interrupt_configure(per_cfg->wm_interrupt, LEVEL_HIGH);
        interrupt_enable(per_cfg->wm_interrupt);

        if (drv->tx_buffer_size != 0)
        {
            I2S_MODE(per_cfg->baseaddress) |= I2S_ENABLE_TX_INT;
        }
        if (drv->rx_buffer_size != 0)
        {
            I2S_MODE(per_cfg->baseaddress) |= I2S_ENABLE_RX_INT;
        }
    }

    return drv;
}

/**
 * @brief write a number of 8 bit samples. This function is non-blocking, use i2s_tx_avail() first!
 *
 * @param   i2s_drv         device pointer obtained from the i2s_open routine
 * @param   buffer          start address of buffer with samples, starting with left channel
 * @param   n               number of samples
 *
 * @return  None
 */
void i2s_write8(i2s_t * restrict i2s_drv, int8_t * buffer, unsigned int n)
{
    unsigned int i = 0;
    unsigned int next;
    uint8_t  shift = i2s_drv->wordwidth - 8;

    if (n == 0) return;

    if (i2s_drv->tx_buffer_size > 0)
    {
        // to align in stereo mode, skip first sample if odd tx_buffer index
        if (i2s_drv->stereo_output)
        {
            if ((i2s_drv->tx_buffer_head % 2) != 0)
            {
                i++;
            }
        }

        while (i < n)
        {
            next = i2s_drv->tx_buffer_head + 1;
            if (next == i2s_drv->tx_buffer_size )
            {
                next = 0;
            }
            i2s_drv->tx_buffer[i2s_drv->tx_buffer_head] = ((int32_t)buffer[i++]) << shift;
            i2s_drv->tx_buffer_head = next;
        }

        I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_TX_INT;
    }
    else
    {
        // to align in stereo mode, skip first sample if odd TX FIFO head pointer
        if (i2s_drv->stereo_output)
        {
            if (I2S_TX_POINTERS(i2s_drv->base_addr) & 0x1)
            {
                i++;
            }
        }

        while (i < n)
        {
            I2S_DATA(i2s_drv->base_addr) = ((int32_t)buffer[i++]) << shift;
        }
    }
}

/**
 * @brief   read a number of 8 bit samples, starting with left channel. This function is non-blocking, use i2s_rx_avail() first!
 *
 * @param   i2s_drv     device pointer (obtained from the i2s_open routine)
 * @param   buffer      start address of buffer for samples
 * @param   n           number of requested samples
 *
 * @return  None
 */
void i2s_read8(i2s_t * restrict i2s_drv, int8_t * buffer, unsigned int n)
{
    unsigned int i = 0;
    uint8_t shift = i2s_drv->wordwidth - 8;

    if (n == 0) return;

    if (i2s_drv->rx_buffer_size > 0)
    {
        // align in stereo mode, skip first sample if odd rx_buffer index
        if (i2s_drv->stereo_input && ((i2s_drv->rx_buffer_tail % 2) != 0))
        {
            i2s_drv->rx_buffer_tail++;
            if (i2s_drv->rx_buffer_tail == i2s_drv->rx_buffer_size)
            {
                i2s_drv->rx_buffer_tail = 0;
            }
        }

        while (i < n)
        {
            buffer[i++] = (int8_t)((i2s_drv->rx_buffer[i2s_drv->rx_buffer_tail++]) >> shift);
            if (i2s_drv->rx_buffer_tail == i2s_drv->rx_buffer_size)
            {
                i2s_drv->rx_buffer_tail = 0;
            }
        }

        I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_RX_INT;
    }
    else
    {
        // to align in stereo mode, skip first sample if odd RX FIFO tail pointer
        if (i2s_drv->stereo_input)
        {
            if (I2S_RX_POINTERS(i2s_drv->base_addr) & 0x10000)
            {
                I2S_DATA(i2s_drv->base_addr);
            }
        }
        while(i < n)
        {
            buffer[i++] = (int8_t)(I2S_DATA(i2s_drv->base_addr) >> shift);
        }
    }
}


/**
 * @brief write a number of 16 bit samples. This function is non-blocking, use i2s_tx_avail() first!
 *
 * @param   i2s_drv         device pointer obtained from the i2s_open routine
 * @param   buffer          start address of buffer with samples, starting with left channel
 * @param   n               number of samples
 *
 * @return  None
 */
void i2s_write16(i2s_t * restrict i2s_drv, int16_t * buffer, unsigned int n)
{
    unsigned int i = 0;
    unsigned int next;
    uint8_t  shift = i2s_drv->wordwidth - 16;

    if (n == 0) return;

    if (i2s_drv->tx_buffer_size > 0)
    {
        // to align in stereo mode, skip first sample if odd tx_buffer index
        if (i2s_drv->stereo_output)
        {
            if ((i2s_drv->tx_buffer_head % 2) != 0)
            {
                i++;
            }
        }

        while (i < n)
        {
            next = i2s_drv->tx_buffer_head + 1;
            if (next == i2s_drv->tx_buffer_size )
            {
                next = 0;
            }
            i2s_drv->tx_buffer[i2s_drv->tx_buffer_head] = buffer[i++] << shift;
            i2s_drv->tx_buffer_head = next;
        }

        I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_TX_INT;
    }
    else
    {
        // to align in stereo mode, skip first sample if odd TX FIFO head pointer
        if (i2s_drv->stereo_output)
        {
            if (I2S_TX_POINTERS(i2s_drv->base_addr) & 0x1)
            {
                i++;
            }
        }

        while (i < n)
        {
            I2S_DATA(i2s_drv->base_addr) = buffer[i++] << shift;
        }
    }
}


/**
 * @brief   read a number of 16 bit samples, starting with left channel. This function is non-blocking, use i2s_rx_avail() first!
 *
 * @param   i2s_drv     device pointer (obtained from the i2s_open routine)
 * @param   buffer      start address of buffer for samples
 * @param   n           number of requested samples
 *
 * @return  None
 */
void i2s_read16(i2s_t * restrict i2s_drv, int16_t * buffer, unsigned int n)
{
    unsigned int i = 0;
    uint8_t shift = i2s_drv->wordwidth - 16;

    if (n == 0) return;

    if (i2s_drv->rx_buffer_size > 0)
    {
        // align in stereo mode, skip first sample if odd rx_buffer index
        if (i2s_drv->stereo_input && ((i2s_drv->rx_buffer_tail % 2) != 0))
        {
            i2s_drv->rx_buffer_tail++;
            if (i2s_drv->rx_buffer_tail == i2s_drv->rx_buffer_size)
            {
                i2s_drv->rx_buffer_tail = 0;
            }
        }

        while (i < n)
        {
            buffer[i++] = (int16_t)((i2s_drv->rx_buffer[i2s_drv->rx_buffer_tail++]) >> shift);
            if (i2s_drv->rx_buffer_tail == i2s_drv->rx_buffer_size)
            {
                i2s_drv->rx_buffer_tail = 0;
            }
        }

        I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_RX_INT;
    }
    else
    {
        // to align in stereo mode, skip first sample if odd RX FIFO tail pointer
        if (i2s_drv->stereo_input)
        {
            if (I2S_RX_POINTERS(i2s_drv->base_addr) & 0x10000)
            {
                I2S_DATA(i2s_drv->base_addr);
            }
        }
        while(i < n)
        {
            buffer[i++] = (int16_t)(I2S_DATA(i2s_drv->base_addr) >> shift);
        }
    }
}


/**
 * @brief   write a number of 32 bit samples. This function is non-blocking, use i2s_tx_avail() first!
 *
 * @param   i2s_drv         device pointer obtained from the i2s_open routine
 * @param   buffer          start address of buffer with samples, starting with left channel
 * @param   n               number of samples
 *
 * @return  None
 */
void i2s_write32(i2s_t * restrict i2s_drv, int32_t * buffer, unsigned int n)
{
    unsigned int i = 0;
    unsigned int next;

    if (n == 0) return;

    if(i2s_drv->tx_buffer_size > 0)
    {
        // to align in stereo mode, skip first sample if odd tx_buffer index
        if (i2s_drv->stereo_output)
        {
            if ((i2s_drv->tx_buffer_head % 2) != 0)
            {
                i++;
            }
        }

        while (i < n)
        {
            next = i2s_drv->tx_buffer_head + 1;
            if (next == i2s_drv->tx_buffer_size )
            {
                next = 0;
            }
            i2s_drv->tx_buffer[i2s_drv->tx_buffer_head] = buffer[i++];
            i2s_drv->tx_buffer_head = next;
        }

        I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_TX_INT;
    }
    else
    {
        // to align in stereo mode, skip first sample if odd TX FIFO head pointer
        if (i2s_drv->stereo_output)
        {
            if (I2S_TX_POINTERS(i2s_drv->base_addr) & 0x1)
            {
                i++;
            }
        }

        while(i < n)
        {
            I2S_DATA(i2s_drv->base_addr) = buffer[i++];
        }
    }
}


/**
 * @brief   read a number of 32 bit samples, starting with left channel. This function is non-blocking, use i2s_rx_avail() first!
 *
 * @param   i2s_drv     device pointer (obtained from the i2s_open routine)
 * @param   buffer      start address of buffer for samples
 * @param   n           number of requested samples
 *
 * @return  None
 */
extern void i2s_read32(i2s_t * restrict i2s_drv, int32_t * buffer, unsigned int n)
{
    unsigned int i = 0;

    if (n == 0) return;

    if (i2s_drv->rx_buffer_size > 0)
    {
        // align in stereo mode, skip first sample if odd rx_buffer index
        if (i2s_drv->stereo_input && ((i2s_drv->rx_buffer_tail % 2) != 0))
        {
            i2s_drv->rx_buffer_tail++;
            if (i2s_drv->rx_buffer_tail == i2s_drv->rx_buffer_size)
            {
                i2s_drv->rx_buffer_tail = 0;
            }
        }

        while (i < n)
        {
            buffer[i++] = i2s_drv->rx_buffer[i2s_drv->rx_buffer_tail++];
            if (i2s_drv->rx_buffer_tail == i2s_drv->rx_buffer_size)
            {
                i2s_drv->rx_buffer_tail = 0;
            }
        }

        I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_RX_INT;
    }
    else
    {
        // to align in stereo mode, skip first sample if odd RX FIFO tail pointer
        if (i2s_drv->stereo_input)
        {
            if (I2S_RX_POINTERS(i2s_drv->base_addr) & 0x10000)
            {
                I2S_DATA(i2s_drv->base_addr);
            }
        }
        while(i < n)
        {
            buffer[i++] = I2S_DATA(i2s_drv->base_addr);
        }
    }
}


/**
 * @brief   get the number of samples that can be written to the transmit buffer
 *
 * @param   i2s_drv     device pointer (obtained from the i2s_open routine)
 *
 * @return  available space in transmit buffer
 */
unsigned int i2s_tx_avail(i2s_t * restrict i2s_drv)
{
    unsigned int retval;
    uint32_t tx_pointers;

    if (i2s_drv->tx_buffer_size > 0)
    {
        /* Software buffer, if (head == tail) then empty */
        retval = i2s_drv->tx_buffer_size + i2s_drv->tx_buffer_tail - i2s_drv->tx_buffer_head;
        if (retval > i2s_drv->tx_buffer_size)
        {
            retval -= i2s_drv->tx_buffer_size;
        }
        retval = retval - 1;  // minus 1 to make sure head will not bite in tail
    }
    else
    {
        /* Hardware buffer, if (head == tail) then full */
        tx_pointers = I2S_TX_POINTERS(i2s_drv->base_addr);
        retval = i2s_drv->hw_fifo_size + (tx_pointers >> 16) - (tx_pointers & 0xFFFF);
        if(retval >= i2s_drv->hw_fifo_size)
        {
            retval -= i2s_drv->hw_fifo_size;
        }
    }
    if ( i2s_drv->stereo_output ) retval &= ~0x01;  // In stereo, we don't support an odd number of samples!
    return retval;
}


/**
 * @brief   get the number of samples that are available in the receive buffer
 *
 * @param   i2s_drv     device pointer (obtained from the i2s_open routine)
 *
 * @return  number of samples that can be read from receive buffer
 */
unsigned int i2s_rx_avail(i2s_t * restrict i2s_drv)
{
    unsigned int retval;
    uint32_t rx_pointers;

    if (i2s_drv->rx_buffer_size > 0)
    {
        /* Software buffer, if (head == tail) then empty */
        retval = i2s_drv->rx_buffer_size + i2s_drv->rx_buffer_head - i2s_drv->rx_buffer_tail;
        if (retval >= i2s_drv->rx_buffer_size)
        {
            retval -= i2s_drv->rx_buffer_size;
        }
    }
    else
    {
        /* Hardware buffer, if (head == tail) then full */
        rx_pointers = I2S_RX_POINTERS(i2s_drv->base_addr);
        retval = i2s_drv->hw_fifo_size + (rx_pointers & 0xFFFF) - (rx_pointers >> 16);
        if (retval > i2s_drv->hw_fifo_size)
        {
            retval -= i2s_drv->hw_fifo_size;
        }
        retval = retval - 1;  // minus 1 because head points to next empty slot
    }
    if ( i2s_drv->stereo_input ) retval &= ~0x01;  // In stereo, we don't support an odd number of samples!
    return retval;
}


/**
 * @brief   start transmit
 *
 * @param   i2s_drv     device pointer
 *
 * @return  None
 */
void i2s_tx_start(i2s_t * restrict i2s_drv)
{
    I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_TX;
}


/**
 * @brief   stop transmit
 *
 * @param   i2s_drv     device pointer
 *
 * @return  None
 */
void i2s_tx_stop(i2s_t * restrict i2s_drv)
{
    I2S_MODE(i2s_drv->base_addr) &= ~I2S_ENABLE_TX;
}


/**
 * @brief   start receiver
 *
 * @param   i2s_drv     device pointer
 *
 * @return  None
 */
void i2s_rx_start(i2s_t * restrict i2s_drv)
{
    I2S_MODE(i2s_drv->base_addr) |= I2S_ENABLE_RX;
}


/**
 * @brief   stop receiver
 *
 * @param   i2s_drv     device pointer
 *
 * @return  None
 */
void i2s_rx_stop(i2s_t * restrict i2s_drv)
{
    I2S_MODE(i2s_drv->base_addr) &= ~I2S_ENABLE_RX;
}


/**
 * @brief   native interrupt handler
 */
static void __INTERRUPT_NATIVE i2s_isr(void)
{
    uint32_t intr = interrupt_get_current();
    i2s_t * i2s_drv = interrupt_native_context(intr);
    uintptr_t base_addr = i2s_drv->base_addr;

    int32_t *buffer;
    int32_t buffer_fixed;
    int32_t buffer_index;
    uint32_t buffer_size;
    uint32_t watermark;
    uint32_t next;
    int i, i_max;

    if (i2s_drv->revision == 0)
    {
        watermark = (I2S_CONTROL(base_addr) & 0xFF00) >> 8;
    }
    else
    {
        watermark = (I2S_CONTROL(base_addr) & 0xFFFF0000) >> 16;
    }

    i_max = i2s_drv->hw_fifo_size - watermark;  /* max nr of samples to copy to/from hardware buffer */

    /* transmitter needs new samples? */
    if ((I2S_STATUS(base_addr) & I2S_FIFO_OUT_WATERMARK) != 0)
    {
        // help the compiler a bit
        buffer = i2s_drv->tx_buffer;
        buffer_size = i2s_drv->tx_buffer_size;
        buffer_fixed = i2s_drv->tx_buffer_head;
        buffer_index = i2s_drv->tx_buffer_tail;  /* copy the volatile */

        if ((I2S_STATUS(base_addr) & I2S_FIFO_OUT_LR) != 0)
        {
            buffer_index |= 1;
        }
        for (i = 0; i < i_max; i++)
        {
            if (buffer_index == buffer_fixed)
            {
                // software buffer underflow, disable transmitter interrupt
                I2S_MODE(base_addr) &= ~I2S_ENABLE_TX_INT;
                break;
            }
            I2S_DATA(base_addr) = buffer[buffer_index++];
            if (buffer_index == buffer_size)
            {
                buffer_index = 0;
            }
        }
        i2s_drv->tx_buffer_tail = buffer_index;  /* store the volatile */
    }

    /* receiver has new samples? */
    if ((I2S_STATUS(base_addr) & I2S_FIFO_IN_WATERMARK) != 0)
    {
        // help the compiler a bit
        buffer = i2s_drv->rx_buffer;
        buffer_size = i2s_drv->rx_buffer_size;
        buffer_fixed = i2s_drv->rx_buffer_tail;
        buffer_index = i2s_drv->rx_buffer_head;  /* copy the volatile */

        if ((I2S_STATUS(base_addr) & I2S_FIFO_IN_LR) != 0)
        {
            buffer_index |= 1;
        }
        for (i = 0; i < i_max; i++)
        {
            next = buffer_index + 1;
            if (next == buffer_size)
            {
                next = 0;
            }
            if (next == buffer_fixed)
            {
                // don't read next (head will bite in tail!)
                // software buffer overflow, disable receiver interrupt
                I2S_MODE(base_addr) &= ~I2S_ENABLE_RX_INT;
                break;
            }
            buffer[buffer_index] = I2S_DATA(base_addr);
            buffer_index = next;
        }

        i2s_drv->rx_buffer_head = buffer_index;  /* store the volatile */
    }

    interrupt_acknowledge(intr);
}


/**
 * @brief set prescaler
 *
 * @param   i2s_drv         device pointer
 * @param   value           prescaler value
 *
 * @return  none
 */
void i2s_set_prescaler(i2s_t * restrict i2s_drv, uint8_t value)
{
    uint32_t    control;

    // clear prescaler, backup watermark
    if (i2s_drv->revision == 0)
    {
        control = I2S_CONTROL(i2s_drv->base_addr) & 0xFF00;
    }
    else
    {
        control = I2S_CONTROL(i2s_drv->base_addr) & 0xFFFF0000;
    }

    if (value > 1)
    {
        if (i2s_drv->revision == 0)
        {
            control |= 0x10000 | value;
        }
        else
        {
            control |= 0x08000 | value;
        }
    }

    // set prescaler, restore watermark
    I2S_CONTROL(i2s_drv->base_addr) = control;
}


/**
 * @brief   set watermark
 *
 * @param   i2s_drv         device pointer
 * @param   value           new watermark value
 *
 * @return  none
 */
void i2s_set_watermark(i2s_t * restrict i2s_drv, uint16_t value)
{
    uint32_t    control;

    if (value >= i2s_drv->hw_fifo_size)
    {
        value = 0;
    }

    // clear watermark, backup prescaler
    if (i2s_drv->revision == 0)
    {
        control = I2S_CONTROL(i2s_drv->base_addr) & 0x100FF;
        control |= value << 8;
    }
    else
    {
        control = I2S_CONTROL(i2s_drv->base_addr) & 0x0000FFFF;
        control |= (uint32_t)value << 16;
    }

    // set watermark, restore prescaler
    I2S_CONTROL(i2s_drv->base_addr) = control;
}


/**
 * @brief   set word width
 *
 * This function sets the word width, which can only be set if both
 * transmitter and receiver are disabled.
 *
 * @param   i2s_drv         device pointer obtained from the i2s_open routine
 * @param   wwidth          new word width
 *
 * @return  true:   ok,
 *          false:  new wordt width could not be set
 */
bool i2s_set_wwidth(i2s_t * restrict i2s_drv, i2s_wwidth_t wwidth)
{
    uint32_t    mode_reg;

    // clear wwidth
    mode_reg = I2S_MODE(i2s_drv->base_addr) & ~I2S_WWIDTH;

    if (((mode_reg & I2S_ENABLE_TX) == 0) && ((mode_reg & I2S_ENABLE_RX) == 0))
    {
        mode_reg |= wwidth;
        I2S_MODE(i2s_drv->base_addr) = mode_reg;
        i2s_drv->wordwidth = (uint8_t)wwidth;
        return true;
    }
    else
    {
        return false;
    }
}


/**
 * @brief   get current word width
 *
 * @param   i2s_drv         device pointer
 *
 * @return  current word width
 */
i2s_wwidth_t i2s_get_wwidth(i2s_t * restrict i2s_drv)
{
    return i2s_drv->wordwidth;
}


/**
 * @brief   set word justification
 *
 * This function sets the word justification. It can only be used when both
 * transmitter and receiver are disabled.
 *
 * @param   i2s_drv         device pointer
 * @param   wjust           word justification
 *
 * @return  true:   ok,
 *          false:  new word justification could not be set
 */
bool i2s_set_wjust(i2s_t * restrict i2s_drv, i2s_wjust_t wjust)
{
    uint32_t    mode_reg;

    // clear wjust
    mode_reg = I2S_MODE(i2s_drv->base_addr) & 0xFFFE7FFF;

    if (((mode_reg & I2S_ENABLE_TX) == 0) && ((mode_reg & I2S_ENABLE_RX) == 0))
    {
        mode_reg |= (uint32_t)wjust << 15;
        I2S_MODE(i2s_drv->base_addr) = mode_reg;
        return true;
    }
    else
    {
        return false;
    }
}


/**
 * @brief   set output mode
 *
 * This function sets the output mode (stereo/mono). It can only be used when
 * both transmitter and receiver are disabled.
 *
 * @param   i2s_drv         device pointer
 * @param   mode            stereo/mone mode
 *
 * @return  true:   ok,
 *          false:  new output mode could not be set
 */
bool i2s_set_output_mode(i2s_t * restrict i2s_drv, i2s_output_t mode)
{
    uint32_t    mode_reg;

    mode_reg = I2S_MODE(i2s_drv->base_addr) & ~I2S_MONO_OUT;

    if (((mode_reg & I2S_ENABLE_TX) == 0) && ((mode_reg & I2S_ENABLE_RX) == 0))
    {
        if (mode == I2S_MONO_OUTPUT)
        {
            mode_reg |= I2S_MONO_OUT;
            i2s_drv->stereo_output = false;
        }
        else
        {
            i2s_drv->stereo_output = true;
        }
        I2S_MODE(i2s_drv->base_addr) = mode_reg;
        return true;
    }
    else
    {
        return false;
    }
}


/**
 * @brief   set input mode
 *
 * This function sets the input mode for the device. It can only be used when
 * both receiver and transmitter are disabled.
 *
 * @param   i2s_drv         device pointer
 * @param   mode            input mode
 *
 * @return  true:   ok,
 *          false:  input mode could not be set
 */
bool i2s_set_input_mode(i2s_t * restrict i2s_drv, i2s_input_t mode)
{
    uint32_t    mode_reg;

    mode_reg = I2S_MODE(i2s_drv->base_addr) & ~(I2S_MONO_IN | I2S_MONO_IN_LR);

    if (((mode_reg & I2S_ENABLE_TX) == 0) && ((mode_reg & I2S_ENABLE_RX) == 0))
    {
        if (mode == I2S_MONO_INPUT_LEFT)
        {
            mode_reg |= I2S_MONO_IN;
            i2s_drv->stereo_input = false;
        }
        else if (mode == I2S_MONO_INPUT_RIGHT)
        {
            mode_reg |= I2S_MONO_IN | I2S_MONO_IN_LR;
            i2s_drv->stereo_input = false;
        }
        else
        {
            i2s_drv->stereo_input = true;
        }
        I2S_MODE(i2s_drv->base_addr) = mode_reg;
        return true;
    }
    else
    {
        return false;
    }
}
