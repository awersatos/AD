/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        PWM8 peripheral device driver.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver for PWM8 peripheral.
 */

#include <assert.h>
#include <pal.h>
#include <per_pwm8.h>
#include <drv_pwm8.h>

#include "drv_pwm8_cfg_instance.h"

// runtime driver data
struct pwm8_s
{
    uintptr_t           base_addr;
};

// runtime driver table
static pwm8_t drv_table[DRV_PWM8_INSTANCE_COUNT];

/**
 * @brief set prescaler reload value for specified output signal frequency
 *
 * This function calculates and sets the prescaler value for the specified
 * output signal frequency in Hz.
 *
 * @param   pwm8_drv        device pointer obtained from the pwm8_open routine
 * @param   frequency       output signal frequency in Hz
 *
 * @return  none
 */
void pwm8_set_frequency(pwm8_t * restrict pwm8_drv, uint32_t frequency)
{
    if (frequency > 0)
    {
        pwm8_set_prescaler(pwm8_drv, (pal_freq_hz() / (256 * frequency)) - 1);
    }
}

/**
 * @brief set pulse width for specified duty cycle percentage
 *
 * This function calculates and sets the pulse width value for the specified
 * duty cycle as a percentage of the maximum pulse width.
 *
 * @param   pwm8_drv        device pointer obtained from the pwm8_open routine
 * @param   dutycycle       duty cycle in percentage
 *
 * @return  none
 */
void pwm8_set_dutycycle(pwm8_t * restrict pwm8_drv, uint32_t dutycycle)
{
    if (dutycycle <= 100)
    {
        pwm8_set_pulsewidth(pwm8_drv, (255 * dutycycle) / 100);
    }
}

/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a PWM8 core and its driver.
 * You should call it only once per driver instance id.
 *
 * @param id
 *          Valid driver id (defined in devices.h)
 *
 * @return  Driver pointer if successful initialization, NULL otherwise.
 */
pwm8_t * pwm8_open(int id)
{
    assert((id >= 0) && (id < DRV_PWM8_INSTANCE_COUNT));

    pwm8_t * restrict drv = &drv_table[id];
    // get configuration of driver (created by plugin system)
    drv_pwm8_cfg_instance_t * restrict drv_cfg = &drv_pwm8_instance_table[id];
    // get configuration of peripheral below driver (created by plugin system)
    per_pwm8_cfg_instance_t * restrict per_cfg = &per_pwm8_instance_table[drv_cfg->per_pwm8];

    // copy peripheral configuration data to driver table
    assert(per_cfg->baseaddress != 0);
    drv->base_addr = per_cfg->baseaddress;

    // set-up hardware registers based on configuration
    pwm8_set_dutycycle(drv, drv_cfg->dutycycle);
    pwm8_set_frequency(drv, drv_cfg->frequency);

    return drv;
}

/**
 * @brief   set pulse width
 *
 * @param   pwm8_drv     device pointer
 * @param   value        pulse width value
 *
 * @return  None
 *
 */
void pwm8_set_pulsewidth(pwm8_t * restrict pwm8_drv, uint8_t value)
{
    PWM8_PWMRG(pwm8_drv->base_addr) = value;
}

/**
 * @brief   set prescaler
 *
 * @param   pwm8_drv     device pointer
 * @param   value        prescaler value
 *
 * @return  None
 *
 */
void pwm8_set_prescaler(pwm8_t * restrict pwm8_drv, uint16_t value)
{
    PWM8_PWPHI(pwm8_drv->base_addr) = (value >> 8 ) & 0xff;
    PWM8_PWPLO(pwm8_drv->base_addr) = value & 0xff;
}

/**
 * @brief   enable controller
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_enable_controller(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) |= PWCON_PWEN;
}

/**
 * @brief   disable controller
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_disable_controller(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) &= ~PWCON_PWEN;
}

/**
 * @brief   enable interrupts
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_enable_interrupts(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) |= PWCON_PIEN;
}

/**
 * @brief   disable interrupts
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_disable_interrupts(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) &= ~PWCON_PIEN;
}

/**
 * @brief   enable pre-scaler counter interrupt
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_enable_prescaler_interrupt(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) |= PWCON_PRIE;
}

/**
 * @brief   disable pre-scaler counter interrupt
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_disable_prescaler_interrupt(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) &= ~PWCON_PRIE;
}

/**
 * @brief   check pre-scaler counter interrupt flag
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  true if flag is set, false otherwise
 *
 */
bool pwm8_prescaler_interrupt_flag(pwm8_t * restrict pwm8_drv)
{
    if (PWM8_PWCON(pwm8_drv->base_addr) & PWCON_PRI)
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
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_clear_prescaler_interrupt_flag(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) &= ~PWCON_PRI;
}

/**
 * @brief   enable PWM counter interrupt
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_enable_pulsewidth_interrupt(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) |= PWCON_PWIE;
}

/**
 * @brief   disable PWM counter interrupt
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_disable_pulsewidth_interrupt(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) &= ~PWCON_PWIE;
}

/**
 * @brief   check PWM counter interrupt flag
 *
 * @param   pwm8_drv     device pointer
 *
 * @return  true if flag is set, false otherwise
 *
 */
bool pwm8_pulsewidth_interrupt_flag(pwm8_t * restrict pwm8_drv)
{
    if (PWM8_PWCON(pwm8_drv->base_addr) & PWCON_PWI)
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
 * @param   pwm8_drv     device pointer
 *
 * @return  None
 *
 */
void pwm8_clear_pulsewidth_interrupt_flag(pwm8_t * restrict pwm8_drv)
{
    PWM8_PWCON(pwm8_drv->base_addr) &= ~PWCON_PWI;
}


