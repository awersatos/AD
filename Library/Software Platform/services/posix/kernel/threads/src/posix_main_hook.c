/******************************************************************************
 * FILE:    @(#)posix_main_hook.c       1.2 07/03/13
 * DESCRIPTION:
 *      posix main hook routine
 *****************************************************************************/
#include <limits.h>

#if ( __POSIX_FILE_SYSTEM != 0 )
#include "file.h"
#endif

void posix_main_hook ( void )
{

#if ( __POSIX_FILE_SYSTEM != 0 )

        /* put in memory the virtual device file system */
        extern fs_t     dev_fs;
        extern mnt_t    dev_mnt;

        fs_install ( &dev_fs );
        mnt_install ( &dev_mnt );

#if (__POSIX_SHARED_MEMORY_OBJECTS != 0)
        /* put in memory the virtual shm file system */
        extern fs_t     shm_fs;
        extern mnt_t    shm_mnt;

        fs_install ( &shm_fs );
        mnt_install ( &shm_mnt );
#endif

        /* mount other file systems */
        mnt_init ( );

#endif

        return;

 }


