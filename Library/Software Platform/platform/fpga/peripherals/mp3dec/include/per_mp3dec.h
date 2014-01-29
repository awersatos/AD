/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    WB_MP3DEC peripheral direct access. Generally this
|*                  interface will not be used directly, but instead
|*                  through a higher level driver interface.
|*
\*****************************************************************************/

#ifndef _PER_MP3DEC_H
#define _PER_MP3DEC_H

/**
 * @file
 * Direct access to the WB_MP3DEC peripheral.
 * Generally, application writers will use a higher level interface.
 */

#include <stdint.h>         // Required for uint32_t

#define MP3DEC_WORD( BASE )                 ((volatile uint32_t * const) (BASE) )

/**
 * @name Core Registers
 */

/** @{ */
#define MP3DEC_STATUS( BASE )               MP3DEC_WORD( BASE )[0]      /**< Status */
#define MP3DEC_INTMASK( BASE )              MP3DEC_WORD( BASE )[1]      /**< Interrupt Mask */
#define MP3DEC_READADDRESS( BASE )          MP3DEC_WORD( BASE )[2]      /**< Start of Read Area */
#define MP3DEC_READENDADDRESS( BASE )       MP3DEC_WORD( BASE )[3]      /**< End of Read Area */
#define MP3DEC_WRITEADDRESS( BASE )         MP3DEC_WORD( BASE )[4]     /**< Start of Write Area */
#define MP3DEC_SCRATCHADDRESS( BASE )       MP3DEC_WORD( BASE )[5]     /**< Start of Scratch Area */
#define MP3DEC_HEADER( BASE )               MP3DEC_WORD( BASE )[6]     /**< Header word of MP3 frame, valid when MP3DEC_STATUS_HEADERREADY is set */
#define MP3DEC_VERSION( BASE )              MP3DEC_WORD( BASE )[15]    /**< Core version and configuration */
/** @} */

/**
 * @name Core Status register bitmasks
 */

/** @{ */
#define MP3DEC_STATUS_START                0x00000001   /**< Start start decoding */
#define MP3DEC_STATUS_RESET                0x00000002   /**< Reset decoder */
#define MP3DEC_STATUS_READEMPTY            0x00000004   /**< Read buffer empty */
#define MP3DEC_STATUS_WRITEREADY           0x00000008   /**< Write buffer has been filled with one frame of decoded audio */
#define MP3DEC_STATUS_HEADERREADY          0x00000010   /**< Header register has been filled with a valid header */
/** @} */


/**
 * @name Core IntMask register bitmasks
 */

/** @{ */
#define MP3DEC_INTMASK_READEMPTY           0x00000004   /**< Read buffer empty */
#define MP3DEC_INTMASK_WRITEREADY          0x00000008   /**< Write buffer has been filled with one frame of decoded audio */
#define MP3DEC_INTMASK_HEADERREADY         0x00000010   /**< Header register has been filled with a valid header */
/** @} */

/**
 * @name Core Version register bitmasks
 */

/** @{ */
#define MP3DEC_VERSION_LITTLEENDIAN       0x00000100   /**< Little endian mode */
#define MP3DEC_VERSION_VERSION            0x0000000F   /**< Core version */
/** @} */

#endif /* _MP3DEC_H */
