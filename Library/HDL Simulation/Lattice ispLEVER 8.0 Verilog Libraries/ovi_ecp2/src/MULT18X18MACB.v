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

module MULT18X18MACB (ACCUM51,ACCUM50,ACCUM49,ACCUM48,ACCUM47,ACCUM46,ACCUM45,ACCUM44,ACCUM43,ACCUM42,ACCUM41,ACCUM40,ACCUM39,ACCUM38,ACCUM37,ACCUM36,ACCUM35,ACCUM34,ACCUM33,ACCUM32,ACCUM31,ACCUM30,ACCUM29,ACCUM28,ACCUM27,ACCUM26,ACCUM25,ACCUM24,ACCUM23,ACCUM22,ACCUM21,ACCUM20,ACCUM19,ACCUM18,ACCUM17,ACCUM16,ACCUM15,ACCUM14,ACCUM13,ACCUM12,ACCUM11,ACCUM10,ACCUM9,ACCUM8,ACCUM7,ACCUM6,ACCUM5,ACCUM4,ACCUM3,ACCUM2,ACCUM1,ACCUM0,SROA17,SROA16,SROA15,SROA14,SROA13,SROA12,SROA11,SROA10,SROA9,SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0,SROB17,SROB16,SROB15,SROB14,SROB13,SROB12,SROB11,SROB10,SROB9,SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0,OVERFLOW,A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0,B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0,SRIA17,SRIA16,SRIA15,SRIA14,SRIA13,SRIA12,SRIA11,SRIA10,SRIA9,SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0,SRIB17,SRIB16,SRIB15,SRIB14,SRIB13,SRIB12,SRIB11,SRIB10,SRIB9,SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0,ADDNSUB,SIGNEDA,SIGNEDB,ACCUMSLOAD,CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SOURCEA, SOURCEB, LD51, LD50, LD49, LD48, LD47, LD46, LD45, LD44, LD43, LD42, LD41, LD40, LD39, LD38, LD37, LD36, LD35, LD34, LD33, LD32, LD31, LD30, LD29, LD28, LD27, LD26, LD25, LD24, LD23, LD22, LD21, LD20, LD19, LD18, LD17, LD16, LD15, LD14, LD13, LD12, LD11, LD10, LD9, LD8, LD7, LD6, LD5, LD4, LD3, LD2, LD1, LD0);
input A17,A16,A15,A14,A13,A12,A11,A10,A9;
input A8,A7,A6,A5,A4,A3,A2,A1,A0;
input B17,B16,B15,B14,B13,B12,B11,B10,B9;
input B8,B7,B6,B5,B4,B3,B2,B1,B0;
input LD51, LD50, LD49, LD48, LD47, LD46, LD45, LD44, LD43, LD42, LD41, LD40;
input LD39, LD38, LD37, LD36, LD35, LD34, LD33, LD32, LD31, LD30;
input LD29, LD28, LD27, LD26, LD25, LD24, LD23, LD22, LD21, LD20;
input LD19, LD18, LD17, LD16, LD15, LD14, LD13, LD12, LD11, LD10;
input LD9, LD8, LD7, LD6, LD5, LD4, LD3, LD2, LD1, LD0;
input ADDNSUB, SIGNEDA,SIGNEDB,ACCUMSLOAD,SOURCEA, SOURCEB;
input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3;
input SRIA17,SRIA16,SRIA15,SRIA14,SRIA13,SRIA12,SRIA11,SRIA10,SRIA9;
input SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0;
input SRIB17,SRIB16,SRIB15,SRIB14,SRIB13,SRIB12,SRIB11,SRIB10,SRIB9;
input SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0;
output SROA17,SROA16,SROA15,SROA14,SROA13,SROA12,SROA11,SROA10,SROA9;
output SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0;
output SROB17,SROB16,SROB15,SROB14,SROB13,SROB12,SROB11,SROB10,SROB9;
output SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0;
output ACCUM51,ACCUM50,ACCUM49,ACCUM48,ACCUM47,ACCUM46,ACCUM45,ACCUM44,ACCUM43,ACCUM42,ACCUM41,ACCUM40,ACCUM39,ACCUM38,ACCUM37,ACCUM36,ACCUM35,ACCUM34,ACCUM33,ACCUM32,ACCUM31,ACCUM30,ACCUM29,ACCUM28,ACCUM27,ACCUM26,ACCUM25,ACCUM24,ACCUM23,ACCUM22,ACCUM21,ACCUM20,ACCUM19,ACCUM18,ACCUM17,ACCUM16,ACCUM15,ACCUM14,ACCUM13,ACCUM12,ACCUM11,ACCUM10,ACCUM9,ACCUM8,ACCUM7,ACCUM6,ACCUM5,ACCUM4,ACCUM3,ACCUM2,ACCUM1,ACCUM0,OVERFLOW; 

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
parameter REG_ACCUMSLOAD_0_CLK = "NONE";
parameter REG_ACCUMSLOAD_0_CE = "CE0";
parameter REG_ACCUMSLOAD_0_RST = "RST0";
parameter REG_ACCUMSLOAD_1_CLK = "NONE";
parameter REG_ACCUMSLOAD_1_CE = "CE0";
parameter REG_ACCUMSLOAD_1_RST = "RST0";
parameter REG_ADDNSUB_0_CLK = "NONE";
parameter REG_ADDNSUB_0_CE = "CE0";
parameter REG_ADDNSUB_0_RST = "RST0";
parameter REG_ADDNSUB_1_CLK = "NONE";
parameter REG_ADDNSUB_1_CE = "CE0";
parameter REG_ADDNSUB_1_RST = "RST0";
parameter GSR = "ENABLED";


