/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*
|*  Description:    Non-blockio interface for JPG storage devices.
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
#include <errno.h>

#include <util_endian.h>
#include <sysutils.h>
#include <per_jpgdec.h>
#include <drv_jpgdec.h>

#include "drv_jpgdec_cfg_instance.h"


// runtime driver properties
struct jpgdec_drv_s
{
    int blocking_mode;
    uint32_t pollmscs;

    // workcopies from configuration
    uintptr_t baseaddress;
};

static jpgdec_t jpgdec_driver_table[DRV_JPGDEC_INSTANCE_COUNT];



/**
 * @brief Set the location for the output
 *
 * Specify the memory area where the decodec JPEG will be written.
 * If a @em line_width is given, the decoder will begin each decoded line at @em line_width intervals,
 * truncating a decoded line if necessary. If @em line_width = 0 all lines will be decoded back to back in the buffer.
 * If the decoder needs to write outside the given area, JPGDEC_STATUS_READEMPTY flag in the status register will be set.
 *
 * NOTE: as the core uses DMA, it is important the buffer is located in a section of memory which the core can write.
 *
 * @param  drv         jpgdec driver pointer
 * @param  buffer      pointer to 32-bit aligned output buffer
 * @param  size        size of output buffer in bytes, must be multiple of 4
 * @param  line_width  width of an output line in pixels
 *
 * @return Nothing
 */
extern void jpgdec_set_outputbuffer(jpgdec_t * restrict drv, uintptr_t buffer, size_t size, size_t line_width)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    JPGDEC_WRITESTARTADDRESS(base) = (uint32_t) buffer;
    JPGDEC_WRITEENDADDRESS(base) = (uint32_t) buffer + size;
    JPGDEC_WRITEWIDTH(base) = (uint32_t) line_width;
}


/**
 * @brief Set up input buffer
 *
 * Set up the input buffer for jpg decoding. This is normally used for adding additional data
 * to an active decoding which has halted because it ran out of data. For decoding a new image
 * use jpgdec_decode() instead.
 *
 * @param  drv   jpgdec driver pointer
 * @param  data  pointer to input buffer
 * @param  size  size of input buffer in bytes
 *
 * @return Nothing
 */
extern void jpgdec_set_inputdata(jpgdec_t * restrict drv, const uint8_t *data, size_t size)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    JPGDEC_READADDRESS(base) = (uint32_t) data;
    JPGDEC_READCOUNT(base) = (uint32_t) size;
}


/**
 * @brief Set area to decode
 *
 * Limit the area to decode. By default this is the entire JPGDEC buffer.
 * The @em start_x/@em start_y pixel will end up at the write_start_address as
 * specified with jpgdec_set_output().
 *
 * @param  drv      jpgdec driver pointer
 * @param  start_x  begin column of area to decode, must be multiple of 2
 * @param  start_y  begin line of area to decode
 * @param  end_x    right column of area to decode, must be multiple of 2, 0 means no limit
 * @param  end_y    bottom line of area to decode, 0 means no limit
 *
 * @return Nothing
 */
extern void jpgdec_set_area(jpgdec_t * restrict drv, size_t start_x, size_t start_y, size_t end_x, size_t end_y)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    JPGDEC_START_X(base) = (uint32_t) start_x;
    JPGDEC_START_Y(base) = start_y;

    JPGDEC_END_X(base) = end_x;
    JPGDEC_END_Y(base) = end_y;
}


/**
 * @brief Decode a JPEG image
 *
 * Decode jpg image to buffer (as set up with jpgdec_set_buffer). This function is non-blocking, the status register
 * will be 0 while the decoder is busy.
 * If the decoder needs more data, the JPGDEC_STATUS_READEMPTY flag in the status register will be set.
 * If so you can add more data using jpgdec_set_inputdata(), and continue decoding with jpgdec_decode_continue().
 * If the decoder wants to write outside the outbutbuffer, the JPGDEC_STATUS_WRITEFULL flag in the status register will be set.
 * If so you can optionally change the output buffer using jpgdec_set_outputbuffer() and continue decoding with jpgdec_decode_continue().
 * optionally using a new shift value.
 *
 * NOTE: as the core uses DMA, it is important the data is located in a section of memory which the core can read.
 *
 * @param drv    jpgdec driver pointer
 * @param data   pointer to JPG data to decode
 * @param size   size of JPG data to decode
 * @param shift  number of pixels to leftshift the output
 *
 * @return Nothing
 */
