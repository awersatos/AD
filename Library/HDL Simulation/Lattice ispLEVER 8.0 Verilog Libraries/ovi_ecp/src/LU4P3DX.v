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
// Simulation Library File for SC
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/LU4P3DX.v,v 1.5 2005/05/19 19:06:49 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module LU4P3DX (D0, D1, D2, D3, CI, SP, CK, SD, CD, CO, Q0, Q1, Q2, Q3);
  parameter GSR = "ENABLED";
input  D0, D1, D2, D3, CI, SP, CK, SD, CD;
output CO, Q0, Q1, Q2, Q3;

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  reg n1;
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

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SR = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SR = PUR_sig;
  end
//--------------------------

FL1P3DX_FUNC  INST68 (.D0(I7), .D1(D0), .SP(SP), .CK(CK), .SD(SD), .CD(CD), .SR(SR), .notifier(n1), .Q(Q0));
FL1P3DX_FUNC  INST69 (.D0(I19), .D1(D1), .SP(SP), .CK(CK), .SD(SD), .CD(CD), .SR(SR), .notifier(n1), .Q(Q1));
FL1P3DX_FUNC  INST70 (.D0(I32), .D1(D2), .SP(SP), .CK(CK), .SD(SD), .CD(CD), .SR(SR), .notifier(n1), .Q(Q2));
FL1P3DX_FUNC  INST71 (.D0(I45), .D1(D3), .SP(SP), .CK(CK), .SD(SD), .CD(CD), .SR(SR), .notifier(n1), .Q(Q3));
buf  (CII, CI);

// For timing checks
and (SD_SP_CI_GSR, SP, SD, CI, GSR);
and (GSR_CI_SD, SD, CI, GSR);
and (GSR_CI, CI, GSR);

endmodule

`endcelldefine
