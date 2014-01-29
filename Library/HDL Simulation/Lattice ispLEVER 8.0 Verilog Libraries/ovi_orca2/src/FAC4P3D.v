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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FAC4P3D.v,v 1.3 2005/05/19 18:05:35 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Mon Sep 12 16:50:36 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module FAC4P3D (A0, A1, A2, A3, CI, SP, CK, CD, CO, 
       Q0, Q1, Q2, Q3);
input  A0, A1, A2, A3, CI, SP, CK, CD;
output CO, Q0, Q1, Q2, Q3;
`ifdef GSR_SIGNAL
wire GSR = `GSR_SIGNAL;
`else
pullup (weak1) (GSR);
`endif

/* GSR_PRE \INST68.INST27 (.GSR(GSR)); */
FAC4P3D_GSR G (.A0(A0), .A1(A1), .A2(A2), .A3(A3), .CI(CI),
      .SP(SP), .CK(CK), .CD(CD), .GSR(GSR), .CO(CO),
      .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3));

endmodule

