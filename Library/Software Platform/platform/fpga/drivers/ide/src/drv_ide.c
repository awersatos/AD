/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    IDE driver (non-posix interface).
|*
\*****************************************************************************/

/**
 * @file drv_ide.h
 *
 * @brief
 *      IDE driver
 *
 * This driver provides access to the WB_IDE peripheral. An IDE controller
 * can control two devices, a master and a slave device. These devices can
 * either be regular hard disks or CF card readers.
 *
 * Requires: <a href="ide.chm::/index.htm">WB_IDE peripheral</a>.
 */

#include <stdint.h>
#include <stdbool.h>
#include <assert.h>

#include <timing.h>
#include <sysutils.h>
#include <per_ide.h>
#include <drv_ide.h>

#include "drv_ide_cfg_instance.h"

/*
 * mutex support
 */

#if ( DRV_IDE_USE_MUTEX != 0 )
# define IDE_MUTEX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(ide_mutex_buffer)
# define IDE_MUTEX_LOCK( ide )          POSIX_DEV_MUTEX_LOCK(&ide->mutex, ide_mutex_buffer)
# define IDE_MUTEX_UNLOCK( ide )        POSIX_DEV_MUTEX_UNLOCK(&ide->mutex, ide_mutex_buffer)
#else
# define IDE_MUTEX_PREPARE()            do {} while (0)
# define IDE_MUTEX_LOCK( ide )          do {} while (0)
# define IDE_MUTEX_UNLOCK( ide )        do {} while (0)
#endif

/*
 * IDE Commands
 */
#define IDE_COMMAND_READ_SECTORS        0x20
#define IDE_COMMAND_READ_MULTIPLE       0xC4
#define IDE_COMMAND_WRITE_SECTORS       0x30
#define IDE_COMMAND_IDENTIFY_DEVICE     0xEC
#define IDE_COMMAND_SET_FEATURES        0xEF

/*
 * IDE Registers
 */
//                                                // CS1- CS0- DA2 DA1 DA0
#define IDE_DATA                        0x0010  //  N    A    N   N   N   => 1 0 0 0 0     Read/Write
#define IDE_ERROR                       0x0011  //  N    A    N   N   A   => 1 0 0 0 1     Read-only
#define IDE_FEATURES                    0x0011  //  N    A    N   N   A   => 1 0 0 0 1     Write-only
#define IDE_SECTOR_COUNT                0x0012  //  N    A    N   A   N   => 1 0 0 1 0     Read/Write
#define IDE_LBA_LOW                     0x0013  //  N    A    N   A   A   => 1 0 0 1 1     Read/Write
#define IDE_LBA_MID                     0x0014  //  N    A    A   N   N   => 1 0 1 0 0     Read/Write
#define IDE_LBA_HIGH                    0x0015  //  N    A    A   N   A   => 1 0 1 0 1     Read/Write
#define IDE_DEVICE                      0x0016  //  N    A    A   A   N   => 1 0 1 1 0     Write-only
#define IDE_COMMAND                     0x0017  //  N    A    A   A   A   => 1 0 1 1 1     Write-only
#define IDE_STATUS                      0x0017  //  N    A    A   A   A   => 1 0 1 1 1     Read-only
#define IDE_DEVICE_CONTROL              0x000E  //  A    N    A   A   N   => 0 1 1 1 0     Write-only

#define IDE_ALTSTATUS                   IDE_DEVICE_CONTROL      // Read-only
#define IDE_SECTOR                      IDE_LBA_LOW
#define IDE_CYLINDER_LOW                IDE_LBA_MID
#define IDE_CYLINDER_HIGH               IDE_LBA_HIGH

/*
 * IDE Constants
 */
#define IDE_FEATURES_SETTRANSFERMODE    0x03
#define IDE_DEVICE_CONTROL_SRST         0x04

#define IDE_STATUS_ERR                  0x01
#define IDE_STATUS_DRQ                  0x08
#define IDE_STATUS_BSY                  0x80
#define IDE_STATUS_DRDY                 0x40

#define IDE_DEVICE_0                    0x00
#define IDE_DEVICE_1                    0x10
#define IDE_DEVICE_LBAMODE              0x40

#define IDE_SECTORSIZE                  512

// init flags
#define IDE_INIT_CORE                   0x1
#define IDE_INIT_DEVICE                 0x2

struct ide_s
{
    uintptr_t baseaddr;
    bool slave;
    uintptr_t dma_from;
    uintptr_t dma_to;
    int timeout;
    uint16_t cylinders;
    uint8_t heads;
    uint8_t sectorspertrack;
    uint32_t lbasectors;
    ide_info_t info;
#if ( DRV_IDE_USE_MUTEX != 0 )
    pthread_mutex_t mutex;
#endif
    unsigned int initflags;
};

static ide_t ide_table[DRV_IDE_INSTANCE_COUNT];

//............................................................................
// Convenience macros and functions

#define ide_wait_for(baseaddr, musthave, mustnothave) \
    while ( !ide_check_status(baseaddr,musthave,mustnothave) ) {/**/}

