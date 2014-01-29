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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/LTGT.v,v 1.2 2005/05/19 18:06:00 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue May 17 12:24:43 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module LTGT (A0, A1, B0, B1, GT, LT);
input  A0, A1, B0, B1;
output GT, LT;
OR2 INST1 (.A(I19), .B(I20), .Z(GT));
NOT INST10 (.A(B0), .Z(I26));
NOT INST11 (.A(B1), .Z(I25));
AND2 INST12 (.A(A1), .B(I25), .Z(I19));
XNOR2 INST13 (.A(A1), .B(B1), .Z(I17));
XNOR2 INST14 (.A(A1), .B(B1), .Z(I16));
OR2 INST2 (.A(I23), .B(I24), .Z(LT));
NOT INST5 (.A(A1), .Z(I27));
NOT INST6 (.A(A0), .Z(I28));
AND3 INST7 (.A(I16), .B(I28), .C(B0), .Z(I24));
AND2 INST8 (.A(I27), .B(B1), .Z(I23));
AND3 INST9 (.A(I17), .B(A0), .C(I26), .Z(I20));

endmodule
`endcelldefine
