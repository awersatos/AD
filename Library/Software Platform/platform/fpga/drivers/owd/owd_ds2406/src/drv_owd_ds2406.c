///////////////////////////////////////////////////////////////////////////////
// drv_owd_ds2406.c

#include "drv_owd_ds2406.h"

static void ds2406_address_memory(owm_t* driver, uint16_t start_address);

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Read device memory
 *
 * This function retrieves Bytes of memory from the targeted device
 *
 * @param  driver           OWM Driver pointer as returned from owm_open
 * @param  device_address   Index of device within device_list array
 * @param  buffer           Buffer to receive size Bytes of data
 * @param  size             Bytes to receive. (Max 128Bytes for DS2406)
 * @param  start_address    Start address within device memory space
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void ds2406_get_memory(owm_t* driver,
                             uint8_t  device_address,
                             uint8_t* buffer,
                             uint8_t  size,
                             uint16_t start_address)
{
    uint32_t i;

    owm_address_device(driver, device_address);
    ds2406_send_command(driver, DS2406_COMMAND_READ_MEMORY);
    ds2406_address_memory(driver, start_address);

    for (i=0; i<size; i++)
    {
        buffer[i] = owm_receive_byte(driver);
    }
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Send command
 *
 * This function transmits command over the One Wire bus
 *
 * @param  driver   OWM Driver pointer as returned from owm_open
 * @param  command  Command Byte to send
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void ds2406_send_command(owm_t* driver, uint8_t command)
{
    owm_send_byte(driver, command);
}

///////////////////////////////////////////////////////////////////////////////
static void ds2406_address_memory(owm_t* driver, uint16_t start_address)
{
    uint16_t address = start_address & 0x007F;
    owm_send_byte(driver, (unsigned char)address);
    owm_send_byte(driver, (unsigned char)(address >> 8));
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Get device status
 *
 * This function retrieves the status of the addressed device
 *
 * @param  driver           OWM Driver pointer as returned from owm_open
 * @param  device_address   Index of device within device_list array
 * @param  buffer           Buffer for target bytes
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void ds2406_get_status(owm_t* driver, uint8_t device_address, uint8_t* buffer)
{
    uint32_t i;

    owm_address_device(driver, device_address);
    ds2406_send_command(driver, DS2406_COMMAND_READ_STATUS);
    ds2406_address_memory(driver, 0);

    for (i=0; i<DS2406_STATUS_MEMORY_SIZE; i++)
    {
        buffer[i] = owm_receive_byte(driver);
    }
}

///////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Read a device memory page 
 *
 * This function retrieves a single memory page from the addressed device.
 *
 * @param  driver           OWM Driver pointer as returned from owm_open
 * @param  device_address   Index of device within device_list array
 * @param  buffer           Buffer for received bytes(32 bytes for DS2406 page)
 * @param  page_number      Page number from 0 to 3
 *
 * @return Nothing
 */
///////////////////////////////////////////////////////////////////////////////
void ds2406_get_memory_page(owm_t* driver, uint8_t device_address, uint8_t* buffer, uint8_t page_number)
{
    uint16_t page_address;

    switch (page_number)
    {
        case DS2406_MEMORY_PAGE_0:
            {
                page_address = DS2406_MEMORY_PAGE_ADDRESS_0;
                break;
            }
        case DS2406_MEMORY_PAGE_1:
            {
                page_address = DS2406_MEMORY_PAGE_ADDRESS_1;
                break;
            }
        case DS2406_MEMORY_PAGE_2:
            {
                page_address = DS2406_MEMORY_PAGE_ADDRESS_2;
                break;
            }
        default:
            {
                page_address = DS2406_MEMORY_PAGE_ADDRESS_3;
                break;
            }
    }

    ds2406_get_memory(driver, device_address, buffer, DS2406_MEMORY_PAGE_SIZE, page_address);
}

