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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/DMUX38E.v,v 1.2 2005/05/19 18:05:35 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Mon May 16 16:38:52 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module DMUX38E (A0, A1, A2, E, Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7);
input  A0, A1, A2, E;
output Z0, Z1, Z2, Z3, Z4, Z5, Z6, Z7;
NOT INST24 (.A(A2), .Z(I16));
AND4 INST25 (.A(I14), .B(A1), .C(I15), .D(E), .Z(Z2));
NOT INST26 (.A(A2), .Z(I13));
NOT INST27 (.A(A1), .Z(I12));
AND4 INST28 (.A(A0), .B(I12), .C(I13), .D(E), .Z(Z1));
AND4 INST29 (.A(I5), .B(I6), .C(I7), .D(E), .Z(Z0));
NOT INST30 (.A(A0), .Z(I5));
NOT INST31 (.A(A1), .Z(I6));
NOT INST32 (.A(A2), .Z(I7));
AND4 INST33 (.A(I17), .B(I18), .C(A2), .D(E), .Z(Z4));
AND4 INST34 (.A(A0), .B(I19), .C(A2), .D(E), .Z(Z5));
AND4 INST35 (.A(I20), .B(A1), .C(A2), .D(E), .Z(Z6));
AND4 INST36 (.A(A0), .B(A1), .C(A2), .D(E), .Z(Z7));
NOT INST37 (.A(A0), .Z(I14));
NOT INST38 (.A(A2), .Z(I15));
NOT INST39 (.A(A0), .Z(I17));
NOT INST40 (.A(A1), .Z(I18));
NOT INST41 (.A(A1), .Z(I19));
NOT INST42 (.A(A0), .Z(I20));
AND4 INST43 (.A(A0), .B(A1), .C(I16), .D(E), .Z(Z3));

endmodule
`endcelldefine
