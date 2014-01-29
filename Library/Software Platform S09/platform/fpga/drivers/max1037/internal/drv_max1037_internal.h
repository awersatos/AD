/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
\*****************************************************************************/

#ifndef _DRV_MAX1037_INTERNAL_H
#define _DRV_MAX1037_INTERNAL_H

#include <stdint.h>
#include <stdbool.h>
#include <time.h>

#include <drv_max1037_cfg_instance.h>

/*
 * mutex support
 */

#if DRV_MAX1037_USE_MUTEX
# define MAX1037_MUTEX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(max1037_mutex_buffer)
# define MAX1037_MUTEX_LOCK( max1037 )      POSIX_DEV_MUTEX_LOCK(&max1037->mutex, max1037_mutex_buffer)
# define MAX1037_MUTEX_UNLOCK( max1037 )    POSIX_DEV_MUTEX_UNLOCK(&max1037->mutex, max1037_mutex_buffer)
#else
# define MAX1037_MUTEX_PREPARE()
# define MAX1037_MUTEX_LOCK( max1037 )
# define MAX1037_MUTEX_UNLOCK( max1037 )
#endif

/*
 * driver data
 */

struct drv_max1037_s
{
    i2cm_t * i2cm;
    uint8_t config;
    uint8_t setup;
#if DRV_MAX1037_INSTANCE_BUS_SHARING_TRUE_USED    
    bool    bus_sharing;
#endif
#if DRV_MAX1037_INSTANCE_BLOCKING_TRUE_USED
    bool    blocking;
#endif
#if DRV_MAX1037_USE_MUTEX
    pthread_mutex_t mutex;
#endif
} ;

// I2C addresses of MAX1037 device

#define SLAVE_READ_ADDR         0xC9    // Reading
#define SLAVE_WRITE_ADDR        0xC8    // Writing

inline void max1037_wait( max1037_t * restrict drv )
{
// ToDo: implement different blocking modes here
}

inline bool max1037_get_bus( max1037_t * restrict drv )
{
#if DRV_MAX1037_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( i2cm_get_bus( drv->i2cm ) == -1 )
        {
  #if DRV_MAX1037_INSTANCE_BLOCKING_TRUE_USED
            if ( !drv->blocking ) return false;
  #endif
            max1037_wait( drv );
        }
    }
#endif    
    return true;
}

inline void max1037_release_bus( max1037_t * restrict drv )
{
#if DRV_MAX1037_INSTANCE_BUS_SHARING_TRUE_USED
    i2cm_release_bus( drv->i2cm );
#endif
}

#endif /* _DRV_MAX1037_INTERNAL_H */
