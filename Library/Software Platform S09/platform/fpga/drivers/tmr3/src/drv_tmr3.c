/**
 *  COPYRIGHT:     Copyright (c) 2008, Altium
 *
 *  DESCRIPTION:   TMR3 Dual Timer Unit
 */

#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include <drv_tmr3_cfg_instance.h>
#include <drv_tmr3.h>
#include <per_tmr3_cfg_instance.h>
#include <per_tmr3.h>
#include <interrupts.h>

typedef enum {
    mode_13bit,
    mode_16bit,
    mode_8bit_autoreload,
    mode_dual_8bit
} tmr3_mode;

typedef struct
{
    tmr3_mode   mode;
    bool        counter_mode;
    bool        gated;
    union {
        uint16_t    val_13bit;
        uint16_t    val_16bit;
        uint8_t     val_8bit;
    } val;
} tmr3_value;

struct _tmr3_t
{
    bool                    open;

    tmr3_value              value_a;
    tmr3_handler            handler_a;
    void                    *data_a;
    bool                    handler_a_installed;

    tmr3_value              value_b;
    tmr3_handler            handler_b;
    void                    *data_b;
    bool                    handler_b_installed;

    const per_tmr3_cfg_instance_t *periph;
};

static tmr3_t   tmr3_table[DRV_TMR3_INSTANCE_COUNT];


static void __INTERRUPT_NATIVE tmr3_interrupt(void)
{
    tmr3_t *drv;

    drv = interrupt_native_context(interrupt_get_current());

    if (TMR3_TCON(drv->periph->baseaddress) & TCON_TFA)
    {
        TMR3_TCON(drv->periph->baseaddress) &= ~TCON_TFA;
        if (drv->handler_a_installed)
        {
            drv->handler_a(drv, drv->data_a);
        }
    }

    if (TMR3_TCON(drv->periph->baseaddress) & TCON_TFB)
    {
        TMR3_TCON(drv->periph->baseaddress) &= ~TCON_TFB;
        if (drv->handler_b_installed)
        {
            drv->handler_b(drv, drv->data_b);
        }
    }

    interrupt_acknowledge(drv->periph->interrupt);
    return;
}


static void
timer_a_configure(tmr3_t *drv)
{
    uint8_t     tmod;
    uint32_t    addr;

    addr = drv->periph->baseaddress;
    tmod = TMR3_TMOD(addr) & ~ (TA_GATE|TA_COUNTER|TA_MODE3);
    if (drv->value_a.counter_mode)
    {
        tmod |= TA_COUNTER;
    }
    if (drv->value_a.gated)
    {
        tmod |= TA_GATE;
    }

    switch (drv->value_a.mode)
    {
        case mode_13bit:
            tmod |= TA_MODE0;
            TMR3_TMOD(addr) = tmod;
            TMR3_TLA(addr) = drv->value_a.val.val_13bit & 0x14;
            TMR3_THA(addr) = (drv->value_a.val.val_13bit >> 5) & 0xff;
            break;
        case mode_16bit:
            tmod |= TA_MODE1;
            TMR3_TMOD(addr) = tmod;
            TMR3_TLA(addr) = drv->value_a.val.val_16bit & 0xff;
            TMR3_THA(addr) = (drv->value_a.val.val_16bit >> 8) & 0xff;
            break;
        case mode_8bit_autoreload:
            tmod |= TA_MODE2;
            TMR3_TMOD(addr) = tmod;
            TMR3_TLA(addr) = drv->value_a.val.val_8bit;
            TMR3_THA(addr) = drv->value_a.val.val_8bit;
            break;
        case mode_dual_8bit:
            tmod |= TA_MODE3;
            TMR3_TMOD(addr) = tmod;
            TMR3_TLA(addr) = drv->value_a.val.val_16bit & 0xff;
            TMR3_THA(addr) = (drv->value_a.val.val_16bit >> 8) & 0xff;
            break;
    }
}


