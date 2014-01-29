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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/LD4P3AX_GSR.v,v 1.2 2005/05/19 19:01:43 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue May 17 12:07:01 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module LD4P3AX_GSR (D0, D1, D2, D3, CI, SP, CK, SD, GSR, PUR, CO, Q0, Q1, Q2, Q3);
  parameter DISABLED_GSR = 0;
  input  D0, D1, D2, D3, CI, SP, CK, SD, GSR, PUR;
  output CO, Q0, Q1, Q2, Q3;
  reg n1, n2, n3, n4;
  reg SR;

and INST11 (I4, Q0, CII);
or INST12 (I6, CII, I4, Q0);
xnor INST13 (I7, Q0, CII);
and INST24 (I16, Q1, I6);
or INST25 (I18, I6, I16, Q1);
xnor INST26 (I19, Q1, I6);
and INST37 (I29, Q2, I18);
or INST38 (I31, I18, I29, Q2);
xnor INST39 (I32, Q2, I18);
and INST50 (I42, Q3, I31);
or INST51 (CO, I31, I42, Q3);
xnor INST52 (I45, Q3, I31);
//---- Programmable GSR ----

  always @ (GSR or PUR) begin
    if (DISABLED_GSR == 0) begin
      SR = GSR && PUR;
    end
    else if (DISABLED_GSR == 1)
      SR = PUR;
  end
//--------------------------

FL1P3AZ_FUNC  INST68 (.D0(I7), .D1(D0), .SP(SP), .CK(CK), .SD(SD), .SR(SR), .notifier(n1), .Q(Q0));
FL1P3AZ_FUNC  INST69 (.D0(I19), .D1(D1), .SP(SP), .CK(CK), .SD(SD), .SR(SR), .notifier(n2), .Q(Q1));
FL1P3AZ_FUNC  INST70 (.D0(I32), .D1(D2), .SP(SP), .CK(CK), .SD(SD), .SR(SR), .notifier(n3), .Q(Q2));
FL1P3AZ_FUNC  INST71 (.D0(I45), .D1(D3), .SP(SP), .CK(CK), .SD(SD), .SR(SR), .notifier(n4), .Q(Q3));
FD1P3AX_FUNC  INST999 (.D(CI), .SP(SP), .CK(CK), .SR(), .Q());
DELAY  INST990 (.A(CI), .Z(CII));


// For timing checks
and (SD_SP_CI_GSR, SP, SD, CI, GSR);
and (GSR_SP, SP, GSR);
and (GSR_CI, CI, GSR);
not (CIN, CI);

endmodule
`endcelldefine
