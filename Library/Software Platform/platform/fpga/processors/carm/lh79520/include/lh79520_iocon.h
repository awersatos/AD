
#if !defined LH79520_IOCON_H
#define LH79520_IOCON_H

#include "lh79520_chip.h"

/***********************************************************************
 * IO Configuration Block Structure
 **********************************************************************/
/* type for IOCON register types */
typedef struct 
{
    volatile uint32_t   memmux;
    volatile uint32_t   lcdmux;
    volatile uint32_t   miscmux;
    volatile uint32_t   dmamux;
    volatile uint32_t   uartmux;
    volatile uint32_t   ssimux;
    volatile uint32_t   scratchreg;
} IOCON_REGS_TYPE;

/***********************************************************************
 * Memory Multiplexing IOCON Register Bit Field constants
 **********************************************************************/
#define MEMMUX_PIOE_NOMUX       _SBF(0,0)
#define MEMMUX_MIDQM32          _SBF(0,1)
#define MEMMUX_MIDQM30          _SBF(0,3)
#define MEMMUX_PIOE4            _SBF(2,0)
#define MEMMUX_MINWE            _SBF(2,1)
#define MEMMUX_PIOE5            _SBF(3,0)
#define MEMMUX_MISDNCS0         _SBF(3,1)
#define MEMMUX_PIOE6            _SBF(4,0)
#define MEMMUX_MISDNCS1         _SBF(4,1)
#define MEMMUX_PIOE7            _SBF(5,0)
#define MEMMUX_MICKE            _SBF(5,1)
#define MEMMUX_PIOF0            _SBF(6,0)
#define MEMMUX_MICLKIO          _SBF(6,1)
#define MEMMUX_PIO_X            _SBF(7,0)
#define MEMMUX_MIDATA_X         _SBF(7,1)
#define MEMMUX_PIOH2            _SBF(8,0)
#define MEMMUX_MICSN3           _SBF(8,1)
#define MEMMUX_PIOH3            _SBF(9,0)
#define MEMMUX_MICSN4           _SBF(9,1)
#define MEMMUX_PIOH4            _SBF(10,0)
#define MEMMUX_MICSN5           _SBF(10,1)
#define MEMMUX_PIOH5            _SBF(11,0)
#define MEMMUX_MICSN6           _SBF(11,1)
#define MEMMUX_PIOH6            _SBF(12,0)
#define MEMMUX_MIBLSN2          _SBF(12,1)
#define MEMMUX_PIOH7            _SBF(13,0)
#define MEMMUX_MIBLSN3          _SBF(13,1)

/***********************************************************************
 * LCD Multiplexing IOCON Register Bit Field constants
 **********************************************************************/
#define LCDMUX_PIOB4            _SBF(0,0)
#define LCDMUX_CLD12            _SBF(0,1)
#define LCDMUX_CLREV            _SBF(0,2)
#define LCDMUX_PIOB5            _SBF(2,0)
#define LCDMUX_CLD13            _SBF(2,1)
#define LCDMUX_PIOB6            _SBF(3,0)
#define LCDMUX_CLD14            _SBF(3,1)
#define LCDMUX_PIOB7            _SBF(4,0)
#define LCDMUX_CLD15            _SBF(4,1)
#define LCDMUX_CLDSPLEN         _SBF(4,2)
#define LCDMUX_PIOC0            _SBF(6,0)
#define LCDMUX_CLDEN            _SBF(6,1)
#define LCDMUX_CLSPL            _SBF(6,2)
#define LCDMUX_PIOC1            _SBF(8,0)
#define LCDMUX_CLVDDEN          _SBF(8,1)
#define LCDMUX_CLS              _SBF(8,2)
#define LCDMUX_PIOC2            _SBF(10,0)
#define LCDMUX_CLXCLK           _SBF(10,1)
#define LCDMUX_PIOC3            _SBF(11,0)
#define LCDMUX_CLCP             _SBF(11,1)
#define LCDMUX_PIOC4            _SBF(12,0)
#define LCDMUX_CLD16            _SBF(12,1)
#define LCDMUX_PIOC5            _SBF(13,0)
#define LCDMUX_CLLP             _SBF(13,1)
#define LCDMUX_CLP              _SBF(13,2)
#define LCDMUX_PIOC6            _SBF(15,0)
#define LCDMUX_CLD17            _SBF(15,1)
#define LCDMUX_PIOC7            _SBF(16,0)
#define LCDMUX_CLFP             _SBF(16,1)
#define LCDMUX_CLSPS            _SBF(16,2)
#define LCDMUX_PIOD0            _SBF(18,0)
#define LCDMUX_CLD2             _SBF(18,1)
#define LCDMUX_PIOD1            _SBF(19,0)
#define LCDMUX_CLD3             _SBF(19,1)
#define LCDMUX_PIOD2            _SBF(20,0)
#define LCDMUX_CLD4             _SBF(20,1)
#define LCDMUX_PIOD3            _SBF(21,0)
#define LCDMUX_CLD5             _SBF(21,1)
#define LCDMUX_PIOD4            _SBF(22,0)
#define LCDMUX_CLD6             _SBF(22,1)
#define LCDMUX_CPS              _SBF(22,2)
#define LCDMUX_PIOD5            _SBF(24,0)
#define LCDMUX_CLD7             _SBF(24,1)
#define LCDMUX_PIOD6            _SBF(25,0)
#define LCDMUX_CLD8             _SBF(25,1)
#define LCDMUX_PIOD7            _SBF(26,0)
#define LCDMUX_CLD9             _SBF(26,1)
#define LCDMUX_INT6             _SBF(27,0)
#define LCDMUX_CLD10            _SBF(27,1)
#define LCDMUX_INT7             _SBF(28,0)
#define LCDMUX_CLD11            _SBF(28,1)

