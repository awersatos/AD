/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    S29 driver (non-posix interface).
|*
\*****************************************************************************/

#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>

#include <sysutils.h>
#include <pal.h>
#include <per_s29.h>
#include <drv_s29.h>

#include "drv_s29_internal.h"  // definition of struct s29_s

#include "drv_s29_cfg_instance.h"

static s29_t s29_table[DRV_S29_INSTANCE_COUNT];

/*
 * Local interface
 */

inline void threadwait(s29_t * restrict drv)
{
#if __POSIX_KERNEL__
#if DRV_S29_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_S29_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
#endif
#if DRV_S29_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_S29_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
#endif
#if DRV_S29_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_S29_WAIT_MODE_SLEEP)
    {
        struct timespec ts = { 0, drv->wait_sleepms * 1000 * 1000 };

        nanosleep (&ts, NULL);
    }
    else
#endif
    { /* never reached */ }
#else
    // without RTOS
    __nop();
#endif
}



/******************************************************************************
* FUNCTION: s29_device_init
*
* Fill device structure describing partition on a memory blockdevice
*
* s29           device structure to contain with s29 flash block device description
*
* returns       0 for success, <>0 if any error
*/
int s29_device_init( s29_t * restrict  s29, uint32_t baseaddr )
{
    volatile uint16_t *flash = ( void * ) baseaddr;
    volatile uint16_t *flashptr;
    size_t size;
    uint16_t blocks;
    size_t blksize;
    uint16_t regions;
    uint16_t pagecount;
    uint32_t bufsize;

    s29->baseaddr = baseaddr;

    // Switch device to CFI mode
    flash[FLASH_ADDR_CFI] = FLASH_CMD_CFI;

    s29->chipsize = 1 << ( flash[FLASH_ADDR_CFI_DEVSIZE] & 0xFF );
    regions = flash[FLASH_ADDR_CFI_EBR] & 0xFF;

    pagecount = 0;
    size = 0;
    blksize = 0;
    flashptr = flash + FLASH_ADDR_CFI_EBRI;

    // Go through the list of erase block regions and get the individual sizes
    for ( int index = 0; index < regions; index++ )
    {
        blocks = ( flashptr[0] | ( flashptr[1] << 8 ) ) + 1;
        blksize = ( size_t ) 256 *( flashptr[2] | ( flashptr[3] << 8 ) );
        size += blksize * blocks;
        flashptr += 4;
        pagecount += blocks;
    }

    if ( size != s29->chipsize )
    {
        // Oops, sum of all erase blocks != chipsize; there must be an error!
        return -1;
    }
    else
    {
        // Fill rest of s29 info
        bufsize = flash[FLASH_ADDR_CFI_BUFSIZE_H];
        bufsize = ( bufsize << 16 ) | flash[FLASH_ADDR_CFI_BUFSIZE_L];
        s29->bufsize = 1 << bufsize;
        s29->pagecount = pagecount;
        s29->pagesize = blksize;
        s29->sector_erase_timeout =
            ( 1 << flash[FLASH_ADDR_CFI_SECTERA_TO] ) * ( 1 << flash[FLASH_ADDR_CFI_SECTERA_MUL] );
        if ( flash[FLASH_ADDR_CFI_CHIPERA_TO] == 0 )
        {
            s29->chip_erase_timeout = s29->sector_erase_timeout * pagecount;
        }
        else
        {
            s29->chip_erase_timeout =
                ( 1 << flash[FLASH_ADDR_CFI_CHIPERA_TO] ) * ( 1 << flash[FLASH_ADDR_CFI_CHIPERA_MUL] );
        }

        s29->word_write_timeout =
            ( 1 << flash[FLASH_ADDR_CFI_WRWORD_TO] ) * ( 1 << flash[FLASH_ADDR_CFI_WRWORD_MUL] );

        if ( flash[FLASH_ADDR_CFI_WRBUF_TO] == 0 )
        {
            s29->buf_write_timeout = s29->word_write_timeout * s29->bufsize;
        }
        else
        {
            s29->buf_write_timeout =
                ( 1 << flash[FLASH_ADDR_CFI_WRBUF_TO] ) * ( 1 << flash[FLASH_ADDR_CFI_WRBUF_MUL] );
        }

    }
    flash[0] = FLASH_CMD_RESET;

    return 0;
}

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize the S29 paralel flash device
 *
 * This function initializes the S29 paralel flash device.
 *
 * @param id
 *      Driver id (defined in devices.h)
 *
 * @return
 *      The s29 driver pointer for the specified device, or NULL on error.
 */