#define ide_wait_while_busy(baseaddr)       ide_wait_for(baseaddr, IDE_STATUS_DRDY, IDE_STATUS_BSY)
#define ide_wait_for_data_request(baseaddr) ide_wait_for(baseaddr, IDE_STATUS_DRQ, 0)

//............................................................................
inline uint8_t ide_get_register( uintptr_t baseaddr, uint16_t reg )
{
    uint32_t val;

    IDECORE_COMMAND( baseaddr ) = reg;
    do
    {
        val = IDECORE_DATA( baseaddr );
    }
    while ( val & IDECORE_DATA_BUSY );

    return ( uint8_t ) ( val & 0xFF );
}

//............................................................................
inline void ide_set_register( uintptr_t baseaddr, uint16_t reg, uint8_t val )
{
    IDECORE_DATA( baseaddr ) = val;     //((uint16_t) val) << 8;
    IDECORE_COMMAND( baseaddr ) = reg | IDECORE_COMMAND_WRITE | IDECORE_COMMAND_BUSYCHECK;

    while ( IDECORE_DATA( baseaddr ) & IDECORE_DATA_BUSY )
        /**/;
}

//............................................................................
inline bool ide_check_status( uintptr_t baseaddr, uint8_t musthave, uint8_t mustnothave )
{
    return ( ( ide_get_register( baseaddr, IDE_STATUS ) & ( musthave | mustnothave ) ) == musthave );
}

//............................................................................
inline int timed_wait_for( uintptr_t baseaddr, uint8_t musthave, uint8_t mustnothave, int timeout )
{
    uint64_t mark = 0;

    if ( timeout )
    {
        mark = clock_ms(  );
    }

    while ( !ide_check_status( baseaddr, musthave, mustnothave ) )
    {
        if ( timeout && elapsed_time_ms( mark ) > timeout )
        {
            return -1;
        }
    }
    return 0;
}

//............................................................................
inline void printinfo( uint16_t *buf16, uint32_t slave )
{
#ifdef __SSAS_DEBUG__
    debug_printf( "IDE ide %u found\n", slave );

    debug_printf( "\nmodel: " );
    char *p = ( char * ) ( buf16 + 27 );
    for ( int i = 20; i; p += 2, --i )
    {
        debug_printf( "%c%c", p[1], p[0] );
    } debug_printf( "\n" );
    debug_printf( "serial: \n" );
    p = ( char * ) ( buf16 + 10 );
    for ( int i = 10; i; p += 2, --i )
    {
        debug_printf( "%c%c", p[1], p[0] );
    }
    debug_printf( "\nfirmware: " );
    p = ( char * ) ( buf16 + 23 );
    for ( int i = 4; i; p += 2, --i )
    {
        debug_printf( "%c%c", p[1], p[0] );
    }
    debug_printf( "\n" );

    debug_printf( "cylinders/heads/sectors: %i/%i/%i\n",
                  little16( buf16[1] ), little16( buf16[3] ) & 0xFF, little16( buf16[6] ) & 0xFF );
    debug_printf( "sectors 28-bit LBA mode: %i\n", read_little32from16( ( uint8_t * ) &buf16[60] ) );

    debug_printf( "capabilities: " );
    uint16_t cap = little16( buf16[49] );
    if ( cap & 0x0800 )
    {
        debug_printf( "IORDY " );
    }
    if ( cap & 0x0400 )
    {
        debug_printf( "IORDY-disable " );
    }
    if ( cap & 0x0200 )
    {
        debug_printf( "LBA " );
    }
    if ( cap & 0x0100 )
    {
        debug_printf( "DMA " );
    }
    debug_printf( "\n" );

    debug_printf( "PIO modes: (0/1/2) " );
    uint16_t piomodes = little16( buf16[64] );
    if ( piomodes & ( 1 << 0 ) )
    {
        debug_printf( "3 " );
    }
    if ( piomodes & ( 1 << 1 ) )
    {
        debug_printf( "4 " );
    }
    debug_printf( "\nPIO without/with flow control (ns): %i/%i\n",
                  little16( buf16[67] ), little16( buf16[68] ) );

    debug_printf( "DMA modes: " );
    uint16_t dmamodes = little16( buf16[63] );
    if ( dmamodes & ( 1 << 0 ) )
    {
        debug_printf( "0 " );
    }
    if ( dmamodes & ( 1 << 1 ) )
    {
        debug_printf( "1 " );
    }
    if ( dmamodes & ( 1 << 2 ) )
    {
        debug_printf( "2 " );
    }
    debug_printf( "\nDMA minimum/recommended cycletime (ns): %i/%i\n",
                  little16( buf16[65] ), little16( buf16[66] ) );

    debug_printf( "UDMA modes: " );
    uint16_t udmamodes = little16( buf16[88] );
    if ( udmamodes & ( 1 << 0 ) )
    {
        debug_printf( "0 " );
    }
    if ( udmamodes & ( 1 << 1 ) )
    {
        debug_printf( "1 " );
    }
    if ( udmamodes & ( 1 << 2 ) )
    {
        debug_printf( "2 " );
    }
    if ( udmamodes & ( 1 << 3 ) )
    {
        debug_printf( "3 " );
    }
    if ( udmamodes & ( 1 << 4 ) )
    {
        debug_printf( "4 " );
    }
    if ( udmamodes & ( 1 << 5 ) )
    {
        debug_printf( "5 " );
    }
    debug_printf( "\n" );
#endif
}

