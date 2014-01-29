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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FJ1S3BX.v,v 1.3 2005/05/19 18:05:48 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:51:17 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module FJ1S3BX (J, K, CK, PD, Q, QN);
input  J, K, CK, PD;
output Q, QN;
`ifdef GSR_SIGNAL
wire GSR = `GSR_SIGNAL;
`else
pullup (weak1) (GSR);
`endif

DELAY INST11 (.A(I17), .Z(Q));
DELAY INST22 (.A(I21), .Z(QN));
OR2 INST37 (.A(PD), .B(I51), .Z(I28));
/* GSRB INST40 (.GSRI(GSRI), .Z(I42)); */
NOT INST49 (.A(GSR), .Z(I51));
UJKFF2 INST6 (.J(J), .K(K), .CK(CK), .PRE(I28), .Q(I17),
      .QN(I21));

endmodule
`endcelldefine
