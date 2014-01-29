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
// Simulation Library File for ORCA2A
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/FD1P3IX_GSR.v,v 1.2 2005/05/19 18:26:19 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine
module FD1P3IX_GSR (D, SP, CK, CD, GSR, Q);
input  D, SP, CK, CD, GSR;
output Q;
reg notifier;

NOT  INST69 (GSR, I29);
OR2  INST32 (I54,D,I50);
OR2  INST33 (SP,Q,I51);
AND3 INST35 (I51,I65,I50,I38);
NOT  INST52 (SP,I54);
NOT  INST57 (CD,I65);
UDFDL5_UDP_X INST6 (Q, I38, CK, I29, notifier);

endmodule

`endcelldefine
