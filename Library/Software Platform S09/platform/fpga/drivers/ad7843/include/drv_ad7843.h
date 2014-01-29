/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        AD7843 specific I/O interface.
|*
\*****************************************************************************/

#ifndef _DRV_AD7843_H
#define _DRV_AD7843_H

#ifdef  __cplusplus
extern "C" {
#endif

/** @file
 * Interface to SPI based AD7843 touchscreen controller device driver
 */

#include <stdint.h>
#include <stdbool.h>

/**
 * @name Error codes
 */

/** @{ */

#define AD7843_ERR_OK           0       /**<  No error */
#define AD7843_ERR_SPI          -1      /**<  Could not get control over SPI bus */
/** @} */

/**
 * @name AD7843 Status information
 */


typedef struct drv_ad7843_s ad7843_t;

 /**
 * @brief
 *      Raw data structure
 *
 * This structure describes the raw data from the AD7843.
 */

typedef struct 
{
    int x;          /**< x value */
    int y;          /**< y value */
    bool pendown;   /**< pen down */
} ad7843_raw_t;

extern ad7843_t * ad7843_open( unsigned int id );

extern int ad7843_get_raw( ad7843_t *drv, ad7843_raw_t *raw );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_AD7843_H */
