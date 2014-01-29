/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    posix_devctl
|*
\*****************************************************************************/

#include <limits.h>

#include <unistd.h>
#include <errno.h>
#include <devio.h>

/**
 * @brief causes the device control command dcmd to be passed to the driver identified by fildes.
 *
 *      The posix_devctl() function shall cause the device control command dcmd to be
 *      passed to the driver identified by fildes. Associated data shall be passed to and/or
 *      from the driver depending on direction information encoded in the dcmd argument
 *      or as implied in the dcmd argument by the design and implementation of the driver.
 *      If the dev_data_ptr argument is not a NULL pointer, it shall be a pointer to a buffer
 *      that is provided by the caller and that contains data bytes to be passed to the driver
 *      or provides space for receiving data bytes to be passed back from the driver, or both.
 *      If the data are to be passed to the driver, at least nbyte bytes of associated data
 *      shall be made available to the driver; if the data are to be passed from the driver,
 *      no more than nbyte bytes shall be passed.
 *
 *      If dev_data_ptr is not a NULL pointer and nbyte is zero, the amount of data passed
 *      to and/or from the driver is unspecified. This feature is obsolescent and is only provided
 *      for compatibility with existing device drivers.
 *      If dev_data_ptr is a NULL pointer, there shall be no data passed between the caller
 *      and the driver other than the data specified in the rest of the arguments to
 *      posix_devctl() and in its return value.
 *      The dev_info_ptr argument provides the opportunity to return an integer number
 *      containing additional device information, instead of just a success/failure indication.
 *      The set of valid commands, the associated data interpretation, the returned device
 *      information number, and the effects of the command on the device are all defined
 *      by the driver for the device identified by fildes.
 *
 * @param fildes
 *        file descriptor
 * @param dcmd
 *        device command
 * @param dev_data_ptr
 *        pointer to a buffer to be passed/received to/from the driver
 * @param nbyte
 *        number of buffer bytes to be made available to/from the driver
 * @param dev_info_ptr
 *        additional return information
 * @return
 *      Upon successful completion, posix_devctl() shall return zero; otherwise an error
 *      number shall be returned to indicate the error. The value returned via the
 *      dev_info_ptr argument is driver dependent.
 *
 */

extern int posix_devctl(      int fildes,
                              int dcmd,
                              void *dev_data_ptr,
                              size_t nbyte,
                              int *dev_info_ptr )
{
        int   ret=0;
        void* dptr;

        if (  dev_data_ptr == NULL && nbyte )
        {
                return EINVAL;
        }

        if ( fildes < 0 || fildes >= DEV_MAX || (dptr = devio_getdev(fildes)) == NULL  )
        {
                return  EBADF;
        }

        return devio_posix_devctl( dptr,dcmd,dev_data_ptr,nbyte, dev_info_ptr);
}


