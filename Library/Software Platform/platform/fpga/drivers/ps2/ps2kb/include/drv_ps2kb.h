/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    Low level PS/2 keyboard driver
|*
\*****************************************************************************/

#ifndef _DRV_PS2KB_H
#define _DRV_PS2KB_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

#define PS2KB_OK            0           /**< driver status: no problems found */
#define PS2KB_RESET_FAILED  (1 << 0)    /**< driver status: keyboard reset failed */

typedef struct ps2kb_s ps2kb_t;

extern ps2kb_t *ps2kb_open(unsigned int id);

extern int ps2kb_reset(ps2kb_t * restrict ps2kb);

extern int ps2kb_get_drvstat(ps2kb_t * restrict ps2kb);

extern int ps2kb_setleds(ps2kb_t * restrict ps2kb, uint8_t leds);

extern const uint8_t *ps2kb_get_scancode(ps2kb_t * restrict ps2kb);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_PS2KB_H */
