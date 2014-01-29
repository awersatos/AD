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
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FD1P3IX_FUNC.v,v 1.3 2005/05/19 19:01:13 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FD1P3IX_FUNC (D, SP, CK, CD, SR, notifier, Q);
input  D, SP, CK, CD, SR, notifier;
output Q;

//NOT  INST69 (SR, I29);
//OR2  INST32 (I54,D,I50);
//OR2  INST33 (SP,Q,I51);
//AND3 INST35 (I51,I65,I50,I38);
//NOT  INST52 (SP,I54);
//NOT  INST57 (CD,I65);
not     (I29, SR);
or      (I50, I54, D);
or      (I51, SP, Q);
and     (I38, I51, I65, I50);
not     (I54, SP);
not     (I65, CD);
UDFDL5_UDP_X INST6 (Q, I38, CK, I29, notifier);


endmodule

`endcelldefine
