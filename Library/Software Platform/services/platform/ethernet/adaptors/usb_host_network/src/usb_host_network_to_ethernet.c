/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Adaptor from USB Host Network to ETHERNET service
|*
\*****************************************************************************/

#include <stdint.h>
#include <usb_host_network_to_ethernet_cfg.h>

#include <ethernet_i.h>
#include <ethernet.h>

#include "usb_host_network_to_ethernet_cfg_instance.h"

#include <usbhost_network.h>

/* register adaptor */

extern void usb_host_network_to_ethernet_init(void)
{
    for ( int adapter_id = 0; adapter_id < USB_HOST_NETWORK_TO_ETHERNET_INSTANCE_COUNT; adapter_id++ )
    {
        ethernet_t *ethernet = &ethernet_table[usb_host_network_to_ethernet_instance_table[adapter_id].ethernet_adaptor];

        ethernet->corebuf_alloc     = (void*) usbhost_network_corebuf_alloc;
        ethernet->corebuf_send      = (void*) usbhost_network_corebuf_send;
        ethernet->corebuf_receive   = (void*) usbhost_network_corebuf_receive;
        ethernet->corebuf_free      = (void*) usbhost_network_corebuf_free;
        ethernet->send              = (void*) usbhost_network_send;
        ethernet->receive           = (void*) usbhost_network_receive;
        ethernet->setmac            = (void*) usbhost_network_setmac;
        ethernet->getmac            = (void*) usbhost_network_getmac;
        ethernet->open              = (void*) usbhost_network_open;

        ethernet->drv_id            = usb_host_network_to_ethernet_instance_table[adapter_id].usbhost_network;
        ethernet->drv               = NULL;
    }
}
