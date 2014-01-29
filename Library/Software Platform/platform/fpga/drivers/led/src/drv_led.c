/*****************************************************************************\
|*
|*  IN PACKAGE:         LED Controller Driver
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        LED Controller Driver Interface
 */

/**
 * @file
 * Device driver interface for WB_LED_CTRL peripheral.
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include <per_led.h>
#include <drv_led.h>

#include "drv_led_cfg_instance.h"
#include "led_info.h"

#define OFF_INTENSITY 0

// runtime driver data
struct _led_s
{
    uintptr_t    base_addr;
    uint16_t     num_led_ids;

#if PER_LED_INSTANCE_ISRGB_TRUE_USED > 0
    uint8_t      intensities[3*PER_LED_INSTANCE_NUMLEDS_MAX];
#elif PER_LED_INSTANCE_NUMLEDS_MAX > 0
    uint8_t      intensities[PER_LED_INSTANCE_NUMLEDS_MAX];
#else
    uint8_t      intensities[1];
#endif
};

// runtime driver table
static led_t drv_table[DRV_LED_INSTANCE_COUNT];

/**
 * @brief
 * Turn on the LED
 *
 * Turn on the LED. The intensity value of the LED will be the value specified
 * using the function led_set_all_on_intensity() or led_set_on_intensity().
 *
 * @param led_drv   Valid driver configuration data (created using led_open())
 * @param led_id    Valid LED id (defined in led_info.h)
 *
 * @return none
 */
void led_turn_on (led_t * restrict led_drv, uint8_t led_id)
{
    LED_BASE8(led_drv->base_addr)[led_id] = led_drv->intensities[led_id];
}

/**
 * @brief
 * Turn off the LED
 *
 * Turn off the LED.
 *
 * @param led_drv   Valid driver configuration data (created using led_open())
 * @param led_id    Valid LED id (defined in led_info.h)
 *
 * @return none
 */
void led_turn_off(led_t * restrict led_drv, uint8_t led_id)
{
    LED_BASE8(led_drv->base_addr)[led_id] = OFF_INTENSITY;
}

/**
 * @brief
 * Turn on all LEDs
 *
 * Turn on all LEDs. The intensity value of each LED will be the value specified
 * using the function led_set_all_on_intensity() or led_set_on_intensity().
 *
 * @param led_drv   Valid driver configuration data (created using led_open())
 *
 * @return none
 */
void led_turn_all_on (led_t * restrict led_drv)
{
    for (int i = 0; i < led_drv->num_led_ids; ++i)
        LED_BASE8(led_drv->base_addr)[i] = led_drv->intensities[i];
}

/**
 * @brief
 * Turn off all LEDs
 *
 * Turn off all LEDs.
 *
 * @param led_drv   Valid driver configuration data (created using led_open())
 *
 * @return none
 */
void led_turn_all_off(led_t * restrict led_drv)
{
    for (int i = 0; i < led_drv->num_led_ids; ++i)
        LED_BASE8(led_drv->base_addr)[i] = OFF_INTENSITY;
}

/**
 * @brief
 * Sets the intensity of the LED when it is turned on
 *
 * Sets the intensity of the LED when it is turned on. The setting will not
 * take effect until the LED is next turned on using either led_turn_on() or
 * led_turn_all_on().
 *
 * @param led_drv   Valid driver configuration data (created using led_open())
 * @param led_id    Valid LED id (defined in led_info.h)
 * @param intensity Intensity value for the LEDs when it is turned on (0-255)
 *
 * @return none
 */
void led_set_on_intensity(led_t * restrict led_drv, uint8_t led_id, uint8_t intensity)
{
    led_drv->intensities[led_id] = intensity;
}

/**
 * @brief
 * Sets the intensity of all LEDs when turned on
 *
 * Sets the intensity of all LEDs when turned on. The setting will not take
 * effect until the LEDs are next turned on using either led_turn_on() or
 * led_turn_all_on().
 *
 * @param led_drv   Valid driver configuration data (created using led_open())
 * @param intensity Intensity value for the LEDs when it is turned on (0-255)
 *
 * @return none
 */
void led_set_all_on_intensity(led_t * restrict led_drv, uint8_t intensity)
{
    for (int i = 0; i < led_drv->num_led_ids; ++i)
        led_drv->intensities[i] = intensity;
}

/**
 * @brief
 * Sets the intensity of an LED
 *
 * Sets the intensity of an LED.
 *
 * @param led_drv   Valid driver configuration data (created using led_open())
 * @param led_id    Valid LED id (defined in led_info.h)
 * @param intensity Intensity value for the LED (0-255)
 *
 * @return none
 */
void led_set_intensity(led_t * restrict led_drv, uint8_t led_id, uint8_t intensity)
{
    LED_BASE8(led_drv->base_addr)[led_id] = intensity;
}

/**
 * @brief
 * Open an instance of an LED Controller driver
 *
 * This function opens an instance of an LED Controller driver. The LED
 * Controller device's properties are stored in the configuration data
 * returned.  This function should only be called once per driver instance id.
 *
 * @param id Valid driver id (defined in devices.h)
 *
 * @return   configuration data pointer if successful initialization, NULL
 *           otherwise.
 */
led_t * led_open(int id)
{
    assert((id >= 0) && (id < DRV_LED_INSTANCE_COUNT));

    led_t * restrict drv = &drv_table[id];
    if (drv->base_addr == 0)
    {
        // get configuration of driver (created by plugin system)
        const drv_led_cfg_instance_t * restrict drv_cfg = &drv_led_instance_table[id];
        // get configuration of peripheral below driver (created by plugin system)
        const per_led_cfg_instance_t * restrict per_cfg = &per_led_instance_table[drv_cfg->per_led];

        // copy peripheral configuration data to driver table
        assert(per_cfg->baseaddress != 0);
        drv->base_addr = per_cfg->baseaddress;
        if (per_cfg->isrgb)
            drv->num_led_ids = 3*per_cfg->numleds;
        else
            drv->num_led_ids = per_cfg->numleds;

        for (int i = 0; i < drv->num_led_ids; ++i)
            drv->intensities[i] = drv_cfg->default_on_intensity;
    }
    return drv;
}
