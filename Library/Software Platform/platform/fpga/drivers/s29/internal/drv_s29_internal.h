/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
\*****************************************************************************/

#ifndef _DRV_S29_INTERNAL_H
#define _DRV_S29_INTERNAL_H

/*
 * mutex support
 */

#if ( DRV_S29_USE_MUTEX != 0 )
# define S29_MUTEX_PREPARE()            POSIX_DEV_MUTEX_PREPARE(s29_mutex_buffer)
# define S29_MUTEX_LOCK( s29 )          POSIX_DEV_MUTEX_LOCK(&s29->mutex, s29_mutex_buffer)
# define S29_MUTEX_UNLOCK( s29 )        POSIX_DEV_MUTEX_UNLOCK(&s29->mutex, s29_mutex_buffer)
#else
# define S29_MUTEX_PREPARE()            do {} while (0)
# define S29_MUTEX_LOCK( s29 )          do {} while (0)
# define S29_MUTEX_UNLOCK( s29 )        do {} while (0)
#endif

/*
 * driver data
 */

struct s29_s
{
    uintptr_t baseaddr;
    uint16_t pagecount;
    size_t pagesize;
    size_t chipsize;
    size_t bufsize;
    uint32_t sector_erase_timeout;
    uint32_t chip_erase_timeout;
    uint32_t word_write_timeout;
    uint32_t buf_write_timeout;
#if __POSIX_KERNEL__
    int wait_mode;
# if DRV_S29_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
# endif
#endif
#if ( DRV_S29_USE_MUTEX != 0 )
    pthread_mutex_t mutex;
#endif
};

#endif /* _DRV_S29_INTERNAL_H */