//............................................................................
// Read IDE error register

static uint16_t ide_errorcheck( uintptr_t baseaddr )
{
    uint16_t status = ide_get_register( baseaddr, IDE_STATUS ) & IDE_STATUS_ERR;

    if ( status )
    {
        uint8_t errornr = ide_get_register( baseaddr, IDE_ERROR ) & 0xFF;

        debug_printf( "\nIDE status %02X - error: ", status );
        switch ( errornr )
        {
        case 0x00:
            debug_printf( "no additional info\n" );
            break;
        case 0x10:
            debug_printf( "ID not found / ID error\n" );
            break;
        default:
            debug_printf( "%02X\n", errornr );
            break;
        }
    }

    return status;
}

//............................................................................
// Read sector(s) of data from IDE device

static void ide_read_buf( uintptr_t baseaddr, void *buf, uint8_t blkcount, uint8_t use_dma )
{
    // wordaligned is about the same speed as halfword (5% faster), but the
    // bandwidth needed on the memorybus is half that of wordaligned access.
    // both are at least 25% faster compared to bytealigned access.

    switch ( ( ( uint32_t ) buf ) & 0x03 )
    {
    case 0x00:
        if ( use_dma )
        {
            // word aligned
            while ( blkcount-- )
            {
                ide_wait_for_data_request( baseaddr );

                IDECORE_MEMSTART( baseaddr ) = ( uint32_t ) buf;
                IDECORE_COMMAND( baseaddr ) = IDE_DATA | IDECORE_COMMAND_SECTOR;
                while ( IDECORE_DATA( baseaddr ) & IDECORE_DATA_BUSY )
                {
                    __nop(  );
                }

                buf = ( uint8_t * ) buf + IDE_SECTORSIZE;

                ide_get_register( baseaddr, IDE_ALTSTATUS );    // wait at least PIO cycle delay before status is valid
                ide_wait_while_busy( baseaddr );
            }
            break;
        }
        // fall through

    case 0x02:
        // half word aligned
        while ( blkcount-- )
        {
            ide_wait_for_data_request( baseaddr );

            for ( uint16_t i = IDE_SECTORSIZE / sizeof( uint16_t ); i; --i )
            {
                uint32_t data;
                IDECORE_COMMAND( baseaddr ) = IDE_DATA;
                do
                {
                    data = IDECORE_DATA( baseaddr );
                }
                while ( data & IDECORE_DATA_BUSY );

                write_little16to16( buf, data & 0xFFFF );
                buf = ( uint16_t * ) buf + 1;
            }

            ide_get_register( baseaddr, IDE_ALTSTATUS );        // wait at least PIO cycle delay before status is valid
            ide_wait_while_busy( baseaddr );
        }
        break;

    default:
        // byte aligned
        while ( blkcount-- )
        {
            ide_wait_for_data_request( baseaddr );

            for ( uint16_t i = IDE_SECTORSIZE / sizeof( uint16_t ); i; --i )
            {
                uint32_t data;
                IDECORE_COMMAND( baseaddr ) = IDE_DATA;
                do
                {
                    data = IDECORE_DATA( baseaddr );
                }
                while ( data & IDECORE_DATA_BUSY );

                write_little16to8( buf, data & 0xFFFF );
                buf = ( uint8_t * ) buf + 2;
            }

            ide_get_register( baseaddr, IDE_ALTSTATUS );        // wait at least PIO cycle delay before status is valid
            ide_wait_while_busy( baseaddr );
        }
        break;

    }
}

//............................................................................
// Write sector(s) of data to IDE device

