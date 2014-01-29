/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        PWMX peripheral device driver.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver for PWMX peripheral.
 */

#include <assert.h>
#include <pal.h>
#include <per_pwmx.h>
#include <drv_pwmx.h>

#include "drv_pwmx_cfg_instance.h"

// runtime driver data
struct pwmx_s
{
    uintptr_t           base_addr;
    uint16_t            max_width;
};

// runtime driver table
static pwmx_t drv_table[DRV_PWMX_INSTANCE_COUNT];

/**
 * @brief set prescaler reload value for specified output signal frequency
 *
 * This function calculates and sets the prescaler value for the specified
 * output signal frequency in Hz.
 *
 * @param   pwmx_drv        device pointer obtained from the pwmx_open routine
 * @param   frequency       output signal frequency in Hz
 *
 * @return  none
 */
void pwmx_set_frequency(pwmx_t * restrict pwmx_drv, uint32_t frequency)
{
    if (frequency > 0)
    {
        pwmx_set_prescaler(pwmx_drv, (pal_freq_hz() / (pwmx_drv->max_width * frequency)) - 1);
    }
}

/**
 * @brief set pulse width for specified duty cycle percentage
 *
 * This function calculates and sets the pulse width value for the specified
 * duty cycle as a percentage of the maximum pulse width.
 *
 * @param   pwmx_drv        device pointer obtained from the pwmx_open routine
 * @param   dutycycle       duty cycle in percentage
 *
 * @return  none
 */
void pwmx_set_dutycycle(pwmx_t * restrict pwmx_drv, uint32_t dutycycle)
{
    if (dutycycle <= 100)
    {
        pwmx_set_pulsewidth(pwmx_drv, ((pwmx_drv->max_width - 1) * dutycycle) / 100);
    }
}

/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a PWMX core and its driver.
 * You should call it only once per driver instance id.
 *
 * @param id
 *          Valid driver id (defined in devices.h)
 *
 * @return  Driver pointer if successful initialization, NULL otherwise.
 */
pwmx_t * pwmx_open(int id)
{
    assert((id >= 0) && (id < DRV_PWMX_INSTANCE_COUNT));

    pwmx_t * restrict drv = &drv_table[id];
    if (drv->base_addr == 0)
    {
        // get configuration of driver (created by plugin system)
        const drv_pwmx_cfg_instance_t * restrict drv_cfg = &drv_pwmx_instance_table[id];
        // get configuration of peripheral below driver (created by plugin system)
        const per_pwmx_cfg_instance_t * restrict per_cfg = &per_pwmx_instance_table[drv_cfg->per_pwmx];

        // convert driver configuration data to driver table
        drv->max_width = 1 << (2 * drv_cfg->resolution) + 8;

        // copy peripheral configuration data to driver table
        assert(per_cfg->baseaddress != 0);
        drv->base_addr = per_cfg->baseaddress;

        // set-up hardware registers based on configuration
        pwmx_set_resolution_mode(drv, drv_cfg->resolution);
        pwmx_set_dutycycle(drv, drv_cfg->dutycycle);
        pwmx_set_frequency(drv, drv_cfg->frequency);
    }
    return drv;
}

/**
 * @brief   get maximum pulse width plus 1
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  max pulse width
 *
 */
uint16_t pwmx_max_pulsewidth(pwmx_t * restrict pwmx_drv)
{
    return pwmx_drv->max_width;
}

/**
 * @brief   get resolution mode
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  resolution mode
 *
 */
pwmx_mode_t pwmx_get_resolution_mode(pwmx_t * restrict pwmx_drv)
{
    uint8_t        control_reg;
    pwmx_mode_t    mode = PWMX_MODE_8BIT;

    control_reg = PWMX_PWCON(pwmx_drv->base_addr);

    if (control_reg & PWCON_MOD0)
    {
        if (control_reg & PWCON_MOD1)
        {
            mode = PWMX_MODE_14BIT;
        }
        else
        {
            mode = PWMX_MODE_10BIT;
        }
    }
    else if (control_reg & PWCON_MOD1)
    {
        mode = PWMX_MODE_12BIT;
    }

    return mode;
}

