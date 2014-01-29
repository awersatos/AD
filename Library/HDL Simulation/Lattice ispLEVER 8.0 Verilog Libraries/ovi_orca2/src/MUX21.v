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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/MUX21.v,v 1.3 2005/05/19 18:06:01 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri May 13 12:42:40 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module MUX21 (D0, D1, SD, Z);
input  D0, D1, SD;
output Z;
/*OR2 INST11 (.A(I3), .B(I2), .Z(Z));
NOT INST5 (.A(SD), .Z(I4));
AND2 INST6 (.A(SD), .B(D1), .Z(I2));
AND2 INST7 (.A(D0), .B(I4), .Z(I3));*/

  or  (Z, I3, I2);
  not (I4, SD);
  and (I2, SD, D1);
  and (I3, D0, I4);

endmodule
`endcelldefine
