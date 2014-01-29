/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    WB_JPGDEC peripheral direct access. Generally this
|*                  interface will not be used directly, but instead
|*                  through a higher level driver interface.
|*
\*****************************************************************************/

#ifndef _JPGDEC_H
#define _JPGDEC_H

/**
 * @file
 * Direct access to the WB_JPGDEC peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * See also CR0174 - WB_JPGDEC JPEG decoder
 */

#include <stdint.h>         // Required for uint32_t

#define JPGDEC_WORD( BASE )                 ((volatile uint32_t * const) (BASE) )

/**
 * @name Core Registers
 */

/** @{ */
#define JPGDEC_STATUS( BASE )               JPGDEC_WORD( BASE )[0]      /**< Status */
#define JPGDEC_INTMASK( BASE )              JPGDEC_WORD( BASE )[1]      /**< Interrupt Mask */
#define JPGDEC_SIZE_X( BASE )               JPGDEC_WORD( BASE )[2]      /**< Image Size - Width */
#define JPGDEC_SIZE_Y( BASE )               JPGDEC_WORD( BASE )[3]      /**< Image Size - Height */
#define JPGDEC_START_X( BASE )              JPGDEC_WORD( BASE )[4]      /**< Decoding Area - Start Column */
#define JPGDEC_START_Y( BASE )              JPGDEC_WORD( BASE )[5]      /**< Decoding Area - Start Row */
#define JPGDEC_END_X( BASE )                JPGDEC_WORD( BASE )[6]      /**< Decoding Area - End Column */
#define JPGDEC_END_Y( BASE )                JPGDEC_WORD( BASE )[7]      /**< Decoding Area - End Row */
#define JPGDEC_READADDRESS( BASE )          JPGDEC_WORD( BASE )[8]      /**< Read Address */
#define JPGDEC_READCOUNT( BASE )            JPGDEC_WORD( BASE )[9]      /**< Read Count */
#define JPGDEC_WRITESTARTADDRESS( BASE )    JPGDEC_WORD( BASE )[10]     /**< Write Area - Start */
#define JPGDEC_WRITEENDADDRESS( BASE )      JPGDEC_WORD( BASE )[11]     /**< Write Area - End */
#define JPGDEC_WRITEOFFSET( BASE )          JPGDEC_WORD( BASE )[12]     /**< Write Address - OFfset */
#define JPGDEC_WRITEWIDTH( BASE )           JPGDEC_WORD( BASE )[13]     /**< Write Line Width */
#define JPGDEC_WRITEADDRESS( BASE )         JPGDEC_WORD( BASE )[14]     /**< Write Address */
/** @} */

/**
 * @name Core status register bitmasks
 */

/** @{ */
#define JPGDEC_STATUS_READY                0x0001   /**< Ready, image correctly processed */
#define JPGDEC_STATUS_READEMPTY            0x0002   /**< Read buffer empty */
#define JPGDEC_STATUS_WRITEFULL            0x0004   /**< Write requested outside buffer */
#define JPGDEC_STATUS_ERROR                0x0008   /**< Error */
#define JPGDEC_STATUS_ERROR_NOTAJPG        0x0010   /**< Error type: header not recognized */
#define JPGDEC_STATUS_ERROR_CORRUPT        0x0020   /**< Error type: data is corrupt */
#define JPGDEC_STATUS_ERROR_UNSUPPORTED    0x0040   /**< Error type: format not supported */
#define JPGDEC_STATUS_START                0x0080   /**< Start start decoding */
#define JPGDEC_STATUS_RESET                0x0100   /**< Reset decoder, test idle state */
/** @} */

#endif /* _JPGDEC_H */
