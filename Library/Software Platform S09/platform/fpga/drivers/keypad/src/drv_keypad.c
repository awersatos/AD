/**
 * @file
 *
 * @brief
 *      driver for NB1 keypad peripheral, no buffering is done so key input is
 *      lost when not reading
 */

#include <assert.h>
#include "drv_keypad_cfg_instance.h"
#include "drv_keypad_cfg.h"
#include "drv_keypad.h"
#include "per_keypad_cfg_instance.h"
#include "per_keypad.h"
#include "timing.h"
#include <stdbool.h>
#include <string.h>
#include <time.h>

struct _drv_keypad_t {
    bool            enable_repeat;
    unsigned int    initial_repeat_delay;
    unsigned int    repeat_interval;
    unsigned char   *asciilookup;
    uint64_t        last_key_down_tick;
    unsigned char   last_key;
    unsigned int    no_repeats_yet;
    per_keypad_cfg_instance_t *per_keypad;
#if __POSIX_KERNEL__
    int wait_mode;
#endif
};

static unsigned char default_lookup[16] = {
    '1', '2', '3', 'C',
    '4', '5', '6', 'D',
    '7', '8', '9', 'E',
    'A', '0', 'B', 'F'
};

static struct _drv_keypad_t keypads[DRV_KEYPAD_INSTANCE_COUNT];

/* 3 cycles of 244Hz 0.0122 sec, rounded up to 15 ms */
#define KEYPAD_DEBOUNCE 15


inline void threadwait_ms(drv_keypad_t * restrict drv, int ms)
{
    uint64_t waitfor = clock_ms() + ms;

    while (clock_ms() < waitfor)
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
}




/**
 * @brief   open the keypad driver fot the keypad device identied by id
 *
 * @param   id  keypad device to open
 *
 * @return  the opened keypad driver, or NULL when there is no such device
 */
drv_keypad_t *
keypad_open(int id)
{
    drv_keypad_t *ret = NULL;

    if (id >= 0 && id < DRV_KEYPAD_INSTANCE_COUNT)
    {
        ret = &keypads[id];
        memset(ret, 0, sizeof(*ret));
        ret->enable_repeat = drv_keypad_instance_table[id].autoreapeat;
        ret->initial_repeat_delay = drv_keypad_instance_table[id].initial_autoreapeat_delay_ms;
        ret->repeat_interval = drv_keypad_instance_table[id].autoreapeat_delay_ms;
        ret->last_key = 0xff;
        ret->per_keypad = &per_keypad_instance_table[drv_keypad_instance_table[id].per_keypad];
        ret->asciilookup = default_lookup;
        assert(ret->per_keypad->baseaddress != 0);
        keypad_reset(ret);
    }
    return ret;
}


/**
 * @brief   returns the current acsii lookup table
 *
 * @param   drv     keypad driver
 *
 * @return  returns the current ascii lookup table, this is a 16 bytes table
 */
unsigned char *
keypad_get_ascii_lookup_table(drv_keypad_t *drv)
{
    return drv->asciilookup;
}


/**
 * @brief   set the acsii lookup table
 *
 *          Set the acsii lookup table, this should be an array of 16 characters
 *          one cahracter for each key on the keypad.
 *
 * @param   drv     keypad driver
 * @param   table   array with 16 characters for the key to char mapping
 *
 * @return  none
 */
void
keypad_set_ascii_lookup_table(drv_keypad_t *drv, unsigned char *table)
{
    drv->asciilookup = table;
}


/**
 * @brief   return auto reapeat setting of the driver
 *
 * @param   drv     keypad driver
 *
 * @return  true if autorepaeat is on, false if autorepeat is off
 */
bool
keypad_get_enable_repeat(drv_keypad_t *drv)
{
    return drv->enable_repeat;
}


/**
 * @brief   turn autorepeat mode on or off
 *
 * @param   drv     keypad driver
 * @param   enable  set auto repeat mode on or off
 *
 * @return  none
 */
void
keypad_set_enable_repeat(drv_keypad_t *drv, bool enable)
{
    drv->enable_repeat = enable;
}