extern s29_t *s29_open( int id )
{
    s29_t * s29;
    drv_s29_cfg_instance_t * cfg;
    uintptr_t baseaddress;
#if ( DRV_S29_USE_MUTEX != 0 )
    pthread_mutexattr_t mutexattr;
#endif

    assert( id >= 0 && id < DRV_S29_INSTANCE_COUNT );
    s29 = &s29_table[id];

    if ( s29->init )
    {
        return s29;
    }

    cfg = &drv_s29_instance_table[id];
	assert(per_s29_instance_table[cfg->per_s29].baseaddress != 0);
    baseaddress = per_s29_instance_table[cfg->per_s29].baseaddress;

#if ( DRV_S29_USE_MUTEX != 0 )
    pthread_mutexattr_init( &mutexattr );
    pthread_mutex_init( &s29->mutex, &mutexattr );
#endif

    S29_MUTEX_PREPARE();
    S29_MUTEX_LOCK( s29 );
    if ( s29_device_init( s29, baseaddress ) == 0 )
    {
        s29->init = true;
    }
    S29_MUTEX_UNLOCK( s29 );

    return s29->init ? s29 : NULL;
}

/**
 * @brief
 *      Erase one sector on the flash device
 *
 *  This function erases a single sector on the S29 flash device.
 *
 *  @param s29
 *      s29 driver pointer
 *  @param offset
 *      Byte offset of sector to erase
 *
 * @return
 *      0 if succesful, -1 otherwise.
 */
extern int s29_erase_sector( s29_t * restrict  s29, size_t offset )
{
    volatile uint16_t *flash = ( void * ) s29->baseaddr;
    uint64_t timeout;
    bool success = false;

    offset /= 2;                // Convert bytes to words

    S29_MUTEX_PREPARE();
    S29_MUTEX_LOCK( s29 );

    flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_PRE1;
    flash[FLASH_ADDR_UNLOCK2] = FLASH_CMD_PRE2;
    flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_ERA1;

    flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_PRE1;
    flash[FLASH_ADDR_UNLOCK2] = FLASH_CMD_PRE2;
    flash[offset] = FLASH_CMD_ERA3;

    timeout = pal_clock() + s29->sector_erase_timeout * ( pal_freq_hz() / 1000 );
    while ( pal_clock() < timeout )
    {
        if ( ( ( flash[0] ^ flash[0] ) & FLASH_DQ6 ) == 0 )    // Check if DQ6 still toggles
        {
            success = true;
            break;
        }
        threadwait(s29);
    }

    S29_MUTEX_UNLOCK( s29 );

    return success ? 0 : -1;
}