static void ide_write_buf( uintptr_t baseaddr, const void *buf, uint8_t blkcount, uint8_t use_dma )
{
    const uint32_t *buf32 = ( uint32_t * ) buf;

    if ( !buf )
    {
        // blanking
        IDECORE_DATA( baseaddr ) = 0;
        while ( blkcount-- )
        {
            ide_wait_for_data_request( baseaddr );

            for ( uint16_t i = IDE_SECTORSIZE / sizeof( uint16_t ); i; --i )
            {
                IDECORE_COMMAND( baseaddr ) = IDE_DATA | IDECORE_COMMAND_WRITE;

                while ( IDECORE_DATA( baseaddr ) & IDECORE_DATA_BUSY )
                {
                    __nop(  );
                }
            }

            ide_get_register( baseaddr, IDE_ALTSTATUS );        // wait at least PIO cycle delay before status is valid
            ide_wait_while_busy( baseaddr );
        }
    }
    else
    {
        switch ( ( ( uint32_t ) buf ) & 0x03 )
        {
        case 0x00:
            if ( use_dma )
            {
                // word aligned
                while ( blkcount-- )
                {
                    ide_wait_for_data_request( baseaddr );

                    IDECORE_MEMSTART( baseaddr ) = ( uint32_t ) buf32;
                    IDECORE_COMMAND( baseaddr ) = IDE_DATA | IDECORE_COMMAND_WRITE | IDECORE_COMMAND_SECTOR;

                    while ( IDECORE_DATA( baseaddr ) & IDECORE_DATA_BUSY )
                    {
                        __nop(  );
                    }
                    ide_get_register( baseaddr, IDE_ALTSTATUS );        // wait at least PIO cycle delay before status is valid

                    ide_wait_while_busy( baseaddr );
                    buf32 += ( IDE_SECTORSIZE / sizeof( buf32[0] ) );
                }
                break;
            }
            // fall through

        case 0x02:
            // half word aligned
            while ( blkcount-- )
            {
                ide_wait_for_data_request( baseaddr );

                for ( uint16_t i = IDE_SECTORSIZE / sizeof( uint16_t ); i; --i )
                {
                    IDECORE_DATA( baseaddr ) = read_little16from16( ( void * ) buf );
                    buf = ( uint16_t * ) buf + 1;
                    IDECORE_COMMAND( baseaddr ) = IDE_DATA | IDECORE_COMMAND_WRITE;

                    while ( IDECORE_DATA( baseaddr ) & IDECORE_DATA_BUSY )
                    {
                        __nop(  );
                    }
                }

                ide_get_register( baseaddr, IDE_ALTSTATUS );    // wait at least PIO cycle delay before status is valid
                ide_wait_while_busy( baseaddr );
            }
            break;

        default:
            // byte aligned
            while ( blkcount-- )
            {
                ide_wait_for_data_request( baseaddr );

                for ( uint16_t i = IDE_SECTORSIZE / sizeof( uint16_t ); i; --i )
                {
                    uint16_t data = read_little16from8( ( void * ) buf );
                    buf = ( uint8_t * ) buf + 2;

                    IDECORE_DATA( baseaddr ) = data;
                    IDECORE_COMMAND( baseaddr ) = IDE_DATA | IDECORE_COMMAND_WRITE;

                    while ( IDECORE_DATA( baseaddr ) & IDECORE_DATA_BUSY )
                    {
                        __nop(  );
                    }
                }

                ide_get_register( baseaddr, IDE_ALTSTATUS );    // wait at least PIO cycle delay before status is valid
                ide_wait_while_busy( baseaddr );
            }
            break;

        }
    }
}

//............................................................................
// CHS addressing

inline void ide_read_sectors_chs( uintptr_t baseaddr, bool slave, void *buf, uint16_t cylinder,
                                  uint8_t head, uint8_t startsector, uint8_t blkcount, uint8_t use_dma )
{
    ide_wait_for( baseaddr, IDE_STATUS_DRDY, IDE_STATUS_DRQ | IDE_STATUS_BSY );
    ide_set_register( baseaddr, IDE_DEVICE, ( slave ? IDE_DEVICE_1 : IDE_DEVICE_0 ) | head );
    ide_set_register( baseaddr, IDE_CYLINDER_HIGH, cylinder >> 8 );
    ide_set_register( baseaddr, IDE_CYLINDER_LOW, cylinder & 0xFF );
    ide_set_register( baseaddr, IDE_SECTOR, startsector );
    ide_set_register( baseaddr, IDE_SECTOR_COUNT, blkcount );
    ide_set_register( baseaddr, IDE_COMMAND, IDE_COMMAND_READ_SECTORS );

    if ( !ide_errorcheck( baseaddr ) )
    {
        ide_read_buf( baseaddr, buf, blkcount, use_dma );
    }
}

inline void ide_write_sectors_chs( uintptr_t baseaddr, bool slave, const void *buf, uint16_t cylinder,
                                   uint8_t head, uint8_t startsector, uint8_t blkcount, uint8_t use_dma )
{
    ide_wait_for( baseaddr, IDE_STATUS_DRDY, IDE_STATUS_DRQ | IDE_STATUS_BSY );
    ide_set_register( baseaddr, IDE_DEVICE, ( slave ? IDE_DEVICE_1 : IDE_DEVICE_0 ) | head );
    ide_set_register( baseaddr, IDE_CYLINDER_HIGH, cylinder >> 8 );
    ide_set_register( baseaddr, IDE_CYLINDER_LOW, cylinder & 0xFF );
    ide_set_register( baseaddr, IDE_SECTOR, startsector );
    ide_set_register( baseaddr, IDE_SECTOR_COUNT, blkcount );
    ide_set_register( baseaddr, IDE_COMMAND, IDE_COMMAND_WRITE_SECTORS );

    if ( !ide_errorcheck( baseaddr ) )
    {
        ide_write_buf( baseaddr, buf, blkcount, use_dma );
    }
}

//............................................................................
// LBA addressing

inline void ide_read_sectors_lba( uintptr_t baseaddr, bool slave, void *buf, uint32_t lba,
                                  uint8_t blkcount, uint8_t use_dma )
{
    ide_wait_for( baseaddr, IDE_STATUS_DRDY, IDE_STATUS_DRQ | IDE_STATUS_BSY );
    ide_set_register( baseaddr, IDE_DEVICE,
                      IDE_DEVICE_LBAMODE | ( slave ? IDE_DEVICE_1 : IDE_DEVICE_0 ) | ( lba >> 24 ) & 0x0F );
    ide_set_register( baseaddr, IDE_LBA_HIGH, ( lba >> 16 ) & 0xFF );
    ide_set_register( baseaddr, IDE_LBA_MID, ( lba >> 8 ) & 0xFF );
    ide_set_register( baseaddr, IDE_LBA_LOW, lba & 0xFF );
    ide_set_register( baseaddr, IDE_SECTOR_COUNT, blkcount );
    ide_set_register( baseaddr, IDE_COMMAND, IDE_COMMAND_READ_SECTORS );

    if ( !ide_errorcheck( baseaddr ) )
    {
        ide_read_buf( baseaddr, buf, blkcount, use_dma );
    }
}

