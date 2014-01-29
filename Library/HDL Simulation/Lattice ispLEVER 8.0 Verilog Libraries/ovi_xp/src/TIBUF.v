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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/TIBUF.v,v 1.2 2005/05/19 20:09:01 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Sat May 14 09:39:28 1994 */
/* module compiled from "lsl2db 3.6.4" run */


`celldefine
module TIBUF (I, T, O);
input  I, T;
output O;
bufif1 INST5 (O, I, T);

endmodule 
`endcelldefine