/**
 * @brief   get the initial delay value for autorepeat
 *
 * @param   drv     keypad driver
 *
 * @return  returns the initial autorepeat interval (in milli seconds)
 */
unsigned int
keypad_get_initial_repeat_delay_ms(drv_keypad_t *drv)
{
    return drv->initial_repeat_delay;
}


/**
 * @brief   set the initial delay value for autorepeat
 *
 * @param   drv     keypad driver
 * @param   ms      initial autorepeat interval in milli seconds
 *
 * @return  none
 */
void
keypad_set_initial_repeat_delay_ms(drv_keypad_t *drv, unsigned int ms)
{
    drv->initial_repeat_delay = ms;
}


/**
 * @brief   get the autorepeat interval
 *
 * @param   drv     keypad driver
 *
 * @return  autorepeat interval in milli seconds
 */
unsigned int
keypad_get_repeat_delay_ms(drv_keypad_t *drv)
{
    return drv->repeat_interval;
}


/**
 * @brief   set the autorepeat interval
 *
 * @param   drv     keypad driver
 * @param   ms      autorepeat interval in milli seconds
 *
 * @return  none
 */
void
keypad_set_repeat_delay_ms(drv_keypad_t *drv, unsigned int ms)
{
    drv->repeat_interval = ms;
}


/**
 * @brief   reset the keypad hardware
 *
 * @param   drv     keypad driver
 *
 * @return  none
 */
void
keypad_reset(drv_keypad_t *drv)
{
    KEYPAD_KEYREG(drv->per_keypad->baseaddress) = 0;
}


/**
 * @brief   get the current pressed key
 *
 * @param   drv     keypad driver
 *
 * @return  number of the currently pressed key, note that 0 is also returned
 *          when no key is pressed
 */
unsigned char
keypad_get_current_key(drv_keypad_t *drv)
{
    unsigned char lastkey = 0;

    if (keypad_is_key_down(drv))
    {
        lastkey = KEYPAD_KEYREG(drv->per_keypad->baseaddress);
        keypad_reset(drv);
    }

    return(lastkey);
}


/**
 * @brief   check if a key is pressed
 *
 * @param   drv     keypad driver
 *
 * @return  0 no key pressed, 1 a key pressed
 */
int
keypad_is_key_down(drv_keypad_t *drv)
{
    return KEYPAD_VALKEYREG(drv->per_keypad->baseaddress);
}


/**
 * @brief   wait for the next key to be pressed/repeated
 *
 * @param   drv     keypad driver
 *
 * @return  id of the key pressed
 */
unsigned char
keypad_get_next_key(drv_keypad_t *drv)
{
    unsigned char   next_key  = 0;
    uint64_t        this_mark = 0;

    while (1)
    {
        threadwait_ms(drv, KEYPAD_DEBOUNCE);

        if (keypad_is_key_down(drv))
        {
            next_key  = keypad_get_current_key(drv);
            this_mark = clock_ms();
            if (drv->last_key == 0xFF)
            {
                drv->no_repeats_yet = 1;
                break;
            }
            else if (!drv->enable_repeat)
            {
            }
            else if (drv->no_repeats_yet &&
                     (elapsed_time_ms(drv->last_key_down_tick) > drv->initial_repeat_delay))
            {
                drv->no_repeats_yet = 0;
                break;
            }
            else if (!drv->no_repeats_yet &&
                     (elapsed_time_ms(drv->last_key_down_tick) > drv->repeat_interval))
            {
                break;
            }
        }
        else
        {
            drv->last_key = 0xFF;
        }
    }
    drv->last_key           = next_key;
    drv->last_key_down_tick = this_mark;
    return drv->last_key;
}


/**
 * @brief   read key input form the keypad
 *
 *          Read key input form the keypad, key numbers are converted to ascii
 *          using the current lookup table
 *
 * @param   drv     keypad driver
 * @param   buf     caracter array to store key characters in
 * @param   size    number of characters or read
 *
 * @return  1
 */
int
keypad_read(drv_keypad_t *drv, char *buf, size_t size)
{
    while (size > 0)
    {
        *buf++ = drv->asciilookup[keypad_get_next_key(drv) & 0x0F];
        size --;
    }
    return 1;
}

