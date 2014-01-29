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


#endif
