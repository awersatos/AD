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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/FD1P3JX_GSR.v,v 1.2 2005/05/19 18:26:20 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

module FD1P3JX_GSR (D, SP, CK, PD, GSR, Q);
input  D, SP, CK, PD, GSR;
output Q;
reg notifier;
 

NOT INST76 (GSR,I29);
OR3 INST33 (PD,I36,I73,I50);
AND2 INST34 (Q,I54,I36);
AND2 INST35 (SP,D,I73);
NOT INST52 (SP,I54);
UDFDL7_UDP_X INST6 (Q,I50,CK,I29,notifier);

endmodule
`endcelldefine
