/*****************************************************************************\
|*
|*  IN PACKAGE: SPI device driver
|*
|*  COPYRIGHT: Copyright (c) 2009, Altium
|*
 */

/**
 * @file
 * Device driver for WB_SPI peripheral.
 *
 */

#include <stdlib.h>
#include <assert.h>
#include <time.h>
#include <pal.h>

#include <per_spi.h>
#include <drv_spi.h>

struct drv_spi_s
{
    uintptr_t   baseaddress;
    uint8_t     inputpinscount;
    uint8_t     slavecount;
    uint8_t     channel;
    bool        transfersize8;               // hardware only supports 8 bit transfers
    uint32_t    cdiv[DRV_SPI_INSTANCE_CHANNELS_MAX + 1];
    uint32_t    ctrl[DRV_SPI_INSTANCE_CHANNELS_MAX + 1];
#if __POSIX_KERNEL__
    int wait_mode;
# if DRV_SPI_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
# endif
#endif
} ;

// runtime driver table
static spi_t drv_table[DRV_SPI_INSTANCE_COUNT];


inline void threadwait(spi_t * restrict drv)
{
#if __POSIX_KERNEL__
#if DRV_SPI_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_SPI_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
#endif
#if DRV_SPI_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_SPI_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
#if DRV_SPI_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_SPI_WAIT_MODE_SLEEP)
    {
        struct timespec ts = { 0, drv->wait_sleepms * 1000 * 1000 };

        nanosleep (&ts, NULL);
    }
    else
#endif
    { /* never reached */ }
#else
    // without RTOS
    __nop();
#endif
}

inline uint32_t spi_calc_cdiv( uint32_t baudrate )
{
    uint32_t cdiv;
    cdiv = PAL_CLOCKHZ / (baudrate * 2);
    if (((PAL_CLOCKHZ / cdiv) >> 1) > baudrate ) cdiv++;
    if ( cdiv == 0 ) cdiv = 1;
    return cdiv - 1;
}

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the WB_SPI core and its driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise
 */

spi_t * spi_open( int id )
{
    assert( id < DRV_SPI_INSTANCE_COUNT );

    uint32_t ctrl = SPI_CTRL_CS;            // Initialize, CS = high, MODE = low

    spi_t * restrict drv = &drv_table[id];

    if ( drv->baseaddress == 0 )
    {
        const drv_spi_cfg_instance_t * restrict drv_cfg = &drv_spi_instance_table[id];
        const per_spi_cfg_instance_t * restrict per_cfg = &per_spi_instance_table[drv_cfg->per_spi];
        assert( per_cfg->baseaddress != 0 );
        drv->baseaddress = per_cfg->baseaddress;
        drv->inputpinscount = 8; // core defines 8 general purpose inputs (only available for sdcard for now)
        drv->slavecount = per_cfg->slavecount & 0xFF;
//        drv->transfersize8 = SPI_STAT(drv->baseaddress) & SPI_STAT_8BIT;
        drv->transfersize8 = (per_cfg->transfersize == 8)? 1 : 0;
        drv->channel = 0;         // Initially, the bus is assumed to be free

#if __POSIX_KERNEL__
        drv->wait_mode = drv_cfg->wait_mode;
# if DRV_SPI_INSTANCE_WAIT_MODE_SLEEP_USED
        drv->wait_sleepms = drv_cfg->wait_sleepms;
# endif
#endif
        // Initialize the core: set baudrate
        spi_set_baudrate( drv, drv_cfg->spi_frequency );

        // default to bigendian transfers (this is _NOT_ related to the endianness of the CPU)
        ctrl |= SPI_CTRL_ENDIAN;

        switch( drv_cfg->spimode )
        {
            case 1 :
                ctrl |= SPI_CTRL_CPHA;
                break;
            case 2 :
                ctrl |= SPI_CTRL_CPOL;
                break;
            case  3 :
                ctrl |= SPI_CTRL_CPOL | SPI_CTRL_CPHA;
                break;
            default : ; // CPOL = 0, CPHA = 0 (mode 0) => do nothing
        }
        SPI_CTRL( drv->baseaddress ) = ctrl;
    }
    // And we're done!
    return drv;
}

/**
 * @brief    Sets the baudrate of the SPI core
 *
 * This function sets the baudrate of the SPI core
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param   baudrate New baudrate to be used in bps
 *
 * @return Nothing
 */

