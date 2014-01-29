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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/OAI42.v,v 1.2 2005/05/19 18:06:15 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.2 on Fri Aug  5 11:15:45 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module OAI42 (A1, A2, A3, A4, B1, B2, Z);
input  A1, A2, A3, A4, B1, B2;
output Z;
OR4 INST3 (.A(A1), .B(A2), .C(A3), .D(A4), .Z(I12));
OR2 INST4 (.A(B1), .B(B2), .Z(I5));
ND2 INST6 (.A(I12), .B(I5), .Z(Z));

endmodule

