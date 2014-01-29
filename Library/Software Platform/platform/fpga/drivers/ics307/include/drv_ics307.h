/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        ICS307 peripheral device driver interface.
|*
|*****************************************************************************/

/**
 * @file
 * Driver for ICS307-02 SERIALLY PROGRAMMABLE CLOCK SOURCE.
 */

#ifndef DRV_ICS307_H_
#define DRV_ICS307_H_

#ifdef  __cplusplus
extern "C" {
#endif

typedef struct _ics307_t ics307_t;

//..............................................................................
// Bit Masks for CLK1 output divider Setting  S[0..2]
#define ICS307_OD_10   0x00   // BitMask for CLK1 Output Divide by 10
#define ICS307_OD_2    0x01   // BitMask for CLK1 Output Divide by 2
#define ICS307_OD_8    0x02   // BitMask for CLK1 Output Divide by 8
#define ICS307_OD_4    0x03   // BitMask for CLK1 Output Divide by 4 (default)
#define ICS307_OD_5    0x04   // BitMask for CLK1 Output Divide by 5
#define ICS307_OD_7    0x05   // BitMask for CLK1 Output Divide by 7
#define ICS307_OD_3    0x06   // BitMask for CLK1 Output Divide by 3
#define ICS307_OD_6    0x07   // BitMask for CLK1 Output Divide by 6
//..............................................................................

//..............................................................................
// Bit Masks for Clock 2 Output MUX bits (F[0..1])
#define ICS307_CLK2_REF        0x00  // Clk2 output = REF    (default)
#define ICS307_CLK2_REF_DIV2   0x08  // Clk2 output = REF/2
#define ICS307_CLK2_OFF        0x10  // Clk2 output = 0
#define ICS307_CLK2_CLK1_DIV2  0x18  // Clk2 output = CLK1/2
//..............................................................................

//..............................................................................
// Bit Masks for TTL Bit (Output Duty Cycle Configuration)
#define ICS307_TTL_5V          0x00  // optimised Dyty Cycle for VDD = 5V
#define ICS307_TTL_3V3         0x20  // optimised Dyty Cycle for VDD = 3.3V (default)
//..............................................................................

//..............................................................................
// Bit Mask for internal Crystal Load Capacitance
#define ICS307_XTAL_LOAD_0     0x00  // Lowest Range (default)
#define ICS307_XTAL_LOAD_1     0x40  // ...
#define ICS307_XTAL_LOAD_2     0x80  // ...
#define ICS307_XTAL_LOAD_3     0xC0  // Highest Range
//..............................................................................

//..............................................................................
#define ICS307_Default_Config  (ICS307_XTAL_LOAD_0 | ICS307_TTL_3V3 | ICS307_CLK2_REF | ICS307_OD_4)
#define ICS307_Default_VCO_DIV 8    // default VCO divider
#define ICS307_Default_REF_DIV 6    // default Reference divider
//..............................................................................

//..............................................................................
// Programs the ICS307 to generate a new output frequency
// Output Frequency for CLK1 = Fref * 2 * (VDW + 8) / ((RDW + 2) * OD)
// Parameters:
//   Config: Configuration word :
//
//         MSB                                 LSB
//        +----+----+-----+----+----+----+----+----+
//        | C1   C0 | TTL | F1   F0 | S2   S1   S0 |
//        +----+----+--+--+--+-+-+--+-+--+----+--+-+
//           |   |     |     |   |    |          |
//           +-+-+     |     +-+-+    +-----+----+
//             |       |       |            |
//        Crystal    Output  CLK2      Output Divide
//        Load       Duty    Output
//        Impedance  Cycle   Select
//
//  vdw    : VCO Divider Word  (9 significant bits)
//  rdw    : Reference Divider Word  (7 significant bits)
//
extern int drv_ics307_program(ics307_t *drv, unsigned char config, unsigned int vdw, unsigned char rdw);

// determines values for od, vdw an rdw for the specified freq (in Herz)
// the code assumes 20 MHz crystal
// returns:
//      1 when for exact match of frequency
//      0 for when nearest frequency when closs
//      -1 fo incorrect value for freq (allowed range 6 - 200 MHz)
extern int drv_ics307_best_match(unsigned int freq, unsigned int *pod, unsigned int *pvdw, unsigned int *prdw);


//..............................................................................
// Programs command word 'data' into the clock generator chip
extern int drv_ics307_program_word(ics307_t *drv, unsigned int data);
// Program the device with closes match for frequency
extern int drv_ics307_program_freq_mhz(ics307_t *drv, int freq);

// return the last witten value, note that the programmed value
// can not be read from the device
// returns 0 when last written value is stored at *data
//      -1 when o programmed value is not known
extern int drv_ics307_read_word(ics307_t *drv, unsigned int *data);


//..............................................................................
// Open the specified ics307 device
extern ics307_t *drv_ics307_open(int id);

//..............................................................................

#ifdef  __cplusplus
}
#endif

#endif /* ndef DRV_ICS307_H_ */

