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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mj/RCS/BBPU.v,v 1.4 2005/05/19 20:01:21 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module BBPU (I, T, O, B);
  input  I, T;
  output O;
  inout  B;

  tri0 TSALL = TSALL_INST.TSALLNET;

  not INST0 (TN, T);
  not INST2 (TSALL_N, TSALL);
  and INST1 (ENH, TN, TSALL_N);

  buf INBUF (O, B);
  bufif1 OUTBUF (INT, I, ENH);
  pullup (INT);
  pmos (B,INT,1'b0);


endmodule

`endcelldefine
