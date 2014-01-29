/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*
|*  Description:    VGA_32 peripheral direct access. Generally this 
|*                  interface will not be used directly, but instead
|*                  through a higher level driver interface.
|*
 *****************************************************************************/

#ifndef _PER_VGA32_H
#define _PER_VGA32_H

/**
 * @file
 * Direct access to the VGA32_16BPP peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * @see 
 *     CR0165 - VGA32_16BPP - 32-bit VGA Controller with 16bpp Data Support
 */

#include <stdint.h>

#define VGA32_BASE(address)         ((volatile uint32_t*)address)

/**
 * @name Core Registers
 */
 
/** @{ */ 
#define VGA32_CTRL_REG(address)     VGA32_BASE(address)[0x0]      /**< Control register */                       
#define VGA32_STAT_REG(address)     VGA32_BASE(address)[0x1]      /**< Status register */                        
#define VGA32_HTIM_REG(address)     VGA32_BASE(address)[0x2]      /**< Horizontal timing register */             
#define VGA32_VTIM_REG(address)     VGA32_BASE(address)[0x3]      /**< Vertical timing register */               
#define VGA32_HVLEN_REG(address)    VGA32_BASE(address)[0x4]      /**< Horizontal and vertical lenght register */
#define VGA32_VMBA_REG(address)     VGA32_BASE(address)[0x5]      /**< Video Memory Base Address register */     
#define VGA32_CDIV_REG(address)     VGA32_BASE(address)[0x6]      /**< System clock division register */         
#define VGA32_CLUTOFF_REG(address)  VGA32_BASE(address)[0x7]      /**< Color Look-up Table Offset Register */
#define VGA32_CLUT0(address)        VGA32_BASE(address)[0x200]    /**< Start address Color Look-up Table 0 */
#define VGA32_CLUT1(address)        VGA32_BASE(address)[0x300]    /**< Start address Color Look-up Table 1 */


                                                                                       
/**                                                                                    
 * @name Core Control Register Bitmasks                                                
 */                                                                                    
/** @{ */                                                                              
#define VGA32_VSE       0x0001   /**< Video System Enable */ 
#define VGA32_LTB       0x0010   /**< Color Look-up Table Select */ 
#define VGA32_BM        0x0060   /**< Bitmode Control */
#define VGA32_CME       0x0080   /**< Color Mode Enable */
#define VGA32_HOP       0x0100   /**< Horizontal Synchronization Output Polarity */
#define VGA32_VOP       0x0200   /**< Vertical Synchronization Output Polarity */  
#define VGA32_COP       0x0400   /**< Composite Synchronization Output Polarity */ 
#define VGA32_BOP       0x0800   /**< Blanking Synchronization Output Polarity */  
#define VGA32_CKDE      0x1000   /**< Clock Division Enable */                     
/** @} */                                                                              
                                                                                       
                                                                                       
/**                                                                                    
 * @name Core Status Register Bitmasks                                                
 */                                                                                    
/** @{ */                                                                              
#define VGA32_ACP       0x0010   /**< Active Color Look-up Table flag */ 
/** @} */                                                                              
                                                                                       
                                                                                       
/**                                                                                    
 * @name Core Horizontal Timing Register Bitmasks                                      
 */                                                                                    
/** @{ */                                                                              
#define VGA32_HVISIBLE  0x0000FFFF   /**< Horizontal Visible Area */               
#define VGA32_HBPORCH   0x00FF0000   /**< Horizontal Back Porch length */          
#define VGA32_HSYNC     0xFF000000   /**< Horizontal Synch Pulse length */         
/** @} */                                                                              
                                                                                       
                                                                                       
/**                                                                                    
 * @name Core Vertical Timing Register Bitmasks                                        
 */                                                                                    
/** @{ */                                                                              
#define VGA32_VVISIBLE  0x0000FFFF   /**< Vertical Visible Area */                 
#define VGA32_VBPORCH   0x00FF0000   /**< Vertical Back Porch length */            
#define VGA32_VSYNC     0xFF000000   /**< Vertical Synch Pulse length */           
/** @} */                                                                              
                                                                                       
                                                                                       
/**                                                                                    
 * @name Core Horizontal and Vertical Length Register Bitmasks                         
 */                                                                                    
/** @{ */                                                                              
#define VGA32_VLEN      0x0000FFFF   /**< Number of lines in a frame */            
#define VGA32_HLEN      0xFFFF0000   /**< Number of pixel in a line */             
/** @} */                                                                              

#endif
                                                                                        
