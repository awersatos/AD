#include <rtc.h>
#include <rtc_i.h>
#include <stdio.h>
#include <assert.h>
#include "rtc_cfg_instance.h"
#include "rtc_cfg.h"


rtc_t rtc_table[RTC_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the RTC device driver.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

rtc_t *rtc_open(unsigned int id)
{
    assert(id < RTC_INSTANCE_COUNT);

    rtc_t * restrict srv = &rtc_table[id];
    // get configuration of driver (created by plugin system)
    const rtc_cfg_instance_t * restrict srv_cfg = &rtc_instance_table[id];

    if (srv->drv == NULL)
    {
        srv->drv = srv->drv_open(srv->drv_id);
    }
    return srv->drv ? srv : NULL;
}


/**
 * @brief    Get the time from the RTC
 *
 * This function fills the tm structure with the RTC time.
 *
 * @param  rtc      pointer to valid device driver
 * @param  t        pointer to tm structure
 *
 * @return 0 on succes, error otherwise
 */

int rtc_get_time(rtc_t *rtc, struct tm *t)
{
    return rtc->get_time(rtc->drv, t);
}


/**
 * @brief    Set the RTC time
 *
 * This function sets the time to the RTC. the time is extracted from the tm structure.
 *
 * @param  rtc      pointer to valid device driver
 * @param  t        pointer to valid tm structure
 *
 * @return 0 on succes, error otherwise
 */

int rtc_set_time(rtc_t *rtc, struct tm *t)
{
    return rtc->set_time(rtc->drv, t);
}

