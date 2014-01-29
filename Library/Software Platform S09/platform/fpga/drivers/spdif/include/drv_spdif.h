/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        SPDIF peripheral device driver interface.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver interface for WB_SPDIF peripheral.
 */

#ifndef _DRV_SPDIF_H
#define _DRV_SPDIF_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef enum
{
    SPDIF_OUTPUTMODE_STEREO,
    SPDIF_OUTPUTMODE_MONO,
    SPDIF_OUTPUTMODE_MONODUP
} spdif_output_mode_t;

typedef struct spdif_s spdif_t;

extern int spdif_write8( spdif_t * restrict drv, int8_t * buffer, int n );
extern int spdif_write16( spdif_t * restrict drv, int16_t * buffer, int n);
extern int spdif_write32( spdif_t * restrict drv, int32_t * buffer, int n );
extern int spdif_read( spdif_t * restrict drv, int32_t * buffer, int n );
extern uint32_t spdif_rx_avail(spdif_t * restrict spdif_drv);

extern void spdif_tx_start(spdif_t * restrict spdif_drv);
extern void spdif_rx_start(spdif_t * restrict spdif_drv);
extern void spdif_tx_stop(spdif_t * restrict spdif_drv);
extern void spdif_rx_stop(spdif_t * restrict spdif_drv);

extern unsigned spdif_set_samplefrequency( spdif_t * restrict drv, unsigned samplerate );

extern void spdif_set_tx_watermark(spdif_t * restrict spdif_drv, uint16_t value);
extern void spdif_set_rx_watermark(spdif_t * restrict spdif_drv, uint16_t value);

extern spdif_t * spdif_open(unsigned id);
extern void spdif_rx_reset( spdif_t * restrict drv );
extern void spdif_rx_fifo_reset( spdif_t * restrict drv );
extern void spdif_tx_reset( spdif_t * restrict drv );
extern void spdif_tx_fifo_reset( spdif_t * restrict drv );

extern void spdif_set_shift(spdif_t * restrict drv, int shift );
extern void spdif_set_outputmode( spdif_t * restrict drv, spdif_output_mode_t mode );

extern void spdif_write_status_bitstream( spdif_t * restrict drv, uint16_t * left, uint16_t * right, int size );
extern void spdif_write_user_bitstream( spdif_t * restrict drv, uint16_t * left, uint16_t * right, int size );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_SPDIF_H */

