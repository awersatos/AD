/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Definition of generic interfaces for blockio drivers.
|*                      Non POSIX standard.
|*
\*****************************************************************************/

#ifndef _POSIX_BLOCKIO_H
#define _POSIX_BLOCKIO_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include <devctl.h>
#include <sys\types.h>

// blockio error codes
#define BLOCKIO_ERROR_IO                        -1 /**< Unspecified I/O error */
#define BLOCKIO_ERROR_FDISK_DISKFULL            -2 /**< Partition table does not match the device size */
#define BLOCKIO_ERROR_WRONG_MBR_SIGNATURE       -3 /**< Master boot record contains incorrect signature */
#define BLOCKIO_ERROR_BLOCKSIZE_UNSUPPORTED     -4 /**< Unsupported sector size */
#define BLOCKIO_ERROR_NOMEM                     -5 /**< Allocation of temporally memory area for operation failed */

// copied from fs_fat.h for convenience
#define BLOCKIO_PARTITIONTYPE_FAT12             0x01    /**< FAT12 partition (see blockio_write_partitiontype()) */
#define BLOCKIO_PARTITIONTYPE_FAT16             0x06    /**< FAT16 partition (see blockio_write_partitiontype()) */
#define BLOCKIO_PARTITIONTYPE_FAT32             0x0B    /**< FAT32 partition (see blockio_write_partitiontype()) */

#define DEVCTL_BLOCKIO_CFG                      ( DEVCTL_COMMON_NO + 0 )

/**
 * @brief
 *      Disk layout information
 *
 * This data structure holds information about the disk layout of a block
 * device. Use this as an argument to posix_devctl() with the
 * DEVCTL_BLOCKIO_CFG command:
 *
 * @code
 * posix_devctl_blockio_cfg_t cfg;
 *
 * posix_devctl( fd, DEVCTL_BLOCKIO_CFG, &cfg, sizeof( cfg ), NULL );
 * @endcode
 */
typedef struct
{
    uint32_t blkstart;  /**< Start sector */
    uint32_t blksize;   /**< Sector size */
    uint32_t blktotal;  /**< Number of sectors on the device */
} posix_devctl_blockio_cfg_t;

#define DEVCTL_BLOCKIO_IMPL                     ( DEVCTL_COMMON_NO + 1 )

/**
 * @brief
 *      Block driver implementation
 *
 * This data structure holds the block driver implementation. Use this as an
 * argument to posix_devctl() with the DEVCTL_BLOCKIO_IMPL command:
 *
 * @code
 * posix_devctl_blockio_impl_t impl;
 *
 * posix_devctl( fd, DEVCTL_BLOCKIO_IMPL, (void*)&impl, sizeof( impl ), NULL );
 * impl.read_sectors( impl.device, buf, lba, size );
 * @endcode
 */
typedef struct
{
    /** Device specific driver pointer */
    void *device;
    /** Sector write function */
    ssize_t (*write_sectors)( void *device, const void *buf, uint32_t lba, size_t size );
    /** Sector clear function */
    ssize_t (*clear_sectors)( void *device, uint32_t lba, size_t size );
    /** Sector read function */
    ssize_t (*read_sectors)( void *device, void *buf, uint32_t lba, size_t size );
    /** Write cached data to the device, optionally invalidating the cache */
    int (*flush_data)( void *device, int invalidate_cache );
    /** Perform range check on partition start, size and device total */
    bool (*sanity_check)( void *device, uint32_t blkstart, uint32_t blkcount, uint32_t blktotal );
} posix_devctl_blockio_impl_t;

#define DEVCTL_COMMON_BLOCKIO_NO                ( DEVCTL_COMMON_NO + 128 )

// basic block I/O
extern ssize_t bwrite( int fd, const void *buf, uint32_t lba, size_t size );
extern ssize_t bclear( int fd, uint32_t lba, size_t size );
extern ssize_t bread( int fd, void *buf, uint32_t lba, size_t size );
extern int bflush( int fd, bool invalidate );

// partition table support
extern int blockio_write_partitiontable( int fd, int32_t size[] );
extern int blockio_write_partitiontype( int fd, int nr, uint8_t type );
extern int blockio_select_partition( int fd, int nr, uint32_t *blkstart, uint32_t *blkcount );

#ifdef  __cplusplus
}
#endif

#endif /* _POSIX_SERIAL_H */
