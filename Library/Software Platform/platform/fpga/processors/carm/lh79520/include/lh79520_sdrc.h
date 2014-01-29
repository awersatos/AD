#if !defined LH79520_SDRC_H
#define LH79520_SDRC_H

#include "lh79520_chip.h"

/***********************************************************************
 * SDRAM Controller Module Register Structure
 **********************************************************************/
typedef struct
{
    volatile uint32_t config0;    /* Configuration 0 */
    volatile uint32_t config1;    /* Configuration 1 */
    volatile uint32_t reftimer;   /* Refresh Timer */
    volatile uint32_t wbtimeout;  /* Write Buffer Timeout */ 
} SDRC_REGS_TYPE;

/*********************************************************************** 
 * SDRAM Controller Configuration Register 0 Bit Field constants
 **********************************************************************/ 
/* SDRAM controller bit field - Auto Pre-charge */ 
#define SDRAM_A_AUTO    _SBF(24,1)  /* Auto Pre-charge */ 
/* SDRAM controller bit field - No Auto Pre-charge */ 
#define SDRAM_A_NOAUTO  _SBF(24,0)  /* No Auto Pre-charge */ 
/* SDRAM controller bit field - Clock Enable Continuous */ 
#define SDRAM_C_CONT    _SBF(18,1)  /* Clock Enable Continuous */ 
/* SDRAM controller bit field - Clock Enable Idle deasserted */ 
#define SDRAM_C_IDLE    _SBF(18,0)  /* Clock Enable Idle deasserted */ 
/* SDRAM controller bit field - CAS latency 1 */ 
#define SDRAM_CLAT1     _SBF(20,1)  /* CAS latency 1 */ 
/* SDRAM controller bit field - CAS latency 2 */ 
#define SDRAM_CLAT2     _SBF(20,2)  /* CAS latency 2 */ 
/* SDRAM controller bit field - CAS latency 3 */ 
#define SDRAM_CLAT3     _SBF(20,3)  /* CAS latency 3 */ 
/* SDRAM controller bit field - nCSOut[0] is 256MBit device */ 
#define SDRAM_CS0_256M  _BIT(1)     /* nCSOut[0] is 256MBit device */ 
/* SDRAM controller bit field - nCSOut[0] is 2 bank device*/
#define SDRAM_CS0_2BANK _SBF(3,0)   /* nCSOut[0] is 2 bank device*/
/* SDRAM controller bit field - nCSOut[0] is 4 bank device*/
#define SDRAM_CS0_4BANK _SBF(3,1)   /* nCSOut[0] is 4 bank device*/
/* SDRAM controller bit field - nCSOut[0] is x16 device*/
#define SDRAM_CS0_X16   _SBF(2,0)   /* nCSOut[0] is x16 device*/
/* SDRAM controller bit field - nCSOut[0] is x32 device*/
#define SDRAM_CS0_X32   _SBF(2,0)   /* nCSOut[0] is x32 device*/
/* SDRAM controller bit field - nCSOut[0] is x8 device*/
#define SDRAM_CS0_X8    _SBF(2,1)   /* nCSOut[0] is x8 device*/
/* SDRAM controller bit field - nCSOut[1] is 256MBit device */ 
#define SDRAM_CS1_256M  _BIT(5)     /* nCSOut[1] is 256MBit device */ 
/* SDRAM controller bit field - nCSOut[1] is 2 bank device*/
#define SDRAM_CS1_2BANK _SBF(7,0)   /* nCSOut[1] is 2 bank device*/
/* SDRAM controller bit field - nCSOut[1] is 4 bank device*/
#define SDRAM_CS1_4BANK _SBF(7,1)   /* nCSOut[1] is 4 bank device*/
/* SDRAM controller bit field - nCSOut[1] is x16 device*/
#define SDRAM_CS1_X16   _SBF(6,0)   /* nCSOut[1] is x16 device*/
/* SDRAM controller bit field - nCSOut[1] is x32 device*/
#define SDRAM_CS1_X32   _SBF(6,0)   /* nCSOut[1] is x32 device*/
/* SDRAM controller bit field - nCSOut[1] is x8 device*/
#define SDRAM_CS1_X8    _SBF(6,1)   /* nCSOut[1] is x8 device*/
/* SDRAM controller bit field - nCSOut[2] is 256MBit device */ 
#define SDRAM_CS2_256M  _BIT(9)     /* nCSOut[2] is 256MBit device */ 
/* SDRAM controller bit field - nCSOut[2] is 2 bank device*/
#define SDRAM_CS2_2BANK _SBF(11,0)  /* nCSOut[2] is 2 bank device*/
/* SDRAM controller bit field - nCSOut[2] is 4 bank device*/
#define SDRAM_CS2_4BANK _SBF(11,1)  /* nCSOut[2] is 4 bank device*/
/* SDRAM controller bit field - nCSOut[2] is x16 device*/
#define SDRAM_CS2_X16   _SBF(10,0)  /* nCSOut[2] is x16 device*/
/* SDRAM controller bit field - nCSOut[2] is x32 device*/
#define SDRAM_CS2_X32   _SBF(10,0)  /* nCSOut[2] is x32 device*/
/* SDRAM controller bit field - nCSOut[2] is x8 device*/
#define SDRAM_CS2_X8    _SBF(10,1)  /* nCSOut[2] is x8 device*/
/* SDRAM controller bit field - nCSOut[3] is 256MBit device */ 
#define SDRAM_CS3_256M  _BIT(13)    /* nCSOut[3] is 256MBit device */ 
/* SDRAM controller bit field - nCSOut[3] is 2 bank device*/
#define SDRAM_CS3_2BANK _SBF(15,0)  /* nCSOut[3] is 2 bank device*/
/* SDRAM controller bit field - nCSOut[3] is 4 bank device*/
#define SDRAM_CS3_4BANK _SBF(15,1)  /* nCSOut[3] is 4 bank device*/
/* SDRAM controller bit field - nCSOut[3] is x16 device*/
#define SDRAM_CS3_X16   _SBF(14,0)  /* nCSOut[3] is x16 device*/
/* SDRAM controller bit field - nCSOut[3] is x32 device*/
#define SDRAM_CS3_X32   _SBF(14,0)  /* nCSOut[3] is x32 device*/
/* SDRAM controller bit field - nCSOut[3] is x8 device*/
#define SDRAM_CS3_X8    _SBF(14,1)  /* nCSOut[3] is x8 device*/
/* SDRAM controller bit field - Clockout Continuous */ 
#define SDRAM_E_CONT    _SBF(17,0)  /* Clockout Continuous */ 
/* SDRAM controller bit field - Clockout stops on Idle */ 
#define SDRAM_E_IDLE    _SBF(17,1)  /* Clockout stops on Idle */ 
/* SDRAM controller bit field - RAS to CAS latency 1 */ 
#define SDRAM_RCLAT1    _SBF(22,1)  /* RAS to CAS latency 1 */ 
/* SDRAM controller bit field - RAS to CAS latency 2 */ 
#define SDRAM_RCLAT2    _SBF(22,2)  /* RAS to CAS latency 2 */ 
/* SDRAM controller bit field - RAS to CAS latency 3 */ 
#define SDRAM_RCLAT3    _SBF(22,3)  /* RAS to CAS latency 3 */ 
/* SDRAM controller bit field - External Bus Width 16 */ 
#define SDRAM_EXTBUS16  _SBF(19,1)  /* External Bus Width 16 */ 
/* SDRAM controller bit field - External Bus Width 32 */ 
#define SDRAM_EXTBUS32  _SBF(19,0)  /* External Bus Width 32 */ 