inline void ide_write_sectors_lba( uintptr_t baseaddr, bool slave, const void *buf, uint32_t lba,
                                   uint8_t blkcount, uint8_t use_dma )
{
    ide_wait_for( baseaddr, IDE_STATUS_DRDY, IDE_STATUS_DRQ | IDE_STATUS_BSY );
    ide_set_register( baseaddr, IDE_DEVICE,
                      IDE_DEVICE_LBAMODE | ( slave ? IDE_DEVICE_1 : IDE_DEVICE_0 ) | ( lba >> 24 ) & 0x0F );
    ide_set_register( baseaddr, IDE_LBA_HIGH, ( lba >> 16 ) & 0xFF );
    ide_set_register( baseaddr, IDE_LBA_MID, ( lba >> 8 ) & 0xFF );
    ide_set_register( baseaddr, IDE_LBA_LOW, lba & 0xFF );
    ide_set_register( baseaddr, IDE_SECTOR_COUNT, blkcount );
    ide_set_register( baseaddr, IDE_COMMAND, IDE_COMMAND_WRITE_SECTORS );

    if ( !ide_errorcheck( baseaddr ) )
    {
        ide_write_buf( baseaddr, buf, blkcount, use_dma );
    }
}

//............................................................................
// Read data
inline int read_sectors( ide_t * restrict ide, uint8_t *data, uint32_t lba, uint32_t blkcount )
{
    uint32_t count = blkcount;
    uint8_t dma = ( ( ( ( uintptr_t ) data ) >= ide->dma_from )
                    && ( ( ( uintptr_t ) data ) < ide->dma_to ) ) ? 1 : 0;

    if ( ide->lbasectors )
    {
        while ( count )
        {
            uint16_t blocks = ( count >= ide->sectorspertrack ) ? ide->sectorspertrack : count;
            ide_read_sectors_lba( ide->baseaddr, ide->slave, ( void * ) data, lba, blocks & 0xFF, dma );
            count -= blocks;
            lba += blocks;
            data = data + blocks * IDE_SECTORSIZE;
        }
    }
    else
    {
        for ( ;; )
        {
            uint8_t startsector = lba % ide->sectorspertrack;
            uint8_t head = ( lba / ide->sectorspertrack ) % ide->heads;
            uint16_t cylinder = ( lba / ide->sectorspertrack / ide->heads ) & 0xFFFF;
            uint8_t maxsectors = ide->sectorspertrack - startsector;

            if ( count > maxsectors )
            {
                ide_read_sectors_chs( ide->baseaddr, ide->slave, ( void * ) data, cylinder, head,
                                      startsector + 1, maxsectors, dma );
                lba += maxsectors;
                data = data + maxsectors * IDE_SECTORSIZE;
                count -= maxsectors;
            }
            else
            {
                ide_read_sectors_chs( ide->baseaddr, ide->slave, ( void * ) data, cylinder, head,
                                      startsector + 1, count & 0xFF, dma );
                break;
            }
        }
    }

    return blkcount;
}

//............................................................................
// Write data
inline int write_sectors( ide_t * restrict ide, const uint8_t *data, uint32_t lba, uint32_t blkcount )
{
    uint32_t count = blkcount;
    uint8_t dma = ( ( ( ( uintptr_t ) data ) >= ide->dma_from )
                    && ( ( ( uintptr_t ) data ) < ide->dma_to ) ) ? 1 : 0;

    if ( ide->lbasectors )
    {
        while ( count )
        {
            uint16_t blocks = ( count >= ide->sectorspertrack ) ? ide->sectorspertrack : count;
            ide_write_sectors_lba( ide->baseaddr, ide->slave, ( const void * ) data, lba, blocks & 0xFF,
                                   dma );
            count -= blocks;
            lba += blocks;
            if ( data )
            {
                data = ( uint8_t * ) data + blocks * IDE_SECTORSIZE;
            }
        }
    }
    else
    {
        for ( ;; )
        {
            uint8_t startsector = lba % ide->sectorspertrack;
            uint8_t head = ( lba / ide->sectorspertrack ) % ide->heads;
            uint16_t cylinder = ( lba / ide->sectorspertrack / ide->heads ) & 0xFFFF;
            uint8_t maxsectors = ide->sectorspertrack - startsector;

            if ( count > ( uint32_t ) maxsectors )
            {
                ide_write_sectors_chs( ide->baseaddr, ide->slave, ( const void * ) data, cylinder, head,
                                       startsector + 1, maxsectors, dma );
                lba += maxsectors;
                if ( data )
                {
                    data = ( uint8_t * ) data + maxsectors * IDE_SECTORSIZE;
                }
                count -= maxsectors;
            }
            else
            {
                ide_write_sectors_chs( ide->baseaddr, ide->slave, ( const void * ) data, cylinder, head,
                                       startsector + 1, count & 0xFF, dma );
                break;
            }
        }
    }

    return blkcount;
}

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize the IDE controller
 *
 * This function initializes the IDE controller. Opening a device connected to
 * the IDE controller requires two steps: first call this function to obtain an
 * ide driver pointer, then call <code>ide_select_device()</code> to open the
 * device. The only case where this call returns NULL is when there is no CF
 * card present in the reader.
 *
 * Some driver functions can be called without first selecting a device:
 * - <code>ide_detect()</code>
 * - <code>ide_hardreset()</code>
 * - <code>ide_powerdown()</code>
 *
 * @param id
 *      Driver id (defined in devices.h)
 *
 * @return
 *      The ide driver pointer for the specified device, or NULL on error.
 */
