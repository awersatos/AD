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
// $Header:
//
`celldefine
`timescale  1 ns / 1 ps

module MULT36X36B (P71,P70,P69,P68,P67,P66,P65,P64,P63,P62,P61,P60,P59,P58,P57,P56,P55,P54,P53,P52,P51,P50,P49,P48,P47,P46,P45,P44,P43,P42,P41,P40,P39,P38,P37,P36,P35,P34,P33,P32,P31,P30,P29,P28,P27,P26,P25,P24,P23,P22,P21,P20,P19,P18,P17,P16,P15,P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0,A35,A34,A33,A32,A31,A30,A29,A28,A27,A26,A25,A24,A23,A22,A21,A20,A19,A18,A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0,B35,B34,B33,B32,B31,B30,B29,B28,B27,B26,B25,B24,B23,B22,B21,B20,B19,B18,B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0,SIGNEDA,SIGNEDB,CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3);
input A35,A34,A33,A32,A31,A30,A29,A28,A27,A26,A25,A24,A23,A22,A21,A20,A19,A18;
input A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0;
input B35,B34,B33,B32,B31,B30,B29,B28,B27,B26,B25,B24,B23,B22,B21,B20,B19,B18;
input B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0;
input SIGNEDA,SIGNEDB;
input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3;
output P71,P70,P69,P68,P67,P66,P65,P64,P63,P62,P61,P60,P59,P58,P57,P56,P55,P54; 
output P53,P52,P51,P50,P49,P48,P47,P46,P45,P44,P43,P42,P41,P40,P39,P38,P37,P36; 
output P35,P34,P33,P32,P31,P30,P29,P28,P27,P26,P25,P24,P23,P22,P21,P20,P19,P18; 
output P17,P16,P15,P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0; 

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
parameter REG_SIGNEDA_0_CLK = "NONE";
parameter REG_SIGNEDA_0_CE = "CE0";
parameter REG_SIGNEDA_0_RST = "RST0";
parameter REG_SIGNEDA_1_CLK = "NONE";
parameter REG_SIGNEDA_1_CE = "CE0";
parameter REG_SIGNEDA_1_RST = "RST0";
parameter REG_SIGNEDB_0_CLK = "NONE";
parameter REG_SIGNEDB_0_CE = "CE0";
parameter REG_SIGNEDB_0_RST = "RST0";
parameter REG_SIGNEDB_1_CLK = "NONE";
parameter REG_SIGNEDB_1_CE = "CE0";
parameter REG_SIGNEDB_1_RST = "RST0";
parameter GSR = "ENABLED";


