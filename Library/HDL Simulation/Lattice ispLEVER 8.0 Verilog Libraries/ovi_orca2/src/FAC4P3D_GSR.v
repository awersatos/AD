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
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FAC4P3D_GSR.v,v 1.2 2005/05/19 18:05:35 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Mon Sep 12 16:50:36 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module FAC4P3D_GSR (A0, A1, A2, A3, CI, SP, CK, CD, 
       GSR, CO, Q0, Q1, Q2, Q3);
input  A0, A1, A2, A3, CI, SP, CK, CD, GSR;
output CO, Q0, Q1, Q2, Q3;
AND2 INST10 (.A(CI), .B(Q0), .Z(I3));
AND2 INST11 (.A(A0), .B(CI), .Z(I4));
OR3 INST12 (.A(I3), .B(I4), .C(I5), .Z(I6));
XOR3 INST13 (.A(A0), .B(Q0), .C(CI), .Z(I7));
AND2 INST2 (.A(Q0), .B(A0), .Z(I5));
AND2 INST22 (.A(Q1), .B(A1), .Z(I17));
AND2 INST23 (.A(I6), .B(Q1), .Z(I15));
AND2 INST24 (.A(A1), .B(I6), .Z(I16));
OR3 INST25 (.A(I15), .B(I16), .C(I17), .Z(I18));
XOR3 INST26 (.A(A1), .B(Q1), .C(I6), .Z(I19));
AND2 INST35 (.A(Q2), .B(A2), .Z(I30));
AND2 INST36 (.A(I18), .B(Q2), .Z(I28));
AND2 INST37 (.A(A2), .B(I18), .Z(I29));
OR3 INST38 (.A(I28), .B(I29), .C(I30), .Z(I31));
XOR3 INST39 (.A(A2), .B(Q2), .C(I18), .Z(I32));
AND2 INST48 (.A(Q3), .B(A3), .Z(I43));
AND2 INST49 (.A(I31), .B(Q3), .Z(I41));
AND2 INST50 (.A(A3), .B(I31), .Z(I42));
OR3 INST51 (.A(I41), .B(I42), .C(I43), .Z(CO));
XOR3 INST52 (.A(A3), .B(Q3), .C(I31), .Z(I45));
OR2 \INST68.INST33 (.A(\INST68.I36 ), .B(\INST68.I38 ),
      .Z(\INST68.I50 ));
AND2 \INST68.INST34 (.A(Q3), .B(\INST68.I54 ), .Z(
      \INST68.I36 ));
AND2 \INST68.INST35 (.A(SP), .B(I45), .Z(\INST68.I38 ));
NOT \INST68.INST52 (.A(SP), .Z(\INST68.I54 ));
OR2 \INST68.INST59 (.A(\INST68.CDI ), .B(\INST68.I67 ),
      .Z(\INST68.I57 ));
UDFDL5 \INST68.INST6 (.D(\INST68.I50 ), .CK(CK), .CLR(
      \INST68.I57 ), .Q(Q3), .QN(\INST68.QN ));
NOT \INST68.INST65 (.A(GSR), .Z(\INST68.I67 ));
BUF \INST68.INST997 (.A(CD), .Z(\INST68.CDI ));
OR2 \INST69.INST33 (.A(\INST69.I36 ), .B(\INST69.I38 ),
      .Z(\INST69.I50 ));
AND2 \INST69.INST34 (.A(Q2), .B(\INST69.I54 ), .Z(
      \INST69.I36 ));
AND2 \INST69.INST35 (.A(SP), .B(I32), .Z(\INST69.I38 ));
NOT \INST69.INST52 (.A(SP), .Z(\INST69.I54 ));
OR2 \INST69.INST59 (.A(\INST69.CDI ), .B(\INST69.I67 ),
      .Z(\INST69.I57 ));
UDFDL5 \INST69.INST6 (.D(\INST69.I50 ), .CK(CK), .CLR(
      \INST69.I57 ), .Q(Q2), .QN(\INST69.QN ));
NOT \INST69.INST65 (.A(GSR), .Z(\INST69.I67 ));
BUF \INST69.INST997 (.A(CD), .Z(\INST69.CDI ));
OR2 \INST70.INST33 (.A(\INST70.I36 ), .B(\INST70.I38 ),
      .Z(\INST70.I50 ));
AND2 \INST70.INST34 (.A(Q1), .B(\INST70.I54 ), .Z(
      \INST70.I36 ));
AND2 \INST70.INST35 (.A(SP), .B(I19), .Z(\INST70.I38 ));
NOT \INST70.INST52 (.A(SP), .Z(\INST70.I54 ));
OR2 \INST70.INST59 (.A(\INST70.CDI ), .B(\INST70.I67 ),
      .Z(\INST70.I57 ));
UDFDL5 \INST70.INST6 (.D(\INST70.I50 ), .CK(CK), .CLR(
      \INST70.I57 ), .Q(Q1), .QN(\INST70.QN ));
NOT \INST70.INST65 (.A(GSR), .Z(\INST70.I67 ));
BUF \INST70.INST997 (.A(CD), .Z(\INST70.CDI ));
OR2 \INST71.INST33 (.A(\INST71.I36 ), .B(\INST71.I38 ),
      .Z(\INST71.I50 ));
AND2 \INST71.INST34 (.A(Q0), .B(\INST71.I54 ), .Z(
      \INST71.I36 ));
AND2 \INST71.INST35 (.A(SP), .B(I7), .Z(\INST71.I38 ));
NOT \INST71.INST52 (.A(SP), .Z(\INST71.I54 ));
OR2 \INST71.INST59 (.A(\INST71.CDI ), .B(\INST71.I67 ),
      .Z(\INST71.I57 ));
UDFDL5 \INST71.INST6 (.D(\INST71.I50 ), .CK(CK), .CLR(
      \INST71.I57 ), .Q(Q0), .QN(\INST71.QN ));
NOT \INST71.INST65 (.A(GSR), .Z(\INST71.I67 ));
BUF \INST71.INST997 (.A(CD), .Z(\INST71.CDI ));

endmodule

