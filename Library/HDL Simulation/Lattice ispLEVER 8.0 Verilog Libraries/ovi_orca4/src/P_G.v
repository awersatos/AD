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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/P_G.v,v 1.2 2005/05/19 19:02:11 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module P_G (CO, A, B, CI);
input  A, B, CI;
output CO;

// Standard Propagate and Generate
or   PROP (P, A, B);
and  GEN  (G, A, B);

// The physical impleementation of the carry logic - the propagate is used to
// enable a pass transistor, and the carry out is created by a wired OR

and  PASS (PC, P, CI);
or   WOR  (CO, G, PC);

endmodule

`endcelldefine
