/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Adaptor from EMAC32 driver to ETHERNET service
|*
\*****************************************************************************/

#include <stdint.h>

#include <drv_emac32.h>

#include <ethernet_i.h>
#include <ethernet.h>

#include "emac32_to_ethernet_cfg_instance.h"

/* register adaptor */

extern void emac32_to_ethernet_init(void)
{
    for ( int adapter_id = 0; adapter_id < EMAC32_TO_ETHERNET_INSTANCE_COUNT; adapter_id++ )
    {
        ethernet_t *ethernet = &ethernet_table[emac32_to_ethernet_instance_table[adapter_id].ethernet_adaptor];

        ethernet->corebuf_alloc = (void*) emac32_corebuf_alloc;
        ethernet->corebuf_send = (void*) emac32_corebuf_send;
        ethernet->corebuf_receive = (void*) emac32_corebuf_receive;
        ethernet->corebuf_free = (void*) emac32_corebuf_free;

        ethernet->send = (void*) emac32_send;
        ethernet->receive = (void*) emac32_receive;

        ethernet->setmac = (void*) emac32_setmac;
        ethernet->getmac = (void*) emac32_getmac;

        ethernet->open = (void*) emac32_open;

        ethernet->drv_id = emac32_to_ethernet_instance_table[adapter_id].drv_emac32;
        ethernet->drv = NULL;
    }
}