extern void jpgdec_decode(jpgdec_t * restrict drv, const uint8_t *data, size_t size, size_t shift)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    JPGDEC_STATUS(base) = JPGDEC_STATUS_RESET;

    JPGDEC_READADDRESS(base) = (uint32_t) data;
    JPGDEC_READCOUNT(base) = size;

    JPGDEC_WRITEOFFSET(base) = shift * sizeof(uint16_t);

    JPGDEC_STATUS(base) = JPGDEC_STATUS_START;
}


/**
 * @brief Continue halted decoding
 *
 * Continue decoding after it was halted by running out of data of trying to write outside the outputbuffer.
 * See jpgdec_decode() for more information.
 *
 * @param  drv    jpgdec driver pointer
 * @param  shift  number of pixels to leftshift the output
 *
 * @return Nothing
 */
extern void jpgdec_decode_continue(jpgdec_t * restrict drv, size_t shift)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;

    JPGDEC_WRITEOFFSET(base) = shift * sizeof(uint16_t);

    JPGDEC_STATUS(base) = JPGDEC_STATUS_WRITEFULL | JPGDEC_STATUS_READEMPTY;
}





/**
 * @brief Get JPGDEC core status
 *
 * Get the status of the JPGDEC decoder. See JPGDEC_STATUS_<bitname> definitions.
 *
 * @param  drv   jpgdec driver pointer
 *
 * @return JPGDEC decoder status
 */
extern uint32_t jpgdec_get_status(jpgdec_t * restrict drv)
{
    assert(drv != NULL);

    return big32(JPGDEC_STATUS(drv->baseaddress));
}


/**
 * @brief Get height of JPG
 *
 * Get the height of the last decoded JPG header.
 *
 * @param  drv   jpgdec driver pointer
 *
 * @return Height.
 */
extern uint32_t jpgdec_get_size_x(jpgdec_t * restrict drv)
{
    assert(drv != NULL);

    return JPGDEC_SIZE_X(drv->baseaddress);
}


/**
 * @brief Get width of JPG
 *
 * Get the width of the last decoded JPG header.
 *
 * @param  drv   jpgdec driver pointer
 *
 * @return Width.
 */
extern uint32_t jpgdec_get_size_y(jpgdec_t * restrict drv)
{
    assert(drv != NULL);

    return JPGDEC_SIZE_Y(drv->baseaddress);
}


/**
 * @brief Get address decoder wants to write
 *
 * Get the address where the decoder wanted to write a pixel. This is only useful when the decoder has halted
 * because it wanted to write outside the specified outputbuffer.
 *
 * @param  drv   jpgdec driver pointer
 *
 * @return Address where decoder wanted to write
 */
extern uintptr_t jpgdec_get_writeaddress(jpgdec_t * restrict drv)
{
    assert(drv != NULL);

    return JPGDEC_WRITEADDRESS(drv->baseaddress);
}


/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a JPGDEC core and its driver.
 * You should call it only once per id.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise
 */
jpgdec_t *jpgdec_open(int id)
{
    assert((id >= 0) && (id < DRV_JPGDEC_INSTANCE_COUNT));

    jpgdec_t *restrict drv = &jpgdec_driver_table[id];
    // get configuration of driver (created by plugin system)
    drv_jpgdec_cfg_instance_t *restrict drv_cfg = &drv_jpgdec_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    per_jpgdec_cfg_instance_t *restrict per_cfg = &per_jpgdec_instance_table[drv_cfg->per_jpgdec];
    uintptr_t base = per_cfg->baseaddress;

    // copy all configuration needed to driver
    drv->baseaddress = base;

    // reset hardware
    JPGDEC_STATUS(base) = big32(JPGDEC_STATUS_RESET);
    JPGDEC_START_X(base) = 0;
    JPGDEC_END_X(base) = 0;
    JPGDEC_START_Y(base) = 0;
    JPGDEC_END_Y(base) = 0;

    // disable all interrupts
    JPGDEC_INTMASK(base) = 0;

    return drv;
}
