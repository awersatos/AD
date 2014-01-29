/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        I2C master device driver.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver for I2CM_W peripheral.
 */

#include <assert.h>
#include <timing.h>
#include <interrupts.h>

#if __POSIX_KERNEL__
#include <pthread.h>
#endif

#include <per_i2cm.h>
#include <drv_i2cm.h>
#include <drv_i2cm_cfg_instance.h>

struct drv_i2cm_s
{
    uintptr_t   baseaddress;
    uint8_t     interrupt;
    uint8_t     occupied;
#if __POSIX_KERNEL__
    int wait_mode;
# if DRV_I2CM_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
# endif
#endif
};


// runtime driver table
static i2cm_t drv_table[DRV_I2CM_INSTANCE_COUNT];


inline void threadwait(i2cm_t * restrict drv)
{
#if __POSIX_KERNEL__
#if DRV_I2CM_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_I2CM_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
#endif
#if DRV_I2CM_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_I2CM_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
#if DRV_I2CM_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_I2CM_WAIT_MODE_SLEEP)
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



/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a I2CM core and its driver.
 * You should call it only once per id.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise.
 */

i2cm_t * i2cm_open( int id )
{
    uint16_t    clkdivisor;
    assert( id < DRV_I2CM_INSTANCE_COUNT );
    i2cm_t * restrict drv = &drv_table[id];
    const drv_i2cm_cfg_instance_t * restrict drv_cfg = &drv_i2cm_instance_table[id];
    const per_i2cm_cfg_instance_t * restrict per_cfg = &per_i2cm_instance_table[drv_cfg->per_i2cm];

    if ( drv->baseaddress == 0 )
    {
        // First time we get here, copy peripheral data to driver table, initialize the I2C bus peripheral and reset slaves
        assert(per_cfg->baseaddress != 0);
        drv->baseaddress = per_cfg->baseaddress;
        drv->interrupt = per_cfg->interrupt;
#if __POSIX_KERNEL__
        drv->wait_mode = drv_cfg->wait_mode;
# if DRV_I2CM_INSTANCE_WAIT_MODE_SLEEP_USED
        drv->wait_sleepms = drv_cfg->wait_sleepms;
# endif
#endif
        // Initialize the I2C master device
        clkdivisor =  freq_hz()/ (5 * drv_cfg->sclk ) - 1;
        I2CM_CTRL( drv->baseaddress ) =  0;
        I2CM_CLK0( drv->baseaddress ) = clkdivisor & 0xFF;
        I2CM_CLK1( drv->baseaddress ) = (clkdivisor >> 8) & 0xFF;

        // Reset slave statemachines
        for( int i = 0; i < 9; i++ )
        {
            I2CM_CTRL( drv->baseaddress ) = I2CM_CTRL_ENABLE  | I2CM_CTRL_IEN | I2CM_CTRL_STO;  // Make stop condition
            while( (I2CM_STAT( drv->baseaddress ) & I2CM_STAT_INTREQ) == 0 ) threadwait(drv);              // Wait for interrupt to occur
            I2CM_CTRL( drv->baseaddress ) = I2CM_CTRL_ENABLE | I2CM_CTRL_IACK;                  // Acknowledge the interrupt (wipe it)
        }

    }

    // And we're done
    return drv;
}

/**
 * @brief Transmit a single byte through the I2C bus
 *
 * This function transmits a single byte through the I2C bus. The transfer can
 * be preceeded by a startcondition, but it never generates a stop condition.
 *
 * @param      drv     i2cm driver pointer
 * @param      start   generate a (re-)start condition if true
 * @param      data    the byte that needs to be written
 *
 * @return     0 if okay, -1 otherwise
 */

int i2cm_putchar( i2cm_t * restrict drv, bool start, const uint8_t data )
{
    uint8_t ctrl = I2CM_CTRL_ENABLE  | I2CM_CTRL_WR | I2CM_CTRL_IEN;
    uint8_t status;

    assert( drv != NULL );

    if ( start ) ctrl |= I2CM_CTRL_STA;

    I2CM_WRDAT( drv->baseaddress ) = data;
    I2CM_CTRL( drv->baseaddress ) = ctrl;                               // Write

    while ( ((status = I2CM_STAT( drv->baseaddress )) & I2CM_STAT_INTREQ) == 0 ) threadwait(drv); // Wait for interrupt to appear

    I2CM_CTRL( drv->baseaddress ) = I2CM_CTRL_ENABLE | I2CM_CTRL_IACK;  // Acknowledge the interrupt (wipe it)
    return (status & I2CM_STAT_RXACK) ? -1 : 0;                         // And we're done!
}

/**
 * @brief Get a single byte from the I2C bus
 *
 * This function reads a byte from the I2C bus. The transfer can be be preceeded
 * by a startcondition, but it never generates a stop condition. In most cases, you
 * must acknowledge the reception of the byte if you want to continue reading after
 * this one. The final byte must than be NACK'd.
 *
 * @param      drv     i2cm driver pointer
 * @param      start   generate a (re)start condition if true
 * @param      ack     acknowledge bit
 *
 * @return     received byte value
 */

int i2cm_getchar( i2cm_t * restrict drv, bool start, bool ack)
{
    uint8_t ctrl = I2CM_CTRL_ENABLE | I2CM_CTRL_RD | I2CM_CTRL_IEN | I2CM_CTRL_NACK;
    uint8_t val;

    assert( drv != NULL );

    while( I2CM_STAT( drv->baseaddress ) & I2CM_STAT_BUSY ) threadwait(drv);

    if ( start ) ctrl |= I2CM_CTRL_STA;
    if ( ack ) ctrl &= ~I2CM_CTRL_NACK;
    I2CM_CTRL( drv->baseaddress ) = ctrl;
    while( (I2CM_STAT( drv->baseaddress ) & I2CM_STAT_INTREQ) == 0 ) threadwait(drv);  // Wait for interrupt to appear
    val = I2CM_RDDAT( drv->baseaddress );
    I2CM_CTRL( drv->baseaddress )  = I2CM_CTRL_ENABLE | I2CM_CTRL_IACK;  // Acknowledge the interrupt (wipe it)
    return val;
}

/**
 * @brief Write multiple bytes to an I2C device
 *
 * This function sends a stream to the specified I2C device. It first generates a start
 * condition, than sends out the slave address (with LSB = 0 to indicate writing). If acknowledged,
 * it continues to send out the bytes specified. It terminates all transfers with a stop condition.
 *
 * @param   drv     i2cm driver pointer
 * @param   address I2C address of remote device
 * @param   data    buffer with data to transmit
 * @param   length  number of bytes in buffer
 *
 * @return     -1 on error, 0 otherwise
 */

int i2cm_write( i2cm_t * restrict drv, const uint8_t address, const uint8_t * data, size_t length )
{
    int status;
    assert( drv != NULL );
    assert( data != NULL );
    assert( (address & 0x01) == 0 );

    status = i2cm_putchar( drv, true, address );
    if ( !status )
    {
        while( length-- )
        {
            status = i2cm_putchar( drv, false, *data++ );
            if ( (status == -1) && (length == 0) ) status = 0;
        }
    }
    i2cm_stop( drv );
    return status;
}

/**
 * @brief Read multiple bytes from an I2C device
 *
 * This function reads a block of data from the I2C slave. It first sends a start condition, than
 * sends the slave address (note: LSB should be '1' for reading!). If the address is acknowledged, it
 * reads from the bus, acknowledging each byte but the final one. When done, it generates a stop condition.
 *
 * @param   drv     i2cm driver pointer
 * @param   address I2C address of remote device
 * @param   data    buffer with data to receive
 * @param   length  number of bytes in buffer
 *
 * @return     -1 on error, last byte value read otherwise
 */

int i2cm_read( i2cm_t * restrict drv, const uint8_t address, uint8_t * data, size_t length )
{
    int status;
    assert( drv != NULL );
    assert( data != NULL );
    assert( (address & 0x01) == 1 );

    status = i2cm_putchar( drv, true, address );

    if ( !status )
    {
        while( length-- )
        {
            status = i2cm_getchar( drv, false, length != 0 );
            *data++ = status & 0xFF;
        }
    }
    i2cm_stop( drv );
    return status;
}

/**
 * @brief Generate a single stop condition
 *
 * This function generates a stop condition (rising edge SDA when SCL is stable high). If SCL
 * is high when calling this function, it first negates SCL. SDA follows if necessary; this will
 * never generate a start condition!
 *
 * @param   drv     i2cm driver pointer
 *
 * @return     -1 on error, 0 otherwise
 */

int i2cm_stop( i2cm_t * restrict drv )
{
    uint8_t status;
    assert( drv != NULL );
    I2CM_CTRL( drv->baseaddress ) = I2CM_CTRL_ENABLE | I2CM_CTRL_STO;

    while ( ((status = I2CM_STAT( drv->baseaddress )) & I2CM_STAT_INTREQ) == 0 ) threadwait(drv); // Wait for interrupt to appear

    I2CM_CTRL( drv->baseaddress ) = I2CM_CTRL_ENABLE | I2CM_CTRL_IACK;  // Acknowledge the interrupt (wipe it)
    return (status & I2CM_STAT_RXACK) ? -1 : 0;                         // And we're done!
}


/**
 * @brief Get control over the I2C bus
 *
 * Try to het control over the I2C bus. Don't do anything on the bus except i2cm_open().
 *
 * @param   drv     i2cm driver pointer
 *
 * @return     -1 if you didn't get it, 0 otherwise
 */

int i2cm_get_bus( i2cm_t * restrict drv )
{
    if ( drv->occupied )
    {
        return -1;
    }
    else
    {
        drv->occupied = 1;
        return 0;
    }
}

/**
 * @brief Release control over the I2C bus
 *
 * This function releases control over the I2C bus. Note that you are responsible for the bus to be in idle state
 * before releasing the bus!
 *
 * @param   drv     i2cm driver pointer
 *
 * @return     nothing
 */

void i2cm_release_bus( i2cm_t * restrict drv )
{
    drv->occupied = 0;
}
