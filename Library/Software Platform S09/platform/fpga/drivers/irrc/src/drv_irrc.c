/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         IR Remote Control driver
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Interface to the WB_IRRC peripheral
|*
 */
#include <assert.h>
#include <pal.h>
#include <interrupts.h>
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#endif
#include <time.h>

#include <per_irrc.h>
#include <drv_irrc.h>
#include <drv_irrc_cfg_instance.h>
#include "irrxbuffer_type.h"

struct irrc_drv_s
{
    uintptr_t     baseaddr;
    uint8_t       rxint;  // raw: mark or space detected; nec: command/repeat data received
    // workcopies from driver configuration
    irrxbuffer_t  *rxbuffer;
    int           rxbuffer_size;
    uint32_t      codec;
    uint32_t      fcarrier;
    int           rxoverrun;
    int           rxhead;
    int           rxtail;
#if __POSIX_KERNEL__
    int wait_mode;
# if DRV_IRRC_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
# endif
#endif
};

// runtime driver table
static irrc_t irrc_driver_table[DRV_IRRC_INSTANCE_COUNT];


inline void threadwait(irrc_t * restrict drv)
{
#if __POSIX_KERNEL__
#if DRV_IRRC_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_IRRC_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
#endif
#if DRV_IRRC_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_IRRC_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
#if DRV_IRRC_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_IRRC_WAIT_MODE_SLEEP)
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
 * @brief Get the configured codec
 *
 * The codecs (RAW, RC5 or NEC) are defined in the header file
 * of this driver.
 *
 * @param drv       irrc driver pointer
 *
 * @return the currently active codec
 */
uint32_t irrc_getcodec(irrc_t * restrict drv)
{
    return drv->codec;
}


/**
 * @brief Get the status register of the IrRC hardware
 *
 * This status register contains the send and recieve
 * status of the hardware. For a detailed description of the IrRC
 * registers, see the Core Reference
 * <a href="CR0188 WB_IRRC Infrared coder.PDF">CR0188 WB_IRRC Infrared coder</a>
 *
 * @param drv       irrc driver pointer
 *
 * @return the contents of the hardware status register
 */
uint32_t irrc_getstatus(irrc_t * restrict drv)
{
    return IRRC_STATUS(drv->baseaddr);
}


/**
 * @brief Get the control register of the IrRC hardware
 *
 * This control register contains the mode of operation
 * of the IrRC hardware. For a detailed description of the IrRC
 * registers, see the Core Reference
 * <a href="CR0188 WB_IRRC Infrared coder.PDF">CR0188 WB_IRRC Infrared coder</a>
 *
 * @param drv       irrc driver pointer
 *
 * @return the contents of the control register
 */
uint32_t irrc_getctrl(irrc_t * restrict drv)
{
    return IRRC_CTRL(drv->baseaddr);
}


/**
 * @brief Set the control IrRC hardware register
 *
 * This registers controls the mode of operation
 * of the IrRC hardware. For a detailed description
 * of the IrRC registers, see the Core Reference
 * <a href="CR0188 WB_IRRC Infrared coder.PDF">CR0188 WB_IRRC Infrared coder</a>
 *
 * @param drv       irrc driver pointer
 * @param value     value to be set
 *
 * @return Nothing.
 */
void irrc_setctrl(irrc_t * restrict drv, uint32_t value)
{
    IRRC_CTRL(drv->baseaddr) = value;
}


/**
 * @brief Check if repeated data has arrived
 *
 * @param drv       irrc driver pointer
 *
 * @return 0 if no repeat data available, non-zero if there is repeated data
 */
int irrc_rxrepeat(irrc_t * restrict drv)
{
    return IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXREPEAT;
}


/**
 * @brief Check if new data has arrived
 *
 * Interrupts do not have to be enabled to use this function.
 * The rxint status is also reset in this function.
 *
 * @param drv       irrc driver pointer
 *
 * @return 0 if no data available, non-zero if there is new data
 */
int irrc_rxdata(irrc_t * restrict drv)
{
    int retvalue = 0;

    if (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXINT)
    {
        IRRC_CTRL(drv->baseaddr) |= IRRC_CTRL_RXINTRST;
        retvalue = 1;
    }
    return retvalue;
}


/**
 * @brief Read the data register
 *
 * The meaning of this data is depending on the mode of operation
 * (RC5, NEC or RAW). Normally you would like to use irrc_rxrawdata()
 * , irrc_rxrc5data() or irrc_rxnecdata() to interpret this data.
 *
 * @param drv       irrc driver pointer
 *
 * @return Value of data register
 */
uint32_t irrc_data(irrc_t * restrict drv)
{
    return IRRC_DATA(drv->baseaddr);
}


/**
 * @brief Read raw pulse data (non blocking).
 *
 * The function will return the duration of the received pulses (mark)
 * and the silence period (space) before this pulse train(mark).
 * Every Mark/Space will generate one datavalue. So e.g. when receiving
 * Marks and spaces with a frequency of 2kHz (NEC protocol) you also
 * need to call this routine with 2kHz. If you're not able to do that
 * you could make reception interrupt controlled and use a large rxbuffer...
 *
 * @param drv       irrc driver pointer
 * @param usecs     true: return count in usecs, false: return count in carrier periods
 * @param *pcount   length of received pulse train
 * @param *scount   length of silence

 *
 * @return Ok (0), buffer empty (-1) or (-2) on overflow
 */
int irrc_rxrawdata(irrc_t * restrict drv, int usecs, uint32_t *pcount, uint32_t *scount)
{
    int retvalue = -1;

    if (drv->rxbuffer_size)   // interrupts used
    {
        if (drv->rxhead != drv->rxtail)   // buffer not empty
        {
            if (drv->rxoverrun)
            {
                retvalue = -2;
                drv->rxoverrun = 0;
            }
            else
            {
                *pcount = (drv->rxbuffer[drv->rxtail].data & 0xFFFF0000) >> 16;
                *scount = drv->rxbuffer[drv->rxtail].data & 0xFFFF;
                if (usecs)
                {
                    *pcount *= 1000000 / drv->fcarrier;
                    *scount *= 1000000 / drv->fcarrier;
                }
                retvalue = 0;
                drv->rxtail++;
                if (drv->rxtail == drv->rxbuffer_size) drv->rxtail = 0;
            }
        }
    }
    else
    {
        if (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXINT)
        {
            if (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXOVERRUN)
            {
                retvalue = -2;
            }
            else
            {
                *pcount = (drv->rxbuffer[drv->rxtail].data & 0xFFFF0000) >> 16;
                *scount = drv->rxbuffer[drv->rxtail].data & 0xFFFF;
                if (usecs)
                {
                    *pcount *= 1000000 / drv->fcarrier;
                    *scount *= 1000000 / drv->fcarrier;
                }
                retvalue = 0;
            }
            // acknowledge reception (reset interrupt)
            IRRC_CTRL(drv->baseaddr) |= IRRC_CTRL_RXINTRST;
        }
    }
    return retvalue;
}


/**
 * @brief Read and interpret received extended rc5 encoded pulse data (non blocking).
 *
 * This function can be used for both, interrupt and non-interrupt driven reception
 *
 * @param drv       irrc driver pointer
 * @param *address  received address
 * @param *command  received command
 *
 * @return repeated data (1), normal data (0) , buffer empty (-1) or (-2) on overflow
 */
int irrc_rxrc5data(irrc_t * restrict drv, uint16_t *address, uint16_t *command)
{
    int retvalue = -1;

    if (drv->rxbuffer_size) // interrupt controlled reception
    {
        if (drv->rxhead != drv->rxtail)   // buffer not empty
        {
            if (drv->rxoverrun)
            {
                retvalue = -2;
                drv->rxoverrun = 0;
            }
            else
            {
                *command = ((~drv->rxbuffer[drv->rxtail].data & 0x1000) >> 6) + drv->rxbuffer[drv->rxtail].data & 0x3F;
                *address = (drv->rxbuffer[drv->rxtail].data >> 6) & 0x1F;
                retvalue = drv->rxbuffer[drv->rxtail].repeat;
                drv->rxtail++;
                if (drv->rxtail == drv->rxbuffer_size) drv->rxtail = 0;
            }
        }
    }
    else
    {
        if (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXINT)
        {
            if (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXOVERRUN)
            {
                retvalue = -2;
            }
            else
            {
                *command = ((~IRRC_DATA(drv->baseaddr) & 0x1000) >> 6) + (IRRC_DATA(drv->baseaddr) & 0x3F);
                *address = (IRRC_DATA(drv->baseaddr) >> 6) & 0x1F;
                retvalue = (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXREPEAT)? 1 : 0;
            }
            // acknowledge reception (reset interrupt)
            IRRC_CTRL(drv->baseaddr) |= IRRC_CTRL_RXINTRST;
        }
    }
    return retvalue;
}


/**
 * @brief Read and interpret received nec encoded pulse data (non blocking).
 *
 * This function can be used for both, interrupt and non-interrupt driven reception
 *
 * @param drv       irrc driver pointer
 * @param *address  received address (custom) code
 * @param *command  received command (data)
 *
 * @return repeated data (1), normal data (0) , buffer empty (-1) or (-2) on overflow
 */
int irrc_rxnecdata(irrc_t * restrict drv, uint16_t *address, uint16_t *command)
{
    int retvalue = -1;

    if (drv->rxbuffer_size) // interrupt controlled reception
    {
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
                drv->rxtail++;
                if (drv->rxtail == drv->rxbuffer_size) drv->rxtail = 0;
            }
        }
    }
    else
    {
        if (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXINT)
        {
            if (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXOVERRUN)
            {
                retvalue = -2;
            }
            else
            {
                *command = (IRRC_DATA(drv->baseaddr) >> 16) & 0xFFFF;
                *address = IRRC_DATA(drv->baseaddr) & 0xFFFF;
                retvalue = (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXREPEAT)? 1 : 0;
            }
            // acknowledge reception (reset interrupt)
            IRRC_CTRL(drv->baseaddr) |= IRRC_CTRL_RXINTRST;
        }
    }
    return retvalue;
}


