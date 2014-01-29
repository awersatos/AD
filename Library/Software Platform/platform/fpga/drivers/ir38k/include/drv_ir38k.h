/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:
|*
 */
/**
 * @file
 * Driver for the Infrared Remote Control WB_IR38KRX peripheral. This peripheral 
 * enables the Vishay TSOP 323338 applied on the NB Starterkit. The driver enables you
 * to receive infrared NEC encoded signals from a remote control. After configuring 
 * this driver, open the hardware by using ir38k_open(). 
 */
#ifndef _DRV_IR38K_H
#define _DRV_IR38K_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

typedef struct ir38k_drv_s ir38k_t;

extern int ir38k_rxnecdata(ir38k_t * restrict drv, uint16_t *address, uint16_t *command);
extern int ir38k_getbiterror(ir38k_t * restrict drv);
extern void ir38k_rstbiterror(ir38k_t * restrict drv);
extern ir38k_t *ir38k_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_IR38K_H */