void spi_set_baudrate( spi_t * restrict drv, uint32_t baudrate )
{

    assert( drv != NULL );

    SPI_CDIV( drv->baseaddress ) = spi_calc_cdiv( baudrate );
}



/**
 * @brief    Retrieves the actual baudrate of the SPI core
 *
 * This function retrieves the actual baudrate of the SPI core
 *
 * @param  drv  Driver pointer as returned from spi_open
 *
 * @return Actual baudrate used, in bps
 */

uint32_t spi_get_baudrate( spi_t * restrict drv )
{
    assert( drv != NULL );
    return (PAL_CLOCKHZ / (SPI_CDIV( drv->baseaddress ) + 1)) / 2;
}

/**
 * @brief    Sets the endianess of the SPI core
 *
 * This function switches multibyte actions of the SPI core
 * to little endian or to big endian. This defines which byte
 * in a multibyte transfer is send first and where received
 * bytes are stored in the receiver word. Little endian: shifts
 * out bits 7 to 0 first, big endian shifts bits 7 to 0 last.
 *
 * Note: This only sets the endianness of the transfers over SPI,
 * and is not related to the endianness of the CPU. The endianness
 * is set to big endian by default by the spi_open() routine.
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param   endianess false: little endian, big endian otherwise
 *
 * @return Nothing
 */

void spi_set_endianess( spi_t * restrict drv, bool endianess )
{
    assert( drv != NULL );
    if ( endianess )
    {
        SPI_CTRL( drv->baseaddress ) |= SPI_CTRL_ENDIAN;
//        drv->bigendian = 1;
    }
    else
    {
        SPI_CTRL( drv->baseaddress ) &= ~SPI_CTRL_ENDIAN;
//        drv->bigendian = 0;
    }
}

/**
 * @brief   Switches SPI mode
 *
 * @param   drv Driver pointer as returned from spi_open
 * @param   mode: SPI mode to switch core to
 *
 * @return  Nothing
 */

void spi_set_mode( spi_t * restrict drv, const spi_mode_t mode )
{
    uint32_t ctrl;
    assert( drv != NULL );

    ctrl = SPI_CTRL( drv->baseaddress ) & ~(SPI_CTRL_CPOL | SPI_CTRL_CPHA);
    
    switch( mode )
    {
        case SPI_MODE1 :
            ctrl |= SPI_CTRL_CPHA;
            break;
        case SPI_MODE2 :
            ctrl |= SPI_CTRL_CPOL;
            break;
        case SPI_MODE3 :
            ctrl |= SPI_CTRL_CPOL | SPI_CTRL_CPHA;
            break;
        default : /* Should be SPI_MODE0 */ ; // CPOL = 0, CPHA = 0 (mode 0) => do nothing
    }
    SPI_CTRL( drv->baseaddress ) = ctrl;
}

/**
 * @brief   Lowers the CS pin of the SPI core
 *
 * This function drives the CS pin the SPI core low and thus
 * selects the slave peripheral
 *
 * @param  drv  Driver pointer as returned from spi_open
 *
 * @return Nothing
 */

void spi_cs_lo( spi_t * restrict drv )
{
    assert( drv != NULL );
    SPI_CTRL( drv->baseaddress ) &= ~SPI_CTRL_CS;
}

/**
 * @brief    Raises the CS pin of the SPI core
 *
 * This function drives the CS pin the SPI core high and thus
 * deselects the slave peripheral
 *
 * @param  drv  Driver pointer as returned from spi_open
 *
 * @return Nothing
 */

void spi_cs_hi( spi_t * restrict drv )
{
    assert( drv != NULL );
    SPI_CTRL( drv->baseaddress ) |= SPI_CTRL_CS;
}

/**
 * @brief    Transmit a byte
 *
 * This function transmits a single byte over SPI and does not
 * wait for an answer
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param  val  Value to be send to the slave
 *
 * @return Nothing
 */

void spi_transmit8( spi_t * restrict drv, uint8_t val )
{
    assert( drv != NULL );
    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
    SPI_DATA8( drv->baseaddress ) = val;
}

/**
 * @brief    Transmit and receive a byte
 *
 * This function transfers a single byte over SPI, waits for its
 * completion and returns what is sent back by the slave. Use this
 * function if you just want is to receive; make sure you send 0xFF
 * in that case.
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param  val  Value to be send to the slave
 *
 * @return byte as received from the slave
 */

uint8_t spi_transceive8( spi_t * restrict drv, uint8_t val )
{
    assert( drv != NULL );
    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
    SPI_DATA8( drv->baseaddress ) = val;
    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
    return (uint8_t)SPI_DATA8( drv->baseaddress );
}

