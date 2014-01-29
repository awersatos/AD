// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/SBR1024X18.v,v 1.3 2005/05/19 19:02:14 pradeep Exp $ 
//
`timescale 1 ns / 1 ps

`celldefine

module SBR1024X18  (AW0, AW1, AW2, AW3, AW4, AW5, AW6, AW7, AW8, AW9,
                    AR0, AR1, AR2, AR3, AR4, AR5, AR6, AR7, AR8, AR9,
                    D0, D1, D2, D3, D4, D5, D6, D7, D8,
                    D9, D10, D11, D12, D13, D14, D15, D16, D17,
                    BW0, BW1, CKW, CKR, CSW, CSR,
                    SQ0, SQ1, SQ2, SQ3, SQ4, SQ5, SQ6, SQ7, SQ8,
                    SQ9, SQ10, SQ11, SQ12, SQ13, SQ14, SQ15, SQ16, SQ17, SBUSY,
                    Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8,
                    Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, BUSY,
                    SAW0, SAW1, SAW2, SAW3, SAW4, SAW5, SAW6, SAW7, SAW8, SAW9,
                    SAR0, SAR1, SAR2, SAR3, SAR4, SAR5, SAR6, SAR7, SAR8, SAR9,
                    SD0, SD1, SD2, SD3, SD4, SD5, SD6, SD7, SD8,
                    SD9, SD10, SD11, SD12, SD13, SD14, SD15, SD16, SD17,
                    SBW0, SBW1, SCKW, SCKR, SCSW, SCSR,
                    MC0, MC1, ARBITER);

// PARAMETERS
parameter BRAMMODE = "NOREG";
parameter ARBITERMODE = "FALSE";

input AW0, AW1, AW2, AW3, AW4, AW5, AW6, AW7, AW8, AW9;
input AR0, AR1, AR2, AR3, AR4, AR5, AR6, AR7, AR8, AR9;
input D0, D1, D2, D3, D4, D5, D6, D7, D8;
input D9, D10, D11, D12, D13, D14, D15, D16, D17;
input BW0, BW1, CKW, CKR, CSW, CSR;
input SQ0, SQ1, SQ2, SQ3, SQ4, SQ5, SQ6, SQ7, SQ8;
input SQ9, SQ10, SQ11, SQ12, SQ13, SQ14, SQ15, SQ16, SQ17, SBUSY;

output Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8;
output Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17, BUSY;
output SAW0, SAW1, SAW2, SAW3, SAW4, SAW5, SAW6, SAW7, SAW8, SAW9;
output SAR0, SAR1, SAR2, SAR3, SAR4, SAR5, SAR6, SAR7, SAR8, SAR9;
output SD0, SD1, SD2, SD3, SD4, SD5, SD6, SD7, SD8;
output SD9, SD10, SD11, SD12, SD13, SD14, SD15, SD16, SD17;
output SBW0, SBW1, SCKW, SCKR, SCSW, SCSR;
output MC0, MC1, ARBITER;

reg MC0, MC1, ARBITER;
wire ram_mode;
wire arb_mode;
wire wait_mode;

assign ram_mode = BRAMMODE;
assign arb_mode = ARBITERMODE;
 
  buf (Q0, SQ0);
  buf (Q1, SQ1);
  buf (Q2, SQ2);
  buf (Q3, SQ3);
  buf (Q4, SQ4);
  buf (Q5, SQ5);
  buf (Q6, SQ6);
  buf (Q7, SQ7);
  buf (Q8, SQ8);
  buf (Q9, SQ9);
  buf (Q10, SQ10);
  buf (Q11, SQ11);
  buf (Q12, SQ12);
  buf (Q13, SQ13);
  buf (Q14, SQ14);
  buf (Q15, SQ15);
  buf (Q16, SQ16);
  buf (Q17, SQ17);
  buf (BUSY, SBUSY);
  buf (SAW0, AW0);
  buf (SAW1, AW1);
  buf (SAW2, AW2);
  buf (SAW3, AW3);
  buf (SAW4, AW4);
  buf (SAW5, AW5);
  buf (SAW6, AW6);
  buf (SAW7, AW7);
  buf (SAW8, AW8);
  buf (SAW9, AW9);
  buf (SAR0, AR0);
  buf (SAR1, AR1);
  buf (SAR2, AR2);
  buf (SAR3, AR3);
  buf (SAR4, AR4);
  buf (SAR5, AR5);
  buf (SAR6, AR6);
  buf (SAR7, AR7);
  buf (SAR8, AR8);
  buf (SAR9, AR9);
  buf (SD0, D0);
  buf (SD1, D1);
  buf (SD2, D2);
  buf (SD3, D3);
  buf (SD4, D4);
  buf (SD5, D5);
  buf (SD6, D6);
  buf (SD7, D7);
  buf (SD8, D8);
  buf (SD9, D9);
  buf (SD10, D10);
  buf (SD11, D11);
  buf (SD12, D12);
  buf (SD13, D13);
  buf (SD14, D14);
  buf (SD15, D15);
  buf (SD16, D16);
  buf (SD17, D17);
  buf (SBW0, BW0);
  buf (SBW1, BW1);
  buf (SCKW, CKW);
  buf (SCKR, CKR);
  buf (SCSW, CSW);
  buf (SCSR, CSR);

  always @(ram_mode)
  begin
     if (BRAMMODE == "NOREG")
     begin
        MC0 = 1'b0;
        MC1 = 1'b0;
     end
     else if (BRAMMODE == "INREG")
     begin
        MC0 = 1'b1;
        MC1 = 1'b0;
     end
     else if (BRAMMODE == "OUTREG")
     begin
        MC0 = 1'b0;
        MC1 = 1'b1;
     end
     else if (BRAMMODE == "IOREG")
     begin
        MC0 = 1'b1;
        MC1 = 1'b1;
     end
  end

  always @(arb_mode)
  begin
     if (ARBITERMODE == "TRUE")
     begin
        ARBITER = 1'b1;
     end
     else if (ARBITERMODE == "FALSE")
     begin
        ARBITER = 1'b0;
     end
  end

endmodule

`endcelldefine

