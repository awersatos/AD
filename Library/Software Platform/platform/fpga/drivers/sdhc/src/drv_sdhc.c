/*****************************************************************************
 *
 *  Copyright:          Copyright (c) 2007, Altium
 *
 *  Description:        SD Host Controller drive
 *
\*****************************************************************************/

/**
 * @file drv_sdhc.h
 *
 * @brief
 *      SD Host Controller
 *
 * This driver provides access to SD card readers through the SD 4-bit Host Controller
 *
 * Requires: <a href="sdhc.chm::/index.htm">WB_SDHC peripheral</a>.
 */

#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <string.h>

#include <pal.h>
#include <sysutils.h>
#include <per_sdhc.h>
#include <drv_sdhc.h>

#include "drv_sdhc_cfg_instance.h"

//#define SDHC_DEBUG  1

#ifdef SDHC_DEBUG
#include <stdio.h>
#define debugprintf         printf
#define debugputs           puts
#define debugputchar        putchar
#else
#define debugprintf(...)
#define debugputs(A)
#define debugputchar(A)
#endif

#define SIZE_RESP_R1        5       // Response R1: card status
#define SIZE_RESP_R1B       5       // Response R1b: card status with optional busy signalling
#define SIZE_RESP_R2        16      // Response R2: CID or CSD (note: ignore the CRC in the message, clocked in as invalid CRC)
#define SIZE_RESP_R3        5       // Response R3: OCR (note: we ignore the final byte in the message, clocked in as invalid CRC)
#define SIZE_RESP_R4        5       // Response R4: SDIO OCR (note: we ignore the reserved byte in the message, clocked in as invalid CRC)
#define SIZE_RESP_R5        5       // Response R5: SDIO IO_RW_Direct response
#define SIZE_RESP_R6        5       // Response R6: Published RCA & partial status
#define SIZE_RESP_R7        5       // Response R7: Card interface condition

#define SIZE_RESP_MAX       16

// OCR register
#define OCR_LOW             (0x00000001 << 7)   // Reserved for Low Voltage Range
#define OCR_27_28           (0x00000001 << 15)  // Vdd = 2.7 - 2.8V
#define OCR_28_29           (0x00000001 << 16)  // Vdd = 2.8 - 2.9V
#define OCR_29_30           (0x00000001 << 17)  // Vdd = 2.9 - 3.0V
#define OCR_30_31           (0x00000001 << 18)  // Vdd = 3.0 - 2.1V
#define OCR_31_32           (0x00000001 << 19)  // Vdd = 3.1 - 3.2V
#define OCR_32_33           (0x00000001 << 20)  // Vdd = 3.2 - 3.3V
#define OCR_33_34           (0x00000001 << 21)  // Vdd = 3.3 - 3.4V
#define OCR_34_35           (0x00000001 << 22)  // Vdd = 3.4 - 3.5V
#define OCR_35_36           (0x00000001 << 23)  // Vdd = 3.5 - 3.6V
#define OCR_HCS             (0x00000001 << 30)  // High Capacity Supported by host (HCS in command)
#define OCR_CCS             (0x00000001 << 30)  // Card Capacity Status (CCS in response)
#define OCR_RDY             (0x00000001 << 31)  // Card power up status bit (RDY)

// SDIO specific stuff from OCR
#define IO_OP_COND_RDY      (0x00000001 << 31)  // Card is ready to operate after intialization
#define IO_OP_COND_NF       (0x00000007 << 28)  // Number of I/O functions
#define IO_OP_COND_MP       (0x00000001 << 27)  // Memory present

//#define CMDTIMEOUT          (CLOCKS_PER_SEC / 10)
#define CMDTIMEOUT          (CLOCKS_PER_SEC / 1)

// SD Status bits
#define SDSTAT_OUT_OF_RANGE         (0x00000001 << 31)
#define SDSTAT_ADDRESS_ERROR        (0x00000001 << 30)
#define SDSTAT_BLOCK_LEN_ERROR      (0x00000001 << 29)
#define SDSTAT_ERASE_SEQ_ERROR      (0x00000001 << 28)
#define SDSTAT_ERASE_PARAM          (0x00000001 << 27)
#define SDSTAT_WP_VIOLATION         (0x00000001 << 26)
#define SDSTAT_CARD_IS_LOCKED       (0x00000001 << 25)
#define SDSTAT_LOCK_UNLOCK_FAILED   (0x00000001 << 24)
#define SDSTAT_COM_CRC_ERROR        (0x00000001 << 23)
#define SDSTAT_ILLEGAL_COMMAND      (0x00000001 << 22)
#define SDSTAT_CARD_ECC_FAILED      (0x00000001 << 21)
#define SDSTAT_CRC_ERROR            (0x00000001 << 20)
#define SDSTAT_ERROR                (0x00000001 << 19)
#define SDSTAT_CSD_OVERWRITE        (0x00000001 << 16)
#define SDSTAT_WP_ERASE_SKIP        (0x00000001 << 15)
#define SDSTAT_CARD_ECC_DISABLED    (0x00000001 << 14)
#define SDSTAT_ERASE_RESET          (0x00000001 << 13)
#define SDSTAT_CURRENT_STATE_MASK   (0x0000000F <<  9)  // See below
#define SDSTAT_READY                (0x00000001 <<  8)
#define SDSTAT_APP_CMD              (0x00000001 <<  5)
#define SDSTAT_AKE_SEQ_ERROR        (0x00000001 <<  3)

