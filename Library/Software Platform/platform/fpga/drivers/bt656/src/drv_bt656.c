/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        BT656 driver
|*
\*****************************************************************************/

/**
 * @file drv_bt656.h
 *
 * @brief
 *      BT656 Video Capture Controller
 *
 * This driver provides access to a BT656 video capture controller.
 *
 * For a detailed description of the BT656 peripheral, see the Core Reference
 * <a href="CR0159 BT656 Video Capture Controller.PDF">BT656 Video Capture Controller</a>.
 */

#include <stdint.h>
#include <stdbool.h>
#include <assert.h>
#include <per_bt656.h>
#include <drv_bt656.h>

#include "drv_bt656_cfg_instance.h"

#ifndef CLAMP
#define CLAMP( val, min, max )  ( ( (val) < (min) ) ? (min) : ( (val) > (max) ) ? (max) : (val) )
#endif

/*
 * mutex support
 */

#if ( DRV_BT656_USE_MUTEX != 0 )
# define BT656_MUTEX_PREPARE()          POSIX_DEV_MUTEX_PREPARE(bt656_mutex_buffer)
# define BT656_MUTEX_LOCK( bt656 )      POSIX_DEV_MUTEX_LOCK(&bt656->mutex, bt656_mutex_buffer)
# define BT656_MUTEX_UNLOCK( bt656 )    POSIX_DEV_MUTEX_UNLOCK(&bt656->mutex, bt656_mutex_buffer)
#else
# define BT656_MUTEX_PREPARE()          do {} while (0)
# define BT656_MUTEX_LOCK( bt656 )      do {} while (0)
# define BT656_MUTEX_UNLOCK( bt656 )    do {} while (0)
#endif

struct bt656_s
{
    uintptr_t   baseaddress;
    uint16_t    line_size;
    uint16_t    input_line_size;
    uint8_t     color_mode;
    uint8_t     x_zoom;
    uint8_t     y_zoom;
    uint8_t     frame_skip;
    uint8_t     line_interrupt;
    uint8_t     frame_interrupt;
#if ( DRV_BT656_USE_MUTEX != 0 )
    pthread_mutex_t mutex;
#endif
};

static bt656_t bt656_table[DRV_BT656_INSTANCE_COUNT];

//..............................................................................
// Local interface

// bt656_bpp() returns the bytes (!) per pixel in the actual color mode
static const uint32_t bt656_bpp_color_depth[] = { 0, 1, 2, 4, 1, 2, 4 };
#define bt656_bpp( color_mode ) bt656_bpp_color_depth[color_mode]


//..............................................................................
// Public interface

/**
 * @brief
 *      Initialize BT656 controller
 *
 * This function initializes the BT656 controller. Initially the controller is 
 * disabled.  Make sure to add an output buffer before changing the 
 * controller's run mode (see bt656_set_buffer()).
 *
 * @param id
 *      Device id (defined in devices.h)
 *
 * @return
 *      A bt656 driver pointer if successful, or NULL on error.
 */
extern bt656_t *bt656_open( unsigned int id )
{
    bt656_t * restrict bt656;
    const drv_bt656_cfg_instance_t *cfg;
    const per_bt656_cfg_instance_t *per_cfg;
#if ( DRV_BT656_USE_MUTEX != 0 )
    pthread_mutexattr_t mutexattr;
#endif
    
    assert( id < DRV_BT656_INSTANCE_COUNT );
    bt656 = &bt656_table[id];
    
    if ( bt656->baseaddress == 0 )
    {
        cfg = &drv_bt656_instance_table[id];
        per_cfg = &per_bt656_instance_table[cfg->per_bt656];

        assert( per_cfg->baseaddress != 0 );
        bt656->baseaddress = per_cfg->baseaddress;
        bt656->line_interrupt = per_cfg->line_interrupt;
        bt656->frame_interrupt = per_cfg->frame_interrupt;

        bt656->color_mode = (uint8_t)cfg->color_mode+1;
        bt656->line_size = cfg->line_size;
        bt656->input_line_size = cfg->input_line_size;
        
#if ( DRV_BT656_USE_MUTEX != 0 )
        pthread_mutexattr_init( &mutexattr );
        pthread_mutex_init( &bt656->mutex, &mutexattr );
#endif

        BT656_MUTEX_PREPARE();
        BT656_MUTEX_LOCK( bt656 );

        // initialize BT656 controller device:
        // - controller is initialy disabled
        // - no zooming or frame skipping
#ifdef __LITTLE_ENDIAN__
        BT656_MODE_REG( bt656->baseaddress ) = ( (uint32_t)bt656->color_mode << 2 ) | BT656_MODE_LITTLEENDIAN;
#else
        BT656_MODE_REG( bt656->baseaddress ) = ( (uint32_t)bt656->color_mode << 2 );
#endif
        BT656_SCALE_REG( bt656->baseaddress ) = 0x00;
        BT656_BPL_REG( bt656->baseaddress ) = bt656->line_size * bt656_bpp( bt656->color_mode );
        BT656_VBPL_REG( bt656->baseaddress ) = bt656->input_line_size * bt656_bpp( bt656->color_mode );

        BT656_MUTEX_UNLOCK( bt656 );
    }
    return bt656;
}

