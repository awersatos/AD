/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Direct (non-blockio) interface for M25PX0 flash memory devices.
|*
\*****************************************************************************/

/**
 * @file
 * Device driver for SPI based M25Px0 serial flash memories
 *
 */

#include <assert.h>
#include <time.h>

#include <drv_spi.h>
#include <drv_m25px0.h>
#include "../internal/drv_m25px0_internal.h"
#include <drv_m25px0_cfg_instance.h>

// M25PX0 instruction set
#define M25PX0_INSTR_WREN       0x06    // Write enable
#define M25PX0_INSTR_WRDI       0x04    // Write disable
#define M25PX0_INSTR_RDSR       0x05    // Read status register
#define M25PX0_INSTR_WRSR       0x01    // Write status register
#define M25PX0_INSTR_READ       0x03    // Read data bytes
#define M25PX0_INSTR_FAST_READ  0x0B    // Read data bytes at higher speed
#define M25PX0_INSTR_PP         0x02    // Page program
#define M25PX0_INSTR_SE         0xD8    // Sector erase
#define M25PX0_INSTR_BE         0xC7    // Bulk erase
#define M25PX0_INSTR_DP         0xB9    // Deep power-down
#define M25PX0_INSTR_RES        0xAB    // Release from deep power down and optionally read electronic signature

// runtime driver table
static m25px0_t drv_table[DRV_M25PX0_INSTANCE_COUNT];

static int m25px0_send_cmd( spi_t * restrict spi, uint8_t channel, uint8_t cmd )
{
    int retval = M25PX0_ERR_SPI;

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    if ( (channel == 0) ||  spi_get_bus( spi, channel ))
    {
#endif
        spi_cs_hi( spi );
        spi_cs_lo( spi );
        spi_transceive8( spi, cmd );
        spi_cs_hi( spi );
        retval = M25PX0_ERR_OK;
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        if ( channel ) spi_release_bus( spi );
    }
#endif
    M25PX0_MUTEX_UNLOCK( drv );
    return retval;
}

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes both, the WB_SPI core and the serial flash memory (including drivers).
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise (for example: if the SPI bus could not be opened)
 */

m25px0_t * m25px0_open( unsigned id )
{
    assert( id < DRV_M25PX0_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    m25px0_t * restrict drv = &drv_table[id];
    drv_m25px0_cfg_instance_t * restrict drv_cfg = &drv_m25px0_instance_table[id];

    if ( drv->spi != NULL ) return drv;

#if DRV_M25PX0_USE_MUTEX
    pthread_mutexattr_t mutexattr;
    pthread_mutexattr_init( &mutexattr );
    pthread_mutex_init( &drv->mutex, &mutexattr );
#endif

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );

    if ( drv->spi = spi_open( drv_cfg->drv_spi ), !drv->spi ) return NULL;

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    drv->channel = drv_cfg->channel;
    spi_init_channel( drv->spi, drv->channel, drv_cfg->spi_freq, drv_cfg->spi_mode );
    if ( drv_cfg->bus_sharing && drv->spi && !spi_get_bus( drv->spi, drv->channel ) )
    {
        drv->spi = NULL;
    }
    else
    {
#else
        spi_set_baudrate( drv->spi, drv_cfg->spi_freq );
        spi_set_mode( drv->spi, drv_cfg->spi_mode );
#endif
        spi_cs_hi( drv->spi );                                                  // Reset chip's SPI FSM
        spi_set_endianess( drv->spi, true );
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_RES );
        for ( clock_t tres = clock() + 3 * CLOCKS_PER_SEC / 1000000; clock() < tres; ) __nop();
        drv->signature = (uint8_t)spi_transceive32( drv->spi, 0xFFFFFFFF ) & 0xFF;
        spi_cs_hi( drv->spi );

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        spi_release_bus( drv->spi );
    }
#endif
    M25PX0_MUTEX_UNLOCK( drv );
    return drv->spi ? drv : NULL;
}