/**
 * @brief    Get a single byte from the receiver register
 *
 * This function reads the receiver register from the core, which is
 * filled during a previously started 8-bit transfer.
 *
 * @param  drv  Driver pointer as returned from spi_open
 *
 * @return byte as received from the slave
 */


uint8_t spi_received8( spi_t * restrict drv )
{
    assert( drv != NULL );
    return (uint8_t)SPI_DATA8( drv->baseaddress );
}

/**
 * @brief    Transmit a half word
 *
 * This function transmits a half word (two bytes) over SPI and does
 * not wait for an answer. If big endianess is selected, send out
 * bits 15 to 8 first, followed by bits 7 to 0. If small endianess
 * is selected, bits 7 to 0 are sent first, than 15 to 8.
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param  val  Value to be send to the slave
 *
 * @return Nothing
 */

void spi_transmit16( spi_t * restrict drv, uint16_t val )
{
    assert( drv != NULL );

    if (drv->transfersize8)
    {
        bool bigendian = (SPI_CTRL( drv->baseaddress ) & SPI_CTRL_ENDIAN) ? true : false;
        int m = bigendian? 8 : 0;
        int n = bigendian? -8 : 8;

        for (int i = 0; i < 2; i++)
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            SPI_DATA8( drv->baseaddress ) = (val >> m) & 0xFF;
            m += n;
        }
    }
    else
    {
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        SPI_DATA16( drv->baseaddress ) = val;
    }
}

/**
 * @brief    Transmit and receive a half word
 *
 * This function transmits a half word (two bytes) over SPI, waits
 * until its completion and returns what is sent back by the slave.
 * Use this function if you just want is to receive; make sure you
 * send 0xFFFF in that case.
 *
 * If big endianess is selected, transfer bits 15 to 8 first,
 * followed by bits 7 to 0. If small endianess is selected,
 * bits 7 to 0 are transferred first, than 15 to 8.
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param  val  Value to be send to the slave
 *
 * @return byte as received from the slave
 */

uint16_t spi_transceive16( spi_t * restrict drv, uint16_t val )
{
    assert( drv != NULL );

    uint16_t ret = 0;

    if (drv->transfersize8)
    {
        bool bigendian = (SPI_CTRL( drv->baseaddress ) & SPI_CTRL_ENDIAN) ? true : false;
        int m = bigendian? 8 : 0;
        int n = bigendian? -8 : 8;

        for (int i = 0; i < 2; i++)
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            SPI_DATA8( drv->baseaddress ) = (val >> m) & 0xFF;
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            ret = (uint16_t)(ret + (SPI_DATA8(drv->baseaddress) << m));
            m += n;
        }
    }
    else
    {
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        SPI_DATA16( drv->baseaddress ) = val;
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        ret = (uint16_t) SPI_DATA16( drv->baseaddress );
    }

    return ret;
}

/**
 * @brief    Get a half word from the receiver register
 *
 * This function reads the receiver register from the core, which is
 * filled during a previously started 16-bit transfer.
 *
 * @param  drv  Driver pointer as returned from spi_open
 *
 * @return byte as received from the slave
 */

uint16_t spi_received16( spi_t * restrict drv )
{
    assert( drv != NULL );
    return (uint16_t)SPI_DATA16( drv->baseaddress );
}

/**
 * @brief    Transmit a word
 *
 * This function transmits one word (four bytes) over SPI and does
 * not wait for an answer. If big endianess is selected, send out
 * bits 31 down to to 0. If small endianess is selected, bits 7 to 0
 * are sent first, than 15 to 8, than 23 to 16 and finally bits 31 to 24.
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param  val  Value to be send to the slave
 *
 * @return Nothing
 */

void spi_transmit32( spi_t * restrict drv, uint32_t val )
{
    assert( drv != NULL );

    if (drv->transfersize8)
    {
        bool bigendian = (SPI_CTRL( drv->baseaddress ) & SPI_CTRL_ENDIAN) ? true : false;
        int m = bigendian? 24 : 0;
        int n = bigendian? -8 : 8;

        for (int i = 0; i < 4; i++)
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            SPI_DATA8( drv->baseaddress ) = (val >> m) & 0xFF;
            m += n;
        }
    }
    else
    {
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        SPI_DATA32( drv->baseaddress ) = val;
    }
}