#define SDSTAT_CURRENT_STATE_IDLE   (0x00000000 <<  9)
#define SDSTAT_CURRENT_STATE_READY  (0x00000001 <<  9)
#define SDSTAT_CURRENT_STATE_IDENT  (0x00000002 <<  9)
#define SDSTAT_CURRENT_STATE_STBY   (0x00000003 <<  9)
#define SDSTAT_CURRENT_STATE_TRAN   (0x00000004 <<  9)
#define SDSTAT_CURRENT_STATE_DATA   (0x00000005 <<  9)
#define SDSTAT_CURRENT_STATE_RCV    (0x00000006 <<  9)
#define SDSTAT_CURRENT_STATE_PRG    (0x00000007 <<  9)
#define SDSTAT_CURRENT_STATE_DIS    (0x00000008 <<  9)
#define SDSTAT_CURRENT_STATE_IO     (0x0000000F <<  9)

/*
 * configuration data
 */

struct sdhc_s
{
    uintptr_t   baseaddress;
    uint8_t     * dma_from;
    uint8_t     * dma_to;
    uint32_t    dma_buf;
    size_t      dma_buf_size;

    bool        sdio;           // Card has I/O
    bool        sdmem;          // Card has memory capabilities
    bool        highcap;        // High capacity

    uint16_t    rca;            // Relative Card Address
    int8_t      cardtype;       // Card type
    unsigned    speed;          // Clock speed of SD_CLK

    clock_t     read_delay;     // Card must answer within this time when reading
    clock_t     write_delay;    // Card must answer within this time when writing

    unsigned    erase_size;     // Erase size

    sdhc_info_t info;
};

static sdhc_t drv_table[DRV_SDHC_INSTANCE_COUNT];

/**
 * brief Transmit a command and wait for response
 *
 * This function transmits a 48-bit command packet on the CMD line. Than it waits for a response. If it
 * is received correctly before the timeout expires, the function returns the number of bytes in the
 * response. If not, it returns the reason of failure. Note that some commands may return a response that
 * does not include a valid CRC (or a CRC that does not include the command itself). In that case, ignore
 * a return value of SDHC_ERR_CRC.
 *
 * param    drv         Pointer to driver context
 * param    cmd         Command to be sent (1 byte)
 * param    arg         Argument to be sent (4 bytes)
 * param    resplen     Length of response expected, not including CRC
 * param    respdata    Pointer to memory to store response in
 * param    timeout     Max. time to wait for a response, in clock ticks
 *
 * return   number of bytes received or error code if negative (see SDHC_ERR_*)
 */

static int transceive_cmd( sdhc_t * restrict drv, uint8_t cmd, uint32_t arg, int resplen, uint8_t * respdata, clock_t timeout )
{
    int i = 0;
    uint32_t status;

    do
    {
        status = SDHC_STAT( drv->baseaddress );
    } while( status & (SDHC_STAT_CMD_TXBUSY|SDHC_STAT_CMD_RXBUSY) );

    debugprintf( "> %2d: %02X %08X < %2d:", cmd, cmd, arg, resplen );
    cmd = (cmd | 0x40) & 0x7F;
    status = 0x00;
    SDHC_CMD_TXARG( drv->baseaddress )  = arg;
    SDHC_CMD_TXCMD( drv->baseaddress ) = cmd;
    SDHC_CMD_RXSIZE( drv->baseaddress ) = resplen;
    if (resplen)
    {
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_SETMASK | SDHC_CTRL_CMD_TXENABLE | SDHC_CTRL_CMD_RXENABLE;
    }
    else
    {
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_SETMASK | SDHC_CTRL_CMD_TXENABLE;
    }

    if ( resplen )
    {
        // Wait for transmitter to be done
        timeout += clock();
        while( SDHC_STAT( drv->baseaddress ) & (SDHC_STAT_CMD_TXBUSY|SDHC_STAT_CMD_TXENABLE)) __nop() ;

        do
        {
            status = SDHC_STAT( drv->baseaddress );
            if ( (status & SDHC_STAT_CMD_RXEMPTY) == 0)
            {
                respdata[i] = (uint8_t)SDHC_CMD_RXFIFO( drv->baseaddress );
                debugprintf( " %02X", respdata[i] );
                if ( ++i == resplen )
                {
                    debugputs( "" );
                    // Wait for busy to disappear
                    do
                    {
                        status = SDHC_STAT( drv->baseaddress );
                    }
                    while( status & SDHC_STAT_CMD_RXBUSY  );
                    if ( (status & SDHC_STAT_CMD_RXEMPTY) == 0 ) return SDHC_ERR_EXTDATA;
                    if ( status & SDHC_STAT_CMD_CRCERR ) return SDHC_ERR_CRC;
                    return i;
                }
            }
        } while( clock() < timeout );
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RSTMASK | SDHC_CTRL_CMD_RXENABLE;
        debugputs( " ** Timeout **" );
        return i ? SDHC_ERR_NODATA : SDHC_ERR_NORESP;   // Receiver timeout
    }
    debugputs( "" );
    return 0;
}

static int transceive_acmd( sdhc_t * restrict drv, uint8_t cmd, uint32_t arg, int resplen, uint8_t * respdata, clock_t timeout )
{
    uint8_t response[SIZE_RESP_R1];
    int retval = transceive_cmd( drv, 55, (uint32_t)drv->rca << 16, SIZE_RESP_R1, response, timeout );
    if ( retval != SIZE_RESP_R1 )
    {
        return retval;
    }
    else
    {
        return transceive_cmd( drv, cmd, arg, resplen, respdata, timeout );
    }
}

