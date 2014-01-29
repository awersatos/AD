/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
\*****************************************************************************/

#ifndef _DRV_M25PX0_INTERNAL_H
#define _DRV_M25PX0_INTERNAL_H

/*
 * mutex support
 */

#if DRV_M25PX0_USE_MUTEX
# define M25PX0_MUTEX_PREPARE()             POSIX_DEV_MUTEX_PREPARE(m25px0_mutex_buffer)
# define M25PX0_MUTEX_LOCK( m25px0 )        POSIX_DEV_MUTEX_LOCK(&m25px0->mutex, m25px0_mutex_buffer)
# define M25PX0_MUTEX_UNLOCK( m25px0 )      POSIX_DEV_MUTEX_UNLOCK(&m25px0->mutex, m25px0_mutex_buffer)
#else
# define M25PX0_MUTEX_PREPARE()            
# define M25PX0_MUTEX_LOCK( m25px0 )          
# define M25PX0_MUTEX_UNLOCK( m25px0 )        
#endif

/*
 * driver data
 */

struct drv_m25px0_s
{
    spi_t * spi;                    // SPI device driver pointer
    uint8_t channel;                // Channel for this device, 0 if not shared
    uint8_t signature;              // Device signature (0x13 = M25P80)
#if DRV_M25PX0_USE_MUTEX
    pthread_mutex_t mutex;
#endif
};

#endif /* _DRV_M25PX0_INTERNAL_H */
