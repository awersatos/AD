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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/CU4P3JX_GSR.v,v 1.5 2005/05/19 18:29:34 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue May 17 11:44:42 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module CU4P3JX_GSR (CI, SP, CK, PD, GSR, PUR, CO, Q0, Q1, Q2, Q3);
  parameter DISABLED_GSR = 0;
  input  CI, SP, CK, PD, GSR, PUR;
  output CO, Q0, Q1, Q2, Q3;
  reg n;
  reg SR;

and INST11 (I6, Q0, CII);
xor INST13 (I7, Q0, CII);
and INST24 (I18, Q1, I6);
xor INST26 (I19, Q1, I6);
and INST37 (I31, Q2, I18);
xor INST39 (I32, Q2, I18);
and INST50 (CO, Q3, I31);
xor INST52 (I45, Q3, I31);
//---- Programmable GSR ----

  always @ (GSR or PUR) begin
    if (DISABLED_GSR == 0) begin
      SR = GSR && PUR;
    end
    else if (DISABLED_GSR == 1)
      SR = PUR;
  end
//--------------------------

FD1P3JZ_FUNC  INST68 (.D(I7), .SP(SP), .CK(CK), .PD(PD), .notifier(n), .SR(SR), .Q(Q0));
FD1P3JZ_FUNC  INST69 (.D(I19), .SP(SP), .CK(CK), .PD(PD), .notifier(n), .SR(SR), .Q(Q1));
FD1P3JZ_FUNC  INST70 (.D(I32), .SP(SP), .CK(CK), .PD(PD), .notifier(n), .SR(SR), .Q(Q2));
FD1P3JZ_FUNC  INST71 (.D(I45), .SP(SP), .CK(CK), .PD(PD), .notifier(n), .SR(SR), .Q(Q3));
FD1P3JZ_FUNC  INST999 (.D(CI), .SP(SP), .CK(CK), .PD(PD), .notifier(), .SR(), .Q());
DELAY  INST990 (.A(CI), .Z(CII));


// For timing checks
not (PDN, PD);
and (GSR_PD, PDN, GSR);
and (PD_SP_CI_GSR, SP, PDN, CI, GSR);
and (GSR_CI_PD, PDN, CI, GSR);
and (GSR_CI, CI, GSR);


endmodule
`endcelldefine
