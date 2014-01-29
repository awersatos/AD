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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/BTS12PU.v,v 1.4 2005/05/19 18:29:16 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module BTS12PU (I, T, O, B);
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
  bufif1 OUTBUF (INT, I, ENH);
  pullup (INT);
  pmos (B,INT,1'b0);
  buf INBUF (O, B);


endmodule

`endcelldefine
