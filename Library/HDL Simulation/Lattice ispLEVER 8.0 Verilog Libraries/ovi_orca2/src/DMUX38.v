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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/DMUX38.v,v 1.2 2005/05/19 18:05:35 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Mon May 16 16:38:52 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module DMUX38 (A0, A1, A2, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);
input  A0, A1, A2;
output Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7;
NOT INST1 (.A(A2), .Z(I36));
AND3 INST10 (.A(I37), .B(I38), .C(A2), .Z(Z4));
AND3 INST11 (.A(A0), .B(I39), .C(A2), .Z(Z5));
AND3 INST12 (.A(I40), .B(A1), .C(A2), .Z(Z6));
AND3 INST13 (.A(A0), .B(A1), .C(A2), .Z(Z7));
NOT INST14 (.A(A0), .Z(I34));
NOT INST15 (.A(A2), .Z(I35));
NOT INST16 (.A(A0), .Z(I37));
NOT INST17 (.A(A1), .Z(I38));
NOT INST18 (.A(A1), .Z(I39));
NOT INST19 (.A(A0), .Z(I40));
AND3 INST2 (.A(I34), .B(A1), .C(I35), .Z(Z2));
AND3 INST20 (.A(A0), .B(A1), .C(I36), .Z(Z3));
NOT INST3 (.A(A2), .Z(I33));
NOT INST4 (.A(A1), .Z(I32));
AND3 INST5 (.A(A0), .B(I32), .C(I33), .Z(Z1));
AND3 INST6 (.A(I25), .B(I26), .C(I27), .Z(Z0));
NOT INST7 (.A(A0), .Z(I25));
NOT INST8 (.A(A1), .Z(I26));
NOT INST9 (.A(A2), .Z(I27));

endmodule
`endcelldefine
