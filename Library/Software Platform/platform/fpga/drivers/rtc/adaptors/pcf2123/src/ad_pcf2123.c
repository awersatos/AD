#include "ad_rtc_pcf2123_cfg_instance.h"
#include "drv_pcf2123_cfg_instance.h"
#include "rtc_cfg_instance.h"
#include "rtc_cfg.h"
#include <drv_pcf2123.h>
#include <rtc.h>
#include <rtc_i.h>


extern rtc_t rtc_table[RTC_INSTANCE_COUNT];

void ad_pcf2123_init(void)
{
    int id;

    for (int drv_id = 0; drv_id < DRV_PCF2123_INSTANCE_COUNT; drv_id++)
    {
        id = ad_rtc_pcf2123_instance_table[drv_id].ad_rtc;

        rtc_table[id].drv_id    = drv_id;
        rtc_table[id].drv_open  = (void*)pcf2123_open;
        rtc_table[id].set_time  = (void*)pcf2123_set_time;
        rtc_table[id].get_time  = (void*)pcf2123_get_time;
    }
}