/**
 * @brief    Retrieve chip status register
 *
 * This function reads the status register
 *
 * @param  drv pointer to chip's device driver
 *
 * @return errorcode if negative, contents of status register otherwise
 */

int m25px0_status( m25px0_t * drv )
{
    int retval = M25PX0_ERR_SPI;

    assert( drv != NULL );

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    if ( (drv->channel == 0 ) || spi_get_bus( drv->spi, drv->channel ))
    {
#endif
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_RDSR );
        retval = spi_transceive8( drv->spi, 0xFF );
        spi_cs_hi( drv->spi );
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        if ( drv->channel ) spi_release_bus( drv->spi );
    }
#endif
    M25PX0_MUTEX_UNLOCK( drv );
    return retval;
}

/**
 * @brief    Set write protection bits
 *
 * This function writes block protection bits in the status register
 *
 * @param  drv pointer to chip's device driver
 * @param  pattern defines the protection bits
 *
 * @return errorcode or 0 on succes
 */

int m25px0_set_protection( m25px0_t * drv, uint8_t pattern )
{
    int retval = M25PX0_ERR_SPI;
    uint8_t status;
    assert( drv != NULL );

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    if (( drv->channel == 0 ) || spi_get_bus( drv->spi, drv->channel ))
    {
#endif
        spi_cs_hi( drv->spi );                                              // Make sure flash memory's SPI FSM is reset
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_RDSR );
        status = spi_transceive8( drv->spi, 0xFF );                         // Get current status register
        spi_cs_hi( drv->spi );
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_WREN );                     // Enable writing
        spi_cs_hi( drv->spi );
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_WRSR );                     // Write new protection bits in status register
        spi_transceive8( drv->spi, (status & ~(M25PX0_STAT_BP2|M25PX0_STAT_BP1|M25PX0_STAT_BP0)) | pattern);
        spi_cs_hi( drv->spi );
        retval = M25PX0_ERR_OK;
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        if ( drv->channel ) spi_release_bus( drv->spi );
    }
#endif
    M25PX0_MUTEX_UNLOCK( drv );
    return retval;
}

/**
 * @brief    Erases the entire chip
 *
 * This function starts erasure of the complete device. Make sure that all block protection is off and
 * that all write instructions are completed before calling this function. Please note that chip erasure
 * can take a lot of time - a bulk erasure typically takes 10 seconds on a M25P80-V.
 *
 * @param  drv pointer to chip's device driver
 *
 * @return < 0: error code, 0 on success
 */

int m25px0_bulk_erase( m25px0_t * drv )
{
    int retval = M25PX0_ERR_SPI;
    assert( drv != NULL );

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    if (( drv->channel == 0 ) || spi_get_bus( drv->spi, drv->channel ))
    {
#endif
        spi_cs_hi( drv->spi );                                                  // Make sure flash memory's SPI FSM is reset
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_WREN );                     // Enable writing
        spi_cs_hi( drv->spi );
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_BE );                       // Start the bulk erase
        spi_cs_hi( drv->spi );
        retval = M25PX0_ERR_OK;

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        if ( drv->channel ) spi_release_bus( drv->spi );
    }
#endif
    return retval;
}

/**
 * @brief    Erases one sector of the chip
 *
 * This function starts erasure of one sector. Make sure that all block protection is off and
 * that all write instructions are completed before calling this function. Please note that chip erasure
 * can take a lot of time - a bulk erasure typically takes 10 seconds on a M25P80-V.
 *
 * @param  drv pointer to chip's device driver
 * @param   address a valid address in the range of the sector to be erased
 *
 * @return < 0: error code, 0 on success
 */

