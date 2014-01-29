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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/LUT7.v,v 1.3 2005/05/19 20:08:57 pradeep Exp $ 
//
`celldefine
`timescale 1 ns / 1 ps

module LUT7 (Z, A, B, C, D, E, F, G);

parameter  [127:0]init = 128'h0000_0000_0000_0000_0000_0000_0000_0000 ;

input   A, B, C, D, E, F, G;
output  Z;

wire o0, o1;

defparam inst0.init = init[63:0];
LUT6 inst0 (o0, A, B, C, D, E, F);

defparam inst1.init = init[127:64];
LUT6 inst1 (o1, A, B, C, D, E, F);

PFMUX    inst2 (o0, o1, G, Z);


endmodule
`endcelldefine
