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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/BTS12PU.v,v 1.2 2005/05/19 18:05:24 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Fri Jun 24 11:41:49 1994 */
/* module compiled from "lsl2db 3.6.4" run */
/* deleted unneeded buffer jmw 10-20-95 */

`celldefine
module BTS12PU (I, T, O, B);
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
bufif1 OUTBUF (INT, I, ENH);
pullup (INT);
pmos (B,INT,1'b0);
buf INBUF (O, B);


endmodule
`endcelldefine
