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
// Simulation Library File for ECP2
//
// $Header: /home/rel01/env5_1b.6/verilog/pkg/versclibs/data/ecp2/RCS/DELAYB.v,v 1.1 2005/07/07 20:24:59 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine
module DELAYC (A, Z);
  input A;
  output Z;
  
  buf (Z, A);

endmodule
`endcelldefine