int m25px0_sector_erase( m25px0_t * restrict drv, uint32_t address )
{
    int retval = M25PX0_ERR_SPI;

    assert( drv != NULL );
    assert( (address & 0xFFFFFF) == address );

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    if (( drv->channel == 0 ) || spi_get_bus( drv->spi, drv->channel ))
    {
#endif
        spi_cs_hi( drv->spi );                                                  // Make sure flash memory's SPI FSM is reset
        spi_set_endianess( drv->spi, true );
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_WREN );                     // Enable writing
        spi_cs_hi( drv->spi );
        spi_cs_lo( drv->spi );
        spi_transceive32( drv->spi, (M25PX0_INSTR_SE << 24) | address );    // Start the sector erase
        spi_cs_hi( drv->spi );
        retval = M25PX0_ERR_OK;

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        if ( drv->channel ) spi_release_bus( drv->spi );
    }
#endif
    M25PX0_MUTEX_UNLOCK( drv );
    return retval;
}

/**
 * @brief    Programs a page
 *
 * This function starts programing data in the flash memory. A page spans from xxx00 up to xxxFF.
 * If programming crosses the upper boundary of a page, it continues from the lower boundary in
 * that same page. This function uses the m25px0 page program instruction which does only reset bits.
 * therefore you must start with an erased (bulk or sector) flash device (all bits set to 1) before 
 * using this function. Otherwise bits programmed to 1 will be ignored (stay 0). Note: you cannot
 * program more than 256 bytes at a time!
 *
 * @param   drv pointer to chip's device driver
 * @param   address address to start programming
 * @param   buffer pointer to buffer to store read data in
 * @param   buflen size of buffer, in bytes
 *
 * @return Number of bytes send to the chip for programming. 0 on error
 */


size_t m25px0_program_page( m25px0_t * restrict drv, uint32_t address, void * buffer, size_t buflen )
{
    size_t bytes;
    uint8_t * buf8;
    uint16_t * buf16;
    uint32_t * buf32;

    assert( drv != NULL );
    assert( (address & 0xFFFFFF) == address );
    assert( buffer != NULL );

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    if (( drv->channel == 0 ) || spi_get_bus( drv->spi, drv->channel ))
    {
#endif

        spi_cs_hi( drv->spi );                                               // Make sure flash memory's SPI FSM is reset
        spi_set_endianess( drv->spi, true );
        spi_cs_lo( drv->spi );
        spi_transceive8( drv->spi, M25PX0_INSTR_WREN );                     // Enable writing
        spi_cs_hi( drv->spi );
        __nop();
        spi_cs_lo( drv->spi );
        spi_transceive32( drv->spi, (M25PX0_INSTR_PP << 24) | address );    // Start the sector erase

        spi_set_endianess( drv->spi, __BIG_ENDIAN__ );                      // Switch endianess to native format

        // Maximize on 256 bytes
        if ( buflen > 256 )
        {
            buflen = 256;
        }

        bytes = buflen;
        buf8 = buffer;

        // Fix 8-bit alignment problems
        if( ((uintptr_t)buf8 & 0x01) && (bytes > 0) )
        {
            spi_transceive8( drv->spi, *buf8++ );
            bytes--;
        }

        // Fix 16-bit alignment problems

        buf16 = (uint16_t *)buf8;

        if( ((uintptr_t)buf16 & 0x02) && (bytes > 1) )
        {
            spi_transceive16( drv->spi, *buf16++ );
            bytes -= 2;
        }

        // Bulk write
        buf32 = (uint32_t *)buf16;
        while( bytes > 3 )
        {
            spi_transceive32( drv->spi, *buf32++ );
            bytes -= 4;
        }

        // Any trailing halfwords?
        buf16 = (uint16_t *)buf32;
        if( bytes & 0x02 )
        {
            spi_transceive16( drv->spi, *buf16++ );
        }

        // Any trailing bytes?
        buf8 = (uint8_t *)buf16;
        if( bytes & 0x01 )
        {
            spi_transceive8( drv->spi, *buf8 );
        }
        spi_cs_hi( drv->spi );

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        if ( drv->channel ) spi_release_bus( drv->spi );
    }
    else
    {
        buflen = 0;
    }
#endif
    M25PX0_MUTEX_UNLOCK( drv );
    return buflen;
}

