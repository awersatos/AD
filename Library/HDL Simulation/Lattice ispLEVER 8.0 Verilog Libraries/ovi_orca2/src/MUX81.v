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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/MUX81.v,v 1.2 2005/05/19 18:06:02 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri May 13 12:44:59 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module MUX81 (D0, D1, D2, D3, D4, D5, D6, D7, SD1, SD2, SD3, Z);
input  D0, D1, D2, D3, D4, D5, D6, D7, SD1, SD2, SD3;
output Z;
OR2 INST1 (.A(I2), .B(I33), .Z(Z));
OR2 INST10 (.A(I42), .B(I41), .Z(I44));
AND2 INST11 (.A(SD1), .B(D7), .Z(I47));
AND2 INST12 (.A(D6), .B(I49), .Z(I48));
OR2 INST13 (.A(I48), .B(I47), .Z(I63));
NOT INST14 (.A(SD1), .Z(I52));
AND2 INST15 (.A(SD1), .B(D5), .Z(I50));
AND2 INST16 (.A(D4), .B(I52), .Z(I51));
OR2 INST17 (.A(I51), .B(I50), .Z(I62));
NOT INST18 (.A(SD1), .Z(I55));
AND2 INST19 (.A(SD1), .B(D3), .Z(I53));
AND2 INST20 (.A(D2), .B(I55), .Z(I54));
OR2 INST21 (.A(I54), .B(I53), .Z(I40));
NOT INST22 (.A(SD2), .Z(I58));
AND2 INST23 (.A(SD2), .B(I40), .Z(I56));
AND2 INST24 (.A(I44), .B(I58), .Z(I57));
OR2 INST25 (.A(I57), .B(I56), .Z(I30));
OR2 INST26 (.A(I60), .B(I61), .Z(I64));
AND2 INST27 (.A(I62), .B(I59), .Z(I60));
AND2 INST28 (.A(SD2), .B(I63), .Z(I61));
NOT INST29 (.A(SD2), .Z(I59));
AND2 INST3 (.A(I30), .B(I32), .Z(I2));
AND2 INST4 (.A(SD3), .B(I64), .Z(I33));
NOT INST5 (.A(SD3), .Z(I32));
NOT INST6 (.A(SD1), .Z(I49));
NOT INST7 (.A(SD1), .Z(I43));
AND2 INST8 (.A(SD1), .B(D1), .Z(I41));
AND2 INST9 (.A(D0), .B(I43), .Z(I42));

endmodule
`endcelldefine