static void
timer_b_configure(tmr3_t *drv)
{
    uint8_t     tmod;
    uint32_t    addr;

    addr = drv->periph->baseaddress;
    tmod = TMR3_TMOD(addr) & ~ (TB_GATE|TB_COUNTER|TB_MODE3);
    if (drv->value_b.counter_mode)
    {
        tmod |= TB_COUNTER;
    }
    if (drv->value_b.gated)
    {
        tmod |= TB_GATE;
    }

    switch (drv->value_b.mode)
    {
        case mode_13bit:
            tmod |= TB_MODE0;
            TMR3_TMOD(addr) = tmod;
            TMR3_TLB(addr) = drv->value_b.val.val_13bit & 0x14;
            TMR3_THB(addr) = (drv->value_b.val.val_13bit >> 5) & 0xff;
            break;
        case mode_16bit:
            tmod |= TB_MODE1;
            TMR3_TMOD(addr) = tmod;
            TMR3_TLB(addr) = drv->value_b.val.val_16bit & 0xff;
            TMR3_THB(addr) = (drv->value_b.val.val_16bit >> 8) & 0xff;
            break;
        case mode_8bit_autoreload:
            tmod |= TB_MODE2;
            TMR3_TMOD(addr) = tmod;
            TMR3_TLB(addr) = drv->value_b.val.val_8bit;
            TMR3_THB(addr) = drv->value_b.val.val_8bit;
            break;
        case mode_dual_8bit:
            /* does not exist for timer B */
            break;
    }
}


/**
 * @brief   opens the specified tmr3 device
 *
 * @param   id      id of the device to open
 *
 * @return  pointer to opened device or NULL when device could not be opend
 */
tmr3_t *
drv_tmr3_open(int id)
{
    if (id >= 0 && id < DRV_TMR3_INSTANCE_COUNT)
    {
        if (tmr3_table[id].open == false)
        {
            memset(&tmr3_table[id], 0, sizeof(tmr3_table[id]));
            tmr3_table[id].open = true;
            tmr3_table[id].periph = &per_tmr3_instance_table[drv_tmr3_instance_table[id].per_tmr3];

            assert(tmr3_table[id].periph->baseaddress != 0);
            tmr3_table[id].value_a.counter_mode = drv_tmr3_instance_table[id].timer_a_counter_mode;
            tmr3_table[id].value_a.gated = drv_tmr3_instance_table[id].timer_a_gated;
            switch (drv_tmr3_instance_table[id].timer_a_mode)
            {
                case 0:
                    tmr3_table[id].value_a.mode = mode_13bit;
                    tmr3_table[id].value_a.val.val_13bit = drv_tmr3_instance_table[id].timer_a_13bit;
                    break;
                case 1:
                    tmr3_table[id].value_a.mode = mode_16bit;
                    tmr3_table[id].value_a.val.val_16bit = drv_tmr3_instance_table[id].timer_a_16bit;
                    break;
                case 2:
                    tmr3_table[id].value_a.mode = mode_8bit_autoreload;
                    tmr3_table[id].value_a.val.val_8bit = drv_tmr3_instance_table[id].timer_a_auto_reload;
                    break;
                case 3:
                    tmr3_table[id].value_a.mode = mode_dual_8bit;
                    tmr3_table[id].value_a.val.val_16bit =
                            drv_tmr3_instance_table[id].timer_a_tla | (drv_tmr3_instance_table[id].timer_a_tha << 8);
                    break;
            }
            timer_a_configure(&tmr3_table[id]);

            tmr3_table[id].value_b.counter_mode = drv_tmr3_instance_table[id].timer_b_counter_mode;
            tmr3_table[id].value_b.gated = drv_tmr3_instance_table[id].timer_b_gated;
            switch (drv_tmr3_instance_table[id].timer_b_mode)
            {
                case 0:
                    tmr3_table[id].value_b.mode = mode_13bit;
                    tmr3_table[id].value_b.val.val_13bit = drv_tmr3_instance_table[id].timer_b_13bit;
                    break;
                case 1:
                    tmr3_table[id].value_b.mode = mode_16bit;
                    tmr3_table[id].value_b.val.val_16bit = drv_tmr3_instance_table[id].timer_b_16bit;
                    break;
                case 2:
                    tmr3_table[id].value_b.mode = mode_8bit_autoreload;
                    tmr3_table[id].value_b.val.val_8bit = drv_tmr3_instance_table[id].timer_b_auto_reload;
                    break;
            }
            timer_b_configure(&tmr3_table[id]);

            /* register interrupt */
            interrupt_register_native(tmr3_table[id].periph->interrupt, &tmr3_table[id], tmr3_interrupt);
        }
        return &tmr3_table[id];
    }
    return NULL;
}


/**
 * @brief   close a tmr3 device
 *
 * @param   drv     device to close
 *
 * @return 0 on succes, -1 in case error
 */
