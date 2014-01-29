///////////////////////////////////////////////////////////////////////////////
//
//  IN PACKAGE:         Low Level Peripheral Interfaces
//
//  COPYRIGHT:          Copyright (c) 2007, Altium
//
//  DESCRIPTION:        Device driver interface for Wishbone One Wire Master 
//                      Controller.
//
///////////////////////////////////////////////////////////////////////////////


/**
 * @file
 * Interface to device driver for WB_OWM peripheral.
 *
 **/

#ifndef __DRV_OWM_H
#define __DRV_OWM_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#include <per_owm.h>

///////////////////////////////////////////////////////////////////////////////
#define SIZE_SN           8
#define MAX_DEVICE_COUNT  8

///////////////////////////////////////////////////////////////////////////////
typedef struct
{
    uint8_t                 family;                 // Family Code; see http://pdfserv.maxim-ic.com/en/an/AN155.pdf for list of devices
    uint8_t                 serial_number[SIZE_SN]; // 8 byte device serial number for device addressing
} owm_device_info_t;

///////////////////////////////////////////////////////////////////////////////
typedef struct
{
    // Public fields
    uint32_t                base_address;                   // base address for core
    uint32_t                interrupt_number;               // interrupt number for pal to register owm_isr
    uint16_t                device_count;                   // number of devices on One Wire Bus 0 : no devices found
    owm_device_info_t       device_list[MAX_DEVICE_COUNT];  // list of devices with their family codes and serial numbers,
    // Private fields
    volatile bool           interrupt_done;                 // interrupt processed
    volatile uint8_t        interrupt_source;               // peripheral interrupt register
    volatile uint8_t        data_buffer;                    // receive buffer
} owm_t;

///////////////////////////////////////////////////////////////////////////////
// Initializes wb_owm core and searches for devices
owm_t *owm_open (uint32_t id);
// find all devices on the bus
void owm_search_devices (owm_t * driver);
// addresses device for data transfers
void owm_address_device (owm_t * driver, uint8_t index);
// send byte to one wire device
void owm_send_byte      (owm_t * driver, uint8_t value);
// receive byte from one wire device
uint8_t owm_receive_byte(owm_t * driver);

uint8_t owm_get_selected_bus(owm_t * driver);
void    owm_select_bus      (owm_t * driver, uint8_t index);

#ifdef  __cplusplus
}
#endif

#endif // __DRV_OWM_H


