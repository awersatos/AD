/*****************************************************************************
 *
 *  Copyright:          Copyright (c) 2007, Altium
 *
 *  Description:        Direct (non-blockio) interface for SD card devices.
 *
\*****************************************************************************/

/**
 * @file drv_sdcard.h
 *
 * @brief
 *      SDCARD driver
 *
 * This driver provides access to SD card readers through an SPI controller.
 *
 * Requires: <a href="spi.chm::/index.htm">WB_SPI peripheral</a>.
 */

#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>
#include <errno.h>

#include <pal.h>
#include <sysutils.h>
#include <drv_spi.h>
#include <drv_sdcard.h>

#include "drv_sdcard_cfg_instance.h"

#ifndef MIN
# define MIN( a, b )                            ( ( (a) <= (b) ) ? (a) : (b) )
#endif

/*
 * mutex support
 */

#if ( DRV_SDCARD_USE_MUTEX != 0 )
# define SDCARD_MUTEX_PREPARE()                 POSIX_DEV_MUTEX_PREPARE(sdcard_mutex_buffer)
# define SDCARD_MUTEX_LOCK( sdcard )            POSIX_DEV_MUTEX_LOCK(&sdcard->mutex, sdcard_mutex_buffer)
# define SDCARD_MUTEX_UNLOCK( sdcard )          POSIX_DEV_MUTEX_UNLOCK(&sdcard->mutex, sdcard_mutex_buffer)
#else
# define SDCARD_MUTEX_PREPARE()                 do {} while ( 0 )
# define SDCARD_MUTEX_LOCK( sdcard )            do {} while ( 0 )
# define SDCARD_MUTEX_UNLOCK( sdcard )          do {} while ( 0 )
#endif

/*
 * Commands and response codes
 */

#define SD_ERR_OK               0
#define SD_ERR_COMM             -1
#define SD_ERR_INIT             -2
#define SD_ERR_UNSUPPORTED      -3

#define SD_START_TOKEN          0xFE
#define SD_MULTI_WRITE_TOKEN    0xFC
#define SD_STOP_TOKEN           0xFD
#define SD_RESPONSE_MASK        0x1F
#define SD_DATA_ACCEPTED        0x05
#define SD_CRC_ERROR            0x0B
#define SD_WRITE_ERROR          0x0D

#define MAXSPICLOCK             20000000    // This maximum is caused by delays from FPGA SPI to SDCARD

/* SUPPORTED VOLTAGE RANGE:
 *
 * The supported voltage range of the card must match with the voltage (range)
 * of the cardreader.
 *
 * Bit in OSD register | Supported voltage
 *
 *            4              1.6 - 1.7
 *            5              1.7 - 1.8
 *            6              1.8 - 1.9
 *            7              1.9 - 2.0
 *            8              2.0 - 2.1
 *            9              2.1 - 2.2
 *           10              2.2 - 2.3
 *           11              2.3 - 2.4
 *           12              2.4 - 2.5
 *           13              2.5 - 2.6
 *           14              2.6 - 2.7
 *           15              2.7 - 2.8
 *           16              2.8 - 2.9
 *           17              2.9 - 3.0
 *           18              3.0 - 3.1
 *           19              3.1 - 3.2
 *           20              3.2 - 3.3
 *           21              3.3 - 3.4
 *           22              3.4 - 3.5
 *           23              3.5 - 3.6
 *
 * Give the cardreader voltage range to sd_init, sd_init will test the SDcard
 * voltage range against the cardreader voltage range.
 *
 * Default for NanoBoard-NB2 : 3.0 - 3.6V = bit 18 - 23.
 */

#define SD_VOLTAGE_16_17    0x00000010  // 1.6 - 1.7 V
#define SD_VOLTAGE_17_18    0x00000020  // 1.7 - 1.8 V
#define SD_VOLTAGE_18_19    0x00000040  // 1.8 - 1.9 V
#define SD_VOLTAGE_19_20    0x00000080  // 1.9 - 2.0 V
#define SD_VOLTAGE_20_21    0x00000100  // 2.0 - 2.1 V
#define SD_VOLTAGE_21_21    0x00000200  // 2.1 - 2.2 V
#define SD_VOLTAGE_22_21    0x00000400  // 2.2 - 2.3 V
#define SD_VOLTAGE_23_21    0x00000800  // 2.3 - 2.4 V
#define SD_VOLTAGE_24_21    0x00001000  // 2.4 - 2.5 V
#define SD_VOLTAGE_25_21    0x00002000  // 2.5 - 2.6 V
#define SD_VOLTAGE_26_21    0x00004000  // 2.6 - 2.7 V
#define SD_VOLTAGE_27_21    0x00008000  // 2.7 - 2.8 V
#define SD_VOLTAGE_28_21    0x00010000  // 2.8 - 2.9 V
#define SD_VOLTAGE_29_30    0x00020000  // 2.9 - 3.0 V
#define SD_VOLTAGE_30_31    0x00040000  // 3.0 - 3.1 V
#define SD_VOLTAGE_31_32    0x00080000  // 3.1 - 3.2 V
#define SD_VOLTAGE_32_33    0x00100000  // 3.2 - 3.3 V
#define SD_VOLTAGE_33_34    0x00200000  // 3.3 - 3.4 V
#define SD_VOLTAGE_34_35    0x00400000  // 3.4 - 3.5 V
#define SD_VOLTAGE_35_36    0x00800000  // 3.5 - 3.6 V

