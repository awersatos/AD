// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2008 by Lattice Semiconductor Corporation
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
// Simulation Library File for DSP based Multiplier PMI
//
// Parameter Definition
//Name                               Value                             Default
/*
------------------------------------------------------------------------------
  pmi_dataa_width                   2 to 72                               8
  pmi_datab_width                   2 to 72                               8
  pmi_additional_pipeline           0 | 1                                 0
  pmi_input_reg                    "on"|"off"                           "on"
  pmi_output_reg                   "on"|"off"                           "on"
  pmi_family                 "ECP"|"ECP2"|"ECP2M"|"XP2"|"ECP3"          "ECP2"
  pmi_gsr                          "enable"|"disable"                 "enable"
  pmi_source_control_a0            "parallel"|"shift"               "parallel"
  pmi_source_control_a1            "parallel"|"shift"               "parallel"
  pmi_source_control_a2            "parallel"|"shift"               "parallel"
  pmi_source_control_a3            "parallel"|"shift"               "parallel"
  pmi_source_control_b0            "parallel"|"shift"               "parallel"
  pmi_source_control_b1            "parallel"|"shift"               "parallel"
  pmi_source_control_b2            "parallel"|"shift"               "parallel"
  pmi_source_control_b3            "parallel"|"shift"               "parallel"
  pmi_reg_inputa0_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputa0_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputa0_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputa1_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputa1_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputa1_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputa2_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputa2_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputa2_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputa3_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputa3_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputa3_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputb0_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputb0_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputb0_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputb1_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputb1_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputb1_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputb2_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputb2_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputb2_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputb3_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputb3_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputb3_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_pipeline0_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_pipeline0_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_pipeline0_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_pipeline1_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_pipeline1_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_pipeline1_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_pipeline2_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_pipeline2_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_pipeline2_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_pipeline3_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_pipeline3_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_pipeline3_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_output_clk                "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_output_ce                 "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_output_rst                "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signeda_0_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signeda_0_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_signeda_0_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signeda_1_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signeda_1_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_signeda_1_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signedb_0_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signedb_0_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_signedb_0_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signedb_1_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signedb_1_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_signedb_1_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_addnsub1_0_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_addnsub1_0_ce             "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_addnsub1_0_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_addnsub1_1_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_addnsub1_1_ce             "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_addnsub1_1_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_addnsub3_0_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_addnsub3_0_ce             "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_addnsub3_0_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_addnsub3_1_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_addnsub3_1_ce             "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_addnsub3_1_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_pipelined_mode               "on"|"off"                           "off"
------------------------------------------------------------------------------
*/
// $Header:
//

