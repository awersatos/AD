/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        SD host controller driver
|*
\*****************************************************************************/

#ifndef _DRV_SDHC_H
#define _DRV_SDHC_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef struct
{
    unsigned int blksize;       /**< Size of a sector */
    unsigned int blkcount;      /**< Number of sectors on the device */
} sdhc_info_t;

typedef struct sdhc_s sdhc_t;

#define SDHC_CARD_SCMEM   1                 /* Card is a standard capacity memory only card */
#define SDHC_CARD_HCMEM   2                 /* Card is a high capacity memory only card */
#define SDHC_CARD_IO      3                 /* Card is an I/O only card */
#define SDHC_CARD_SCCOMBO 4                 /* Card is a standard capacity combo card */
#define SDHC_CARD_HCCOMBO 5                 /* Card is a high capacity combo card */

#define SDHC_ERR_OK                 0       /* No error */
#define SDHC_ERR_CRC                -1      /* CRC error on receiver */
#define SDHC_ERR_NORESP             -2      /* No response from receiver */
#define SDHC_ERR_NODATA             -3      /* Not enough data in FIFO */
#define SDHC_ERR_EXTDATA            -4      /* Extraneous data in FIFO */
#define SDHC_ERR_NOCARD             -5      /* No card */
#define SDHC_ERR_UNUSABLE           -6      /* Unusable card */
#define SDHC_ERR_TIMEOUT            -7      /* Timeout on data receive */
#define SDHC_ERR_INTERNAL           -8      /* And internal error has occured */

typedef enum
{
    SDHC_INIT_POWERON,                /* Card initialization from power on */
    SDHC_INIT_MEMORY,                 /* Initialize the memory part of the card only */
    SDHC_INIT_IO                      /* Initialize the I/O part of the card */
} sdhc_init_t;

//extern bool sdhc_is_memcard( card_t card );
extern bool sdhc_is_memcard( int card );
extern sdhc_t * sdhc_open(unsigned id);
extern bool sdhc_card_detect( sdhc_t * restrict drv );
extern bool sdhc_card_protected( sdhc_t * restrict drv );
extern bool sdhc_card_removed( sdhc_t * restrict drv );
extern int sdhc_card_init( sdhc_t * restrict drv, sdhc_init_t init );

extern unsigned sdhc_set_speed( sdhc_t * restrict drv, unsigned sdclk, unsigned sysclk );
extern bool sdhc_set_blocklength( sdhc_t * drv, uint32_t blocklength );
extern uint32_t sdhc_get_status( sdhc_t * drv );

extern const sdhc_info_t *sdhc_get_info( sdhc_t * restrict drv );
extern int sdhc_read_sectors( sdhc_t * restrict drv, uint8_t *data, unsigned int lba, unsigned int sectorcount );
extern int sdhc_write_sectors( sdhc_t * restrict drv, const uint8_t *data, unsigned int lba, unsigned int sectorcount );
extern int sdhc_clear_sectors( sdhc_t * restrict drv, unsigned int lba, unsigned int sectorcount );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_SDHC_H */