#define SD_VOLTAGE_30_36    0x00FC0000  // 3.0 - 3.6 V for NB2

/*
 * configuration data
 */

struct sdcard_s
{
    spi_t *spi;
    uint32_t read_delay;
    uint32_t write_delay;
    uint32_t erase_size;
    sdcard_info_t info;
#if ( DRV_SDCARD_USE_MUTEX != 0 )
    pthread_mutex_t mutex;
#endif
#if ( DRV_SDCARD_BUS_SHARING_TRUE_USED )
#if ( DRV_SDCARD_BUS_SHARING_FALSE_USED )
    bool bus_sharing;
#endif
    uint8_t channel;
#endif
};

static sdcard_t sdcard_table[DRV_SDCARD_INSTANCE_COUNT];

/*
 * SPI bus sharing
 */
inline bool sdcard_get_spi_bus( sdcard_t *sdcard )
{
#if ( DRV_SDCARD_BUS_SHARING_TRUE_USED )
# if ( DRV_SDCARD_BUS_SHARING_FALSE_USED )
    if ( sdcard->bus_sharing )
    {
# endif
        return spi_get_bus( sdcard->spi, spi->channel );
# if ( DRV_SDCARD_BUS_SHARING_FALSE_USED )
    }
    return true;
# endif
#else
    // no sharing
    return true;
#endif
}

inline void sdcard_release_spi_bus( sdcard_t *sdcard )
{
#if ( DRV_SDCARD_BUS_SHARING_TRUE_USED )
# if ( DRV_SDCARD_BUS_SHARING_FALSE_USED )
    if ( sdcard->bus_sharing )
    {
# endif
        spi_release_bus( sdcard->spi );
# if ( DRV_SDCARD_BUS_SHARING_FALSE_USED )
    }
# endif
#endif
}

/*
 * Local interface: sdcard commands
 */

static const uint8_t cmd0[]  = { 0x40, 0x00, 0x00, 0x00, 0x00, 0x95 };          /* CMD0:   reset and go to idle state */
//static const uint8_t cmd1[]  = { 0x41, 0x00, 0x00, 0x00, 0x00, 0xFF };         /* CMD1:   send op cond */
static const uint8_t cmd9[]  = { 0x49, 0x00, 0x00, 0x00, 0x00, 0xFF };          /* CMD9:   read CSD register */
static const uint8_t cmd10[] = { 0x4A, 0x00, 0x00, 0x00, 0x00, 0xFF };          /* CMD10:  read CID register */
//static const uint8_t cmd12[] = { 0x4C, 0x00, 0x00, 0x00, 0x00, 0xFF };         /* CMD12:  stop transmission */
static const uint8_t cmd13[] = { 0x4D, 0x00, 0x00, 0x00, 0x00, 0xFF };          /* CMD13:  send status */
static const uint8_t cmd16[] = { 0x50, 0x00, 0x00, 0x02, 0x00, 0xFF };          /* CMD16:  set block length, fixed to 512 bytes */
static const uint8_t cmd41[] = { 0x69, 0x00, 0x00, 0x00, 0x00, 0xFF };          /* ACMD41: send op cond, only valid after cmd55 */
static const uint8_t cmd55[] = { 0x77, 0x00, 0x00, 0x00, 0x00, 0xFF };          /* CMD55:  next command is an application specific command */
static const uint8_t cmd58[] = { 0x7A, 0x00, 0x00, 0x00, 0x00, 0xFF };          /* CMD58:  read OCR register */

/* Send sdcard command and wait for response
 *
 * sdcard = driver pointer
 * cmd = command to SD Card
 * cmd_len = length of the command
 * resp = pointer to response value
 * resp_len = length of expected response
 *
 * Returns SD_ERR_OK if successful, an error code otherwise.
 */
