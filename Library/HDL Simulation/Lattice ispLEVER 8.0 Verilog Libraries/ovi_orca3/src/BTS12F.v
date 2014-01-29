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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/BTS12F.v,v 1.4 2005/05/19 18:29:15 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module BTS12F (I, T, O, B);
  input  I, T;
  output O;
  inout  B;

 `ifdef TSALL_SIGNAL
  wire TSALL = `TSALL_SIGNAL;
 `else
  pullup (weak1) (TSALL);
 `endif

  not INST0 (TN, T);
  and INST5 (ENH, TN, TSALL);
  buf INST10 (O, B);
  bufif1 INST14 (B, I, ENH);


endmodule 

`endcelldefine
