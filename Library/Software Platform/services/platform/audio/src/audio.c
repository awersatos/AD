/*****************************************************************************\
|*
|*  IN PACKAGE:         AUDIO Driver
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        AUDIO Driver Interface
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include <timing.h>
#include <audio.h>
#include <drv_i2s.h>
#include <drv_cs4270.h>

#include "audio_cfg_instance.h"

/*
 * driver data
 */

typedef void (*i2s_write_t) (i2s_t * restrict, void *, unsigned int);
typedef void (*i2s_read_t) (i2s_t * restrict, void *, unsigned int );

struct ctxt_audio_s
{
    i2s_t       * i2s;                  // I2S device driver pointer
    i2s_write_t i2s_write;              // Pointer to write function
    i2s_read_t  i2s_read;               // Pointer to read function
    cs4270_t    * cs4270;               // CS4270 device driver pointer
    unsigned    samplefreq;             // Sample frequency (in samples/sec)
    uint8_t     channels;               // Number of channels (1 or 2)
    uint8_t     samplesize;             // Number of bytes in a single sample (8, 16, 20 or 24)

#if AUDIO_USE_MUTEX
    pthread_mutex_t mutex;
#endif
};


// table of driver contexts
static audio_t context_table[AUDIO_INSTANCE_COUNT];

/**
 * @brief    Open a context of the audio service
 *
 * The first time the function is called, it initializes I2S and CS4270 device drivers.
 * Further attemps to open an already successfully opened context simply return the same pointer.
 *
 * @param  id  valid context id
 *
 * @return context pointer if succesful initialized, NULL otherwise
 */

audio_t *audio_open(const unsigned id)
{
    // Copy configuration data to driver table
    audio_t * restrict context = &context_table[id];
    const audio_cfg_instance_t * restrict context_cfg = &audio_instance_table[id];

    // If opened before, just return the pointer
    if ( context->cs4270 && context->i2s ) return context;
    
    while ( context->cs4270 = cs4270_open( context_cfg->drv_cs4270 ), !context->cs4270 )
    {
        __nop();
    }

    if( context->i2s = i2s_open( context_cfg->drv_i2s ), !context->i2s )
    {
        return NULL;
    }

    // Initialize the hardware:

    // Stop data streaming to/from CS4270 anymore please
    i2s_tx_stop( context->i2s );
    i2s_rx_stop( context->i2s );

    // Freeze CS4270 until we're done
    cs4270_write( context->cs4270, CS4270_REG_POWER_CONTROL, CS4270_FREEZE );

    // Slave mode
    cs4270_write( context->cs4270, CS4270_REG_FUNCTION_MODE, CS4270_MODE_SLAVE_MODE|CS4270_MODE_MCLK_DIV_1);

    // I2S communication
    cs4270_write( context->cs4270, CS4270_REG_SERIAL_AUDIO_FORMAT, CS4270_FORMAT_ADC_DIF|CS4270_FORMAT_DAC_DIF_FORMAT_I2S_NORMAL_24_BIT );

    // Soft on
    cs4270_write( context->cs4270, CS4270_REG_TRANSITION_CONTROL, CS4270_TRAN_SOFT_ON_CROSS_ON );

    // Automatic mute
    cs4270_write( context->cs4270, CS4270_REG_MUTE_CONTROL, 0 );

    // Volume at 0 dB
    cs4270_write( context->cs4270, CS4270_REG_VOL_CONTROL_AOUTA, 0x00 );
    cs4270_write( context->cs4270, CS4270_REG_VOL_CONTROL_AOUTB, 0x00 );

    // Unfreeze
    cs4270_write( context->cs4270, CS4270_REG_POWER_CONTROL, 0x00 );

    // Set our I2S device
    audio_set_format( context, context_cfg->def_samplefreq, context_cfg->def_channels, context_cfg->def_samplesize );
    i2s_set_wjust( context->i2s, I2S_WJUST_I2S );

    // And we're done!
    return context;
}

/**
 * @brief    Set audio format
 *
 * Set the audio format on the hardware as well as the driver
 *
 * @param  context  pointer to audio context
 * @param  samplefreq Sample frequency to be set, in Hz
 * @param  channels Number of channels (1 for mono, 2 for stero)
 * @param  samplesize Size of a single channel's sample, in bits (8, 16, 24 or 32)
 *
 * @return 0 on success, failure otherwise
 */

