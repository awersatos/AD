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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/DMUX24.v,v 1.2 2005/05/19 18:05:34 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Mon May 16 16:38:52 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module DMUX24 (A0, A1, Z0, Z1, Z2, Z3);
input  A0, A1;
output Z0, Z1, Z2, Z3;
AND2 INST15 (.A(A0), .B(A1), .Z(Z3));
AND2 INST16 (.A(I13), .B(A1), .Z(Z2));
AND2 INST17 (.A(A0), .B(I1), .Z(Z1));
AND2 INST18 (.A(I5), .B(I4), .Z(Z0));
NOT INST2 (.A(A1), .Z(I1));
NOT INST6 (.A(A0), .Z(I5));
NOT INST7 (.A(A1), .Z(I4));
NOT INST8 (.A(A0), .Z(I13));

endmodule
`endcelldefine