/**
 * @brief
 *      Set line size of the output device
 *
 * This function sets the line size in pixels for the output device. If the
 * width of the output device is not the same as the width of the incoming video
 * there must be a gap to ensure that each line of the video is displayed 
 * underneath the previous line.
 *
 * @param bt656
 *      bt656 driver pointer
 * @param line_size
 *      Line size of the output device in pixels
 *
 * @return
 *      Nothing.
 */
extern void bt656_set_output_line_size( bt656_t * restrict bt656, uint16_t line_size )
{
    bt656->line_size = line_size;

    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    BT656_BPL_REG( bt656->baseaddress ) = (uint32_t)line_size * bt656_bpp( bt656->color_mode );

    BT656_MUTEX_UNLOCK();
}

/**
 * @brief
 *      Set line size of the video input
 *
 * This function sets the line size in pixels for the video input. This value is
 * used by the driver to determine the number of bytes per line written to the
 * video buffer when the video is scaled (see bt656_set_scale()).
 *
 * @param bt656
 *      bt656 driver pointer
 * @param line_size
 *      Line size of the video input in pixels
 *
 * @return
 *      Nothing.
 *
 * @see
 *      bt656_set_scale()
 */
extern void bt656_set_input_line_size( bt656_t * restrict bt656, uint16_t line_size )
{
    bt656->input_line_size = line_size;

    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    BT656_VBPL_REG( bt656->baseaddress ) = bt656->input_line_size * bt656_bpp( bt656->color_mode ) / ( bt656->x_zoom + 1 );

    BT656_MUTEX_UNLOCK( bt656 );
}

/**
 * @brief
 *      Set video output buffer
 *
 * This function changes the location for the video output.  Each captured video frame
 * will be written to @em buffer, up to a maximum of @em size bytes.
 *
 * @param bt656
 *      bt656 driver pointer
 * @param buffer
 *      Video output buffer
 * @param size
 *      Size of video output buffer
 *
 * @return
 *      Nothing.
 */
extern void bt656_set_buffer( bt656_t * restrict bt656, uint32_t *buffer, size_t size )
{
    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    BT656_START_REG( bt656->baseaddress ) = ( uint32_t ) buffer;
    BT656_SIZE_REG( bt656->baseaddress ) = size;

    BT656_MUTEX_UNLOCK( bt656 );
}

/**
 * @brief
 *      Set video color mode
 *
 * This function sets the color mode for incoming and outgoing video data.
 *
 * @param bt656
 *      bt656 driver pointer
 * @param color_mode
 *      Video color mode
 *
 * @return
 *      Nothing.
 */
extern void bt656_set_color_mode( bt656_t * restrict bt656, bt656_color_mode_t color_mode )
{
    bt656->color_mode = (uint8_t)color_mode;
    
    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    BT656_MODE_REG( bt656->baseaddress ) = ( BT656_MODE_REG( bt656->baseaddress ) & ~BT656_MODE_CM ) | ( (uint32_t)bt656->color_mode << 2 );
    BT656_BPL_REG( bt656->baseaddress ) = bt656->line_size * bt656_bpp( bt656->color_mode );
    BT656_VBPL_REG( bt656->baseaddress ) = bt656->input_line_size * bt656_bpp( bt656->color_mode ) / ( bt656->x_zoom + 1 );

    BT656_MUTEX_UNLOCK( bt656 );
}