int audio_set_format( audio_t * restrict context, unsigned int samplefreq, int channels, int samplesize )
{
    assert( context != NULL );
    assert( (samplefreq > 0) && (samplefreq <= 96000) );
    assert( (channels == 1) || (channels == 2) );
    assert( (samplesize == 8) || (samplesize == 16) || (samplesize == 20) || (samplesize == 24) );

    i2s_tx_stop( context->i2s );
    i2s_rx_stop( context->i2s );

    i2s_calculate_and_set_prescaler( context->i2s, samplefreq, freq_hz() );
    i2s_set_output_mode( context->i2s, (channels == 1) ? I2S_MONO_OUTPUT : I2S_STEREO_OUTPUT );
    i2s_set_input_mode( context->i2s, (channels == 1) ? I2S_MONO_INPUT_LEFT : I2S_STEREO_INPUT );
    i2s_set_wwidth( context->i2s, (samplesize == 8) ? 16 : samplesize );

    context->samplefreq = samplefreq;
    context->channels = (uint8_t)channels;
    context->samplesize = (uint8_t)samplesize;

    switch( samplesize )
    {
    case 8 :
        context->i2s_write = (i2s_write_t)i2s_write8;
        context->i2s_read = (i2s_read_t)i2s_read8;
        break;
    case 16:
        context->i2s_write = (i2s_write_t)i2s_write16;
        context->i2s_read = (i2s_read_t)i2s_read16;
        break;
    default:
        context->i2s_write = (i2s_write_t)i2s_write32;
        context->i2s_read = (i2s_read_t)i2s_read32;
        break;
    }
    i2s_tx_start( context->i2s );
    return 0;
}

/**
 * @brief    Sets the volume of the audio
 *
 * @param  context  pointer to audio context
 * @param  volume volume to set, 0 is softest, 255 is max
 *
 * @return 0 on success, failure otherwise
 */

int audio_set_volume( audio_t * restrict context, unsigned short volume )
{
    return cs4270_set_volume( context->cs4270, 255 - volume, eChannel_Stereo );
}

/**
 * @brief   Play sample
 *
 * This functions starts playing data from memory
 *
 * @param   context Pointer to context as returned by audio_open
 * @param   buf     Pointer to audio to be played
 * @param   buflen  Number of samples in the buffer to be played
 *
 * @return  number of samples written, < 0 : error
 */

int audio_play( audio_t * restrict context, void * buf, unsigned int buflen )
{
    unsigned int samples = i2s_tx_avail( context->i2s );
    if ( samples > buflen ) samples = buflen;
    context->i2s_write( context->i2s, buf, samples );
    return samples;
}

/**
 * @brief   Record sample
 *
 * This functions records audio data in memory
 *
 * @param   context Pointer to context as returned by audio_open
 * @param   buf     Pointer to audio to be recorded
 * @param   buflen  Maximum number of samples in the buffer to be recorded
 *
 * @return  number of samples read, < 0 : error
 */

int audio_record( audio_t * restrict context, void * buf, unsigned int buflen )
{
    unsigned int samples = i2s_rx_avail( context->i2s );
    i2s_rx_start( context->i2s );
    if ( samples > buflen ) samples = buflen;
    context->i2s_read( context->i2s, buf, samples );
    return samples;
}
/**
 * @brief   Stop playing
 *
 * This functions stops audio play
 *
 * @param   context   Pointer to context as returned by audio_open
 *
 * @return  0 on success, failure otherwise
 */

int audio_stop_playing( audio_t * restrict context )
{
//    i2s_tx_stop( context->i2s );
    return 0;
}

/**
 * @brief   Stop recording
 *
 * This functions stops audio record
 *
 * @param   context   Pointer to context as returned by audio_open
 *
 * @return  0 on success, failure otherwise
 */

int audio_stop_recording( audio_t * restrict context )
{
    i2s_rx_stop( context->i2s );
    return 0;
}

/**
 * @brief Get samplefrequency
 *
 * This function returns the current samplefrequency used
 *
 * @param drv   Pointer to context as returned by audio_open
 *
 * @return Samplefrequency, in Hz
 */
 
int audio_get_samplefreq( audio_t * restrict drv )
{
    return drv->samplefreq;
}

/**
 * @brief Get number of channels
 *
 * This function returns the current number of channels in use
 *
 * @param drv   Pointer to context as returned by audio_open
 *
 * @return Number of channels
 */
 
int audio_get_channels( audio_t * restrict drv )
{
    return drv->channels;
}

/**
 * @brief Get samplesize
 *
 * This function returns the current samplesize, in bits per channel
 *
 * @param drv   Pointer to context as returned by audio_open
 *
 * @return Samplesize
 */

int audio_get_samplesize( audio_t * restrict drv )
{
    return drv->samplesize;
}

