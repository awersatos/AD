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
// ---------------------------------------------------------------------
//
// Simulation Library File for ECP
//
// $Header: /home/rel01/env5_1a.34/verilog/pkg/versclibs/data/orca5ecp/RCS/MULT9X9ADDSUBSUM.v,v 1.2 2005/05/19 19:12:32 pradeep Exp $ 
//
`celldefine
`timescale  1 ns / 1 ps

module MULT9X9ADDSUBSUM (SUM19,SUM18,SUM17,SUM16,SUM15,SUM14,SUM13,SUM12,SUM11,SUM10,SUM9,SUM8,SUM7,SUM6,SUM5,SUM4,SUM3,SUM2,SUM1,SUM0,SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0,SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0,A08,A07,A06,A05,A04,A03,A02,A01,A00,A18,A17,A16,A15,A14,A13,A12,A11,A10,A28,A27,A26,A25,A24,A23,A22,A21,A20,A38,A37,A36,A35,A34,A33,A32,A31,A30,B08,B07,B06,B05,B04,B03,B02,B01,B00,B18,B17,B16,B15,B14,B13,B12,B11,B10,B28,B27,B26,B25,B24,B23,B22,B21,B20,B38,B37,B36,B35,B34,B33,B32,B31,B30,SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0,SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0,SIGNEDAB,ADDNSUB1,ADDNSUB3,CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3);
input A08,A07,A06,A05,A04,A03,A02,A01,A00;
input A18,A17,A16,A15,A14,A13,A12,A11,A10;
input A28,A27,A26,A25,A24,A23,A22,A21,A20;
input A38,A37,A36,A35,A34,A33,A32,A31,A30;
input B08,B07,B06,B05,B04,B03,B02,B01,B00;
input B18,B17,B16,B15,B14,B13,B12,B11,B10;
input B28,B27,B26,B25,B24,B23,B22,B21,B20;
input B38,B37,B36,B35,B34,B33,B32,B31,B30;
input SIGNEDAB,ADDNSUB1,ADDNSUB3;
input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3;
input SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0;
input SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0;
output SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0;
output SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0;
output SUM19,SUM18,SUM17,SUM16,SUM15,SUM14,SUM13,SUM12,SUM11,SUM10,SUM9,SUM8,SUM7,SUM6,SUM5,SUM4,SUM3,SUM2,SUM1,SUM0; 

parameter REG_INPUTA0_CLK = "NONE";
parameter REG_INPUTA0_CE = "CE0";
parameter REG_INPUTA0_RST = "RST0";
parameter REG_INPUTA1_CLK = "NONE";
parameter REG_INPUTA1_CE = "CE0";
parameter REG_INPUTA1_RST = "RST0";
parameter REG_INPUTA2_CLK = "NONE";
parameter REG_INPUTA2_CE = "CE0";
parameter REG_INPUTA2_RST = "RST0";
parameter REG_INPUTA3_CLK = "NONE";
parameter REG_INPUTA3_CE = "CE0";
parameter REG_INPUTA3_RST = "RST0";
parameter REG_INPUTB0_CLK = "NONE";
parameter REG_INPUTB0_CE = "CE0";
parameter REG_INPUTB0_RST = "RST0";
parameter REG_INPUTB1_CLK = "NONE";
parameter REG_INPUTB1_CE = "CE0";
parameter REG_INPUTB1_RST = "RST0";
parameter REG_INPUTB2_CLK = "NONE";
parameter REG_INPUTB2_CE = "CE0";
parameter REG_INPUTB2_RST = "RST0";
parameter REG_INPUTB3_CLK = "NONE";
parameter REG_INPUTB3_CE = "CE0";
parameter REG_INPUTB3_RST = "RST0";
parameter REG_PIPELINE0_CLK = "NONE";
parameter REG_PIPELINE0_CE = "CE0";
parameter REG_PIPELINE0_RST = "RST0";
parameter REG_PIPELINE1_CLK = "NONE";
parameter REG_PIPELINE1_CE = "CE0";
parameter REG_PIPELINE1_RST = "RST0";
parameter REG_PIPELINE2_CLK = "NONE";
parameter REG_PIPELINE2_CE = "CE0";
parameter REG_PIPELINE2_RST = "RST0";
parameter REG_PIPELINE3_CLK = "NONE";
parameter REG_PIPELINE3_CE = "CE0";
parameter REG_PIPELINE3_RST = "RST0";
parameter REG_OUTPUT_CLK = "NONE";
parameter REG_OUTPUT_CE = "CE0";
parameter REG_OUTPUT_RST = "RST0";
parameter REG_SIGNEDAB_0_CLK = "NONE";
parameter REG_SIGNEDAB_0_CE = "CE0";
parameter REG_SIGNEDAB_0_RST = "RST0";
parameter REG_SIGNEDAB_1_CLK = "NONE";
parameter REG_SIGNEDAB_1_CE = "CE0";
parameter REG_SIGNEDAB_1_RST = "RST0";
parameter REG_ADDNSUB1_0_CLK = "NONE";
parameter REG_ADDNSUB1_0_CE = "CE0";
parameter REG_ADDNSUB1_0_RST = "RST0";
parameter REG_ADDNSUB1_1_CLK = "NONE";
parameter REG_ADDNSUB1_1_CE = "CE0";
parameter REG_ADDNSUB1_1_RST = "RST0";
parameter REG_ADDNSUB3_0_CLK = "NONE";
parameter REG_ADDNSUB3_0_CE = "CE0";
parameter REG_ADDNSUB3_0_RST = "RST0";
parameter REG_ADDNSUB3_1_CLK = "NONE";
parameter REG_ADDNSUB3_1_CE = "CE0";
parameter REG_ADDNSUB3_1_RST = "RST0";
parameter SHIFT_IN_A0 = "FALSE";
parameter SHIFT_IN_A1 = "FALSE";
parameter SHIFT_IN_A2 = "FALSE";
parameter SHIFT_IN_A3 = "FALSE";
parameter SHIFT_IN_B0 = "FALSE";
parameter SHIFT_IN_B1 = "FALSE";
parameter SHIFT_IN_B2 = "FALSE";
parameter SHIFT_IN_B3 = "FALSE";
parameter GSR = "ENABLED";


