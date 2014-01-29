/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $13/10/2009$
|*
|*  IN PACKAGE:         
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        
|*
 */

#ifndef DRV_CELLULAR_H_
#define DRV_CELLULAR_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include "drv_uart8.h"

typedef struct drv_cellular_s cellular_t;

#define CELLULAR_GPS_DEVICE_NAME "GPS"

extern cellular_t * cellular_open          (unsigned int id);
extern uart8_t *    cellular_uart8_open    (unsigned int id);

extern void         cellular_pwr_on        (cellular_t * cellular);
extern void         cellular_dtr           (cellular_t * cellular);
extern int          cellular_status        (cellular_t * cellular);

#ifdef  __cplusplus
}
#endif

#endif /* DRV_CELLULAR_H_ */