supply0 GND; 
supply1 VCC; 

    wire CE0b,CE1b,CE2b,CE3b,CLK0b,CLK1b,CLK2b,CLK3b,RST0b,RST1b,RST2b,RST3b;

    wire [17:0] a_sig, b_sig;
    wire [51:0] ld_sig;
    reg  [17:0] a_sig_reg, b_sig_reg;
    reg  [17:0] a_sig_gen, b_sig_gen;
    reg [17:0] a_sig_s_1, b_sig_s_1;
    wire [17:0] a_sig_s, b_sig_s;
    wire [35:0] p_sig_i;

    //reg [17:0] sroa_reg,srob_reg;
    wire [17:0] sroa_reg,srob_reg;

    reg [35:0] p_sig_ps;
    reg [52:0] p_sig_ps_accum;
    reg [52:0] p_sig_ps_accum_2;
    wire [52:0] p_sig_ps_accum_1;
    wire [52:0] accum_sig;
    reg [52:0] accum_sig_l;
    reg [52:0] accum_reg;
    reg [35:0] a_sig_m, b_sig_m;

    wire sourcea_sig;
    wire sourceb_sig;
    wire signedab_p2;
    wire signeda_sig;
    reg  signeda_p1;
    reg  signeda_p2;
    reg  signeda_reg1;
    reg  signeda_reg2;
    wire signedb_sig;
    reg  signedb_p1;
    reg  signedb_p2;
    reg  signedb_reg1;
    reg  signedb_reg2;

    wire accumsload_sig;
    reg  accumsload_p1;
    reg  accumsload_p2;
    reg  accumsload_p3;
    reg  accumsload_reg1;
    reg  accumsload_reg2;

    wire addnsub_sig;
    reg  addnsub_p1;
    reg  addnsub_p2;
    reg  addnsub_reg1;
    reg  addnsub_reg2;

    wire overflow_sig;
    reg overflow_sig_1;
    reg overflow_sig_2;

    wire input_a_rst_ogsr;
    wire input_b_rst_ogsr;
    wire pipeline_rst_ogsr;
    wire output_rst_ogsr;
    wire reg_signeda_0_rst_ogsr;
    wire reg_signeda_1_rst_ogsr;
    wire reg_signedb_0_rst_ogsr;
    wire reg_signedb_1_rst_ogsr;
    wire reg_addnsub_0_rst_ogsr;
    wire reg_addnsub_1_rst_ogsr;
    wire reg_accumsload_0_rst_ogsr;
    wire reg_accumsload_1_rst_ogsr;

    reg input_a_clk_sig,input_a_ce_sig,input_a_rst_sig;
    reg input_b_clk_sig,input_b_ce_sig,input_b_rst_sig;
    reg pipeline_clk_sig,pipeline_ce_sig,pipeline_rst_sig;
    reg output_clk_sig,output_ce_sig,output_rst_sig;

    reg reg_signeda_0_clk_sig,reg_signeda_0_ce_sig,reg_signeda_0_rst_sig;
    reg reg_signeda_1_clk_sig,reg_signeda_1_ce_sig,reg_signeda_1_rst_sig;
    reg reg_signedb_0_clk_sig,reg_signedb_0_ce_sig,reg_signedb_0_rst_sig;
    reg reg_signedb_1_clk_sig,reg_signedb_1_ce_sig,reg_signedb_1_rst_sig;
    reg reg_addnsub_0_clk_sig,reg_addnsub_0_ce_sig,reg_addnsub_0_rst_sig;
    reg reg_addnsub_1_clk_sig,reg_addnsub_1_ce_sig,reg_addnsub_1_rst_sig;
    reg reg_accumsload_0_clk_sig,reg_accumsload_0_ce_sig,reg_accumsload_0_rst_sig;
    reg reg_accumsload_1_clk_sig,reg_accumsload_1_ce_sig,reg_accumsload_1_rst_sig;

    reg [35:0] p_sig_o,p_sig_o1;

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
    or INST5 (reg_signeda_0_rst_ogsr, reg_signeda_0_rst_sig, SR1);
    or INST6 (reg_signeda_1_rst_ogsr, reg_signeda_1_rst_sig, SR1);
    or INST11 (reg_signedb_0_rst_ogsr, reg_signedb_0_rst_sig, SR1);
    or INST12 (reg_signedb_1_rst_ogsr, reg_signedb_1_rst_sig, SR1);
    or INST7 (reg_addnsub_0_rst_ogsr, reg_addnsub_0_rst_sig, SR1);
    or INST8 (reg_addnsub_1_rst_ogsr, reg_addnsub_1_rst_sig, SR1);
    or INST9 (reg_accumsload_0_rst_ogsr, reg_accumsload_0_rst_sig, SR1);
    or INST10 (reg_accumsload_1_rst_ogsr, reg_accumsload_1_rst_sig, SR1);

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

    buf inst_LD0 (ld_sig[0], LD0);
    buf inst_LD1 (ld_sig[1], LD1);
    buf inst_LD2 (ld_sig[2], LD2);
    buf inst_LD3 (ld_sig[3], LD3);
    buf inst_LD4 (ld_sig[4], LD4);
    buf inst_LD5 (ld_sig[5], LD5);
    buf inst_LD6 (ld_sig[6], LD6);
    buf inst_LD7 (ld_sig[7], LD7);
    buf inst_LD8 (ld_sig[8], LD8);
    buf inst_LD9 (ld_sig[9], LD9);
    buf inst_LD10 (ld_sig[10], LD10);
    buf inst_LD11 (ld_sig[11], LD11);
    buf inst_LD12 (ld_sig[12], LD12);
    buf inst_LD13 (ld_sig[13], LD13);
    buf inst_LD14 (ld_sig[14], LD14);
    buf inst_LD15 (ld_sig[15], LD15);
    buf inst_LD16 (ld_sig[16], LD16);
    buf inst_LD17 (ld_sig[17], LD17);
    buf inst_LD18 (ld_sig[18], LD18);
    buf inst_LD19 (ld_sig[19], LD19);
    buf inst_LD20 (ld_sig[20], LD20);
    buf inst_LD21 (ld_sig[21], LD21);
    buf inst_LD22 (ld_sig[22], LD22);
    buf inst_LD23 (ld_sig[23], LD23);
    buf inst_LD24 (ld_sig[24], LD24);
    buf inst_LD25 (ld_sig[25], LD25);
    buf inst_LD26 (ld_sig[26], LD26);
    buf inst_LD27 (ld_sig[27], LD27);
    buf inst_LD28 (ld_sig[28], LD28);
    buf inst_LD29 (ld_sig[29], LD29);
    buf inst_LD30 (ld_sig[30], LD30);
    buf inst_LD31 (ld_sig[31], LD31);
    buf inst_LD32 (ld_sig[32], LD32);
    buf inst_LD33 (ld_sig[33], LD33);
    buf inst_LD34 (ld_sig[34], LD34);
    buf inst_LD35 (ld_sig[35], LD35);
    buf inst_LD36 (ld_sig[36], LD36);
    buf inst_LD37 (ld_sig[37], LD37);
    buf inst_LD38 (ld_sig[38], LD38);
    buf inst_LD39 (ld_sig[39], LD39);
    buf inst_LD40 (ld_sig[40], LD40);
    buf inst_LD41 (ld_sig[41], LD41);
    buf inst_LD42 (ld_sig[42], LD42);
    buf inst_LD43 (ld_sig[43], LD43);
    buf inst_LD44 (ld_sig[44], LD44);
    buf inst_LD45 (ld_sig[45], LD45);
    buf inst_LD46 (ld_sig[46], LD46);
    buf inst_LD47 (ld_sig[47], LD47);
    buf inst_LD48 (ld_sig[48], LD48);
    buf inst_LD49 (ld_sig[49], LD49);
    buf inst_LD50 (ld_sig[50], LD50);
    buf inst_LD51 (ld_sig[51], LD51);

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

    buf inst_SIGNEDA (signeda_sig, SIGNEDA);
    buf inst_SIGNEDB (signedb_sig, SIGNEDB);
    buf inst_ACCUMSLOAD (accumsload_sig, ACCUMSLOAD);
    buf inst_ADDNSUB (addnsub_sig, ADDNSUB);
    buf inst_SOURCEA (sourcea_sig, SOURCEA);
    buf inst_SOURCEB (sourceb_sig, SOURCEB);

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

    buf inst_ACCUM0 (ACCUM0, accum_reg[0]);
    buf inst_ACCUM1 (ACCUM1, accum_reg[1]);
    buf inst_ACCUM2 (ACCUM2, accum_reg[2]);
    buf inst_ACCUM3 (ACCUM3, accum_reg[3]);
    buf inst_ACCUM4 (ACCUM4, accum_reg[4]);
    buf inst_ACCUM5 (ACCUM5, accum_reg[5]);
    buf inst_ACCUM6 (ACCUM6, accum_reg[6]);
    buf inst_ACCUM7 (ACCUM7, accum_reg[7]);
    buf inst_ACCUM8 (ACCUM8, accum_reg[8]);
    buf inst_ACCUM9 (ACCUM9, accum_reg[9]);
    buf inst_ACCUM10 (ACCUM10, accum_reg[10]);
    buf inst_ACCUM11 (ACCUM11, accum_reg[11]);
    buf inst_ACCUM12 (ACCUM12, accum_reg[12]);
    buf inst_ACCUM13 (ACCUM13, accum_reg[13]);
    buf inst_ACCUM14 (ACCUM14, accum_reg[14]);
    buf inst_ACCUM15 (ACCUM15, accum_reg[15]);
    buf inst_ACCUM16 (ACCUM16, accum_reg[16]);
    buf inst_ACCUM17 (ACCUM17, accum_reg[17]);
    buf inst_ACCUM18 (ACCUM18, accum_reg[18]);
    buf inst_ACCUM19 (ACCUM19, accum_reg[19]);
    buf inst_ACCUM20 (ACCUM20, accum_reg[20]);
    buf inst_ACCUM21 (ACCUM21, accum_reg[21]);
    buf inst_ACCUM22 (ACCUM22, accum_reg[22]);
    buf inst_ACCUM23 (ACCUM23, accum_reg[23]);
    buf inst_ACCUM24 (ACCUM24, accum_reg[24]);
    buf inst_ACCUM25 (ACCUM25, accum_reg[25]);
    buf inst_ACCUM26 (ACCUM26, accum_reg[26]);
    buf inst_ACCUM27 (ACCUM27, accum_reg[27]);
    buf inst_ACCUM28 (ACCUM28, accum_reg[28]);
    buf inst_ACCUM29 (ACCUM29, accum_reg[29]);
    buf inst_ACCUM30 (ACCUM30, accum_reg[30]);
    buf inst_ACCUM31 (ACCUM31, accum_reg[31]);
    buf inst_ACCUM32 (ACCUM32, accum_reg[32]);
    buf inst_ACCUM33 (ACCUM33, accum_reg[33]);
    buf inst_ACCUM34 (ACCUM34, accum_reg[34]);
    buf inst_ACCUM35 (ACCUM35, accum_reg[35]);
    buf inst_ACCUM36 (ACCUM36, accum_reg[36]);
    buf inst_ACCUM37 (ACCUM37, accum_reg[37]);
    buf inst_ACCUM38 (ACCUM38, accum_reg[38]);
    buf inst_ACCUM39 (ACCUM39, accum_reg[39]);
    buf inst_ACCUM40 (ACCUM40, accum_reg[40]);
    buf inst_ACCUM41 (ACCUM41, accum_reg[41]);
    buf inst_ACCUM42 (ACCUM42, accum_reg[42]);
    buf inst_ACCUM43 (ACCUM43, accum_reg[43]);
    buf inst_ACCUM44 (ACCUM44, accum_reg[44]);
    buf inst_ACCUM45 (ACCUM45, accum_reg[45]);
    buf inst_ACCUM46 (ACCUM46, accum_reg[46]);
    buf inst_ACCUM47 (ACCUM47, accum_reg[47]);
    buf inst_ACCUM48 (ACCUM48, accum_reg[48]);
    buf inst_ACCUM49 (ACCUM49, accum_reg[49]);
    buf inst_ACCUM50 (ACCUM50, accum_reg[50]);
    buf inst_ACCUM51 (ACCUM51, accum_reg[51]);
    buf inst_OVERFLOW (OVERFLOW, overflow_sig);

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

    always @(p_sig_ps or signeda_p2 or signedb_p2)
    begin
      if ((signeda_p2 || signedb_p2) == 1'b1)
        begin
          p_sig_ps_accum[35:0] = p_sig_ps[35:0];
          p_sig_ps_accum[52:36] = {p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35],
                           p_sig_ps[35]};
        end
      else 
        begin
          p_sig_ps_accum[35:0] = p_sig_ps[35:0];
          p_sig_ps_accum[52:36] = 0;
        end
    end

    always @(a_sig_s or a_sig or sourcea_sig)
    begin
      if (sourcea_sig == 1'b1)
          a_sig_s_1 = a_sig_s;
      else if (sourcea_sig == 1'b0)
          a_sig_s_1 = a_sig;
    end

    always @(b_sig_s or b_sig or sourceb_sig)
    begin
      if (sourceb_sig == 1'b1)
          b_sig_s_1 = b_sig_s;
      else if (sourceb_sig == 1'b0)
          b_sig_s_1 = b_sig;
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
      if (REG_SIGNEDA_0_CLK == "CLK0")
          reg_signeda_0_clk_sig = CLK0b;
      else if (REG_SIGNEDA_0_CLK == "CLK1")
          reg_signeda_0_clk_sig = CLK1b;
      else if (REG_SIGNEDA_0_CLK == "CLK2")
          reg_signeda_0_clk_sig = CLK2b;
      else if (REG_SIGNEDA_0_CLK == "CLK3")
          reg_signeda_0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDB_0_CLK == "CLK0")
          reg_signedb_0_clk_sig = CLK0b;
      else if (REG_SIGNEDB_0_CLK == "CLK1")
          reg_signedb_0_clk_sig = CLK1b;
      else if (REG_SIGNEDB_0_CLK == "CLK2")
          reg_signedb_0_clk_sig = CLK2b;
      else if (REG_SIGNEDB_0_CLK == "CLK3")
          reg_signedb_0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDA_1_CLK == "CLK0")
          reg_signeda_1_clk_sig = CLK0b;
      else if (REG_SIGNEDA_1_CLK == "CLK1")
          reg_signeda_1_clk_sig = CLK1b;
      else if (REG_SIGNEDA_1_CLK == "CLK2")
          reg_signeda_1_clk_sig = CLK2b;
      else if (REG_SIGNEDA_1_CLK == "CLK3")
          reg_signeda_1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDB_1_CLK == "CLK0")
          reg_signedb_1_clk_sig = CLK0b;
      else if (REG_SIGNEDB_1_CLK == "CLK1")
          reg_signedb_1_clk_sig = CLK1b;
      else if (REG_SIGNEDB_1_CLK == "CLK2")
          reg_signedb_1_clk_sig = CLK2b;
      else if (REG_SIGNEDB_1_CLK == "CLK3")
          reg_signedb_1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ADDNSUB_0_CLK == "CLK0")
          reg_addnsub_0_clk_sig = CLK0b;
      else if (REG_ADDNSUB_0_CLK == "CLK1")
          reg_addnsub_0_clk_sig = CLK1b;
      else if (REG_ADDNSUB_0_CLK == "CLK2")
          reg_addnsub_0_clk_sig = CLK2b;
      else if (REG_ADDNSUB_0_CLK == "CLK3")
          reg_addnsub_0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ADDNSUB_1_CLK == "CLK0")
          reg_addnsub_1_clk_sig = CLK0b;
      else if (REG_ADDNSUB_1_CLK == "CLK1")
          reg_addnsub_1_clk_sig = CLK1b;
      else if (REG_ADDNSUB_1_CLK == "CLK2")
          reg_addnsub_1_clk_sig = CLK2b;
      else if (REG_ADDNSUB_1_CLK == "CLK3")
          reg_addnsub_1_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ACCUMSLOAD_0_CLK == "CLK0")
          reg_accumsload_0_clk_sig = CLK0b;
      else if (REG_ACCUMSLOAD_0_CLK == "CLK1")
          reg_accumsload_0_clk_sig = CLK1b;
      else if (REG_ACCUMSLOAD_0_CLK == "CLK2")
          reg_accumsload_0_clk_sig = CLK2b;
      else if (REG_ACCUMSLOAD_0_CLK == "CLK3")
          reg_accumsload_0_clk_sig = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_ACCUMSLOAD_1_CLK == "CLK0")
          reg_accumsload_1_clk_sig = CLK0b;
      else if (REG_ACCUMSLOAD_1_CLK == "CLK1")
          reg_accumsload_1_clk_sig = CLK1b;
      else if (REG_ACCUMSLOAD_1_CLK == "CLK2")
          reg_accumsload_1_clk_sig = CLK2b;
      else if (REG_ACCUMSLOAD_1_CLK == "CLK3")
          reg_accumsload_1_clk_sig = CLK3b;
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

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDA_0_CE == "CE0")
          reg_signeda_0_ce_sig = CE0b;
      else if (REG_SIGNEDA_0_CE == "CE1")
          reg_signeda_0_ce_sig = CE1b;
      else if (REG_SIGNEDA_0_CE == "CE2")
          reg_signeda_0_ce_sig = CE2b;
      else if (REG_SIGNEDA_0_CE == "CE3")
          reg_signeda_0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDB_0_CE == "CE0")
          reg_signedb_0_ce_sig = CE0b;
      else if (REG_SIGNEDB_0_CE == "CE1")
          reg_signedb_0_ce_sig = CE1b;
      else if (REG_SIGNEDB_0_CE == "CE2")
          reg_signedb_0_ce_sig = CE2b;
      else if (REG_SIGNEDB_0_CE == "CE3")
          reg_signedb_0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDA_1_CE == "CE0")
          reg_signeda_1_ce_sig = CE0b;
      else if (REG_SIGNEDA_1_CE == "CE1")
          reg_signeda_1_ce_sig = CE1b;
      else if (REG_SIGNEDA_1_CE == "CE2")
          reg_signeda_1_ce_sig = CE2b;
      else if (REG_SIGNEDA_1_CE == "CE3")
          reg_signeda_1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDB_1_CE == "CE0")
          reg_signedb_1_ce_sig = CE0b;
      else if (REG_SIGNEDB_1_CE == "CE1")
          reg_signedb_1_ce_sig = CE1b;
      else if (REG_SIGNEDB_1_CE == "CE2")
          reg_signedb_1_ce_sig = CE2b;
      else if (REG_SIGNEDB_1_CE == "CE3")
          reg_signedb_1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ADDNSUB_0_CE == "CE0")
          reg_addnsub_0_ce_sig = CE0b;
      else if (REG_ADDNSUB_0_CE == "CE1")
          reg_addnsub_0_ce_sig = CE1b;
      else if (REG_ADDNSUB_0_CE == "CE2")
          reg_addnsub_0_ce_sig = CE2b;
      else if (REG_ADDNSUB_0_CE == "CE3")
          reg_addnsub_0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ADDNSUB_1_CE == "CE0")
          reg_addnsub_1_ce_sig = CE0b;
      else if (REG_ADDNSUB_1_CE == "CE1")
          reg_addnsub_1_ce_sig = CE1b;
      else if (REG_ADDNSUB_1_CE == "CE2")
          reg_addnsub_1_ce_sig = CE2b;
      else if (REG_ADDNSUB_1_CE == "CE3")
          reg_addnsub_1_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ACCUMSLOAD_0_CE == "CE0")
          reg_accumsload_0_ce_sig = CE0b;
      else if (REG_ACCUMSLOAD_0_CE == "CE1")
          reg_accumsload_0_ce_sig = CE1b;
      else if (REG_ACCUMSLOAD_0_CE == "CE2")
          reg_accumsload_0_ce_sig = CE2b;
      else if (REG_ACCUMSLOAD_0_CE == "CE3")
          reg_accumsload_0_ce_sig = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_ACCUMSLOAD_1_CE == "CE0")
          reg_accumsload_1_ce_sig = CE0b;
      else if (REG_ACCUMSLOAD_1_CE == "CE1")
          reg_accumsload_1_ce_sig = CE1b;
      else if (REG_ACCUMSLOAD_1_CE == "CE2")
          reg_accumsload_1_ce_sig = CE2b;
      else if (REG_ACCUMSLOAD_1_CE == "CE3")
          reg_accumsload_1_ce_sig = CE3b;
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
          reg_signeda_0_rst_sig = RST0b;
      else if (REG_SIGNEDA_0_RST == "RST1")
          reg_signeda_0_rst_sig = RST1b;
      else if (REG_SIGNEDA_0_RST == "RST2")
          reg_signeda_0_rst_sig = RST2b;
      else if (REG_SIGNEDA_0_RST == "RST3")
          reg_signeda_0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDB_0_RST == "RST0")
          reg_signedb_0_rst_sig = RST0b;
      else if (REG_SIGNEDB_0_RST == "RST1")
          reg_signedb_0_rst_sig = RST1b;
      else if (REG_SIGNEDB_0_RST == "RST2")
          reg_signedb_0_rst_sig = RST2b;
      else if (REG_SIGNEDB_0_RST == "RST3")
          reg_signedb_0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDA_1_RST == "RST0")
          reg_signeda_1_rst_sig = RST0b;
      else if (REG_SIGNEDA_1_RST == "RST1")
          reg_signeda_1_rst_sig = RST1b;
      else if (REG_SIGNEDA_1_RST == "RST2")
          reg_signeda_1_rst_sig = RST2b;
      else if (REG_SIGNEDA_1_RST == "RST3")
          reg_signeda_1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDB_1_RST == "RST0")
          reg_signedb_1_rst_sig = RST0b;
      else if (REG_SIGNEDB_1_RST == "RST1")
          reg_signedb_1_rst_sig = RST1b;
      else if (REG_SIGNEDB_1_RST == "RST2")
          reg_signedb_1_rst_sig = RST2b;
      else if (REG_SIGNEDB_1_RST == "RST3")
          reg_signedb_1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ADDNSUB_0_RST == "RST0")
          reg_addnsub_0_rst_sig = RST0b;
      else if (REG_ADDNSUB_0_RST == "RST1")
          reg_addnsub_0_rst_sig = RST1b;
      else if (REG_ADDNSUB_0_RST == "RST2")
          reg_addnsub_0_rst_sig = RST2b;
      else if (REG_ADDNSUB_0_RST == "RST3")
          reg_addnsub_0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ADDNSUB_1_RST == "RST0")
          reg_addnsub_1_rst_sig = RST0b;
      else if (REG_ADDNSUB_1_RST == "RST1")
          reg_addnsub_1_rst_sig = RST1b;
      else if (REG_ADDNSUB_1_RST == "RST2")
          reg_addnsub_1_rst_sig = RST2b;
      else if (REG_ADDNSUB_1_RST == "RST3")
          reg_addnsub_1_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ACCUMSLOAD_0_RST == "RST0")
          reg_accumsload_0_rst_sig = RST0b;
      else if (REG_ACCUMSLOAD_0_RST == "RST1")
          reg_accumsload_0_rst_sig = RST1b;
      else if (REG_ACCUMSLOAD_0_RST == "RST2")
          reg_accumsload_0_rst_sig = RST2b;
      else if (REG_ACCUMSLOAD_0_RST == "RST3")
          reg_accumsload_0_rst_sig = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_ACCUMSLOAD_1_RST == "RST0")
          reg_accumsload_1_rst_sig = RST0b;
      else if (REG_ACCUMSLOAD_1_RST == "RST1")
          reg_accumsload_1_rst_sig = RST1b;
      else if (REG_ACCUMSLOAD_1_RST == "RST2")
          reg_accumsload_1_rst_sig = RST2b;
      else if (REG_ACCUMSLOAD_1_RST == "RST3")
          reg_accumsload_1_rst_sig = RST3b;
    end

    always @(posedge input_a_clk_sig or posedge input_a_rst_ogsr)
    begin
      if (input_a_rst_ogsr == 1'b1)
        begin
          a_sig_reg <= 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg <= a_sig_s_1;
        end
    end

    always @(a_sig_s_1 or a_sig_reg)
    begin
      if (REG_INPUTA_CLK == "NONE")
          a_sig_gen = a_sig_s_1;
      else
          a_sig_gen = a_sig_reg;
    end

    assign sroa_reg = a_sig_gen;

    always @(posedge input_b_clk_sig or posedge input_b_rst_ogsr)
    begin
      if (input_b_rst_ogsr == 1'b1)
        begin
          b_sig_reg <= 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg <= b_sig_s_1;
        end
    end

    always @(b_sig_s_1 or b_sig_reg)
    begin
      if (REG_INPUTB_CLK == "NONE")
          b_sig_gen = b_sig_s_1;
      else
          b_sig_gen = b_sig_reg;
    end

    assign srob_reg = b_sig_gen;

    always @(posedge reg_signeda_0_clk_sig or posedge reg_signeda_0_rst_ogsr)
    begin
      if (reg_signeda_0_rst_ogsr == 1'b1)
        begin
          signeda_reg1 <= 0;
        end
      else if (reg_signeda_0_ce_sig == 1'b1)
        begin
          signeda_reg1 <= signeda_sig;
        end
    end

    always @(posedge reg_signedb_0_clk_sig or posedge reg_signedb_0_rst_ogsr)
    begin
      if (reg_signedb_0_rst_ogsr == 1'b1)
        begin
          signedb_reg1 <= 0;
        end
      else if (reg_signedb_0_ce_sig == 1'b1)
        begin
          signedb_reg1 <= signedb_sig;
        end
    end

    always @(posedge reg_signeda_1_clk_sig or posedge reg_signeda_1_rst_ogsr)
    begin
      if (reg_signeda_1_rst_ogsr == 1'b1)
        begin
          signeda_reg2 <= 0;
        end
      else if (reg_signeda_1_ce_sig == 1'b1)
        begin
          signeda_reg2 <= signeda_p1;
        end
    end

    always @(posedge reg_signedb_1_clk_sig or posedge reg_signedb_1_rst_ogsr)
    begin
      if (reg_signedb_1_rst_ogsr == 1'b1)
        begin
          signedb_reg2 <= 0;
        end
      else if (reg_signedb_1_ce_sig == 1'b1)
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

    or INST13 (signedab_p2, signeda_p2, signedb_p2);

    always @(posedge reg_addnsub_0_clk_sig or posedge reg_addnsub_0_rst_ogsr)
    begin
      if (reg_addnsub_0_rst_ogsr == 1'b1)
        begin
          addnsub_reg1 <= 0;
        end
      else if (reg_addnsub_0_ce_sig == 1'b1)
        begin
          addnsub_reg1 <= addnsub_sig;
        end
    end

    always @(posedge reg_addnsub_1_clk_sig or posedge reg_addnsub_1_rst_ogsr)
    begin
      if (reg_addnsub_1_rst_ogsr == 1'b1)
        begin
          addnsub_reg2 <= 0;
        end
      else if (reg_addnsub_1_ce_sig == 1'b1)
        begin
          addnsub_reg2 <= addnsub_p1;
        end
    end

    always @(addnsub_sig or addnsub_reg1)
    begin
      if (REG_ADDNSUB_0_CLK == "NONE")
          addnsub_p1 = addnsub_sig;
      else 
          addnsub_p1 = addnsub_reg1;
    end

    always @(addnsub_p1 or addnsub_reg2)
    begin
      if (REG_ADDNSUB_1_CLK == "NONE")
          addnsub_p2 = addnsub_p1;
      else 
          addnsub_p2 = addnsub_reg2;
    end

    always @(posedge reg_accumsload_0_clk_sig or posedge reg_accumsload_0_rst_ogsr)
    begin
      if (reg_accumsload_0_rst_ogsr == 1'b1)
        begin
          accumsload_reg1 <= 0;
        end
      else if (reg_accumsload_0_ce_sig == 1'b1)
        begin
          accumsload_reg1 <= accumsload_sig;
        end
    end

    always @(posedge reg_accumsload_1_clk_sig or posedge reg_accumsload_1_rst_ogsr)
    begin
      if (reg_accumsload_1_rst_ogsr == 1'b1)
        begin
          accumsload_reg2 <= 0;
        end
      else if (reg_accumsload_1_ce_sig == 1'b1)
        begin
          accumsload_reg2 <= accumsload_p1;
        end
    end

    always @(accumsload_sig or accumsload_reg1)
    begin
      if (REG_ACCUMSLOAD_0_CLK == "NONE")
          accumsload_p1 = accumsload_sig;
      else 
          accumsload_p1 = accumsload_reg1;
    end

    always @(accumsload_p1 or accumsload_reg2)
    begin
      if (REG_ACCUMSLOAD_1_CLK == "NONE")
          accumsload_p2 = accumsload_p1;
      else 
          accumsload_p2 = accumsload_reg2;
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
          accum_reg <= 0;
      else if (output_ce_sig == 1'b1)
          accum_reg <= accum_sig;
    end

    always @(p_sig_i or p_sig_o)
    begin
      if (REG_PIPELINE_CLK == "NONE")
          p_sig_ps = p_sig_i;
      else 
          p_sig_ps = p_sig_o;
    end

    always @(accumsload_p2 or ld_sig or accum_reg)
    begin
      if (accumsload_p2 == 1'b1)
      begin
         accum_sig_l[51:0] = ld_sig;
         if ((signeda_p2 || signedb_p2) == 1'b1) 
            accum_sig_l[52] = ld_sig[51];
         else 
            accum_sig_l[52] = 1'b0;
      end
      else 
      begin
         accum_sig_l[51:0] = accum_reg[51:0];
         if ((signeda_p2 || signedb_p2) == 1'b1)
            accum_sig_l[52] = accum_reg[51];
         else
            accum_sig_l[52] = 1'b0;
      end
    end

    assign accum_sig = addnsub_p2 ? (accum_sig_l + p_sig_ps_accum) : (accum_sig_l - p_sig_ps_accum);

    always @(posedge output_clk_sig or posedge output_rst_ogsr)
    begin
      if (output_rst_ogsr == 1'b1) begin
          overflow_sig_1 <= 1'b0;
      end
      else if (output_ce_sig == 1'b1) begin
          overflow_sig_1 <= accum_reg[52]; 
      end
    end

    always @(posedge output_clk_sig or posedge output_rst_ogsr)
    begin
      if (output_rst_ogsr == 1'b1) begin  
          overflow_sig_2 <= 1'b0;
          p_sig_ps_accum_2 <= 0;
          accumsload_p3 <= 0;
      end
      else if (output_ce_sig == 1'b1) begin 
          overflow_sig_2 <= (!accum_reg[52] && accum_reg[51] || accum_reg[52] && !accum_reg[51]);
          p_sig_ps_accum_2 <= p_sig_ps_accum;
          accumsload_p3 <= accumsload_p2;
      end
     end

//    assign overflow_sig = accumsload_p3 ? 
//                         (!addnsub_p2 && !signedab_p2) ? ((p_sig_ps_accum_2 == 0) ? 1'b0: 1'b1) :
//                         (!addnsub_p2 && signedab_p2)  ? 1'b0:
//                         (addnsub_p2  && !signedab_p2) ? 1'b0:
//                         (addnsub_p2  && !signedab_p2) ? ((accum_reg[52]) ? 1'b1 : 1'b0):
//                         (addnsub_p2  &&  signedab_p2) ? 1'b0: p_sig_ps_accum_2[52] :
//                         signedab_p2 ? (!overflow_sig_2 && (!accum_reg[52] && accum_reg[51] || accum_reg[52] && !accum_reg[51])): (accum_reg[52] && !overflow_sig_1);

//    assign overflow_sig = signedab_p2 ? (!overflow_sig_2 && (!accum_reg[52] && accum_reg[51] || accum_reg[52] && !accum_reg[51])): (accum_reg[52] && !overflow_sig_1);


    assign overflow_sig = (signeda_p2 || signedb_p2) ? ((!accum_reg[52] && accum_reg[51]) || (accum_reg[52] && !accum_reg[51])): (accum_reg[52]);

endmodule

`endcelldefine
