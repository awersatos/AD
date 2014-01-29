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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/OAI2211.v,v 1.2 2005/05/19 18:06:13 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.2 on Fri Aug  5 11:14:51 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module OAI2211 (A1, A2, B1, B2, C, D, Z);
input  A1, A2, B1, B2, C, D;
output Z;
ND4 INST2 (.A(I11), .B(I9), .C(C), .D(D), .Z(Z));
OR2 INST3 (.A(B1), .B(B2), .Z(I9));
OR2 INST4 (.A(A1), .B(A2), .Z(I11));

endmodule

