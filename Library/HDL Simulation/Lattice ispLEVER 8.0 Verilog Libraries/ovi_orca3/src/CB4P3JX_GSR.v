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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/CB4P3JX_GSR.v,v 1.6 2005/05/19 18:29:21 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue May 17 11:32:30 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module CB4P3JX_GSR (CI, SP, CK, PD, CON, GSR, PUR, CO, Q0, Q1, Q2, Q3);
  parameter DISABLED_GSR = 0;
  input  CI, SP, CK, PD, CON, GSR, PUR;
  output CO, Q0, Q1, Q2, Q3;
  reg n;
  reg SR;

and INST10 (I3, CII, CONN);
and INST11 (I4, Q0, CII);
or INST12 (I6, I3, I4, I5);
xor INST13 (I7, Q0, CONN, CII);
and INST2 (I5, CONN, Q0);
and INST22 (I17, CONN, Q1);
and INST23 (I15, I6, CONN);
and INST24 (I16, Q1, I6);
or INST25 (I18, I15, I16, I17);
xor INST26 (I19, Q1, CONN, I6);
and INST35 (I30, CONN, Q2);
and INST36 (I28, I18, CONN);
and INST37 (I29, Q2, I18);
or INST38 (I31, I28, I29, I30);
xor INST39 (I32, Q2, CONN, I18);
and INST48 (I43, CONN, Q3);
and INST49 (I41, I31, CONN);
and INST50 (I42, Q3, I31);
or INST51 (CO, I41, I42, I43);
xor INST52 (I45, Q3, CONN, I31);
not INST96 (CONN, CONI);
//---- Programmable GSR ----

  always @ (GSR or PUR) begin
    if (DISABLED_GSR == 0) begin
      SR = GSR && PUR;
    end
    else if (DISABLED_GSR == 1)
      SR = PUR;
  end
//--------------------------

FD1P3JZ_FUNC  INST68 (.D(I7), .SP(SP), .CK(CK), .PD(PD), .SR(SR), .notifier(n), .Q(Q0));
FD1P3JZ_FUNC  INST69 (.D(I19), .SP(SP), .CK(CK), .PD(PD), .SR(SR), .notifier(n), .Q(Q1));
FD1P3JZ_FUNC  INST70 (.D(I32), .SP(SP), .CK(CK), .PD(PD), .SR(SR), .notifier(n), .Q(Q2));
FD1P3JZ_FUNC  INST71 (.D(I45), .SP(SP), .CK(CK), .PD(PD), .SR(SR), .notifier(n), .Q(Q3));
FD1P3JZ_FUNC  INST999 (.D(CI), .SP(SP), .CK(CK), .PD(PD), .SR(), .notifier(), .Q());
FD1P3JZ_FUNC  INST998 (.D(CON), .SP(SP), .CK(CK), .PD(PD), .SR(), .notifier(), .Q());
DELAY  INST990 (.A(CI), .Z(CII));
DELAY  INST991 (.A(CON), .Z(CONI));


// For timing checks
not (PDN, PD);
and (GSR_PD, PDN, GSR);
and (GSR_SP, SP, GSR);
xor (CI_PD, CI, PD);



endmodule 
`endcelldefine