static int sdcard_spi_cmd_rsp( sdcard_t * restrict sdcard, const uint8_t *cmd, uint8_t cmd_len, uint8_t *resp,
                               uint8_t resp_len )
{
    int retry;
    uint8_t response = 0;

    /* close previous command */
    spi_transceive8( sdcard->spi, 0xFF );

    /* send command */
    for ( int i = 0; i < cmd_len; i++ )
    {
        spi_transceive8( sdcard->spi, cmd[i] );
    }

    /* wait for response */
    for ( retry = 9; retry > 0; retry-- )
    {
        response = spi_transceive8( sdcard->spi, 0xFF );
        if ( response != 0xFF )
        {
            break;
        }
    }

    if ( retry == 0 )
    {
        /* Timeout waiting for card to respond on cmd */
        return SD_ERR_COMM;
    }

    /* get response */
    resp[0] = ( uint8_t ) ( response & 0xFF );
    for ( int i = 1; i < resp_len; i++ )
    {
        resp[i] = spi_transceive8( sdcard->spi, 0xFF );
    }

    return SD_ERR_OK;
}

/*
 * Local interface: reading and writing
 */

/* Read a block from the SD Card and write to 'block'. This function does not
 * include the sd read block command.
 *
 * sdcard = driver pointer
 * block = receive buffer
 * block_len = length of buffer
 * delay = card must respond within this time
 *
 * Returns SD_ERR_OK if successful, and error code otherwise.
 */
inline int sdcard_readbuf( sdcard_t * restrict sdcard, uint8_t *block, uint32_t block_len, uint32_t delay )
{
    /* wait for card to start response */
    for ( ; delay; delay-- )
    {
        if ( spi_transceive8( sdcard->spi, 0xFF ) == SD_START_TOKEN )
        {
            /* start of response found */
            break;
        }
    }

    if ( delay == 0 )
    {
        /* timeout waiting for card to response */
        return SD_ERR_COMM;
    }

    spi_readblock( sdcard->spi, block, block_len );

    /* clock out CRC, but ignore */
    spi_transceive16( sdcard->spi, 0xFFFF );

    return SD_ERR_OK;
}

/* Send read command and read block
 *
 * sdcard = driver pointer
 * block = receive buffer
 * block_len = length of buffer
 * address = start address for reading
 *
 * Returns SD_ERR_OK if successful, and error code otherwise.
 */
inline int sdcard_get_block( sdcard_t * restrict sdcard, uint8_t *block, uint32_t block_len,
                             uint32_t address )
{
    uint8_t cmd17[] = { 0x51, 0x00, 0x00, 0x00, 0x00, 0xFF };
    uint8_t response;

    cmd17[1] = ( uint8_t ) ( ( address >> 24 ) & 0xFF );
    cmd17[2] = ( uint8_t ) ( ( address >> 16 ) & 0xFF );
    cmd17[3] = ( uint8_t ) ( ( address >> 8 ) & 0xFF );
    cmd17[4] = ( uint8_t ) ( address & 0xFF );

    spi_cs_lo( sdcard->spi );

    /* send read_block command */
    if ( sdcard_spi_cmd_rsp( sdcard, cmd17, sizeof( cmd17 ), &response, 1 ) != SD_ERR_OK )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }
    if ( response != 0 )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }
    if ( sdcard_readbuf( sdcard, block, block_len, sdcard->read_delay ) != SD_ERR_OK )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }

    spi_cs_hi( sdcard->spi );
    return SD_ERR_OK;
}

/* Write a block to the SD Card. This does not include the sd write block
 * command.
 *
 * sdcard = driver pointer
 * block = data buffer, or NULL to write '0's
 * block_len = length of buffer
 * delay = card must respond within this time
 *
 * Returns SD_ERR_OK if successful, an error code otherwise.
 */
