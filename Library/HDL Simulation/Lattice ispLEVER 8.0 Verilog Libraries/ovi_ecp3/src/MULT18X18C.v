// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2007 by Lattice Semiconductor Corporation
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
// Simulation Library File for ECP3
//
// $Header:
//

`celldefine
`timescale  1 ns / 1 ps

module MULT18X18C (P35,P34,P33,P32,P31,P30,P29,P28,P27,P26,P25,P24,P23,P22,P21,P20,P19,P18,
P17,P16,P15,P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0,
SROA17,SROA16,SROA15,SROA14,SROA13,SROA12,SROA11,SROA10,SROA9,
SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0,
SROB17,SROB16,SROB15,SROB14,SROB13,SROB12,SROB11,SROB10,SROB9,
SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0,
ROA17,ROA16,ROA15,ROA14,ROA13,ROA12,ROA11,ROA10,ROA9,
ROA8,ROA7,ROA6,ROA5,ROA4,ROA3,ROA2,ROA1,ROA0,
ROB17,ROB16,ROB15,ROB14,ROB13,ROB12,ROB11,ROB10,ROB9,
ROB8,ROB7,ROB6,ROB5,ROB4,ROB3,ROB2,ROB1,ROB0,
A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0,
B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0,
SRIA17,SRIA16,SRIA15,SRIA14,SRIA13,SRIA12,SRIA11,SRIA10,SRIA9,
SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0,
SRIB17,SRIB16,SRIB15,SRIB14,SRIB13,SRIB12,SRIB11,SRIB10,SRIB9,
SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0,
SIGNEDA,SIGNEDB,CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SOURCEA,SOURCEB,SIGNEDP);

input A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0;
input B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0;
input SIGNEDA,SIGNEDB,SOURCEA,SOURCEB;
input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3;
input SRIA17,SRIA16,SRIA15,SRIA14,SRIA13,SRIA12,SRIA11,SRIA10,SRIA9;
input SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0;
input SRIB17,SRIB16,SRIB15,SRIB14,SRIB13,SRIB12,SRIB11,SRIB10,SRIB9;
input SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0;
output SROA17,SROA16,SROA15,SROA14,SROA13,SROA12,SROA11,SROA10,SROA9;
output SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0;
output SROB17,SROB16,SROB15,SROB14,SROB13,SROB12,SROB11,SROB10,SROB9;
output SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0;
output ROA17,ROA16,ROA15,ROA14,ROA13,ROA12,ROA11,ROA10,ROA9;
output ROA8,ROA7,ROA6,ROA5,ROA4,ROA3,ROA2,ROA1,ROA0;
output ROB17,ROB16,ROB15,ROB14,ROB13,ROB12,ROB11,ROB10,ROB9;
output ROB8,ROB7,ROB6,ROB5,ROB4,ROB3,ROB2,ROB1,ROB0;
output P35,P34,P33,P32,P31,P30,P29,P28,P27,P26,P25,P24,P23,P22,P21,P20,P19,P18; 
output P17,P16,P15,P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0; 
output SIGNEDP;

