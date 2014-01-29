/**
 * @file
 * Device driver for CS4270 24-bit, 192 kHz Stereo Audio CODEC
 *
 */

#include <assert.h>
#include <timing.h>
#include <drv_spi.h>
#include <drv_cs4270.h>

#include "drv_cs4270_cfg_instance.h"

// runtime driver data
struct cs4270_s
{
    spi_t *spi_master;
    uint8_t spi_slave_id;
};

// runtime driver table
static cs4270_t drv_table[DRV_CS4270_INSTANCE_COUNT];

#define CS4270_ADDRESS          0x9E
#define CS4270_WRITE            0x00
#define CS4270_READ             0x01

static void cs4270_change_begin (spi_t * spi_master);
static void cs4270_change_end   (spi_t * spi_master);
static void cs4270_spi_write    (spi_t * spi_master, uint8_t address, uint8_t data);
static uint8_t cs4270_spi_read  (spi_t * spi_master, uint8_t address);

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes both, the WB_SPI core and the CS4270 24-bit, 192 kHz Stereo Audio CODEC.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful initialized, NULL otherwise
 */
cs4270_t * cs4270_open(int id)
{
    assert((id >= 0) && (id < DRV_CS4270_INSTANCE_COUNT));

    cs4270_t * restrict drv = &drv_table[id];
    
    if (drv->spi_master == NULL)
    {
        const drv_cs4270_cfg_instance_t * restrict drv_cfg = &drv_cs4270_instance_table[id];
        int error_code;

        drv->spi_master = spi_open(drv_cfg->drv_spi);;

        if (drv_cfg->bus_sharing)
        {
            drv->spi_slave_id = drv_cfg->channel;
        }
        else
        {
            drv->spi_slave_id = 0;
        }

        error_code = cs4270_reset(drv);

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
        if (error_code == CS4270_ERR_OK)
#endif
        {
            error_code = cs4270_set_default(drv);
        }

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
        if (error_code != CS4270_ERR_OK)
        {
            drv->spi_master = NULL;
            drv = NULL;
        }
#endif
    }
    return drv;
}


/**
 * @brief    Reset an instance of the driver
 *
 * This function resets the CS4270 24-bit, 192 kHz Stereo Audio CODEC.
 *
 * @param  drv  pointer to device driver
 *
 * @return error code or CS4270_ERR_OK when succesfull reset
 */
int cs4270_reset(cs4270_t * restrict drv)
{
    int retval = CS4270_ERR_SPI;
    uint8_t ctrl_reg;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
    if ((drv->spi_slave_id == 0) || spi_get_bus(drv->spi_master, drv->spi_slave_id))
    {
#endif
        spi_set_mode( drv->spi_master, SPI_MODE0 );
        spi_set_baudrate( drv->spi_master, 1000000 );
        ctrl_reg = cs4270_spi_read(drv->spi_master, CS4270_REG_POWER_CONTROL);
        ctrl_reg |= 0x01;
        cs4270_spi_write(drv->spi_master, CS4270_REG_POWER_CONTROL, ctrl_reg);
        ctrl_reg = cs4270_spi_read(drv->spi_master, CS4270_REG_POWER_CONTROL);
        ctrl_reg &= 0xFE;
        cs4270_spi_write(drv->spi_master, CS4270_REG_POWER_CONTROL, ctrl_reg);
        retval = CS4270_ERR_OK;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
        if (drv->spi_slave_id != 0)
        {
            spi_release_bus( drv->spi_master );
        }
    }
#endif
    return retval;
}


/**
 * @brief    set output volume
 *
 * Use thie funciton to set the output volume.
 *
 * @param   drv     pointer to device driver
 * @param   volume  output volume in dB, possible values 0 to -127.5 dB
 * @param   channel channel(s) to set volume
 *
 * @return error code or CS4270_ERR_OK when new volume set
 */
int cs4270_set_volume(cs4270_t * restrict drv, uint8_t volume, channel_select_t channel)
{
    int retval = CS4270_ERR_SPI;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
    if ((drv->spi_slave_id == 0) || spi_get_bus(drv->spi_master, drv->spi_slave_id))
    {
#endif
        cs4270_change_begin(drv->spi_master);
        switch(channel)
        {
            case eChannel_R: cs4270_spi_write(drv->spi_master, CS4270_REG_VOL_CONTROL_AOUTA, volume);
                             break;
            case eChannel_L: cs4270_spi_write(drv->spi_master, CS4270_REG_VOL_CONTROL_AOUTB, volume);
                             break;
            default:         cs4270_spi_write(drv->spi_master, CS4270_REG_VOL_CONTROL_AOUTA, volume);
                             cs4270_spi_write(drv->spi_master, CS4270_REG_VOL_CONTROL_AOUTB, volume);
                             break;
        }
        cs4270_change_end(drv->spi_master);
        retval = CS4270_ERR_OK;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
        if (drv->spi_slave_id != 0)
        {
            spi_release_bus(drv->spi_master);
        }
    }
#endif
    return retval;
}


static void cs4270_spi_write(spi_t * spi_master, uint8_t address, uint8_t data)
{
    delay_us( 1 );          // CS must be high for at least 1 usec before dropping it again
    spi_cs_lo(spi_master);
    spi_transceive8(spi_master, CS4270_ADDRESS | CS4270_WRITE);
    spi_transceive8(spi_master, address);
    spi_transceive8(spi_master, data);
    spi_cs_hi(spi_master);
}

