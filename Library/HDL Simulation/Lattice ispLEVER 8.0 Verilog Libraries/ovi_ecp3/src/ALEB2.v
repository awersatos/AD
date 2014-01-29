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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ALEB2.v,v 1.3 2005/05/19 19:06:17 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine
 

module ALEB2 (A0, A1, B0, B1, CI, LE); 

input  A0, A1, B0, B1, CI;
output LE;

and  (I3, CI, I9);
and  (I4, B0, CI);
or   (I6, I3, I4, I5);
not  (I9, A0);
and  (I5, I9, B0);
or   (LE, I32, I31, I30);
and  (I31, B1, I6);
and  (I32, I6, I22);
and  (I30, I22, B1);
not  (I22, A1);


endmodule
`endcelldefine
