/*
 *  COPYRIGHT:     Copyright (c) 2008, Altium
 *
 *  DESCRIPTION:   MAX1104 8-bit analog-to-digital/digital-to-analog converter
 */

#include <drv_max1104.h>
#include <drv_spi.h>
#include <drv_max1104_cfg_instance.h>
#include <pal.h>
#include <string.h>

struct _max1104_t
{
    spi_t               *spi;
    uint8_t             device_id;
    uint32_t            mode;
    bool                open;
#if ( __POSIX_KERNEL__ != 0 )
    pthread_mutex_t     mutex;
#endif
    int                 sample_rate;
    uint8_t             *rx_buffer;
    int                 rx_buffer_size;
    int                 rx_head;
    int                 rx_tail;
    int                 rx_overflow;
    uint8_t             *tx_buffer;
    int                 tx_buffer_size;
    int                 tx_head;
    int                 tx_tail;
    int                 tx_underflow;
    int                 tx_full;
    bool                running;
    bool                prevent_access;
    bool                delay_tick;
    void                *suspend_resume_data;
};

static struct _max1104_t max1104_table[DRV_MAX1104_INSTANCE_COUNT];

static inline void
begin_access(max1104_t *drv)
{
    drv->prevent_access = true;
}


static inline void
end_access(max1104_t *drv)
{
    drv->prevent_access = false;
    if (drv->delay_tick)
    {
        drv->delay_tick = false;
        drv_max1104_timer_handler(drv);
    }
}


static max1104_t *
drv_max1104_open_internal(int id)
{
    if (id < 0 || id >= DRV_MAX1104_INSTANCE_COUNT)
    {
        return NULL;
    }
    if (max1104_table[id].open == false)
    {
        memset(&max1104_table[id], 0, sizeof(max1104_table[id]));
        max1104_table[id].spi = spi_open(id);
        max1104_table[id].open = true;
        max1104_table[id].device_id = drv_max1104_instance_table[id].device_id;
        max1104_table[id].mode = drv_max1104_instance_table[id].mode;

#if ( __POSIX_KERNEL__ != 0 )
        pthread_mutex_init(&max1104_table[id].mutex, NULL);
#endif

        max1104_table[id].rx_buffer = drv_max1104_instance_table[id].rx_buffer;
        max1104_table[id].rx_buffer_size = drv_max1104_instance_table[id].rx_buffer_size;
        max1104_table[id].rx_head = 0;
        max1104_table[id].rx_tail = 0;

        max1104_table[id].tx_buffer = drv_max1104_instance_table[id].tx_buffer;
        max1104_table[id].tx_buffer_size = drv_max1104_instance_table[id].tx_buffer_size;
        max1104_table[id].tx_head = 0;
        max1104_table[id].tx_tail = 0;

    }
    return &max1104_table[id];
}


/**
 * @brief   open the specified max1104 device
 *
 * @param   id  id of the device to open
 *
 * @return  pointer to opened device or NULL when device could not be opened
 */
max1104_t *
drv_max1104_open(int id)
{
    if (id >= 0 && id < DRV_MAX1104_INSTANCE_COUNT)
    {
        max1104_t *drv;

        drv = drv_max1104_open_internal(id);
        if (drv != NULL)
        {
            drv_max1104_set_mode(drv, drv->mode);
        }

        return drv;
    }
    return NULL;
}


/**
 * @brief   open the specified max1104 device in the specified mode
 *
 *          Open the specified max1104 device in the specified mode, this routine can
 *          be used to open the device in a different mode than the mode that was
 *          specified in the SSAS configuration
 *
 * @param   id      id of the device to open
 * @param   mode    mode the start the device in
 *
 * @return  pointer to opened device or NULL when device could not be opened
 */
max1104_t *
drv_max1104_open_in_mode(int id, max1104_mode_t mode)
{
    max1104_t *drv;

    drv = drv_max1104_open_internal(id);
    if (drv != NULL)
    {
        drv_max1104_set_mode(drv, mode);
    }
    return drv;
}


/**
 * @brief   change the mode of the max1104 device
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 * @param   mode    device mode
 *
 * @return  0 success, -1 otherwise
 */
int
drv_max1104_set_mode(max1104_t *drv, max1104_mode_t mode)
{
    if (drv == NULL)
    {
        return -1;
    }

    spi_get_bus(drv->spi, drv->device_id);
    spi_cs_hi(drv->spi);   //Toggle CS high then low
    pal_delay_us(20);
    spi_cs_lo(drv->spi);
    pal_delay_us(20);
    switch(mode)
    {
        case Continuous_ADCDAC:
        case Continuous_ADC:
        case Continuous_DAC:
            spi_transceive8(drv->spi, (uint8_t)mode);
//            pal_delay_ms(1);
            break;
        default:
            break;
    }
    drv->mode = mode;
    spi_release_bus(drv->spi);
    return 0;
}


