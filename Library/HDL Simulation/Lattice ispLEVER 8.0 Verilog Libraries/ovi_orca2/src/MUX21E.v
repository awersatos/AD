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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/MUX21E.v,v 1.2 2005/05/19 18:06:01 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri May 13 12:43:11 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module MUX21E (D0, D1, SD, E, Z);
input  D0, D1, SD, E;
output Z;
OR2 INST1 (.A(I2), .B(I3), .Z(Z));
AND3 INST11 (.A(D0), .B(I9), .C(E), .Z(I2));
AND3 INST12 (.A(SD), .B(D1), .C(E), .Z(I3));
NOT INST7 (.A(SD), .Z(I9));

endmodule
`endcelldefine