/**
 * @brief    Transmit and receive a word
 *
 * This function transmits one word (four bytes) over SPI, waits
 * for its completion and returns what is sent back by the slave.
 * Use this function if you just want is to receive; make sure you
 * send 0xFFFFFFFF
 *
 * If big endianess is selected, transfer bits 31 down to to 0.
 * If small endianess is selected, bits 7 to 0 are transferred
 * first, than 15 to 8, than 23 to 16 and finally bits 31 to 24.
 *
 * @param  drv  Driver pointer as returned from spi_open
 * @param  val  Value to be send to the slave
 *
 * @return Nothing
 */

uint32_t spi_transceive32( spi_t * restrict drv, uint32_t val )
{
    assert( drv != NULL );

    uint32_t ret = 0;

    if (drv->transfersize8)
    {
        bool bigendian = (SPI_CTRL( drv->baseaddress ) & SPI_CTRL_ENDIAN) ? true : false;
        int m = bigendian? 24 : 0;
        int n = bigendian? -8 : 8;

        for (int i = 0; i < 4; i++)
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            SPI_DATA8( drv->baseaddress ) = (val >> m) & 0xFF;
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            ret = ret + (SPI_DATA8(drv->baseaddress) << m);
            m += n;
        }
    }
    else
    {
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        SPI_DATA32( drv->baseaddress ) = val;
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        ret = SPI_DATA32( drv->baseaddress );
    }

    return ret;
}

/**
 * @brief    Get a word from the receiver register
 *
 * This function reads the receiver register from the core, which is
 * filled during a previously started 32-bit transfer.
 *
 * @param  drv  Driver pointer as returned from spi_open
 *
 * @return byte as received from the slave
 */

uint32_t spi_received32( spi_t * restrict drv )
{
    assert( drv != NULL );
    return SPI_DATA32( drv->baseaddress );
}

/**
 * @brief   Checks if the SPI core is busy
 *
 * This function checks if the SPI core is busy (i.e.: not idle)
 *
 * @param drv   Driver pointer as returned from spi_open
 *
 * @return false if the core is idle, true if transfer is in progress
 */

bool spi_busy( spi_t * restrict drv )
{
    assert( drv != NULL );
    return ( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) ? true : false;
}

/**
 * @brief   Try to get control over the SPI bus
 *
 * This function tries to get control over the NanoBoard bus
 * and select a single device.
 *
 * @param   drv  Driver pointer as returned from spi_open
 *
 * @param   channel SPI channel identifier from NanoBoard peripheral
 *
 * @return false if SPI is not available to the daughterboard or the channel number is invalid, true otherwise
 */

bool spi_get_bus( spi_t * restrict drv, uint8_t channel )
{
#if DRV_SPI_INSTANCE_NB_MULTIPLEX_SUPPORT_TRUE_USED
    uint8_t  data;
    uint32_t cdiv;
    uint32_t ctrl;
#endif

    assert( drv != NULL );

    if ( drv->channel ) return false;                                                       // Bus is opened by someone else!
    if ( (channel == 0) || (channel > DRV_SPI_INSTANCE_CHANNELS_MAX) ) return false;       // Illegal channel requested

#if DRV_SPI_INSTANCE_NB_MULTIPLEX_SUPPORT_TRUE_USED

    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);                  // Wait for pending SPI communication to finish

    ctrl = SPI_CTRL( drv->baseaddress );
    cdiv = SPI_CDIV( drv->baseaddress );
    drv->ctrl[0] = ctrl;
    drv->cdiv[0] = cdiv;

    SPI_CTRL( drv->baseaddress ) = ctrl | SPI_CTRL_CS;                                      // De-select slave
//    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_CPHA;                             // Set mode 1, endianess = don't care
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS;                             // Set mode 1, endianess = don't care
    SPI_CDIV( drv->baseaddress ) = spi_calc_cdiv( 5000000 );                                // Set SPI speed to 5 MHz
//    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_CPHA | SPI_CTRL_MODE;             // Select multiplexer
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_MODE;             // Select multiplexer
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_MODE;             // Select multiplexer
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS;             // Select multiplexer
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS;             // Select multiplexer
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_MODE;             // Select multiplexer
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_MODE;             // Select multiplexer

    SPI_DATA8( drv->baseaddress ) = channel | 0x80;
    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
    SPI_DATA8( drv->baseaddress ) = channel | 0x80;
    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);

    data = (uint8_t)SPI_DATA8( drv->baseaddress );

    SPI_CDIV( drv->baseaddress ) = cdiv;
    SPI_CTRL( drv->baseaddress ) = ctrl;

    if ( data )
    {
        // Another master has the bus...
        return false;
    }
    else
