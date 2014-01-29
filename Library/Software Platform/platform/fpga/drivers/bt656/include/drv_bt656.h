/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        BT656 driver
|*
\*****************************************************************************/

#ifndef _DRV_BT656_H
#define _DRV_BT656_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>

/**
 * @brief
 *      BT656 Color Modes
 *
 * This enumeration describes the available color modes for the BT656
 * Controller.
 */
typedef enum
{
    BT656_GREY8=1,      /**< 8bit grey scale */
    BT656_GREY16,       /**< 16bit grey scale */
    BT656_GREY32,       /**< 32bit grey scale */
    BT656_RGB8,         /**< 8bit RGB color mode */
    BT656_RGB16,        /**< 16bit RGB color mode */
    BT656_RGB32         /**< 32bit RGB color mode */
} bt656_color_mode_t;

/**
 * @brief
 *      BT656 Run Modes
 *
 * This enumeration describes the available run modes for the BT656 Controller.
 */
typedef enum
{
    BT656_DISABLE=0,    /**< Inactive controller */
    BT656_RUN,          /**< Capture frames continously */
    BT656_SINGLE,       /**< Capture single frame */
    BT656_WAITING       /**< Controller is busy, only used by bt656_get_run_mode() */
} bt656_run_mode_t;

typedef struct bt656_s bt656_t;

extern bt656_t *bt656_open( unsigned int id );

extern void bt656_set_output_line_size( bt656_t * restrict bt656, uint16_t line_size );

extern void bt656_set_input_line_size( bt656_t * restrict bt656, uint16_t line_size );

extern void bt656_set_buffer( bt656_t * restrict bt656, uint32_t *buffer, size_t size );

extern void bt656_set_color_mode( bt656_t * restrict bt656, bt656_color_mode_t color_mode );

extern void bt656_set_run_mode( bt656_t * restrict bt656, bt656_run_mode_t run_mode );

extern bt656_run_mode_t bt656_get_run_mode( bt656_t * restrict bt656 );

extern void bt656_set_scale( bt656_t * restrict bt656, uint8_t x_scale, uint8_t y_scale );

extern void bt656_set_frame_rate( bt656_t * restrict bt656, uint8_t frame_rate_scale );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_BT656_H */