/**
 * @brief   close the device
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 *
 * @return  0 success, -1 otherwise
 */
int
drv_max1104_close(max1104_t *drv)
{
    if (drv != NULL)
    {
        spi_get_bus(drv->spi, drv->device_id);
        spi_cs_hi(drv->spi);
        spi_release_bus(drv->spi);
#if ( __POSIX_KERNEL__ != 0 )
        pthread_mutex_destroy(drv->mutex);
#endif
        drv->open = false;
        return 0;
    }
    return -1;
}


/**
 * @brief   enable or disable the adc and dac part of the device
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 * @param   enable_adc  new state for the adc part of the device
 * @param   enable_dac  new state for the dac part of the device
 *
 * @return  none
 */
void
drv_max1104_set_enabled(max1104_t *drv, bool enable_adc, bool enable_dac)
{
    uint8_t control;

    if (drv == NULL)
    {
        return;
    }

    control = (uint8_t)drv->mode;
    if (enable_adc)
    {
        control |= MAX1104_E1;
    }
    else
    {
        control &= ~MAX1104_E1;
    }
    if (enable_dac)
    {
        control |= MAX1104_E0;
    }
    else
    {
        control &= MAX1104_E0;
    }
    spi_get_bus(drv->spi, drv->device_id);
    spi_transmit8(drv->spi, control);
    spi_release_bus(drv->spi);
    drv->mode = control;
}

static int
drv_max1104_getc_internal(max1104_t *drv)
{
    int ret;

    switch (drv->mode)
    {
        case Continuous_ADCDAC:
        case Continuous_ADC:
            spi_get_bus(drv->spi, drv->device_id);
            ret = spi_received8(drv->spi);
            spi_release_bus(drv->spi);
            return ret;

        case Continuous_DAC:
        case Single_DAC:
            return -1;

        case Single_ADCDAC:
        case Single_ADC:
            spi_get_bus(drv->spi, drv->device_id);
            spi_transmit8(drv->spi, Single_ADC);
            pal_delay_us(36);
            ret = spi_transceive8(drv->spi, 0);
            spi_release_bus(drv->spi);
            return ret;

        default:
            // should not get here
            return -1;
    }
}


/**
 * @brief   read a character
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 *
 * @return  next character, -1 in case of error
 */
int
drv_max1104_getc(max1104_t *drv)
{
    int result = -1;
    if (drv != NULL)
    {
        if (drv->rx_buffer_size)
        {
            begin_access(drv);
            if (drv->rx_head != drv->rx_tail)
            {
                // read data from head of ringbuffer
                result = drv->rx_buffer[drv->rx_tail];
                if (drv->rx_tail + 1 >= drv->rx_buffer_size)
                {
                    drv->rx_tail = 0;
                }
                else
                {
                    drv->rx_tail = drv->rx_tail + 1;
                }
            }
            end_access(drv);
            return result;
        }
        else
        {
            return drv_max1104_getc_internal(drv);
        }
    }
    return -1;
}


static int
drv_max1104_putc_internal(int c, max1104_t *drv)
{
    switch (drv->mode)
    {
        case Continuous_ADCDAC:
        case Continuous_DAC:
            spi_get_bus(drv->spi, drv->device_id);
            spi_transmit8(drv->spi, (uint8_t)c);
            spi_release_bus(drv->spi);
            return 0;
        case Continuous_ADC:
        case Single_ADC:
            return -1;
        case Single_ADCDAC:
        case Single_DAC:
            spi_get_bus(drv->spi, drv->device_id);
            spi_transmit8(drv->spi, Single_DAC);
            while(spi_busy(drv->spi));
            spi_transmit8(drv->spi, (uint8_t)c);
            while(spi_busy(drv->spi));
            spi_release_bus(drv->spi);
            return 0;
        default:
            break;
    }
    return 0;
}


/**
 * @brief   write a character
 *
 * @param   c       character to write
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 *
 * @return  0 success, -1 error
 */
int
drv_max1104_putc(int c, max1104_t *drv)
{
    if (drv == NULL)
    {
        return -1;
    }
    if (drv->tx_buffer_size)
    {
        int next;

        begin_access(drv);

        next = drv->tx_head + 1;

        if (next >= drv->tx_buffer_size)
        {
            next = 0; // wrap
        }

        if (next == drv->tx_tail)
        {
            // driver buffer full
            drv->tx_full ++;
            end_access(drv);
            return -1;
        }
        else
        {
            // busy, put data in driver buffer
            drv->tx_head = next;
            drv->tx_buffer[next] = c & 0xFF;
            end_access(drv);
            return 0;
        }
    }
    else
    {
        return drv_max1104_putc_internal(c, drv);
    }
}