/**
 * @brief transmit raw pulse data (non-blocking).
 *
 * This function will transmit a pulse burst (pcount pulses) followed by a
 * period (scount) of silence. Each count (pcount and scount) is measured in
 * carrier periods.
 *
 * @param drv       irrc driver pointer
 * @param pcount    generate this number of pulses followed by
 * @param scount    this number of quiescence periods
 *
 * @return Nothing.
 */
void irrc_txrawdata(irrc_t * restrict drv, uint32_t pcount, uint32_t scount)
{
    uint32_t data = (pcount << 16) + scount; // LSB is transmitted first

    // wait while transmitter is ready
    while(IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_TXBUSY);
    IRRC_DATA(drv->baseaddr) = data;
}


/**
 * @brief transmit nec encoded pulse data frame (non-blocking).
 *
 * This function will transmit a 16 bit address and command in NEC compatible
 * format. Using count > 1 will send one normal NEC dataframe and count - 1
 * repeat frames. Worst case this function will block software execution for
 * count * 108ms.
 *
 * @param drv       irrc driver pointer
 * @param count     repeat the transmission count - 1 times
 * @param address   address (custom) code
 * @param command   command (data)
 *
 * @return Nothing.
 */
void irrc_txnecdata(irrc_t * restrict drv, int count, uint16_t address, uint16_t command)
{
    uint32_t data = (command << 16) + address; // LSB is transmitted first

    for(int i = 0; i < count; i++)
    {
        // wait while transmitter is busy
        while(IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_TXBUSY) threadwait(drv);
        IRRC_DATA(drv->baseaddr) = data;
    }
}

