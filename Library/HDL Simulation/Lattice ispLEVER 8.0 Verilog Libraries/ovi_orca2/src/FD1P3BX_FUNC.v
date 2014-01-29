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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1P3BX_FUNC.v,v 1.3 2005/05/19 18:05:38 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:47:04 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FD1P3BX_FUNC (D, SP, CK, PD, GSR, notifier, Q);
input  D, SP, CK, PD, GSR, notifier;
output Q;


// always @ (posedge CK)
//  $stop;

or INST33 (I50, I36, I38);
and INST34 (I36, Q, I54);
and INST35 (I38, SP, D);
not INST52 (I54, SP);
or INST59 (I57, PDI, I66);
UDFDL7_UDP_X INST6 (Q, I50, CK, I57, notifier); 
not INST64 (I66, GSR);
buf INST997 (PDI, PD);

not (GSRI_PD,I57);
xor (D_XOR_Q,D,Q);

endmodule

