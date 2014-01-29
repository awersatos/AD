
// ------------------------------------------------------------------------------------------
//   SFR Port expansions
// ------------------------------------------------------------------------------------------

#define SFR_PORT0 (*(__bsfr volatile unsigned char *) 0x86 )   // I/O Port on SFR bus @ 0x86
#define SFR_PORT1 (*(__bsfr volatile unsigned char *) 0x8E )   // I/O Port on SFR bus @ 0x8E
#define SFR_PORT2 (*(__bsfr volatile unsigned char *) 0x96 )   // I/O Port on SFR bus @ 0x96
#define SFR_PORT3 (*(__bsfr volatile unsigned char *) 0x9E )   // I/O Port on SFR bus @ 0x9E
#define SFR_PORT4 (*(__bsfr volatile unsigned char *) 0xA6 )   // I/O Port on SFR bus @ 0xA6
#define SFR_PORT5 (*(__bsfr volatile unsigned char *) 0xAE )   // I/O Port on SFR bus @ 0xAE
#define SFR_PORT6 (*(__bsfr volatile unsigned char *) 0xB6 )   // I/O Port on SFR bus @ 0xB6
#define SFR_PORT7 (*(__bsfr volatile unsigned char *) 0xBE )   // I/O Port on SFR bus @ 0xBE
#define SFR_PORT8 (*(__bsfr volatile unsigned char *) 0xC6 )   // I/O Port on SFR bus @ 0xC6
#define SFR_PORT9 (*(__bsfr volatile unsigned char *) 0xCE )   // I/O Port on SFR bus @ 0xCE

#define LED_PORT      SFR_PORT0        // output port for LEDs
#define DIP_PORT      SFR_PORT0        // input port for DIP-Switches 
#define AXIS_PORT     SFR_PORT1        // port for the AXIS selector
#define U1H0_PORT     SFR_PORT2        // Port for lowest byte  of User I/O port
#define U1H1_PORT     SFR_PORT3        // Port for middle byte  of User I/O Port
#define U1H2_PORT     SFR_PORT4        // Port for top two bits of User I/O Port
#define KEY_PORT      SFR_PORT5        // port for Test Button