/**
 * @brief Open an instance of the driver
 *
 * This function initializes both, the SD controller core and its driver.
 * You should call it only once per driver instance id. Note: this function
 * will not initialize the card!
 *
 * @param id
 *          Valid driver id (defined in devices.h)
 *
 * @return  Driver pointer if successful initialization, NULL otherwise.
 */
sdhc_t * sdhc_open(unsigned id)
{
    assert( id < DRV_SDHC_INSTANCE_COUNT );

    sdhc_t * restrict drv = &drv_table[id];

    if ( drv->baseaddress == 0 )
    {
        // get configuration of driver (created by plugin system)
        const drv_sdhc_cfg_instance_t * restrict drv_cfg = &drv_sdhc_instance_table[id];
        // get configuration of peripheral below driver (created by plugin system)
        const per_sdhc_cfg_instance_t * restrict per_cfg = &per_sdhc_instance_table[drv_cfg->per_sdhc];

        assert(per_cfg->baseaddress != 0);
        drv->baseaddress = per_cfg->baseaddress;
        // Stop a possibly operating core and reset it
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
#ifdef __LITTLE_ENDIAN__
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_SETMASK | SDHC_CTRL_ENDIANESS;
#endif

        // Than copy all the other parameters
        drv->dma_from = (uint8_t *) drv_cfg->dma_from;
        drv->dma_to = (uint8_t *) drv_cfg->dma_to;
        drv->dma_buf = (uint32_t) drv_cfg->dma_buf;
        drv->dma_buf_size = drv_cfg->dma_buf_size;

    }
    return drv;
}

/**
 * @brief Check if there's a card in the slot
 *
 * @param   drv Pointer to driver context
 *
 * @return  False is there's no card in the slot, True otherwise
 */

bool sdhc_card_detect( sdhc_t * restrict drv )
{
    return SDHC_STAT( drv->baseaddress ) & SDHC_STAT_SD_DETECT;
}


/**
 * @brief Check the switch on the SD card
 *
 * @param   drv Pointer to driver context
 *
 * @return  True if switched ON (card protected), False otherwise
 */

bool sdhc_card_protected( sdhc_t * restrict drv )
{
    return (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_SD_PROTECT) == 0;
}

/**
 * @brief Check if the SD card has been removed
 *
 * This function checks if the SD card has been removed. If a new SD card is inserted,
 * this function keeps returning True until it is reset through a call to sdhc_clear_card_removed()
 *
 * @param   drv Pointer to driver context
 *
 * @return  True if a card has been removed or if there's no card in the slot. True otherwise.
 */

bool sdhc_card_removed( sdhc_t * restrict drv )
{
    return (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_SD_REMOVED) ? true : false;
}

/**
 * @brief Set clock frequency on the SD host
 *
 * @param drv Pointer to driver context
 * @param sdclk Requested clock frequency of SD_CLK
 * @param sysclk System clock as provided on the CLK_I input of the host controller
 *
 * @return Value of SD_CLK actually set
 */

unsigned sdhc_set_speed( sdhc_t * restrict drv, unsigned sdclk, unsigned sysclk )
{
    unsigned divisor = sysclk / (sdclk * 2);
    if ( divisor < 2 ) divisor = 2;
    SDHC_CDIV( drv->baseaddress ) = divisor - 1;
    return sysclk / (divisor * 2);
}


typedef struct __packed__
{
    uint32_t    csd_structure       : 2;
    uint32_t                        : 6;
    uint32_t    taac                : 8;
    uint32_t    nsac                : 8;
    uint32_t    tran_speed          : 8;
    uint32_t    ccc                 : 12;
    uint32_t    read_bl_len         : 4;
    uint32_t    read_bl_partial     : 1;
    uint32_t    write_blk_misalign  : 1;
    uint32_t    read_blk_misalign   : 1;
    uint32_t    dsr_imp             : 1;
    uint32_t                        : 2;
    uint32_t    c_size              : 12;
    uint32_t    vdd_r_curr_min      : 3;
    uint32_t    vdd_r_curr_max      : 3;
    uint32_t    vdd_w_curr_min      : 3;
    uint32_t    vdd_w_curr_max      : 3;
    uint32_t    c_size_mult         : 3;
    uint32_t    erase_blk_en        : 1;
    uint32_t    sector_size         : 7;
    uint32_t    wp_grp_size         : 7;
    uint32_t    wp_grp_enable       : 1;
    uint32_t                        : 2;
    uint32_t    r2w_factor          : 3;
    uint32_t    write_bl_len        : 4;
    uint32_t    write_bl_partial    : 1;
    uint32_t                        : 5;
    uint32_t    file_format_grp     : 1;
    uint32_t    copy                : 1;
    uint32_t    perm_write_protect  : 1;
    uint32_t    tmp_write_protect   : 1;
    uint32_t    file_format         : 2;
    uint32_t                        : 2;
    uint32_t    crc                 : 7;
    uint32_t    the_end             : 1;
} csd_t;