extern ide_t *ide_open( int id )
{
    ide_t *ide;
    const drv_ide_cfg_instance_t *cfg;
    const per_ide_cfg_instance_t *per_cfg;
#if ( DRV_IDE_USE_MUTEX != 0 )
    pthread_mutexattr_t mutexattr;
#endif

    assert( id >= 0 && id < DRV_IDE_INSTANCE_COUNT );
    ide = &ide_table[id];


    if ( ide->initflags & IDE_INIT_CORE )
    {
        return ide;
    }

    cfg = &drv_ide_instance_table[id];
    per_cfg = &per_ide_instance_table[cfg->per_ide];

    assert(per_cfg->baseaddress != 0);
    ide->baseaddr = per_cfg->baseaddress;
    ide->slave = cfg->slave;
    ide->dma_from = cfg->dma_from;
    ide->dma_to = cfg->dma_to;
    ide->timeout = cfg->timeout;
    ide->cylinders = 0;
    ide->heads = 0;
    ide->sectorspertrack = 0;
    ide->lbasectors = 0;

#if ( DRV_IDE_USE_MUTEX != 0 )
    pthread_mutexattr_init( &mutexattr );
    pthread_mutex_init( &ide->mutex, &mutexattr );
#endif

    if ( cfg->cfcard )
    {
        if ( ide_detect( ide ) == 0 )
        {
            return NULL;
        }
        ide_powerdown( ide, true );
        delay_ms( 100 );
        ide_powerdown( ide, false );
    }
    ide_hardreset( ide );

    ide->initflags |= IDE_INIT_CORE;
    return ide;
}

/**
 * @brief
 *      Detect the presence of a CF card
 *
 * If the IDE controller is connected to a CF card reader, you can use this
 * function to detect whether there is a card present in the reader.
 *
 * @param ide
 *      ide driver pointer
 *
 * @return
 *      True if a CF card is present, false otherwise.
 */
extern bool ide_detect( ide_t * restrict ide )
{
    return ( ( IDECORE_DATA( ide->baseaddr ) & IDECORE_DATA_DETECT ) != 0 );
}

/**
 * @brief
 *      Reset the IDE controller and all attached devices
 *
 * This function uses a hardware reset to reset the IDE core and all devices
 * attached to it.
 *
 * @param ide
 *      ide driver pointer
 *
 * @return
 *      Nothing.
 */
extern void ide_hardreset( ide_t * restrict ide )
{
    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );
    IDECORE_SETUP( ide->baseaddr ) |= IDECORE_SETUP_RESET;
    delay_us( 25 );
    IDECORE_SETUP( ide->baseaddr ) &= ~IDECORE_SETUP_RESET;
    IDE_MUTEX_UNLOCK( ide );
}

/**
 * @brief
 *      Power attached devices off or on
 *
 * Turn power off or on for all devices attached to the IDE controller.
 *
 * @param ide
 *      ide driver pointer
 * @param off
 *      True to turn power off, false to turn it on
 *
 * @return
 *      Nothing.
 */
extern void ide_powerdown( ide_t * restrict ide, bool off )
{
    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );
    if ( off )
    {
        IDECORE_SETUP( ide->baseaddr ) |= IDECORE_SETUP_POWERDOWN;
    }
    else
    {
        IDECORE_SETUP( ide->baseaddr ) &= ~IDECORE_SETUP_POWERDOWN;
    }
    IDE_MUTEX_UNLOCK( ide );
}


