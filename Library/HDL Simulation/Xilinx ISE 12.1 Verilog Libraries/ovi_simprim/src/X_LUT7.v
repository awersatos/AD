// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_LUT7.v,v 1.7 2006/01/11 19:34:38 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.2i (I.26)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  7-input Look-Up-Table with General Output
// /___/   /\     Filename : X_LUT7.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:56 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    01/07/06 - Add LOC Parameter (CR 222733)
// End Revision

`timescale 1 ps/1 ps

module X_LUT7 (O, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6);

  parameter INIT = 128'h00000000000000000000000000000000;
  parameter LOC = "UNPLACED";

  output O;
  input ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6;

  wire out0, out1, out2, out3, out4, out5, out6, out7, out8, out9;
  wire out10, out11, out12, out13, out14, out15, out16, out17, out18, out19;
  wire out20, out21, out22, out23, out24, out25, out26, out27, out28, out29;
  wire out30, out31, out32, out33, out34, out35, out36, out37, out38, out39;
  wire out40, out41;
  wire a0, a1, a2, a3, a4, a5, a6;

  buf b0 (a0, ADR0);
  buf b1 (a1, ADR1);
  buf b2 (a2, ADR2);
  buf b3 (a3, ADR3);
  buf b4 (a4, ADR4);
  buf b5 (a5, ADR5);
  buf b6 (a6, ADR6);

  x_lut7_mux4 (out31, INIT[127], INIT[126], INIT[125], INIT[124], a1, a0);
  x_lut7_mux4 (out30, INIT[123], INIT[122], INIT[121], INIT[120], a1, a0);
  x_lut7_mux4 (out29, INIT[119], INIT[118], INIT[117], INIT[116], a1, a0);
  x_lut7_mux4 (out28, INIT[115], INIT[114], INIT[113], INIT[112], a1, a0);
  x_lut7_mux4 (out27, INIT[111], INIT[110], INIT[109], INIT[108], a1, a0);
  x_lut7_mux4 (out26, INIT[107], INIT[106], INIT[105], INIT[104], a1, a0);
  x_lut7_mux4 (out25, INIT[103], INIT[102], INIT[101], INIT[100], a1, a0);
  x_lut7_mux4 (out24, INIT[99], INIT[98], INIT[97], INIT[96], a1, a0);
  x_lut7_mux4 (out23, INIT[95], INIT[94], INIT[93], INIT[92], a1, a0);
  x_lut7_mux4 (out22, INIT[91], INIT[90], INIT[89], INIT[88], a1, a0);
  x_lut7_mux4 (out21, INIT[87], INIT[86], INIT[85], INIT[84], a1, a0);
  x_lut7_mux4 (out20, INIT[83], INIT[82], INIT[81], INIT[80], a1, a0);
  x_lut7_mux4 (out19, INIT[79], INIT[78], INIT[77], INIT[76], a1, a0);
  x_lut7_mux4 (out18, INIT[75], INIT[74], INIT[73], INIT[72], a1, a0);
  x_lut7_mux4 (out17, INIT[71], INIT[70], INIT[69], INIT[68], a1, a0);
  x_lut7_mux4 (out16, INIT[67], INIT[66], INIT[65], INIT[64], a1, a0);
  x_lut7_mux4 (out15, INIT[63], INIT[62], INIT[61], INIT[60], a1, a0);
  x_lut7_mux4 (out14, INIT[59], INIT[58], INIT[57], INIT[56], a1, a0);
  x_lut7_mux4 (out13, INIT[55], INIT[54], INIT[53], INIT[52], a1, a0);
  x_lut7_mux4 (out12, INIT[51], INIT[50], INIT[49], INIT[48], a1, a0);
  x_lut7_mux4 (out11, INIT[47], INIT[46], INIT[45], INIT[44], a1, a0);
  x_lut7_mux4 (out10, INIT[43], INIT[42], INIT[41], INIT[40], a1, a0);
  x_lut7_mux4 (out9, INIT[39], INIT[38], INIT[37], INIT[36], a1, a0);
  x_lut7_mux4 (out8, INIT[35], INIT[34], INIT[33], INIT[32], a1, a0);
  x_lut7_mux4 (out7, INIT[31], INIT[30], INIT[29], INIT[28], a1, a0);
  x_lut7_mux4 (out6, INIT[27], INIT[26], INIT[25], INIT[24], a1, a0);
  x_lut7_mux4 (out5, INIT[23], INIT[22], INIT[21], INIT[20], a1, a0);
  x_lut7_mux4 (out4, INIT[19], INIT[18], INIT[17], INIT[16], a1, a0);
  x_lut7_mux4 (out3, INIT[15], INIT[14], INIT[13], INIT[12], a1, a0);
  x_lut7_mux4 (out2, INIT[11], INIT[10], INIT[9], INIT[8], a1, a0);
  x_lut7_mux4 (out1, INIT[7], INIT[6], INIT[5], INIT[4], a1, a0);
  x_lut7_mux4 (out0, INIT[3], INIT[2], INIT[1], INIT[0], a1, a0);

  x_lut7_mux4 (out39, out31, out30, out29, out28, a3, a2);
  x_lut7_mux4 (out38, out27, out26, out25, out24, a3, a2);
  x_lut7_mux4 (out37, out23, out22, out21, out20, a3, a2);
  x_lut7_mux4 (out36, out19, out18, out17, out16, a3, a2);
  x_lut7_mux4 (out35, out15, out14, out13, out12, a3, a2);
  x_lut7_mux4 (out34, out11, out10, out9, out8, a3, a2);
  x_lut7_mux4 (out33, out7, out6, out5, out4, a3, a2);
  x_lut7_mux4 (out32, out3, out2, out1, out0, a3, a2);

  x_lut7_mux4 (out41, out39, out38, out37, out36, a5, a4);
  x_lut7_mux4 (out40, out35, out34, out33, out32, a5, a4);

  x_lut7_mux4 (O, 1'b0, 1'b0, out41, out40, 1'b0, a6);

  specify

	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	(ADR2 => O) = (0:0:0, 0:0:0);
	(ADR3 => O) = (0:0:0, 0:0:0);
	(ADR4 => O) = (0:0:0, 0:0:0);
	(ADR5 => O) = (0:0:0, 0:0:0);
	(ADR6 => O) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;

  endspecify

endmodule

primitive x_lut7_mux4 (o, d3, d2, d1, d0, s1, s0);

  output o;
  input d3, d2, d1, d0;
  input s1, s0;

  table

    // d3  d2  d1  d0  s1  s0 : o;

       ?   ?   ?   1   0   0  : 1;
       ?   ?   ?   0   0   0  : 0;
       ?   ?   1   ?   0   1  : 1;
       ?   ?   0   ?   0   1  : 0;
       ?   1   ?   ?   1   0  : 1;
       ?   0   ?   ?   1   0  : 0;
       1   ?   ?   ?   1   1  : 1;
       0   ?   ?   ?   1   1  : 0;

       ?   ?   0   0   0   x  : 0;
       ?   ?   1   1   0   x  : 1;
       0   0   ?   ?   1   x  : 0;
       1   1   ?   ?   1   x  : 1;

       ?   0   ?   0   x   0  : 0;
       ?   1   ?   1   x   0  : 1;
       0   ?   0   ?   x   1  : 0;
       1   ?   1   ?   x   1  : 1;

       0   0   0   0   x   x  : 0;
       1   1   1   1   x   x  : 1;

  endtable

endprimitive
