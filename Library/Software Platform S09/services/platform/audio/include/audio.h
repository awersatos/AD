/*****************************************************************************\
|*
|*  IN PACKAGE:         AUDIO
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        AUDIO interface
 */

/**
 * @file
 * This is the Generic Audio interface
 *
 */


#ifndef _AUDIO_H_
#define _AUDIO_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

typedef struct ctxt_audio_s audio_t;

extern audio_t *audio_open(const unsigned id);
extern int audio_set_format( audio_t * restrict drv, unsigned int samplefreq, int channels, int samplesize );
extern int audio_get_samplefreq( audio_t * restrict drv );
extern int audio_get_channels( audio_t * restrict drv );
extern int audio_get_samplesize( audio_t * restrict drv );
extern int audio_set_volume( audio_t * restrict drv, unsigned short volume );
extern int audio_play( audio_t * restrict drv, void * buf, unsigned int buflen );
extern int audio_record( audio_t * restrict drv, void * buf, unsigned int buflen );
extern int audio_stop_playing( audio_t * restrict drv );
extern int audio_stop_recording( audio_t * restrict drv );

#ifdef  __cplusplus
}
#endif

#endif /* _AUDIO_H_ */
