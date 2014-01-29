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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/LUT4.v,v 1.3 2005/05/19 20:08:56 pradeep Exp $ 
//
`celldefine
`timescale 1 ns / 1 ps
module LUT4 (A, B, C, D, Z);

parameter  [15:0]init = 16'h0000 ;

input   A, B, C, D;
output  Z;
wire    y,y0,y1,y2,y3,i0,i1,i2,i3;

buf INST0 (i0,A);
buf INST1 (i1,B);
buf INST2 (i2,C);
buf INST3 (i3,D);
buf INST4 (Z,y);

lut_mux4 (y3, init[15], init[14], init[13], init[12], i1, i0);
lut_mux4 (y2, init[11], init[10], init[9], init[8], i1, i0);
lut_mux4 (y1, init[7], init[6], init[5], init[4], i1, i0);
lut_mux4 (y0, init[3], init[2], init[1], init[0], i1, i0);
lut_mux4 (y, y3, y2, y1, y0, i3, i2);

	
endmodule
`endcelldefine
