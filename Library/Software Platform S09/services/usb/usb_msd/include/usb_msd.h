/*
 * USB mass storage class
 */
/*
 * @file Service for USB mass storage devices.
 */

#include <stdint.h>
#include <stdbool.h>

#ifdef  __cplusplus
extern "C" {
#endif

#ifndef __USB_MSD_H
#define __USB_MSD_H     1

typedef struct _usb_msd_t usb_msd_t;

/* initialize USB mass storage class */
extern  usb_msd_t       *msd_open(int id);
extern  void            msd_reset(usb_msd_t *msd);

/* handle USB mass storage requests */
extern  void            msd_handle_request(usb_msd_t *msd);

#ifdef  __cplusplus
}
#endif

#endif /* !defined(__USB_MSD_H) */