inline int sdcard_writebuf( sdcard_t * restrict sdcard, const uint8_t *block, uint32_t block_len,
                            uint32_t delay )
{
    uint8_t response;

    /* send start token */
    spi_transceive8( sdcard->spi, SD_START_TOKEN );

    if ( block )
    {
        if ( block_len && (uintptr_t)block & 0x1 )
        {
            spi_transceive8( sdcard->spi, *block++ );
        }
        if ( block_len > 1 && (uintptr_t)block & 0x2 )
        {
            spi_transceive16( sdcard->spi, *(uint16_t *)block );
            block_len -= 2;
            block += 2;
        }
        while ( block_len > 3 )
        {
            spi_transceive32( sdcard->spi, *(uint32_t *)block );
            block_len -= 4;
            block += 4;
        }
        if ( block_len > 1 )
        {
            spi_transceive16( sdcard->spi, *(uint16_t *)block );
            block_len -= 2;
            block += 2;
        }
        if ( block_len )
        {
            spi_transceive8( sdcard->spi, *block );
        }
    }
    else
    {
        while ( block_len > 3 )
        {
            spi_transceive32( sdcard->spi, 0 );
            block_len -= 4;
        }
        if ( block_len > 1 )
        {
            spi_transceive16( sdcard->spi, 0 );
            block_len -= 2;
        }
        if ( block_len )
        {
            spi_transceive8( sdcard->spi, 0 );
        }
    }

    /* send CRC, actually send 0xFFFF as CRC is ignored */
    spi_transceive16( sdcard->spi, 0xFFFF );

    /* wait for response */
    response = spi_transceive8( sdcard->spi, 0xFF );
    if ( ( response & SD_RESPONSE_MASK ) != SD_DATA_ACCEPTED )
    {
        return SD_ERR_COMM;
    }
    /* wait for end of programming */
    for ( ; delay; delay-- )
    {
        if ( ( response = spi_transceive8( sdcard->spi, 0xFF ) ) != 0x00 )
        {
            break;
        }
    }

    if ( delay == 0 )
    {
        /* timeout waiting for card to respond */
        return SD_ERR_COMM;
    }

    return SD_ERR_OK;
}

/* Send write command and write block
 *
 * sdcard = driver pointer
 * block = receive buffer
 * block_len = length of buffer
 * address = start address for reading
 *
 * Returns SD_ERR_OK if successful, an error code otherwise.
 */
inline int sdcard_put_block( sdcard_t * restrict sdcard, const uint8_t *block, uint32_t block_len,
                             uint32_t address )
{
    uint8_t cmd24[] = { 0x58, 0x00, 0x00, 0x00, 0x00, 0xFF };
    uint8_t response2[2];

    cmd24[1] = ( uint8_t ) ( ( address >> 24 ) & 0xFF );
    cmd24[2] = ( uint8_t ) ( ( address >> 16 ) & 0xFF );
    cmd24[3] = ( uint8_t ) ( ( address >> 8 ) & 0xFF );
    cmd24[4] = ( uint8_t ) ( address & 0xFF );

    spi_cs_lo( sdcard->spi );

    /* send write_block command */
    if ( sdcard_spi_cmd_rsp( sdcard, cmd24, sizeof( cmd24 ), response2, 1 ) != SD_ERR_OK )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }
    if ( response2[0] != 0 )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }

    if ( sdcard_writebuf( sdcard, block, block_len, sdcard->write_delay ) != SD_ERR_OK )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }

    /* test for program errors */
    if ( sdcard_spi_cmd_rsp( sdcard, cmd13, sizeof( cmd13 ), response2, 2 ) != SD_ERR_OK )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }
    if ( ( response2[0] != 0 ) || ( response2[1] != 0 ) )
    {
        /* status error, write failed */
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }

    spi_cs_hi( sdcard->spi );
    return SD_ERR_OK;
}

/*
 * Local interface: device identification
 */

typedef struct
{
    uint32_t taac;              /* Data read access time - 1 in ns */
    uint32_t tran_speed;        /* Max. data transfer rate in b/s */
    uint16_t nsac;              /* Data read access time - 2 in CLK cycles (NSAC*100) */
    uint16_t ccc;               /* Card command classes */
    uint16_t read_bl_len;       /* Max. read data block length */
    uint16_t c_size;            /* Device size base */
    uint16_t c_size_mult;       /* Device size multiplier */
    uint16_t write_bl_len;      /* Max. write data block length */
    uint8_t sector_size;        /* Erase sector size */
    uint8_t wp_grp_size;        /* Write protect group size */
    uint8_t read_bl_partial;    /* Partial blocks for read allowed */
    uint8_t r2w_factor;         /* read / write delay factor */
    uint8_t erase_blk_en;       /* 1 block erasable, instead of 1 sector_size */
    uint8_t file_format;        /* File format */
} csd_t;

typedef struct
{
    uint8_t mid;
    char oid[3];
    char pnm[6];
    char pr[3];
    uint32_t psn;
    char mdt[4];
} cid_t;

#ifdef SDCARD_DEBUG

# include <stdio.h>

/* Print device info
 *
 * cid = device info pointer
 *
 * Returns nothing.
 */
static void sd_print_cid( cid_t * cid )
{
    printf( "----------------------------------------\n" );
    printf( "Manufacturer ID:  %d\n", cid->mid );
    printf( "Application ID:   %d-%d-%d\n", cid->oid[0], cid->oid[1], cid->oid[2] );
    printf( "Product Name:     %s\n", ( char * ) cid->pnm );
    printf( "Product Revision: %s\n", ( char * ) cid->pr );
    printf( "Manufacture Date: %s\n", ( char * ) cid->mdt );
    printf( "----------------------------------------\n" );
    return;
}