supply0 GND; 
supply1 VCC; 

    wire CE0b,CE1b,CE2b,CE3b,CLK0b,CLK1b,CLK2b,CLK3b,RST0b,RST1b,RST2b,RST3b;

    wire [35:0] a_sig, b_sig;
    reg  [35:0] a_sig_reg, b_sig_reg;
    wire [35:0] a_sig_gen, b_sig_gen;
    reg [35:0] a_sig_p, b_sig_p;
    wire [71:0] p_sig_i;

    reg [71:0] p_sig_ps;
    reg [71:0] p_sig;
    reg [71:0] a_sig_m, b_sig_m;

    wire signeda_sig;
    wire signedb_sig;

    wire input_a_rst_ogsr;
    wire input_b_rst_ogsr;
    wire pipeline_rst_ogsr;
    wire output_rst_ogsr;
    wire reg_ctrl_0_rst_ogsr_a;
    wire reg_ctrl_0_rst_ogsr_b;

    reg  signeda_p1;
    reg  signeda_p2;
    reg  signeda_reg1;
    reg  signeda_reg2;
    reg  signedb_p1;
    reg  signedb_p2;
    reg  signedb_reg1;
    reg  signedb_reg2;

    reg input_a_clk_sig,input_a_ce_sig,input_a_rst_sig;
    reg input_b_clk_sig,input_b_ce_sig,input_b_rst_sig;
    reg pipeline_clk_sig,pipeline_ce_sig,pipeline_rst_sig;
    reg output_clk_sig,output_ce_sig,output_rst_sig;
    reg reg_ctrl_0_clk_sig_a,reg_ctrl_0_ce_sig_a,reg_ctrl_0_rst_sig_a;
    reg reg_ctrl_1_clk_sig_a,reg_ctrl_1_ce_sig_a,reg_ctrl_1_rst_sig_a;
    reg reg_ctrl_0_clk_sig_b,reg_ctrl_0_ce_sig_b,reg_ctrl_0_rst_sig_b;
    reg reg_ctrl_1_clk_sig_b,reg_ctrl_1_ce_sig_b,reg_ctrl_1_rst_sig_b;

    reg [71:0] p_sig_o,p_sig_o1;

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

    or INST1 (input_a_rst_ogsr, input_a_rst_sig, SR1);
    or INST2 (input_b_rst_ogsr, input_b_rst_sig, SR1);
    or INST3 (pipeline_rst_ogsr, pipeline_rst_sig, SR1);
    or INST4 (output_rst_ogsr, output_rst_sig, SR1);
    or INST5 (reg_ctrl_0_rst_ogsr_a, reg_ctrl_0_rst_sig_a, SR1);
    or INST6 (reg_ctrl_0_rst_ogsr_b, reg_ctrl_0_rst_sig_b, SR1);
    or INST7 (reg_ctrl_1_rst_ogsr_a, reg_ctrl_1_rst_sig_a, SR1);
    or INST8 (reg_ctrl_1_rst_ogsr_b, reg_ctrl_1_rst_sig_b, SR1);

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
    buf inst_A18 (a_sig[18], A18);
    buf inst_A19 (a_sig[19], A19);
    buf inst_A20 (a_sig[20], A20);
    buf inst_A21 (a_sig[21], A21);
    buf inst_A22 (a_sig[22], A22);
    buf inst_A23 (a_sig[23], A23);
    buf inst_A24 (a_sig[24], A24);
    buf inst_A25 (a_sig[25], A25);
    buf inst_A26 (a_sig[26], A26);
    buf inst_A27 (a_sig[27], A27);
    buf inst_A28 (a_sig[28], A28);
    buf inst_A29 (a_sig[29], A29);
    buf inst_A30 (a_sig[30], A30);
    buf inst_A31 (a_sig[31], A31);
    buf inst_A32 (a_sig[32], A32);
    buf inst_A33 (a_sig[33], A33);
    buf inst_A34 (a_sig[34], A34);
    buf inst_A35 (a_sig[35], A35);

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
    buf inst_B18 (b_sig[18], B18);
    buf inst_B19 (b_sig[19], B19);
    buf inst_B20 (b_sig[20], B20);
    buf inst_B21 (b_sig[21], B21);
    buf inst_B22 (b_sig[22], B22);
    buf inst_B23 (b_sig[23], B23);
    buf inst_B24 (b_sig[24], B24);
    buf inst_B25 (b_sig[25], B25);
    buf inst_B26 (b_sig[26], B26);
    buf inst_B27 (b_sig[27], B27);
    buf inst_B28 (b_sig[28], B28);
    buf inst_B29 (b_sig[29], B29);
    buf inst_B30 (b_sig[30], B30);
    buf inst_B31 (b_sig[31], B31);
    buf inst_B32 (b_sig[32], B32);
    buf inst_B33 (b_sig[33], B33);
    buf inst_B34 (b_sig[34], B34);
    buf inst_B35 (b_sig[35], B35);

    buf inst_s_SIGNEDA (signeda_sig, SIGNEDA);
    buf inst_s_SIGNEDB (signedb_sig, SIGNEDB);

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
    buf inst_P36 (P36, p_sig[36]);
    buf inst_P37 (P37, p_sig[37]);
    buf inst_P38 (P38, p_sig[38]);
    buf inst_P39 (P39, p_sig[39]);
    buf inst_P40 (P40, p_sig[40]);
    buf inst_P41 (P41, p_sig[41]);
    buf inst_P42 (P42, p_sig[42]);
    buf inst_P43 (P43, p_sig[43]);
    buf inst_P44 (P44, p_sig[44]);
    buf inst_P45 (P45, p_sig[45]);
    buf inst_P46 (P46, p_sig[46]);
    buf inst_P47 (P47, p_sig[47]);
    buf inst_P48 (P48, p_sig[48]);
    buf inst_P49 (P49, p_sig[49]);
    buf inst_P50 (P50, p_sig[50]);
    buf inst_P51 (P51, p_sig[51]);
    buf inst_P52 (P52, p_sig[52]);
    buf inst_P53 (P53, p_sig[53]);
    buf inst_P54 (P54, p_sig[54]);
    buf inst_P55 (P55, p_sig[55]);
    buf inst_P56 (P56, p_sig[56]);
    buf inst_P57 (P57, p_sig[57]);
    buf inst_P58 (P58, p_sig[58]);
    buf inst_P59 (P59, p_sig[59]);
    buf inst_P60 (P60, p_sig[60]);
    buf inst_P61 (P61, p_sig[61]);
    buf inst_P62 (P62, p_sig[62]);
    buf inst_P63 (P63, p_sig[63]);
    buf inst_P64 (P64, p_sig[64]);
    buf inst_P65 (P65, p_sig[65]);
    buf inst_P66 (P66, p_sig[66]);
    buf inst_P67 (P67, p_sig[67]);
    buf inst_P68 (P68, p_sig[68]);
    buf inst_P69 (P69, p_sig[69]);
    buf inst_P70 (P70, p_sig[70]);
    buf inst_P71 (P71, p_sig[71]);

    always @(a_sig_gen or signeda_p2)
    begin
      if (signeda_p2 == 1'b1)
        begin
          a_sig_m[35:0] = a_sig_gen[35:0];
          a_sig_m[71:36] = { a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35],
                            a_sig_gen[35]};
        end
      else 
        begin
          a_sig_m[35:0] =  a_sig_gen[35:0];
          a_sig_m[71:36] = 0;
        end
    end

    always @(b_sig_gen or signedb_p2)
    begin
      if (signedb_p2 == 1'b1)
        begin
          b_sig_m[35:0] = b_sig_gen[35:0];
          b_sig_m[71:36] = {b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35],
                           b_sig_gen[35]};
        end
      else 
        begin
          b_sig_m[35:0] = b_sig_gen[35:0];
          b_sig_m[71:36] = 0;
        end
    end

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

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDA_0_CLK == "CLK0")
          reg_ctrl_0_clk_sig_a = CLK0b;
      else if (REG_SIGNEDA_0_CLK == "CLK1")
          reg_ctrl_0_clk_sig_a = CLK1b;
      else if (REG_SIGNEDA_0_CLK == "CLK2")
          reg_ctrl_0_clk_sig_a = CLK2b;
      else if (REG_SIGNEDA_0_CLK == "CLK3")
          reg_ctrl_0_clk_sig_a = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDB_0_CLK == "CLK0")
          reg_ctrl_0_clk_sig_b = CLK0b;
      else if (REG_SIGNEDB_0_CLK == "CLK1")
          reg_ctrl_0_clk_sig_b = CLK1b;
      else if (REG_SIGNEDB_0_CLK == "CLK2")
          reg_ctrl_0_clk_sig_b = CLK2b;
      else if (REG_SIGNEDB_0_CLK == "CLK3")
          reg_ctrl_0_clk_sig_b = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDA_1_CLK == "CLK0")
          reg_ctrl_1_clk_sig_a = CLK0b;
      else if (REG_SIGNEDA_1_CLK == "CLK1")
          reg_ctrl_1_clk_sig_a = CLK1b;
      else if (REG_SIGNEDA_1_CLK == "CLK2")
          reg_ctrl_1_clk_sig_a = CLK2b;
      else if (REG_SIGNEDA_1_CLK == "CLK3")
          reg_ctrl_1_clk_sig_a = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDB_1_CLK == "CLK0")
          reg_ctrl_1_clk_sig_b = CLK0b;
      else if (REG_SIGNEDB_1_CLK == "CLK1")
          reg_ctrl_1_clk_sig_b = CLK1b;
      else if (REG_SIGNEDB_1_CLK == "CLK2")
          reg_ctrl_1_clk_sig_b = CLK2b;
      else if (REG_SIGNEDB_1_CLK == "CLK3")
          reg_ctrl_1_clk_sig_b = CLK3b;
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

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDA_0_CE == "CE0")
          reg_ctrl_0_ce_sig_a = CE0b;
      else if (REG_SIGNEDA_0_CE == "CE1")
          reg_ctrl_0_ce_sig_a = CE1b;
      else if (REG_SIGNEDA_0_CE == "CE2")
          reg_ctrl_0_ce_sig_a = CE2b;
      else if (REG_SIGNEDA_0_CE == "CE3")
          reg_ctrl_0_ce_sig_a = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDB_0_CE == "CE0")
          reg_ctrl_0_ce_sig_b = CE0b;
      else if (REG_SIGNEDB_0_CE == "CE1")
          reg_ctrl_0_ce_sig_b = CE1b;
      else if (REG_SIGNEDB_0_CE == "CE2")
          reg_ctrl_0_ce_sig_b = CE2b;
      else if (REG_SIGNEDB_0_CE == "CE3")
          reg_ctrl_0_ce_sig_b = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDA_1_CE == "CE0")
          reg_ctrl_1_ce_sig_a = CE0b;
      else if (REG_SIGNEDA_1_CE == "CE1")
          reg_ctrl_1_ce_sig_a = CE1b;
      else if (REG_SIGNEDA_1_CE == "CE2")
          reg_ctrl_1_ce_sig_a = CE2b;
      else if (REG_SIGNEDA_1_CE == "CE3")
          reg_ctrl_1_ce_sig_a = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDB_1_CE == "CE0")
          reg_ctrl_1_ce_sig_b = CE0b;
      else if (REG_SIGNEDB_1_CE == "CE1")
          reg_ctrl_1_ce_sig_b = CE1b;
      else if (REG_SIGNEDB_1_CE == "CE2")
          reg_ctrl_1_ce_sig_b = CE2b;
      else if (REG_SIGNEDB_1_CE == "CE3")
          reg_ctrl_1_ce_sig_b = CE3b;
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

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDA_0_RST == "RST0")
          reg_ctrl_0_rst_sig_a = RST0b;
      else if (REG_SIGNEDA_0_RST == "RST1")
          reg_ctrl_0_rst_sig_a = RST1b;
      else if (REG_SIGNEDA_0_RST == "RST2")
          reg_ctrl_0_rst_sig_a = RST2b;
      else if (REG_SIGNEDA_0_RST == "RST3")
          reg_ctrl_0_rst_sig_a = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDB_0_RST == "RST0")
          reg_ctrl_0_rst_sig_b = RST0b;
      else if (REG_SIGNEDB_0_RST == "RST1")
          reg_ctrl_0_rst_sig_b = RST1b;
      else if (REG_SIGNEDB_0_RST == "RST2")
          reg_ctrl_0_rst_sig_b = RST2b;
      else if (REG_SIGNEDB_0_RST == "RST3")
          reg_ctrl_0_rst_sig_b = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDA_1_RST == "RST0")
          reg_ctrl_1_rst_sig_a = RST0b;
      else if (REG_SIGNEDA_1_RST == "RST1")
          reg_ctrl_1_rst_sig_a = RST1b;
      else if (REG_SIGNEDA_1_RST == "RST2")
          reg_ctrl_1_rst_sig_a = RST2b;
      else if (REG_SIGNEDA_1_RST == "RST3")
          reg_ctrl_1_rst_sig_a = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDB_1_RST == "RST0")
          reg_ctrl_1_rst_sig_b = RST0b;
      else if (REG_SIGNEDB_1_RST == "RST1")
          reg_ctrl_1_rst_sig_b = RST1b;
      else if (REG_SIGNEDB_1_RST == "RST2")
          reg_ctrl_1_rst_sig_b = RST2b;
      else if (REG_SIGNEDB_1_RST == "RST3")
          reg_ctrl_1_rst_sig_b = RST3b;
    end

    always @(posedge input_a_clk_sig or posedge input_a_rst_ogsr)
    begin
      if (input_a_rst_ogsr == 1'b1)
        begin
          a_sig_reg <= 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg <= a_sig;
        end
    end

    always @(posedge input_b_clk_sig or posedge input_b_rst_ogsr)
    begin
      if (input_b_rst_ogsr == 1'b1)
        begin
          b_sig_reg <= 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg <= b_sig;
        end
    end

    always @(posedge reg_ctrl_0_clk_sig_a or posedge reg_ctrl_0_rst_ogsr_a)
    begin
      if (reg_ctrl_0_rst_ogsr_a == 1'b1)
        begin
          signeda_reg1 <= 0;
        end
      else if (reg_ctrl_0_ce_sig_a == 1'b1)
        begin
          signeda_reg1 <= signeda_sig;
        end
    end

    always @(posedge reg_ctrl_0_clk_sig_b or posedge reg_ctrl_0_rst_ogsr_b)
    begin
      if (reg_ctrl_0_rst_ogsr_b == 1'b1)
        begin
          signedb_reg1 <= 0;
        end
      else if (reg_ctrl_0_ce_sig_b == 1'b1)
        begin
          signedb_reg1 <= signedb_sig;
        end
    end

    always @(posedge reg_ctrl_1_clk_sig_a or posedge reg_ctrl_1_rst_ogsr_a)
    begin
      if (reg_ctrl_1_rst_ogsr_a == 1'b1)
        begin
          signeda_reg2 <= 0;
        end
      else if (reg_ctrl_1_ce_sig_a == 1'b1)
        begin
          signeda_reg2 <= signeda_p1;
        end
    end

    always @(posedge reg_ctrl_1_clk_sig_b or posedge reg_ctrl_1_rst_ogsr_b)
    begin
      if (reg_ctrl_1_rst_ogsr_b == 1'b1)
        begin
          signedb_reg2 <= 0;
        end
      else if (reg_ctrl_1_ce_sig_b == 1'b1)
        begin
          signedb_reg2 <= signedb_p1;
        end
    end

    always @(signeda_sig or signeda_reg1)
    begin
      if (REG_SIGNEDA_0_CLK == "NONE")
          signeda_p1 = signeda_sig;
      else 
          signeda_p1 = signeda_reg1;
    end

    always @(signedb_sig or signedb_reg1)
    begin
      if (REG_SIGNEDB_0_CLK == "NONE")
          signedb_p1 = signedb_sig;
      else
          signedb_p1 = signedb_reg1;
    end

    always @(signeda_p1 or signeda_reg2)
    begin
      if (REG_SIGNEDA_1_CLK == "NONE")
          signeda_p2 = signeda_p1;
      else 
          signeda_p2 = signeda_reg2;
    end

    always @(signedb_p1 or signedb_reg2)
    begin
      if (REG_SIGNEDB_1_CLK == "NONE")
          signedb_p2 = signedb_p1;
      else
          signedb_p2 = signedb_reg2;
    end

    always @(a_sig or a_sig_reg)
    begin
      if (REG_INPUTA_CLK == "NONE")
          a_sig_p = a_sig;
      else 
          a_sig_p = a_sig_reg;
    end

    assign a_sig_gen = a_sig_p;
    assign b_sig_gen = b_sig_p;

    always @(b_sig or b_sig_reg)
    begin
      if (REG_INPUTB_CLK == "NONE")
          b_sig_p = b_sig;
      else 
          b_sig_p = b_sig_reg;
    end

    assign p_sig_i = (!a_sig_m || !b_sig_m)? 0 : a_sig_m * b_sig_m ;

    always @(posedge pipeline_clk_sig or posedge pipeline_rst_ogsr)
    begin
      if (pipeline_rst_ogsr == 1'b1)
          p_sig_o <= 0;
      else if (pipeline_ce_sig == 1'b1)
          p_sig_o <= p_sig_i;
    end

    always @(posedge output_clk_sig or posedge output_rst_ogsr)
    begin
      if (output_rst_ogsr == 1'b1)
          p_sig_o1 <= 0;
      else if (output_ce_sig == 1'b1)
          p_sig_o1 <= p_sig_ps;
    end

    always @(p_sig_i or p_sig_o)
    begin
      if (REG_PIPELINE_CLK == "NONE")
          p_sig_ps = p_sig_i;
      else 
          p_sig_ps = p_sig_o;
    end

    always @(p_sig_ps or p_sig_o1)
    begin
      if (REG_OUTPUT_CLK == "NONE")
          p_sig = p_sig_ps;
      else 
          p_sig = p_sig_o1;
    end

endmodule

`endcelldefine