/**
 * @brief    Write data to CS4270 register
 *
 * This function set the value of a register of the CS4270 24-bit, 192 kHz Stereo Audio CODEC.
 *
 * @param   drv     pointer to device driver
 * @param   address register to write to
 * @param   data    new value for register
 *
 * @return  none
 */
int cs4270_write(cs4270_t * restrict drv, uint8_t address, uint8_t data)
{
    int retval = CS4270_ERR_SPI;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
    if ((drv->spi_slave_id == 0) || spi_get_bus(drv->spi_master, drv->spi_slave_id))
    {
#endif
        cs4270_spi_write(drv->spi_master, address, data);
        retval = CS4270_ERR_OK;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
        if (drv->spi_slave_id != 0)
        {
            spi_release_bus( drv->spi_master );
        }
    }
#endif
    return retval;
}


static uint8_t cs4270_spi_read(spi_t * spi_master, uint8_t address)
{
    uint8_t rv = 0;

    // Select address
    delay_us( 1 );          // CS must be high for at least 1 usec before dropping it again
    spi_cs_lo(spi_master);
    delay_ns( 20 );
    spi_transceive8(spi_master, CS4270_ADDRESS | CS4270_WRITE);
    spi_transceive8(spi_master, address);
    spi_cs_hi(spi_master);

    delay_us( 1 );          // CS must be high for at least 1 usec before dropping it again

    // Read value
    spi_cs_lo(spi_master);
    spi_transceive8(spi_master, CS4270_ADDRESS | CS4270_READ);
    rv = spi_transceive8(spi_master, 0xFE);
    spi_cs_hi(spi_master);

    return rv;
}

/**
 * @brief    Read data from CS4270 register
 *
 * This function reads the value of a register of the CS4270 24-bit, 192 kHz Stereo Audio CODEC.
 *
 * @param   drv     pointer to device driver
 * @param   address register to read from
 * @param   data    pointer to area where to store data
 *
 * @return  error code, or CS4270_ERR_OK in case of succesfull read
 */
int cs4270_read(cs4270_t * restrict drv, uint8_t address, uint8_t * data)
{
    int retval = CS4270_ERR_SPI;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
    if ((drv->spi_slave_id == 0) || spi_get_bus(drv->spi_master, drv->spi_slave_id))
    {
#endif
        *data = cs4270_spi_read(drv->spi_master, address);
        retval = CS4270_ERR_OK;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
        if (drv->spi_slave_id != 0)
        {
            spi_release_bus(drv->spi_master);
        }
    }
#endif
    return retval;
}


/**
 * set Freeze bit so changes can be made that will take affect after the freeze bit is cleared again
 */
static void cs4270_change_begin(spi_t * spi_master)
{
    uint8_t ctrl_reg;

    ctrl_reg = cs4270_spi_read(spi_master, CS4270_REG_POWER_CONTROL);
    ctrl_reg |= 0x80;
    cs4270_spi_write(spi_master, CS4270_REG_POWER_CONTROL, ctrl_reg);
}


/**
 * clear Freeze bit so changes made to the registers take affect
 */
static void cs4270_change_end(spi_t * spi_master)
{
    uint8_t ctrl_reg;

    ctrl_reg = cs4270_spi_read(spi_master, CS4270_REG_POWER_CONTROL);
    ctrl_reg &= 0x7F;
    cs4270_spi_write(spi_master, CS4270_REG_POWER_CONTROL, ctrl_reg);
}


/**
 * @brief    Restore default settings
 *
 * This function sets register of the CS4270 to there default values.
 *
 * @param   drv     pointer to device driver
 *
 * @return error code or CS4270_ERR_OK
 */
int cs4270_set_default(cs4270_t * restrict drv)
{
    int retval = CS4270_ERR_SPI;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
    if ((drv->spi_slave_id == 0) || spi_get_bus(drv->spi_master, drv->spi_slave_id))
    {
#endif
        cs4270_change_begin(drv->spi_master);
        cs4270_spi_write(drv->spi_master, CS4270_REG_FUNCTION_MODE, CS4270_MODE_SLAVE_MODE);
        cs4270_spi_write(drv->spi_master, CS4270_REG_SERIAL_AUDIO_FORMAT, CS4270_FORMAT_ADC_DIF | CS4270_FORMAT_DAC_DIF_FORMAT_I2S_NORMAL_24_BIT);
        cs4270_spi_write(drv->spi_master, CS4270_REG_TRANSITION_CONTROL, CS4270_TRAN_SOFT_ON_CROSS_ON);
        cs4270_spi_write(drv->spi_master, CS4270_REG_MUTE_CONTROL, 0);
        cs4270_spi_write(drv->spi_master, CS4270_REG_VOL_CONTROL_AOUTA, 0x00);
        cs4270_spi_write(drv->spi_master, CS4270_REG_VOL_CONTROL_AOUTB, 0x00);
        cs4270_change_end(drv->spi_master);
        retval = CS4270_ERR_OK;

#if DRV_CS4270_INSTANCE_BUS_SHARING_TRUE_USED
        if (drv->spi_slave_id != 0)
        {
            spi_release_bus(drv->spi_master);
        }
    }
#endif
    return retval;
}