// working part from ide_piomode without the mutex
static void ide_piomode_internal( ide_t * restrict ide, unsigned int piomode, unsigned int min_piocycle)
{
    int piocycle;
    int setup;
    int pulse;
    int recover;
    int cpucycle;

    switch (piomode)
    {
    case 6:
        piocycle = 80;
        setup = 10;
        pulse = 55;
        if (min_piocycle <= piocycle) break; /* optional fallthrough */

    case 5:
        piocycle = 100;
        setup = 15;
        pulse = 65;
        if (min_piocycle <= piocycle) break; /* optional fallthrough */

    case 4:
        piocycle = 120;
        setup = 25;
        pulse = 70;
        if (min_piocycle <= piocycle) break; /* optional fallthrough */

    case 3:
        piocycle = 180;
        setup = 30;
        pulse = 80;
        if (min_piocycle <= piocycle) break; /* optional fallthrough */

    case 2:
        piocycle = 240;
        setup = 30;
        pulse = 100;
        if (min_piocycle <= piocycle) break; /* optional fallthrough */

    case 1:
        piocycle = 383;
        setup = 50;
        pulse = 125;
        if (min_piocycle <= piocycle) break; /* optional fallthrough */

    case 0:
    default:
        piocycle = 600;
        setup = 70;
        pulse = 165;
        break;

    }

    // math below ends up to:
    // PIO mode 0 at 50MHz setup=3 pulse=8 delay=16 (safe mode at boot)
    // PIO mode 2 at 50MHz setup=1 pulse=4 delay=4 (default mode for all disks)
    // PIO mode 4 at 50MHz setup=1 pulse=2 delay=0 (max mode for core)

    cpucycle = 1000000000 / freq_hz();

    piocycle = (piocycle + (cpucycle - 1)) / cpucycle;
    setup = (setup + (cpucycle - 1)) / cpucycle;

    pulse = (pulse + (cpucycle - 1)) / cpucycle;
    recover = piocycle - pulse;

    if ((setup -= 1) < 0) setup = 0;
    if ((pulse -= 2) < 0) pulse = 0;
    if ((recover -= 2) < 0) recover = 0;

    IDECORE_SETUP( ide->baseaddr ) =
#ifdef __LITTLE_ENDIAN__
        IDECORE_SETUP_LITTLEENDIAN |
#endif
        ( ide->slave ? IDECORE_SETUP_CSEL : 0 ) | ( recover << 8 ) | ( pulse << 3 ) | setup;

    debug_printf( "PIO mode %i setup=%i pulse=%i recover=%i", piomode, setup, pulse, recover );
    debug_printf( " (%i MHz=%i ns: setup=%i ns, pulse/recover/cycle=%i/%i/%i ns)\n",
                  freq_hz() / 1000000, cpucycle,
                  (1 + setup) * cpucycle, (2 + pulse) * cpucycle, (2 + recover) * cpucycle, (2 + pulse + 2 + recover) * cpucycle );
}


/**
 * @brief
 *      Set the piomode for the attached device
 *
 * This function sets up the core to the given PIO mode speed.
 *
 * @param ide
 *      ide driver pointer
 * @param piomode
 *      supported modes (0/1/2/3/4/5/6)
 *
 * @return
 *      Nothing.
 */
extern void ide_piomode( ide_t * restrict ide, unsigned int piomode)
{
    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );

    ide_piomode_internal(ide, piomode, 0);

    IDE_MUTEX_UNLOCK( ide );
}


/**
 * @brief
 *      Open device attached to the IDE controller
 *
 * This function initializes a device attached to the IDE controller. The
 * device can be the master device or the slave device. In the plugin
 * configuration you can select whether the device is a master or a slave
 * device and whether it is a regular hard disk or a CF card reader.
 *
 * @param ide
 *      ide driver pointer
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int ide_open_device( ide_t * restrict ide )
{
    uint32_t buf32[IDE_SECTORSIZE / sizeof( uint32_t )];
    uint16_t *buf16;
    uint16_t piomodeflags;
    int piomode;

    if ( ide->initflags & IDE_INIT_DEVICE )
    {
        return 0;
    }
    if ( !(ide->initflags & IDE_INIT_CORE) )
    {
        return -1;
    }

    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );

    ide_piomode_internal(ide, 0, 0);

    ide_set_register( ide->baseaddr, IDE_DEVICE, ide->slave ? IDE_DEVICE_1 : IDE_DEVICE_0 );
    if ( timed_wait_for( ide->baseaddr, IDE_STATUS_DRDY, IDE_STATUS_DRQ | IDE_STATUS_BSY, ide->timeout ) )
    {
        IDE_MUTEX_UNLOCK( ide );
        return -1;
    }

    ide_set_register( ide->baseaddr, IDE_COMMAND, IDE_COMMAND_IDENTIFY_DEVICE );
    if ( ide_errorcheck( ide->baseaddr ) )
    {
        IDE_MUTEX_UNLOCK( ide );
        return -1;
    }

    ide_wait_for_data_request( ide->baseaddr );

    /* read 1 block */
    ide_read_buf( ide->baseaddr, ( void * ) buf32, 1, 0 );
    buf16 = ( uint16_t * ) buf32;

    ide_get_register( ide->baseaddr, IDE_ALTSTATUS );   // wait at least PIO cycle delay before status is valid
    ide_wait_while_busy( ide->baseaddr );

    printinfo( ( uint16_t * ) buf32, ide->slave );

    // set piomode based on what drive knows and minimum piocycle without flowcontrol
    piomode = 2;
    piomodeflags = little16( buf16[64] );
    if ( piomodeflags & ( 1 << 0 ) ) piomode = 3;
    if ( piomodeflags & ( 1 << 1 ) ) piomode = 4;
    ide_piomode_internal(ide, piomode, little16( buf16[67] ));

    ide->cylinders = little16( buf16[1] );
    ide->heads = little16( buf16[3] ) & 0xFF;
    ide->sectorspertrack = little16( buf16[6] ) & 0xFF;
    if ( little16( buf16[49] ) & 0x200 )
    {
        ide->lbasectors = read_little32from16( ( uint8_t * ) &buf16[60] );
        ide->info.blkcount = ide->lbasectors;
    }
    else
    {
        ide->lbasectors = 0;
        ide->info.blkcount = ide->sectorspertrack * ide->heads * ide->cylinders;
    }
    ide->info.blksize = IDE_SECTORSIZE;

    IDE_MUTEX_UNLOCK( ide );
    ide->initflags |= IDE_INIT_DEVICE;
    return 0;
}