/* Print device properties
 *
 * sdcard = driver pointer
 * speed = device speed
 *
 * Returns nothing.
 */
inline void sd_print_properties( sdcard_t * restrict sdcard, int speed )
{
    printf( "Speed:            %d\n", speed );
    printf( "Read delay:       %d\n", sdcard->read_delay );
    printf( "Write delay:      %d\n", sdcard->write_delay );
    printf( "Erase block size: %d\n", sdcard->erase_size );
    printf( "Block size:       %d\n", sdcard->info.blksize );
    printf( "Number of blocks: %d\n", sdcard->info.blkcount );
    printf( "----------------------------------------\n\n" );
}

#endif /* SDCARD_DEBUG */

/* Read csd info from card, write to local variable
 *
 * Returns SD_ERR_OK if successful, an error code otherwise
 */
static int sdcard_get_csd( sdcard_t * restrict sdcard, csd_t * restrict csd )
{
    uint8_t data[18];
    uint8_t mant[] = { 0, 10, 12, 13, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80 };
    uint32_t expo[] = { 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000 };

    if ( sdcard_spi_cmd_rsp( sdcard, cmd9, sizeof( cmd9 ), data, 1 ) != SD_ERR_OK )
    {
        /* no commmunication with card */
        return SD_ERR_COMM;
    }

    if ( sdcard_readbuf( sdcard, data, 18, 8 ) != SD_ERR_OK )
    {
        /* no commmunication with card */
        return SD_ERR_COMM;
    }

    if ( ( data[0] & 0x03 ) != 0 )
    {
        /* unknown csd version */
        return SD_ERR_UNSUPPORTED;
    }

    /*
     * taac: max delay before card responses on block read, stored in ns
     */
    csd->taac = ( mant[( data[1] & 0x78 ) >> 3] * expo[data[1] & 0x07] ) / 10;

    /*
     * max clocks before card responses on block read
     */
    csd->nsac = data[2] * 100;

    /*
     * max clock freq, stored in Hz
     */
    csd->tran_speed = mant[( data[3] & 0x78 ) >> 3] * expo[data[3] & 0x07] * 10000;

    /*
     * supported classes
     */
    csd->ccc = ( uint16_t ) data[4] << 4 | ( uint16_t ) data[5] >> 4;

    /*
     * read-block length
     */
    switch ( data[5] & 0x0F )
    {
    case 9:
        csd->read_bl_len = 512;
        break;
    case 10:
        csd->read_bl_len = 1024;
        break;
    case 11:
        csd->read_bl_len = 2048;
        break;
    default:
        csd->read_bl_len = 0;
        break;
    }

    /*
     * partial block read possible ?
     */
    csd->read_bl_partial = data[6] & 0x80 ? 1 : 0;

    /*
     * card size = c_size * c_size_mult * read_bl_len
     */
    csd->c_size =
        ( ( ( uint16_t ) data[6] & 0x0003 ) << 10 | ( uint16_t ) data[7] << 2 | ( uint16_t ) data[8] >> 6 ) +
        1;
    csd->c_size_mult = 1 << ( ( ( data[9] & 0x03 ) << 1 | data[10] >> 7 ) + 2 );

    csd->erase_blk_en = ( data[10] & 0x40 ) ? 1 : 0;

    /*
     * erase sector size
     */
    csd->sector_size = ( ( data[10] & 0x3F ) << 1 | data[11] >> 7 ) + 1;

    /*
     * write protect group size
     */
    csd->wp_grp_size = ( data[11] & 0x7F ) + 1;

    /*
     * read to write factor
     */
    csd->r2w_factor = 1 << ( ( data[12] & 0x16 ) >> 2 );

    /*
     * write-block length
     */
    switch ( ( data[12] & 0x03 ) << 2 | data[13] >> 6 )
    {
    case 9:
        csd->write_bl_len = 512;
        break;
    case 10:
        csd->write_bl_len = 1024;
        break;
    case 11:
        csd->write_bl_len = 2048;
        break;
    default:
        csd->write_bl_len = 0;
        break;
    }

    /*
     * file format
     */
    csd->file_format = ( data[14] & 0x80 ) >> 5 | ( data[14] & 0x06 ) >> 1;

    return SD_ERR_OK;
}

/* Read cid info from the SD card
 *
 * sdcard = driver pointer
 * cid = device identification pointer
 *
 * Return SD_ERR_OK if successful, an error code otherwise.
 */
