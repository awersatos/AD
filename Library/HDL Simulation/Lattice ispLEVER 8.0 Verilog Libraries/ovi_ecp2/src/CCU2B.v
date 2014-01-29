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
// Simulation Library File for ECP2
//
// $Header: /home/pradeep/fndry_src/env/verilog/pkg/versclibs/data/ecp2/RCS/CCU2B.v,v 1.1 2005/08/18 17:58:07 pradeep Exp $
//
`resetall
`timescale 1 ns / 1 ps

module CCU2B (
   CIN,
   A0, B0, C0, D0,
   A1, B1, C1, D1,
   //S0, S1, COUT0, COUT1
   S0, S1, COUT
);

input CIN;
input A0, B0, C0, D0;
input A1, B1, C1, D1;
output S0, S1, COUT;

parameter [15:0] INIT0 = 16'h0000;
parameter [15:0] INIT1 = 16'h0000;
parameter INJECT1_0 = "YES";
parameter INJECT1_1 = "YES";

wire y3_0, y2_0, y1_0, y0_0; 
wire y3_1, y2_1, y1_1, y0_1; 

// First Half
lut_mux4 (y3_0, INIT0[15], INIT0[14], INIT0[13], INIT0[12], B0, A0);
lut_mux4 (y2_0, INIT0[11], INIT0[10], INIT0[9], INIT0[8], B0, A0);
lut_mux4 (y1_0, INIT0[7], INIT0[6], INIT0[5], INIT0[4], B0, A0);
lut_mux4 (y0_0, INIT0[3], INIT0[2], INIT0[1], INIT0[0], B0, A0);
lut_mux4 (prop_0, y3_0, y2_0, y1_0, y0_0, D0, C0);

wire gen_0 = (INJECT1_0 == "YES" )? 1'b0 : y0_0;
wire pass_cin_0 = (INJECT1_0 == "YES" )? 1'b0 : 1'b1;
wire cout_0 = (~prop_0 & gen_0) | (prop_0 & CIN);
wire sum_0 = prop_0 ^ (pass_cin_0 & CIN);

//Second Half
lut_mux4 (y3_1, INIT1[15], INIT1[14], INIT1[13], INIT1[12], B1, A1);
lut_mux4 (y2_1, INIT1[11], INIT1[10], INIT1[9], INIT1[8], B1, A1);
lut_mux4 (y1_1, INIT1[7], INIT1[6], INIT1[5], INIT1[4], B1, A1);
lut_mux4 (y0_1, INIT1[3], INIT1[2], INIT1[1], INIT1[0], B1, A1);
lut_mux4 (prop_1, y3_1, y2_1, y1_1, y0_1, D1, C1);

wire gen_1 = (INJECT1_1 == "YES" )? 1'b0 : y0_1;
wire pass_cin_1 = (INJECT1_1 == "YES" )? 1'b0 : 1'b1;
wire cout_1 = (~prop_1 & gen_1) | (prop_1 & cout_0);
wire sum_1 = prop_1 ^ (pass_cin_1 & cout_0); 
//------------------------------------

buf (COUT, cout_1);
buf (S0, sum_0);
buf (S1, sum_1);

endmodule

