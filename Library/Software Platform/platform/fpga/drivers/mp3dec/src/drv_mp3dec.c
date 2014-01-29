/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*
|*  Description:    MP3DEC decoder interface.
|*
\*****************************************************************************/

#include <limits.h>
#include <assert.h>

#if __POSIX_KERNEL__ == 0
# include <pal.h>
#else
# include <pthread.h>
# include <interrupts.h>
#endif

#include <stdlib.h>

#include <util_endian.h>
#include <sysutils.h>
#include <per_mp3dec.h>
#include <drv_mp3dec.h>

#include "drv_mp3dec_cfg_instance.h"


// runtime driver properties
struct mp3dec_drv_s
{
    // workcopies from configuration
    uintptr_t baseaddress;
};

static mp3dec_t mp3dec_driver_table[DRV_MP3DEC_INSTANCE_COUNT];



/**
 * @brief Set the location for the output
 *
 * Specify the start of the memory area where the decoded MP3 will be written.
 * This must be an 32-bit-aligned array of 576 16-bit stereo samples (2304 byte).
 *
 * NOTE: as the core uses DMA, it is important the buffer is located in a section
 * of memory which the core can write using its memory bus.
 *
 * @param  drv         mp3dec driver pointer
 * @param  buffer      pointer to 32-bit aligned output buffer size 576 words
 *
 * @return Nothing
 */
extern void mp3dec_set_outputbuffer(mp3dec_t * restrict drv, uint32_t *buffer)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    MP3DEC_WRITEADDRESS(base) = (uint32_t) buffer;
    MP3DEC_STATUS(base) = MP3DEC_STATUS_WRITEREADY;
}



/**
 * @brief Set the location for the scratch area
 *
 * Specify the start of the memory area which the MP3DEC core will use
 * as scratch area. This must be an 32-bit-aligned array of 6528 32-bit words (26112 byte).
 *
 * NOTE: as the core uses DMA, it is important the buffer is located in a section
 * of memory which the core can access using its scratch-memory bus.
 *
 * @param  drv         mp3dec driver pointer
 * @param  buffer      pointer to 32-bit aligned scratch buffer size 6528 words
 *
 * @return Nothing
 */
extern void mp3dec_set_scratchbuffer(mp3dec_t * restrict drv, uint32_t *buffer)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    MP3DEC_SCRATCHADDRESS(base) = (uint32_t) buffer;
}



/**
 * @brief Set up input buffer
 *
 * Set up the input buffer for mp3 decoding. This is normally used for adding additional data
 * to an active decoding which has halted because it ran out of data. To start a new mp3 'file'
 * use mp3dec_decode() instead. The buffer must be 32-bit aligned, it's size however is specified in bytes.
 *
 * NOTE: as the core uses DMA, it is important the buffer is located in a section
 * of memory which the core can access using its memory bus.
 *
 * @param  drv   mp3dec driver pointer
 * @param  data  pointer to input buffer
 * @param  size  size of input buffer in bytes
 *
 * @return Nothing
 */
extern void mp3dec_set_inputdata(mp3dec_t * restrict drv, const uint32_t *data, size_t size)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    MP3DEC_READADDRESS(base) = (uint32_t) data;
    MP3DEC_READENDADDRESS(base) = (uint32_t) ((uintptr_t) data + size + 3);

    MP3DEC_STATUS(base) = MP3DEC_STATUS_READEMPTY;
}


/**
 * @brief Start decoding MP3 data
 *
 * Decode mp3 data to buffer (as set up with mp3dec_set_buffer). This function is non-blocking, the status register
 * must be monitored to detect when a decoded frame is ready (MP3DEC_STATUS_FRAMEREADY is set). After processing this data
 * mp3dec_decode_continue() must be called. If the decoder needs more data, the MP3DEC_STATUS_READEMPTY flag will be set.
 * If so you can add more data using mp3dec_set_inputdata(), decoding will then continue.
 *
 * NOTE: as the core uses DMA, it is important the data is located in a section of memory which the core can
 * access using its memory bus.
 *
 * @param drv    mp3dec driver pointer
 * @param data   pointer to MP3 data to decode
 * @param size   size of MP3 data to decode
 * @param shift  number of pixels to leftshift the output
 *
 * @return Nothing
 */
extern void mp3dec_decode(mp3dec_t * restrict drv, const uint32_t *data, size_t size)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    MP3DEC_STATUS(base) = MP3DEC_STATUS_RESET;

    // headerready bit gets not reset with core softreset
    MP3DEC_STATUS(drv->baseaddress) = MP3DEC_STATUS_HEADERREADY;

    MP3DEC_READADDRESS(base) = (uint32_t) data;
    MP3DEC_READENDADDRESS(base) = (uint32_t) ((uintptr_t) data + size + 3);

    MP3DEC_STATUS(base) = MP3DEC_STATUS_START;
}


