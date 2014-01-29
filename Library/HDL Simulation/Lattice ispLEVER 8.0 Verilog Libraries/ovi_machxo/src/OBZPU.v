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
// Simulation Library File for XO
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mj/RCS/OBZPU.v,v 1.4 2005/05/19 20:01:23 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OBZPU (I, T, O);
  input  I, T;
  output O;

  tri0 TSALL = TSALL_INST.TSALLNET;

  not INST3 (TSALL_N, TSALL);
  not INST0 (TN, T);
  and INST1 (ENH, TN, TSALL_N);
  pullup(INT);
  bufif1 INST2 (INT, I, ENH);
  pmos (O,INT,1'b0);


endmodule

`endcelldefine
