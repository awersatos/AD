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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/DMUX24E.v,v 1.2 2005/05/19 18:05:34 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Mon May 16 16:38:52 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module DMUX24E (A0, A1, E, Z0, Z1, Z2, Z3);
input  A0, A1, E;
output Z0, Z1, Z2, Z3;
NOT INST17 (.A(A0), .Z(I18));
AND3 INST3 (.A(A0), .B(A1), .C(E), .Z(Z3));
AND3 INST4 (.A(I18), .B(A1), .C(E), .Z(Z2));
AND3 INST5 (.A(A0), .B(I15), .C(E), .Z(Z1));
AND3 INST6 (.A(I11), .B(I10), .C(E), .Z(Z0));
NOT INST7 (.A(A1), .Z(I15));
NOT INST8 (.A(A1), .Z(I10));
NOT INST9 (.A(A0), .Z(I11));

endmodule
`endcelldefine
