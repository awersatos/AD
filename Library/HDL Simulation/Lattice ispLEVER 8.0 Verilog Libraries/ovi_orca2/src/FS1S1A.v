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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FS1S1A.v,v 1.3 2005/05/19 18:05:53 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:54:29 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FS1S1A (S, R, CK, Q, QN);
input  S, R, CK;
output Q, QN;
`ifdef GSR_SIGNAL
wire GSR = `GSR_SIGNAL;
`else
pullup (weak1) (GSR);
`endif

DELAY INST11 (.A(I17), .Z(Q));
DELAY INST22 (.A(I21), .Z(QN));
/* GSRB INST27 (.GSRI(GSRI), .Z(I47)); */
NOT INST32 (.A(R), .Z(I40));
OR2 INST33 (.A(I36), .B(I38), .Z(I9));
AND2 INST34 (.A(I17), .B(I40), .Z(I36));
AND2 INST35 (.A(I40), .B(S), .Z(I38));
NOT INST48 (.A(GSR), .Z(I29));
UDFDL1 INST6 (.CLR(I29), .PD(I9), .PE(CK), .Q(I17), .QN(
      I21));

endmodule