/**
 * @brief
 *      Erase all sectors of the flash device
 *
 * This function erases the entire S29 flash device.
 *
 * @param s29
 *      s29 driver pointer
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int s29_erase( s29_t * restrict  s29 )
{
    volatile uint16_t *flash = ( void * ) s29->baseaddr;
    uint64_t timeout;
    bool success = false;

    S29_MUTEX_PREPARE();
    S29_MUTEX_LOCK( s29 );

    // Send command sequence for erasing
    flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_PRE1;
    flash[FLASH_ADDR_UNLOCK2] = FLASH_CMD_PRE2;
    flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_ERA1;

    flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_PRE1;
    flash[FLASH_ADDR_UNLOCK2] = FLASH_CMD_PRE2;
    flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_ERA2;

    // Wait for erase to finish
    timeout = pal_clock() + s29->chip_erase_timeout * ( pal_freq_hz() / 1000 );
    while ( pal_clock() < timeout )
    {
        if ( ( ( flash[0] ^ flash[0] ) & FLASH_DQ6 ) == 0 )    // Check if DQ6 still toggles
        {
            success = true;
            break;
        }
        threadwait(s29);
    }

    S29_MUTEX_UNLOCK( s29 );

    return success ? 0 : -1;
}

/**
 * @brief
 *      Program the flash device
 *
 * This function writes @em bytes number of bytes to the the S29 flash device,
 * starting at byte offset @em offset. The @em memptr address must be 16-bit
 * aligned.
 *
 * @param s29
 *      s29 driver pointer
 * @param offset
 *      Offset in flash to start writing
 * @param memptr
 *      Start address of data
 * @param bytes
 *      Number of bytes to write
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int s29_program( s29_t * restrict  s29, size_t offset, void *memptr, size_t bytes )
{
    volatile uint16_t *flash = ( void * ) s29->baseaddr;
    volatile uint16_t *mem = memptr;
    size_t words = bytes / 2 + ( bytes & 1 );
    size_t index;
    bool success = false;
    uint64_t timeout;

    offset /= 2;                // Convert bytes to words

    S29_MUTEX_PREPARE();
    S29_MUTEX_LOCK( s29 );

    for ( index = 0; index < words; index++ )
    {
        // Send command and data to program
        flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_PRE1;
        flash[FLASH_ADDR_UNLOCK2] = FLASH_CMD_PRE2;
        flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_PRG;
        flash[( index + offset ) << FLASH_SHIFT_ADDR_LINES] = *mem++;

        // Wait for program cycle to finish
        success = false;
        timeout = pal_clock() + s29->word_write_timeout * ( pal_freq_hz() / 1000000 );
        while ( pal_clock() < timeout )
        {
            if ( ( ( flash[0] ^ flash[0] ) & FLASH_DQ6 ) == 0 )
            {
                success = true;
                break;
            }
            threadwait(s29);
        }

        if ( !success )
        {
            break;
        }
    }

    S29_MUTEX_UNLOCK( s29 );

    return success ? 0 : -1;
}

/**
 * @brief
 *      Program the flash device using block programming
 *
 * This function writes @em bytes number of bytes to the the S29 flash device,
 * starting at byte offset @em offset. The @em memptr address must be 16-bit
 * aligned. The difference between this functions and
 * <code>s29_program()</code> is the method of programming. Block programming
 * is more efficient for a large amount of data.
 *
 * @param s29
 *      s29 driver pointer
 * @param offset
 *      Offset in flash to start writing
 * @param memptr
 *      Start address of data
 * @param bytes
 *      Number of bytes to write
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
/**********************************************************************
|*
|*  FUNCTION    : s29_program_block
|*
|*  PARAMETERS  : s29 = pointer to s29 context
|*                offset = offset in flash to start writing
|*                memptr = pointer to data to be written
|*                bytes = number of bytes to be written
|*
|*  RETURNS     : 0 when OK, <>0 when failed
|*
|*  DESCRIPTION : Program the flash using block programming
 */
extern int s29_program_block( s29_t * restrict  s29, size_t offset, void *memptr, size_t bytes )
{
    volatile uint16_t *flash = ( void * ) s29->baseaddr;
    volatile uint16_t *mem = memptr;
    size_t words = ( bytes / 2 ) + ( bytes % 2 );
    size_t num_words = words;
    size_t index;
    uint32_t bufsize = s29->bufsize / 2;    // Buffer size in words!
    bool success = false;
    uint64_t timeout;

    offset /= 2;                // Convert bytes to words

    S29_MUTEX_PREPARE();
    S29_MUTEX_LOCK( s29 );

    for ( index = 0; index < words; index += bufsize, num_words -= bufsize )
    {
        size_t n = ( num_words > bufsize ) ? bufsize : num_words;

        flash[FLASH_ADDR_UNLOCK1] = FLASH_CMD_PRE1;
        flash[FLASH_ADDR_UNLOCK2] = FLASH_CMD_PRE2;
        flash[( index + offset ) << FLASH_SHIFT_ADDR_LINES] = FLASH_CMD_WBL;
        flash[offset] = n - 1;
        flash[( index + offset ) << FLASH_SHIFT_ADDR_LINES] = *mem++;
        for ( int j = 1; j < n; j++ )
        {
            flash[( index + j + offset ) << FLASH_SHIFT_ADDR_LINES] = *mem++;
        }
        flash[offset] = FLASH_CMD_PBF;

        // Wait for program cycle to finish
        success = false;
        timeout = pal_clock() + s29->buf_write_timeout * ( pal_freq_hz() / 1000000 );
        while ( pal_clock() < timeout )
        {
            if ( ( ( flash[0] ^ flash[0] ) & FLASH_DQ6 ) == 0 )
            {
                success = true;
                break;
            }
            threadwait(s29);
        }

        if ( !success )
        {
            break;
        }
    }

    S29_MUTEX_UNLOCK( s29 );

    return success ? 0 : -1;
}