parameter REG_INPUTA_CLK = "NONE";
parameter REG_INPUTA_CE = "CE0";
parameter REG_INPUTA_RST = "RST0";
parameter REG_INPUTB_CLK = "NONE";
parameter REG_INPUTB_CE = "CE0";
parameter REG_INPUTB_RST = "RST0";
parameter REG_PIPELINE_CLK = "NONE";
parameter REG_PIPELINE_CE = "CE0";
parameter REG_PIPELINE_RST = "RST0";
parameter REG_OUTPUT_CLK = "NONE";
parameter REG_OUTPUT_CE = "CE0";
parameter REG_OUTPUT_RST = "RST0";
parameter GSR = "ENABLED";
parameter CAS_MATCH_REG = "FALSE";
parameter MULT_BYPASS = "DISABLED";
parameter RESETMODE = "SYNC";


    wire CE0b,CE1b,CE2b,CE3b,CLK0b,CLK1b,CLK2b,CLK3b,RST0b,RST1b,RST2b,RST3b;

    wire [17:0] a_sig, b_sig;
    reg  [17:0] a_sig_reg, b_sig_reg, a_sig_reg_async, a_sig_gen1_async, a_sig_reg_sync, a_sig_gen1_sync;
    reg  [17:0] a_sig_gen, b_sig_gen, b_sig_reg_async, b_sig_reg_sync, a_sig_gen1;
    wire [17:0] a_sig_s, b_sig_s;
    reg [17:0]  a_sig_s_1, b_sig_s_1, a_sig_gen2, a_sig_gen3;
    wire [35:0] p_sig_i;

    wire [17:0] sroa_reg,srob_reg, roa_reg;

    reg [35:0] p_sig_ps, p_sig_o_async, p_sig_o_sync, p_sig_o1_async, p_sig_o1_sync;
    reg [35:0] p_sig, p_sig_out;
    reg [35:0] a_sig_m, b_sig_m;

    wire input_a_rst_ogsr;
    wire input_b_rst_ogsr;
    wire pipeline_rst_ogsr;
    wire output_rst_ogsr;

    wire signeda_sig;
    wire signedb_sig, signedab_sig;
    wire sourcea_sig;
    wire sourceb_sig;
    reg  signeda_p1, signedab_sig_async, signedab_sig_sync, signedab_reg;
    reg  signeda_reg1, signeda_reg1_async, signeda_reg1_sync;
    reg  signedb_p1, signedp_sig;
    reg  signedb_reg1, signedb_reg1_async, signedb_reg1_sync;

    reg input_a_clk_sig,input_a_ce_sig,input_a_rst_sig;
    reg input_b_clk_sig,input_b_ce_sig,input_b_rst_sig;
    reg pipeline_clk_sig,pipeline_ce_sig,pipeline_rst_sig;
    reg output_clk_sig,output_ce_sig,output_rst_sig;

    reg [35:0] p_sig_o,p_sig_o1;

    reg SRN;

    tri1 GSR_sig = GSR_INST.GSRNET;
    tri1 PUR_sig = PUR_INST.PURNET;
 
    initial
    begin
       p_sig = 0;
    end

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

    or INST1 (input_a_rst_ogsr, input_a_rst_sig, SR1);
    or INST2 (input_b_rst_ogsr, input_b_rst_sig, SR1);
    or INST3 (pipeline_rst_ogsr, pipeline_rst_sig, SR1);
    or INST4 (output_rst_ogsr, output_rst_sig, SR1);

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

    buf inst_A0 (a_sig[0], A0);
    buf inst_A1 (a_sig[1], A1);
    buf inst_A2 (a_sig[2], A2);
    buf inst_A3 (a_sig[3], A3);
    buf inst_A4 (a_sig[4], A4);
    buf inst_A5 (a_sig[5], A5);
    buf inst_A6 (a_sig[6], A6);
    buf inst_A7 (a_sig[7], A7);
    buf inst_A8 (a_sig[8], A8);
    buf inst_A9 (a_sig[9], A9);
    buf inst_A10 (a_sig[10], A10);
    buf inst_A11 (a_sig[11], A11);
    buf inst_A12 (a_sig[12], A12);
    buf inst_A13 (a_sig[13], A13);
    buf inst_A14 (a_sig[14], A14);
    buf inst_A15 (a_sig[15], A15);
    buf inst_A16 (a_sig[16], A16);
    buf inst_A17 (a_sig[17], A17);
    buf inst_B0 (b_sig[0], B0);
    buf inst_B1 (b_sig[1], B1);
    buf inst_B2 (b_sig[2], B2);
    buf inst_B3 (b_sig[3], B3);
    buf inst_B4 (b_sig[4], B4);
    buf inst_B5 (b_sig[5], B5);
    buf inst_B6 (b_sig[6], B6);
    buf inst_B7 (b_sig[7], B7);
    buf inst_B8 (b_sig[8], B8);
    buf inst_B9 (b_sig[9], B9);
    buf inst_B10 (b_sig[10], B10);
    buf inst_B11 (b_sig[11], B11);
    buf inst_B12 (b_sig[12], B12);
    buf inst_B13 (b_sig[13], B13);
    buf inst_B14 (b_sig[14], B14);
    buf inst_B15 (b_sig[15], B15);
    buf inst_B16 (b_sig[16], B16);
    buf inst_B17 (b_sig[17], B17);

    buf inst_s_A0 (a_sig_s[0], SRIA0);
    buf inst_s_A1 (a_sig_s[1], SRIA1);
    buf inst_s_A2 (a_sig_s[2], SRIA2);
    buf inst_s_A3 (a_sig_s[3], SRIA3);
    buf inst_s_A4 (a_sig_s[4], SRIA4);
    buf inst_s_A5 (a_sig_s[5], SRIA5);
    buf inst_s_A6 (a_sig_s[6], SRIA6);
    buf inst_s_A7 (a_sig_s[7], SRIA7);
    buf inst_s_A8 (a_sig_s[8], SRIA8);
    buf inst_s_A9 (a_sig_s[9], SRIA9);
    buf inst_s_A10 (a_sig_s[10], SRIA10);
    buf inst_s_A11 (a_sig_s[11], SRIA11);
    buf inst_s_A12 (a_sig_s[12], SRIA12);
    buf inst_s_A13 (a_sig_s[13], SRIA13);
    buf inst_s_A14 (a_sig_s[14], SRIA14);
    buf inst_s_A15 (a_sig_s[15], SRIA15);
    buf inst_s_A16 (a_sig_s[16], SRIA16);
    buf inst_s_A17 (a_sig_s[17], SRIA17);

    buf inst_s_B0 (b_sig_s[0], SRIB0);
    buf inst_s_B1 (b_sig_s[1], SRIB1);
    buf inst_s_B2 (b_sig_s[2], SRIB2);
    buf inst_s_B3 (b_sig_s[3], SRIB3);
    buf inst_s_B4 (b_sig_s[4], SRIB4);
    buf inst_s_B5 (b_sig_s[5], SRIB5);
    buf inst_s_B6 (b_sig_s[6], SRIB6);
    buf inst_s_B7 (b_sig_s[7], SRIB7);
    buf inst_s_B8 (b_sig_s[8], SRIB8);
    buf inst_s_B9 (b_sig_s[9], SRIB9);
    buf inst_s_B10 (b_sig_s[10], SRIB10);
    buf inst_s_B11 (b_sig_s[11], SRIB11);
    buf inst_s_B12 (b_sig_s[12], SRIB12);
    buf inst_s_B13 (b_sig_s[13], SRIB13);
    buf inst_s_B14 (b_sig_s[14], SRIB14);
    buf inst_s_B15 (b_sig_s[15], SRIB15);
    buf inst_s_B16 (b_sig_s[16], SRIB16);
    buf inst_s_B17 (b_sig_s[17], SRIB17);

    buf inst_s_SIGNEDA (signeda_sig, SIGNEDA);
    buf inst_s_SIGNEDB (signedb_sig, SIGNEDB);
    buf inst_s_SOURCEA (sourcea_sig, SOURCEA);
    buf inst_s_SOURCEB (sourceb_sig, SOURCEB);

    buf inst_P0 (P0, p_sig[0]);
    buf inst_P1 (P1, p_sig[1]);
    buf inst_P2 (P2, p_sig[2]);
    buf inst_P3 (P3, p_sig[3]);
    buf inst_P4 (P4, p_sig[4]);
    buf inst_P5 (P5, p_sig[5]);
    buf inst_P6 (P6, p_sig[6]);
    buf inst_P7 (P7, p_sig[7]);
    buf inst_P8 (P8, p_sig[8]);
    buf inst_P9 (P9, p_sig[9]);
    buf inst_P10 (P10, p_sig[10]);
    buf inst_P11 (P11, p_sig[11]);
    buf inst_P12 (P12, p_sig[12]);
    buf inst_P13 (P13, p_sig[13]);
    buf inst_P14 (P14, p_sig[14]);
    buf inst_P15 (P15, p_sig[15]);
    buf inst_P16 (P16, p_sig[16]);
    buf inst_P17 (P17, p_sig[17]);
    buf inst_P18 (P18, p_sig[18]);
    buf inst_P19 (P19, p_sig[19]);
    buf inst_P20 (P20, p_sig[20]);
    buf inst_P21 (P21, p_sig[21]);
    buf inst_P22 (P22, p_sig[22]);
    buf inst_P23 (P23, p_sig[23]);
    buf inst_P24 (P24, p_sig[24]);
    buf inst_P25 (P25, p_sig[25]);
    buf inst_P26 (P26, p_sig[26]);
    buf inst_P27 (P27, p_sig[27]);
    buf inst_P28 (P28, p_sig[28]);
    buf inst_P29 (P29, p_sig[29]);
    buf inst_P30 (P30, p_sig[30]);
    buf inst_P31 (P31, p_sig[31]);
    buf inst_P32 (P32, p_sig[32]);
    buf inst_P33 (P33, p_sig[33]);
    buf inst_P34 (P34, p_sig[34]);
    buf inst_P35 (P35, p_sig[35]);

    buf inst_SROA0 (SROA0, sroa_reg[0]);
    buf inst_SROA1 (SROA1, sroa_reg[1]);
    buf inst_SROA2 (SROA2, sroa_reg[2]);
    buf inst_SROA3 (SROA3, sroa_reg[3]);
    buf inst_SROA4 (SROA4, sroa_reg[4]);
    buf inst_SROA5 (SROA5, sroa_reg[5]);
    buf inst_SROA6 (SROA6, sroa_reg[6]);
    buf inst_SROA7 (SROA7, sroa_reg[7]);
    buf inst_SROA8 (SROA8, sroa_reg[8]);
    buf inst_SROA9 (SROA9, sroa_reg[9]);
    buf inst_SROA10 (SROA10, sroa_reg[10]);
    buf inst_SROA11 (SROA11, sroa_reg[11]);
    buf inst_SROA12 (SROA12, sroa_reg[12]);
    buf inst_SROA13 (SROA13, sroa_reg[13]);
    buf inst_SROA14 (SROA14, sroa_reg[14]);
    buf inst_SROA15 (SROA15, sroa_reg[15]);
    buf inst_SROA16 (SROA16, sroa_reg[16]);
    buf inst_SROA17 (SROA17, sroa_reg[17]);

    buf inst_SROB0 (SROB0, srob_reg[0]);
    buf inst_SROB1 (SROB1, srob_reg[1]);
    buf inst_SROB2 (SROB2, srob_reg[2]);
    buf inst_SROB3 (SROB3, srob_reg[3]);
    buf inst_SROB4 (SROB4, srob_reg[4]);
    buf inst_SROB5 (SROB5, srob_reg[5]);
    buf inst_SROB6 (SROB6, srob_reg[6]);
    buf inst_SROB7 (SROB7, srob_reg[7]);
    buf inst_SROB8 (SROB8, srob_reg[8]);
    buf inst_SROB9 (SROB9, srob_reg[9]);
    buf inst_SROB10 (SROB10, srob_reg[10]);
    buf inst_SROB11 (SROB11, srob_reg[11]);
    buf inst_SROB12 (SROB12, srob_reg[12]);
    buf inst_SROB13 (SROB13, srob_reg[13]);
    buf inst_SROB14 (SROB14, srob_reg[14]);
    buf inst_SROB15 (SROB15, srob_reg[15]);
    buf inst_SROB16 (SROB16, srob_reg[16]);
    buf inst_SROB17 (SROB17, srob_reg[17]);

    buf inst_ROA0 (ROA0, roa_reg[0]);
    buf inst_ROA1 (ROA1, roa_reg[1]);
    buf inst_ROA2 (ROA2, roa_reg[2]);
    buf inst_ROA3 (ROA3, roa_reg[3]);
    buf inst_ROA4 (ROA4, roa_reg[4]);
    buf inst_ROA5 (ROA5, roa_reg[5]);
    buf inst_ROA6 (ROA6, roa_reg[6]);
    buf inst_ROA7 (ROA7, roa_reg[7]);
    buf inst_ROA8 (ROA8, roa_reg[8]);
    buf inst_ROA9 (ROA9, roa_reg[9]);
    buf inst_ROA10 (ROA10, roa_reg[10]);
    buf inst_ROA11 (ROA11, roa_reg[11]);
    buf inst_ROA12 (ROA12, roa_reg[12]);
    buf inst_ROA13 (ROA13, roa_reg[13]);
    buf inst_ROA14 (ROA14, roa_reg[14]);
    buf inst_ROA15 (ROA15, roa_reg[15]);
    buf inst_ROA16 (ROA16, roa_reg[16]);
    buf inst_ROA17 (ROA17, roa_reg[17]);

    buf inst_ROB0 (ROB0, srob_reg[0]);
    buf inst_ROB1 (ROB1, srob_reg[1]);
    buf inst_ROB2 (ROB2, srob_reg[2]);
    buf inst_ROB3 (ROB3, srob_reg[3]);
    buf inst_ROB4 (ROB4, srob_reg[4]);
    buf inst_ROB5 (ROB5, srob_reg[5]);
    buf inst_ROB6 (ROB6, srob_reg[6]);
    buf inst_ROB7 (ROB7, srob_reg[7]);
    buf inst_ROB8 (ROB8, srob_reg[8]);
    buf inst_ROB9 (ROB9, srob_reg[9]);
    buf inst_ROB10 (ROB10, srob_reg[10]);
    buf inst_ROB11 (ROB11, srob_reg[11]);
    buf inst_ROB12 (ROB12, srob_reg[12]);
    buf inst_ROB13 (ROB13, srob_reg[13]);
    buf inst_ROB14 (ROB14, srob_reg[14]);
    buf inst_ROB15 (ROB15, srob_reg[15]);
    buf inst_ROB16 (ROB16, srob_reg[16]);
    buf inst_ROB17 (ROB17, srob_reg[17]);

    buf inst_SIGNEDP (SIGNEDP, signedp_sig);

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTA_CLK == "CLK0")
          input_a_clk_sig = CLK0b;
      else if (REG_INPUTA_CLK == "CLK1")
          input_a_clk_sig = CLK1b;
      else if (REG_INPUTA_CLK == "CLK2")
          input_a_clk_sig = CLK2b;
      else if (REG_INPUTA_CLK == "CLK3")
          input_a_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_INPUTB_CLK == "CLK0")
          input_b_clk_sig = CLK0b;
      else if (REG_INPUTB_CLK == "CLK1")
          input_b_clk_sig = CLK1b;
      else if (REG_INPUTB_CLK == "CLK2")
          input_b_clk_sig = CLK2b;
      else if (REG_INPUTB_CLK == "CLK3")
          input_b_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_PIPELINE_CLK == "CLK0")
          pipeline_clk_sig = CLK0b;
      else if (REG_PIPELINE_CLK == "CLK1")
          pipeline_clk_sig = CLK1b;
      else if (REG_PIPELINE_CLK == "CLK2")
          pipeline_clk_sig = CLK2b;
      else if (REG_PIPELINE_CLK == "CLK3")
          pipeline_clk_sig = CLK3b;
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
      if (REG_INPUTA_CE == "CE0")
          input_a_ce_sig = CE0b;
      else if (REG_INPUTA_CE == "CE1")
          input_a_ce_sig = CE1b;
      else if (REG_INPUTA_CE == "CE2")
          input_a_ce_sig = CE2b;
      else if (REG_INPUTA_CE == "CE3")
          input_a_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_INPUTB_CE == "CE0")
          input_b_ce_sig = CE0b;
      else if (REG_INPUTB_CE == "CE1")
          input_b_ce_sig = CE1b;
      else if (REG_INPUTB_CE == "CE2")
          input_b_ce_sig = CE2b;
      else if (REG_INPUTB_CE == "CE3")
          input_b_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_PIPELINE_CE == "CE0")
          pipeline_ce_sig = CE0b;
      else if (REG_PIPELINE_CE == "CE1")
          pipeline_ce_sig = CE1b;
      else if (REG_PIPELINE_CE == "CE2")
          pipeline_ce_sig = CE2b;
      else if (REG_PIPELINE_CE == "CE3")
          pipeline_ce_sig = CE3b;
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

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTA_RST == "RST0")
          input_a_rst_sig = RST0b;
      else if (REG_INPUTA_RST == "RST1")
          input_a_rst_sig = RST1b;
      else if (REG_INPUTA_RST == "RST2")
          input_a_rst_sig = RST2b;
      else if (REG_INPUTA_RST == "RST3")
          input_a_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_INPUTB_RST == "RST0")
          input_b_rst_sig = RST0b;
      else if (REG_INPUTB_RST == "RST1")
          input_b_rst_sig = RST1b;
      else if (REG_INPUTB_RST == "RST2")
          input_b_rst_sig = RST2b;
      else if (REG_INPUTB_RST == "RST3")
          input_b_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_PIPELINE_RST == "RST0")
          pipeline_rst_sig = RST0b;
      else if (REG_PIPELINE_RST == "RST1")
          pipeline_rst_sig = RST1b;
      else if (REG_PIPELINE_RST == "RST2")
          pipeline_rst_sig = RST2b;
      else if (REG_PIPELINE_RST == "RST3")
          pipeline_rst_sig = RST3b;
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

    always @(a_sig_s or a_sig or sourcea_sig)
    begin
      if (sourcea_sig == 1'b1)
          a_sig_s_1 <= a_sig_s;
      else if (sourcea_sig == 1'b0)
          a_sig_s_1 <= a_sig;
    end

    always @(b_sig_s or b_sig or sourceb_sig)
    begin
      if (sourceb_sig == 1'b1)
          b_sig_s_1 = b_sig_s;
      else if (sourceb_sig == 1'b0)
          b_sig_s_1 = b_sig;
    end

    always @(posedge input_a_clk_sig or posedge input_a_rst_ogsr)
    begin
      if (input_a_rst_ogsr == 1'b1)
        begin
          a_sig_reg_async <= 0;
          a_sig_gen1_async <= 0;
          signeda_reg1_async <= 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg_async <= a_sig_s_1;
          a_sig_gen1_async <= a_sig_gen;
          signeda_reg1_async <= signeda_sig;
        end
    end

    always @(posedge input_a_clk_sig)
    begin
      if (input_a_rst_ogsr == 1'b1)
        begin
          a_sig_reg_sync <= 0;
          a_sig_gen1_sync <= 0;
          signeda_reg1_sync <= 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg_sync <= a_sig_s_1;
          a_sig_gen1_sync <= a_sig_gen;
          signeda_reg1_sync <= signeda_sig;
        end
    end

    always @(posedge input_b_clk_sig or posedge input_b_rst_ogsr)
    begin
      if (input_b_rst_ogsr == 1'b1)
        begin
          b_sig_reg_async <= 0;
          signedb_reg1_async <= 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg_async <= b_sig_s_1;
          signedb_reg1_async <= signedb_sig;
        end
    end

    always @(posedge input_b_clk_sig)
    begin
      if (input_b_rst_ogsr == 1'b1)
        begin
          b_sig_reg_sync <= 0;
          signedb_reg1_sync <= 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg_sync <= b_sig_s_1;
          signedb_reg1_sync <= signedb_sig;
        end
    end

    always @ (SR1)
    begin
       if (SR1 == 1)
       begin
          assign a_sig_reg = 0;
          assign a_sig_gen1 = 0;
          assign b_sig_reg = 0;
          assign signeda_reg1 = 0;
          assign signedb_reg1 = 0;
          assign p_sig_o = 0;
          assign p_sig_o1 = 0;
       end
       else
       begin
          deassign a_sig_reg;
          deassign a_sig_gen1;
          deassign b_sig_reg;
          deassign signeda_reg1;
          deassign signedb_reg1;
          deassign p_sig_o;
          deassign p_sig_o1;
       end
    end

    always @(a_sig_reg_sync or a_sig_reg_async or b_sig_reg_sync or b_sig_reg_async or a_sig_gen1_async or a_sig_gen1_sync or signeda_reg1_async or signeda_reg1_sync or signedb_reg1_async or signedb_reg1_sync, p_sig_o_async or p_sig_o_sync or p_sig_o1_async or p_sig_o1_sync or signedab_sig_async or signedab_sig_sync)
    begin
      if (RESETMODE == "ASYNC")
      begin
         a_sig_reg <= a_sig_reg_async;
         a_sig_gen1 <= a_sig_gen1_async;
         b_sig_reg <= b_sig_reg_async;
         signeda_reg1 <= signeda_reg1_async;
         signedb_reg1 <= signedb_reg1_async;
         p_sig_o <= p_sig_o_async;
         p_sig_o1 <= p_sig_o1_async;
         signedab_reg <= signedab_sig_async;
      end 
      else if (RESETMODE == "SYNC")
      begin
         a_sig_reg <= a_sig_reg_sync;
         a_sig_gen1 <= a_sig_gen1_sync;
         b_sig_reg <= b_sig_reg_sync;
         signeda_reg1 <= signeda_reg1_sync;
         signedb_reg1 <= signedb_reg1_sync;
         p_sig_o <= p_sig_o_sync;
         p_sig_o1 <= p_sig_o1_sync;
         signedab_reg <= signedab_sig_sync;
      end
    end

    always @(a_sig_reg or a_sig_s_1 or signeda_reg1 or signeda_sig)
    begin
      if (REG_INPUTA_CLK == "NONE")
      begin
          a_sig_gen <= a_sig_s_1;
          signeda_p1 <= signeda_sig;
      end
      else
      begin
          a_sig_gen <= a_sig_reg;
          signeda_p1 <= signeda_reg1;
      end
    end

    always @(a_sig_gen or a_sig_gen1)
    begin
      if (REG_INPUTA_CLK == "NONE")
      begin
          a_sig_gen2 = a_sig_gen;
      end
      else 
      begin
          a_sig_gen2 = a_sig_gen1;
      end
    end

    always @(a_sig_gen or a_sig_gen2)
    begin
      if (CAS_MATCH_REG == "FALSE")
          a_sig_gen3 = a_sig_gen;
      else if (CAS_MATCH_REG == "TRUE")
          a_sig_gen3 = a_sig_gen2;
    end

    assign  roa_reg = a_sig_gen;
    assign  sroa_reg = a_sig_gen3;

    always @(b_sig_reg or b_sig_s_1 or signedb_reg1 or signedb_sig)
    begin
      if (REG_INPUTB_CLK == "NONE")
      begin
          b_sig_gen = b_sig_s_1;
          signedb_p1 <= signedb_sig;
      end
      else
      begin
          b_sig_gen = b_sig_reg;
          signedb_p1 <= signedb_reg1;
      end
    end

    assign  srob_reg = b_sig_gen;

    always @(a_sig_gen or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a_sig_m[17:0] = a_sig_gen[17:0];
          a_sig_m[35:18] = { a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17],
                            a_sig_gen[17]};
        end
      else
        begin
          a_sig_m[17:0] =  a_sig_gen[17:0];
          a_sig_m[35:18] = 0;
        end
    end

    always @(b_sig_gen or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b_sig_m[17:0] = b_sig_gen[17:0];
          b_sig_m[35:18] = {b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17],
                           b_sig_gen[17]};
        end
      else
        begin
          b_sig_m[17:0] = b_sig_gen[17:0];
          b_sig_m[35:18] = 0;
        end
    end

    assign p_sig_i = (!a_sig_m || !b_sig_m)? 0 : a_sig_m * b_sig_m ;

    or INST7 (signedab_sig, signeda_p1, signedb_p1);
 
    always @(posedge pipeline_clk_sig or posedge pipeline_rst_ogsr)
    begin
      if (pipeline_rst_ogsr == 1'b1)
        begin
          p_sig_o_async <= 0;
          signedab_sig_async <= 0;
        end
      else if (pipeline_ce_sig == 1'b1)
        begin
          p_sig_o_async <= p_sig_i;
          signedab_sig_async <= signedab_sig;
        end
    end

    always @(posedge pipeline_clk_sig)
    begin
      if (pipeline_rst_ogsr == 1'b1)
        begin
          p_sig_o_sync <= 0;
          signedab_sig_sync <= 0;
        end
      else if (pipeline_ce_sig == 1'b1)
        begin
          p_sig_o_sync <= p_sig_i;
          signedab_sig_sync <= signedab_sig;
        end
    end

    always @(p_sig_i or p_sig_o or signedab_sig or signedab_reg)
    begin
      if (REG_PIPELINE_CLK == "NONE")
      begin
          p_sig_ps = p_sig_i;
          signedp_sig = signedab_sig;
      end
      else
      begin
          p_sig_ps = p_sig_o;
          signedp_sig = signedab_reg;
      end
    end

    always @(posedge output_clk_sig or posedge output_rst_ogsr)
    begin
      if (output_rst_ogsr == 1'b1)
          p_sig_o1_async <= 0;
      else if (output_ce_sig == 1'b1)
          p_sig_o1_async <= p_sig_ps;
    end

    always @(posedge output_clk_sig)
    begin
      if (output_rst_ogsr == 1'b1)
          p_sig_o1_sync <= 0;
      else if (output_ce_sig == 1'b1)
          p_sig_o1_sync <= p_sig_ps;
    end

    always @(p_sig_ps or p_sig_o1)
    begin
      if (REG_OUTPUT_CLK == "NONE")
          p_sig_out = p_sig_ps;
      else
          p_sig_out = p_sig_o1;
    end

    always @(p_sig_out)
    begin
      if (MULT_BYPASS == "DISABLED")
          p_sig = p_sig_out;
      else
          p_sig = 0;
    end

endmodule

`endcelldefine
