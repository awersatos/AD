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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/COMP4.v,v 1.2 2005/05/19 18:05:31 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri May 13 16:31:57 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module COMP4 (A0, A1, A2, A3, B0, B1, B2, B3, EQ);
input  A0, A1, A2, A3, B0, B1, B2, B3;
output EQ;
XNOR2 INST12 (.A(A2), .B(B2), .Z(I15));
XNOR2 INST13 (.A(A3), .B(B3), .Z(I14));
XNOR2 INST2 (.A(A1), .B(B1), .Z(I10));
AND4 INST26 (.A(I9), .B(I10), .C(I15), .D(I14), .Z(EQ));
XNOR2 INST3 (.A(A0), .B(B0), .Z(I9));

endmodule
`endcelldefine
