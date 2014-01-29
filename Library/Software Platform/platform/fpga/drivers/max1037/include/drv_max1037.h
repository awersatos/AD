#ifndef __DRV_MAX1037_H
#define __DRV_MAX1037_H

#ifdef  __cplusplus
extern "C" {
#endif

/** @file
  * Interface to the MAX1037 AD converter device driver
  */

#include <stdint.h>
#include <limits.h>

#define MAX1037_ERR INT_MIN


/**
 * @name Bits in the setup byte
 */

/** @{ */
#define MAX1037_SETUP_nRST         0x02    /**<  Negative reset */
#define MAX1037_SETUP_BIPOLAIR     0x04    /**<  Bipolair operation */
#define MAX1037_SETUP_EXTCLK       0x08    /**<  Use external clock */
#define MAX1037_SETUP_SEL0         0x10    /**<  Select reference voltage and state of AIN_/REF */
#define MAX1037_SETUP_SEL1         0x20    /**<  Select reference voltage and state of AIN_/REF */
#define MAX1037_SETUP_SEL2         0x40    /**<  Select reference voltage and state of AIN_/REF */
#define MAX1037_SETUP_REG          0x80    /**<  Must be set to address configuration byte */
/** @} */


/**
 * @name Bits in the configuration byte
 */

/** @{ */
#define MAX1037_CONFIG_SGL         0x01    /**<  Single ended */
#define MAX1037_CONFIG_CS0         0x02    /**<  Channel select 0 */
#define MAX1037_CONFIG_CS1         0x04    /**<  Channel select 1 */
#define MAX1037_CONFIG_CS2         0x08    /**<  Channel select 2 */
#define MAX1037_CONFIG_CS3         0x10    /**<  Channel select 3 */
#define MAX1037_CONFIG_CS_MASK     (MAX1037_CONFIG_CS0|MAX1037_CONFIG_CS1|MAX1037_CONFIG_CS2|MAX1037_CONFIG_CS3)
#define MAX1037_CONFIG_SCAN0       0x20    /**<  Scan select bit 0 */
#define MAX1037_CONFIG_SCAN1       0x40    /**<  Scan select bit 1 */
#define MAX1037_CONFIG_SCAN_MASK   (MAX1037_CONFIG_SCAN0|MAX1037_CONFIG_SCAN1)
/** @} */

typedef struct drv_max1037_s max1037_t;

extern max1037_t * max1037_open( unsigned int id );
extern int max1037_read( max1037_t * restrict drv );
extern int max1037_read_channel( max1037_t * restrict drv, uint8_t channel );
extern int max1037_multiread( max1037_t * restrict drv, uint8_t * data, size_t length );
extern int max1037_write_setup( max1037_t * restrict drv, uint8_t setup );
extern int max1037_write_config( max1037_t * restrict drv, uint8_t config );
extern int max1037_select_channel( max1037_t * restrict drv, uint8_t channel );
extern int max1037_select_multichannel( max1037_t * restrict drv, uint8_t channels );
extern uint8_t max1037_read_config( max1037_t * restrict drv );
extern uint8_t max1037_read_setup( max1037_t * restrict drv );

#ifdef  __cplusplus
}
#endif

#endif // __DRV_MAX1037_H
