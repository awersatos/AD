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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/OBZPU.v,v 1.4 2005/05/19 20:08:52 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OBZPU (I, T, O);
  input  I, T;
  output O;

  supply1 TSALL;
//  tri1 TSALL = TSALL_INST.TSALLNET;

  not INST0 (TN, T);
  and INST1 (ENH, TN, TSALL);
  pullup(INT);
  bufif1 INST2 (INT, I, ENH);
  pmos (O,INT,1'b0);


endmodule

`endcelldefine
