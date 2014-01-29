/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        IOPORT peripheral direct access. 
|*
\*****************************************************************************/

#include <per_ioport.h>

#include "per_ioport_cfg.h"
#include "per_ioport_cfg_instance.h"

/**
 * @brief
 * Get the base address of the IOPORT peripheral.
 *
 * This function opens an instance of an I/O Port driver. The I/O Port peripheral's
 * properties are stored in the configuration data returned.
 *
 * @param  id   a valid peripheral ID
 * @return      base address or 0 if invalid id
 */

uint32_t per_ioport_get_base_address( int id )
{
    return ( id >= 0 && id < PER_IOPORT_INSTANCE_COUNT ) ? per_ioport_instance_table[id].baseaddress : 0;
}

