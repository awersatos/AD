/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        JPGDEC decoder interface.
|*
 *****************************************************************************/

/**
 * @file
 * Driver for WB_JPGDEC peripheral.
 *
 * For a detailed description of the WB_JPGDEC peripheral, see the Core Reference
 * <a href="CR0174 - WB_JPGDEC JPEG decoder.PDF">CR0174 - WB_JPGDEC JPEG decoder</a>
 */

#ifndef _DRV_JPGDEC_H
#define _DRV_JPGDEC_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#ifndef _PER_JPGDEC_H

/* Status flags from jpgdec.h, also used for interrupt mask: */
#define JPGDEC_STATUS_READY                0x0001
#define JPGDEC_STATUS_READEMPTY            0x0002
#define JPGDEC_STATUS_WRITEFULL            0x0004
#define JPGDEC_STATUS_ERROR                0x0008
#define JPGDEC_STATUS_ERROR_NOTAJPG        0x0010
#define JPGDEC_STATUS_ERROR_CORRUPT        0x0020
#define JPGDEC_STATUS_ERROR_UNSUPPORTED    0x0040
#define JPGDEC_STATUS_START                0x0080
#define JPGDEC_STATUS_RESET                0x0100

#endif

#define JPGDEC_DEFHUFFMAN_SIZE             424

typedef struct jpgdec_drv_s jpgdec_t;

extern void jpgdec_set_defhuffman(jpgdec_t * restrict drv, uint8_t *data);
extern void jpgdec_set_outputbuffer(jpgdec_t * restrict drv, uintptr_t buffer, size_t size, size_t line_width);
extern void jpgdec_set_inputdata(jpgdec_t * restrict drv, const uint8_t *data, size_t size);
extern void jpgdec_set_area(jpgdec_t * restrict drv, size_t start_x, size_t start_y, size_t end_x, size_t end_y);
extern void jpgdec_decode(jpgdec_t * restrict drv, const uint8_t *data, size_t size, size_t shift);
extern void jpgdec_decode_continue(jpgdec_t * restrict drv, size_t shift);
extern uint32_t jpgdec_get_status(jpgdec_t * restrict drv);
extern uint32_t jpgdec_get_size_x(jpgdec_t * restrict drv);
extern uint32_t jpgdec_get_size_y(jpgdec_t * restrict drv);
extern uintptr_t jpgdec_get_writeaddress(jpgdec_t * restrict drv);
jpgdec_t *jpgdec_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_JPGDEC_H */
