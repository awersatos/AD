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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FT1S3AX.v,v 1.3 2005/05/19 18:05:53 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:54:40 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module FT1S3AX (T, CK, Q, QN);
input  T, CK;
output Q, QN;
`ifdef GSR_SIGNAL
wire GSR = `GSR_SIGNAL;
`else
pullup (weak1) (GSR);
`endif

DELAY INST11 (.A(I37), .Z(Q));
DELAY INST22 (.A(I21), .Z(QN));
/* GSRB INST27 (.GSRI(GSRI), .Z(I39)); */
XOR2 INST35 (.A(I37), .B(T), .Z(I17));
NOT INST40 (.A(GSR), .Z(I29));
UDFDL5 INST6 (.D(I17), .CK(CK), .CLR(I29), .Q(I37), .QN(
      I21));

endmodule
`endcelldefine
