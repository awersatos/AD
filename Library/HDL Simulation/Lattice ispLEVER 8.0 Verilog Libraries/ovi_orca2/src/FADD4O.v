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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FADD4O.v,v 1.2 2005/05/19 18:05:36 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Mon Aug 29 09:53:43 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module FADD4O (A0, A1, A2, A3, B0, B1, B2, B3, CI, 
       OFL, S0, S1, S2, S3);
input  A0, A1, A2, A3, B0, B1, B2, B3, CI;
output OFL, S0, S1, S2, S3;
AND2 INST10 (.A(CI), .B(B0), .Z(I3));
AND2 INST11 (.A(A0), .B(CI), .Z(I4));
OR3 INST12 (.A(I3), .B(I4), .C(I5), .Z(I6));
XOR3 INST13 (.A(A0), .B(B0), .C(CI), .Z(S0));
AND2 INST2 (.A(B0), .B(A0), .Z(I5));
AND2 INST22 (.A(B1), .B(A1), .Z(I17));
AND2 INST23 (.A(I6), .B(B1), .Z(I15));
AND2 INST24 (.A(A1), .B(I6), .Z(I16));
OR3 INST25 (.A(I15), .B(I16), .C(I17), .Z(I18));
XOR3 INST26 (.A(A1), .B(B1), .C(I6), .Z(S1));
AND2 INST35 (.A(B2), .B(A2), .Z(I30));
AND2 INST36 (.A(I18), .B(B2), .Z(I28));
AND2 INST37 (.A(A2), .B(I18), .Z(I29));
OR3 INST38 (.A(I28), .B(I29), .C(I30), .Z(I31));
XOR3 INST39 (.A(A2), .B(B2), .C(I18), .Z(S2));
AND2 INST48 (.A(B3), .B(A3), .Z(I43));
AND2 INST49 (.A(I31), .B(B3), .Z(I41));
AND2 INST50 (.A(A3), .B(I31), .Z(I42));
OR3 INST51 (.A(I41), .B(I42), .C(I43), .Z(CO));
XOR3 INST52 (.A(A3), .B(B3), .C(I31), .Z(S3));
XOR2 INST53 (.A(I31), .B(CO), .Z(OFL));

endmodule