/**
 * @brief Continue halted decoding
 *
 * Continue decoding after it halted at the end of a decoded frame.
 * See mp3dec_decode() for more information.
 *
 * @param  drv    mp3dec driver pointer
 *
 * @return Nothing
 */
extern void mp3dec_decode_continue(mp3dec_t * restrict drv)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    MP3DEC_STATUS(base) = MP3DEC_STATUS_WRITEREADY;
}


/**
 * @brief Get MP3DEC core status
 *
 * Get the status of the MP3DEC decoder. See MP3DEC_STATUS_<bitname> definitions.
 *
 * @param  drv   mp3dec driver pointer
 *
 * @return MP3DEC decoder status
 */
extern uint32_t mp3dec_get_status(mp3dec_t * restrict drv)
{
    assert(drv != NULL);

    return MP3DEC_STATUS(drv->baseaddress);
}


/**
 * @brief Get header of MP3
 *
 * Get the last valid MP3 header word, resets the MP3DEC_STATUS_HEADERREADY flag in the statusregister
 *
 * @param  drv   mp3dec driver pointer
 *
 * @return 32-bit Header word
 */
extern uint32_t mp3dec_get_header(mp3dec_t * restrict drv)
{
    assert(drv != NULL);
    uint32_t header;

    header = MP3DEC_HEADER(drv->baseaddress);

    MP3DEC_STATUS(drv->baseaddress) = MP3DEC_STATUS_HEADERREADY;

    return header;
}


/**
 * @brief Get samplerate of MP3
 *
 * Get the samplerate from the last valid MP3 header word
 *
 * @param  drv   mp3dec driver pointer
 *
 * @return samplerate
 */
extern int mp3dec_get_samplerate(mp3dec_t * restrict drv)
{
    uint32_t header;
    uint32_t samplerate_index;
    const int samplerates[] = { 44100, 48000, 32000, 0 };

    assert(drv != NULL);

    header = MP3DEC_HEADER(drv->baseaddress);
    samplerate_index = (header >> 10) & 0x00000003;

    return samplerates[samplerate_index];
}


/**
 * @brief Get channel mode of MP3
 *
 * Get the channelmode from the last valid MP3 header word
 *
 * @param  drv   mp3dec driver pointer
 *
 * @return channelmode (1=mono, 2=stereo, 3=dual)
 */
extern int mp3dec_get_channelmode(mp3dec_t * restrict drv)
{
    uint32_t header;
    uint32_t channelmode_index;
    const int channelmodes[] = { 2, 2, 3, 1 };

    assert(drv != NULL);

    header = MP3DEC_HEADER(drv->baseaddress);
    channelmode_index = (header >> 6) & 0x00000003;

    return channelmodes[channelmode_index];
}


/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a MP3DEC core and its driver. On consequetive calls this just returns a
 * pointer to the driver.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer if succesful, NULL otherwise
 */
mp3dec_t *mp3dec_open(int id)
{
    assert((id >= 0) && (id < DRV_MP3DEC_INSTANCE_COUNT));

    mp3dec_t *restrict drv = &mp3dec_driver_table[id];
    // get configuration of driver (created by plugin system)
    drv_mp3dec_cfg_instance_t const * restrict drv_cfg = &drv_mp3dec_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    per_mp3dec_cfg_instance_t const * restrict per_cfg = &per_mp3dec_instance_table[drv_cfg->per_mp3dec];
    uintptr_t base = per_cfg->baseaddress;

    if (drv->baseaddress) return drv;

    // copy all configuration needed to driver
    drv->baseaddress = base;

#ifdef __LITTLE_ENDIAN__
    MP3DEC_VERSION(base) = MP3DEC_VERSION_LITTLEENDIAN;
#else
    MP3DEC_VERSION(base) = 0;
#endif

    // reset hardware
    MP3DEC_STATUS(base) = MP3DEC_STATUS_RESET;

    // optionally locate the scratchbuffer in CPU memory
    MP3DEC_SCRATCHADDRESS(base) = (uint32_t) ((drv_cfg->scratchtype == DRV_MP3DEC_SCRATCHTYPE_SHARED) ? drv_cfg->scratchbuffer : 0);

    // disable all interrupts
    MP3DEC_INTMASK(base) = 0;

    return drv;
}

