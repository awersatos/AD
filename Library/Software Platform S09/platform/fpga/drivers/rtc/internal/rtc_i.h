#ifndef _RTC_I_H
#define _RTC_I_H
#include <time.h>
#include "rtc_cfg_instance.h"
#include "rtc_cfg.h"

struct _rtc_s
{
    void *drv;
    int  drv_id;
    void *(*drv_open)( unsigned int id );
    int  (*get_time)( void *drv, struct tm * t );
    int  (*set_time)( void *drv, struct tm * t );
};

extern rtc_t rtc_table[RTC_INSTANCE_COUNT];


#endif
