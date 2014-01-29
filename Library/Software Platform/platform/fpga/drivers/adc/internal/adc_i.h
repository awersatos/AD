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

inline void adc_register_adaptor( int _adc_id,
                                  int _drv_id,
                                  void *(*_drv_open)( unsigned int id ),
                                  int32_t (*_read)( void *drv, int channel),
                                  int32_t (*_read_multi)( void *drv, int *data, int nr) )
{
    adc_table[_adc_id].drv_id     = _drv_id;
    adc_table[_adc_id].drv_open   = _drv_open;
    adc_table[_adc_id].read       = _read;
    adc_table[_adc_id].read_multi = _read_multi;
}

#endif