static int
get_next_tx(max1104_t *drv)
{
    int ret = 0;

    begin_access(drv);

    if (drv->tx_tail != drv->tx_head)
    {
        ret = drv->tx_buffer[drv->tx_tail];
        if (drv->tx_tail + 1 == drv->tx_buffer_size)
        {
            drv->tx_tail = 0;
        }
        else
        {
            drv->tx_tail = drv->tx_tail + 1;
        }
    }
    else
    {
        drv->tx_underflow++;
    }

    end_access(drv);

    return ret;
}


static int
put_next_rx(max1104_t *drv, int c)
{
    int ret = 0;

    begin_access(drv);

    if (drv->rx_head == drv->rx_tail - 1 || (drv->rx_tail == 0 && drv->rx_head + 1 == drv->rx_buffer_size))
    {
        /* buffer full */
        drv->rx_overflow ++;
        end_access(drv);
        return -1;
    }
    drv->rx_head = (drv->rx_head + 1 == drv->rx_buffer_size) ? 0 : drv->rx_head + 1;
    drv->rx_buffer[drv->rx_head] = (uint8_t)c;
    if (drv->rx_tail == -1)
    {
        drv->rx_tail = 0;
    }

    end_access(drv);

    return 0;
}


/**
 * @brief   next sample tick
 *
 *          Next sample tick, when the driver is used in buffered mode this
 *          routine should be called every sample interval
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 *
 * @return  none
 */
void
drv_max1104_timer_handler(max1104_t *drv)
{
    if (drv == NULL)
    {
        return;
    }
    if (drv->prevent_access)
    {
        drv->delay_tick = true;
    }
    else
    {
        switch (drv->mode)
        {
            case Continuous_ADCDAC:
                spi_get_bus(drv->spi, drv->device_id);
                put_next_rx(drv, spi_transceive8(drv->spi, get_next_tx(drv)));
                spi_release_bus(drv->spi);
                break;

            case Continuous_DAC:
                spi_get_bus(drv->spi, drv->device_id);
                spi_transmit8(drv->spi, get_next_tx(drv));
                spi_release_bus(drv->spi);
                break;

            case Continuous_ADC:
                spi_get_bus(drv->spi, drv->device_id);
                put_next_rx(drv, spi_transceive8(drv->spi, 0));
                spi_release_bus(drv->spi);
                break;
            default:
                __nop();
        }
    }
}


/**
 * @brief   see how how much free space there is in the transmit buffer
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 *
 * @return  number of bytes that can successfully be writen to the transmit buffer
 */
int
drv_max1104_rx_avail(max1104_t *drv)
{
    int     available = -1;

    if (drv != NULL && drv->rx_buffer_size)
    {
        begin_access(drv);
        available = drv->rx_head - drv->rx_tail;
        if (available < 0)
        {
            available += drv->rx_buffer_size;
        }
        end_access(drv);
    }
    return available;
}


/**
 * @brief   see how how much data there is in the receive buffer
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 *
 * @return  number of bytes that can successfully be read from the receive buffer
 */
int
drv_max1104_tx_avail(max1104_t *drv)
{
    int     available = -1;

    if (drv != NULL && drv->tx_buffer_size)
    {
        begin_access(drv);
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
        end_access(drv);
    }
    return available;
}


/**
 * @brief   read adc data
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 * @param   buf     where to store data
 * @param   nbyte   maximun number of byte to store in buffer
 *
 * @return  number of bytes stored in buffer
 */
int
drv_max1104_read(max1104_t *drv, void *buf, int nbyte)
{
    uint8_t *p = buf;
    int i, c;

    if (buf != NULL && nbyte > 0)
    {
        for (i = 0; i < nbyte; i++)
        {
            c = drv_max1104_getc(drv);
            if (c == -1)
            {
                __nop();
                break;
            }
            p[i] = (uint8_t)c;
        }
        return i;
    }
    return 0;
}


/**
 * @brief   write dac data
 *
 * @param   drv     driver pointer as returned from drv_max1104_open() or drv_max1104_open_in_mode()
 * @param   buf     buffer containing 8-bit output samples
 * @param   nbyte   maximun number of samples in buffer
 *
 * @return  number of samples used from buffer, -1 in case of error
 */
int
drv_max1104_write(max1104_t *drv, const void *buf, int nbyte)
{
    const uint8_t *p = buf;
    int i, c;

    if (buf != NULL && nbyte > 0)
    {
        for (i = 0; i < nbyte; i++)
        {
            c = drv_max1104_putc(p[i], drv);
            if (c == -1)
            {
                return i;
            }
        }
        return i;
    }
    return -1;
}

