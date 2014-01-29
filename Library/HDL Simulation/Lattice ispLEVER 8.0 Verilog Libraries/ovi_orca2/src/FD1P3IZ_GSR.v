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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1P3IZ_GSR.v,v 1.2 2005/05/19 18:05:40 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:47:25 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module FD1P3IZ_GSR (D, SP, CK, CD, GSR, Q, QN);
input  D, SP, CK, CD, GSR;
output Q, QN;
reg notifier;

or INST33 (I50, I36, I38);
and INST34 (I36, Q, I54);
and INST35 (I38, SP, I65, D);
not INST52 (I54, SP);
not INST57 (I65, CD);
UDFDL5_UDP_X INST6 (Q, I50, CK, I29, notifier);
not INST69 (I29, GSR);


xor (D_XOR_Q, D, Q);
not (BCD,CD);
not (BD,D);
and (GSR_BCD_SP,GSR,BCD,SP);
and (GSR_D_XOR_Q,GSR,D_XOR_Q);
and (GSR_BD_SP,GSR,BD,SP);

endmodule

`endcelldefine
