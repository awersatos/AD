/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Custom Instrument device direct access.
|*
\*****************************************************************************/

#include <per_instrument.h>

#include "per_instrument_cfg.h"
#include "per_instrument_cfg_instance.h"


uint32_t per_instrument_get_base_address(int id)
{
    return ( id >= 0 && id < PER_INSTRUMENT_INSTANCE_COUNT ) ? per_instrument_instance_table[id].baseaddress : 0;
}