/*********************************************************************** 
 * SDRAM Controller Configuration Register 1 Bit Field constants
 **********************************************************************/ 
/* SDRAM controller register 1 bit - Normal Operation */ 
#define SDRAM_INIT_NORMAL   _SBF(0,0)   /* Normal Operation */ 
/* SDRAM controller register 1 bit - Init Control PALL */ 
#define SDRAM_INIT_PALL     _SBF(0,1)   /* Init Control PALL */ 
/* SDRAM controller register 1 bit - Init Control MODE */ 
#define SDRAM_INIT_MODE     _SBF(0,2)   /* Init Control MODE */ 
/* SDRAM controller register 1 bit - Init Control NOP */ 
#define SDRAM_INIT_NOP      _SBF(0,3)   /* Init Control NOP */ 
/* SDRAM controller register 1 bit - SDRAM Engine Status */ 
#define SDRAM_STATUS        _BIT(5)     /* SDRAM Engine Status */ 
/* SDRAM controller register 1 bit - Write Buffer Disable */ 
#define SDRAM_WB_DISABLE    _SBF(3,0)   /* Write Buffer Disable */ 
/* SDRAM controller register 1 bit - Write Buffer Enable */ 
#define SDRAM_WB_ENABLE     _SBF(3,1)   /* Write Buffer Enable */ 
/* SDRAM controller register 1 bit - Read Buffer Disable */ 
#define SDRAM_RB_DISABLE    _SBF(2,0)   /* Read Buffer Disable */ 
/* SDRAM controller register 1 bit - Read Buffer Enable */ 
#define SDRAM_RB_ENABLE     _SBF(2,1)   /* Read Buffer Enable */ 

/*********************************************************************** 
 * SDRAM Controller Refresh Timer Register Bit Field
 **********************************************************************/ 
/* SDRAM controller refresh timer bit - Set Refresh Timer */ 
#define SDRAM_SET_REFRESH(n)    ((n)&_BITMASK(16))

/*********************************************************************** 
 * SDRAM Controller Write Buffer Timeout Register Bit Field
 **********************************************************************/ 
/* SDRAM controller refresh timer bit -  Set Write Buffer Timeout */ 
#define SDRAM_SET_WBTIMEOUT(n)  ((n)&_BITMASK(16))

/* Macro pointing to SDRAM registers */
#define SDRAM   ((SDRC_REGS_TYPE *)(SDRAM_REGS_BASE))

#endif /* LH79520_SDRC_H */ 
