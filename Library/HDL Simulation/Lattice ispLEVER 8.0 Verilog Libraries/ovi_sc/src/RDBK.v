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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/RDBK.v,v 1.4 2005/05/19 19:06:59 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps


`celldefine
module RDBK (RDCFGN, FFRDCFG, FFRDCFGCLK, RDDATA);
input  RDCFGN;
input  FFRDCFG;
input  FFRDCFGCLK;
output RDDATA;

parameter FF_RDCFG = "ENABLED";
parameter FF_RDCFG_CLK = "USER";    // "USER", "CLK"
parameter RDCFG_DATA_SYNC = "RISE";    // "RISE", "FALL"

endmodule
`endcelldefine