/**
 * @brief
 *      Set video capture mode of the BT656 controller
 *
 * This function is used to disable video capture, capture a single video
 * frame, or start capturing video frames continuously.
 *
 * @param bt656
 *      bt656 driver pointer
 * @param run_mode
 *      Video capture mode
 *
 * @return
 *      Nothing.
 */
extern void bt656_set_run_mode( bt656_t * restrict bt656, bt656_run_mode_t run_mode )
{
    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    BT656_MODE_REG( bt656->baseaddress ) = ( BT656_MODE_REG( bt656->baseaddress ) & ~(BT656_MODE_RUN | BT656_MODE_SFC) ) | ((uint32_t) run_mode);

    BT656_MUTEX_UNLOCK( bt656 );
}

/**
 * @brief
 *      Get the current state of the BT656 controller
 *
 * This function reads the status of the BT656 controller and returns the
 * current video capture mode or @em BT656_WAITING if the controller is
 * busy.
 *
 * @param bt656
 *      bt656 driver pointer
 *
 * @return
 *      Current run mode of the BT656 controller.
 */
extern bt656_run_mode_t bt656_get_run_mode( bt656_t * restrict bt656 )
{
    bt656_run_mode_t mode = BT656_RUN;
    
    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    switch ( BT656_STATUS_REG( bt656->baseaddress ) & 0x03 )
    {
        case 0 :
            if ( BT656_MODE_REG( bt656->baseaddress ) & (BT656_MODE_RUN | BT656_MODE_SFC) )
            {
                mode = BT656_WAITING;
            }
            else
            {
                mode = BT656_DISABLE;
            }
            break;
        case 1 :
            mode = BT656_RUN;
            break;
        case 2 :
            mode = BT656_SINGLE;
            break;
        default :
            mode = BT656_RUN;
            break;
    }

    BT656_MUTEX_UNLOCK( bt656 );

    return mode;
}

/**
 * @brief
 *      Set scale factors
 *
 * This function changes the scaling factors applied to the captured video,
 * before sending it to the video output buffer. The @em x_scale and @em y_scale
 * factors determine the size of the video output relative to the video input, a
 * value of 1 means no scaling, a value of 2 means half of the size (width or
 * height), and so on. Scale factors must be between 1 and 16.
 *
 * @param bt656
 *      bt656 driver pointer
 * @param x_scale
 *      Scale factor for video width
 * @param y_scale
 *      Scale factor for video height
 *
 * @return
 *      Nothing.
 */
extern void bt656_set_scale( bt656_t * restrict bt656, uint8_t x_scale, uint8_t y_scale )
{
    bt656->x_zoom = CLAMP( x_scale, 1, 16 ) - 1;
    bt656->y_zoom = CLAMP( y_scale, 1, 16 ) - 1;

    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    BT656_SCALE_REG( bt656->baseaddress ) = 
        ( (uint32_t)bt656->frame_skip << 8 ) | ( (uint32_t)bt656->y_zoom << 4 ) | bt656->x_zoom;
    BT656_VBPL_REG( bt656->baseaddress ) = bt656->input_line_size * bt656_bpp( bt656->color_mode ) / ( bt656->x_zoom + 1 );

    BT656_MUTEX_UNLOCK( bt656 );
}

/**
 * @brief
 *      Set output frame rate
 *
 * This function reduces the frame rate of the video output relative to the
 * captured video framerate. An @em frame_rate value of 1 means no scaling, a
 * value of 2 means half the frame rate, a value of 3 means 1/3 of the frame
 * rate and so on. The frame rate scale factors must be between 1 and 16.
 *
 * @param bt656
 *      bt656 driver pointer
 * @param frame_rate_scale
 *      Scale factor for video frame rate
 *
 * @return
 *      Nothing.
 */
extern void bt656_set_frame_rate( bt656_t * restrict bt656, uint8_t frame_rate_scale )
{
    bt656->frame_skip = CLAMP( frame_rate_scale, 1, 16 ) - 1;

    BT656_MUTEX_PREPARE();
    BT656_MUTEX_LOCK( bt656 );

    BT656_SCALE_REG( bt656->baseaddress ) = 
        ( (uint32_t)bt656->frame_skip << 8 ) | ( (uint32_t)bt656->y_zoom << 4 ) | bt656->x_zoom;

    BT656_MUTEX_UNLOCK( bt656 );
}