static int sdcard_get_cid( sdcard_t * restrict sdcard, cid_t * cid )
{
    uint8_t data[18];

    if ( sdcard_spi_cmd_rsp( sdcard, cmd10, sizeof( cmd10 ), data, 1 ) != SD_ERR_OK )
    {
        /* no commmunication with card */
        return SD_ERR_COMM;
    }

    if ( sdcard_readbuf( sdcard, data, 18, 8 ) != SD_ERR_OK )
    {
        /* no commmunication with card */
        return SD_ERR_COMM;
    }

    /*
     * Manufacturer ID
     */
    cid->mid = data[0];

    /*
     * OEM/Application ID
     */
    cid->oid[0] = data[1];
    cid->oid[1] = data[2];
    cid->oid[2] = 0;

    /*
     * Product Name
     */
    cid->pnm[0] = data[3];
    cid->pnm[1] = data[4];
    cid->pnm[2] = data[5];
    cid->pnm[3] = data[6];
    cid->pnm[4] = data[7];
    cid->pnm[5] = 0;

    /*
     * Product Revision
     */
    cid->pr[0] = ( data[8] >> 4 ) + '0';
    cid->pr[1] = ( data[8] & 0x0F ) + '0';
    cid->pr[2] = 0;

    /*
     * Product Serial Number
     */
    cid->psn =
        ( uint32_t ) data[9] << 24 | ( uint32_t ) data[10] << 16 | ( uint32_t ) data[11] << 8 | ( uint32_t )
        data[12];

    /*
     * Manufacture Date (JJM)
     */
    cid->mdt[0] = ( data[13] & 0x0F ) + '0';
    cid->mdt[1] = ( data[14] >> 4 ) + '0';
    cid->mdt[2] = ( data[14] & 0x0F ) < 10 ? ( data[14] & 0x0F ) + '0' : ( data[14] & 0x0F ) - 10 + 'A';
    cid->mdt[3] = 0;

#if SDCARD_DEBUG
    sd_print_cid( cid );
#endif

    return SD_ERR_OK;
}

/*
 * Local interface: initialization
 */

/* Initialize SD card reader and get SD card info
 *
 * sdcard = driver pointer
 * cfg = instance configuration pointer
 *
 * Returns SD_ERR_OK if successful, an error code otherwise.
 */
