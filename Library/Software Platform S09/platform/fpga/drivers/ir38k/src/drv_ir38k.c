/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         IR Remote Control (38KHz) RX driver
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Interface to the WB_IR38KRX peripheral
|*
 */
#include <assert.h>
#include <interrupts.h>
#include <timing.h>

#include <drv_ir38k.h>
#include <drv_ir38k_cfg_instance.h>
#include "ir38kbuffer_type.h"

struct ir38k_drv_s
{
    uint8_t         rxint;
    ir38kbuffer_t   *rxbuffer;
    int             rxbuffer_size;
    int             rxoverrun;
    int             rxhead;
    int             rxtail;
    int             biterror;  // decoding errors
    int             repsens;   // sensitivity to received repeat codes
};

// runtime driver table
static ir38k_t ir38k_driver_table[DRV_IR38K_INSTANCE_COUNT];


/**
 * @brief Return the number of bit decode errors
 *
 * For every received NEC command you can get a maximum of 32 errors. This is because
 * each NEC RC command contains 32 bits.
 *
 * @param drv       ir38k driver pointer
 *
 * @return Number of biterrors
 */
int ir38k_getbiterror(ir38k_t * restrict drv)
{
    return drv->biterror;
}


/**
 * @brief Reset the decode biterror counter
 *
 * For every received NEC command you can get a maximum of 32 errors. This is because
 * each NEC RC command contains 32 bits.
 *
 * @param drv       ir38k driver pointer
 *
 * @return Nothing
 */
void ir38k_rstbiterror(ir38k_t * restrict drv)
{
    drv->biterror = 0;
}


/**
 * @brief Read and interpret received nec encoded pulse data (non blocking).
 *
 * This function can be used for both, interrupt and non-interrupt driven reception.
 *
 * @param drv       ir38k driver pointer
 * @param address   pointer to location for received address (custom) code
 * @param command   pointer to location for received command (data)
 *
 * @return repeated data (1), normal data (0) , buffer empty (-1) or (-2) on overflow
 */
int ir38k_rxnecdata(ir38k_t * restrict drv, uint16_t *address, uint16_t *command)
{
    int retvalue = -1;

    if (drv->rxhead != drv->rxtail)   // buffer not empty
    {
        if (drv->rxoverrun)
        {
            retvalue = -2;
            drv->rxoverrun = 0;
        }
        else
        {
            *command = (drv->rxbuffer[drv->rxtail].data >> 16) & 0xFFFF;
            *address = drv->rxbuffer[drv->rxtail].data & 0xFFFF;
            retvalue = drv->rxbuffer[drv->rxtail].repeat;
        }
        drv->rxtail++;
        if (drv->rxtail == drv->rxbuffer_size) drv->rxtail = 0;
    }
    return retvalue;
}


/**
 * @brief Actual IR NEC protocol decoder
 *
 * This function decodes a nec encoded data sequence
 *
 * @param drv   ir38k driver pointer
 * @param usecs time since previous rising edge
 *
 * @return Nothing
 */
static void nec_decoder(ir38k_t * restrict drv, uint64_t usecs)
{
    static enum {START, BITDET, STOP} state;
    static uint32_t nec_decdata;
    static int bitcount;
    static int repeat, repcount;
    int next = drv->rxhead + 1;
    
    if ((state != STOP) && (usecs >= (9000 + 4500 + 900 + 450))) // reset state: rxd inactive too long
    {
        bitcount = 0;
        state = START;
    }
    else
    {
        switch (state)
        {
        case START:
            if ((bitcount == 31) && (usecs >= (9000 + 2250 - 900 - 225)) && (usecs < (9000 + 2250 + 900 + 225)))
            {
                repeat = 1;
                repcount++;
                state = STOP;
            }
            else if ((usecs >= (9000 + 4500 - 900 - 450)) && (usecs < (9000 + 4500 + 900 + 450)))
            {
                nec_decdata = 0;
                repeat = 0;
                repcount = 0;
                bitcount = 0;
                state = BITDET;
            }
            else
            {
                bitcount = 0; // repeat codes are now meaningless
            }
            break;
        case BITDET:
            if ((usecs >= 560 + 1125) && (usecs < (2250 + 225)))
            {
                nec_decdata |= (1 << bitcount);
            }
            if ((usecs >= (2250 + 225)) || (usecs < (1125 - 225))) // biterror
            { 
               drv->biterror++;
               bitcount = 0;
               state = START;
            }
            else if (bitcount == 31)
                state = STOP;
            else
                bitcount = bitcount + 1;
            break;
        case STOP:
            state = START;
            break;
        default: ; // nothing
        }
        if (state == STOP) // complete sequence received; record
        {
            if (next == drv->rxbuffer_size) next = 0;
            if (next != drv->rxtail)
            {
                if ((repeat == 0) || (repcount > drv->repsens))
                {
                    drv->rxbuffer[drv->rxhead].data = nec_decdata;
                    drv->rxbuffer[drv->rxhead].repeat = repeat;
                    drv->rxhead = next;
                }
            }
            else
            {
                drv->rxoverrun = 1;
            }
        }
    }
}


// native interrupt wrapper
__INTERRUPT_NATIVE void ir38k_rx_handler_native(void)
{
    int num = interrupt_get_current();
    ir38k_t * drv = (ir38k_t *) interrupt_native_context(num);
    static uint64_t since_us;
    
    // clear cause of interrupt to allow detection of another
    interrupt_acknowledge(num);

    nec_decoder (drv, elapsed_time_us(since_us));
    since_us = clock_us();
}


/**
 * @brief Open an instance of the driver
 *
 * This function initializes both the IR38K core and its driver.
 * You should call it only once per id.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer on succesful initialization, NULL otherwise.
 */
ir38k_t *ir38k_open(int id)
{
    assert((id >= 0) && (id < DRV_IR38K_INSTANCE_COUNT));

    ir38k_t * restrict drv = &ir38k_driver_table[id];
    // get configuration of driver (created by plugin system)
    drv_ir38k_cfg_instance_t * restrict drv_cfg = &drv_ir38k_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    per_ir38k_cfg_instance_t * restrict per_cfg = &per_ir38k_instance_table[drv_cfg->per_ir38k];

    // initialize driver
    assert(drv_cfg->rxbuffer_size != 0);
    drv->rxint           = per_cfg->rxinterrupt;
    drv->rxbuffer        = drv_cfg->rxbuffer;
    drv->rxbuffer_size   = drv_cfg->rxbuffer_size;
    drv->repsens         = drv_cfg->repsens;
    drv->rxoverrun       = 0;
    drv->rxhead          = 0;
    drv->rxtail          = 0;
    drv->biterror        = 0;

    // Setup RX interrupt
    interrupt_register_native(drv->rxint, (void*) drv, ir38k_rx_handler_native);
    interrupt_configure(drv->rxint, EDGE_RISING);
    interrupt_acknowledge(drv->rxint);
    interrupt_enable(drv->rxint);
    return drv;
}
