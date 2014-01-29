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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FADSU4O.v,v 1.2 2005/05/19 18:05:36 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Mon Aug 29 09:55:01 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module FADSU4O (A0, A1, A2, A3, B0, B1, B2, B3, BCI, 
       CON, OFL, S0, S1, S2, S3);
input  A0, A1, A2, A3, B0, B1, B2, B3, BCI, CON;
output OFL, S0, S1, S2, S3;
AND2 INST10 (.A(BCI), .B(I9), .Z(I3));
AND2 INST11 (.A(A0), .B(BCI), .Z(I4));
OR3 INST12 (.A(I3), .B(I4), .C(I5), .Z(I6));
XOR3 INST13 (.A(A0), .B(I9), .C(BCI), .Z(S0));
XNOR2 INST14 (.A(CON), .B(B0), .Z(I9));
AND2 INST2 (.A(I9), .B(A0), .Z(I5));
AND2 INST30 (.A(I23), .B(A1), .Z(I27));
AND2 INST31 (.A(I6), .B(I23), .Z(I25));
AND2 INST32 (.A(A1), .B(I6), .Z(I26));
OR3 INST33 (.A(I25), .B(I26), .C(I27), .Z(I28));
XOR3 INST34 (.A(A1), .B(I23), .C(I6), .Z(S1));
XNOR2 INST35 (.A(CON), .B(B1), .Z(I23));
AND2 INST46 (.A(I39), .B(A2), .Z(I43));
AND2 INST47 (.A(I28), .B(I39), .Z(I41));
AND2 INST48 (.A(A2), .B(I28), .Z(I42));
OR3 INST49 (.A(I41), .B(I42), .C(I43), .Z(I44));
XOR3 INST50 (.A(A2), .B(I39), .C(I28), .Z(S2));
XNOR2 INST51 (.A(CON), .B(B2), .Z(I39));
AND2 INST62 (.A(I55), .B(A3), .Z(I59));
AND2 INST63 (.A(I44), .B(I55), .Z(I57));
AND2 INST64 (.A(A3), .B(I44), .Z(I58));
OR3 INST65 (.A(I57), .B(I58), .C(I59), .Z(BCO));
XOR3 INST66 (.A(A3), .B(I55), .C(I44), .Z(S3));
XNOR2 INST67 (.A(CON), .B(B3), .Z(I55));
XOR2 INST68 (.A(I44), .B(BCO), .Z(OFL));

endmodule