//inline int sdcard_device_init( sdcard_t * restrict sdcard, const drv_sdcard_cfg_instance_t * restrict cfg )
int sdcard_device_init( sdcard_t * restrict sdcard )
{
    uint16_t blkdiv;
    csd_t csd;
    cid_t cid;
    int retry;
    uint8_t data[5];
    int error_code;
    uint32_t voltage_range = SD_VOLTAGE_30_36;  // cfg->voltage_range;

    /* Conservative initial rate: 400 kHz */
    spi_set_baudrate( sdcard->spi, 400 * 1000 );

    /* Card into SPI mode */
    spi_cs_hi( sdcard->spi );

    /* Initialization sequence */
    for ( int i = 0; i < 10; i++ )
    {
        spi_transceive8( sdcard->spi, 0xFF );
    }

    spi_cs_lo( sdcard->spi );

    /* Reset SD Card */
    if ( sdcard_spi_cmd_rsp( sdcard, cmd0, sizeof( cmd0 ), data, 1 ) != SD_ERR_OK || data[0] != 1 )
    {
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }

    /* start initialisation of the card and see if it is done */
#if 0
    int mmc_compatible = cfg->mmc_compatible;
    if ( mmc_compatible )
    {
        for ( retry = 0xFFFF; retry; retry-- )  /* try for at least 1 second */
        {
            /* will work for Thick SD Memory Cards and MMC */
            if ( sdcard_spi_cmd_rsp( sdcard, cmd1, sizeof( cmd1 ), data, 1 ) != SD_ERR_OK )
            {
                /* no commmunication with card */
                spi_cs_hi( sdcard->spi );
                return SD_ERR_COMM;
            }

            if ( data[0] == 0x00 )
            {
                /* initialisation done, stop polling card */
                break;
            }
        }
    }
    else
#endif
    {
        for ( retry = 0xFFFF; retry; retry-- )  /* try for at least 1 second */
        {
            /* will work for Thick SD Cards and Thin SD Cards */
            if ( sdcard_spi_cmd_rsp( sdcard, cmd55, sizeof( cmd55 ), data, 1 ) != SD_ERR_OK )
            {
                /* no commmunication with card */
                spi_cs_hi( sdcard->spi );
                return SD_ERR_COMM;
            }

            if ( sdcard_spi_cmd_rsp( sdcard, cmd41, sizeof( cmd41 ), data, 1 ) != SD_ERR_OK )
            {
                /* no commmunication with card */
                spi_cs_hi( sdcard->spi );
                return SD_ERR_COMM;
            }

            if ( data[0] == 0x00 )
            {
                /* initialisation done, stop polling card */
                break;
            }
        }
    }

    if ( retry == 0 )
    {
        /* Timeout waiting for 0x00 from card */
        spi_cs_hi( sdcard->spi );
        return SD_ERR_INIT;
    }

    if ( sdcard_spi_cmd_rsp( sdcard, cmd58, sizeof( cmd58 ), data, 5 ) != SD_ERR_OK
         || data[0] != 0x00 )
    {
        /* no commmunication with card */
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }

    if ( ( ( ( uint32_t ) data[1] << 24
             | ( uint32_t ) data[2] << 16
             | ( uint32_t ) data[3] << 8 | ( uint32_t ) data[4] ) & voltage_range ) != voltage_range )
    {
        /* supplied voltage out of range */
        spi_cs_hi( sdcard->spi );
        return SD_ERR_UNSUPPORTED;
    }

    error_code = sdcard_get_csd( sdcard, &csd );
    if ( error_code != SD_ERR_OK )
    {
        spi_cs_hi( sdcard->spi );
        return error_code;
    }

    /* FIXME: is this needed for initialization? */
    error_code = sdcard_get_cid( sdcard, &cid );
    if ( error_code != SD_ERR_OK )
    {
        spi_cs_hi( sdcard->spi );
        return error_code;
    }

    if ( sdcard_spi_cmd_rsp( sdcard, cmd16, sizeof( cmd16 ), data, 1 ) != SD_ERR_OK
         || data[0] != 0x00 )
    {
        /* no commmunication with card */
        spi_cs_hi( sdcard->spi );
        return SD_ERR_COMM;
    }

    /* fill in the values from csd */
    sdcard->read_delay = ( uint32_t ) ( ( ( csd.taac / 1000 ) * ( pal_freq_hz(  ) / 1000000 ) ) / 8 + 1 );
    sdcard->write_delay = sdcard->read_delay * csd.r2w_factor;
    sdcard->erase_size = csd.erase_blk_en ? csd.write_bl_len : csd.wp_grp_size * csd.write_bl_len;
    
    /* Normalize read/write block length to 512 bytes... */
    blkdiv = csd.read_bl_len / 512;
    sdcard->info.blksize = csd.read_bl_len / blkdiv;
    sdcard->info.blkcount = csd.c_size * csd.c_size_mult * blkdiv;

#ifdef SDCARD_DEBUG
    sd_print_properties( sdcard, csd.tran_speed );
#endif
    spi_cs_hi( sdcard->spi );

    // set highest possible clock speed. MAXSPICLOCK is caused by delay from DB FPGA to SDCARD on PB02.06
    // Also note that that the spi core will never run higher than system clock / 2.
    spi_set_baudrate( sdcard->spi, MIN( MAXSPICLOCK, csd.tran_speed )  );

    return SD_ERR_OK;
}

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize the SD card reader
 *
 * This function initializes the SD card reader and its SPI controller.
 *
 * @param id
 *      Driver id (defined in devices.h)
 *
 * @return
 *      The sdcard driver pointer for the specified device, or NULL on error.
 */
extern sdcard_t *sdcard_open( unsigned int id )
{
    sdcard_t *sdcard;
    const drv_sdcard_cfg_instance_t *cfg;
#if ( DRV_SDCARD_USE_MUTEX )
    pthread_mutexattr_t mutexattr;
#endif

    assert( id < DRV_SDCARD_INSTANCE_COUNT );
    sdcard = &sdcard_table[id];

    if ( sdcard->spi == NULL )
    {
        cfg = &drv_sdcard_instance_table[id];

        sdcard->spi = spi_open( (unsigned int)cfg->drv_spi );

        if ( sdcard->spi != NULL )
        {
        #if ( DRV_SDCARD_USE_MUTEX )
            pthread_mutexattr_init( &mutexattr );
            pthread_mutex_init( &ps2_dev->mutex, &mutexattr );
        #endif

        #if ( DRV_SDCARD_BUS_SHARING_TRUE_USED )
        # if ( DRV_SDCARD_BUS_SHARING_FALSE_USED )
            sdcard->bus_sharing = cfg->bus_sharing;
        # endif
            sdcard->channel = cfg->channel;
        #endif

            if ( sdcard_get_spi_bus( sdcard ) )
            {
                SDCARD_MUTEX_PREPARE();
                SDCARD_MUTEX_LOCK( sdcard );
//                if ( sdcard_device_init( sdcard, cfg ) == SD_ERR_OK )
                sdcard_device_init( sdcard );
                SDCARD_MUTEX_UNLOCK( sdcard );
            }
            sdcard_release_spi_bus( sdcard );
        }
    }
    return (sdcard->spi != NULL) ? sdcard : NULL;
}