void debug_dump_csd( uint8_t * p )
{
#ifdef SDHC_DEBUG
    csd_t * csd = (void *)p;

    printf( "*** CSD structure *** %04X%04X%04X%04X\n", read_big32from8( p ), read_big32from8( p+4 ), read_big32from8( p+8 ), read_big32from8( p+12 ) );
    printf( "CSD id (00)        = %X\n", csd->csd_structure );
    printf( "TAAC               = %02X\n", csd->taac );
    printf( "NSAC               = %02X\n", csd->nsac );
    printf( "TRAN_SPEED         = %02X\n", csd->tran_speed );
    printf( "CCC                = %03X\n", csd->ccc );
    printf( "READ_BL_LEN        = %X\n", csd->read_bl_len );
    printf( "READ_BL_PARTIAL    = %d\n", csd->read_bl_partial );
    printf( "WRITE_BLK_MISALIGN = %d\n", csd->write_blk_misalign );
    printf( "READ_BLK_MISALIGN  = %d\n", csd->read_blk_misalign );
    printf( "DSR_IMP            = %d\n", csd->dsr_imp );
    printf( "C_SIZE             = %03X\n", csd->c_size );
    printf( "VDD_R_CURR_MIN     = %X\n", csd->vdd_r_curr_min );
    printf( "VDD_R_CURR_MAX     = %X\n", csd->vdd_r_curr_max );
    printf( "VDD_W_CURR_MIN     = %X\n", csd->vdd_w_curr_min );
    printf( "VDD_W_CURR_MAX     = %X\n", csd->vdd_w_curr_max );
    printf( "C_SIZE_MULT        = %X\n", csd->c_size_mult );
    printf( "ERASE_BLK_EN       = %d\n", csd->erase_blk_en );
    printf( "SECTOR_SIZE        = %d\n", csd->sector_size );
    printf( "WP_GRP_SIZE        = %d\n", csd->wp_grp_size );
    printf( "WP_GRP_ENABLE      = %d\n", csd->wp_grp_enable );
    printf( "R2W_FACTOR         = %d\n", csd->r2w_factor );
    printf( "WRITE_BL_LEN       = %X\n", csd->write_bl_len );
    printf( "WRITE_BL_PARTIAL   = %d\n", csd->write_bl_partial );
    printf( "FILE_FORMAT_GRP    = %d\n", csd->file_format_grp );
    printf( "COPY               = %d\n", csd->copy );
    printf( "PERM_WRITE_PROTECT = %d\n", csd->perm_write_protect );
    printf( "TMP_WRITE_PROTECT  = %d\n", csd->tmp_write_protect );
    printf( "FILE_FORMAT        = %d\n", csd->file_format );
    printf( "CRC                = %02X\n", csd->crc );
    printf( "----------------   = %d\n", csd->the_end );

#endif
}

/**
 * @brief Initialize the card (SDIO simplified specification version 2.00)
 *
 * @param drv pointer to device driver context
 * @param init Initialization entry point
 *
 * @return status
 */

