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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FSUB4O.v,v 1.2 2005/05/19 18:05:53 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Mon Aug 29 09:54:21 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module FSUB4O (A0, A1, A2, A3, B0, B1, B2, B3, BI, 
       OFL, S0, S1, S2, S3);
input  A0, A1, A2, A3, B0, B1, B2, B3, BI;
output OFL, S0, S1, S2, S3;
AND2 INST10 (.A(BI), .B(I9), .Z(I3));
AND2 INST11 (.A(A0), .B(BI), .Z(I4));
OR3 INST12 (.A(I3), .B(I4), .C(I5), .Z(I6));
XOR3 INST13 (.A(A0), .B(I9), .C(BI), .Z(S0));
NOT INST19 (.A(B0), .Z(I9));
AND2 INST2 (.A(I9), .B(A0), .Z(I5));
XOR3 INST23 (.A(A1), .B(I22), .C(I6), .Z(S1));
OR3 INST24 (.A(I32), .B(I31), .C(I30), .Z(I29));
AND2 INST25 (.A(A1), .B(I6), .Z(I31));
AND2 INST26 (.A(I6), .B(I22), .Z(I32));
AND2 INST27 (.A(I22), .B(A1), .Z(I30));
NOT INST35 (.A(B1), .Z(I22));
XOR3 INST38 (.A(A2), .B(I37), .C(I29), .Z(S2));
OR3 INST39 (.A(I47), .B(I46), .C(I45), .Z(I44));
AND2 INST40 (.A(A2), .B(I29), .Z(I46));
AND2 INST41 (.A(I29), .B(I37), .Z(I47));
AND2 INST42 (.A(I37), .B(A2), .Z(I45));
NOT INST50 (.A(B2), .Z(I37));
XOR3 INST53 (.A(A3), .B(I52), .C(I44), .Z(S3));
OR3 INST54 (.A(I62), .B(I61), .C(I60), .Z(BO));
AND2 INST55 (.A(A3), .B(I44), .Z(I61));
AND2 INST56 (.A(I44), .B(I52), .Z(I62));
AND2 INST57 (.A(I52), .B(A3), .Z(I60));
NOT INST65 (.A(B3), .Z(I52));
XOR2 INST66 (.A(I44), .B(BO), .Z(OFL));

endmodule

