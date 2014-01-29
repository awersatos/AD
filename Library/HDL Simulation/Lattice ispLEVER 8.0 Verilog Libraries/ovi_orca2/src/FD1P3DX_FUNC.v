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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FD1P3DX_FUNC.v,v 1.2 2005/05/19 18:05:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:47:10 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FD1P3DX_FUNC (D, SP, CK, CD, GSR, notifier, Q);
input  D, SP, CK, CD, GSR, notifier;
output Q;

or INST33 (I50, I36, I38);
and INST34 (I36, Q, I54);
and INST35 (I38, SP, D);
not INST52 (I54, SP);
or INST59 (I57, CDI, I67);
UDFDL5_UDP_X INST6 (Q, I50, CK, I57, notifier); 
not INST65 (I67, GSR);
buf INST997 (CDI, CD);

endmodule

