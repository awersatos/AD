/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:
|*
\*****************************************************************************/

#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>

#include <stdbool.h>
#include <stdint.h>

#include <drv_isp1760.h>
#include <usbhost_i.h>

#include "ad_isp1760_to_usbhost_cfg_instance.h"

/* register devices with the usbhost service */

void isp1760_to_usbhost_init( void )
{
    int i = 0;

    for (int drv_id = 0; drv_id < AD_ISP1760_TO_USBHOST_INSTANCE_COUNT; drv_id++)
    {
        int id = ad_isp1760_to_usbhost_instance_table[drv_id].ad_usbhost;
        usbhost_t *usbhost = &usbhost_table[id];

        usbhost->drv_id         = id;
        usbhost->drv            = NULL;

        usbhost->open           = (void*) isp1760_open;
        usbhost->reset          = (void*) isp1760_reset;
        usbhost->start          = (void*) isp1760_start;
        usbhost->stop           = (void*) isp1760_stop;
        usbhost->getinterrupt   = (void*) isp1760_get_interrupt;
        usbhost->shutdown       = (void*) isp1760_shutdown;
        usbhost->enqueue_urb    = (void*) isp1760_enqueue_urb;
        usbhost->dequeue_urb    = (void*) isp1760_dequeue_urb;
        usbhost->abort_endpoint = (void*) isp1760_abort_endpoint;
        usbhost->hubstatus      = (void*) NULL;
        usbhost->hubcontrol     = (void*) NULL;
    }
}

