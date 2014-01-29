/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
\*****************************************************************************/

#ifndef _DRV_MAX5841_INTERNAL_H
#define _DRV_MAX5841_INTERNAL_H

#include <stdint.h>
#include <stdbool.h>
#include <time.h>

#include <drv_max5841_cfg_instance.h>

/*
 * mutex support
 */

#if DRV_MAX5841_USE_MUTEX
# define MAX5841_MUTEX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(max5841_mutex_buffer)
# define MAX5841_MUTEX_LOCK( max5841 )      POSIX_DEV_MUTEX_LOCK(&max5841->mutex, max5841_mutex_buffer)
# define MAX5841_MUTEX_UNLOCK( max5841 )    POSIX_DEV_MUTEX_UNLOCK(&max5841->mutex, max5841_mutex_buffer)
#else
# define MAX5841_MUTEX_PREPARE()
# define MAX5841_MUTEX_LOCK( max5841 )
# define MAX5841_MUTEX_UNLOCK( max5841 )
#endif

/*
 * driver data
 */

struct drv_max5841_s
{
    i2cm_t      * i2cm;
    uint8_t     i2c_addr;
    uint8_t     pd;
#if DRV_MAX5841_INSTANCE_BUS_SHARING_TRUE_USED    
    bool    bus_sharing;
#endif
#if DRV_MAX5841_INSTANCE_BLOCKING_TRUE_USED
    bool    blocking;
#endif
#if DRV_MAX5841_USE_MUTEX
    pthread_mutex_t mutex;
#endif
} ;

inline void max5841_wait( max5841_t * restrict drv )
{
// ToDo: implement different blocking modes here
}

inline bool max5841_get_bus( max5841_t * restrict drv )
{
#if DRV_MAX5841_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( i2cm_get_bus( drv->i2cm ) == -1 )
        {
  #if DRV_MAX5841_INSTANCE_BLOCKING_TRUE_USED
            if ( !drv->blocking ) return false;
  #endif
            max5841_wait( drv );
        }
    }
#endif    
    return true;
}

inline void max5841_release_bus( max5841_t * restrict drv )
{
#if DRV_MAX5841_INSTANCE_BUS_SHARING_TRUE_USED
    i2cm_release_bus( drv->i2cm );
#endif
}

#endif /* _DRV_MAX5841_INTERNAL_H */