supply0 GND; 
supply1 VCC; 

    wire CE0b,CE1b,CE2b,CE3b,CLK0b,CLK1b,CLK2b,CLK3b,RST0b,RST1b,RST2b,RST3b;

    wire [8:0] a0_sig, b0_sig;
    wire [8:0] a1_sig, b1_sig;
    wire [8:0] a2_sig, b2_sig;
    wire [8:0] a3_sig, b3_sig;

    reg  [8:0] a0_sig_reg, b0_sig_reg;
    reg  [8:0] a1_sig_reg, b1_sig_reg;
    reg  [8:0] a2_sig_reg, b2_sig_reg;
    reg  [8:0] a3_sig_reg, b3_sig_reg;

    reg  [8:0] a0_sig_gen, b0_sig_gen;
    reg  [8:0] a1_sig_gen, b1_sig_gen;
    reg  [8:0] a2_sig_gen, b2_sig_gen;
    reg  [8:0] a3_sig_gen, b3_sig_gen;

    reg [8:0] a0_sig_p, b0_sig_p;
    reg [8:0] a1_sig_p, b1_sig_p;
    reg [8:0] a2_sig_p, b2_sig_p;
    reg [8:0] a3_sig_p, b3_sig_p;

    wire [8:0] a_sig_s, b_sig_s;
    reg [8:0] a_sig_s_1, b_sig_s_1;

    wire [17:0] p0_sig_i;
    wire [17:0] p1_sig_i;
    wire [17:0] p2_sig_i;
    wire [17:0] p3_sig_i;

    reg [18:0] p0_sig_i_e;
    reg [18:0] p1_sig_i_e;
    reg [18:0] p2_sig_i_e;
    reg [18:0] p3_sig_i_e;

    reg [17:0] p0_sig_i_reg, p0_sig_i_reg1;
    reg [17:0] p1_sig_i_reg, p1_sig_i_reg1;
    reg [17:0] p2_sig_i_reg, p2_sig_i_reg1;
    reg [17:0] p3_sig_i_reg, p3_sig_i_reg1;

    reg [8:0] sroa_reg,srob_reg;
    reg [8:0] sroa_reg1,srob_reg1;
    reg [8:0] sroa_reg2,srob_reg2;
    //reg [8:0] sroa_reg3,srob_reg3;
    wire [8:0] sroa_reg3,srob_reg3;

    wire [18:0] sum0_sig_i;
    wire [18:0] sum1_sig_i;
    reg [19:0] sum0_sig_i_e;
    reg [19:0] sum1_sig_i_e;

    wire [19:0] sumt_sig;
    reg [19:0] sumt_reg;

    reg [19:0] sum_o;

    reg [17:0] a0_sig_m, b0_sig_m;
    reg [17:0] a1_sig_m, b1_sig_m;
    reg [17:0] a2_sig_m, b2_sig_m;
    reg [17:0] a3_sig_m, b3_sig_m;

    wire signedab_sig;
    reg  signedab_p1;
    reg  signedab_p2;
    reg  signedab_reg1;
    reg  signedab_reg2;

    wire addnsub1_sig;
    reg  addnsub1_p1;
    reg  addnsub1_p2;
    reg  addnsub1_reg1;
    reg  addnsub1_reg2;

    wire addnsub3_sig;
    reg  addnsub3_p1;
    reg  addnsub3_p2;
    reg  addnsub3_reg1;
    reg  addnsub3_reg2;

    reg input_a0_clk_sig,input_a0_ce_sig,input_a0_rst_sig;
    reg input_a1_clk_sig,input_a1_ce_sig,input_a1_rst_sig;
    reg input_a2_clk_sig,input_a2_ce_sig,input_a2_rst_sig;
    reg input_a3_clk_sig,input_a3_ce_sig,input_a3_rst_sig;

    reg input_b0_clk_sig,input_b0_ce_sig,input_b0_rst_sig;
    reg input_b1_clk_sig,input_b1_ce_sig,input_b1_rst_sig;
    reg input_b2_clk_sig,input_b2_ce_sig,input_b2_rst_sig;
    reg input_b3_clk_sig,input_b3_ce_sig,input_b3_rst_sig;

    reg pipeline0_clk_sig,pipeline0_ce_sig,pipeline0_rst_sig;
    reg pipeline1_clk_sig,pipeline1_ce_sig,pipeline1_rst_sig;
    reg pipeline2_clk_sig,pipeline2_ce_sig,pipeline2_rst_sig;
    reg pipeline3_clk_sig,pipeline3_ce_sig,pipeline3_rst_sig;

    reg output_clk_sig,output_ce_sig,output_rst_sig;

    wire input_a0_rst_ogsr;
    wire input_a1_rst_ogsr;
    wire input_a2_rst_ogsr;
    wire input_a3_rst_ogsr;
    wire input_b0_rst_ogsr;
    wire input_b1_rst_ogsr;
    wire input_b2_rst_ogsr;
    wire input_b3_rst_ogsr;
    wire pipeline0_rst_ogsr;
    wire pipeline1_rst_ogsr;
    wire pipeline2_rst_ogsr;
    wire pipeline3_rst_ogsr;
    wire output_rst_ogsr;
    wire reg_signedab_0_rst_ogsr;
    wire reg_signedab_1_rst_ogsr;
    wire reg_addnsub1_0_rst_ogsr;
    wire reg_addnsub1_1_rst_ogsr;
    wire reg_addnsub3_0_rst_ogsr;
    wire reg_addnsub3_1_rst_ogsr;
    wire reg_accumsload_0_rst_ogsr;
    wire reg_accumsload_1_rst_ogsr;

    reg reg_addnsub1_0_clk_sig,reg_addnsub1_0_ce_sig,reg_addnsub1_0_rst_sig;
    reg reg_addnsub1_1_clk_sig,reg_addnsub1_1_ce_sig,reg_addnsub1_1_rst_sig;

    reg reg_addnsub3_0_clk_sig,reg_addnsub3_0_ce_sig,reg_addnsub3_0_rst_sig;
    reg reg_addnsub3_1_clk_sig,reg_addnsub3_1_ce_sig,reg_addnsub3_1_rst_sig;

    reg reg_signedab_0_clk_sig,reg_signedab_0_ce_sig,reg_signedab_0_rst_sig;
    reg reg_signedab_1_clk_sig,reg_signedab_1_ce_sig,reg_signedab_1_rst_sig;

    reg SRN;

    tri1 GSR_sig = GSR_INST.GSRNET;
    tri1 PUR_sig = PUR_INST.PURNET;

    not (SR1, SRN);

    always @ (GSR_sig or PUR_sig ) 
    begin
      if (GSR == "ENABLED") 
        begin
         SRN = GSR_sig & PUR_sig ;
        end
      else if (GSR == "DISABLED")
        SRN = PUR_sig;
    end

    or INST1 (input_a0_rst_ogsr, input_a0_rst_sig, SR1);
    or INST2 (input_a1_rst_ogsr, input_a1_rst_sig, SR1);
    or INST3 (input_a2_rst_ogsr, input_a2_rst_sig, SR1);
    or INST4 (input_a3_rst_ogsr, input_a3_rst_sig, SR1);
    or INST5 (input_b0_rst_ogsr, input_b0_rst_sig, SR1);
    or INST6 (input_b1_rst_ogsr, input_b1_rst_sig, SR1);
    or INST7 (input_b2_rst_ogsr, input_b2_rst_sig, SR1);
    or INST8 (input_b3_rst_ogsr, input_b3_rst_sig, SR1);
    or INST9 (pipeline0_rst_ogsr, pipeline0_rst_sig, SR1);
    or INST10 (pipeline1_rst_ogsr, pipeline1_rst_sig, SR1);
    or INST11 (pipeline2_rst_ogsr, pipeline2_rst_sig, SR1);
    or INST12 (pipeline3_rst_ogsr, pipeline3_rst_sig, SR1);
    or INST13 (output_rst_ogsr, output_rst_sig, SR1);
    or INST14 (reg_signedab_0_rst_ogsr, reg_signedab_0_rst_sig, SR1);
    or INST15 (reg_signedab_1_rst_ogsr, reg_signedab_1_rst_sig, SR1);
    or INST16 (reg_addnsub1_0_rst_ogsr, reg_addnsub1_0_rst_sig, SR1);
    or INST17 (reg_addnsub1_1_rst_ogsr, reg_addnsub1_1_rst_sig, SR1);
    or INST18 (reg_addnsub3_0_rst_ogsr, reg_addnsub3_0_rst_sig, SR1);
    or INST19 (reg_addnsub3_1_rst_ogsr, reg_addnsub3_1_rst_sig, SR1);

    buf (CE0b, CE0);
    buf (CE1b, CE1);
    buf (CE2b, CE2);
    buf (CE3b, CE3);
    buf (CLK0b, CLK0);
    buf (CLK1b, CLK1);
    buf (CLK2b, CLK2);
    buf (CLK3b, CLK3);
    buf (RST0b, RST0);
    buf (RST1b, RST1);
    buf (RST2b, RST2);
    buf (RST3b, RST3);

    buf inst_A00 (a0_sig[0], A00);
    buf inst_A01 (a0_sig[1], A01);
    buf inst_A02 (a0_sig[2], A02);
    buf inst_A03 (a0_sig[3], A03);
    buf inst_A04 (a0_sig[4], A04);
    buf inst_A05 (a0_sig[5], A05);
    buf inst_A06 (a0_sig[6], A06);
    buf inst_A07 (a0_sig[7], A07);
    buf inst_A08 (a0_sig[8], A08);
    buf inst_B00 (b0_sig[0], B00);
    buf inst_B01 (b0_sig[1], B01);
    buf inst_B02 (b0_sig[2], B02);
    buf inst_B03 (b0_sig[3], B03);
    buf inst_B04 (b0_sig[4], B04);
    buf inst_B05 (b0_sig[5], B05);
    buf inst_B06 (b0_sig[6], B06);
    buf inst_B07 (b0_sig[7], B07);
    buf inst_B08 (b0_sig[8], B08);

    buf inst_A10 (a1_sig[0], A10);
    buf inst_A11 (a1_sig[1], A11);
    buf inst_A12 (a1_sig[2], A12);
    buf inst_A13 (a1_sig[3], A13);
    buf inst_A14 (a1_sig[4], A14);
    buf inst_A15 (a1_sig[5], A15);
    buf inst_A16 (a1_sig[6], A16);
    buf inst_A17 (a1_sig[7], A17);
    buf inst_A18 (a1_sig[8], A18);
    buf inst_B10 (b1_sig[0], B10);
    buf inst_B11 (b1_sig[1], B11);
    buf inst_B12 (b1_sig[2], B12);
    buf inst_B13 (b1_sig[3], B13);
    buf inst_B14 (b1_sig[4], B14);
    buf inst_B15 (b1_sig[5], B15);
    buf inst_B16 (b1_sig[6], B16);
    buf inst_B17 (b1_sig[7], B17);
    buf inst_B18 (b1_sig[8], B18);

    buf inst_A20 (a2_sig[0], A20);
    buf inst_A21 (a2_sig[1], A21);
    buf inst_A22 (a2_sig[2], A22);
    buf inst_A23 (a2_sig[3], A23);
    buf inst_A24 (a2_sig[4], A24);
    buf inst_A25 (a2_sig[5], A25);
    buf inst_A26 (a2_sig[6], A26);
    buf inst_A27 (a2_sig[7], A27);
    buf inst_A28 (a2_sig[8], A28);
    buf inst_B20 (b2_sig[0], B20);
    buf inst_B21 (b2_sig[1], B21);
    buf inst_B22 (b2_sig[2], B22);
    buf inst_B23 (b2_sig[3], B23);
    buf inst_B24 (b2_sig[4], B24);
    buf inst_B25 (b2_sig[5], B25);
    buf inst_B26 (b2_sig[6], B26);
    buf inst_B27 (b2_sig[7], B27);
    buf inst_B28 (b2_sig[8], B28);

    buf inst_A30 (a3_sig[0], A30);
    buf inst_A31 (a3_sig[1], A31);
    buf inst_A32 (a3_sig[2], A32);
    buf inst_A33 (a3_sig[3], A33);
    buf inst_A34 (a3_sig[4], A34);
    buf inst_A35 (a3_sig[5], A35);
    buf inst_A36 (a3_sig[6], A36);
    buf inst_A37 (a3_sig[7], A37);
    buf inst_A38 (a3_sig[8], A38);
    buf inst_B30 (b3_sig[0], B30);
    buf inst_B31 (b3_sig[1], B31);
    buf inst_B32 (b3_sig[2], B32);
    buf inst_B33 (b3_sig[3], B33);
    buf inst_B34 (b3_sig[4], B34);
    buf inst_B35 (b3_sig[5], B35);
    buf inst_B36 (b3_sig[6], B36);
    buf inst_B37 (b3_sig[7], B37);
    buf inst_B38 (b3_sig[8], B38);

    buf inst_SIGNEDAB (signedab_sig, SIGNEDAB);
    buf inst_ADDNSUB1 (addnsub1_sig, ADDNSUB1);
    buf inst_ADDNSUB3 (addnsub3_sig, ADDNSUB3);

    buf inst_s_A0 (a_sig_s[0], SRIA0);
    buf inst_s_A1 (a_sig_s[1], SRIA1);
    buf inst_s_A2 (a_sig_s[2], SRIA2);
    buf inst_s_A3 (a_sig_s[3], SRIA3);
    buf inst_s_A4 (a_sig_s[4], SRIA4);
    buf inst_s_A5 (a_sig_s[5], SRIA5);
    buf inst_s_A6 (a_sig_s[6], SRIA6);
    buf inst_s_A7 (a_sig_s[7], SRIA7);
    buf inst_s_A8 (a_sig_s[8], SRIA8);

    buf inst_s_B0 (b_sig_s[0], SRIB0);
    buf inst_s_B1 (b_sig_s[1], SRIB1);
    buf inst_s_B2 (b_sig_s[2], SRIB2);
    buf inst_s_B3 (b_sig_s[3], SRIB3);
    buf inst_s_B4 (b_sig_s[4], SRIB4);
    buf inst_s_B5 (b_sig_s[5], SRIB5);
    buf inst_s_B6 (b_sig_s[6], SRIB6);
    buf inst_s_B7 (b_sig_s[7], SRIB7);
    buf inst_s_B8 (b_sig_s[8], SRIB8);

    buf inst_SUM0 (SUM0, sum_o[0]);
    buf inst_SUM1 (SUM1, sum_o[1]);
    buf inst_SUM2 (SUM2, sum_o[2]);
    buf inst_SUM3 (SUM3, sum_o[3]);
    buf inst_SUM4 (SUM4, sum_o[4]);
    buf inst_SUM5 (SUM5, sum_o[5]);
    buf inst_SUM6 (SUM6, sum_o[6]);
    buf inst_SUM7 (SUM7, sum_o[7]);
    buf inst_SUM8 (SUM8, sum_o[8]);
    buf inst_SUM9 (SUM9, sum_o[9]);
    buf inst_SUM10 (SUM10, sum_o[10]);
    buf inst_SUM11 (SUM11, sum_o[11]);
    buf inst_SUM12 (SUM12, sum_o[12]);
    buf inst_SUM13 (SUM13, sum_o[13]);
    buf inst_SUM14 (SUM14, sum_o[14]);
    buf inst_SUM15 (SUM15, sum_o[15]);
    buf inst_SUM16 (SUM16, sum_o[16]);
    buf inst_SUM17 (SUM17, sum_o[17]);
    buf inst_SUM18 (SUM18, sum_o[18]);
    buf inst_SUM19 (SUM19, sum_o[19]);

    buf inst_SROA0 (SROA0, sroa_reg3[0]);
    buf inst_SROA1 (SROA1, sroa_reg3[1]);
    buf inst_SROA2 (SROA2, sroa_reg3[2]);
    buf inst_SROA3 (SROA3, sroa_reg3[3]);
    buf inst_SROA4 (SROA4, sroa_reg3[4]);
    buf inst_SROA5 (SROA5, sroa_reg3[5]);
    buf inst_SROA6 (SROA6, sroa_reg3[6]);
    buf inst_SROA7 (SROA7, sroa_reg3[7]);
    buf inst_SROA8 (SROA8, sroa_reg3[8]);

    buf inst_SROB0 (SROB0, srob_reg3[0]);
    buf inst_SROB1 (SROB1, srob_reg3[1]);
    buf inst_SROB2 (SROB2, srob_reg3[2]);
    buf inst_SROB3 (SROB3, srob_reg3[3]);
    buf inst_SROB4 (SROB4, srob_reg3[4]);
    buf inst_SROB5 (SROB5, srob_reg3[5]);
    buf inst_SROB6 (SROB6, srob_reg3[6]);
    buf inst_SROB7 (SROB7, srob_reg3[7]);
    buf inst_SROB8 (SROB8, srob_reg3[8]);

    always @(a0_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          a0_sig_m[8:0] = a0_sig_gen[8:0];
          a0_sig_m[17:9] = { a0_sig_gen[8],
                            a0_sig_gen[8],
                            a0_sig_gen[8],
                            a0_sig_gen[8],
                            a0_sig_gen[8],
                            a0_sig_gen[8],
                            a0_sig_gen[8],
                            a0_sig_gen[8],
                            a0_sig_gen[8]};
        end
      else 
        begin
          a0_sig_m[8:0] =  a0_sig_gen[8:0];
          a0_sig_m[17:9] = 0;
        end
    end

    always @(a1_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          a1_sig_m[8:0] = a1_sig_gen[8:0];
          a1_sig_m[17:9] = { a1_sig_gen[8],
                            a1_sig_gen[8],
                            a1_sig_gen[8],
                            a1_sig_gen[8],
                            a1_sig_gen[8],
                            a1_sig_gen[8],
                            a1_sig_gen[8],
                            a1_sig_gen[8],
                            a1_sig_gen[8]};
        end
      else 
        begin
          a1_sig_m[8:0] =  a1_sig_gen[8:0];
          a1_sig_m[17:9] = 0;
        end
    end

    always @(a2_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          a2_sig_m[8:0] = a2_sig_gen[8:0];
          a2_sig_m[17:9] = { a2_sig_gen[8],
                            a2_sig_gen[8],
                            a2_sig_gen[8],
                            a2_sig_gen[8],
                            a2_sig_gen[8],
                            a2_sig_gen[8],
                            a2_sig_gen[8],
                            a2_sig_gen[8],
                            a2_sig_gen[8]};
        end
      else 
        begin
          a2_sig_m[8:0] =  a2_sig_gen[8:0];
          a2_sig_m[17:9] = 0;
        end
    end

    always @(a3_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          a3_sig_m[8:0] = a3_sig_gen[8:0];
          a3_sig_m[17:9] = { a3_sig_gen[8],
                            a3_sig_gen[8],
                            a3_sig_gen[8],
                            a3_sig_gen[8],
                            a3_sig_gen[8],
                            a3_sig_gen[8],
                            a3_sig_gen[8],
                            a3_sig_gen[8],
                            a3_sig_gen[8]};
        end
      else 
        begin
          a3_sig_m[8:0] =  a3_sig_gen[8:0];
          a3_sig_m[17:9] = 0;
        end
    end

    always @(b0_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          b0_sig_m[8:0] = b0_sig_gen[8:0];
          b0_sig_m[17:9] = {b0_sig_gen[8],
                           b0_sig_gen[8],
                           b0_sig_gen[8],
                           b0_sig_gen[8],
                           b0_sig_gen[8],
                           b0_sig_gen[8],
                           b0_sig_gen[8],
                           b0_sig_gen[8],
                           b0_sig_gen[8]};
        end
      else 
        begin
          b0_sig_m[8:0] = b0_sig_gen[8:0];
          b0_sig_m[17:9] = 0;
        end
    end

    always @(b1_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          b1_sig_m[8:0] = b1_sig_gen[8:0];
          b1_sig_m[17:9] = {b1_sig_gen[8],
                           b1_sig_gen[8],
                           b1_sig_gen[8],
                           b1_sig_gen[8],
                           b1_sig_gen[8],
                           b1_sig_gen[8],
                           b1_sig_gen[8],
                           b1_sig_gen[8],
                           b1_sig_gen[8]};
        end
      else 
        begin
          b1_sig_m[8:0] = b1_sig_gen[8:0];
          b1_sig_m[17:9] = 0;
        end
    end

    always @(b2_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          b2_sig_m[8:0] = b2_sig_gen[8:0];
          b2_sig_m[17:9] = {b2_sig_gen[8],
                           b2_sig_gen[8],
                           b2_sig_gen[8],
                           b2_sig_gen[8],
                           b2_sig_gen[8],
                           b2_sig_gen[8],
                           b2_sig_gen[8],
                           b2_sig_gen[8],
                           b2_sig_gen[8]};
        end
      else 
        begin
          b2_sig_m[8:0] = b2_sig_gen[8:0];
          b2_sig_m[17:9] = 0;
        end
    end

    always @(b3_sig_gen or signedab_p1)
    begin
      if (signedab_p1 == 1'b1)
        begin
          b3_sig_m[8:0] = b3_sig_gen[8:0];
          b3_sig_m[17:9] = {b3_sig_gen[8],
                           b3_sig_gen[8],
                           b3_sig_gen[8],
                           b3_sig_gen[8],
                           b3_sig_gen[8],
                           b3_sig_gen[8],
                           b3_sig_gen[8],
                           b3_sig_gen[8],
                           b3_sig_gen[8]};
        end
      else 
        begin
          b3_sig_m[8:0] = b3_sig_gen[8:0];
          b3_sig_m[17:9] = 0;
        end
    end

    always @(a_sig_s_1 or a0_sig_p)
    begin
      if (SHIFT_IN_A0 == "TRUE")
          a0_sig_gen = a_sig_s_1;
      else if (SHIFT_IN_A0 == "FALSE")
          a0_sig_gen = a0_sig_p;
    end

    always @(sroa_reg or a1_sig_p)
    begin
      if (SHIFT_IN_A1 == "TRUE")
          a1_sig_gen = sroa_reg;
      else if (SHIFT_IN_A1 == "FALSE")
          a1_sig_gen = a1_sig_p;
    end

    always @(sroa_reg1 or a2_sig_p)
    begin
      if (SHIFT_IN_A2 == "TRUE")
          a2_sig_gen = sroa_reg1;
      else if (SHIFT_IN_A2 == "FALSE")
          a2_sig_gen = a2_sig_p;
    end

    always @(sroa_reg2 or a3_sig_p)
    begin
      if (SHIFT_IN_A3 == "TRUE")
          a3_sig_gen = sroa_reg2;
      else if (SHIFT_IN_A3 == "FALSE")
          a3_sig_gen = a3_sig_p;
    end

    always @(b_sig_s_1 or b0_sig_p)
    begin
      if (SHIFT_IN_B0 == "TRUE")
          b0_sig_gen = b_sig_s_1;
      else if (SHIFT_IN_B0 == "FALSE")
          b0_sig_gen = b0_sig_p;
    end

    always @(srob_reg or b1_sig_p)
    begin
      if (SHIFT_IN_B1 == "TRUE")
          b1_sig_gen = srob_reg;
      else if (SHIFT_IN_B1 == "FALSE")
          b1_sig_gen = b1_sig_p;
    end

    always @(srob_reg1 or b2_sig_p)
    begin
      if (SHIFT_IN_B2 == "TRUE")
          b2_sig_gen = srob_reg1;
      else if (SHIFT_IN_B2 == "FALSE")
          b2_sig_gen = b2_sig_p;
    end

    always @(srob_reg2 or b3_sig_p)
    begin
      if (SHIFT_IN_B3 == "TRUE")
          b3_sig_gen = srob_reg2;
      else if (SHIFT_IN_B3 == "FALSE")
          b3_sig_gen = b3_sig_p;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTA0_CLK == "CLK0")
          input_a0_clk_sig = CLK0b;
      else if (REG_INPUTA0_CLK == "CLK1")
          input_a0_clk_sig = CLK1b;
      else if (REG_INPUTA0_CLK == "CLK2")
          input_a0_clk_sig = CLK2b;
      else if (REG_INPUTA0_CLK == "CLK3")
          input_a0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTA1_CLK == "CLK0")
          input_a1_clk_sig = CLK0b;
      else if (REG_INPUTA1_CLK == "CLK1")
          input_a1_clk_sig = CLK1b;
      else if (REG_INPUTA1_CLK == "CLK2")
          input_a1_clk_sig = CLK2b;
      else if (REG_INPUTA1_CLK == "CLK3")
          input_a1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTA2_CLK == "CLK0")
          input_a2_clk_sig = CLK0b;
      else if (REG_INPUTA2_CLK == "CLK1")
          input_a2_clk_sig = CLK1b;
      else if (REG_INPUTA2_CLK == "CLK2")
          input_a2_clk_sig = CLK2b;
      else if (REG_INPUTA2_CLK == "CLK3")
          input_a2_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTA3_CLK == "CLK0")
          input_a3_clk_sig = CLK0b;
      else if (REG_INPUTA3_CLK == "CLK1")
          input_a3_clk_sig = CLK1b;
      else if (REG_INPUTA3_CLK == "CLK2")
          input_a3_clk_sig = CLK2b;
      else if (REG_INPUTA3_CLK == "CLK3")
          input_a3_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTB0_CLK == "CLK0")
          input_b0_clk_sig = CLK0b;
      else if (REG_INPUTB0_CLK == "CLK1")
          input_b0_clk_sig = CLK1b;
      else if (REG_INPUTB0_CLK == "CLK2")
          input_b0_clk_sig = CLK2b;
      else if (REG_INPUTB0_CLK == "CLK3")
          input_b0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTB1_CLK == "CLK0")
          input_b1_clk_sig = CLK0b;
      else if (REG_INPUTB1_CLK == "CLK1")
          input_b1_clk_sig = CLK1b;
      else if (REG_INPUTB1_CLK == "CLK2")
          input_b1_clk_sig = CLK2b;
      else if (REG_INPUTB1_CLK == "CLK3")
          input_b1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTB2_CLK == "CLK0")
          input_b2_clk_sig = CLK0b;
      else if (REG_INPUTB2_CLK == "CLK1")
          input_b2_clk_sig = CLK1b;
      else if (REG_INPUTB2_CLK == "CLK2")
          input_b2_clk_sig = CLK2b;
      else if (REG_INPUTB2_CLK == "CLK3")
          input_b2_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTB3_CLK == "CLK0")
          input_b3_clk_sig = CLK0b;
      else if (REG_INPUTB3_CLK == "CLK1")
          input_b3_clk_sig = CLK1b;
      else if (REG_INPUTB3_CLK == "CLK2")
          input_b3_clk_sig = CLK2b;
      else if (REG_INPUTB3_CLK == "CLK3")
          input_b3_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_PIPELINE0_CLK == "CLK0")
          pipeline0_clk_sig = CLK0b;
      else if (REG_PIPELINE0_CLK == "CLK1")
          pipeline0_clk_sig = CLK1b;
      else if (REG_PIPELINE0_CLK == "CLK2")
          pipeline0_clk_sig = CLK2b;
      else if (REG_PIPELINE0_CLK == "CLK3")
          pipeline0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_PIPELINE1_CLK == "CLK0")
          pipeline1_clk_sig = CLK0b;
      else if (REG_PIPELINE1_CLK == "CLK1")
          pipeline1_clk_sig = CLK1b;
      else if (REG_PIPELINE1_CLK == "CLK2")
          pipeline1_clk_sig = CLK2b;
      else if (REG_PIPELINE1_CLK == "CLK3")
          pipeline1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_PIPELINE2_CLK == "CLK0")
          pipeline2_clk_sig = CLK0b;
      else if (REG_PIPELINE2_CLK == "CLK1")
          pipeline2_clk_sig = CLK1b;
      else if (REG_PIPELINE2_CLK == "CLK2")
          pipeline2_clk_sig = CLK2b;
      else if (REG_PIPELINE2_CLK == "CLK3")
          pipeline2_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_PIPELINE3_CLK == "CLK0")
          pipeline3_clk_sig = CLK0b;
      else if (REG_PIPELINE3_CLK == "CLK1")
          pipeline3_clk_sig = CLK1b;
      else if (REG_PIPELINE3_CLK == "CLK2")
          pipeline3_clk_sig = CLK2b;
      else if (REG_PIPELINE3_CLK == "CLK3")
          pipeline3_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDAB_0_CLK == "CLK0")
          reg_signedab_0_clk_sig = CLK0b;
      else if (REG_SIGNEDAB_0_CLK == "CLK1")
          reg_signedab_0_clk_sig = CLK1b;
      else if (REG_SIGNEDAB_0_CLK == "CLK2")
          reg_signedab_0_clk_sig = CLK2b;
      else if (REG_SIGNEDAB_0_CLK == "CLK3")
          reg_signedab_0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDAB_1_CLK == "CLK0")
          reg_signedab_1_clk_sig = CLK0b;
      else if (REG_SIGNEDAB_1_CLK == "CLK1")
          reg_signedab_1_clk_sig = CLK1b;
      else if (REG_SIGNEDAB_1_CLK == "CLK2")
          reg_signedab_1_clk_sig = CLK2b;
      else if (REG_SIGNEDAB_1_CLK == "CLK3")
          reg_signedab_1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ADDNSUB1_0_CLK == "CLK0")
          reg_addnsub1_0_clk_sig = CLK0b;
      else if (REG_ADDNSUB1_0_CLK == "CLK1")
          reg_addnsub1_0_clk_sig = CLK1b;
      else if (REG_ADDNSUB1_0_CLK == "CLK2")
          reg_addnsub1_0_clk_sig = CLK2b;
      else if (REG_ADDNSUB1_0_CLK == "CLK3")
          reg_addnsub1_0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ADDNSUB1_1_CLK == "CLK0")
          reg_addnsub1_1_clk_sig = CLK0b;
      else if (REG_ADDNSUB1_1_CLK == "CLK1")
          reg_addnsub1_1_clk_sig = CLK1b;
      else if (REG_ADDNSUB1_1_CLK == "CLK2")
          reg_addnsub1_1_clk_sig = CLK2b;
      else if (REG_ADDNSUB1_1_CLK == "CLK3")
          reg_addnsub1_1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ADDNSUB3_0_CLK == "CLK0")
          reg_addnsub3_0_clk_sig = CLK0b;
      else if (REG_ADDNSUB3_0_CLK == "CLK1")
          reg_addnsub3_0_clk_sig = CLK1b;
      else if (REG_ADDNSUB3_0_CLK == "CLK2")
          reg_addnsub3_0_clk_sig = CLK2b;
      else if (REG_ADDNSUB3_0_CLK == "CLK3")
          reg_addnsub3_0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ADDNSUB3_1_CLK == "CLK0")
          reg_addnsub3_1_clk_sig = CLK0b;
      else if (REG_ADDNSUB3_1_CLK == "CLK1")
          reg_addnsub3_1_clk_sig = CLK1b;
      else if (REG_ADDNSUB3_1_CLK == "CLK2")
          reg_addnsub3_1_clk_sig = CLK2b;
      else if (REG_ADDNSUB3_1_CLK == "CLK3")
          reg_addnsub3_1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_OUTPUT_CLK == "CLK0")
          output_clk_sig = CLK0b;
      else if (REG_OUTPUT_CLK == "CLK1")
          output_clk_sig = CLK1b;
      else if (REG_OUTPUT_CLK == "CLK2")
          output_clk_sig = CLK2b;
      else if (REG_OUTPUT_CLK == "CLK3")
          output_clk_sig = CLK3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTA0_CE == "CE0")
          input_a0_ce_sig = CE0b;
      else if (REG_INPUTA0_CE == "CE1")
          input_a0_ce_sig = CE1b;
      else if (REG_INPUTA0_CE == "CE2")
          input_a0_ce_sig = CE2b;
      else if (REG_INPUTA0_CE == "CE3")
          input_a0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTA1_CE == "CE0")
          input_a1_ce_sig = CE0b;
      else if (REG_INPUTA1_CE == "CE1")
          input_a1_ce_sig = CE1b;
      else if (REG_INPUTA1_CE == "CE2")
          input_a1_ce_sig = CE2b;
      else if (REG_INPUTA1_CE == "CE3")
          input_a1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTA2_CE == "CE0")
          input_a2_ce_sig = CE0b;
      else if (REG_INPUTA2_CE == "CE1")
          input_a2_ce_sig = CE1b;
      else if (REG_INPUTA2_CE == "CE2")
          input_a2_ce_sig = CE2b;
      else if (REG_INPUTA2_CE == "CE3")
          input_a2_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTA3_CE == "CE0")
          input_a3_ce_sig = CE0b;
      else if (REG_INPUTA3_CE == "CE1")
          input_a3_ce_sig = CE1b;
      else if (REG_INPUTA3_CE == "CE2")
          input_a3_ce_sig = CE2b;
      else if (REG_INPUTA2_CE == "CE3")
          input_a3_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTB0_CE == "CE0")
          input_b0_ce_sig = CE0b;
      else if (REG_INPUTB0_CE == "CE1")
          input_b0_ce_sig = CE1b;
      else if (REG_INPUTB0_CE == "CE2")
          input_b0_ce_sig = CE2b;
      else if (REG_INPUTB0_CE == "CE3")
          input_b0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTB1_CE == "CE0")
          input_b1_ce_sig = CE0b;
      else if (REG_INPUTB1_CE == "CE1")
          input_b1_ce_sig = CE1b;
      else if (REG_INPUTB1_CE == "CE2")
          input_b1_ce_sig = CE2b;
      else if (REG_INPUTB1_CE == "CE3")
          input_b1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTB2_CE == "CE0")
          input_b2_ce_sig = CE0b;
      else if (REG_INPUTB2_CE == "CE1")
          input_b2_ce_sig = CE1b;
      else if (REG_INPUTB2_CE == "CE2")
          input_b2_ce_sig = CE2b;
      else if (REG_INPUTB2_CE == "CE3")
          input_b2_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTB3_CE == "CE0")
          input_b3_ce_sig = CE0b;
      else if (REG_INPUTB3_CE == "CE1")
          input_b3_ce_sig = CE1b;
      else if (REG_INPUTB3_CE == "CE2")
          input_b3_ce_sig = CE2b;
      else if (REG_INPUTB3_CE == "CE3")
          input_b3_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_PIPELINE0_CE == "CE0")
          pipeline0_ce_sig = CE0b;
      else if (REG_PIPELINE0_CE == "CE1")
          pipeline0_ce_sig = CE1b;
      else if (REG_PIPELINE0_CE == "CE2")
          pipeline0_ce_sig = CE2b;
      else if (REG_PIPELINE0_CE == "CE3")
          pipeline0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_PIPELINE1_CE == "CE0")
          pipeline1_ce_sig = CE0b;
      else if (REG_PIPELINE1_CE == "CE1")
          pipeline1_ce_sig = CE1b;
      else if (REG_PIPELINE1_CE == "CE2")
          pipeline1_ce_sig = CE2b;
      else if (REG_PIPELINE1_CE == "CE3")
          pipeline1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_PIPELINE2_CE == "CE0")
          pipeline2_ce_sig = CE0b;
      else if (REG_PIPELINE2_CE == "CE1")
          pipeline2_ce_sig = CE1b;
      else if (REG_PIPELINE2_CE == "CE2")
          pipeline2_ce_sig = CE2b;
      else if (REG_PIPELINE2_CE == "CE3")
          pipeline2_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_PIPELINE3_CE == "CE0")
          pipeline3_ce_sig = CE0b;
      else if (REG_PIPELINE3_CE == "CE1")
          pipeline3_ce_sig = CE1b;
      else if (REG_PIPELINE3_CE == "CE2")
          pipeline3_ce_sig = CE2b;
      else if (REG_PIPELINE3_CE == "CE3")
          pipeline3_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_OUTPUT_CE == "CE0")
          output_ce_sig = CE0b;
      else if (REG_OUTPUT_CE == "CE1")
          output_ce_sig = CE1b;
      else if (REG_OUTPUT_CE == "CE2")
          output_ce_sig = CE2b;
      else if (REG_OUTPUT_CE == "CE3")
          output_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDAB_0_CE == "CE0")
          reg_signedab_0_ce_sig = CE0b;
      else if (REG_SIGNEDAB_0_CE == "CE1")
          reg_signedab_0_ce_sig = CE1b;
      else if (REG_SIGNEDAB_0_CE == "CE2")
          reg_signedab_0_ce_sig = CE2b;
      else if (REG_SIGNEDAB_0_CE == "CE3")
          reg_signedab_0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDAB_1_CE == "CE0")
          reg_signedab_1_ce_sig = CE0b;
      else if (REG_SIGNEDAB_1_CE == "CE1")
          reg_signedab_1_ce_sig = CE1b;
      else if (REG_SIGNEDAB_1_CE == "CE2")
          reg_signedab_1_ce_sig = CE2b;
      else if (REG_SIGNEDAB_1_CE == "CE3")
          reg_signedab_1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ADDNSUB1_0_CE == "CE0")
          reg_addnsub1_0_ce_sig = CE0b;
      else if (REG_ADDNSUB1_0_CE == "CE1")
          reg_addnsub1_0_ce_sig = CE1b;
      else if (REG_ADDNSUB1_0_CE == "CE2")
          reg_addnsub1_0_ce_sig = CE2b;
      else if (REG_ADDNSUB1_0_CE == "CE3")
          reg_addnsub1_0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ADDNSUB1_1_CE == "CE0")
          reg_addnsub1_1_ce_sig = CE0b;
      else if (REG_ADDNSUB1_1_CE == "CE1")
          reg_addnsub1_1_ce_sig = CE1b;
      else if (REG_ADDNSUB1_1_CE == "CE2")
          reg_addnsub1_1_ce_sig = CE2b;
      else if (REG_ADDNSUB1_1_CE == "CE3")
          reg_addnsub1_1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ADDNSUB3_0_CE == "CE0")
          reg_addnsub3_0_ce_sig = CE0b;
      else if (REG_ADDNSUB3_0_CE == "CE1")
          reg_addnsub3_0_ce_sig = CE1b;
      else if (REG_ADDNSUB3_0_CE == "CE2")
          reg_addnsub3_0_ce_sig = CE2b;
      else if (REG_ADDNSUB3_0_CE == "CE3")
          reg_addnsub3_0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ADDNSUB3_1_CE == "CE0")
          reg_addnsub3_1_ce_sig = CE0b;
      else if (REG_ADDNSUB3_1_CE == "CE1")
          reg_addnsub3_1_ce_sig = CE1b;
      else if (REG_ADDNSUB3_1_CE == "CE2")
          reg_addnsub3_1_ce_sig = CE2b;
      else if (REG_ADDNSUB3_1_CE == "CE3")
          reg_addnsub3_1_ce_sig = CE3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTA0_RST == "RST0")
          input_a0_rst_sig = RST0b;
      else if (REG_INPUTA0_RST == "RST1")
          input_a0_rst_sig = RST1b;
      else if (REG_INPUTA0_RST == "RST2")
          input_a0_rst_sig = RST2b;
      else if (REG_INPUTA0_RST == "RST3")
          input_a0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTA1_RST == "RST0")
          input_a1_rst_sig = RST0b;
      else if (REG_INPUTA1_RST == "RST1")
          input_a1_rst_sig = RST1b;
      else if (REG_INPUTA1_RST == "RST2")
          input_a1_rst_sig = RST2b;
      else if (REG_INPUTA1_RST == "RST3")
          input_a1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTA2_RST == "RST0")
          input_a2_rst_sig = RST0b;
      else if (REG_INPUTA2_RST == "RST1")
          input_a2_rst_sig = RST1b;
      else if (REG_INPUTA2_RST == "RST2")
          input_a2_rst_sig = RST2b;
      else if (REG_INPUTA2_RST == "RST3")
          input_a2_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTA3_RST == "RST0")
          input_a3_rst_sig = RST0b;
      else if (REG_INPUTA3_RST == "RST1")
          input_a3_rst_sig = RST1b;
      else if (REG_INPUTA3_RST == "RST2")
          input_a3_rst_sig = RST2b;
      else if (REG_INPUTA3_RST == "RST3")
          input_a3_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTB0_RST == "RST0")
          input_b0_rst_sig = RST0b;
      else if (REG_INPUTB0_RST == "RST1")
          input_b0_rst_sig = RST1b;
      else if (REG_INPUTB0_RST == "RST2")
          input_b0_rst_sig = RST2b;
      else if (REG_INPUTB0_RST == "RST3")
          input_b0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTB1_RST == "RST0")
          input_b1_rst_sig = RST0b;
      else if (REG_INPUTB1_RST == "RST1")
          input_b1_rst_sig = RST1b;
      else if (REG_INPUTB1_RST == "RST2")
          input_b1_rst_sig = RST2b;
      else if (REG_INPUTB1_RST == "RST3")
          input_b1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTB2_RST == "RST0")
          input_b2_rst_sig = RST0b;
      else if (REG_INPUTB2_RST == "RST1")
          input_b2_rst_sig = RST1b;
      else if (REG_INPUTB2_RST == "RST2")
          input_b2_rst_sig = RST2b;
      else if (REG_INPUTB2_RST == "RST3")
          input_b2_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTB3_RST == "RST0")
          input_b3_rst_sig = RST0b;
      else if (REG_INPUTB3_RST == "RST1")
          input_b3_rst_sig = RST1b;
      else if (REG_INPUTB3_RST == "RST2")
          input_b3_rst_sig = RST2b;
      else if (REG_INPUTB3_RST == "RST3")
          input_b3_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_PIPELINE0_RST == "RST0")
          pipeline0_rst_sig = RST0b;
      else if (REG_PIPELINE0_RST == "RST1")
          pipeline0_rst_sig = RST1b;
      else if (REG_PIPELINE0_RST == "RST2")
          pipeline0_rst_sig = RST2b;
      else if (REG_PIPELINE0_RST == "RST3")
          pipeline0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_PIPELINE1_RST == "RST0")
          pipeline1_rst_sig = RST0b;
      else if (REG_PIPELINE1_RST == "RST1")
          pipeline1_rst_sig = RST1b;
      else if (REG_PIPELINE1_RST == "RST2")
          pipeline1_rst_sig = RST2b;
      else if (REG_PIPELINE1_RST == "RST3")
          pipeline1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_PIPELINE2_RST == "RST0")
          pipeline2_rst_sig = RST0b;
      else if (REG_PIPELINE2_RST == "RST1")
          pipeline2_rst_sig = RST1b;
      else if (REG_PIPELINE2_RST == "RST2")
          pipeline2_rst_sig = RST2b;
      else if (REG_PIPELINE2_RST == "RST3")
          pipeline2_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_PIPELINE3_RST == "RST0")
          pipeline3_rst_sig = RST0b;
      else if (REG_PIPELINE3_RST == "RST1")
          pipeline3_rst_sig = RST1b;
      else if (REG_PIPELINE3_RST == "RST2")
          pipeline3_rst_sig = RST2b;
      else if (REG_PIPELINE3_RST == "RST3")
          pipeline3_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_OUTPUT_RST == "RST0")
          output_rst_sig = RST0b;
      else if (REG_OUTPUT_RST == "RST1")
          output_rst_sig = RST1b;
      else if (REG_OUTPUT_RST == "RST2")
          output_rst_sig = RST2b;
      else if (REG_OUTPUT_RST == "RST3")
          output_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDAB_0_RST == "RST0")
          reg_signedab_0_rst_sig = RST0b;
      else if (REG_SIGNEDAB_0_RST == "RST1")
          reg_signedab_0_rst_sig = RST1b;
      else if (REG_SIGNEDAB_0_RST == "RST2")
          reg_signedab_0_rst_sig = RST2b;
      else if (REG_SIGNEDAB_0_RST == "RST3")
          reg_signedab_0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDAB_1_RST == "RST0")
          reg_signedab_1_rst_sig = RST0b;
      else if (REG_SIGNEDAB_1_RST == "RST1")
          reg_signedab_1_rst_sig = RST1b;
      else if (REG_SIGNEDAB_1_RST == "RST2")
          reg_signedab_1_rst_sig = RST2b;
      else if (REG_SIGNEDAB_1_RST == "RST3")
          reg_signedab_1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ADDNSUB1_0_RST == "RST0")
          reg_addnsub1_0_rst_sig = RST0b;
      else if (REG_ADDNSUB1_0_RST == "RST1")
          reg_addnsub1_0_rst_sig = RST1b;
      else if (REG_ADDNSUB1_0_RST == "RST2")
          reg_addnsub1_0_rst_sig = RST2b;
      else if (REG_ADDNSUB1_0_RST == "RST3")
          reg_addnsub1_0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ADDNSUB1_1_RST == "RST0")
          reg_addnsub1_1_rst_sig = RST0b;
      else if (REG_ADDNSUB1_1_RST == "RST1")
          reg_addnsub1_1_rst_sig = RST1b;
      else if (REG_ADDNSUB1_1_RST == "RST2")
          reg_addnsub1_1_rst_sig = RST2b;
      else if (REG_ADDNSUB1_1_RST == "RST3")
          reg_addnsub1_1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ADDNSUB3_0_RST == "RST0")
          reg_addnsub3_0_rst_sig = RST0b;
      else if (REG_ADDNSUB3_0_RST == "RST1")
          reg_addnsub3_0_rst_sig = RST1b;
      else if (REG_ADDNSUB3_0_RST == "RST2")
          reg_addnsub3_0_rst_sig = RST2b;
      else if (REG_ADDNSUB3_0_RST == "RST3")
          reg_addnsub3_0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ADDNSUB3_1_RST == "RST0")
          reg_addnsub3_1_rst_sig = RST0b;
      else if (REG_ADDNSUB1_1_RST == "RST1")
          reg_addnsub3_1_rst_sig = RST1b;
      else if (REG_ADDNSUB1_1_RST == "RST2")
          reg_addnsub3_1_rst_sig = RST2b;
      else if (REG_ADDNSUB1_1_RST == "RST3")
          reg_addnsub3_1_rst_sig = RST3b;
    end

    always @(posedge input_a0_clk_sig or posedge input_a0_rst_ogsr)
    begin
      if (input_a0_rst_ogsr == 1'b1)
        begin
          a0_sig_reg <= 0;
          sroa_reg <= 0;
        end
      else if (input_a0_ce_sig == 1'b1)
        begin
          a0_sig_reg <= a0_sig;
          sroa_reg <= a0_sig_gen;
        end
    end

    always @(posedge input_a1_clk_sig or posedge input_a1_rst_ogsr)
    begin
      if (input_a1_rst_ogsr == 1'b1)
        begin
          a1_sig_reg <= 0;
          sroa_reg1 <= 0;
        end
      else if (input_a1_ce_sig == 1'b1)
        begin
          a1_sig_reg <= a1_sig;
          sroa_reg1 <= a1_sig_gen;
        end
    end

    always @(posedge input_a2_clk_sig or posedge input_a2_rst_ogsr)
    begin
      if (input_a2_rst_ogsr == 1'b1)
        begin
          a2_sig_reg <= 0;
          sroa_reg2 <= 0;
        end
      else if (input_a2_ce_sig == 1'b1)
        begin
          a2_sig_reg <= a2_sig;
          sroa_reg2 <= a2_sig_gen;
        end
    end

    always @(posedge input_a3_clk_sig or posedge input_a3_rst_ogsr)
    begin
      if (input_a3_rst_ogsr == 1'b1)
        begin
          a3_sig_reg <= 0;
          //sroa_reg3 <= 0;
        end
      else if (input_a3_ce_sig == 1'b1)
        begin
          a3_sig_reg <= a3_sig;
          //sroa_reg3 <= a3_sig_gen;
        end
    end

    assign sroa_reg3 = a3_sig_gen;

    always @(posedge input_a0_clk_sig or posedge input_a0_rst_ogsr)
    begin
      if (input_a0_rst_ogsr == 1'b1)
        begin
          a_sig_s_1 = 0;
        end
      else if (input_a0_ce_sig == 1'b1)
        begin
          a_sig_s_1 = a_sig_s;
        end
    end


    always @(posedge input_b0_clk_sig or posedge input_b0_rst_ogsr)
    begin
      if (input_b0_rst_ogsr == 1'b1)
        begin
          b0_sig_reg <= 0;
          srob_reg <= 0;
        end
      else if (input_b0_ce_sig == 1'b1)
        begin
          b0_sig_reg <= b0_sig;
          srob_reg <= b0_sig_gen;
        end
    end

    always @(posedge input_b1_clk_sig or posedge input_b1_rst_ogsr)
    begin
      if (input_b1_rst_ogsr == 1'b1)
        begin
          b1_sig_reg <= 0;
          srob_reg1 <= 0;
        end
      else if (input_b1_ce_sig == 1'b1)
        begin
          b1_sig_reg <= b1_sig;
          srob_reg1 <= b1_sig_gen;
        end
    end

    always @(posedge input_b2_clk_sig or posedge input_b2_rst_ogsr)
    begin
      if (input_b2_rst_ogsr == 1'b1)
        begin
          b2_sig_reg <= 0;
          srob_reg2 <= 0;
        end
      else if (input_b2_ce_sig == 1'b1)
        begin
          b2_sig_reg <= b2_sig;
          srob_reg2 <= b2_sig_gen;
        end
    end

    always @(posedge input_b3_clk_sig or posedge input_b3_rst_ogsr)
    begin
      if (input_b3_rst_ogsr == 1'b1)
        begin
          b3_sig_reg <= 0;
          //srob_reg3 <= 0;
        end
      else if (input_b3_ce_sig == 1'b1)
        begin
          b3_sig_reg <= b3_sig;
          //srob_reg3 <= b3_sig_gen;
        end
    end

    assign srob_reg3 = b3_sig_gen;

    always @(posedge input_b0_clk_sig or posedge input_b0_rst_ogsr)
    begin
      if (input_b0_rst_ogsr == 1'b1)
        begin
          b_sig_s_1 = 0;
        end
      else if (input_b0_ce_sig == 1'b1)
        begin
          b_sig_s_1 = b_sig_s;
        end
    end


    always @(posedge reg_signedab_0_clk_sig or posedge reg_signedab_0_rst_ogsr)
    begin
      if (reg_signedab_0_rst_ogsr == 1'b1)
        begin
          signedab_reg1 <= 0;
        end
      else if (reg_signedab_0_ce_sig == 1'b1)
        begin
          signedab_reg1 <= signedab_sig;
        end
    end

    always @(posedge reg_signedab_1_clk_sig or posedge reg_signedab_1_rst_ogsr)
    begin
      if (reg_signedab_1_rst_ogsr == 1'b1)
        begin
          signedab_reg2 <= 0;
        end
      else if (reg_signedab_1_ce_sig == 1'b1)
        begin
          signedab_reg2 <= signedab_p1;
        end
    end

    always @(signedab_sig or signedab_reg1)
    begin
      if (REG_SIGNEDAB_0_CLK == "NONE")
          signedab_p1 = signedab_sig;
      else 
          signedab_p1 = signedab_reg1;
    end

    always @(signedab_p1 or signedab_reg2)
    begin
      if (REG_SIGNEDAB_1_CLK == "NONE")
          signedab_p2 = signedab_p1;
      else 
          signedab_p2 = signedab_reg2;
    end

    always @(posedge reg_addnsub1_0_clk_sig or posedge reg_addnsub1_0_rst_ogsr)
    begin
      if (reg_addnsub1_0_rst_ogsr == 1'b1)
        begin
          addnsub1_reg1 <= 0;
        end
      else if (reg_addnsub1_0_ce_sig == 1'b1)
        begin
          addnsub1_reg1 <= addnsub1_sig;
        end
    end

    always @(posedge reg_addnsub1_1_clk_sig or posedge reg_addnsub1_1_rst_ogsr)
    begin
      if (reg_addnsub1_1_rst_ogsr == 1'b1)
        begin
          addnsub1_reg2 <= 0;
        end
      else if (reg_addnsub1_1_ce_sig == 1'b1)
        begin
          addnsub1_reg2 <= addnsub1_p1;
        end
    end

    always @(addnsub1_sig or addnsub1_reg1)
    begin
      if (REG_ADDNSUB1_0_CLK == "NONE")
          addnsub1_p1 = addnsub1_sig;
      else 
          addnsub1_p1 = addnsub1_reg1;
    end

    always @(addnsub1_p1 or addnsub1_reg2)
    begin
      if (REG_ADDNSUB1_1_CLK == "NONE")
          addnsub1_p2 = addnsub1_p1;
      else 
          addnsub1_p2 = addnsub1_reg2;
    end

    always @(posedge reg_addnsub3_0_clk_sig or posedge reg_addnsub3_0_rst_ogsr)
    begin
      if (reg_addnsub3_0_rst_ogsr == 1'b1)
        begin
          addnsub3_reg1 <= 0;
        end
      else if (reg_addnsub3_0_ce_sig == 1'b1)
        begin
          addnsub3_reg1 <= addnsub3_sig;
        end
    end

    always @(posedge reg_addnsub3_1_clk_sig or posedge reg_addnsub3_1_rst_ogsr)
    begin
      if (reg_addnsub3_1_rst_ogsr == 1'b1)
        begin
          addnsub3_reg2 <= 0;
        end
      else if (reg_addnsub3_1_ce_sig == 1'b1)
        begin
          addnsub3_reg2 <= addnsub3_p1;
        end
    end

    always @(addnsub3_sig or addnsub3_reg1)
    begin
      if (REG_ADDNSUB3_0_CLK == "NONE")
          addnsub3_p1 = addnsub3_sig;
      else 
          addnsub3_p1 = addnsub3_reg1;
    end

    always @(addnsub3_p1 or addnsub3_reg2)
    begin
      if (REG_ADDNSUB3_1_CLK == "NONE")
          addnsub3_p2 = addnsub3_p1;
      else 
          addnsub3_p2 = addnsub3_reg2;
    end
    always @(a0_sig or a0_sig_reg)
    begin
      if (REG_INPUTA0_CLK == "NONE")
          a0_sig_p = a0_sig;
      else 
          a0_sig_p = a0_sig_reg;
    end

    always @(a1_sig or a1_sig_reg)
    begin
      if (REG_INPUTA1_CLK == "NONE")
          a1_sig_p = a1_sig;
      else 
          a1_sig_p = a1_sig_reg;
    end

    always @(a2_sig or a2_sig_reg)
    begin
      if (REG_INPUTA2_CLK == "NONE")
          a2_sig_p = a2_sig;
      else 
          a2_sig_p = a2_sig_reg;
    end

    always @(a3_sig or a3_sig_reg)
    begin
      if (REG_INPUTA3_CLK == "NONE")
          a3_sig_p = a3_sig;
      else 
          a3_sig_p = a3_sig_reg;
    end

    always @(b0_sig or b0_sig_reg)
    begin
      if (REG_INPUTB0_CLK == "NONE")
          b0_sig_p = b0_sig;
      else 
          b0_sig_p = b0_sig_reg;
    end

    always @(b1_sig or b1_sig_reg)
    begin
      if (REG_INPUTB1_CLK == "NONE")
          b1_sig_p = b1_sig;
      else 
          b1_sig_p = b1_sig_reg;
    end

    always @(b2_sig or b2_sig_reg)
    begin
      if (REG_INPUTB2_CLK == "NONE")
          b2_sig_p = b2_sig;
      else 
          b2_sig_p = b2_sig_reg;
    end

    always @(b3_sig or b3_sig_reg)
    begin
      if (REG_INPUTB3_CLK == "NONE")
          b3_sig_p = b3_sig;
      else 
          b3_sig_p = b3_sig_reg;
    end

    assign p0_sig_i = (!a0_sig_m || !b0_sig_m)? 0 : a0_sig_m * b0_sig_m ;
    assign p1_sig_i = (!a1_sig_m || !b1_sig_m)? 0 : a1_sig_m * b1_sig_m ;
    assign p2_sig_i = (!a2_sig_m || !b2_sig_m)? 0 : a2_sig_m * b2_sig_m ;
    assign p3_sig_i = (!a3_sig_m || !b3_sig_m)? 0 : a3_sig_m * b3_sig_m ;

    always @(p0_sig_i_reg1 or signedab_p2)
    begin
      if (signedab_p2 == 1'b1)
        begin
           p0_sig_i_e[17:0] = p0_sig_i_reg1;
           p0_sig_i_e[18] = p0_sig_i_reg1[17];
        end
      else
        begin
           p0_sig_i_e[17:0] = p0_sig_i_reg1;
           p0_sig_i_e[18] = 0;
        end
    end


    always @(p1_sig_i_reg1 or signedab_p2)
    begin
      if (signedab_p2 == 1'b1)
        begin
           p1_sig_i_e[17:0] = p1_sig_i_reg1;
           p1_sig_i_e[18] = p1_sig_i_reg1[17];
        end
      else
        begin
           p1_sig_i_e[17:0] = p1_sig_i_reg1;
           p1_sig_i_e[18] = 0;
        end
    end

    always @(p2_sig_i_reg1 or signedab_p2)
    begin
      if (signedab_p2 == 1'b1)
        begin
           p2_sig_i_e[17:0] = p2_sig_i_reg1;
           p2_sig_i_e[18] = p2_sig_i_reg1[17];
        end
      else
        begin
           p2_sig_i_e[17:0] = p2_sig_i_reg1;
           p2_sig_i_e[18] = 0;
        end
    end

    always @(p3_sig_i_reg1 or signedab_p2)
    begin
      if (signedab_p2 == 1'b1)
        begin
           p3_sig_i_e[17:0] = p3_sig_i_reg1;
           p3_sig_i_e[18] = p3_sig_i_reg1[17];
        end
      else
        begin
           p3_sig_i_e[17:0] = p3_sig_i_reg1;
           p3_sig_i_e[18] = 0;
        end
    end

    always @(posedge pipeline0_clk_sig or posedge pipeline0_rst_ogsr)
    begin
      if (pipeline0_rst_ogsr == 1'b1)
          p0_sig_i_reg <= 0;
      else if (pipeline0_ce_sig == 1'b1)
          p0_sig_i_reg <= p0_sig_i;
    end

    always @(posedge pipeline1_clk_sig or posedge pipeline1_rst_ogsr)
    begin
      if (pipeline1_rst_ogsr == 1'b1)
          p1_sig_i_reg <= 0;
      else if (pipeline1_ce_sig == 1'b1)
          p1_sig_i_reg <= p1_sig_i;
    end

    always @(posedge pipeline2_clk_sig or posedge pipeline2_rst_ogsr)
    begin
      if (pipeline2_rst_ogsr == 1'b1)
          p2_sig_i_reg <= 0;
      else if (pipeline2_ce_sig == 1'b1)
          p2_sig_i_reg <= p2_sig_i;
    end

    always @(posedge pipeline3_clk_sig or posedge pipeline3_rst_ogsr)
    begin
      if (pipeline3_rst_ogsr == 1'b1)
          p3_sig_i_reg <= 0;
      else if (pipeline3_ce_sig == 1'b1)
          p3_sig_i_reg <= p3_sig_i;
    end

    always @(p0_sig_i or p0_sig_i_reg)
    begin
      if (REG_PIPELINE0_CLK == "NONE")
          p0_sig_i_reg1 = p0_sig_i;
      else 
          p0_sig_i_reg1 = p0_sig_i_reg;
    end

    always @(p1_sig_i or p1_sig_i_reg)
    begin
      if (REG_PIPELINE1_CLK == "NONE")
          p1_sig_i_reg1 = p1_sig_i;
      else 
          p1_sig_i_reg1 = p1_sig_i_reg;
    end

    always @(p2_sig_i or p2_sig_i_reg)
    begin
      if (REG_PIPELINE2_CLK == "NONE")
          p2_sig_i_reg1 = p2_sig_i;
      else 
          p2_sig_i_reg1 = p2_sig_i_reg;
    end

    always @(p3_sig_i or p3_sig_i_reg)
    begin
      if (REG_PIPELINE3_CLK == "NONE")
          p3_sig_i_reg1 = p3_sig_i;
      else 
          p3_sig_i_reg1 = p3_sig_i_reg;
    end

    assign sum0_sig_i = addnsub1_p2 ? (p0_sig_i_e + p1_sig_i_e) : (p0_sig_i_e - p1_sig_i_e); 
    assign sum1_sig_i = addnsub3_p2 ? (p2_sig_i_e + p3_sig_i_e) : (p2_sig_i_e - p3_sig_i_e); 
    always @(sum0_sig_i or signedab_p2)
    begin
      if (signedab_p2 == 1'b1)
        begin
           sum0_sig_i_e[18:0] = sum0_sig_i;
           sum0_sig_i_e[19] = sum0_sig_i[18];
        end
      else
        begin
           sum0_sig_i_e[18:0] = sum0_sig_i;
           sum0_sig_i_e[19] = 0;
        end
    end

    always @(sum1_sig_i or signedab_p2)
    begin
      if (signedab_p2 == 1'b1)
        begin
           sum1_sig_i_e[18:0] = sum1_sig_i;
           sum1_sig_i_e[19] = sum1_sig_i[18];
        end
      else
        begin
           sum1_sig_i_e[18:0] = sum1_sig_i;
           sum1_sig_i_e[19] = 0;
        end
    end

    assign sumt_sig = sum0_sig_i_e + sum1_sig_i_e;

    always @(posedge output_clk_sig or posedge output_rst_ogsr)
    begin
      if (output_rst_ogsr == 1'b1)
          sumt_reg <= 0;
      else if (output_ce_sig == 1'b1)
          sumt_reg <= sumt_sig;
    end

    always @(sumt_sig or sumt_reg)
    begin
      if (REG_OUTPUT_CLK == "NONE")
          sum_o = sumt_sig;
      else 
          sum_o = sumt_reg;
    end

endmodule

`endcelldefine
