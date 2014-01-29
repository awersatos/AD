/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    ETHERNET services: Private Interface
|*
\*****************************************************************************/

#ifndef _ETHERNET_I_H
#define _ETHERNET_I_H

#include <stdint.h>

#include <ethernet.h>
#include <stdbool.h>
#include "ethernet_cfg.h"


#define ETHERNET_SIGNATURE IFCONFIG_SIGNATURE

struct ethernet_s
{
    uint32_t signature;
    void  *(*get_ifconfig)(void *);

    uint32_t * (*corebuf_alloc)(void * drv, int datasize);
    void (*corebuf_send)(void * drv, uint32_t *corebuf);
    uint32_t *(*corebuf_receive)(void * drv);
    void (*corebuf_free)(void * drv, uint32_t *corebuf);

    int (*send)(void * drv, uint8_t *buf, int size);
    int (*receive)(void * drv, uint8_t *buf, int size);

    void (*setmac)(void * drv, const uint8_t *mac);
    void (*getmac)(void * drv, uint8_t *mac);

    void *(*open)(int id);

    int drv_id;
    void * drv;
};


extern ethernet_t ethernet_table[ETHERNET_INSTANCE_COUNT];

void ethernet_set_hw_address_from_spi(ethernet_t * restrict srv);

#endif

