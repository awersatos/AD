/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        USB-Host Mass Storage Device (MSD) driver
|*                      Printing structures
|*
 *****************************************************************************/

/**
 * @file
 * Utility for USB-Host MSD data printing
 */

#ifndef _DRV_USBHOST_MSD_PRINT_H
#define _DRV_USBHOST_MSD_PRINT_H

#include <usbhost_mass_storage.h>
#include <stdio.h>

extern void usbhost_msd_print_sense_response( FILE *fp, scsi_sense_response_t *response);

#endif /* _DRV_USBHOST_MSD_PRINT_H */