// native interrupt wrapper

__INTERRUPT_NATIVE void irrc_rx_handler_native(void)
{
    int num = interrupt_get_current();
    irrc_t * drv = (irrc_t *) interrupt_native_context(num);
    int next = drv->rxhead + 1;

    // clear cause of interrupt to allow detection of another
    interrupt_acknowledge(num);
    // reset core interrupt
    IRRC_CTRL(drv->baseaddr) |= IRRC_CTRL_RXINTRST;

    if (next == drv->rxbuffer_size) next = 0; // wrap
    if (next != drv->rxtail) // overrun?
    {
        drv->rxbuffer[drv->rxhead].data = IRRC_DATA(drv->baseaddr);
        drv->rxbuffer[drv->rxhead].repeat = (IRRC_STATUS(drv->baseaddr) & IRRC_STATUS_RXREPEAT)? 1 : 0;
        drv->rxhead = next;
    }
    else
    {
        drv->rxoverrun = 1;
    }
}


/**
 * @brief Open an instance of the driver
 *
 * This function initializes both the IRRC core and its driver.
 * You should call it only once per id.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer on succesful initialization, NULL otherwise.
 */
irrc_t *irrc_open(int id)
{
    assert((id >= 0) && (id < DRV_IRRC_INSTANCE_COUNT));

    irrc_t * restrict drv = &irrc_driver_table[id];
    // get configuration of driver (created by plugin system)
    drv_irrc_cfg_instance_t * restrict drv_cfg = &drv_irrc_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    per_irrc_cfg_instance_t * restrict per_cfg = &per_irrc_instance_table[drv_cfg->per_irrc];
    uint32_t clk = (uint32_t) pal_freq_hz();

    // initialize driver
    assert(per_cfg->baseaddress != 0);
    drv->baseaddr        = per_cfg->baseaddress;
    drv->rxint           = per_cfg->rxinterrupt;
    drv->codec           = drv_cfg->codec;
    drv->fcarrier        = drv_cfg->fcarrier;
    drv->rxbuffer        = drv_cfg->rxbuffer;
    drv->rxbuffer_size   = drv_cfg->rxbuffer_size;
    drv->rxoverrun       = 0;
    drv->rxhead          = 0;
    drv->rxtail          = 0;
 #if __POSIX_KERNEL__
    drv->wait_mode       = drv_cfg->wait_mode;
# if DRV_IRRC_INSTANCE_WAIT_MODE_SLEEP_USED
    drv->wait_sleepms    = drv_cfg->wait_sleepms;
# endif
#endif
    // initialize core
    IRRC_CLK(drv->baseaddr) = (uint32_t)((drv->fcarrier * 0x1000000ULL) / clk);         // set carrier frequency
    switch(drv->codec)
    {
    case DRV_IRRC_CODEC_RAW :
        IRRC_CTRL(drv->baseaddr) = IRRC_CTRL(drv->baseaddr) & ~IRRC_CTRL_CODEC | IRRC_CTRL_RAW; // Select RAW protocol
        break;
    case DRV_IRRC_CODEC_NEC :
        IRRC_CTRL(drv->baseaddr) = IRRC_CTRL(drv->baseaddr) & ~IRRC_CTRL_CODEC | IRRC_CTRL_NEC; // Select NEC protocol
        break;
    case DRV_IRRC_CODEC_RC5 :
        IRRC_CTRL(drv->baseaddr) = IRRC_CTRL(drv->baseaddr) & ~IRRC_CTRL_CODEC | IRRC_CTRL_RC5; // Select RC5 protocol
        break;
    default :  ; // Do nothing
    }
    if (drv->rxbuffer_size != 0)
    {
        // disable core interrupt generation and reset the core interrupt
        IRRC_CTRL(drv->baseaddr) = IRRC_CTRL(drv->baseaddr) & ~IRRC_CTRL_INTEN | IRRC_CTRL_RXINTRST;
        // driver has a software buffer, use native interrupt
        interrupt_register_native(drv->rxint, (void*) drv, irrc_rx_handler_native);
        interrupt_configure(drv->rxint, EDGE_RISING);
        interrupt_acknowledge(drv->rxint);
        interrupt_enable(drv->rxint);
        // enable core interrupt generation (IRRC_CTRL_RXINTRST itself is reset by core)
        IRRC_CTRL(drv->baseaddr) |= IRRC_CTRL_INTEN;
    }
    return drv;
}
