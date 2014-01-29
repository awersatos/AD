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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1S1B_GSR.v,v 1.2 2005/05/19 18:05:42 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps


/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:47:57 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FD1S1B_GSR (D, CK, PD, GSR, Q);
input  D, CK, PD, GSR;
output Q;
reg notifier; 
or INST37 (I28, PDI, I45);

not INST44 (I45, GSR);
UDFDL3_UDP_X INST6 (Q, I28, D, CK, notifier); 
buf INST997 (PDI, PD);

not (GSR_PD, I28);


endmodule

