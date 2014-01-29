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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FL1S1A_GSR.v,v 1.2 2005/05/19 18:05:51 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:52:11 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FL1S1A_GSR (D0, D1, CK, SD, GSR, Q);
input  D0, D1, CK, SD, GSR;
output Q;
reg notifier;

or INST34 (I31, I38, I40);
and INST35 (I38, D0I, I43);
DELAY  INST981 (.A(D0), .Z(D0I));
and INST36 (I40, SDI, D1I);
DELAY  INST980 (.A(SD), .Z(SDI));
DELAY  INST982 (.A(D1), .Z(D1I));
not INST37 (I43, SDI);
not INST50 (I29, GSR);
UDFDL1_UDP_X INST6 (Q, I29, I31, CK, notifier);
and (GSR_SD,GSR,SD);
and (GSR_BSD,GSR,I43); 
xor (D0_XOR_D1,D0,D1);

endmodule
