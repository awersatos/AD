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

#include <per_jpgdec.h>
#include <drv_jpgdec.h>

#include "drv_jpgdec_cfg_instance.h"

#define JPGDEC_DEFHUFFMAN   {\
        0xFF, 0xD8, 0xFF, 0xC4, 0x01, 0xA2, 0x00, 0x00, 0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,\
        0x09, 0x0A, 0x0B, 0x01, 0x00, 0x03, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00,\
        0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B,\
        0x10, 0x00, 0x02, 0x01, 0x03, 0x03, 0x02, 0x04, 0x03, 0x05, 0x05, 0x04, 0x04, 0x00, 0x00, 0x01,\
        0x7D, 0x01, 0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12, 0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61,\
        0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xA1, 0x08, 0x23, 0x42, 0xB1, 0xC1, 0x15, 0x52, 0xD1,\
        0xF0, 0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0A, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x25, 0x26, 0x27,\
        0x28, 0x29, 0x2A, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,\
        0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,\
        0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88,\
        0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6,\
        0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3, 0xC4,\
        0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xE1,\
        0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7,\
        0xF8, 0xF9, 0xFA, 0x11, 0x00, 0x02, 0x01, 0x02, 0x04, 0x04, 0x03, 0x04, 0x07, 0x05, 0x04, 0x04,\
        0x00, 0x01, 0x02, 0x77, 0x00, 0x01, 0x02, 0x03, 0x11, 0x04, 0x05, 0x21, 0x31, 0x06, 0x12, 0x41,\
        0x51, 0x07, 0x61, 0x71, 0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91, 0xA1, 0xB1, 0xC1, 0x09,\
        0x23, 0x33, 0x52, 0xF0, 0x15, 0x62, 0x72, 0xD1, 0x0A, 0x16, 0x24, 0x34, 0xE1, 0x25, 0xF1, 0x17,\
        0x18, 0x19, 0x1A, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44,\
        0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x63, 0x64,\
        0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x82, 0x83,\
        0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A,\
        0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8,\
        0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6,\
        0xD7, 0xD8, 0xD9, 0xDA, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xF2, 0xF3, 0xF4,\
        0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFF, 0xD9}

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
 * @brief Parse a default huffman table
 *
 * JPEG images donot always contain a huffman table. The core cannot parse those jpegs without
 * first feeding it a huffman table to decode these jpegs. The MJPEG standard uses this feature
 * to reduce the datarate of a stream of jpeg images. To decode such a MJPEG stream you can
 * use this function to first feed a valid default huffman table to the core. The core will then
 * use this huffman table for all subsequent images. call this function with @em data being
 * addressable by the jpeg core and able to accomodate JPGDEC_DEFHUFFMAN_SIZE. This function
 * will copy a default huffman table to this @em data and parse it to the core.
 *
 * NOTE: as the core uses DMA, it is important @em data is located in a section of memory which
 * the core can read.
 *
 * @param drv    jpgdec driver pointer
 * @param data   pointer to a databuffer addressable by the core
 *
 * @return Nothing
 */
extern void jpgdec_set_defhuffman(jpgdec_t * restrict drv, uint8_t *data)
{
    assert(drv != NULL);
    uintptr_t base = drv->baseaddress;
    uint8_t jpeg_default_huffman_table[JPGDEC_DEFHUFFMAN_SIZE] = JPGDEC_DEFHUFFMAN;

    for (int i = 0; i < JPGDEC_DEFHUFFMAN_SIZE; i++)
        data[i] = jpeg_default_huffman_table[i];

    JPGDEC_STATUS(base) = JPGDEC_STATUS_RESET;
    JPGDEC_READADDRESS(base) = (uint32_t) data;
    JPGDEC_READCOUNT(base) = JPGDEC_DEFHUFFMAN_SIZE;

    JPGDEC_STATUS(base) = JPGDEC_STATUS_START;
}

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

    return JPGDEC_STATUS(drv->baseaddress);
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
    if (drv->baseaddress == 0)
    {
        // get configuration of driver (created by plugin system)
        const drv_jpgdec_cfg_instance_t *restrict drv_cfg = &drv_jpgdec_instance_table[id];
        // get configuration peripheral below driver (created by plugin system)
        const per_jpgdec_cfg_instance_t *restrict per_cfg = &per_jpgdec_instance_table[drv_cfg->per_jpgdec];
        uintptr_t base = per_cfg->baseaddress;

        // copy all configuration needed to driver
        drv->baseaddress = base;

        // reset hardware
        JPGDEC_STATUS(base) = JPGDEC_STATUS_RESET;
        JPGDEC_START_X(base) = 0;
        JPGDEC_END_X(base) = 0;
        JPGDEC_START_Y(base) = 0;
        JPGDEC_END_Y(base) = 0;

        // disable all interrupts
        JPGDEC_INTMASK(base) = 0;

#ifdef __LITTLE_ENDIAN__
        JPGDEC_VERSION(base) = JPGDEC_VERSION_LITTLEENDIAN;
#else
        JPGDEC_VERSION(base) = 0;
#endif
    }
    return drv;
}
