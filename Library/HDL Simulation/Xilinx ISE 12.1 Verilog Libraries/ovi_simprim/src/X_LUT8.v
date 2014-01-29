// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_LUT8.v,v 1.7 2006/01/11 19:34:38 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.2i (I.26)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  8-input Look-Up-Table with General Output
// /___/   /\     Filename : X_LUT8.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:56 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    01/07/06 - Add LOC Parameter (CR 222733)
// End Revision

`timescale 1 ps/1 ps

module X_LUT8 (O, ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6, ADR7);

  parameter INIT = 256'h0000000000000000000000000000000000000000000000000000000000000000;
  parameter LOC = "UNPLACED";

  output O;
  input ADR0, ADR1, ADR2, ADR3, ADR4, ADR5, ADR6, ADR7;

  wire out0, out1, out2, out3, out4, out5, out6, out7, out8, out9;
  wire out10, out11, out12, out13, out14, out15, out16, out17, out18, out19;
  wire out20, out21, out22, out23, out24, out25, out26, out27, out28, out29;
  wire out30, out31, out32, out33, out34, out35, out36, out37, out38, out39;
  wire out40, out41, out42, out43, out44, out45, out46, out47, out48, out49;
  wire out50, out51, out52, out53, out54, out55, out56, out57, out58, out59;
  wire out60, out61, out62, out63, out64, out65, out66, out67, out68, out69;
  wire out70, out71, out72, out73, out74, out75, out76, out77, out78, out79;
  wire out80, out81, out82, out83;
  wire a0, a1, a2, a3, a4, a5, a6, a7;

  buf b0 (a0, ADR0);
  buf b1 (a1, ADR1);
  buf b2 (a2, ADR2);
  buf b3 (a3, ADR3);
  buf b4 (a4, ADR4);
  buf b5 (a5, ADR5);
  buf b6 (a6, ADR6);
  buf b7 (a7, ADR7);

  x_lut8_mux4 (out63, INIT[255], INIT[254], INIT[253], INIT[252], a1, a0);
  x_lut8_mux4 (out62, INIT[251], INIT[250], INIT[249], INIT[248], a1, a0);
  x_lut8_mux4 (out61, INIT[247], INIT[246], INIT[245], INIT[244], a1, a0);
  x_lut8_mux4 (out60, INIT[243], INIT[242], INIT[241], INIT[240], a1, a0);
  x_lut8_mux4 (out59, INIT[239], INIT[238], INIT[237], INIT[236], a1, a0);
  x_lut8_mux4 (out58, INIT[235], INIT[234], INIT[233], INIT[232], a1, a0);
  x_lut8_mux4 (out57, INIT[231], INIT[230], INIT[229], INIT[228], a1, a0);
  x_lut8_mux4 (out56, INIT[227], INIT[226], INIT[225], INIT[224], a1, a0);
  x_lut8_mux4 (out55, INIT[223], INIT[222], INIT[221], INIT[220], a1, a0);
  x_lut8_mux4 (out54, INIT[219], INIT[218], INIT[217], INIT[216], a1, a0);
  x_lut8_mux4 (out53, INIT[215], INIT[214], INIT[213], INIT[212], a1, a0);
  x_lut8_mux4 (out52, INIT[211], INIT[210], INIT[209], INIT[208], a1, a0);
  x_lut8_mux4 (out51, INIT[207], INIT[206], INIT[205], INIT[204], a1, a0);
  x_lut8_mux4 (out50, INIT[203], INIT[202], INIT[201], INIT[200], a1, a0);
  x_lut8_mux4 (out49, INIT[199], INIT[198], INIT[197], INIT[196], a1, a0);
  x_lut8_mux4 (out48, INIT[195], INIT[194], INIT[193], INIT[192], a1, a0);
  x_lut8_mux4 (out47, INIT[191], INIT[190], INIT[189], INIT[188], a1, a0);
  x_lut8_mux4 (out46, INIT[187], INIT[186], INIT[185], INIT[184], a1, a0);
  x_lut8_mux4 (out45, INIT[183], INIT[182], INIT[181], INIT[180], a1, a0);
  x_lut8_mux4 (out44, INIT[179], INIT[178], INIT[177], INIT[176], a1, a0);
  x_lut8_mux4 (out43, INIT[175], INIT[174], INIT[173], INIT[172], a1, a0);
  x_lut8_mux4 (out42, INIT[171], INIT[170], INIT[169], INIT[168], a1, a0);
  x_lut8_mux4 (out41, INIT[167], INIT[166], INIT[165], INIT[164], a1, a0);
  x_lut8_mux4 (out40, INIT[163], INIT[162], INIT[161], INIT[160], a1, a0);
  x_lut8_mux4 (out39, INIT[159], INIT[158], INIT[157], INIT[156], a1, a0);
  x_lut8_mux4 (out38, INIT[155], INIT[154], INIT[153], INIT[152], a1, a0);
  x_lut8_mux4 (out37, INIT[151], INIT[150], INIT[149], INIT[148], a1, a0);
  x_lut8_mux4 (out36, INIT[147], INIT[146], INIT[145], INIT[144], a1, a0);
  x_lut8_mux4 (out35, INIT[143], INIT[142], INIT[141], INIT[140], a1, a0);
  x_lut8_mux4 (out34, INIT[139], INIT[138], INIT[137], INIT[136], a1, a0);
  x_lut8_mux4 (out33, INIT[135], INIT[134], INIT[133], INIT[132], a1, a0);
  x_lut8_mux4 (out32, INIT[131], INIT[130], INIT[129], INIT[128], a1, a0);
  x_lut8_mux4 (out31, INIT[127], INIT[126], INIT[125], INIT[124], a1, a0);
  x_lut8_mux4 (out30, INIT[123], INIT[122], INIT[121], INIT[120], a1, a0);
  x_lut8_mux4 (out29, INIT[119], INIT[118], INIT[117], INIT[116], a1, a0);
  x_lut8_mux4 (out28, INIT[115], INIT[114], INIT[113], INIT[112], a1, a0);
  x_lut8_mux4 (out27, INIT[111], INIT[110], INIT[109], INIT[108], a1, a0);
  x_lut8_mux4 (out26, INIT[107], INIT[106], INIT[105], INIT[104], a1, a0);
  x_lut8_mux4 (out25, INIT[103], INIT[102], INIT[101], INIT[100], a1, a0);
  x_lut8_mux4 (out24, INIT[99], INIT[98], INIT[97], INIT[96], a1, a0);
  x_lut8_mux4 (out23, INIT[95], INIT[94], INIT[93], INIT[92], a1, a0);
  x_lut8_mux4 (out22, INIT[91], INIT[90], INIT[89], INIT[88], a1, a0);
  x_lut8_mux4 (out21, INIT[87], INIT[86], INIT[85], INIT[84], a1, a0);
  x_lut8_mux4 (out20, INIT[83], INIT[82], INIT[81], INIT[80], a1, a0);
  x_lut8_mux4 (out19, INIT[79], INIT[78], INIT[77], INIT[76], a1, a0);
  x_lut8_mux4 (out18, INIT[75], INIT[74], INIT[73], INIT[72], a1, a0);
  x_lut8_mux4 (out17, INIT[71], INIT[70], INIT[69], INIT[68], a1, a0);
  x_lut8_mux4 (out16, INIT[67], INIT[66], INIT[65], INIT[64], a1, a0);
  x_lut8_mux4 (out15, INIT[63], INIT[62], INIT[61], INIT[60], a1, a0);
  x_lut8_mux4 (out14, INIT[59], INIT[58], INIT[57], INIT[56], a1, a0);
  x_lut8_mux4 (out13, INIT[55], INIT[54], INIT[53], INIT[52], a1, a0);
  x_lut8_mux4 (out12, INIT[51], INIT[50], INIT[49], INIT[48], a1, a0);
  x_lut8_mux4 (out11, INIT[47], INIT[46], INIT[45], INIT[44], a1, a0);
  x_lut8_mux4 (out10, INIT[43], INIT[42], INIT[41], INIT[40], a1, a0);
  x_lut8_mux4 (out9, INIT[39], INIT[38], INIT[37], INIT[36], a1, a0);
  x_lut8_mux4 (out8, INIT[35], INIT[34], INIT[33], INIT[32], a1, a0);
  x_lut8_mux4 (out7, INIT[31], INIT[30], INIT[29], INIT[28], a1, a0);
  x_lut8_mux4 (out6, INIT[27], INIT[26], INIT[25], INIT[24], a1, a0);
  x_lut8_mux4 (out5, INIT[23], INIT[22], INIT[21], INIT[20], a1, a0);
  x_lut8_mux4 (out4, INIT[19], INIT[18], INIT[17], INIT[16], a1, a0);
  x_lut8_mux4 (out3, INIT[15], INIT[14], INIT[13], INIT[12], a1, a0);
  x_lut8_mux4 (out2, INIT[11], INIT[10], INIT[9], INIT[8], a1, a0);
  x_lut8_mux4 (out1, INIT[7], INIT[6], INIT[5], INIT[4], a1, a0);
  x_lut8_mux4 (out0, INIT[3], INIT[2], INIT[1], INIT[0], a1, a0);

  x_lut8_mux4 (out79, out63, out62, out61, out60, a3, a2);
  x_lut8_mux4 (out78, out59, out58, out57, out56, a3, a2);
  x_lut8_mux4 (out77, out55, out54, out53, out52, a3, a2);
  x_lut8_mux4 (out76, out51, out50, out49, out48, a3, a2);
  x_lut8_mux4 (out75, out47, out46, out45, out44, a3, a2);
  x_lut8_mux4 (out74, out43, out42, out41, out40, a3, a2);
  x_lut8_mux4 (out73, out39, out38, out37, out36, a3, a2);
  x_lut8_mux4 (out72, out35, out34, out33, out32, a3, a2);
  x_lut8_mux4 (out71, out31, out30, out29, out28, a3, a2);
  x_lut8_mux4 (out70, out27, out26, out25, out24, a3, a2);
  x_lut8_mux4 (out69, out23, out22, out21, out20, a3, a2);
  x_lut8_mux4 (out68, out19, out18, out17, out16, a3, a2);
  x_lut8_mux4 (out67, out15, out14, out13, out12, a3, a2);
  x_lut8_mux4 (out66, out11, out10, out9, out8, a3, a2);
  x_lut8_mux4 (out65, out7, out6, out5, out4, a3, a2);
  x_lut8_mux4 (out64, out3, out2, out1, out0, a3, a2);

  x_lut8_mux4 (out83, out79, out78, out77, out76, a5, a4);
  x_lut8_mux4 (out82, out75, out74, out73, out72, a5, a4);
  x_lut8_mux4 (out81, out71, out70, out69, out68, a5, a4);
  x_lut8_mux4 (out80, out67, out66, out65, out64, a5, a4);

  x_lut8_mux4 (O, out83, out82, out81, out80, a7, a6);

  specify

	(ADR0 => O) = (0:0:0, 0:0:0);
	(ADR1 => O) = (0:0:0, 0:0:0);
	(ADR2 => O) = (0:0:0, 0:0:0);
	(ADR3 => O) = (0:0:0, 0:0:0);
	(ADR4 => O) = (0:0:0, 0:0:0);
	(ADR5 => O) = (0:0:0, 0:0:0);
	(ADR6 => O) = (0:0:0, 0:0:0);
	(ADR7 => O) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;

  endspecify

endmodule

primitive x_lut8_mux4 (o, d3, d2, d1, d0, s1, s0);

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
