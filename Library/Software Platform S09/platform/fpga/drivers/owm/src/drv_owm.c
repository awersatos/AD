///////////////////////////////////////////////////////////////////////////////
//
//  COPYRIGHT:          Copyright (c) 2007, Altium
//
//  DESCRIPTION:        Device driver interface for Wishbone One Wire Master Controller
//
///////////////////////////////////////////////////////////////////////////////

/**
 * @file
 * Device driver for WB_OWM peripheral.
 *
 */

#include "per_owm_cfg.h"
#include "per_owm_cfg_instance.h"

#include "drv_owm_cfg.h"
#include "drv_owm_cfg_instance.h"

#include <drv_owm.h>

#include <pal.h>
#include <assert.h>
#include <interrupts.h>

///////////////////////////////////////////////////////////////////////////////
// Clock Divider Register
///////////////////////////////////////////////////////////////////////////////
#define cFlag_ClkEn     0x80
#define cFlag_Clk_Pre0  0x01
#define cFlag_Clk_Pre1  0x02
#define cFlag_Clk_Div0  0x04
#define cFlag_Clk_Div1  0x08
#define cFlag_Clk_Div2  0x10

///////////////////////////////////////////////////////////////////////////////
//  Command Register Flags
///////////////////////////////////////////////////////////////////////////////
#define cFlag_Cmd_1WR   0x01
#define cFlag_Cmd_SRA   0x02
#define cFlag_Cmd_DQO   0x04
#define cFlag_Cmd_DQI   0x08
#define cFlag_Cmd_RST   0x20
#define cFlag_Cmd_OD    0x80

///////////////////////////////////////////////////////////////////////////////
// Interrupt Enable Register Flags
///////////////////////////////////////////////////////////////////////////////
#define cFlag_IntEn_EPD     0x01
#define cFlag_IntEn_IAS     0x02
#define cFlag_IntEn_ETBE    0x04
#define cFlag_IntEn_ETMT    0x08
#define cFlag_IntEn_ERBF    0x10
#define cFlag_IntEn_ESINT   0x20
#define cFlag_IntEn_ENBSY   0x40
#define cFlag_IntEn_DQOE    0x80

///////////////////////////////////////////////////////////////////////////////
// Interrupt Register Flags
///////////////////////////////////////////////////////////////////////////////
#define cFlag_Int_PD    0x01
#define cFlag_Int_PDR   0x02
#define cFlag_Int_TBE   0x04
#define cFlag_Int_TEMT  0x08
#define cFlag_Int_RBF   0x10
#define cFlag_Int_SINT  0x20
#define cFlag_Int_NBSY  0x40
#define cFlag_Int_DQI   0x80


///////////////////////////////////////////////////////////////////////////////
#define cCommand_SearchRom          0xF0
#define cCommand_MatchRom           0x55
#define cCommand_AcceleratedMode    0x02
#define cCommand_ReadMemory         0xF0
#define cCommand_SkipRom            0xCC
#define cCommand_ReadStatus         0xAA
#define cCommand_SoftReset          0x20
#define cCommand_Null               0x00

///////////////////////////////////////////////////////////////////////////////
#define cData_Search                0x00
#define cData_Receive               0xFF

///////////////////////////////////////////////////////////////////////////////
#define cMatchRom_BufferLength      8
#define cSearchRom_BufferLength     16
#define cSearchRom_PacketLength     64

///////////////////////////////////////////////////////////////////////////////
volatile uint8_t presence_tracking[cSearchRom_PacketLength];

///////////////////////////////////////////////////////////////////////////////
static void owm_set_clock_divider       (owm_t * driver, uint32_t clock_freq);
static void owm_set_clock               (owm_t * driver, uint8_t divisor);
static void owm_set_interrupt           (owm_t * driver, uint8_t flags);
static bool owm_detect_device           (owm_t * driver);
static void owm_reset                   (owm_t * driver);
static void owm_wait_for_interrupt      (owm_t * driver);
static void owm_send_command            (owm_t * driver, uint8_t command);
static void owm_clear_pending_interrupts(owm_t * driver);
static bool owm_initialize_transfer     (owm_t * driver, uint8_t command);

