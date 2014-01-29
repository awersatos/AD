/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    Low level driver for the PS2_W peripheral. Generally,
|*                  application writers will use a higher level interface.
|*
\*****************************************************************************/

#ifndef _DRV_PS2_H
#define _DRV_PS2_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

typedef struct ps2_s ps2_t;

extern ps2_t *ps2_open(unsigned int id);

extern void ps2_install_interrupt_callback(ps2_t * restrict ps2_dev,
                                           void (*interrupt_callback)(ps2_t * restrict ps2_dev, void *data),
                                           void *user_data);

extern int ps2_putchar(ps2_t * restrict ps2_dev, uint8_t val);

extern int ps2_getchar(ps2_t * restrict ps2_dev);

extern int ps2_available_bytes(ps2_t * restrict ps2_dev);

extern void ps2_reset_buffer(ps2_t * restrict ps2_dev);

extern bool ps2_check_buffer_full(ps2_t * restrict ps2_dev);

extern int ps2_waitfor(ps2_t * restrict ps2_dev, uint8_t val);

extern int ps2_wait_until_not_busy(ps2_t * restrict ps2_dev);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_PS2_H */
