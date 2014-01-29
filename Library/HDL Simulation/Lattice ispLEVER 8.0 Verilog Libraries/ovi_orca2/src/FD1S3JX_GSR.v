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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1S3JX_GSR.v,v 1.2 2005/05/19 18:05:46 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:50:03 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FD1S3JX_GSR (D, CK, PD, GSR, Q);
input  D, CK, PD, GSR;
output Q;
reg notifier; 

UDFDL7_UDP_X INST6 (Q, I70, CK, I54, notifier); 
or INST67 (I70, D, PD);
not INST74 (I54, GSR);
not (BPD,PD);
not (QN,Q);
and (GSR_BPD,GSR,BPD);
and (GSR_QN,GSR,QN); 


endmodule