/**
 * @brief
 *      Get information of the SD card
 *
 * You can use this function to obtain disk layout information of an SDCARD
 * device.
 *
 * @param sdcard
 *      sdcard driver pointer
 *
 * @return
 *      Pointer to an sdcard_info_t data structure.
 *
 * @see
 *      sdcard_info_t
 */
extern const sdcard_info_t *sdcard_get_info( sdcard_t * restrict sdcard )
{
    return &sdcard->info;
}

/**
 * @brief
 *      Read a number of sectors from the SD card
 *
 * This function reads the requested number of sectors from the SDCARD device
 * starting with sector @em lba. The buffer @em data needs to be large enough
 * to contain the requested amount of data. Use <code>sdcard_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param sdcard
 *      sdcard driver pointer
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
 *      sdcard_get_info
 */
extern int sdcard_read_sectors( sdcard_t * restrict sdcard, uint8_t *data, unsigned int lba,
                                unsigned int sectorcount )
{
    int count = 0;
    unsigned int blksize = sdcard->info.blksize;

    if ( sdcard_get_spi_bus( sdcard ) )
    {
        SDCARD_MUTEX_PREPARE();
        SDCARD_MUTEX_LOCK( sdcard );
        while ( count < sectorcount )
        {
            if ( sdcard_get_block( sdcard, data, blksize, lba * blksize ) != SD_ERR_OK )
            {
                break;
            }
            data += blksize;
            lba++;
            count++;
        }
        SDCARD_MUTEX_UNLOCK( sdcard );
    }
    sdcard_release_spi_bus( sdcard );
    return count;
}

/**
 * @brief
 *      Write a number of sectors to the SD card
 *
 * This function writes the requested number of sectors to the SDCARD device
 * starting at sector @em lba. Use <code>sdcard_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param sdcard
 *      sdcard driver pointer
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
 *      sdcard_get_info
 */
extern int sdcard_write_sectors( sdcard_t * restrict sdcard, const uint8_t *data, unsigned int lba,
                                 unsigned int sectorcount )
{
    int count = 0;
    unsigned int blksize = sdcard->info.blksize;

    if ( data && sdcard_get_spi_bus( sdcard ) )
    {
        SDCARD_MUTEX_PREPARE();
        SDCARD_MUTEX_LOCK( sdcard );
        while ( count < sectorcount )
        {
            if ( sdcard_put_block( sdcard, data, blksize, lba * blksize ) != SD_ERR_OK )
            {
                break;
            }
            data += blksize;
            lba++;
            count++;
        }
        SDCARD_MUTEX_UNLOCK( sdcard );
    }
    sdcard_release_spi_bus( sdcard );
    return count;
}

/**
 * @brief
 *      Clear a number of sectors on the SD card
 *
 * This function writes zeros to the requested number of sectors on the SD card
 * starting at sector @em lba. Use <code>sdcard_get_info()</code> to
 * find out the sector size and number of sectors of the device.
 *
 * @param sdcard
 *      sdcard driver pointer
 * @param lba
 *      Sector number to start writing at
 * @param sectorcount
 *      Number of sectors to clear
 *
 * @return
 *      Number of sectors cleared.
 *
 * @see
 *      sdcard_get_info
 */
extern int sdcard_clear_sectors( sdcard_t * restrict sdcard, unsigned int lba, unsigned int sectorcount )
{
    int count = 0;
    unsigned int blksize = sdcard->info.blksize;

    if ( sdcard_get_spi_bus( sdcard ) )
    {
        SDCARD_MUTEX_PREPARE();
        SDCARD_MUTEX_LOCK( sdcard );
        while ( count < sectorcount )
        {
            if ( sdcard_put_block( sdcard, NULL, blksize, lba * blksize ) != SD_ERR_OK )
            {
                break;
            }
            lba++;
            count++;
        }
        SDCARD_MUTEX_UNLOCK( sdcard );
    }
    sdcard_release_spi_bus( sdcard );
    return count;
}

/**
 * @brief   
 *      Get value of SD_DETECT pin
 *
 * @param sdcard 
 *      sdcard driver pointer
 *
 * @return  
 *      True if pin is active (card is inserted), false otherwise
 */
 
bool sdcard_detect( sdcard_t * restrict sdcard )
{
    return spi_get_gpin( sdcard->spi ) & 0x01;
}

/**
 * @brief   
 *      Check if write protection switch on card is active
 *
 * @param sdcard 
 *      sdcard driver pointer
 *
 * @return  
 *      False if card is writeable, true otherwise
 */
 

bool sdcard_protected( sdcard_t * restrict sdcard )
{
    return (spi_get_gpin( sdcard->spi ) & 0x02) == 0;
}