int sdhc_card_init( sdhc_t * restrict drv, sdhc_init_t init )
{
    uint8_t response[SIZE_RESP_MAX];
    int     retval;
    bool    flag_f8 = false;
    bool    flag_mp;
    clock_t timeout;
    clock_t cmdto;
    uint32_t ocr;
    uint32_t respval;

    const unsigned tran_speed_unit[] = { 10000, 100000, 1000000, 10000000 };
    const unsigned tran_speed_value[] = { 0, 10, 12, 13, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80 } ;

    const unsigned taac_unit[] = { 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000 };
    const unsigned taac_value[] = { 0, 10, 12, 13, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 80 } ;

    cmdto = CMDTIMEOUT;

    assert( drv != NULL );

    SDHC_STAT( drv->baseaddress ) = SDHC_STAT_SD_REMOVED;           // Reset the "removed" bit from the card
    if ( (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_SD_DETECT) == 0 ) return SDHC_ERR_NOCARD;

    // Initialize the controller
    SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;            // Reset the device, just to make sure there's nothing in there
#ifdef __LITTLE_ENDIAN__
    SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_SETMASK | SDHC_CTRL_ENDIANESS;
#endif
    SDHC_CDIV( drv->baseaddress ) = pal_freq_hz() / 800000;    // Set speed to 400 kHz

    // We need to wait for 74 clocks before doing anything.
    for ( timeout = clock() + 74 * CLOCKS_PER_SEC / 400000; clock() < timeout; ) ;

    drv->cardtype = SDHC_ERR_NOCARD;
    drv->rca = 0;

    // Step 1
    switch( init )
    {
    case SDHC_INIT_POWERON :    // Power On
        drv->sdio = false;
        // Step 2
        transceive_cmd( drv, 0, 0x00000000, 0, NULL, 0 );
        // Fallthrough
    case SDHC_INIT_MEMORY :    // Re-initialize memory
        drv ->sdmem = false;
        // Step 3: Send Interface Condition Command
        // Argument = VHS | check pattern
        //            VHS = 0001b (2.7 - 3.6V)
        //            check pattern = 0xAA
        retval = transceive_cmd( drv, 8, 0x000001AA, SIZE_RESP_R7, response, cmdto );

        if ( retval == SDHC_ERR_NORESP )
        {
            // Retry once if no response (see remarks in SD Host controller Simplified specification of initialization protocol)
            retval = transceive_cmd( drv, 8, 0x000001AA, SIZE_RESP_R7, response, cmdto );
        }
        
        
        if ( retval == SDHC_ERR_NORESP )
        {
            // Step 4
            flag_f8 = false;
        }
        else if ( retval == SIZE_RESP_R7 && read_big32from8( response + 1 ) == 0x000001AA)
        {
            // Step 5
            flag_f8 = true;
        }
        else
        {
            // Step 6
           SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
           return SDHC_ERR_UNUSABLE;
        }
        break;
    case SDHC_INIT_IO :
        // Step 7
        drv->sdio = false;
        transceive_cmd( drv, 52, 0x80000000 | (6 << 9) | (0x08 << 3), SIZE_RESP_R5, response, cmdto );
        break;
    }

    // Step 8
    if ( !(drv->sdio) )
    {
        // Step 9
        retval = transceive_cmd( drv, 5, 0x00000000, SIZE_RESP_R4, response, cmdto );
        // Note: R4 does not have a valid CRC, so SDHC_ERR_CRC is not a reason to invalidate the card!
        if ( retval != SIZE_RESP_R4 && retval != SDHC_ERR_CRC )
        {
            // Step 10.
            flag_mp = true;
        }
        else
        {
            respval = read_big32from8( response + 1 );
            // Perform response check: we should have at least 1 I/O function and the power window should contain 3.3V
            if ( (respval & IO_OP_COND_NF) && (respval & (OCR_32_33|OCR_33_34)) )
            {

                // Step 11 - not implemented: Set Voltage

                // Start timeout. We should set this to 1 second, but let's play nice to the software
                timeout = clock() + 2 * CLOCKS_PER_SEC;
                do
                {
                    // Step 12. Bits 20 and 21 of OCR are set: voltage window = 3.2..3.4V
                    retval = transceive_cmd( drv, 5, OCR_32_33|OCR_33_34, SIZE_RESP_R4, response, cmdto );
                    if ( retval != SIZE_RESP_R4 && retval != SDHC_ERR_CRC)
                    {
                        // Step 13: no or errorneous response, card is unusable
                        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
                        return SDHC_ERR_UNUSABLE;
                    }
                    // Step 14: check IORDY.
                    respval = read_big32from8( response + 1 );
                    if ( respval & OCR_RDY ) break;
                } while( clock() < timeout );
                if ( response[1] & 0x80 )
                {
                    // Step 15: signal that we've got an I/O capable card and that IO is initialized
                    drv->sdio = '1';
                }
            }
            // Step 16
            flag_mp = respval & IO_OP_COND_MP;
        }
    }
    else
    {
        // Default behavior for non SDIO cards: do something with memory :)
        flag_mp = true;
    }


    if ( flag_mp )
    {
        // Step 18
        retval = transceive_acmd( drv, 41, 0x00000000, SIZE_RESP_R3, response, cmdto );
        if ( retval != SIZE_RESP_R3 && retval != SDHC_ERR_CRC )
        {
            // Step 19, not an SD card
            SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
            return SDHC_ERR_UNUSABLE;

        }
        ocr = read_big32from8( response + 1 );
        if ( ocr & (OCR_32_33 | OCR_33_34))
        {
            // Step 20: OCR is okay
            // We do not support setting of other voltages
            timeout = clock() + 2 * CLOCKS_PER_SEC;
            do
            {
                // Step 21
                // Note: do not set HCS bit if CMD8 was not supported.
                retval = transceive_acmd( drv, 41, flag_f8 ? (OCR_32_33|OCR_33_34|OCR_HCS) : (OCR_32_33|OCR_33_34), SIZE_RESP_R3, response, cmdto );
                if ( retval != SIZE_RESP_R3 && retval != SDHC_ERR_CRC)
                {
                    // Step 22: no or errorneous response, card is unusable
                    SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
                    return SDHC_ERR_UNUSABLE;
                }
                ocr = read_big32from8( response + 1 );

                // Step 23: check MRDY
                if ( ocr & OCR_RDY )
                {
                    // Step 24
                    drv->sdmem = true;
                    if ( flag_f8 ) drv->highcap = ocr & OCR_CCS;
                    // Step 25
                    transceive_cmd( drv, 2, 0x00000000, SIZE_RESP_R2, response, cmdto );
                    break;
                }
            } while( clock() < timeout );

        }
    }

    // Step 26

    if ( !drv->sdmem && !drv->sdio )
    {
        transceive_cmd( drv, 15, 0x00000000, 0, NULL, 0 );
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
        return SDHC_ERR_UNUSABLE;

    }


    // Step 27
    retval = transceive_cmd( drv, 3, 0x00000000, SIZE_RESP_R6, response, cmdto );
    if ( retval != SIZE_RESP_R6 && retval != SDHC_ERR_CRC )
    {
        // Not according to spec, but CMD3 failed!
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
        return SDHC_ERR_UNUSABLE;
    }

    drv->rca = read_big16from8( response + 1 );

    // Set card type and we're done with card identification
    if ( !drv->sdio && drv->sdmem )
    {
        // Memory card
        drv->cardtype = drv->highcap ? SDHC_CARD_HCMEM : SDHC_CARD_SCMEM;
    }
    else if ( drv->sdio && drv->sdmem )
    {
        // Combo card
        drv->cardtype = drv->highcap ? SDHC_CARD_HCCOMBO : SDHC_CARD_SCCOMBO;
    }
    else if ( drv->sdio )
    {
        drv->cardtype = SDHC_CARD_IO;
    }
    else
    {
        drv->cardtype = SDHC_ERR_NOCARD;        // Should never happen
    }

    ////////////////////////////////////////////////////////////////////////////

    if ( drv->sdmem )
    {
        // Get CSD and determine system settings
        retval = transceive_cmd( drv, 9, (uint32_t)drv->rca << 16, SIZE_RESP_R2, response, cmdto );
        if ( retval != SIZE_RESP_R2 && retval != SDHC_ERR_CRC )
        {
            // Error
            SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
            return retval;
        }

        drv->speed = sdhc_set_speed( drv, tran_speed_unit[response[4] & 0x03] * tran_speed_value[(response[4] >> 3) & 0x0F], pal_freq_hz() );

        if ( drv->highcap )
        {
            // For SDHC: fixed as per Physical Layer Spec 2.00 section 4.6.2
            drv->read_delay = CLOCKS_PER_SEC / 10;
            drv->write_delay = CLOCKS_PER_SEC / 4;
            drv->info.blksize = 512;

        }
        else
        {
            unsigned taac;
            unsigned nsac;

            // TAAC = data read access-time, bits 2:0 = time unit, bits 6:3 = time value (in nsec)
            taac = taac_unit[response[2] & 0x07] * taac_value[(response[2] >> 3) & 0x0F] / 10;

            // NSAC = clock dependant factor of data access, in 100 SD_CLK cycles
            nsac = response[3];

            // Read delay is in system clocks (TAAC + NSAC)
            drv->read_delay = ((taac * CLOCKS_PER_SEC) / 1000000000ULL)  + CLOCKS_PER_SEC / drv->speed * 100;

            // Write delay is expressed as read delay * (1 << R2W_FACTOR)
            drv->write_delay = drv->read_delay << ((response[13] >> 4) & 0x7);
            drv->info.blksize = 1 << (response[6] & 0x0F);
        }

        if ( response[1] == 0x40 )
        {
            // CSD Version 2.0
            drv->info.blkcount = (read_big32from8( response + 7 ) & 0x3FFFFF) * 1024;
        }
        else
        {
            unsigned c_size = (read_big32from8( response + 6 ) >> 6) & 0xFFF;
            unsigned c_size_mult = (read_big16from8( response + 10 ) >> 7) & 0x07;
            drv->info.blkcount = (c_size+1) << (c_size_mult+2);
        }
    }
    else
    {
        // Default values for SDIO
        drv->speed = sdhc_set_speed( drv, 400000, pal_freq_hz() );
        drv->read_delay = 0;
        drv->write_delay = 0;
        drv->info.blksize = 0;
        drv->info.blkcount = 0;
    }


    // Select the card
    transceive_cmd( drv, 7, (uint32_t)drv->rca << 16, SIZE_RESP_R1B, response, cmdto );

    if ( drv->sdio )
    {
    }
    else
    {
        // Try to set blksize to 512 bytes
        if ( drv->info.blksize != 512 )
        {
            unsigned divisor = drv->info.blksize / 512;
            retval = transceive_cmd( drv, 16, 512, SIZE_RESP_R1, response, cmdto );
            drv->info.blksize = 512;
            drv->info.blkcount *= divisor;
        }

        // Switch card to 4-bit mode
        retval = transceive_acmd( drv, 6, 0x00000002, SIZE_RESP_R1, response, cmdto );
        if ((retval != SIZE_RESP_R1) || (respval = read_big32from8( response + 1 ), respval != (SDSTAT_READY|SDSTAT_CURRENT_STATE_TRAN|SDSTAT_APP_CMD)))
        {
            SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
            return SDHC_ERR_UNUSABLE;
        }
        // We're now in 4-bit mode. Prepare for block transfers
        SDHC_DAT_BLKSIZE( drv->baseaddress ) = drv->info.blksize;
    }

    return (int)drv->cardtype;

}