#endif

    {
        // Succes!
        drv->channel = channel;
        if ( drv->cdiv[channel] )
        {
            SPI_CDIV( drv->baseaddress ) = drv->cdiv[channel];
            SPI_CTRL( drv->baseaddress ) = drv->ctrl[channel];
        }
        return true;
    }
}

/**
 * @brief   Return control over the SPI bus to the NanoBoard controller
 *
 * This function releases the SPI bus to the NanoBoard controller. You must call
 * this function when you are done with the SPI devices - the firmware running
 * the NanoBoard GUI depends on it.
 *
 * @param   drv  Driver pointer as returned from spi_open
 *
 * @return Nothing
 */

void spi_release_bus( spi_t * restrict drv )
{
    uint8_t  channel;

    assert( drv != NULL );

    channel = drv->channel;
    if ( channel == 0 ) return;

    drv->ctrl[channel] = SPI_CTRL( drv->baseaddress );
    drv->cdiv[channel] = SPI_CDIV( drv->baseaddress );

#if DRV_SPI_INSTANCE_NB_MULTIPLEX_SUPPORT_TRUE_USED
    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);

    SPI_CTRL( drv->baseaddress ) |= SPI_CTRL_CS;                                            // De-select slave
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_CPHA;                             // Set mode 1, endianess = don't care
    SPI_CDIV( drv->baseaddress ) = spi_calc_cdiv( 5000000 );                                // Set speed to 5 MHz
    SPI_CTRL( drv->baseaddress ) = SPI_CTRL_CS | SPI_CTRL_CPHA | SPI_CTRL_MODE;             // Select multiplexer

    SPI_DATA8( drv->baseaddress ) = 0;
    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
    SPI_CDIV( drv->baseaddress ) = drv->cdiv[0];
    SPI_CTRL( drv->baseaddress ) = drv->ctrl[0];
#endif
    drv->channel = 0;
}

/**
 * @brief   Initialize the bus CTRL and CDIV settings for a channel
 *
 * Use this function to initialize a channel without actually owning the bus. The values
 * set here will be used when ownership to the bus is established through spi_get_bus()
 *
 * @param drv  Driver pointer as returned from spi_open
 * @param channel Channel number to set data on
 * @param baudrate Baudrate to be set
 * @param spimode SPI mode to be set
 *
 * @return false if the settings could not be used, true otherwise
 */

bool spi_init_channel( spi_t * restrict drv, uint8_t channel, uint32_t baudrate, spi_mode_t spimode )
{
    uint32_t ctrl = SPI_CTRL_CS;

    assert( drv != NULL );
    if ( drv->channel == channel ) return false;
    if ( channel > DRV_SPI_INSTANCE_CHANNELS_MAX ) return false;

    // default to bigendian transfers (this is _NOT_ related to the endianness of the CPU)
    ctrl |= SPI_CTRL_ENDIAN;

    switch( spimode )
    {
        case 1 :
            ctrl |= SPI_CTRL_CPHA;
            break;
        case 2 :
            ctrl |= SPI_CTRL_CPOL;
            break;
        case  3 :
            ctrl |= SPI_CTRL_CPOL | SPI_CTRL_CPHA;
            break;
        default : ; // CPOL = 0, CPHA = 0 (mode 0) => do nothing
    }

    drv->cdiv[channel] = spi_calc_cdiv( baudrate );
    drv->ctrl[channel] = ctrl;

    return true;
}

/**
 * @brief   Get number of general purpose input pins
 *
 * This function returns the number of general purpose input pins available
 *
 * @param   drv Driver pointer as returns from spi_open
 *
 * @return  Number of input pins on the SPI peripheral
 */

uint8_t spi_get_gpin_pincount( spi_t * restrict drv )
{
    return drv->inputpinscount;
}

/**
 * @brief   Get number of chip select output pins
 *
 * This function returns the number of chip select output pins available.
 * This number of spi slaves can be connected.
 *
 * @param   drv Driver pointer as returns from spi_open
 *
 * @return  Number of chip select output pins on the SPI peripheral
 */

uint8_t spi_get_slavecount( spi_t * restrict drv )
{
    return drv->slavecount;
}

/**
 * @brief   Read general purpose input pins
 *
 * This function returns the value of the general purpose input pins
 *
 * @param   drv Driver pointer as returns from spi_open
 *
 * @return  Value of the input pins
 */

