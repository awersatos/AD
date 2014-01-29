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
// Simulation Library File for ORCA2A
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/AGEB4.v,v 1.2 2005/05/19 18:26:18 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps
`celldefine

/* Created by DB2VERILOG Version 1.3.0.3 on Tue Jan 23 15:05:37 1996 */
/* module compiled from "lsl2db 4.1.3" run */

module AGEB4 (A0, A1, A2, A3, B0, B1, B2, B3, CI, 
       GE);
input  A0, A1, A2, A3, B0, B1, B2, B3, CI;
output GE;
AND2 INST1 (.A(CI), .B(I9), .Z(I3));
AND2 INST2 (.A(A0), .B(CI), .Z(I4));
OR3 INST3 (.A(I3), .B(I4), .C(I5), .Z(I6));
NOT INST4 (.A(B0), .Z(I9));
AND2 INST5 (.A(I9), .B(A0), .Z(I5));
OR3 INST6 (.A(I32), .B(I31), .C(I30), .Z(I29));
AND2 INST7 (.A(A1), .B(I6), .Z(I31));
AND2 INST8 (.A(I6), .B(I22), .Z(I32));
AND2 INST9 (.A(I22), .B(A1), .Z(I30));
NOT INST10 (.A(B1), .Z(I22));
OR3 INST11 (.A(I47), .B(I46), .C(I45), .Z(I44));
AND2 INST12 (.A(A2), .B(I29), .Z(I46));
AND2 INST13 (.A(I29), .B(I37), .Z(I47));
AND2 INST14 (.A(I37), .B(A2), .Z(I45));
NOT INST15 (.A(B2), .Z(I37));
OR3 INST16 (.A(I62), .B(I61), .C(I60), .Z(GE));
AND2 INST17 (.A(A3), .B(I44), .Z(I61));
AND2 INST18 (.A(I44), .B(I52), .Z(I62));
AND2 INST19 (.A(I52), .B(A3), .Z(I60));
NOT INST20 (.A(B3), .Z(I52));

endmodule
`endcelldefine
