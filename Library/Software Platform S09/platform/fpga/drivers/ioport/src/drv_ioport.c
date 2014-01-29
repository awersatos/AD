/*****************************************************************************\
|*
|*  IN PACKAGE:         IOPORT Driver
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        IOPORT Driver Interface
 */

#include <stdlib.h>
#include <assert.h>

#include <drv_ioport.h>
#include <per_ioport.h>

#include "drv_ioport_cfg_instance.h"

// table of I/O Port driver instances
static ioport_t ioport_driver_table[DRV_IOPORT_INSTANCE_COUNT];


/**
 * @brief
 * Writes a value to a specific port of the I/O Port
 *
 * This function writes a value to a specific port number in the I/O Port.
 * Note that if the specified port number is invalid, the function will do nothing.
 * Note that if the data width of the I/O Port peripheral is actually lower than
 * 32 bits, the value to be written will be truncated.
 *
 * @param  drv    I/O Port driver configuration data
 * @param  port   the port number to write the value to; must be from 0 to (drv->port_count - 1)
 * @param  value  the value to be written to the port
 * @return none
 */
void ioport_set_value(ioport_t * restrict drv, const uint8_t port, const uint32_t value)
{
    assert(drv != NULL);

    // write the data if the port number and the base address are valid
    if ((port < drv->port_count) && (drv->base_address != 0))
    {
         if (drv->data_width == DRV_IOPORT_DATA_WIDTH_8)
         {
              IOPORT_BASE8(drv->base_address)[port] = (uint8_t) value;
         }
         else if (drv->data_width == DRV_IOPORT_DATA_WIDTH_16)
         {
              IOPORT_BASE16(drv->base_address)[port] = (uint16_t) value;
         }
         else if (drv->data_width == DRV_IOPORT_DATA_WIDTH_32)
         {
              IOPORT_BASE32(drv->base_address)[port] = value;
         }
    }
}


/**
 * @brief
 * Read a value from a specific port of the I/O Port
 *
 * This function reads a value from a specific port number in the I/O Port.
 *
 * @param  drv   I/O Port driver configuration data
 * @param  port  the port number to retrieve the value from; must be from 0 to (drv->port_count - 1)
 * @return       the value of the port if the port number is valid, otherwise returns zero
 */
uint32_t ioport_get_value(ioport_t * restrict drv, const uint8_t port)
{
    assert(drv != NULL);

    uint32_t value = 0;

    // read the data if the port number and base address are valid
    if ((port < drv->port_count) && (drv->base_address != 0))
    {
         if (drv->data_width == DRV_IOPORT_DATA_WIDTH_8)
         {
              value = IOPORT_BASE8(drv->base_address)[port];
         }
         else if (drv->data_width == DRV_IOPORT_DATA_WIDTH_16)
         {
              value = IOPORT_BASE16(drv->base_address)[port];
         }
         else if (drv->data_width == DRV_IOPORT_DATA_WIDTH_32)
         {
              value = IOPORT_BASE32(drv->base_address)[port];
         }
    }

    return value;
}


/**
 * @brief
 * Open an instance of an I/O Port driver
 *
 * This function opens an instance of an I/O Port driver. The I/O Port peripheral's
 * properties are stored in the configuration data returned.
 *
 * @param  id   a valid driver ID
 * @return      configuration data for the I/O Port driver
 */
ioport_t *ioport_open(const int id)
{
    assert((id >= 0) && (id < DRV_IOPORT_INSTANCE_COUNT));

    // get the configuration of the driver and wrapper created by the plugin system
    ioport_t *restrict drv = &ioport_driver_table[id];
    drv_ioport_cfg_instance_t *restrict drv_cfg = &drv_ioport_instance_table[id];
    per_ioport_cfg_instance_t *restrict per_cfg = &per_ioport_instance_table[drv_cfg->per_ioport];

    // copy the configuration to the driver
    drv->base_address = per_cfg->baseaddress;
    drv->port_count = per_cfg->portcount;
    if (per_cfg->buswidth == PER_IOPORT_BUSWIDTH_8)
    {
        drv->data_width = DRV_IOPORT_DATA_WIDTH_8;
    }
    else if (per_cfg->buswidth == PER_IOPORT_BUSWIDTH_16)
    {
        drv->data_width = DRV_IOPORT_DATA_WIDTH_16;
    }
    else if (per_cfg->buswidth == PER_IOPORT_BUSWIDTH_32)
    {
        drv->data_width = DRV_IOPORT_DATA_WIDTH_32;
    }

    // check the configuration of the driver
    assert(drv->base_address != 0);

    return drv;
}

