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

module MULT9X9B (P17,P16,P15,P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0,SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0,SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0,A8,A7,A6,A5,A4,A3,A2,A1,A0,B8,B7,B6,B5,B4,B3,B2,B1,B0,SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0,SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0,SIGNEDA,SIGNEDB,CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SOURCEA,SOURCEB);
input A8,A7,A6,A5,A4,A3,A2,A1,A0;
input B8,B7,B6,B5,B4,B3,B2,B1,B0;
input SIGNEDA,SIGNEDB,SOURCEA,SOURCEB;
input CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3;
input SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0;
input SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0;
output SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0;
output SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0;
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
parameter REG_SIGNEDA_CLK = "NONE";
parameter REG_SIGNEDA_CE = "CE0";
parameter REG_SIGNEDA_RST = "RST0";
parameter REG_SIGNEDB_CLK = "NONE";
parameter REG_SIGNEDB_CE = "CE0";
parameter REG_SIGNEDB_RST = "RST0";
parameter GSR = "ENABLED";


supply0 GND; 
supply1 VCC; 

    wire CE0b,CE1b,CE2b,CE3b,CLK0b,CLK1b,CLK2b,CLK3b,RST0b,RST1b,RST2b,RST3b;

    wire [8:0] a_sig, b_sig;
    reg  [8:0] a_sig_reg, b_sig_reg;
    reg  [8:0] a_sig_gen, b_sig_gen;
    wire [8:0] a_sig_s, b_sig_s;
    reg [8:0]  a_sig_s_1, b_sig_s_1;
    wire [17:0] p_sig_i;

    wire [8:0] sroa_reg,srob_reg;

    reg [17:0] p_sig_ps;
    reg [17:0] p_sig;
    reg [17:0] a_sig_m, b_sig_m;

    wire signeda_sig;
    wire signedb_sig;
    wire sourcea_sig;
    wire sourceb_sig;

    wire input_a_rst_ogsr;
    wire input_b_rst_ogsr;
    wire pipeline_rst_ogsr;
    wire output_rst_ogsr;
    wire reg_ctrl_0_rst_ogsr;
    wire reg_ctrl_1_rst_ogsr;

    reg  signeda_p1;
    reg  signeda_reg1;
    reg  signedb_p1;
    reg  signedb_reg1;

    reg input_a_clk_sig,input_a_ce_sig,input_a_rst_sig;
    reg input_b_clk_sig,input_b_ce_sig,input_b_rst_sig;
    reg pipeline_clk_sig,pipeline_ce_sig,pipeline_rst_sig;
    reg output_clk_sig,output_ce_sig,output_rst_sig;
    reg reg_ctrl_clk_sig_a,reg_ctrl_ce_sig_a,reg_ctrl_rst_sig_a;
    reg reg_ctrl_clk_sig_b,reg_ctrl_ce_sig_b,reg_ctrl_rst_sig_b;

    reg [17:0] p_sig_o,p_sig_o1;

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
    or INST5 (reg_ctrl_a_rst_ogsr, reg_ctrl_rst_sig_a, SR1);
    or INST6 (reg_ctrl_b_rst_ogsr, reg_ctrl_rst_sig_b, SR1);

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
    buf inst_B0 (b_sig[0], B0);
    buf inst_B1 (b_sig[1], B1);
    buf inst_B2 (b_sig[2], B2);
    buf inst_B3 (b_sig[3], B3);
    buf inst_B4 (b_sig[4], B4);
    buf inst_B5 (b_sig[5], B5);
    buf inst_B6 (b_sig[6], B6);
    buf inst_B7 (b_sig[7], B7);
    buf inst_B8 (b_sig[8], B8);

    buf inst_SIGNEDA (signeda_sig, SIGNEDA);
    buf inst_SIGNEDB (signedb_sig, SIGNEDB);
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

    buf inst_s_B0 (b_sig_s[0], SRIB0);
    buf inst_s_B1 (b_sig_s[1], SRIB1);
    buf inst_s_B2 (b_sig_s[2], SRIB2);
    buf inst_s_B3 (b_sig_s[3], SRIB3);
    buf inst_s_B4 (b_sig_s[4], SRIB4);
    buf inst_s_B5 (b_sig_s[5], SRIB5);
    buf inst_s_B6 (b_sig_s[6], SRIB6);
    buf inst_s_B7 (b_sig_s[7], SRIB7);
    buf inst_s_B8 (b_sig_s[8], SRIB8);

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

    buf inst_SROA0 (SROA0, sroa_reg[0]);
    buf inst_SROA1 (SROA1, sroa_reg[1]);
    buf inst_SROA2 (SROA2, sroa_reg[2]);
    buf inst_SROA3 (SROA3, sroa_reg[3]);
    buf inst_SROA4 (SROA4, sroa_reg[4]);
    buf inst_SROA5 (SROA5, sroa_reg[5]);
    buf inst_SROA6 (SROA6, sroa_reg[6]);
    buf inst_SROA7 (SROA7, sroa_reg[7]);
    buf inst_SROA8 (SROA8, sroa_reg[8]);

    buf inst_SROB0 (SROB0, srob_reg[0]);
    buf inst_SROB1 (SROB1, srob_reg[1]);
    buf inst_SROB2 (SROB2, srob_reg[2]);
    buf inst_SROB3 (SROB3, srob_reg[3]);
    buf inst_SROB4 (SROB4, srob_reg[4]);
    buf inst_SROB5 (SROB5, srob_reg[5]);
    buf inst_SROB6 (SROB6, srob_reg[6]);
    buf inst_SROB7 (SROB7, srob_reg[7]);
    buf inst_SROB8 (SROB8, srob_reg[8]);

    always @(a_sig_gen or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a_sig_m[8:0] = a_sig_gen[8:0];
          a_sig_m[17:9] = { a_sig_gen[8],
                            a_sig_gen[8],
                            a_sig_gen[8],
                            a_sig_gen[8],
                            a_sig_gen[8],
                            a_sig_gen[8],
                            a_sig_gen[8],
                            a_sig_gen[8],
                            a_sig_gen[8]};
        end
      else 
        begin
          a_sig_m[8:0] =  a_sig_gen[8:0];
          a_sig_m[17:9] = 0;
        end
    end

    always @(b_sig_gen or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b_sig_m[8:0] = b_sig_gen[8:0];
          b_sig_m[17:9] = {b_sig_gen[8],
                           b_sig_gen[8],
                           b_sig_gen[8],
                           b_sig_gen[8],
                           b_sig_gen[8],
                           b_sig_gen[8],
                           b_sig_gen[8],
                           b_sig_gen[8],
                           b_sig_gen[8]};
        end
      else 
        begin
          b_sig_m[8:0] = b_sig_gen[8:0];
          b_sig_m[17:9] = 0;
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
      if (REG_SIGNEDA_CLK == "CLK0")
          reg_ctrl_clk_sig_a = CLK0b;
      else if (REG_SIGNEDA_CLK == "CLK1")
          reg_ctrl_clk_sig_a = CLK1b;
      else if (REG_SIGNEDA_CLK == "CLK2")
          reg_ctrl_clk_sig_a = CLK2b;
      else if (REG_SIGNEDA_CLK == "CLK3")
          reg_ctrl_clk_sig_a = CLK3b;
    end

    always @(CLK0b or CLK1b or CLK2b or CLK3b)
    begin
      if (REG_SIGNEDB_CLK == "CLK0")
          reg_ctrl_clk_sig_b = CLK0b;
      else if (REG_SIGNEDB_CLK == "CLK1")
          reg_ctrl_clk_sig_b = CLK1b;
      else if (REG_SIGNEDB_CLK == "CLK2")
          reg_ctrl_clk_sig_b = CLK2b;
      else if (REG_SIGNEDB_CLK == "CLK3")
          reg_ctrl_clk_sig_b = CLK3b;
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
      if (REG_SIGNEDA_CE == "CE0")
          reg_ctrl_ce_sig_a = CE0b;
      else if (REG_SIGNEDA_CE == "CE1")
          reg_ctrl_ce_sig_a = CE1b;
      else if (REG_SIGNEDA_CE == "CE2")
          reg_ctrl_ce_sig_a = CE2b;
      else if (REG_SIGNEDA_CE == "CE3")
          reg_ctrl_ce_sig_a = CE3b;
    end

    always @(CE0b or CE1b or CE2b or CE3b)
    begin
      if (REG_SIGNEDB_CE == "CE0")
          reg_ctrl_ce_sig_b = CE0b;
      else if (REG_SIGNEDB_CE == "CE1")
          reg_ctrl_ce_sig_b = CE1b;
      else if (REG_SIGNEDB_CE == "CE2")
          reg_ctrl_ce_sig_b = CE2b;
      else if (REG_SIGNEDB_CE == "CE3")
          reg_ctrl_ce_sig_b = CE3b;
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
      if (REG_SIGNEDA_RST == "RST0")
          reg_ctrl_rst_sig_a = RST0b;
      else if (REG_SIGNEDA_RST == "RST1")
          reg_ctrl_rst_sig_a = RST1b;
      else if (REG_SIGNEDA_RST == "RST2")
          reg_ctrl_rst_sig_a = RST2b;
      else if (REG_SIGNEDA_RST == "RST3")
          reg_ctrl_rst_sig_a = RST3b;
    end

    always @(RST0b or RST1b or RST2b or RST3b)
    begin
      if (REG_SIGNEDB_RST == "RST0")
          reg_ctrl_rst_sig_b = RST0b;
      else if (REG_SIGNEDB_RST == "RST1")
          reg_ctrl_rst_sig_b = RST1b;
      else if (REG_SIGNEDB_RST == "RST2")
          reg_ctrl_rst_sig_b = RST2b;
      else if (REG_SIGNEDB_RST == "RST3")
          reg_ctrl_rst_sig_b = RST3b;
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

    always @(a_sig_reg or a_sig_s_1)
    begin
      if (REG_INPUTA_CLK == "NONE")
          a_sig_gen = a_sig_s_1;
      else
          a_sig_gen = a_sig_reg;
    end

    assign  sroa_reg = a_sig_gen;

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

    always @(b_sig_reg or b_sig_s_1)
    begin
      if (REG_INPUTB_CLK == "NONE")
          b_sig_gen = b_sig_s_1;
      else
          b_sig_gen = b_sig_reg;
    end

    assign  srob_reg = b_sig_gen;

    always @(posedge reg_ctrl_clk_sig_a or posedge reg_ctrl_a_rst_ogsr)
    begin
      if (reg_ctrl_a_rst_ogsr == 1'b1)
        begin
          signeda_reg1 <= 0;
        end
      else if (reg_ctrl_ce_sig_a == 1'b1)
        begin
          signeda_reg1 <= signeda_sig;
        end
    end

    always @(posedge reg_ctrl_clk_sig_b or posedge reg_ctrl_b_rst_ogsr)
    begin
      if (reg_ctrl_b_rst_ogsr == 1'b1)
        begin
          signedb_reg1 <= 0;
        end
      else if (reg_ctrl_ce_sig_b == 1'b1)
        begin
          signedb_reg1 <= signedb_sig;
        end
    end

    always @(signeda_sig or signeda_reg1)
    begin
      if (REG_SIGNEDA_CLK == "NONE")
          signeda_p1 = signeda_sig;
      else 
          signeda_p1 = signeda_reg1;
    end

    always @(signedb_sig or signedb_reg1)
    begin
      if (REG_SIGNEDB_CLK == "NONE")
          signedb_p1 = signedb_sig;
      else
          signedb_p1 = signedb_reg1;
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
