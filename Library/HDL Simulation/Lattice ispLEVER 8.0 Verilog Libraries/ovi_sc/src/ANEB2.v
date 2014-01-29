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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ANEB2.v,v 1.3 2005/05/19 19:06:19 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine


module ANEB2 (A0, A1, B0, B1, CI, NE); 

input  A0, A1, B0, B1, CI;
output NE;

xnor  (RES_A, A0, B0);
xnor  (RES_B, A1, B1);
and   (EQ, RES_A, RES_B);
not   (PNE, EQ);
or    (NE, PNE, CI);


endmodule
`endcelldefine