bool sdhc_set_blocklength( sdhc_t * drv, uint32_t blocklength )
{
    uint8_t response[SIZE_RESP_MAX];
    int retval;

    retval = transceive_cmd( drv, 16, blocklength, SIZE_RESP_R1, response, CMDTIMEOUT );
    if ( retval != SIZE_RESP_R1 ) return false;                     // Card does not answer
    retval = read_big16from8( response + 1 );
    if ( retval )
    {
        return false;   // Card returned errors
    }
    else
    {
        drv->info.blkcount *= drv->info.blksize / blocklength;
        drv->info.blksize = blocklength;
        SDHC_DAT_BLKSIZE( drv->baseaddress ) = blocklength;
        return true;
    }

}

uint32_t sdhc_get_status( sdhc_t * drv )
{
    uint8_t response[SIZE_RESP_MAX];
    int retval;

    retval = transceive_cmd( drv, 13, (uint32_t) drv->rca << 16, SIZE_RESP_R1, response, CMDTIMEOUT );
    return ( retval == SIZE_RESP_R1 ) ? read_big32from8( response + 1 ) : 0xFFFFFFFF;
}

/**
 * @brief Check if a previously initialized card has memory capabilities
 *
 * @param card Pointer to SD Card device context
 * @return False is card has no memory, true otherwise
 */

bool sdhc_is_memcard( int card )
{
    switch( card )
    {
    case SDHC_CARD_SCMEM :                    /* Card is a standard capacity memory only card */
    case SDHC_CARD_HCMEM :                    /* Card is a high capacity memory only card */
    case SDHC_CARD_SCCOMBO :                  /* Card is a standard capacity combo card */
    case SDHC_CARD_HCCOMBO :                  /* Card is a high capacity combo card */
        return true;
    default :
        return false;
    }
}

/**
 * @brief Retrieve card information structure
 *
 * @param drv Pointer to device driver context
 * @return pointer to information structure
 */

const sdhc_info_t *sdhc_get_info( sdhc_t * restrict drv )
{
    return &drv->info;
}

