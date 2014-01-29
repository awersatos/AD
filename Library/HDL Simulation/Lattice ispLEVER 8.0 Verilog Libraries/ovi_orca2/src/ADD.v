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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/ADD.v,v 1.2 2005/05/19 18:05:09 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri May 13 14:53:49 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module ADD (A, B, CI, CO, S);
input  A, B, CI;
output CO, S;
AND2 INST10 (.A(CI), .B(B), .Z(I3));
AND2 INST11 (.A(A), .B(CI), .Z(I4));
OR3 INST12 (.A(I3), .B(I4), .C(I5), .Z(CO));
XOR3 INST13 (.A(A), .B(B), .C(CI), .Z(S));
AND2 INST2 (.A(B), .B(A), .Z(I5));

endmodule
`endcelldefine
