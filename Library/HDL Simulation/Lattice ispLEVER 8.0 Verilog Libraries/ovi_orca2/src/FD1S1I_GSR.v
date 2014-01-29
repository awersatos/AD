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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1S1I_GSR.v,v 1.2 2005/05/19 18:05:43 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:48:17 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FD1S1I_GSR (D, CK, CD, GSR, Q);
input  D, CK, CD, GSR;
output Q;
reg notifier; 

and INST55 (I54, D, I53);
UDFDL1_UDP_X INST6 (Q, I35, I54, CK, notifier);
not INST60 (I53, CD);
not INST63 (I35, GSR);

and(GSR_I53,GSR,I53);
and(GSR_D,GSR,D); 

endmodule

