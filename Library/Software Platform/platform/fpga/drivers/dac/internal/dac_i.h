#ifndef _DAC_I_H
#define _DAC_I_H
#include "dac_cfg_instance.h"
#include "dac_cfg.h"

struct _dac_s
{
    void    *drv;
    int     drv_id;
    void    *(*drv_open)( unsigned int id );
    int32_t (*write)( void *drv, unsigned channel, int value, bool flush);
};

extern dac_t dac_table[DAC_INSTANCE_COUNT];

inline void dac_register_adaptor( int _dac_id,
                                  int _drv_id,
                                  void *(*_drv_open)( unsigned int id ),
                                  int32_t (*_write)( void *drv, unsigned channel, int value, bool flush) )
{
    dac_table[_dac_id].drv_id   = _drv_id;
    dac_table[_dac_id].drv_open = _drv_open;
    dac_table[_dac_id].write    = _write;
}

#endif