static int sdhc_read( sdhc_t * restrict drv, uint8_t *data, unsigned int addr, unsigned int blkcount )
{
    uint8_t response[SIZE_RESP_MAX];
    clock_t timeout;
    uint32_t status;
    int retval;

    if ( !sdhc_card_detect( drv ) ) return SDHC_ERR_NOCARD;

    // Arm the data receiver trigger
    SDHC_DAT_RXSIZE( drv->baseaddress ) = (uint32_t) blkcount * drv->info.blksize;
    SDHC_DAT_MEMADR( drv->baseaddress ) = (uint32_t)data;
    SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_SETMASK | SDHC_CTRL_DAT_RXENABLE;

    // Tell card we want data. If more than one sector, just start the transfer, otherwise  emit a "Read Single Block" command
    retval = transceive_cmd( drv, (blkcount > 1) ? 18 : 17, drv->highcap ? addr : addr * drv->info.blksize, SIZE_RESP_R1, response, CMDTIMEOUT );
    if ( retval != SIZE_RESP_R1 )
    {
        // Dang, we got an error! Stop data monitoring and return
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RSTMASK | SDHC_CTRL_DAT_RXENABLE;
        return retval;
    }

    // Wait for data transfer to begin
    timeout = clock() + drv->read_delay;
    while( SDHC_STAT( drv->baseaddress ) & SDHC_STAT_DAT_RXENABLE)
    {
        if ( clock() > timeout )
        {
            // Got a data timeout... stop receiver and tell user
            SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RSTMASK | SDHC_CTRL_DAT_RXENABLE;
            return 0;
        }
    }

    // Receiver has started, wait for it to finish
    do
    {
        status = SDHC_STAT( drv->baseaddress );
        if ( (status & SDHC_STAT_SD_DETECT) == 0 )
        {
            // No card!
            SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
            return 0;
        }

    } while( status & SDHC_STAT_DAT_RXBUSY );

    // And we're done. If we asked for continous data, stop transmission.
    if ( blkcount > 1 ) transceive_cmd( drv, 12, 0x00000000, SIZE_RESP_R1B, response, CMDTIMEOUT );
    if( status & (SDHC_STAT_DAT_CRCERR|SDHC_STAT_DMA_TIMEOUT) )
    {
        return 0;
    }
    else
    {
        return blkcount;
    }
}

/**
 * @brief Read sectors from SD Card
 *
 * @param drv Pointer to device driver context
 * @param data Pointer to datablock to return data in
 * @param lba Logical block address to start reading from
 * @param sectorcount Number of sectors to read
 *
 * @return Number of sector actually read from card (if not equal to sectorcount: some error occured)
 */

int sdhc_read_sectors( sdhc_t * restrict drv, uint8_t *data, unsigned int lba, unsigned int sectorcount )
{
    assert( drv != NULL );
    assert( data != NULL );
    assert( sectorcount != 0 );

    // First make sure the card is there and the peripheral is idle

    if( (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_SD_DETECT) == 0) return SDHC_ERR_NOCARD;
    if( (SDHC_STAT( drv->baseaddress ) & (SDHC_STAT_DAT_TXENABLE|SDHC_STAT_DAT_RXENABLE|SDHC_STAT_DAT_TXBUSY|SDHC_STAT_DAT_RXBUSY)) != 0) return SDHC_ERR_INTERNAL;

    while( (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_DAT_READY) == 0 ) ;

    // Check if we can do DMA. If not, use our own buffer
    if ( ((uintptr_t)data & 0x03) ||  data < drv->dma_from || (data + drv->info.blksize * sectorcount) > drv->dma_to )
    {
        unsigned int blocks_per_buf = drv->dma_buf_size / drv->info.blksize;
        unsigned int blocks;

        if ( drv->dma_buf_size == 0 ) return 0;     // Can't do DMA, but driver got no temp buffer either!

        for ( unsigned int i = sectorcount; i; i -= blocks )
        {
            blocks = (blocks_per_buf > sectorcount ) ? sectorcount : blocks_per_buf;
            if ( sdhc_read( drv, (uint8_t*)drv->dma_buf, lba, blocks ) == blocks )
            {
                memcpy( data, (uint8_t*)drv->dma_buf, drv->info.blksize * blocks );
                lba += blocks;
                data += drv->info.blksize * blocks;
            }
            else
            {
                return 0;
            }
        }
        return sectorcount;
    }
    else
    {
        return sdhc_read( drv, data, lba, sectorcount );
    }
}

/**
 * @brief Write sectors to SD Card
 *
 * @param drv Pointer to device driver context
 * @param data Pointer to datablock to be written
 * @param lba Logical block address to start writing from
 * @param sectorcount Number of sectors to write
 *
 * @return Number of sector actually written to card (if not equal to sectorcount: some error occured)
 */

