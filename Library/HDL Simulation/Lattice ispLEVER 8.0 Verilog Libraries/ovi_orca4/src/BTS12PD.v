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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/BTS12PD.v,v 1.4 2005/05/19 19:00:49 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module BTS12PD (I, T, O, B);
  input  I, T;
  output O;
  inout  B;


  tri1 TSALL = TSALL_INST.TSALLNET;

  not INST0 (TN, T);
  and INST1 (ENH, TN, TSALL);
  buf INBUF (O, B);
  bufif1 OUTBUF (INT, I, ENH);
  pulldown (INT);
  pmos (B,INT,1'b0);


endmodule

`endcelldefine
