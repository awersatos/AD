/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        AD7843 specific I/O interface.
|*
\*****************************************************************************/

#ifndef _TOUCHSCREEN_H
#define _TOUCHSCREEN_H

#ifdef  __cplusplus
extern "C" {
#endif

/** @file
 * Interface to touchscreen controller services
 */

#include <stdint.h>
#include <stdbool.h>

/**
 * @name Error codes
 */

/** @{ */

#define TOUCHSCREEN_ERR_OK           0       /**<  No error */
#define TOUCHSCREEN_ERR_INVALID      -1      /**<  Could not get valid value */
/** @} */

/**
 * @name Touchscreen Status information
 */


typedef struct touchscreen_s touchscreen_t;

typedef struct 
{
    int x;
    int y;
    bool pendown;
} touchscreen_data_t;


typedef struct
{
    int      xfs;
    int      yfs;
    int      x0_offset;
    int      xfs_offset;
    int      y0_offset;
    int      yfs_offset;
} touchscreen_calibration_t;

typedef void (*touchscreen_callback_t)(int x, int y, int x_size, int y_size, void *param);

extern touchscreen_t * touchscreen_open( unsigned int id );

extern bool touchscreen_get_pos(touchscreen_t const *srv, touchscreen_data_t *pos);
extern bool touchscreen_get_raw(touchscreen_t const *srv, touchscreen_data_t *raw);
extern bool touchscreen_calibrate(touchscreen_t *srv, int x_size, int y_size);
extern void touchscreen_set_rotation(touchscreen_t *srv, int rotation);
extern void touchscreen_set_callback(touchscreen_t * srv, touchscreen_callback_t callback, void *param);
extern const touchscreen_calibration_t *touchscreen_get_calibration_data_pointer(touchscreen_t const * srv);
extern void touchscreen_get_calibration_data(touchscreen_t const * srv, touchscreen_calibration_t * calibration_data);
extern void touchscreen_set_calibration_data(touchscreen_t * srv, touchscreen_calibration_t const * calibration_data);

#ifdef  __cplusplus
}
#endif

#endif /* _TOUCHSCREEN_H */