/**
 * @brief   set resolution mode
 *
 * @param   pwmx_drv     device pointer
 * @param   mode    resolution mode
 *
 * @return  None
 *
 */
void pwmx_set_resolution_mode(pwmx_t * pwmx_drv, pwmx_mode_t mode)
{
    uint8_t    control_reg;
    uint8_t    bits = 8;

    // clear mode
    control_reg = PWMX_PWCON(pwmx_drv->base_addr) & ~(PWCON_MOD0 | PWCON_MOD1);
    // set mode
    switch (mode)
    {
    case PWMX_MODE_8BIT:
        bits = 8;
        break;
    case PWMX_MODE_10BIT:
        bits = 10;
        control_reg |= PWCON_MOD0;
        break;
    case PWMX_MODE_12BIT:
        bits = 12;
        control_reg |= PWCON_MOD1;
        break;
    case PWMX_MODE_14BIT:
        bits = 14;
        control_reg |= PWCON_MOD0 | PWCON_MOD1;
        break;
    default:
        assert(0);
        break;
    }

    PWMX_PWCON(pwmx_drv->base_addr) = control_reg;

    pwmx_drv->max_width = 1 << bits;
}

/**
 * @brief   set pulse width
 *
 * @param   pwmx_drv     device pointer
 * @param   value        pulse width value
 *
 * @return  None
 *
 */
void pwmx_set_pulsewidth(pwmx_t * restrict pwmx_drv, uint16_t value)
{
    PWMX_PWMRGH(pwmx_drv->base_addr) = (value >> 8 ) & 0xff;
    PWMX_PWMRG(pwmx_drv->base_addr) = value & 0xff;
}

/**
 * @brief   set prescaler
 *
 * @param   pwmx_drv     device pointer
 * @param   value        prescaler value
 *
 * @return  None
 *
 */
void pwmx_set_prescaler(pwmx_t * restrict pwmx_drv, uint16_t value)
{
    PWMX_PWPHI(pwmx_drv->base_addr) = (value >> 8 ) & 0xff;
    PWMX_PWPLO(pwmx_drv->base_addr) = value & 0xff;
}

/**
 * @brief   enable controller
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_enable_controller(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) |= PWCON_PWEN;
}

/**
 * @brief   disable controller
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_disable_controller(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) &= ~PWCON_PWEN;
}

/**
 * @brief   enable interrupts
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_enable_interrupts(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) |= PWCON_PIEN;
}

/**
 * @brief   disable interrupts
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_disable_interrupts(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) &= ~PWCON_PIEN;
}

/**
 * @brief   enable pre-scaler counter interrupt
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_enable_prescaler_interrupt(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) |= PWCON_PRIE;
}

/**
 * @brief   disable pre-scaler counter interrupt
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_disable_prescaler_interrupt(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) &= ~PWCON_PRIE;
}

/**
 * @brief   check pre-scaler counter interrupt flag
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  true if flag is set, false otherwise
 *
 */
bool pwmx_prescaler_interrupt_flag(pwmx_t * restrict pwmx_drv)
{
    if (PWMX_PWCON(pwmx_drv->base_addr) & PWCON_PRI)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * @brief   clear pre-scaler counter interrupt flag
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_clear_prescaler_interrupt_flag(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) &= ~PWCON_PRI;
}

/**
 * @brief   enable PWM counter interrupt
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_enable_pulsewidth_interrupt(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) |= PWCON_PWIE;
}

/**
 * @brief   disable PWM counter interrupt
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_disable_pulsewidth_interrupt(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) &= ~PWCON_PWIE;
}

/**
 * @brief   check PWM counter interrupt flag
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  true if flag is set, false otherwise
 *
 */
bool pwmx_pulsewidth_interrupt_flag(pwmx_t * restrict pwmx_drv)
{
    if (PWMX_PWCON(pwmx_drv->base_addr) & PWCON_PWI)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * @brief   clear PWM counter interrupt flag
 *
 * @param   pwmx_drv     device pointer
 *
 * @return  None
 *
 */
void pwmx_clear_pulsewidth_interrupt_flag(pwmx_t * restrict pwmx_drv)
{
    PWMX_PWCON(pwmx_drv->base_addr) &= ~PWCON_PWI;
}