int sdhc_write_sectors( sdhc_t * restrict drv, const uint8_t *data, unsigned int lba, unsigned int sectorcount )
{
    uint8_t response[SIZE_RESP_MAX];
    unsigned int sector;
    clock_t timeout;
    uint32_t status;
    uint32_t buf;

    int retval;

    assert( drv != NULL );
    assert( data != NULL );
    assert( sectorcount != 0 );

    // First make sure the card is still there and the peripheral is idle

    if( (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_SD_DETECT) == 0) return SDHC_ERR_NOCARD;
    if( (SDHC_STAT( drv->baseaddress ) & (SDHC_STAT_DAT_TXENABLE|SDHC_STAT_DAT_RXENABLE|SDHC_STAT_DAT_TXBUSY|SDHC_STAT_DAT_RXBUSY)) != 0) return SDHC_ERR_INTERNAL;

    while( (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_DAT_READY) == 0 ) ;

    // Instruct card there's data coming
    if (retval = transceive_cmd( drv, (sectorcount > 1) ? 25 : 24, drv->highcap ? lba : lba * drv->info.blksize, SIZE_RESP_R1, response, CMDTIMEOUT ), retval != SIZE_RESP_R1 )
    {
        // Buggah, error in command transmission
        return 0;
    }

    // Check if we've got DMA accessable memory
    if ( ((uintptr_t)data & 0x03) || data < drv->dma_from || (data + drv->info.blksize * sectorcount) > drv->dma_to )
    {
        // Either internal memory or unaligned, use of DMA directly to target is not possible
        if ( !drv->dma_buf_size) return 0;  // Oops... we have no temp buffer!
        buf = drv->dma_buf;
    }
    else
    {
        // Set buffer to data area and write DMA start address to peripheral
        buf = (uint32_t)data;
        SDHC_DAT_MEMADR( drv->baseaddress ) = buf;
    }

    // Per sector: send data
    for ( sector = 0; sector < sectorcount; sector++ )
    {
        // Copy data to DMA accessable memory if required
        if ( buf == drv->dma_buf )
        {
            memcpy( (void *)buf, data, drv->info.blksize );
            SDHC_DAT_MEMADR( drv->baseaddress ) = buf;
            data += drv->info.blksize;
        }

        // Send the data
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_SETMASK | SDHC_CTRL_DAT_TXENABLE;

        // Wait for TXEnable to disappear
        timeout = clock() + CLOCKS_PER_SEC / 4; // 250 msec
        do
        {
            status = SDHC_STAT( drv->baseaddress );
            if ( clock() > timeout )
            {
                break;
            }
        } while ( status & SDHC_STAT_DAT_TXENABLE );

        // We're sending data if everything goes as it should. Wait for busy to be gone
        while( status & SDHC_STAT_DAT_TXBUSY )
        {
            if ( (status & SDHC_STAT_SD_DETECT) == 0 )
            {
                // No card!
                SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
                return 0;
            }
            status = SDHC_STAT( drv->baseaddress );
        }

        if( status & (SDHC_STAT_DAT_TXENABLE|SDHC_STAT_DMA_TIMEOUT|SDHC_STAT_DAT_CRCERR))
        {
            // Timeout, DMA- or transmission error
            break;
        }
        if ( (status & SDHC_STAT_SD_DETECT) == 0 )
        {
            // No card
            break;
        }

    }

    // If we sent write_multiple_block, stop transmission
    if ( sectorcount > 1 ) transceive_cmd( drv, 12, 0, SIZE_RESP_R1B, response, CMDTIMEOUT );
    return sector;
}

/**
 * @brief Erase sectors on SD Card
 *
 * @param drv Pointer to device driver context
 * @param lba Logical block address to start erasing from
 * @param sectorcount Number of sectors to erase
 *
 * @return Number of sector actually erased on card (if not equal to sectorcount: some error occured)
 */

int sdhc_clear_sectors( sdhc_t * restrict drv, unsigned int lba, unsigned int sectorcount )
{
    uint8_t response[SIZE_RESP_MAX];
    int sector;
    clock_t timeout;
    uint32_t status;

    assert( drv != NULL );
    assert( sectorcount != 0 );

    // First make sure the card is still there and the peripheral is idle 

    if( (SDHC_STAT( drv->baseaddress ) & SDHC_STAT_SD_DETECT) == 0) return SDHC_ERR_NOCARD;
    if( (SDHC_STAT( drv->baseaddress ) & (SDHC_STAT_DAT_TXENABLE|SDHC_STAT_DAT_RXENABLE|SDHC_STAT_DAT_TXBUSY|SDHC_STAT_DAT_RXBUSY)) != 0) return SDHC_ERR_INTERNAL;
    memset( (void *)drv->dma_buf, 0, drv->info.blksize );

    if (transceive_cmd( drv, 25, drv->highcap ? lba : lba * drv->info.blksize, SIZE_RESP_R1, response, CMDTIMEOUT ) != SIZE_RESP_R1 )
    {
        return 0;
    }

    for ( sector = 0; sector < sectorcount; sector++ )
    {
        // Send the data
        SDHC_DAT_MEMADR( drv->baseaddress ) = drv->dma_buf;
        SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_SETMASK | SDHC_CTRL_DAT_TXENABLE;

        // Wait for TXEnable to disappear
        timeout = clock() + CLOCKS_PER_SEC / 4; // 250 msec
        do
        {
            status = SDHC_STAT( drv->baseaddress );
            if ( clock() > timeout )
            {
                break;
            }
        } while ( status & SDHC_STAT_DAT_TXENABLE );

        // We're sending data if everything goes as it should. Wait for busy to be gone
        while( status & SDHC_STAT_DAT_TXBUSY )
        {
            if ( (status & SDHC_STAT_SD_DETECT) == 0 )
            {
                // No card!
                SDHC_CTRL( drv->baseaddress ) = SDHC_CTRL_RESET;
                return 0;
            }
            status = SDHC_STAT( drv->baseaddress );
        }

        if( status & (SDHC_STAT_DAT_TXENABLE|SDHC_STAT_DMA_TIMEOUT|SDHC_STAT_DAT_CRCERR))
        {
            // Timeout, DMA- or transmission error
            break;
        }

    }

    // If we sent write_multiple_block, stop transmission
    if ( sectorcount > 1 ) transceive_cmd( drv, 12, 0, SIZE_RESP_R1B, response, CMDTIMEOUT );
    return sector;
}