/***********************************************************************
 * Miscellaneous Multiplexing IOCON Register Bit Field constants
 **********************************************************************/
#define MISCMUX_PWM1            _SBF(0,0)
#define MISCMUX_DCDEOT1         _SBF(0,1)
#define MISCMUX_PIOA5           _SBF(1,0)
#define MISCMUX_RCCLKOUT        _SBF(1,1)
#define MISCMUX_PIOA6           _SBF(2,0)
#define MISCMUX_INT0            _SBF(2,1)
#define MISCMUX_PIOA7           _SBF(3,0)
#define MISCMUX_INT1            _SBF(3,1)
#define MISCMUX_PIOB0           _SBF(4,0)
#define MISCMUX_INT2            _SBF(4,1)
#define MISCMUX_INT3            _SBF(5,0)
#define MISCMUX_PWM0SYNC        _SBF(5,1)
#define MISCMUX_INT4            _SBF(6,0)
#define MISCMUX_PWM0            _SBF(6,1)
#define MISCMUX_RCCTOUT         _SBF(7,0)
#define MISCMUX_DCDACK1         _SBF(7,1)
#define MISCMUX_DCDREQ1         _SBF(8,0)
#define MISCMUX_INT5            _SBF(8,1)
#define MISCMUX_PIOF1           _SBF(9,0)
#define MISCMUX_RCCLKEN         _SBF(9,1)
#define MISCMUX_RCCLKIN         _SBF(10,0)
#define MISCMUX_RCUTCLK         _SBF(10,1)

/***********************************************************************
 * DMA Multiplexing IOCON Register Bit Field constants
 **********************************************************************/
#define DMAMUX_PIOB1            _SBF(0,0)
#define DMAMUX_DCDEOT0          _SBF(0,1)
#define DMAMUX_PIOB2            _SBF(1,0)
#define DMAMUX_DCDACK0N         _SBF(1,1)
#define DMAMUX_PIOB3            _SBF(2,0)
#define DMAMUX_DCDREQ0          _SBF(2,1)

/***********************************************************************
 * UART Multiplexing IOCON Register Bit Field constants
 **********************************************************************/
#define UARTMUX_U0IRRXA         _SBF(0,0)
#define UARTMUX_U0RXD           _SBF(0,1)
#define UARTMUX_U0IRTXA         _SBF(1,0)
#define UARTMUX_U0TXD           _SBF(1,1)
#define UARTMUX_PA3             _SBF(2,0)
#define UARTMUX_U1RXD           _SBF(2,1)
#define UARTMUX_PA4             _SBF(3,0)
#define UARTMUX_U1TXD           _SBF(3,1)

/***********************************************************************
 * SSI Multiplexing IOCON Register Bit Field constants
 **********************************************************************/
#define SSIMUX_SSPIN            _SBF(0,0)
#define SSIMUX_UT2RXD           _SBF(0,1)
#define SSIMUX_SSPOUT           _SBF(1,0)
#define SSIMUX_UT2TXD           _SBF(1,1)
#define SSIMUX_PIOA0            _SBF(2,0)
#define SSIMUX_SSPENB           _SBF(2,1)
#define SSIMUX_PIOA1            _SBF(3,0)
#define SSIMUX_SSPCLK           _SBF(3,1)
#define SSIMUX_PIOA2            _SBF(4,0)
#define SSIMUX_SSPFRM           _SBF(4,1)

/* Macro pointing to IOCON registers */
#define IOCON    ((IOCON_REGS_TYPE *)(IOCON_BASE))

#endif /* LH79520_IOCON_H */ 
