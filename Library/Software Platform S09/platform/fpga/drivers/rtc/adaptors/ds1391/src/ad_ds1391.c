#include "ad_rtc_ds1391_cfg_instance.h"
#include "drv_ds1391_cfg_instance.h"
#include "rtc_cfg_instance.h"
#include "rtc_cfg.h"
#include <drv_ds1391.h>
#include <rtc.h>
#include <rtc_i.h>


extern rtc_t rtc_table[RTC_INSTANCE_COUNT];

void ad_ds1391_init(void)
{
    int id;

    for (int drv_id = 0; drv_id < DRV_DS1391_INSTANCE_COUNT; drv_id++)
    {
        id = ad_rtc_ds1391_instance_table[drv_id].ad_rtc;

        rtc_table[id].drv_id    = drv_id;
        rtc_table[id].drv_open  = (void*)ds1391_open;
        rtc_table[id].set_time  = (void*)ds1391_set_time;
        rtc_table[id].get_time  = (void*)ds1391_get_time;
    }
}

