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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/OAI32.v,v 1.2 2005/05/19 18:06:14 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.2 on Fri Aug  5 11:15:22 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module OAI32 (A1, A2, A3, B1, B2, Z);
input  A1, A2, A3, B1, B2;
output Z;
OR2 INST11 (.A(B1), .B(B2), .Z(I7));
ND2 INST6 (.A(I9), .B(I7), .Z(Z));
OR3 INST8 (.A(A1), .B(A2), .C(A3), .Z(I9));

endmodule