uint8_t spi_get_gpin( spi_t * restrict drv )
{
    return (uint8_t)(SPI_GPIN( drv->baseaddress ) & 0xFF);
}

/**
 * @brief   Set chip select output pins
 *
 * This function writes the chip select output pins
 *
 * @param   drv Driver pointer as returns from spi_open
 * @param   val Bit pattern to be written to the output pins port
 *
 * @return  Nothing
 */
 
void spi_set_cs( spi_t * restrict drv, uint8_t val )
{
    SPI_CS( drv->baseaddress ) = val;
} 

/**
 * @brief   Read chip select output pins
 *
 * This functions returns the value of the chip select output pins
 *
 * @param   drv Driver pointer as returns from spi_open
 *
 * @return  Value of the output pins
 */

uint8_t spi_get_cs( spi_t * restrict drv )
{
    return (uint8_t)(SPI_CS( drv->baseaddress ) & 0xFF);
}

/**
 * @brief Read a block of data from SPI
 *
 * This function reads a block of data from the SPI bus using 8- and 32-bit accesses
 * into (unaligned) memory.
 *
 * For this to work correctly, you need to have the endianess control set to match the
 * processor's native endianess!
 *
 * @param drv Driver pointer as returns from spi_open
 * @param buf Pointer to memory to store data in
 * @param bufsize Size of block to read, in bytes
 *
 * @return Nothing
 */

void spi_readblock( spi_t * restrict drv, uint8_t * buf, int bufsize )
{
    uint32_t * buf32;

    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);

    if ( bufsize < 10 )
    {
        SPI_DATA8( drv->baseaddress ) = 0xFF;
        while( --bufsize )
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            *buf = (uint8_t)SPI_DATA8( drv->baseaddress );
            SPI_DATA8( drv->baseaddress ) = 0xFF;
            buf++;
        }
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        *buf = (uint8_t)SPI_DATA8( drv->baseaddress );
    }
    else
    {
        while (((uintptr_t)buf) & 0x03 )
        {
            SPI_DATA8( drv->baseaddress ) = 0xFF;
            bufsize--;
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            *buf++ = (uint8_t)SPI_DATA8( drv->baseaddress );
        }

        buf32 = (void *)buf;
        SPI_DATA32( drv->baseaddress ) = 0xFFFFFFFF;
        while( bufsize > 7 )
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            *buf32 = SPI_DATA32( drv->baseaddress );
            SPI_DATA32( drv->baseaddress ) = 0xFFFFFFFF;
            buf32++;
            bufsize -= 4;
        }
        while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        *buf32++ = SPI_DATA32( drv->baseaddress );
        buf = (void *)buf32;

//        bufsize -= 4;
        while ( bufsize > 4 )
        {
            SPI_DATA8( drv->baseaddress ) = 0xFF;
            bufsize--;
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            *buf++ = (uint8_t)SPI_DATA8( drv->baseaddress );
        }
    }
}

/**
 * @brief Write a block of data to SPI
 *
 * This function writes a block of (unaligned) data to the SPI bus using 8- and 32-bit accesses.
 * Note: the function does *not* wait for the SPI bus to signal it's ready before returning.
 *
 * For this function to work correctly, you need to have the endianess control set to match the
 * processor's native endianess!
 *
 * @param drv Driver pointer as returns from spi_open
 * @param buf Pointer to data block to write
 * @param bufsize Size of block to write, in bytes
 *
 * @return Nothing
 */

void spi_writeblock( spi_t * restrict drv, uint8_t * buf, int bufsize )
{
    uint32_t * buf32;

    while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);

    if ( bufsize < 8 )
    {
        SPI_DATA8( drv->baseaddress ) = *buf++;
        while( --bufsize )
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            SPI_DATA8( drv->baseaddress ) = *buf++;
        }
    }
    else
    {
        while (((uintptr_t)buf) & 0x03 )
        {
            SPI_DATA8( drv->baseaddress ) = *buf++;
            bufsize--;
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
        }

        buf32 = (void *)buf;

        while( bufsize > 3 )
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            SPI_DATA32( drv->baseaddress ) = *buf32++;
            bufsize -= 4;
        }

        buf = (void *)buf32;
        while ( bufsize )
        {
            while( SPI_STAT( drv->baseaddress ) & SPI_STAT_BUSY ) threadwait(drv);
            SPI_DATA8( drv->baseaddress ) = *buf++;
            bufsize--;
        }
    }
}
