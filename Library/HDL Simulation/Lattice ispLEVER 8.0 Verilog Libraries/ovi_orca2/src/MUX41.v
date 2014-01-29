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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/MUX41.v,v 1.2 2005/05/19 18:06:01 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri May 13 12:43:33 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module MUX41 (D0, D1, D2, D3, SD1, SD2, Z);
input  D0, D1, D2, D3, SD1, SD2;
output Z;
AND2 INST10 (.A(D2), .B(I26), .Z(I25));
OR2 INST11 (.A(I25), .B(I24), .Z(I17));
OR2 INST12 (.A(I1), .B(I2), .Z(Z));
AND2 INST29 (.A(I21), .B(I14), .Z(I1));
NOT INST3 (.A(SD2), .Z(I14));
AND2 INST30 (.A(SD2), .B(I17), .Z(I2));
NOT INST4 (.A(SD1), .Z(I20));
AND2 INST5 (.A(SD1), .B(D1), .Z(I18));
AND2 INST6 (.A(D0), .B(I20), .Z(I19));
OR2 INST7 (.A(I19), .B(I18), .Z(I21));
NOT INST8 (.A(SD1), .Z(I26));
AND2 INST9 (.A(SD1), .B(D3), .Z(I24));

endmodule
`endcelldefine
