///////////////////////////////////////////////////////////////////////////////
//
//  IN PACKAGE:         Low Level Peripheral Interfaces
//
//  COPYRIGHT:          Copyright (c) 2007, Altium
//
//  DESCRIPTION:        Device driver interface for DS2406 One Wire deivce.
//
///////////////////////////////////////////////////////////////////////////////


/**
 * @file
 * Interface to device driver for DS2406 One Wire device.
 *
 */

#ifndef __DRV_OWD_DS2406_H
#define __DRV_OWD_DS2406_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <drv_owm.h>


///////////////////////////////////////////////////////////////////////////////
#define DS2406_FAMILY_CODE                      0x12
#define DS2406_MEMORY_SIZE                      128
#define DS2406_MEMORY_PAGE_SIZE                 32
#define DS2406_MEMORY_PAGES                     4
#define DS2406_STATUS_MEMORY_SIZE               8

#define DS2406_MEMORY_PAGE_0                    0
#define DS2406_MEMORY_PAGE_1                    1
#define DS2406_MEMORY_PAGE_2                    2
#define DS2406_MEMORY_PAGE_3                    3

#define DS2406_MEMORY_PAGE_ADDRESS_0            0x00
#define DS2406_MEMORY_PAGE_ADDRESS_1            0x20
#define DS2406_MEMORY_PAGE_ADDRESS_2            0x40
#define DS2406_MEMORY_PAGE_ADDRESS_3            0x60

#define DS2406_COMMAND_WRITE_MEMORY             0x0F
#define DS2406_COMMAND_WRITE_STATUS             0x55
#define DS2406_COMMAND_READ_MEMORY              0xF0
#define DS2406_COMMAND_READ_STATUS              0xAA
#define DS2406_COMMAND_EXTENDED_READ_MEMORY     0xA5
#define DS2406_COMMAND_CHANNEL_ACCESS           0xF5


///////////////////////////////////////////////////////////////////////////////
extern void ds2406_get_memory       (owm_t* driver,
                                           uint8_t  device_address,
                                           uint8_t* buffer,
                                           uint8_t  size,
                                          uint16_t  start_address);
extern void ds2406_send_command     (owm_t* driver,
                                           uint8_t command);
extern void ds2406_get_memory_page  (owm_t* driver,
                                           uint8_t  device_address,
                                           uint8_t* buffer,
                                           uint8_t  page_number);
extern void ds2406_get_status       (owm_t* driver,
                                           uint8_t  device_address,
                                           uint8_t* buffer);

#ifdef  __cplusplus
}
#endif

#endif // __DRV_OWD_DS2406_H
