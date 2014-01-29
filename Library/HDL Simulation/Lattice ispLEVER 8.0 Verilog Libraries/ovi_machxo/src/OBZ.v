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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mj/RCS/OBZ.v,v 1.4 2005/05/19 20:01:23 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OBZ (I, T, O);
  input  I, T;
  output O;

  tri0 TSALL = TSALL_INST.TSALLNET;

  not INST0 (TSALL_N, TSALL);
  not INST1 (TO, T);
  and INST2 (T_AND, TO, TSALL_N);
  bufif1 INST5 (O, I, T_AND);


endmodule 

`endcelldefine
