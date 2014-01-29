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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/ORCALUT6.v,v 1.3 2005/05/19 20:08:56 pradeep Exp $ 
//
`celldefine
`timescale 1 ns / 1 ps

module ORCALUT6 (Z, A, B, C, D, E, F);

parameter  [63:0]init = 64'h0000_0000_0000_0000 ;

input   A, B, C, D, E, F;
output  Z;
wire    y,y0,y1,y2,y3,y4,y5,y6,y7,y8,y9;
wire    y10,y11,y12,y13,y14,y15,y16,y17,y18,y19;
wire    i0,i1,i2,i3,i4,i5;

buf INST0 (i0,A);
buf INST1 (i1,B);
buf INST2 (i2,C);
buf INST3 (i3,D);
buf INST4 (i4,E);
buf INST5 (i5,F);
buf INST6 (Z,y);

lut_mux4 (y15, init[63], init[62], init[61], init[60], i1, i0);
lut_mux4 (y14, init[59], init[58], init[57], init[56], i1, i0);
lut_mux4 (y13, init[55], init[54], init[53], init[52], i1, i0);
lut_mux4 (y12, init[51], init[50], init[49], init[48], i1, i0);
lut_mux4 (y11, init[47], init[46], init[45], init[44], i1, i0);
lut_mux4 (y10, init[43], init[42], init[41], init[40], i1, i0);
lut_mux4 (y9, init[39], init[38], init[37], init[36], i1, i0);
lut_mux4 (y8, init[35], init[34], init[33], init[32], i1, i0);
lut_mux4 (y7, init[31], init[30], init[29], init[28], i1, i0);
lut_mux4 (y6, init[27], init[26], init[25], init[24], i1, i0);
lut_mux4 (y5, init[23], init[22], init[21], init[20], i1, i0);
lut_mux4 (y4, init[19], init[18], init[17], init[16], i1, i0);
lut_mux4 (y3, init[15], init[14], init[13], init[12], i1, i0);
lut_mux4 (y2, init[11], init[10], init[9], init[8], i1, i0);
lut_mux4 (y1, init[7], init[6], init[5], init[4], i1, i0);
lut_mux4 (y0, init[3], init[2], init[1], init[0], i1, i0);
lut_mux4 (y19, y15, y14, y13, y12, i3, i2);
lut_mux4 (y18, y11, y10, y9, y8, i3, i2);
lut_mux4 (y17, y7, y6, y5, y4, i3, i2);
lut_mux4 (y16, y3, y2, y1, y0, i3, i2);
lut_mux4 (y, y19, y18, y17, y16, i5, i4);

specify

    (A => Z) = (0.1:0.1:0.1, 0.1:0.1:0.1);
    (B => Z) = (0.1:0.1:0.1, 0.1:0.1:0.1);
    (C => Z) = (0.1:0.1:0.1, 0.1:0.1:0.1);
    (D => Z) = (0.1:0.1:0.1, 0.1:0.1:0.1);
    (E => Z) = (0.1:0.1:0.1, 0.1:0.1:0.1);
    (F => Z) = (0.1:0.1:0.1, 0.1:0.1:0.1);

endspecify

endmodule

`endcelldefine
