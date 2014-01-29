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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/MUX41E.v,v 1.2 2005/05/19 18:06:01 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri May 13 12:43:59 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module MUX41E (D0, D1, D2, D3, SD1, SD2, E, Z);
input  D0, D1, D2, D3, SD1, SD2, E;
output Z;
OR2 INST21 (.A(I6), .B(I7), .Z(I14));
AND2 INST22 (.A(D2), .B(I5), .Z(I6));
AND2 INST23 (.A(SD1), .B(D3), .Z(I7));
NOT INST24 (.A(SD1), .Z(I5));
OR2 INST25 (.A(I12), .B(I13), .Z(I10));
AND2 INST26 (.A(D0), .B(I11), .Z(I12));
AND2 INST27 (.A(SD1), .B(D1), .Z(I13));
NOT INST28 (.A(SD1), .Z(I11));
NOT INST29 (.A(SD2), .Z(I19));
AND3 INST30 (.A(SD2), .B(I14), .C(E), .Z(I18));
AND3 INST31 (.A(I10), .B(I19), .C(E), .Z(I17));
OR2 INST4 (.A(I17), .B(I18), .Z(Z));

endmodule
`endcelldefine
