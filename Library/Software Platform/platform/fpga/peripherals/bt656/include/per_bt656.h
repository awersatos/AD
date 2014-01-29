/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        BT656 device, low level interface. Application
|*                      witers should generally use a higher level interface.
|*
\*****************************************************************************/

/**
 * @file
 * This plugin provides low level access to the BT656 peripheral. Normally, you
 * do not need this interface because higher level interfaces are available.
 *
 * For a detailed description of the BT656 peripheral, see the Core Reference
 * <a href="CR0159 BT656 Video Capture Controller.PDF">BT656 Video Capture Controller</a>.
 */

#ifndef _PER_BT656_H
#define _PER_BT656_H

#include <stdint.h>

// color modes
#define BT656_CM_GREY8                  1
#define BT656_CM_GREY16                 2
#define BT656_CM_GREY32                 3
#define BT656_CM_RGB8                   4
#define BT656_CM_RGB16                  5
#define BT656_CM_RGB32                  6

// run modes
#define BT656_RM_DISABLE                0x00
#define BT656_RM_RUN                    0x01
#define BT656_RM_SINGLE                 0x10

#define BT656_MODE_RUN                  0x00000001
#define BT656_MODE_SFC                  0x00000002
#define BT656_MODE_CM                   0x0000001C
#define BT656_MODE_LITTLEENDIAN         0x80000000

// register definitions
#define BT656_BASE( base )              ( (volatile uint32_t * const)( base ) ) /**< Hardware base address */

#define BT656_MODE_REG( base )          BT656_BASE( base )[0]                   /**< Mode register, a combination of run mode and color mode */
#define BT656_STATUS_REG( base )        BT656_BASE( base )[1]                   /**< Status register */
#define BT656_START_REG( base )         BT656_BASE( base )[2]                   /**< Video buffer start address */
#define BT656_SIZE_REG( base )          BT656_BASE( base )[3]                   /**< Video buffer size */
#define BT656_BPL_REG( base )           BT656_BASE( base )[4]                   /**< Bytes per line on the output device */
#define BT656_VBPL_REG( base )          BT656_BASE( base )[5]                   /**< Visible bytes per line (bytes per line written to the video buffer) */
#define BT656_SCALE_REG( base )         BT656_BASE( base )[6]                   /**< Scaling register */

#endif /* _PER_BT656_H */