/**
 * @brief
 *      Get information of the IDE device
 *
 * You can use this function to obtain disk layout information of an IDE
 * device.
 *
 * @param ide
 *      ide driver pointer
 *
 * @return
 *      Pointer to an ide_info_t data structure.
 *
 * @see
 *      ide_info_t
 */
extern const ide_info_t *ide_get_info( ide_t * restrict ide )
{
    return ( const ide_info_t * ) &ide->info;
}

/**
 * @brief
 *      Reset a single device attached to the IDE controller
 *
 * This function uses a software reset command to reset a single device
 * attached to the IDE controller.
 *
 * @param ide
 *      ide driver pointer
 *
 * @return
 *      Nothing.
 *
 * @see
 *      ide_hardreset
 */
extern void ide_softreset( ide_t * restrict ide )
{

    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );

    // safe fallback to PIO-0 speed
    ide_piomode_internal(ide, 0, 0);

    IDECORE_DATA( ide->baseaddr ) = IDE_DEVICE_CONTROL_SRST;
    IDECORE_COMMAND( ide->baseaddr ) = IDE_DEVICE_CONTROL | IDECORE_COMMAND_WRITE;

    delay_us( 5 );
    IDECORE_DATA( ide->baseaddr ) = 0;
    IDECORE_COMMAND( ide->baseaddr ) = IDE_DEVICE_CONTROL | IDECORE_COMMAND_WRITE;
    delay_ms( 2 );

    IDE_MUTEX_UNLOCK( ide );
}

/**
 * @brief
 *      Set memory range for DMA
 *
 * Use this function to set the range for direct memory access (DMA). By
 * default DMA is disabled by setting the start address to 0xFFFFFFFF and the
 * end address to 0x0.
 *
 * @param ide
 *      ide driver pointer
 * @param dma_from
 *      Start address for DMA access
 * @param dma_to
 *      End address for DMA access
 *
 * @return
 *      Nothing.
 */
extern void ide_set_dma_range( ide_t * restrict ide, uintptr_t dma_from, uintptr_t dma_to )
{
    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );
    ide->dma_to = dma_to;
    ide->dma_from = dma_from;
    IDE_MUTEX_UNLOCK( ide );
}

/**
 * @brief
 *      Read a number of sectors from the IDE device
 *
 * This function reads the requested number of sectors from the IDE device
 * starting with sector @em lba. The buffer @em data needs to be large enough
 * to contain the requested amount of data. Use <code>ide_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param ide
 *      ide driver pointer
 * @param data
 *      Buffer to store the data
 * @param lba
 *      Sector number to start reading from
 * @param sectorcount
 *      Number of sectors to read
 *
 * @return
 *      Number of sectors read.
 *
 * @see
 *      ide_get_info
 */
extern int ide_read_sectors( ide_t * restrict ide, uint8_t *data, unsigned int lba,
                             unsigned int sectorcount )
{
    int count;

    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );
    count = read_sectors( ide, data, lba, sectorcount );
    IDE_MUTEX_UNLOCK( ide );

    return count;
}

/**
 * @brief
 *      Write a number of sectors to the IDE device
 *
 * This function writes the requested number of sectors to the IDE device
 * starting at sector @em lba. Use <code>ide_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param ide
 *      ide driver pointer
 * @param data
 *      Buffer containing the data to write
 * @param lba
 *      Sector number to start writing at
 * @param sectorcount
 *      Number of sectors to write
 *
 * @return
 *      Number of sectors written.
 *
 * @see
 *      ide_get_info
 */
extern int ide_write_sectors( ide_t * restrict ide, const uint8_t *data, unsigned int lba,
                              unsigned int sectorcount )
{
    int count;

    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );
    count = write_sectors( ide, data, lba, sectorcount );
    IDE_MUTEX_UNLOCK( ide );

    return count;
}

/**
 * @brief
 *      Clear a number of sectors on the IDE device
 *
 * This function writes zeros to the requested number of sectors on the IDE
 * device starting at sector @em lba. Use <code>ide_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param ide
 *      ide driver pointer
 * @param lba
 *      Sector number to start writing at
 * @param sectorcount
 *      Number of sectors to clear
 *
 * @return
 *      Number of sectors cleared.
 *
 * @see
 *      ide_get_info
 */
extern int ide_clear_sectors( ide_t * restrict ide, unsigned int lba, unsigned int sectorcount )
{
    int count;

    IDE_MUTEX_PREPARE();
    IDE_MUTEX_LOCK( ide );
    count = write_sectors( ide, NULL, lba, sectorcount );
    IDE_MUTEX_UNLOCK( ide );

    return count;
}