int
drv_tmr3_close(tmr3_t *drv)
{
    if (drv != NULL)
    {
        if (drv->open == true)
        {
            drv_tmr3_timer_a_stop(drv);
            drv_tmr3_timer_b_stop(drv);
            drv->open = false;
            /* deregister interrupt */
            interrupt_register_native(per_tmr3_instance_table[0].interrupt, NULL, NULL);
        }
        return 0;
    }
    return -1;
}


/**
 * @brief   start timer A
 *
 * @param   drv     device of which to start timer A
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_a_start(tmr3_t *drv)
{
    if (drv != NULL && drv->open)
    {
        /* enable tmr3 interrupt */
        TMR3_TCON(drv->periph->baseaddress) = (TMR3_TCON(drv->periph->baseaddress) & ~TCON_TFA) | TCON_TRA;
        interrupt_enable(drv->periph->interrupt);
        return 0;
    }
    return -1;
}


/**
 * @brief   stop timer A
 *
 * @param   drv     device of which to stop timer A
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_a_stop(tmr3_t *drv)
{
    if (drv != NULL && drv->open)
    {
        TMR3_TCON(drv->periph->baseaddress) &= ~TCON_TRA;
        if ( !(TMR3_TCON(drv->periph->baseaddress) & (TCON_TRA | TCON_TRB)))
        {
            /* both timer not running, disable tmr3 interrupt */
            interrupt_disable(drv->periph->interrupt);
        }
        return 0;
    }
    return -1;
}


/**
 * @brief   start timer B
 *
 * @param   drv     device of which to start timer B
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_b_start(tmr3_t *drv)
{
    if (drv != NULL && drv->open)
    {
        /* enable tmr3 interrupt */
        TMR3_TCON(drv->periph->baseaddress) = (TMR3_TCON(drv->periph->baseaddress) & ~TCON_TFB) | TCON_TRB;
        interrupt_enable(drv->periph->interrupt);
        return 0;
    }
    return -1;
}


/**
 * @brief   stop timer B
 *
 * @param   drv     device of which to stop timer B
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_b_stop(tmr3_t *drv)
{
    if (drv != NULL && drv->open)
    {
        TMR3_TCON(drv->periph->baseaddress) &= ~TCON_TRB;
        if ( !(TMR3_TCON(drv->periph->baseaddress) & (TCON_TRA | TCON_TRB)))
        {
            /* both timer not running, disable tmr3 interrupt */
            interrupt_disable(drv->periph->interrupt);
        }
        return 0;
    }
    return -1;
}


