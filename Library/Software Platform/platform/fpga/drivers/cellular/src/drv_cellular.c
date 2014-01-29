/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         cellular Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Generic package to be able to send and receive cellular auxilliary commands
|*
 */
#include <timing.h>
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif

#include <stdint.h>
#include <stdbool.h>
#include <errno.h>
#include <assert.h>
#include <string.h>

#include <per_cellular.h>
#include <drv_cellular.h>
#include "drv_cellular_internal.h"

#define CELLULAR_SIGNATURE 0xD77DD77D

static cellular_t cellular_table[DRV_CELLULAR_INSTANCE_COUNT];


/**
 * @brief Initialize the cellular device
 *
 * This function initializes the communication with the cellular device.
 *
 * @param id  Service id
 *
 * @return The cellular service pointer for the specified device, or NULL on error.
 */
extern cellular_t * cellular_open(unsigned int id)
{
    cellular_t                        * drv     = &cellular_table[id];
    const drv_cellular_cfg_instance_t * drv_cfg = &drv_cellular_instance_table[id];
    const drv_uart8_cfg_instance_t    * drv_uart8_cfg = &drv_uart8_instance_table[drv_cfg->drv_uart8];
    const per_uart8_cfg_instance_t    * per_cfg = &per_uart8_instance_table[drv_uart8_cfg->per_uart8];

    assert(id < DRV_CELLULAR_INSTANCE_COUNT);

    if (drv->signature != CELLULAR_SIGNATURE)
    {
        memset(drv,0,sizeof(cellular_t));

        assert(per_cfg->baseaddress);
        drv->baseaddress = (uint8_t *) per_cfg->baseaddress;
        drv->uart8 = uart8_open(drv_cfg->drv_uart8);

        if (drv->uart8)
            drv->signature = CELLULAR_SIGNATURE;
    }
    return drv;
}

extern uart8_t * cellular_uart8_open(unsigned int id)
{
    cellular_t * drv = cellular_open(id);

    assert ( id < DRV_CELLULAR_INSTANCE_COUNT );
    return drv ? drv->uart8 : NULL;
}
                             
/**
 * @brief reset the cellular to an initial ready state
 *
 * @param cellular     pointer to a cellular device struct that has been previously opened by using cellular_open()
 *
 */
extern void cellular_pwr_on(cellular_t * cellular)
{
    assert(cellular->signature == CELLULAR_SIGNATURE && cellular->baseaddress);

    CELLULAR_COMMAND(cellular->baseaddress) = CELLULAR_COMMAND_PWR_ON;
}


/**
 * @brief assert the DTR line
 *
 * @param cellular     pointer to a cellular device struct that has been previously opened by using cellular_open()
 *
 */
extern void cellular_dtr(cellular_t * cellular)
{
    assert(cellular->signature == CELLULAR_SIGNATURE && cellular->baseaddress);

    CELLULAR_COMMAND(cellular->baseaddress) = CELLULAR_COMMAND_DTR;
}


/**
 * @brief read the cellular aux controller status
 *
 * @param cellular     pointer to a cellular device struct that has been previously opened by using cellular_open()
 *
 */
extern int cellular_status(cellular_t * cellular)
{
    assert(cellular->signature == CELLULAR_SIGNATURE && cellular->baseaddress);

    return CELLULAR_STATUS(cellular->baseaddress);
}



