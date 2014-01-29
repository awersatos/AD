/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        MP3DEC decoder interface.
|*
 *****************************************************************************/

/**
 * @file
 * Driver for WB_MP3DEC peripheral.
 */

#ifndef _DRV_MP3DEC_H
#define _DRV_MP3DEC_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct mp3dec_drv_s mp3dec_t;

extern void mp3dec_set_outputbuffer(mp3dec_t * restrict drv, uint32_t *buffer);
extern void mp3dec_set_scratchbuffer(mp3dec_t * restrict drv, uint32_t *buffer);
extern void mp3dec_set_inputdata(mp3dec_t * restrict drv, const uint32_t *data, size_t size);
extern void mp3dec_decode(mp3dec_t * restrict drv, const uint32_t *data, size_t size);
extern void mp3dec_decode_continue(mp3dec_t * restrict drv);
extern uint32_t mp3dec_get_status(mp3dec_t * restrict drv);
extern uint32_t mp3dec_get_header(mp3dec_t * restrict drv);
extern int mp3dec_get_samplerate(mp3dec_t * restrict drv);
extern int mp3dec_get_channelmode(mp3dec_t * restrict drv);
mp3dec_t *mp3dec_open(int id);


#ifdef  __cplusplus
}
#endif

#endif /* _DRV_MP3DEC_H */
