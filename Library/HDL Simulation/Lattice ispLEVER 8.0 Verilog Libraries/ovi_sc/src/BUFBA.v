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
// Simulation Library File for SC
//
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/orca5/RCS/BUFBA.v,v 1.4 2005/09/14 19:46:56 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module BUFBA (Z, A);

   output Z ;
   input A ;
   parameter BUF_DELAY = 0;

   buf #BUF_DELAY (Z, A) ;


endmodule // BUFFER

`endcelldefine
