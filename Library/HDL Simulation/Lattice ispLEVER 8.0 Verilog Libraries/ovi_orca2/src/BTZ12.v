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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/BTZ12.v,v 1.3 2005/05/19 18:05:25 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Mon May 16 10:24:20 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module BTZ12 (I, T, O, B);
input  I, T;
output O;
inout  B;


`ifdef TSALL_SIGNAL
wire TSALL = `TSALL_SIGNAL;
`else
pullup (weak1) (TSALL);
`endif

not INST0 (TN, T);
and INST5 (ENH, TN, TSALL);
buf INST10 (O, B);
bufif1 INST14 (B, I, ENH);

endmodule 
`endcelldefine