/**
 * @brief    Reads data
 *
 * This function reads data from the flash memory.
 *
 * @param   drv pointer to chip's device driver
 * @param   address address to start reading from
 * @param   buffer pointer to buffer to store read data in
 * @param   buflen size of buffer, in bytes
 *
 * @return Number of bytes retrieved. 0 on error
 */

size_t m25px0_read( m25px0_t * restrict drv, uint32_t address, void * buffer, size_t buflen )
{
    uint8_t * buf8;
    uint16_t * buf16;
    uint32_t * buf32;

    size_t bytes;

    assert( drv != NULL );
    assert( (address & 0xFFFFFF) == address );
    assert( buffer != NULL );

    M25PX0_MUTEX_PREPARE();
    M25PX0_MUTEX_LOCK( drv );
    __nop();
#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
    if (( drv->channel == 0 ) || spi_get_bus( drv->spi, drv->channel ))
    {
#endif

        spi_cs_hi( drv->spi );                                          // Reset SPI FSM
        spi_set_endianess( drv->spi, true );                            // Send read command & address
        spi_cs_lo( drv->spi );
        spi_transceive32( drv->spi, (M25PX0_INSTR_READ << 24) | address);

        bytes = buflen;
        buf8 = buffer;

        // Fix 8-bit alignment problems
        if( ((uintptr_t)buf8 & 0x01) && (bytes > 0) )
        {
            *buf8++ = spi_transceive8( drv->spi, 0xFF );
            bytes--;
        }

        // Fix 16-bit alignment problems

        buf16 = (uint16_t *)buf8;

        if( ((uintptr_t)buf16 & 0x02) && (bytes > 1) )
        {
            *buf16++ = spi_transceive16( drv->spi, 0xFFFF );
            bytes -= 2;
        }

        // Bulk read
        buf32 = (uint32_t *)buf16;
        while( bytes > 3 )
        {
            *buf32++ = spi_transceive32( drv->spi, 0xFFFFFFFF );
            bytes -= 4;
        }

        // Any trailing halfwords?
        buf16 = (uint16_t *)buf32;
        if( bytes & 0x02 )
        {
            *buf16++ = spi_transceive16( drv->spi, 0xFFFF );
        }

        // Any trailing bytes?
        buf8 = (uint8_t *)buf16;
        if( bytes & 0x01 )
        {
            *buf8 = spi_transceive8( drv->spi, 0xFF );
        }
        spi_cs_hi( drv->spi );

#if DRV_M25PX0_INSTANCE_BUS_SHARING_TRUE_USED
        if ( drv->channel ) spi_release_bus( drv->spi );
    }
    else
    {
        buflen = 0;
    }
#endif
    M25PX0_MUTEX_UNLOCK( drv );
    return buflen;
}

/**
 * @brief    Put chip in deep power-down
 *
 * This function puts the M25Px0 in low power consumption mode.
 *
 * @param  drv pointer to chip's device driver
 *
 * @return errorcode or 0 on succes
 */

int m25px0_power_down( m25px0_t * restrict drv )
{
    assert( drv != NULL );

    // Note: locking and bus reservation are handled locally in m25px0_send_cmd()
    return m25px0_send_cmd( drv->spi, drv->channel, M25PX0_INSTR_DP );
}

/**
 * @brief    Wake up the chip from deep power-down
 *
 * This function wakes M25Px0 from low power consumption mode. Note: after return, you must
 * wait for at least 3 usec before executing other commands!
 *
 * @param  drv pointer to chip's device driver
 *
 * @return errorcode or 0 on succes
 */

int m25px0_wake_up( m25px0_t * restrict drv )
{
    assert( drv != NULL );

    // Note: locking and bus reservation are handled locally in m25px0_send_cmd()
    return m25px0_send_cmd( drv->spi, drv->channel, M25PX0_INSTR_RES );
}

