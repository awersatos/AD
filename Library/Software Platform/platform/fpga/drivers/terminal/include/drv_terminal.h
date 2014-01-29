/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    TERMINAL serial communications device.
|*
\*****************************************************************************/

/**
 * @file
 * Driver for WB_TERMINAL peripheral.
 *
 * The driver can either use the TERMINAL core buffer, or it can use an additional, interrupt
 * controlled software buffer.
 *
 * You can configure these buffer settings independently for receive and transmit.
 *
 */

#ifndef _DRV_TERMINAL_H
#define _DRV_TERMINAL_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <io.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct terminal_drv_s terminal_t;

extern int terminal_putchar(terminal_t * restrict drv, int val);
extern int terminal_getchar(terminal_t * restrict drv);

extern size_t terminal_write(terminal_t * restrict drv, const char *buf, size_t size);
extern size_t terminal_read(terminal_t * restrict drv, char *buf, size_t size);

terminal_t *terminal_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_UART8_H */

