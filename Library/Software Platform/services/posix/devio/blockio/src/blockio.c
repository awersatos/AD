/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008 Altium
|*
|*  Description:    Generic interface for block devices.
|*
\*****************************************************************************/
#include <limits.h>

#include <blockio.h>

/**
 * @brief
 *      Write a number of sectors to the block device
 *
 * This function writes @em size sectors of data from @buf starting at
 * sector @em lba.
 *
 * @param fd
 *      File descriptor
 * @param buf
 *      Pointer to data source
 * @param lba
 *      Sector to start writing
 * @param size
 *      Number of sectors to write
 *
 * @return
 *      Number of sectors written, or -1 on failure.
 */
extern ssize_t bwrite( int fd, const void *buf, uint32_t lba, size_t size )
{
    posix_devctl_blockio_impl_t impl;

    if ( posix_devctl( fd, DEVCTL_BLOCKIO_IMPL, ( void * ) &impl, sizeof( impl ), NULL ) < 0 )
    {
        return BLOCKIO_ERROR_IO;
    }
    if ( buf == NULL )
    {
        return BLOCKIO_ERROR_IO;
    }

    return impl.write_sectors( impl.device, buf, lba, size );
}

/**
 * @brief
 *      Clear a number of sectors on the block device
 *
 * This function writes zeros to @em size sectors of the block device starting
 * at sector @em lba.
 *
 * @param fd
 *      File descriptor
 * @param lba
 *      Sector to start writing
 * @param size
 *      Number of sectors to clear
 *
 * @return
 *      Number of sectors cleared, or -1 on failure.
 */
extern ssize_t bclear( int fd, uint32_t lba, size_t size )
{
    posix_devctl_blockio_impl_t impl;

    if ( posix_devctl( fd, DEVCTL_BLOCKIO_IMPL, ( void * ) &impl, sizeof( impl ), NULL ) < 0 )
    {
        return BLOCKIO_ERROR_IO;
    }

    return impl.clear_sectors( impl.device, lba, size );
}

/**
 * @brief
 *      Read a number of sectors from the block device
 *
 * This function reads @em size sectors of data starting at sector @em lba.
 * Buffer @em buf must be large enough to hold the requested number of sectors.
 *
 * @param fd
 *      File descriptor
 * @param buf
 *      Pointer to data destination
 * @param lba
 *      Sector to start reading
 * @param size
 *      Number of sectors to read.
 *
 * @return
 *      Number of sectors read, or -1 on failure.
 */
extern ssize_t bread( int fd, void *buf, uint32_t lba, size_t size )
{
    posix_devctl_blockio_impl_t impl;

    if ( posix_devctl( fd, DEVCTL_BLOCKIO_IMPL, ( void * ) &impl, sizeof( impl ), NULL ) < 0 )
    {
        return BLOCKIO_ERROR_IO;
    }

    return impl.read_sectors( impl.device, buf, lba, size );
}

/**
 * @brief
 *      Flush cached data to disk
 *
 * This function makes sure all cached data is written to disk. The
 * @em invalidate argument determines if the cache is invalidated.
 *
 * @param fd
 *      File descriptor
 * @param invalidate
 *      False to keep cached data valid, true to invalidate the cached data
 *
 * @return
 *      0 if successful, or -1 otherwise.
 */
extern int bflush( int fd, bool invalidate )
{
    posix_devctl_blockio_impl_t impl;

    if ( posix_devctl( fd, DEVCTL_BLOCKIO_IMPL, ( void * ) &impl, sizeof( impl ), NULL ) < 0 )
    {
        return BLOCKIO_ERROR_IO;
    }

    return impl.flush_data( impl.device, invalidate ? 1 : 0 );
}

