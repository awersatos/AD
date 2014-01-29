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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1S1D_GSR.v,v 1.2 2005/05/19 18:05:42 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:48:02 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FD1S1D_GSR (D, CK, CD, GSR, Q);
input  D, CK, CD, GSR;
output Q;
reg notifier; 

or INST38 (I35, CDI, I46);
not INST43 (I46, GSR);
UDFDL1_UDP_X INST6 (Q, I35, D, CK, notifier); 
buf INST997 (CDI, CD);

not (GSR_CD, I35);
not (BCD,CD);


endmodule
