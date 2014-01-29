#ifndef _ADC_I_H
#define _ADC_I_H
#include "adc_cfg_instance.h"
#include "adc_cfg.h"

struct _adc_s
{
    void    *drv;
    int     drv_id;
    void    *(*drv_open)( unsigned int id );
    int32_t (*read)( void *drv, int channel);
    int32_t (*read_multi)( void *drv, int *data, int nr);
};

extern adc_t adc_table[ADC_INSTANCE_COUNT];


#endif