static bool owm_recover_rom             (uint8_t * receive_buffer,
                                         uint8_t * transmit_buffer,
                                         uint8_t * serial_number);
                                          
static void owm_get_device_rom          (owm_t   * driver,
                                         uint8_t * receive_buffer,
                                         uint8_t * transmit_buffer);


///////////////////////////////////////////////////////////////////////////////
static void __INTERRUPT_NATIVE owm_isr (void);


///////////////////////////////////////////////////////////////////////////////
static owm_t OWM_Instancedrivers[PER_OWM_INSTANCE_COUNT];

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the WB_OWM core and its driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise
 */
///////////////////////////////////////////////////////////////////////////////
owm_t *owm_open(uint32_t id)
{
    owm_t *driver = (void *)0;
    uint32_t clock_freq;
    
    assert( id < DRV_OWM_INSTANCE_COUNT );
    
    driver = &OWM_Instancedrivers[id];
    
    driver->base_address       = per_owm_instance_table[id].baseaddress;
    driver->interrupt_number   = per_owm_instance_table[id].owm_interrupt;
     
    clock_freq = pal_freq_hz();

    // Assert if system frequency is out of range
    assert(!((clock_freq <= 3200000) | (clock_freq > 128000000)));

    // Setup clock divisors
    owm_set_clock_divider(driver, clock_freq);
    pal_delay_us(1);

    // Configure interrupt sources for Presence detection
    owm_set_interrupt(driver, cFlag_IntEn_EPD | cFlag_IntEn_IAS);
    pal_delay_us(1);

    // Prepare interrupts
    owm_clear_pending_interrupts(driver);
    
    //pal_register_interrupt_handler(driver->interrupt_number, driver, owm_isr);
    //pal_interrupt_enable(driver->interrupt_number);
    
    interrupt_register_native(driver->interrupt_number, driver, owm_isr);
    interrupt_enable(driver->interrupt_number);
    
    owm_clear_pending_interrupts(driver);

    // Clear fields
    driver->data_buffer      = 0;
    driver->interrupt_source = 0;
    driver->device_count     = 0;
    
    return driver;
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Search the One Wire bus for devices
 *
 * This function discovers up to 8 devices on the One Wire bus
 *
 * @param  driver  OWM Driver pointer as returned from owm_open
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void owm_search_devices (owm_t * driver)
{
    uint8_t  receive_buffer [cSearchRom_BufferLength];
    uint8_t  transmit_buffer[cSearchRom_BufferLength];
    uint8_t  i;
    bool     last_device;

    driver->device_count = 0;

    if (!owm_detect_device(driver))
    {
        return;
    } else {


        owm_recover_rom(NULL, transmit_buffer, NULL);
        (driver->device_count)++;
        owm_get_device_rom(driver, receive_buffer, transmit_buffer);
        last_device = owm_recover_rom(receive_buffer, transmit_buffer,
                                      driver->device_list[(driver->device_count)-1].serial_number);

        while (!last_device)
        {
            (driver->device_count)++;
            owm_get_device_rom(driver, receive_buffer, transmit_buffer);
            last_device = owm_recover_rom(receive_buffer, transmit_buffer,
                                          driver->device_list[(driver->device_count)-1].serial_number);
            if (driver->device_count == MAX_DEVICE_COUNT)
                break;
        }

        for (i=0; i<driver->device_count; i++)
        {
            driver->device_list[i].family = driver->device_list[i].serial_number[0];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Send Byte
 *
 * This function transmits a single byte on the One Wire bus
 *
 * @param  driver   OWM Driver pointer as returned from owm_open
 * @param  value    Byte to send
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void owm_send_byte(owm_t* driver, uint8_t value)
{
    OWM_DATA(driver->base_address) = value;
    owm_wait_for_interrupt(driver);
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Receive Byte
 *
 * This function receives a single byte from the One Wire bus
 *
 * @param  driver  Driver pointer as returned from owm_open
 *
 * @return Received Byte
 */
///////////////////////////////////////////////////////////////////////////////
uint8_t owm_receive_byte(owm_t * driver)
{
    OWM_DATA(driver->base_address) = cData_Receive;
    owm_wait_for_interrupt(driver);
    return driver->data_buffer;
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Address specific device
 *
 * This function targets the device referenced by passed in index
 *
 * @param  driver   OWM Driver pointer as returned from owm_open
 * @param  index    Index of target device within device_list
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void owm_address_device(owm_t * driver, uint8_t index)
{
    uint32_t i;

    if (owm_initialize_transfer(driver, cCommand_MatchRom))
    {
        // DATA TRANSFER
        for (i=0; i < cMatchRom_BufferLength; i++)
        {
            owm_send_byte(driver, driver->device_list[index].serial_number[i]);
        }
    }
}

///////////////////////////////////////////////////////////////////////////////
static void owm_get_device_rom(owm_t * driver, uint8_t * receive_buffer, uint8_t * transmit_buffer)
{
    uint32_t i;

    if (owm_initialize_transfer(driver, cCommand_SearchRom))
    {
        owm_send_command(driver, cCommand_AcceleratedMode);

        // DATA TRANSFER
        for (i=0; i < cSearchRom_BufferLength; i++)
        {
            owm_send_byte(driver, transmit_buffer[i]);
            receive_buffer[i] = driver->data_buffer;
        }

        // EXIT ACCELERATED MODE
        owm_send_command(driver, cCommand_Null);
    }
}

///////////////////////////////////////////////////////////////////////////////
static bool owm_initialize_transfer(owm_t* driver, uint8_t command)
{
    // INITIALIZATION
    if (owm_detect_device(driver))
    {
        owm_set_interrupt(driver, cFlag_IntEn_IAS | cFlag_IntEn_ERBF);
        owm_clear_pending_interrupts(driver);

        // ROM COMMAND
        owm_send_byte(driver, command);
        return true;
    }
    return false;
}

///////////////////////////////////////////////////////////////////////////////
static bool owm_recover_rom(uint8_t * receive_buffer, uint8_t * transmit_buffer, uint8_t * serial_number)
{
    int32_t  i;
    bool     result;
    uint8_t  transmit_packet [cSearchRom_PacketLength]; // transmit packet for next Search Rom transfer
    uint8_t  recovered_rom   [cSearchRom_PacketLength]; // the recovered rom from the received data
    uint8_t  discrepancy_bits[cSearchRom_PacketLength]; // the discrepancy bits in the received data

    // Initialize data for first Search Rom command
    if (receive_buffer == NULL)
    {
        for (i=0; i < cSearchRom_PacketLength; i++) presence_tracking[i] = 0;
        for (i=0; i < cSearchRom_BufferLength; i++) transmit_buffer[i]   = 0;
        return true;
    }

    // de-interleave the received data into the new rom code and the discrepancy bits
    for (i=0; i < cSearchRom_BufferLength; i++)
    {
        if ((receive_buffer[i] & 0x02) == 0x00) recovered_rom[i*4]      = 0; else recovered_rom[i*4]      = 1;
        if ((receive_buffer[i] & 0x08) == 0x00) recovered_rom[i*4+1]    = 0; else recovered_rom[i*4+1]    = 1;
        if ((receive_buffer[i] & 0x20) == 0x00) recovered_rom[i*4+2]    = 0; else recovered_rom[i*4+2]    = 1;
        if ((receive_buffer[i] & 0x80) == 0x00) recovered_rom[i*4+3]    = 0; else recovered_rom[i*4+3]    = 1;

        if ((receive_buffer[i] & 0x01) == 0x00) discrepancy_bits[i*4]   = 0; else discrepancy_bits[i*4]   = 1;
        if ((receive_buffer[i] & 0x04) == 0x00) discrepancy_bits[i*4+1] = 0; else discrepancy_bits[i*4+1] = 1;
        if ((receive_buffer[i] & 0x10) == 0x00) discrepancy_bits[i*4+2] = 0; else discrepancy_bits[i*4+2] = 1;
        if ((receive_buffer[i] & 0x40) == 0x00) discrepancy_bits[i*4+3] = 0; else discrepancy_bits[i*4+3] = 1;
    }

    // initialize the transmit ROM to the recovered ROM
    for (i=0; i < cSearchRom_PacketLength; i++)
    {
        transmit_packet[i] = recovered_rom[i];
    }

    // work through the new transmit ROM backwards setting every bit to 0 until the
    // most significant discrepancy bit which has not yet been flipped is found
    // The transmit ROM bit at that location must be flipped
    for (i=cSearchRom_PacketLength-1; i >= 0; i--)
    {
        // This is a new discrepancy bit. Set the indicator in the tree, flip the
        // transmit bit, and then break from the loop
        if ((presence_tracking[i] == 0) && (discrepancy_bits[i] == 1) && (transmit_packet[i] == 0))
        {
            presence_tracking[i] = 1;
            transmit_packet[i]   = 1;
            break;
        }

        if ((presence_tracking[i] == 0) && (discrepancy_bits[i] == 1) && (transmit_packet[i] == 1))
        {
            presence_tracking[i] = 1;
            transmit_packet[i]   = 0;
            break;
        }

        // This bit has already been flipped, remove it from the tree and continue
        // setting the transmit bits to zero.
        if ((presence_tracking[i] == 1) && (discrepancy_bits[i] == 1)) presence_tracking[i] = 0;

        transmit_packet[i] = 0;
    }

    if (i == -1)
        result = true;      // that was the last device on the bus
    else
        result = false;

    // Convert the individual transmit ROM bit into a 16 byte format
    // every other bit is don't care

    for (i=0; i < cSearchRom_BufferLength; i++)
    {
        transmit_buffer[i] = (transmit_packet[i*4]   << 1) +
                             (transmit_packet[i*4+1] << 3) +
                             (transmit_packet[i*4+2] << 5) +
                             (transmit_packet[i*4+3] << 7);
    }

    // Convert the individual recovered ROM bits into an 8 byte format
    for (i=0; i < 8; i++)
    {
        serial_number[i] = (recovered_rom[i*8])   +
                           (recovered_rom[i*8+1] << 1) +
                           (recovered_rom[i*8+2] << 2) +
                           (recovered_rom[i*8+3] << 3) +
                           (recovered_rom[i*8+4] << 4) +
                           (recovered_rom[i*8+5] << 5) +
                           (recovered_rom[i*8+6] << 6) +
                           (recovered_rom[i*8+7] << 7);
    }

    // return IsLastDevice: 1 to stop search, 0 to continue
    return result;

}

///////////////////////////////////////////////////////////////////////////////
static void owm_set_clock_divider(owm_t* driver, uint32_t clock_freq)
{
    uint8_t clock_div = 0;
    if      (clock_freq <=   4000000) clock_div = 0x08;  // Divider Ratio: 4
    else if (clock_freq <=   5000000) clock_div = 0x02;  // Divider Ratio: 5
    else if (clock_freq <=   6000000) clock_div = 0x05;  // Divider Ratio: 6
    else if (clock_freq <=   7000000) clock_div = 0x03;  // Divider Ratio: 7
    else if (clock_freq <=   8000000) clock_div = 0x0C;  // Divider Ratio: 8
    else if (clock_freq <=  10000000) clock_div = 0x06;  // Divider Ratio: 10
    else if (clock_freq <=  12000000) clock_div = 0x09;  // Divider Ratio: 12
    else if (clock_freq <=  14000000) clock_div = 0x07;  // Divider Ratio: 14
    else if (clock_freq <=  16000000) clock_div = 0x10;  // Divider Ratio: 16
    else if (clock_freq <=  20000000) clock_div = 0x0A;  // Divider Ratio: 20
    else if (clock_freq <=  24000000) clock_div = 0x0D;  // Divider Ratio: 24
    else if (clock_freq <=  28000000) clock_div = 0x0B;  // Divider Ratio: 28
    else if (clock_freq <=  32000000) clock_div = 0x14;  // Divider Ratio: 32
    else if (clock_freq <=  40000000) clock_div = 0x0E;  // Divider Ratio: 40
    else if (clock_freq <=  48000000) clock_div = 0x11;  // Divider Ratio: 48
    else if (clock_freq <=  56000000) clock_div = 0x0F;  // Divider Ratio: 56
    else if (clock_freq <=  64000000) clock_div = 0x18;  // Divider Ratio: 64
    else if (clock_freq <=  80000000) clock_div = 0x12;  // Divider Ratio: 80
    else if (clock_freq <=  96000000) clock_div = 0x15;  // Divider Ratio: 96
    else if (clock_freq <= 112000000) clock_div = 0x13;  // Divider Ratio: 112
    else                              clock_div = 0x1C;  // Divider Ratio: 128
    owm_set_clock(driver, clock_div | cFlag_ClkEn);
}

///////////////////////////////////////////////////////////////////////////////
static void owm_set_clock(owm_t* driver, uint8_t divisor)
{
    OWM_CLKDIV(driver->base_address) = divisor;
}

///////////////////////////////////////////////////////////////////////////////
static void owm_clear_pending_interrupts(owm_t* driver)
{
    volatile uint8_t dummy;
    dummy = OWM_INT(driver->base_address);
    dummy = OWM_DATA(driver->base_address);
    driver->interrupt_done = false;
}

///////////////////////////////////////////////////////////////////////////////
static void owm_set_interrupt(owm_t* driver, uint8_t flags)
{
    OWM_INTEN(driver->base_address) = flags;
}

///////////////////////////////////////////////////////////////////////////////
static bool owm_detect_device(owm_t* driver)
{
    owm_set_interrupt(driver, cFlag_IntEn_EPD | cFlag_IntEn_IAS);
    owm_reset(driver);
    owm_wait_for_interrupt(driver);
    return (((driver->interrupt_source) & cFlag_Int_PDR) == 0);
}

///////////////////////////////////////////////////////////////////////////////
static void owm_reset(owm_t* driver)
{
    OWM_CMD(driver->base_address) = cFlag_Cmd_1WR;
}

///////////////////////////////////////////////////////////////////////////////
static void owm_wait_for_interrupt(owm_t* driver)
{
    while (!(driver->interrupt_done))
    {
        ;
    }
    driver->interrupt_done = false;
}

///////////////////////////////////////////////////////////////////////////////
static void owm_send_command(owm_t* driver, uint8_t command)
{
    OWM_CMD(driver->base_address) = command;
}

///////////////////////////////////////////////////////////////////////////////
static void __INTERRUPT_NATIVE owm_isr (void)
{
    uint32_t intr  = interrupt_get_current();
    owm_t* driver  = interrupt_native_context(intr);

    driver->interrupt_done   = true;
    driver->interrupt_source = OWM_INT(driver->base_address);
    driver->data_buffer      = OWM_DATA(driver->base_address);

    interrupt_acknowledge(intr);
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Get currently selected One Wire Bus
 *
 * This function returns currently selected one wire bus.
 *
 * @param  driver   OWM Driver pointer as returned from owm_open
 *
 * @return Currently selected One Wire Bus.
 */
///////////////////////////////////////////////////////////////////////////////
uint8_t owm_get_selected_bus(owm_t * driver)
{
    return OWM_BUS_SEL(driver->base_address);
}
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Select One Wire Bus
 *
 * This function selects One Wire Bus
 *
 * @param  driver   OWM Driver pointer as returned from owm_open
 * @param  index    Index of one wire bus.
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void owm_select_bus   (owm_t * driver, uint8_t index)
{
    OWM_BUS_SEL(driver->base_address) = 0x01 << index;
}
///////////////////////////////////////////////////////////////////////////////