`timescale  1 ns / 1 ps

module pmi_dsp_multaddsubsum
 #(parameter pmi_dataa_width = 8,
   parameter pmi_datab_width = 8,
   parameter pmi_additional_pipeline = 0,
   parameter pmi_input_reg = "on",
   parameter pmi_output_reg = "on",
   parameter pmi_family = "ECP2",
   parameter pmi_gsr = "enable",
   parameter pmi_source_control_a0 = "parallel",
   parameter pmi_source_control_a1 = "parallel",
   parameter pmi_source_control_a2 = "parallel",
   parameter pmi_source_control_a3 = "parallel",
   parameter pmi_source_control_b0 = "parallel",
   parameter pmi_source_control_b1 = "parallel",
   parameter pmi_source_control_b2 = "parallel",
   parameter pmi_source_control_b3 = "parallel",
   parameter pmi_reg_inputa0_clk = "CLK0",
   parameter pmi_reg_inputa0_ce = "CE0",
   parameter pmi_reg_inputa0_rst = "RST0",
   parameter pmi_reg_inputa1_clk = "CLK0",
   parameter pmi_reg_inputa1_ce = "CE0",
   parameter pmi_reg_inputa1_rst = "RST0",
   parameter pmi_reg_inputa2_clk = "CLK0",
   parameter pmi_reg_inputa2_ce = "CE0",
   parameter pmi_reg_inputa2_rst = "RST0",
   parameter pmi_reg_inputa3_clk = "CLK0",
   parameter pmi_reg_inputa3_ce = "CE0",
   parameter pmi_reg_inputa3_rst = "RST0",
   parameter pmi_reg_inputb0_clk = "CLK0",
   parameter pmi_reg_inputb0_ce = "CE0",
   parameter pmi_reg_inputb0_rst = "RST0",
   parameter pmi_reg_inputb1_clk = "CLK0",
   parameter pmi_reg_inputb1_ce = "CE0",
   parameter pmi_reg_inputb1_rst = "RST0",
   parameter pmi_reg_inputb2_clk = "CLK0",
   parameter pmi_reg_inputb2_ce = "CE0",
   parameter pmi_reg_inputb2_rst = "RST0",
   parameter pmi_reg_inputb3_clk = "CLK0",
   parameter pmi_reg_inputb3_ce = "CE0",
   parameter pmi_reg_inputb3_rst = "RST0",
   parameter pmi_reg_pipeline0_clk = "CLK0",
   parameter pmi_reg_pipeline0_ce = "CE0",
   parameter pmi_reg_pipeline0_rst = "RST0",
   parameter pmi_reg_pipeline1_clk = "CLK0",
   parameter pmi_reg_pipeline1_ce = "CE0",
   parameter pmi_reg_pipeline1_rst = "RST0",
   parameter pmi_reg_pipeline2_clk = "CLK0",
   parameter pmi_reg_pipeline2_ce = "CE0",
   parameter pmi_reg_pipeline2_rst = "RST0",
   parameter pmi_reg_pipeline3_clk = "CLK0",
   parameter pmi_reg_pipeline3_ce = "CE0",
   parameter pmi_reg_pipeline3_rst = "RST0",
   parameter pmi_reg_output_clk = "CLK0",
   parameter pmi_reg_output_ce = "CE0",
   parameter pmi_reg_output_rst = "RST0",
   parameter pmi_reg_signeda_0_clk = "CLK0",
   parameter pmi_reg_signeda_0_ce = "CE0",
   parameter pmi_reg_signeda_0_rst = "RST0",
   parameter pmi_reg_signeda_1_clk = "CLK0",
   parameter pmi_reg_signeda_1_ce = "CE0",
   parameter pmi_reg_signeda_1_rst = "RST0",
   parameter pmi_reg_signedb_0_clk = "CLK0",
   parameter pmi_reg_signedb_0_ce = "CE0",
   parameter pmi_reg_signedb_0_rst = "RST0",
   parameter pmi_reg_signedb_1_clk = "CLK0",
   parameter pmi_reg_signedb_1_ce = "CE0",
   parameter pmi_reg_signedb_1_rst = "RST0",
   parameter pmi_reg_addnsub1_0_clk = "CLK0",
   parameter pmi_reg_addnsub1_0_ce = "CE0",
   parameter pmi_reg_addnsub1_0_rst = "RST0",
   parameter pmi_reg_addnsub1_1_clk = "CLK0",
   parameter pmi_reg_addnsub1_1_ce = "CE0",
   parameter pmi_reg_addnsub1_1_rst = "RST0",
   parameter pmi_reg_addnsub3_0_clk = "CLK0",
   parameter pmi_reg_addnsub3_0_ce = "CE0",
   parameter pmi_reg_addnsub3_0_rst = "RST0",
   parameter pmi_reg_addnsub3_1_clk = "CLK0",
   parameter pmi_reg_addnsub3_1_ce = "CE0",
   parameter pmi_reg_addnsub3_1_rst = "RST0",
   parameter pmi_pipelined_mode = "off",
   parameter module_type = "pmi_dsp_multaddsubsum")

  (input [(pmi_dataa_width-1):0]       A0, 
   input [(pmi_dataa_width-1):0]       A1, 
   input [(pmi_dataa_width-1):0]       A2, 
   input [(pmi_dataa_width-1):0]       A3,
   input [(pmi_datab_width-1):0]       B0, 
   input [(pmi_datab_width-1):0]       B1, 
   input [(pmi_datab_width-1):0]       B2, 
   input [(pmi_datab_width-1):0]       B3,
   input [17:0]       SRIA,
   input [17:0]       SRIB,
   input CLK0,
   input CLK1,
   input CLK2,
   input CLK3,
   input CE0,
   input CE1,
   input CE2,
   input CE3,
   input RST0,
   input RST1,
   input RST2,
   input RST3,
   input SignA,
   input SignB,
   input ShiftA0,
   input ShiftA1,
   input ShiftA2,
   input ShiftA3,
   input ShiftB0,
   input ShiftB1,
   input ShiftB2,
   input ShiftB3,
   input ADDNSUB1,
   input ADDNSUB3,
   output [(pmi_dataa_width + pmi_datab_width + 1):0]  SUM,
   output [17:0]  SROA,
   output [17:0]  SROB)/*synthesis syn_black_box*/;

//pragma translate_off
reg [(pmi_dataa_width + pmi_datab_width + 1):0] sum_o, sum_o2, sum_o3;
reg input_a0_clk_sig, input_b0_clk_sig;
reg input_a1_clk_sig, input_b1_clk_sig;
reg input_a2_clk_sig, input_b2_clk_sig;
reg input_a3_clk_sig, input_b3_clk_sig;
reg pipeline0_clk_sig, pipeline1_clk_sig, output_clk_sig;
reg pipeline2_clk_sig, pipeline3_clk_sig;
reg reg_ctrl_clk_sig_a_0, reg_ctrl_clk_sig_b_0;
reg reg_ctrl_clk_sig_a_1, reg_ctrl_clk_sig_b_1;
reg input_a0_ce_sig, input_b0_ce_sig;
reg input_a1_ce_sig, input_b1_ce_sig;
reg input_a2_ce_sig, input_b2_ce_sig;
reg input_a3_ce_sig, input_b3_ce_sig;
reg pipeline0_ce_sig, pipeline1_ce_sig, output_ce_sig;
reg pipeline2_ce_sig, pipeline3_ce_sig;
reg reg_ctrl_ce_sig_a_0, reg_ctrl_ce_sig_b_0;
reg reg_ctrl_ce_sig_a_1, reg_ctrl_ce_sig_b_1;
reg input_a0_rst_sig, input_b0_rst_sig;
reg input_a1_rst_sig, input_b1_rst_sig;
reg input_a2_rst_sig, input_b2_rst_sig;
reg input_a3_rst_sig, input_b3_rst_sig;
reg pipeline0_rst_sig, pipeline1_rst_sig, output_rst_sig;
reg pipeline2_rst_sig, pipeline3_rst_sig;
reg reg_ctrl_rst_sig_a_0, reg_ctrl_rst_sig_b_0;
reg reg_ctrl_rst_sig_a_1, reg_ctrl_rst_sig_b_1;
reg reg_addnsub1_0_clk_sig, reg_addnsub1_1_clk_sig;
reg reg_addnsub1_0_ce_sig, reg_addnsub1_1_ce_sig;
reg reg_addnsub1_0_rst_sig, reg_addnsub1_1_rst_sig;
reg reg_addnsub3_0_clk_sig, reg_addnsub3_1_clk_sig;
reg reg_addnsub3_0_ce_sig, reg_addnsub3_1_ce_sig;
reg reg_addnsub3_0_rst_sig, reg_addnsub3_1_rst_sig;
reg signeda_reg2, signedb_reg2;
reg addnsub1_reg1, addnsub1_p1, addnsub1_reg2, addnsub1_p2;
reg addnsub3_reg1, addnsub3_p1, addnsub3_reg2, addnsub3_p2;
reg [(pmi_dataa_width-1):0] a0_sig;
reg [(pmi_dataa_width-1):0] a1_sig;
reg [(pmi_dataa_width-1):0] a2_sig;
reg [(pmi_dataa_width-1):0] a3_sig;
reg [(pmi_dataa_width-1):0] a0_sig_reg;
reg [(pmi_dataa_width-1):0] a1_sig_reg;
reg [(pmi_dataa_width-1):0] a2_sig_reg;
reg [(pmi_dataa_width-1):0] a3_sig_reg;
reg [(pmi_dataa_width-1):0] a0_sig_p;
reg [(pmi_dataa_width-1):0] a1_sig_p;
reg [(pmi_dataa_width-1):0] a2_sig_p;
reg [(pmi_dataa_width-1):0] a3_sig_p;
reg [(pmi_datab_width-1):0] b0_sig;
reg [(pmi_datab_width-1):0] b1_sig;
reg [(pmi_datab_width-1):0] b2_sig;
reg [(pmi_datab_width-1):0] b3_sig;
reg [(pmi_datab_width-1):0] b0_sig_reg;
reg [(pmi_datab_width-1):0] b1_sig_reg;
reg [(pmi_datab_width-1):0] b2_sig_reg;
reg [(pmi_datab_width-1):0] b3_sig_reg;
reg [(pmi_datab_width-1):0] b0_sig_p;
reg [(pmi_datab_width-1):0] b1_sig_p;
reg [(pmi_datab_width-1):0] b2_sig_p;
reg [(pmi_datab_width-1):0] b3_sig_p;
reg signeda_reg1, signeda_p1, signeda_p2;
reg signedb_reg1, signedb_p1, signedb_p2;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] a0_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] a1_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] b0_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] b1_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] a2_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] a3_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] b2_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] b3_sig_m;
wire [(pmi_dataa_width + pmi_datab_width - 1):0] p0_sig_i;
wire [(pmi_dataa_width + pmi_datab_width - 1):0] p1_sig_i;
wire [(pmi_dataa_width + pmi_datab_width - 1):0] p2_sig_i;
wire [(pmi_dataa_width + pmi_datab_width - 1):0] p3_sig_i;
reg [(pmi_dataa_width + pmi_datab_width + 1):0] p0_sig_i_e;
reg [(pmi_dataa_width + pmi_datab_width + 1):0] p1_sig_i_e;
reg [(pmi_dataa_width + pmi_datab_width + 1):0] p2_sig_i_e;
reg [(pmi_dataa_width + pmi_datab_width + 1):0] p3_sig_i_e;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p0_sig_i_e_reg;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p0_sig_i_e_reg1;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p1_sig_i_e_reg;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p1_sig_i_e_reg1;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p2_sig_i_e_reg;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p2_sig_i_e_reg1;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p3_sig_i_e_reg;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p3_sig_i_e_reg1;
reg [(pmi_dataa_width + pmi_datab_width + 1):0] sumt_reg, sumt_reg2, sumt_reg3;
wire [(pmi_dataa_width + pmi_datab_width + 1):0] sum0_sig_i, sum1_sig_i;
wire [(pmi_dataa_width + pmi_datab_width + 1):0] sumt_sig;
wire SignB_new;

initial
   if (pmi_pipelined_mode == "on" && pmi_family != "ECP3")
   begin
      $display ("Error! Fully-pipelined mode is not supported for this device family!");
      $stop;
   end
   else if (pmi_pipelined_mode == "on" && (pmi_output_reg == "off" || pmi_additional_pipeline == 0))
   begin
      $display ("Error! Fully-pipelined mode must have both output and pipeline registers on!");
      $stop;
   end

    assign SignB_new = (pmi_family == "ECP") ? SignA : SignB;

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputa0_clk == "CLK0")
          input_a0_clk_sig = CLK0;
      else if (pmi_reg_inputa0_clk == "CLK1")
          input_a0_clk_sig = CLK1;
      else if (pmi_reg_inputa0_clk == "CLK2")
          input_a0_clk_sig = CLK2;
      else if (pmi_reg_inputa0_clk == "CLK3")
          input_a0_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputa1_clk == "CLK0")
          input_a1_clk_sig = CLK0;
      else if (pmi_reg_inputa1_clk == "CLK1")
          input_a1_clk_sig = CLK1;
      else if (pmi_reg_inputa1_clk == "CLK2")
          input_a1_clk_sig = CLK2;
      else if (pmi_reg_inputa1_clk == "CLK3")
          input_a1_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputa2_clk == "CLK0")
          input_a2_clk_sig = CLK0;
      else if (pmi_reg_inputa2_clk == "CLK1")
          input_a2_clk_sig = CLK1;
      else if (pmi_reg_inputa2_clk == "CLK2")
          input_a2_clk_sig = CLK2;
      else if (pmi_reg_inputa2_clk == "CLK3")
          input_a2_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputa3_clk == "CLK0")
          input_a3_clk_sig = CLK0;
      else if (pmi_reg_inputa3_clk == "CLK1")
          input_a3_clk_sig = CLK1;
      else if (pmi_reg_inputa3_clk == "CLK2")
          input_a3_clk_sig = CLK2;
      else if (pmi_reg_inputa3_clk == "CLK3")
          input_a3_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputb0_clk == "CLK0")
          input_b0_clk_sig = CLK0;
      else if (pmi_reg_inputb0_clk == "CLK1")
          input_b0_clk_sig = CLK1;
      else if (pmi_reg_inputb0_clk == "CLK2")
          input_b0_clk_sig = CLK2;
      else if (pmi_reg_inputb0_clk == "CLK3")
          input_b0_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputb1_clk == "CLK0")
          input_b1_clk_sig = CLK0;
      else if (pmi_reg_inputb1_clk == "CLK1")
          input_b1_clk_sig = CLK1;
      else if (pmi_reg_inputb1_clk == "CLK2")
          input_b1_clk_sig = CLK2;
      else if (pmi_reg_inputb1_clk == "CLK3")
          input_b1_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputb2_clk == "CLK0")
          input_b2_clk_sig = CLK0;
      else if (pmi_reg_inputb2_clk == "CLK1")
          input_b2_clk_sig = CLK1;
      else if (pmi_reg_inputb2_clk == "CLK2")
          input_b2_clk_sig = CLK2;
      else if (pmi_reg_inputb2_clk == "CLK3")
          input_b2_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputb3_clk == "CLK0")
          input_b3_clk_sig = CLK0;
      else if (pmi_reg_inputb3_clk == "CLK1")
          input_b3_clk_sig = CLK1;
      else if (pmi_reg_inputb3_clk == "CLK2")
          input_b3_clk_sig = CLK2;
      else if (pmi_reg_inputb3_clk == "CLK3")
          input_b3_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_pipeline0_clk == "CLK0")
          pipeline0_clk_sig = CLK0;
      else if (pmi_reg_pipeline0_clk == "CLK1")
          pipeline0_clk_sig = CLK1;
      else if (pmi_reg_pipeline0_clk == "CLK2")
          pipeline0_clk_sig = CLK2;
      else if (pmi_reg_pipeline0_clk == "CLK3")
          pipeline0_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_pipeline1_clk == "CLK0")
          pipeline1_clk_sig = CLK0;
      else if (pmi_reg_pipeline1_clk == "CLK1")
          pipeline1_clk_sig = CLK1;
      else if (pmi_reg_pipeline1_clk == "CLK2")
          pipeline1_clk_sig = CLK2;
      else if (pmi_reg_pipeline1_clk == "CLK3")
          pipeline1_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_pipeline2_clk == "CLK0")
          pipeline2_clk_sig = CLK0;
      else if (pmi_reg_pipeline2_clk == "CLK1")
          pipeline2_clk_sig = CLK1;
      else if (pmi_reg_pipeline2_clk == "CLK2")
          pipeline2_clk_sig = CLK2;
      else if (pmi_reg_pipeline2_clk == "CLK3")
          pipeline2_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_pipeline3_clk == "CLK0")
          pipeline3_clk_sig = CLK0;
      else if (pmi_reg_pipeline3_clk == "CLK1")
          pipeline3_clk_sig = CLK1;
      else if (pmi_reg_pipeline3_clk == "CLK2")
          pipeline3_clk_sig = CLK2;
      else if (pmi_reg_pipeline3_clk == "CLK3")
          pipeline3_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_output_clk == "CLK0")
          output_clk_sig = CLK0;
      else if (pmi_reg_output_clk == "CLK1")
          output_clk_sig = CLK1;
      else if (pmi_reg_output_clk == "CLK2")
          output_clk_sig = CLK2;
      else if (pmi_reg_output_clk == "CLK3")
          output_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_signeda_0_clk == "CLK0")
          reg_ctrl_clk_sig_a_0 = CLK0;
      else if (pmi_reg_signeda_0_clk == "CLK1")
          reg_ctrl_clk_sig_a_0 = CLK1;
      else if (pmi_reg_signeda_0_clk == "CLK2")
          reg_ctrl_clk_sig_a_0 = CLK2;
      else if (pmi_reg_signeda_0_clk == "CLK3")
          reg_ctrl_clk_sig_a_0 = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_signeda_1_clk == "CLK0")
          reg_ctrl_clk_sig_a_1 = CLK0;
      else if (pmi_reg_signeda_1_clk == "CLK1")
          reg_ctrl_clk_sig_a_1 = CLK1;
      else if (pmi_reg_signeda_1_clk == "CLK2")
          reg_ctrl_clk_sig_a_1 = CLK2;
      else if (pmi_reg_signeda_1_clk == "CLK3")
          reg_ctrl_clk_sig_a_1 = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_signedb_0_clk == "CLK0")
          reg_ctrl_clk_sig_b_0 = CLK0;
      else if (pmi_reg_signedb_0_clk == "CLK1")
          reg_ctrl_clk_sig_b_0 = CLK1;
      else if (pmi_reg_signedb_0_clk == "CLK2")
          reg_ctrl_clk_sig_b_0 = CLK2;
      else if (pmi_reg_signedb_0_clk == "CLK3")
          reg_ctrl_clk_sig_b_0 = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_signedb_1_clk == "CLK0")
          reg_ctrl_clk_sig_b_1 = CLK0;
      else if (pmi_reg_signedb_1_clk == "CLK1")
          reg_ctrl_clk_sig_b_1 = CLK1;
      else if (pmi_reg_signedb_1_clk == "CLK2")
          reg_ctrl_clk_sig_b_1 = CLK2;
      else if (pmi_reg_signedb_1_clk == "CLK3")
          reg_ctrl_clk_sig_b_1 = CLK3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputa0_ce == "CE0")
          input_a0_ce_sig = CE0;
      else if (pmi_reg_inputa0_ce == "CE1")
          input_a0_ce_sig = CE1;
      else if (pmi_reg_inputa0_ce == "CE2")
          input_a0_ce_sig = CE2;
      else if (pmi_reg_inputa0_ce == "CE3")
          input_a0_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputa1_ce == "CE0")
          input_a1_ce_sig = CE0;
      else if (pmi_reg_inputa1_ce == "CE1")
          input_a1_ce_sig = CE1;
      else if (pmi_reg_inputa1_ce == "CE2")
          input_a1_ce_sig = CE2;
      else if (pmi_reg_inputa1_ce == "CE3")
          input_a1_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputa2_ce == "CE0")
          input_a2_ce_sig = CE0;
      else if (pmi_reg_inputa2_ce == "CE1")
          input_a2_ce_sig = CE1;
      else if (pmi_reg_inputa2_ce == "CE2")
          input_a2_ce_sig = CE2;
      else if (pmi_reg_inputa2_ce == "CE3")
          input_a2_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputa3_ce == "CE0")
          input_a3_ce_sig = CE0;
      else if (pmi_reg_inputa3_ce == "CE1")
          input_a3_ce_sig = CE1;
      else if (pmi_reg_inputa3_ce == "CE2")
          input_a3_ce_sig = CE2;
      else if (pmi_reg_inputa3_ce == "CE3")
          input_a3_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputb0_ce == "CE0")
          input_b0_ce_sig = CE0;
      else if (pmi_reg_inputb0_ce == "CE1")
          input_b0_ce_sig = CE1;
      else if (pmi_reg_inputb0_ce == "CE2")
          input_b0_ce_sig = CE2;
      else if (pmi_reg_inputb0_ce == "CE3")
          input_b0_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputb1_ce == "CE0")
          input_b1_ce_sig = CE0;
      else if (pmi_reg_inputb1_ce == "CE1")
          input_b1_ce_sig = CE1;
      else if (pmi_reg_inputb1_ce == "CE2")
          input_b1_ce_sig = CE2;
      else if (pmi_reg_inputb1_ce == "CE3")
          input_b1_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputb2_ce == "CE0")
          input_b2_ce_sig = CE0;
      else if (pmi_reg_inputb2_ce == "CE1")
          input_b2_ce_sig = CE1;
      else if (pmi_reg_inputb2_ce == "CE2")
          input_b2_ce_sig = CE2;
      else if (pmi_reg_inputb2_ce == "CE3")
          input_b2_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputb3_ce == "CE0")
          input_b3_ce_sig = CE0;
      else if (pmi_reg_inputb3_ce == "CE1")
          input_b3_ce_sig = CE1;
      else if (pmi_reg_inputb3_ce == "CE2")
          input_b3_ce_sig = CE2;
      else if (pmi_reg_inputb3_ce == "CE3")
          input_b3_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_pipeline0_ce == "CE0")
          pipeline0_ce_sig = CE0;
      else if (pmi_reg_pipeline0_ce == "CE1")
          pipeline0_ce_sig = CE1;
      else if (pmi_reg_pipeline0_ce == "CE2")
          pipeline0_ce_sig = CE2;
      else if (pmi_reg_pipeline0_ce == "CE3")
          pipeline0_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_pipeline1_ce == "CE0")
          pipeline1_ce_sig = CE0;
      else if (pmi_reg_pipeline1_ce == "CE1")
          pipeline1_ce_sig = CE1;
      else if (pmi_reg_pipeline1_ce == "CE2")
          pipeline1_ce_sig = CE2;
      else if (pmi_reg_pipeline1_ce == "CE3")
          pipeline1_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_pipeline2_ce == "CE0")
          pipeline2_ce_sig = CE0;
      else if (pmi_reg_pipeline2_ce == "CE1")
          pipeline2_ce_sig = CE1;
      else if (pmi_reg_pipeline2_ce == "CE2")
          pipeline2_ce_sig = CE2;
      else if (pmi_reg_pipeline2_ce == "CE3")
          pipeline2_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_pipeline3_ce == "CE0")
          pipeline3_ce_sig = CE0;
      else if (pmi_reg_pipeline3_ce == "CE1")
          pipeline3_ce_sig = CE1;
      else if (pmi_reg_pipeline3_ce == "CE2")
          pipeline3_ce_sig = CE2;
      else if (pmi_reg_pipeline3_ce == "CE3")
          pipeline3_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_output_ce == "CE0")
          output_ce_sig = CE0;
      else if (pmi_reg_output_ce == "CE1")
          output_ce_sig = CE1;
      else if (pmi_reg_output_ce == "CE2")
          output_ce_sig = CE2;
      else if (pmi_reg_output_ce == "CE3")
          output_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_signeda_0_ce == "CE0")
          reg_ctrl_ce_sig_a_0 = CE0;
      else if (pmi_reg_signeda_0_ce == "CE1")
          reg_ctrl_ce_sig_a_0 = CE1;
      else if (pmi_reg_signeda_0_ce == "CE2")
          reg_ctrl_ce_sig_a_0 = CE2;
      else if (pmi_reg_signeda_0_ce == "CE3")
          reg_ctrl_ce_sig_a_0 = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_signeda_1_ce == "CE0")
          reg_ctrl_ce_sig_a_1 = CE0;
      else if (pmi_reg_signeda_1_ce == "CE1")
          reg_ctrl_ce_sig_a_1 = CE1;
      else if (pmi_reg_signeda_1_ce == "CE2")
          reg_ctrl_ce_sig_a_1 = CE2;
      else if (pmi_reg_signeda_1_ce == "CE3")
          reg_ctrl_ce_sig_a_1 = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_signedb_0_ce == "CE0")
          reg_ctrl_ce_sig_b_0 = CE0;
      else if (pmi_reg_signedb_0_ce == "CE1")
          reg_ctrl_ce_sig_b_0 = CE1;
      else if (pmi_reg_signedb_0_ce == "CE2")
          reg_ctrl_ce_sig_b_0 = CE2;
      else if (pmi_reg_signedb_0_ce == "CE3")
          reg_ctrl_ce_sig_b_0 = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_signedb_1_ce == "CE0")
          reg_ctrl_ce_sig_b_1 = CE0;
      else if (pmi_reg_signedb_1_ce == "CE1")
          reg_ctrl_ce_sig_b_1 = CE1;
      else if (pmi_reg_signedb_1_ce == "CE2")
          reg_ctrl_ce_sig_b_1 = CE2;
      else if (pmi_reg_signedb_1_ce == "CE3")
          reg_ctrl_ce_sig_b_1 = CE3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputa0_rst == "RST0")
          input_a0_rst_sig = RST0;
      else if (pmi_reg_inputa0_rst == "RST1")
          input_a0_rst_sig = RST1;
      else if (pmi_reg_inputa0_rst == "RST2")
          input_a0_rst_sig = RST2;
      else if (pmi_reg_inputa0_rst == "RST3")
          input_a0_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputa1_rst == "RST0")
          input_a1_rst_sig = RST0;
      else if (pmi_reg_inputa1_rst == "RST1")
          input_a1_rst_sig = RST1;
      else if (pmi_reg_inputa1_rst == "RST2")
          input_a1_rst_sig = RST2;
      else if (pmi_reg_inputa1_rst == "RST3")
          input_a1_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputa2_rst == "RST0")
          input_a2_rst_sig = RST0;
      else if (pmi_reg_inputa2_rst == "RST1")
          input_a2_rst_sig = RST1;
      else if (pmi_reg_inputa2_rst == "RST2")
          input_a2_rst_sig = RST2;
      else if (pmi_reg_inputa2_rst == "RST3")
          input_a2_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputa3_rst == "RST0")
          input_a3_rst_sig = RST0;
      else if (pmi_reg_inputa3_rst == "RST1")
          input_a3_rst_sig = RST1;
      else if (pmi_reg_inputa3_rst == "RST2")
          input_a3_rst_sig = RST2;
      else if (pmi_reg_inputa3_rst == "RST3")
          input_a3_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputb0_rst == "RST0")
          input_b0_rst_sig = RST0;
      else if (pmi_reg_inputb0_rst == "RST1")
          input_b0_rst_sig = RST1;
      else if (pmi_reg_inputb0_rst == "RST2")
          input_b0_rst_sig = RST2;
      else if (pmi_reg_inputb0_rst == "RST3")
          input_b0_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputb1_rst == "RST0")
          input_b1_rst_sig = RST0;
      else if (pmi_reg_inputb1_rst == "RST1")
          input_b1_rst_sig = RST1;
      else if (pmi_reg_inputb1_rst == "RST2")
          input_b1_rst_sig = RST2;
      else if (pmi_reg_inputb1_rst == "RST3")
          input_b1_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputb2_rst == "RST0")
          input_b2_rst_sig = RST0;
      else if (pmi_reg_inputb2_rst == "RST1")
          input_b2_rst_sig = RST1;
      else if (pmi_reg_inputb2_rst == "RST2")
          input_b2_rst_sig = RST2;
      else if (pmi_reg_inputb2_rst == "RST3")
          input_b2_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputb3_rst == "RST0")
          input_b3_rst_sig = RST0;
      else if (pmi_reg_inputb3_rst == "RST1")
          input_b3_rst_sig = RST1;
      else if (pmi_reg_inputb3_rst == "RST2")
          input_b3_rst_sig = RST2;
      else if (pmi_reg_inputb3_rst == "RST3")
          input_b3_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_pipeline0_rst == "RST0")
          pipeline0_rst_sig = RST0;
      else if (pmi_reg_pipeline0_rst == "RST1")
          pipeline0_rst_sig = RST1;
      else if (pmi_reg_pipeline0_rst == "RST2")
          pipeline0_rst_sig = RST2;
      else if (pmi_reg_pipeline0_rst == "RST3")
          pipeline0_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_pipeline1_rst == "RST0")
          pipeline1_rst_sig = RST0;
      else if (pmi_reg_pipeline1_rst == "RST1")
          pipeline1_rst_sig = RST1;
      else if (pmi_reg_pipeline1_rst == "RST2")
          pipeline1_rst_sig = RST2;
      else if (pmi_reg_pipeline1_rst == "RST3")
          pipeline1_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_pipeline2_rst == "RST0")
          pipeline2_rst_sig = RST0;
      else if (pmi_reg_pipeline2_rst == "RST1")
          pipeline2_rst_sig = RST1;
      else if (pmi_reg_pipeline2_rst == "RST2")
          pipeline2_rst_sig = RST2;
      else if (pmi_reg_pipeline2_rst == "RST3")
          pipeline2_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_pipeline3_rst == "RST0")
          pipeline3_rst_sig = RST0;
      else if (pmi_reg_pipeline3_rst == "RST1")
          pipeline3_rst_sig = RST1;
      else if (pmi_reg_pipeline3_rst == "RST2")
          pipeline3_rst_sig = RST2;
      else if (pmi_reg_pipeline3_rst == "RST3")
          pipeline3_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_output_rst == "RST0")
          output_rst_sig = RST0;
      else if (pmi_reg_output_rst == "RST1")
          output_rst_sig = RST1;
      else if (pmi_reg_output_rst == "RST2")
          output_rst_sig = RST2;
      else if (pmi_reg_output_rst == "RST3")
          output_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_signeda_0_rst == "RST0")
          reg_ctrl_rst_sig_a_0 = RST0;
      else if (pmi_reg_signeda_0_rst == "RST1")
          reg_ctrl_rst_sig_a_0 = RST1;
      else if (pmi_reg_signeda_0_rst == "RST2")
          reg_ctrl_rst_sig_a_0 = RST2;
      else if (pmi_reg_signeda_0_rst == "RST3")
          reg_ctrl_rst_sig_a_0 = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_signeda_1_rst == "RST0")
          reg_ctrl_rst_sig_a_1 = RST0;
      else if (pmi_reg_signeda_1_rst == "RST1")
          reg_ctrl_rst_sig_a_1 = RST1;
      else if (pmi_reg_signeda_1_rst == "RST2")
          reg_ctrl_rst_sig_a_1 = RST2;
      else if (pmi_reg_signeda_1_rst == "RST3")
          reg_ctrl_rst_sig_a_1 = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_signedb_0_rst == "RST0")
          reg_ctrl_rst_sig_b_0 = RST0;
      else if (pmi_reg_signedb_0_rst == "RST1")
          reg_ctrl_rst_sig_b_0 = RST1;
      else if (pmi_reg_signedb_0_rst == "RST2")
          reg_ctrl_rst_sig_b_0 = RST2;
      else if (pmi_reg_signedb_0_rst == "RST3")
          reg_ctrl_rst_sig_b_0 = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_signedb_1_rst == "RST0")
          reg_ctrl_rst_sig_b_1 = RST0;
      else if (pmi_reg_signedb_1_rst == "RST1")
          reg_ctrl_rst_sig_b_1 = RST1;
      else if (pmi_reg_signedb_1_rst == "RST2")
          reg_ctrl_rst_sig_b_1 = RST2;
      else if (pmi_reg_signedb_1_rst == "RST3")
          reg_ctrl_rst_sig_b_1 = RST3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_addnsub1_0_clk == "CLK0")
          reg_addnsub1_0_clk_sig = CLK0;
      else if (pmi_reg_addnsub1_0_clk == "CLK1")
          reg_addnsub1_0_clk_sig = CLK1;
      else if (pmi_reg_addnsub1_0_clk == "CLK2")
          reg_addnsub1_0_clk_sig = CLK2;
      else if (pmi_reg_addnsub1_0_clk == "CLK3")
          reg_addnsub1_0_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_addnsub1_1_clk == "CLK0")
          reg_addnsub1_1_clk_sig = CLK0;
      else if (pmi_reg_addnsub1_1_clk == "CLK1")
          reg_addnsub1_1_clk_sig = CLK1;
      else if (pmi_reg_addnsub1_1_clk == "CLK2")
          reg_addnsub1_1_clk_sig = CLK2;
      else if (pmi_reg_addnsub1_1_clk == "CLK3")
          reg_addnsub1_1_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_addnsub3_0_clk == "CLK0")
          reg_addnsub3_0_clk_sig = CLK0;
      else if (pmi_reg_addnsub3_0_clk == "CLK1")
          reg_addnsub3_0_clk_sig = CLK1;
      else if (pmi_reg_addnsub3_0_clk == "CLK2")
          reg_addnsub3_0_clk_sig = CLK2;
      else if (pmi_reg_addnsub3_0_clk == "CLK3")
          reg_addnsub3_0_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_addnsub3_1_clk == "CLK0")
          reg_addnsub3_1_clk_sig = CLK0;
      else if (pmi_reg_addnsub3_1_clk == "CLK1")
          reg_addnsub3_1_clk_sig = CLK1;
      else if (pmi_reg_addnsub3_1_clk == "CLK2")
          reg_addnsub3_1_clk_sig = CLK2;
      else if (pmi_reg_addnsub3_1_clk == "CLK3")
          reg_addnsub3_1_clk_sig = CLK3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_addnsub1_0_ce == "CE0")
          reg_addnsub1_0_ce_sig = CE0;
      else if (pmi_reg_addnsub1_0_ce == "CE1")
          reg_addnsub1_0_ce_sig = CE1;
      else if (pmi_reg_addnsub1_0_ce == "CE2")
          reg_addnsub1_0_ce_sig = CE2;
      else if (pmi_reg_addnsub1_0_ce == "CE3")
          reg_addnsub1_0_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_addnsub1_1_ce == "CE0")
          reg_addnsub1_1_ce_sig = CE0;
      else if (pmi_reg_addnsub1_1_ce == "CE1")
          reg_addnsub1_1_ce_sig = CE1;
      else if (pmi_reg_addnsub1_1_ce == "CE2")
          reg_addnsub1_1_ce_sig = CE2;
      else if (pmi_reg_addnsub1_1_ce == "CE3")
          reg_addnsub1_1_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_addnsub3_0_ce == "CE0")
          reg_addnsub3_0_ce_sig = CE0;
      else if (pmi_reg_addnsub3_0_ce == "CE1")
          reg_addnsub3_0_ce_sig = CE1;
      else if (pmi_reg_addnsub3_0_ce == "CE2")
          reg_addnsub3_0_ce_sig = CE2;
      else if (pmi_reg_addnsub3_0_ce == "CE3")
          reg_addnsub3_0_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_addnsub3_1_ce == "CE0")
          reg_addnsub3_1_ce_sig = CE0;
      else if (pmi_reg_addnsub3_1_ce == "CE1")
          reg_addnsub3_1_ce_sig = CE1;
      else if (pmi_reg_addnsub3_1_ce == "CE2")
          reg_addnsub3_1_ce_sig = CE2;
      else if (pmi_reg_addnsub3_1_ce == "CE3")
          reg_addnsub3_1_ce_sig = CE3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_addnsub1_0_rst == "RST0")
          reg_addnsub1_0_rst_sig = RST0;
      else if (pmi_reg_addnsub1_0_rst == "RST1")
          reg_addnsub1_0_rst_sig = RST1;
      else if (pmi_reg_addnsub1_0_rst == "RST2")
          reg_addnsub1_0_rst_sig = RST2;
      else if (pmi_reg_addnsub1_0_rst == "RST3")
          reg_addnsub1_0_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_addnsub1_1_rst == "RST0")
          reg_addnsub1_1_rst_sig = RST0;
      else if (pmi_reg_addnsub1_1_rst == "RST1")
          reg_addnsub1_1_rst_sig = RST1;
      else if (pmi_reg_addnsub1_1_rst == "RST2")
          reg_addnsub1_1_rst_sig = RST2;
      else if (pmi_reg_addnsub1_1_rst == "RST3")
          reg_addnsub1_1_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_addnsub3_0_rst == "RST0")
          reg_addnsub3_0_rst_sig = RST0;
      else if (pmi_reg_addnsub3_0_rst == "RST1")
          reg_addnsub3_0_rst_sig = RST1;
      else if (pmi_reg_addnsub3_0_rst == "RST2")
          reg_addnsub3_0_rst_sig = RST2;
      else if (pmi_reg_addnsub3_0_rst == "RST3")
          reg_addnsub3_0_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_addnsub3_1_rst == "RST0")
          reg_addnsub3_1_rst_sig = RST0;
      else if (pmi_reg_addnsub3_1_rst == "RST1")
          reg_addnsub3_1_rst_sig = RST1;
      else if (pmi_reg_addnsub3_1_rst == "RST2")
          reg_addnsub3_1_rst_sig = RST2;
      else if (pmi_reg_addnsub3_1_rst == "RST3")
          reg_addnsub3_1_rst_sig = RST3;
    end

    always @(A0 or SRIA or ShiftA0)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_a0 == "shift")
            a0_sig = SRIA;
         else
            a0_sig = A0;
      end
      else
      begin
         if (ShiftA0 == 1'b1)
             a0_sig = SRIA;
         else if (ShiftA0 == 1'b0)
             a0_sig = A0;
      end
    end

    always @(B0 or SRIB or ShiftB0)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_b0 == "shift")
            b0_sig = SRIB;
         else
            b0_sig = B0;
      end
      else
      begin
         if (ShiftB0 == 1'b1)
             b0_sig = SRIB;
         else if (ShiftB0 == 1'b0)
             b0_sig = B0;
      end
    end

    always @(posedge input_a0_clk_sig or posedge input_a0_rst_sig)
    begin
      if (input_a0_rst_sig == 1'b1)
        begin
          a0_sig_reg = 0;
        end
      else if (input_a0_ce_sig == 1'b1)
        begin
          a0_sig_reg = a0_sig;
        end
    end

    always @(a0_sig or a0_sig_reg)
    begin
      if (pmi_input_reg == "off")
          a0_sig_p = a0_sig;
      else
          a0_sig_p = a0_sig_reg;
    end

    always @(posedge input_b0_clk_sig or posedge input_b0_rst_sig)
    begin
      if (input_b0_rst_sig == 1'b1)
        begin
          b0_sig_reg = 0;
        end
      else if (input_b0_ce_sig == 1'b1)
        begin
          b0_sig_reg = b0_sig;
        end
    end

    always @(b0_sig or b0_sig_reg)
    begin
      if (pmi_input_reg == "off")
          b0_sig_p = b0_sig;
      else
          b0_sig_p = b0_sig_reg;
    end

    always @(a0_sig_p or A1 or ShiftA1)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_a1 == "shift")
            a1_sig = a0_sig_p;
         else
            a1_sig = A1;
      end
      else
      begin
         if (ShiftA1 == 1'b1)
             a1_sig = a0_sig_p;
         else if (ShiftA1 == 1'b0)
             a1_sig = A1;
      end
    end

    always @(b0_sig_p or B1 or ShiftB1)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_b1 == "shift")
            b1_sig = b0_sig_p;
         else
            b1_sig = B1;
      end
      else
      begin
         if (ShiftB1 == 1'b1)
             b1_sig = b0_sig_p;
         else if (ShiftB1 == 1'b0)
             b1_sig = B1;
       end
    end

    always @(posedge input_a1_clk_sig or posedge input_a1_rst_sig)
    begin
      if (input_a1_rst_sig == 1'b1)
        begin
          a1_sig_reg = 0;
        end
      else if (input_a1_ce_sig == 1'b1)
        begin
          a1_sig_reg = a1_sig;
        end
    end

    always @(a1_sig or a1_sig_reg)
    begin
      if (pmi_input_reg == "off")
          a1_sig_p = a1_sig;
      else
          a1_sig_p = a1_sig_reg;
    end

    always @(posedge input_b1_clk_sig or posedge input_b1_rst_sig)
    begin
      if (input_b1_rst_sig == 1'b1)
        begin
          b1_sig_reg = 0;
        end
      else if (input_b1_ce_sig == 1'b1)
        begin
          b1_sig_reg = b1_sig;
        end
    end

    always @(b1_sig or b1_sig_reg)
    begin
      if (pmi_input_reg == "off")
          b1_sig_p = b1_sig;
      else
          b1_sig_p = b1_sig_reg;
    end

    always @(a1_sig_p or A2 or ShiftA2)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_a1 == "shift")
            a2_sig = a1_sig_p;
         else
            a2_sig = A2;
      end
      else
      begin
         if (ShiftA2 == 1'b1)
             a2_sig = a1_sig_p;
         else if (ShiftA2 == 1'b0)
             a2_sig = A2;
      end
    end

    always @(b1_sig_p or B2 or ShiftB2)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_b2 == "shift")
            b2_sig = b1_sig_p;
         else
            b2_sig = B2;
      end
      else
      begin
         if (ShiftB2 == 1'b1)
             b2_sig = b1_sig_p;
         else if (ShiftB2 == 1'b0)
             b2_sig = B2;
      end
    end

    always @(posedge input_a2_clk_sig or posedge input_a2_rst_sig)
    begin
      if (input_a2_rst_sig == 1'b1)
        begin
          a2_sig_reg = 0;
        end
      else if (input_a2_ce_sig == 1'b1)
        begin
          a2_sig_reg = a2_sig;
        end
    end

    always @(a2_sig or a2_sig_reg)
    begin
      if (pmi_input_reg == "off")
          a2_sig_p = a2_sig;
      else
          a2_sig_p = a2_sig_reg;
    end

    always @(posedge input_b2_clk_sig or posedge input_b2_rst_sig)
    begin
      if (input_b2_rst_sig == 1'b1)
        begin
          b2_sig_reg = 0;
        end
      else if (input_b2_ce_sig == 1'b1)
        begin
          b2_sig_reg = b2_sig;
        end
    end

    always @(b2_sig or b2_sig_reg)
    begin
      if (pmi_input_reg == "off")
          b2_sig_p = b2_sig;
      else
          b2_sig_p = b2_sig_reg;
    end

    always @(a2_sig_p or A3 or ShiftA3)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_a3 == "shift")
            a3_sig = a2_sig_p;
         else
            a3_sig = A3;
      end
      else
      begin
         if (ShiftA3 == 1'b1)
             a3_sig = a2_sig_p;
         else if (ShiftA3 == 1'b0)
             a3_sig = A3;
      end
    end

    always @(b2_sig_p or B3 or ShiftB3)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_b3 == "shift")
            b3_sig = b2_sig_p;
         else
            b3_sig = B3;
      end
      else
      begin
         if (ShiftB3 == 1'b1)
             b3_sig = b2_sig_p;
         else if (ShiftB3 == 1'b0)
             b3_sig = B3;
      end
    end

    always @(posedge input_a3_clk_sig or posedge input_a3_rst_sig)
    begin
      if (input_a3_rst_sig == 1'b1)
        begin
          a3_sig_reg = 0;
        end
      else if (input_a3_ce_sig == 1'b1)
        begin
          a3_sig_reg = a3_sig;
        end
    end

    always @(a3_sig or a3_sig_reg)
    begin
      if (pmi_input_reg == "off")
          a3_sig_p = a3_sig;
      else
          a3_sig_p = a3_sig_reg;
    end

    always @(posedge input_b3_clk_sig or posedge input_b3_rst_sig)
    begin
      if (input_b3_rst_sig == 1'b1)
        begin
          b3_sig_reg = 0;
        end
      else if (input_b3_ce_sig == 1'b1)
        begin
          b3_sig_reg = b3_sig;
        end
    end

    always @(b3_sig or b3_sig_reg)
    begin
      if (pmi_input_reg == "off")
          b3_sig_p = b3_sig;
      else
          b3_sig_p = b3_sig_reg;
    end

    always @(posedge reg_ctrl_clk_sig_a_0 or posedge reg_ctrl_rst_sig_a_0)
    begin
      if (reg_ctrl_rst_sig_a_0 == 1'b1)
        begin
          signeda_reg1 <= 0;
        end
      else if (reg_ctrl_ce_sig_a_0 == 1'b1)
        begin
          signeda_reg1 <= SignA;
        end
    end

    always @(SignA or signeda_reg1)
    begin
      if (pmi_input_reg == "off")
          signeda_p1 = SignA;
      else
          signeda_p1 = signeda_reg1;
    end

    always @(posedge reg_ctrl_clk_sig_b_0 or posedge reg_ctrl_rst_sig_b_0)
    begin
      if (reg_ctrl_rst_sig_b_0 == 1'b1)
        begin
          signedb_reg1 <= 0;
        end
      else if (reg_ctrl_ce_sig_b_0 == 1'b1)
        begin
          signedb_reg1 <= SignB_new;
        end
    end

    always @(SignB_new or signedb_reg1)
    begin
      if (pmi_input_reg == "off")
          signedb_p1 = SignB_new;
      else
          signedb_p1 = signedb_reg1;
    end

    always @(posedge reg_ctrl_clk_sig_a_1 or posedge reg_ctrl_rst_sig_a_1)
    begin
      if (reg_ctrl_rst_sig_a_1 == 1'b1)
        begin
          signeda_reg2 <= 0;
        end
      else if (reg_ctrl_ce_sig_a_1 == 1'b1)
        begin
          signeda_reg2 <= signeda_p1;
        end
    end

    always @(signeda_p1 or signeda_reg2)
    begin
      if (pmi_additional_pipeline == 0)
          signeda_p2 = signeda_p1;
      else
          signeda_p2 = signeda_reg2;
    end

    always @(posedge reg_ctrl_clk_sig_b_1 or posedge reg_ctrl_rst_sig_b_1)
    begin
      if (reg_ctrl_rst_sig_b_1 == 1'b1)
        begin
          signedb_reg2 <= 0;
        end
      else if (reg_ctrl_ce_sig_b_1 == 1'b1)
        begin
          signedb_reg2 <= signedb_p1;
        end
    end

    always @(signedb_p1 or signedb_reg2)
    begin
      if (pmi_additional_pipeline == 0)
          signedb_p2 = signedb_p1;
      else
          signedb_p2 = signedb_reg2;
    end

    always @(posedge reg_addnsub1_0_clk_sig or posedge reg_addnsub1_0_rst_sig)
    begin
      if (reg_addnsub1_0_rst_sig == 1'b1)
        addnsub1_reg1 <= 0;
      else if (reg_addnsub1_0_ce_sig == 1'b1)
        addnsub1_reg1 <= ADDNSUB1;
    end

    always @(ADDNSUB1 or addnsub1_reg1)
    begin
      if (pmi_input_reg == "off")
        addnsub1_p1 <= ADDNSUB1;
      else
        addnsub1_p1 <= addnsub1_reg1;
    end

    always @(posedge reg_addnsub1_1_clk_sig or posedge reg_addnsub1_1_rst_sig)
    begin
      if (reg_addnsub1_1_rst_sig == 1'b1)
        addnsub1_reg2 <= 0;
      else if (reg_addnsub1_1_ce_sig == 1'b1)
        addnsub1_reg2 <= addnsub1_p1;
    end

    always @(addnsub1_p1 or addnsub1_reg2)
    begin
      if (pmi_additional_pipeline == 0)
        addnsub1_p2 <= addnsub1_p1;
      else
        addnsub1_p2 <= addnsub1_reg2;
    end

    always @(posedge reg_addnsub3_0_clk_sig or posedge reg_addnsub3_0_rst_sig)
    begin
      if (reg_addnsub3_0_rst_sig == 1'b1)
        addnsub3_reg1 <= 0;
      else if (reg_addnsub3_0_ce_sig == 1'b1)
        addnsub3_reg1 <= ADDNSUB3;
    end

    always @(ADDNSUB3 or addnsub3_reg1)
    begin
      if (pmi_input_reg == "off")
        addnsub3_p1 <= ADDNSUB3;
      else
        addnsub3_p1 <= addnsub3_reg1;
    end

    always @(posedge reg_addnsub3_1_clk_sig or posedge reg_addnsub3_1_rst_sig)
    begin
      if (reg_addnsub3_1_rst_sig == 1'b1)
        addnsub3_reg2 <= 0;
      else if (reg_addnsub3_1_ce_sig == 1'b1)
        addnsub3_reg2 <= addnsub3_p1;
    end

    always @(addnsub3_p1 or addnsub3_reg2)
    begin
      if (pmi_additional_pipeline == 0)
        addnsub3_p2 <= addnsub3_p1;
      else
        addnsub3_p2 <= addnsub3_reg2;
    end

    always @(a0_sig_p or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a0_sig_m = {{(pmi_datab_width){a0_sig_p[(pmi_dataa_width - 1)]}} , a0_sig_p};
        end
      else
        begin
          a0_sig_m[(pmi_dataa_width - 1):0] =  a0_sig_p[(pmi_dataa_width - 1):0];
          a0_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_dataa_width] = 0;
        end
    end

    always @(b0_sig_p or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b0_sig_m = {{(pmi_dataa_width){b0_sig_p[(pmi_datab_width - 1)]}} , b0_sig_p};
        end
      else
        begin
          b0_sig_m[(pmi_datab_width - 1):0] =  b0_sig_p[(pmi_datab_width - 1):0];
          b0_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_datab_width] = 0;
        end
    end

    always @(a1_sig_p or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a1_sig_m = {{(pmi_datab_width){a1_sig_p[(pmi_dataa_width - 1)]}} , a1_sig_p};
        end
      else
        begin
          a1_sig_m[(pmi_dataa_width - 1):0] =  a1_sig_p[(pmi_dataa_width - 1):0];
          a1_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_dataa_width] = 0;
        end
    end

    always @(b1_sig_p or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b1_sig_m = {{(pmi_dataa_width){b1_sig_p[(pmi_datab_width - 1)]}} , b1_sig_p};
        end
      else
        begin
          b1_sig_m[(pmi_datab_width - 1):0] =  b1_sig_p[(pmi_datab_width - 1):0];
          b1_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_datab_width] = 0;
        end
    end
//
    always @(a2_sig_p or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a2_sig_m = {{(pmi_datab_width){a2_sig_p[(pmi_dataa_width - 1)]}} , a2_sig_p};
        end
      else
        begin
          a2_sig_m[(pmi_dataa_width - 1):0] =  a2_sig_p[(pmi_dataa_width - 1):0];
          a2_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_dataa_width] = 0;
        end
    end

    always @(b2_sig_p or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b2_sig_m = {{(pmi_dataa_width){b2_sig_p[(pmi_datab_width - 1)]}} , b2_sig_p};
        end
      else
        begin
          b2_sig_m[(pmi_datab_width - 1):0] =  b2_sig_p[(pmi_datab_width - 1):0];
          b2_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_datab_width] = 0;
        end
    end

    always @(a3_sig_p or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a3_sig_m = {{(pmi_datab_width){a3_sig_p[(pmi_dataa_width - 1)]}} , a3_sig_p};
        end
      else
        begin
          a3_sig_m[(pmi_dataa_width - 1):0] =  a3_sig_p[(pmi_dataa_width - 1):0];
          a3_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_dataa_width] = 0;
        end
    end

    always @(b3_sig_p or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b3_sig_m = {{(pmi_dataa_width){b3_sig_p[(pmi_datab_width - 1)]}} , b3_sig_p};
        end
      else
        begin
          b3_sig_m[(pmi_datab_width - 1):0] =  b3_sig_p[(pmi_datab_width - 1):0];
          b3_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_datab_width] = 0;
        end
    end

    assign p0_sig_i = (!a0_sig_m || !b0_sig_m)? 0 : a0_sig_m * b0_sig_m ;
    assign p1_sig_i = (!a1_sig_m || !b1_sig_m)? 0 : a1_sig_m * b1_sig_m ;
    assign p2_sig_i = (!a2_sig_m || !b2_sig_m)? 0 : a2_sig_m * b2_sig_m ;
    assign p3_sig_i = (!a3_sig_m || !b3_sig_m)? 0 : a3_sig_m * b3_sig_m ;

    always @(p0_sig_i_e_reg1 or signeda_p2 or signedb_p2)
    begin
      if ((signeda_p2 || signedb_p2) == 1'b1)
        begin
           p0_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p0_sig_i_e_reg1;
           p0_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = {p0_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)], p0_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)]};
        end
      else
        begin
           p0_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p0_sig_i_e_reg1;
           p0_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = 0;
        end
    end

    always @(p1_sig_i_e_reg1 or signeda_p2 or signedb_p2)
    begin
      if ((signeda_p2 || signedb_p2) == 1'b1)
        begin
           p1_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p1_sig_i_e_reg1;
           p1_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = {p1_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)], p1_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)]};
        end
      else
        begin
           p1_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p1_sig_i_e_reg1;
           p1_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = 0;
        end
    end

    always @(p2_sig_i_e_reg1 or signeda_p2 or signedb_p2)
    begin
      if ((signeda_p2 || signedb_p2) == 1'b1)
        begin
           p2_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p2_sig_i_e_reg1;
           p2_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = {p2_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)], p2_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)]};
        end
      else
        begin
           p2_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p2_sig_i_e_reg1;
           p2_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = 0;
        end
    end

    always @(p3_sig_i_e_reg1 or signeda_p2 or signedb_p2)
    begin
      if ((signeda_p2 || signedb_p2) == 1'b1)
        begin
           p3_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p3_sig_i_e_reg1;
           p3_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = {p3_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)], p3_sig_i_e_reg1[(pmi_dataa_width + pmi_datab_width - 1)]};
        end
      else
        begin
           p3_sig_i_e[(pmi_dataa_width + pmi_datab_width - 1):0] = p3_sig_i_e_reg1;
           p3_sig_i_e[(pmi_dataa_width + pmi_datab_width + 1) : (pmi_dataa_width + pmi_datab_width)] = 0;
        end
    end

    always @(posedge pipeline0_clk_sig or posedge pipeline0_rst_sig)
    begin
      if (pipeline0_rst_sig == 1'b1)
          p0_sig_i_e_reg <= 0;
      else if (pipeline0_ce_sig == 1'b1)
          p0_sig_i_e_reg <= p0_sig_i;
    end

    always @(p0_sig_i or p0_sig_i_e_reg)
    begin
      if (pmi_additional_pipeline == 0)
          p0_sig_i_e_reg1 = p0_sig_i;
      else
          p0_sig_i_e_reg1 = p0_sig_i_e_reg;
    end

    always @(posedge pipeline1_clk_sig or posedge pipeline1_rst_sig)
    begin
      if (pipeline1_rst_sig == 1'b1)
          p1_sig_i_e_reg <= 0;
      else if (pipeline1_ce_sig == 1'b1)
          p1_sig_i_e_reg <= p1_sig_i;
    end

    always @(p1_sig_i or p1_sig_i_e_reg)
    begin
      if (pmi_additional_pipeline == 0)
          p1_sig_i_e_reg1 = p1_sig_i;
      else
          p1_sig_i_e_reg1 = p1_sig_i_e_reg;
    end

    always @(posedge pipeline2_clk_sig or posedge pipeline2_rst_sig)
    begin
      if (pipeline2_rst_sig == 1'b1)
          p2_sig_i_e_reg <= 0;
      else if (pipeline2_ce_sig == 1'b1)
          p2_sig_i_e_reg <= p2_sig_i;
    end

    always @(p2_sig_i or p2_sig_i_e_reg)
    begin
      if (pmi_additional_pipeline == 0)
          p2_sig_i_e_reg1 = p2_sig_i;
      else
          p2_sig_i_e_reg1 = p2_sig_i_e_reg;
    end

    always @(posedge pipeline3_clk_sig or posedge pipeline3_rst_sig)
    begin
      if (pipeline3_rst_sig == 1'b1)
          p3_sig_i_e_reg <= 0;
      else if (pipeline3_ce_sig == 1'b1)
          p3_sig_i_e_reg <= p3_sig_i;
    end

    always @(p3_sig_i or p3_sig_i_e_reg)
    begin
      if (pmi_additional_pipeline == 0)
          p3_sig_i_e_reg1 = p3_sig_i;
      else
          p3_sig_i_e_reg1 = p3_sig_i_e_reg;
    end

    assign sum0_sig_i = addnsub1_p2 ? (p0_sig_i_e + p1_sig_i_e) : (p0_sig_i_e - p1_sig_i_e);

    assign sum1_sig_i = addnsub3_p2 ? (p2_sig_i_e + p3_sig_i_e) : (p2_sig_i_e - p3_sig_i_e);

    assign sumt_sig = sum0_sig_i + sum1_sig_i;

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
          sumt_reg <= 0;
      else if (output_ce_sig == 1'b1)
          sumt_reg <= sumt_sig;
    end

    always @(sumt_reg or sumt_sig)
    begin
      if (pmi_output_reg == "off")
          sum_o = sumt_sig;
      else
          sum_o = sumt_reg;
    end

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
          sumt_reg2 <= 0;
      else if (output_ce_sig == 1'b1)
          sumt_reg2 <= sum_o;
    end

    always @(sumt_reg2 or sum_o)
    begin
      if (pmi_pipelined_mode == "off")
          sum_o2 = sum_o;
      else
          sum_o2 = sumt_reg2;
    end

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
          sumt_reg3 <= 0;
      else if (output_ce_sig == 1'b1)
          sumt_reg3 <= sum_o2;
    end

    always @(sumt_reg3 or sum_o2)
    begin
      if (pmi_pipelined_mode == "off")
          sum_o3 = sum_o2;
      else
      begin
         if ( pmi_dataa_width <= 18 || pmi_datab_width <= 18 ||
              (pmi_dataa_width >= 19 && pmi_dataa_width <= 27 && pmi_datab_width >= 37 && pmi_datab_width <= 45) ||
              (pmi_datab_width >= 19 && pmi_datab_width <= 27 && pmi_dataa_width >= 37 && pmi_dataa_width <= 45) )
            sum_o3 = sum_o2;
         else
            sum_o3 = sumt_reg3;
      end
    end

    assign SUM = sum_o3;

    assign SROA = a3_sig_p;
    assign SROB = b3_sig_p;
//pragma translate_on

endmodule