/**
 * @brief   set handler for timer A, only one handler can be associated with
 *          timer A at a time.
 *
 * @param   drv     driver
 * @param   handler user handler to call when an interrupt for timer A occurs
 * @param   data    application data to pass to the handler
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_a_set_handler(tmr3_t *drv, tmr3_handler handler, void *data)
{
    if (drv != NULL && drv->open)
    {
        if (handler != NULL)
        {
            drv->handler_a = handler;
            drv->data_a = data;
            drv->handler_a_installed = 1;
        }
        else
        {
            drv->handler_a_installed = 0;
            drv->handler_a = NULL;
            drv->data_a = NULL;
        }
        return 0;
    }
    return -1;
}


/**
 * @brief   set handler for timer B, only one handler can be associated with
 *          timer B at a time.
 *
 * @param   drv     driver
 * @param   handler user handler to call when an interrupt for timer B occurs
 * @param   data    application data to pass to the handler
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_b_set_handler(tmr3_t *drv, tmr3_handler handler, void *data)
{
    if (drv != NULL && drv->open)
    {
        if (handler != NULL)
        {
            drv->handler_b = handler;
            drv->data_b = data;
            drv->handler_b_installed = 1;
        }
        else
        {
            drv->handler_b_installed = 0;
            drv->handler_b = NULL;
            drv->data_b = NULL;
        }
        return 0;
    }
    return -1;
}


/**
 * @brief   configure timer A in 13 bit mode
 *
 * @param   drv             driver
 * @param   gated           configure timer A for gated mode (external clock source)
 * @param   counter_mode    true -> counter mode, false timer mode
 * @param   value           timer value
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_a_13bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value)
{
    if (drv != NULL && drv->open)
    {
        drv_tmr3_timer_a_stop(drv);
        drv->value_a.counter_mode = counter_mode;
        drv->value_a.gated = gated;
        drv->value_a.mode = mode_13bit;
        drv->value_a.val.val_13bit = value & 0x1fff;
        timer_a_configure(drv);
        return 0;
    }
    return -1;
}


/**
 * @brief   configure timer A in 16 bit mode
 *
 * @param   drv             driver
 * @param   gated           configure timer A for gated mode (external clock source)
 * @param   counter_mode    true -> counter mode, false -> timer mode
 * @param   value           timer value
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_a_16bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value)
{
    if (drv != NULL && drv->open)
    {
        drv_tmr3_timer_a_stop(drv);
        drv->value_a.counter_mode = counter_mode;
        drv->value_a.gated = gated;
        drv->value_a.mode = mode_16bit;
        drv->value_a.val.val_16bit = value;
        timer_a_configure(drv);
        return 0;
    }
    return -1;
}


/**
 * @brief   configure timer A in 8 bit auto reload mode
 *
 * @param   drv             driver
 * @param   gated           configure timer A for gated mode (external clock source)
 * @param   counter_mode    true -> counter mode, false -> timer mode
 * @param   value           timer value
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_a_8bit_autoreload_mode(tmr3_t *drv, bool gated, bool counter_mode, uint8_t value)
{
    if (drv != NULL && drv->open)
    {
        drv_tmr3_timer_a_stop(drv);
        drv->value_a.counter_mode = counter_mode;
        drv->value_a.gated = gated;
        drv->value_a.mode = mode_8bit_autoreload;
        drv->value_a.val.val_8bit = value;
        timer_a_configure(drv);
        return 0;
    }
    return -1;
}


/**
 * @brief   configure timer A in dual 8 bit mode (timer B is not available in this mode)
 *
 * @param   drv             driver
 * @param   gated           configure timer A for gated mode (external clock source)
 * @param   counter_mode    true -> counter mode, false -> timer mode
 * @param   val_l           timer value
 * @param   val_h           timer value
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_a_dual_8bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint8_t val_l, uint8_t val_h)
{
    if (drv != NULL && drv->open)
    {
        drv_tmr3_timer_a_stop(drv);
        drv->value_a.counter_mode = counter_mode;
        drv->value_a.gated = gated;
        drv->value_a.mode = mode_dual_8bit;
        drv->value_a.val.val_16bit = (uint16_t)val_l | (val_h << 8);
        timer_a_configure(drv);
        return 0;
    }
    return -1;
}


/**
 * @brief   configure timer B in 13 bit mode
 *
 * @param   drv             driver
 * @param   gated           configure timer B for gated mode (external clock source)
 * @param   counter_mode    true -> counter mode, false timer mode
 * @param   value           timer value
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_b_13bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value)
{
    if (drv != NULL && drv->open)
    {
        drv_tmr3_timer_b_stop(drv);
        drv->value_b.counter_mode = counter_mode;
        drv->value_b.gated = gated;
        drv->value_b.mode = mode_13bit;
        drv->value_b.val.val_13bit = value & 0x1fff;
        timer_b_configure(drv);
        return 0;
    }
    return -1;
}


/**
 * @brief   configure timer B in 16 bit mode
 *
 * @param   drv             driver
 * @param   gated           configure timer B for gated mode (external clock source)
 * @param   counter_mode    true -> counter mode, false -> timer mode
 * @param   value           timer value
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_b_16bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value)
{
    if (drv != NULL && drv->open)
    {
        drv_tmr3_timer_b_stop(drv);
        drv->value_b.counter_mode = counter_mode;
        drv->value_b.gated = gated;
        drv->value_b.mode = mode_16bit;
        drv->value_b.val.val_16bit = value;
        timer_b_configure(drv);
        return 0;
    }
    return -1;
}


/**
 * @brief   configure timer B in 8 bit auto reload mode
 *
 * @param   drv             driver
 * @param   gated           configure timer B for gated mode (external clock source)
 * @param   counter_mode    true -> counter mode, false -> timer mode
 * @param   value           timer value
 *
 * @return  0 on success, -1 in case of error
 */
int
drv_tmr3_timer_b_8bit_autoreload_mode(tmr3_t *drv, bool gated, bool counter_mode, uint8_t value)
{
    if (drv != NULL && drv->open)
    {
        drv_tmr3_timer_b_stop(drv);
        drv->value_b.counter_mode = counter_mode;
        drv->value_b.gated = gated;
        drv->value_b.mode = mode_8bit_autoreload;
        drv->value_b.val.val_8bit = value;
        timer_b_configure(drv);
        return 0;
    }
    return -1;
}

