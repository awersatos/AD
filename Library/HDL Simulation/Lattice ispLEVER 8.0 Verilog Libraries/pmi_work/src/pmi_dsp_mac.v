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
  pmi_family                 "ECP"|"ECP2"|"ECP2M"|"XP2"|"ECP3"          "ECP2"
  pmi_gsr                          "enable"|"disable"                 "enable"
  pmi_source_control_a             "parallel"|"shift"               "parallel"
  pmi_source_control_b             "parallel"|"shift"               "parallel"
  pmi_reg_inputa_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputa_ce                "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_inputa_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputb_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputb_ce                "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_inputb_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_pipeline_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_pipeline_ce              "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_pipeline_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_output_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_output_ce                "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_output_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signeda_0_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signeda_0_ce             "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_signeda_0_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signeda_1_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signeda_1_ce             "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_signeda_1_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signedb_0_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signedb_0_ce             "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_signedb_0_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signedb_1_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signedb_1_ce             "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_signedb_1_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_addnsub_0_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_addnsub_0_ce             "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_addnsub_0_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_addnsub_1_clk            "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_addnsub_1_ce             "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_addnsub_1_rst            "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_accumsload_0_clk         "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_accumsload_0_ce          "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_accumsload_0_rst         "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_accumsload_1_clk         "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_accumsload_1_ce          "CE0"|"CE1"|"CE2"|"CE3"               "CE0"
  pmi_reg_accumsload_1_rst         "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
------------------------------------------------------------------------------
*/
// $Header:

`timescale  1 ns / 1 ps

module pmi_dsp_mac
 #(parameter pmi_dataa_width = 8,
   parameter pmi_datab_width = 8,
   parameter pmi_additional_pipeline = 0,
   parameter pmi_input_reg = "on",
   parameter pmi_family = "ECP2",
   parameter pmi_gsr = "enable",
   parameter pmi_source_control_a = "parallel",
   parameter pmi_source_control_b = "parallel",
   parameter pmi_reg_inputa_clk = "CLK0",
   parameter pmi_reg_inputa_ce = "CE0",
   parameter pmi_reg_inputa_rst = "RST0",
   parameter pmi_reg_inputb_clk = "CLK0",
   parameter pmi_reg_inputb_ce = "CE0",
   parameter pmi_reg_inputb_rst = "RST0",
   parameter pmi_reg_pipeline_clk = "CLK0",
   parameter pmi_reg_pipeline_ce = "CE0",
   parameter pmi_reg_pipeline_rst = "RST0",
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
   parameter pmi_reg_addnsub_0_clk = "CLK0",
   parameter pmi_reg_addnsub_0_ce = "CE0",
   parameter pmi_reg_addnsub_0_rst = "RST0",
   parameter pmi_reg_addnsub_1_clk = "CLK0",
   parameter pmi_reg_addnsub_1_ce = "CE0",
   parameter pmi_reg_addnsub_1_rst = "RST0",
   parameter pmi_reg_accumsload_0_clk = "CLK0",
   parameter pmi_reg_accumsload_0_ce = "CE0",
   parameter pmi_reg_accumsload_0_rst = "RST0",
   parameter pmi_reg_accumsload_1_clk = "CLK0",
   parameter pmi_reg_accumsload_1_ce = "CE0",
   parameter pmi_reg_accumsload_1_rst = "RST0",
   parameter module_type = "pmi_dsp_mac")

  (input [(pmi_dataa_width-1):0]       A,
   input [(pmi_datab_width-1):0]       B,
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
   input SourceA,
   input SourceB,
   input ADDNSUB,
   input [((pmi_dataa_width + pmi_datab_width - 1) + 16):0] LD,
   input ACCUMSLOAD,
   output [((pmi_dataa_width + pmi_datab_width - 1) + 16):0] ACCUM,
   output OVERFLOW,
   output [17:0]  SROA,
   output [17:0]  SROB)/*synthesis syn_black_box*/;

//pragma translate_off
reg input_a_clk_sig, input_b_clk_sig;
reg pipeline_clk_sig, output_clk_sig;
reg reg_ctrl_clk_sig_a_0, reg_ctrl_clk_sig_b_0;
reg reg_ctrl_clk_sig_a_1, reg_ctrl_clk_sig_b_1;
reg input_a_ce_sig, input_b_ce_sig;
reg pipeline_ce_sig, output_ce_sig;
reg reg_ctrl_ce_sig_a_0, reg_ctrl_ce_sig_b_0;
reg reg_ctrl_ce_sig_a_1, reg_ctrl_ce_sig_b_1;
reg input_a_rst_sig, input_b_rst_sig;
reg pipeline_rst_sig, output_rst_sig;
reg reg_ctrl_rst_sig_a_0, reg_ctrl_rst_sig_b_0;
reg reg_ctrl_rst_sig_a_1, reg_ctrl_rst_sig_b_1;
reg reg_addnsub_0_clk_sig, reg_addnsub_1_clk_sig;
reg reg_addnsub_0_ce_sig, reg_addnsub_1_ce_sig;
reg reg_addnsub_0_rst_sig, reg_addnsub_1_rst_sig;
reg signeda_reg2, signedb_reg2;
reg addnsub_reg1, addnsub_p1, addnsub_reg2, addnsub_p2;
reg [(pmi_dataa_width-1):0] a_sig;
reg [(pmi_dataa_width-1):0] a_sig_reg;
reg [(pmi_dataa_width-1):0] a_sig_p;
reg [(pmi_datab_width-1):0] b_sig;
reg [(pmi_datab_width-1):0] b_sig_reg;
reg [(pmi_datab_width-1):0] b_sig_p;
reg signeda_reg1, signeda_p1, signeda_p2;
reg signedb_reg1, signedb_p1, signedb_p2;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] a_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] b_sig_m;
wire [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig_i;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig_o;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig_ps;
reg [(pmi_dataa_width + pmi_datab_width + 16):0] p_sig_ps_accum;
reg [(pmi_dataa_width + pmi_datab_width + 16):0] p_sig_ps_accum_2;
wire [(pmi_dataa_width + pmi_datab_width + 16):0] accum_sig;
reg [(pmi_dataa_width + pmi_datab_width + 16):0] accum_sig_l;
reg [(pmi_dataa_width + pmi_datab_width + 16):0] accum_reg;
reg reg_accumsload_0_clk_sig, reg_accumsload_1_clk_sig;
reg reg_accumsload_0_ce_sig, reg_accumsload_1_ce_sig;
reg reg_accumsload_0_rst_sig, reg_accumsload_1_rst_sig;
reg  accumsload_p1;
reg  accumsload_p2;
reg  accumsload_p3;
reg  accumsload_reg1;
reg  accumsload_reg2;
wire SignB_new, signedab_p2;
reg overflow_sig_1, OVERFLOW_sig;
reg overflow_sig_2;
wire OVERFLOW_ecp, OVERFLOW_ecp2;

    assign SignB_new = (pmi_family == "ECP") ? SignA : SignB;

    or INST13 (signedab_p2, signeda_p2, signedb_p2);

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputa_clk == "CLK0")
          input_a_clk_sig = CLK0;
      else if (pmi_reg_inputa_clk == "CLK1")
          input_a_clk_sig = CLK1;
      else if (pmi_reg_inputa_clk == "CLK2")
          input_a_clk_sig = CLK2;
      else if (pmi_reg_inputa_clk == "CLK3")
          input_a_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_inputb_clk == "CLK0")
          input_b_clk_sig = CLK0;
      else if (pmi_reg_inputb_clk == "CLK1")
          input_b_clk_sig = CLK1;
      else if (pmi_reg_inputb_clk == "CLK2")
          input_b_clk_sig = CLK2;
      else if (pmi_reg_inputb_clk == "CLK3")
          input_b_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_pipeline_clk == "CLK0")
          pipeline_clk_sig = CLK0;
      else if (pmi_reg_pipeline_clk == "CLK1")
          pipeline_clk_sig = CLK1;
      else if (pmi_reg_pipeline_clk == "CLK2")
          pipeline_clk_sig = CLK2;
      else if (pmi_reg_pipeline_clk == "CLK3")
          pipeline_clk_sig = CLK3;
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
      if (pmi_reg_inputa_ce == "CE0")
          input_a_ce_sig = CE0;
      else if (pmi_reg_inputa_ce == "CE1")
          input_a_ce_sig = CE1;
      else if (pmi_reg_inputa_ce == "CE2")
          input_a_ce_sig = CE2;
      else if (pmi_reg_inputa_ce == "CE3")
          input_a_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_inputb_ce == "CE0")
          input_b_ce_sig = CE0;
      else if (pmi_reg_inputb_ce == "CE1")
          input_b_ce_sig = CE1;
      else if (pmi_reg_inputb_ce == "CE2")
          input_b_ce_sig = CE2;
      else if (pmi_reg_inputb_ce == "CE3")
          input_b_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_pipeline_ce == "CE0")
          pipeline_ce_sig = CE0;
      else if (pmi_reg_pipeline_ce == "CE1")
          pipeline_ce_sig = CE1;
      else if (pmi_reg_pipeline_ce == "CE2")
          pipeline_ce_sig = CE2;
      else if (pmi_reg_pipeline_ce == "CE3")
          pipeline_ce_sig = CE3;
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
      if (pmi_reg_inputa_rst == "RST0")
          input_a_rst_sig = RST0;
      else if (pmi_reg_inputa_rst == "RST1")
          input_a_rst_sig = RST1;
      else if (pmi_reg_inputa_rst == "RST2")
          input_a_rst_sig = RST2;
      else if (pmi_reg_inputa_rst == "RST3")
          input_a_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_inputb_rst == "RST0")
          input_b_rst_sig = RST0;
      else if (pmi_reg_inputb_rst == "RST1")
          input_b_rst_sig = RST1;
      else if (pmi_reg_inputb_rst == "RST2")
          input_b_rst_sig = RST2;
      else if (pmi_reg_inputb_rst == "RST3")
          input_b_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_pipeline_rst == "RST0")
          pipeline_rst_sig = RST0;
      else if (pmi_reg_pipeline_rst == "RST1")
          pipeline_rst_sig = RST1;
      else if (pmi_reg_pipeline_rst == "RST2")
          pipeline_rst_sig = RST2;
      else if (pmi_reg_pipeline_rst == "RST3")
          pipeline_rst_sig = RST3;
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
      if (pmi_reg_addnsub_0_clk == "CLK0")
          reg_addnsub_0_clk_sig = CLK0;
      else if (pmi_reg_addnsub_0_clk == "CLK1")
          reg_addnsub_0_clk_sig = CLK1;
      else if (pmi_reg_addnsub_0_clk == "CLK2")
          reg_addnsub_0_clk_sig = CLK2;
      else if (pmi_reg_addnsub_0_clk == "CLK3")
          reg_addnsub_0_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_addnsub_1_clk == "CLK0")
          reg_addnsub_1_clk_sig = CLK0;
      else if (pmi_reg_addnsub_1_clk == "CLK1")
          reg_addnsub_1_clk_sig = CLK1;
      else if (pmi_reg_addnsub_1_clk == "CLK2")
          reg_addnsub_1_clk_sig = CLK2;
      else if (pmi_reg_addnsub_1_clk == "CLK3")
          reg_addnsub_1_clk_sig = CLK3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_addnsub_0_ce == "CE0")
          reg_addnsub_0_ce_sig = CE0;
      else if (pmi_reg_addnsub_0_ce == "CE1")
          reg_addnsub_0_ce_sig = CE1;
      else if (pmi_reg_addnsub_0_ce == "CE2")
          reg_addnsub_0_ce_sig = CE2;
      else if (pmi_reg_addnsub_0_ce == "CE3")
          reg_addnsub_0_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_addnsub_1_ce == "CE0")
          reg_addnsub_1_ce_sig = CE0;
      else if (pmi_reg_addnsub_1_ce == "CE1")
          reg_addnsub_1_ce_sig = CE1;
      else if (pmi_reg_addnsub_1_ce == "CE2")
          reg_addnsub_1_ce_sig = CE2;
      else if (pmi_reg_addnsub_1_ce == "CE3")
          reg_addnsub_1_ce_sig = CE3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_addnsub_0_rst == "RST0")
          reg_addnsub_0_rst_sig = RST0;
      else if (pmi_reg_addnsub_0_rst == "RST1")
          reg_addnsub_0_rst_sig = RST1;
      else if (pmi_reg_addnsub_0_rst == "RST2")
          reg_addnsub_0_rst_sig = RST2;
      else if (pmi_reg_addnsub_0_rst == "RST3")
          reg_addnsub_0_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_addnsub_1_rst == "RST0")
          reg_addnsub_1_rst_sig = RST0;
      else if (pmi_reg_addnsub_1_rst == "RST1")
          reg_addnsub_1_rst_sig = RST1;
      else if (pmi_reg_addnsub_1_rst == "RST2")
          reg_addnsub_1_rst_sig = RST2;
      else if (pmi_reg_addnsub_1_rst == "RST3")
          reg_addnsub_1_rst_sig = RST3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_accumsload_0_clk == "CLK0")
          reg_accumsload_0_clk_sig = CLK0;
      else if (pmi_reg_accumsload_0_clk == "CLK1")
          reg_accumsload_0_clk_sig = CLK1;
      else if (pmi_reg_accumsload_0_clk == "CLK2")
          reg_accumsload_0_clk_sig = CLK2;
      else if (pmi_reg_accumsload_0_clk == "CLK3")
          reg_accumsload_0_clk_sig = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_accumsload_1_clk == "CLK0")
          reg_accumsload_1_clk_sig = CLK0;
      else if (pmi_reg_accumsload_1_clk == "CLK1")
          reg_accumsload_1_clk_sig = CLK1;
      else if (pmi_reg_accumsload_1_clk == "CLK2")
          reg_accumsload_1_clk_sig = CLK2;
      else if (pmi_reg_accumsload_1_clk == "CLK3")
          reg_accumsload_1_clk_sig = CLK3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_accumsload_0_ce == "CE0")
          reg_accumsload_0_ce_sig = CE0;
      else if (pmi_reg_accumsload_0_ce == "CE1")
          reg_accumsload_0_ce_sig = CE1;
      else if (pmi_reg_accumsload_0_ce == "CE2")
          reg_accumsload_0_ce_sig = CE2;
      else if (pmi_reg_accumsload_0_ce == "CE3")
          reg_accumsload_0_ce_sig = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_accumsload_1_ce == "CE0")
          reg_accumsload_1_ce_sig = CE0;
      else if (pmi_reg_accumsload_1_ce == "CE1")
          reg_accumsload_1_ce_sig = CE1;
      else if (pmi_reg_accumsload_1_ce == "CE2")
          reg_accumsload_1_ce_sig = CE2;
      else if (pmi_reg_accumsload_1_ce == "CE3")
          reg_accumsload_1_ce_sig = CE3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_accumsload_0_rst == "RST0")
          reg_accumsload_0_rst_sig = RST0;
      else if (pmi_reg_accumsload_0_rst == "RST1")
          reg_accumsload_0_rst_sig = RST1;
      else if (pmi_reg_accumsload_0_rst == "RST2")
          reg_accumsload_0_rst_sig = RST2;
      else if (pmi_reg_accumsload_0_rst == "RST3")
          reg_accumsload_0_rst_sig = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_accumsload_1_rst == "RST0")
          reg_accumsload_1_rst_sig = RST0;
      else if (pmi_reg_accumsload_1_rst == "RST1")
          reg_accumsload_1_rst_sig = RST1;
      else if (pmi_reg_accumsload_1_rst == "RST2")
          reg_accumsload_1_rst_sig = RST2;
      else if (pmi_reg_accumsload_1_rst == "RST3")
          reg_accumsload_1_rst_sig = RST3;
    end

    always @(A or SRIA or SourceA)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_a == "shift")
            a_sig = SRIA;
         else
            a_sig = A;
      end
      else
      begin
         if (SourceA == 1'b1)
             a_sig = SRIA;
         else if (SourceA == 1'b0)
             a_sig = A;
      end
    end

    always @(B or SRIB or SourceB)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_b == "shift")
            b_sig = SRIB;
         else
            b_sig = B;
      end
      else
      begin
         if (SourceB == 1'b1)
             b_sig = SRIB;
         else if (SourceB == 1'b0)
             b_sig = B;
      end
    end

    always @(posedge input_a_clk_sig or posedge input_a_rst_sig)
    begin
      if (input_a_rst_sig == 1'b1)
        begin
          a_sig_reg = 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg = a_sig;
        end
    end

    always @(a_sig or a_sig_reg)
    begin
      if (pmi_input_reg == "off")
          a_sig_p = a_sig;
      else
          a_sig_p = a_sig_reg;
    end

    always @(posedge input_b_clk_sig or posedge input_b_rst_sig)
    begin
      if (input_b_rst_sig == 1'b1)
        begin
          b_sig_reg = 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg = b_sig;
        end
    end

    always @(b_sig or b_sig_reg)
    begin
      if (pmi_input_reg == "off")
          b_sig_p = b_sig;
      else
          b_sig_p = b_sig_reg;
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

    always @(posedge reg_addnsub_0_clk_sig or posedge reg_addnsub_0_rst_sig)
    begin
      if (reg_addnsub_0_rst_sig == 1'b1)
        addnsub_reg1 <= 0;
      else if (reg_addnsub_0_ce_sig == 1'b1)
        addnsub_reg1 <= ADDNSUB;
    end

    always @(ADDNSUB or addnsub_reg1)
    begin
      if (pmi_input_reg == "off")
        addnsub_p1 <= ADDNSUB;
      else
        addnsub_p1 <= addnsub_reg1;
    end

    always @(posedge reg_addnsub_1_clk_sig or posedge reg_addnsub_1_rst_sig)
    begin
      if (reg_addnsub_1_rst_sig == 1'b1)
        addnsub_reg2 <= 0;
      else if (reg_addnsub_1_ce_sig == 1'b1)
        addnsub_reg2 <= addnsub_p1;
    end

    always @(addnsub_p1 or addnsub_reg2)
    begin
      if (pmi_additional_pipeline == 0)
        addnsub_p2 <= addnsub_p1;
      else
        addnsub_p2 <= addnsub_reg2;
    end

    always @(posedge reg_accumsload_0_clk_sig or posedge reg_accumsload_0_rst_sig)
    begin
      if (reg_accumsload_0_rst_sig == 1'b1)
        begin
          accumsload_reg1 <= 0;
        end
      else if (reg_accumsload_0_ce_sig == 1'b1)
        begin
          accumsload_reg1 <= ACCUMSLOAD;
        end
    end

    always @(ACCUMSLOAD or accumsload_reg1)
    begin
      if (pmi_input_reg == "off")
        accumsload_p1 <= ACCUMSLOAD;
      else
        accumsload_p1 <= accumsload_reg1;
    end

    always @(posedge reg_accumsload_1_clk_sig or posedge reg_accumsload_1_rst_sig)
    begin
      if (reg_accumsload_1_rst_sig == 1'b1)
        begin
          accumsload_reg2 <= 0;
        end
      else if (reg_accumsload_1_ce_sig == 1'b1)
        begin
          accumsload_reg2 <= accumsload_p1;
        end
    end

    always @(accumsload_p1 or accumsload_reg2)
    begin
      if (pmi_additional_pipeline == 0)
        accumsload_p2 <= accumsload_p1;
      else
        accumsload_p2 <= accumsload_reg2;
    end

    always @(a_sig_p or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a_sig_m = {{(pmi_datab_width){a_sig_p[(pmi_dataa_width - 1)]}} , a_sig_p};
        end
      else
        begin
          a_sig_m[(pmi_dataa_width - 1):0] =  a_sig_p[(pmi_dataa_width - 1):0];
          a_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_dataa_width] = 0;
        end
    end

    always @(b_sig_p or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b_sig_m = {{(pmi_dataa_width){b_sig_p[(pmi_datab_width - 1)]}} , b_sig_p};
        end
      else
        begin
          b_sig_m[(pmi_datab_width - 1):0] =  b_sig_p[(pmi_datab_width - 1):0];
          b_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_datab_width] = 0;
        end
    end

    always @(p_sig_ps or signeda_p2 or signedb_p2)
    begin
      if ((signeda_p2 || signedb_p2) == 1'b1)
        begin
          p_sig_ps_accum[(pmi_dataa_width + pmi_datab_width - 1):0] = p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1):0];
          p_sig_ps_accum[(pmi_dataa_width + pmi_datab_width + 16):(pmi_dataa_width + pmi_datab_width)] =
                          { p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)],
                            p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1)]};
        end
      else
        begin
          p_sig_ps_accum[(pmi_dataa_width + pmi_datab_width - 1):0] =  p_sig_ps[(pmi_dataa_width + pmi_datab_width - 1):0];
          p_sig_ps_accum[(pmi_dataa_width + pmi_datab_width + 16):(pmi_dataa_width + pmi_datab_width)] = 0;
        end
    end

    assign p_sig_i = (!a_sig_m || !b_sig_m)? 0 : a_sig_m * b_sig_m ;

    always @(posedge pipeline_clk_sig or posedge pipeline_rst_sig)
    begin
      if (pipeline_rst_sig == 1'b1)
          p_sig_o <= 0;
      else if (pipeline_ce_sig == 1'b1)
          p_sig_o <= p_sig_i;
    end

    always @(p_sig_i or p_sig_o)
    begin
      if (pmi_additional_pipeline == 0)
          p_sig_ps = p_sig_i;
      else
          p_sig_ps = p_sig_o;
    end

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
          accum_reg <= 0;
      else if (output_ce_sig == 1'b1)
          accum_reg <= accum_sig;
    end

    always @(accumsload_p2 or LD or accum_reg)
    begin
      if (accumsload_p2 == 1'b1)
      begin
         if (pmi_family == "ECP")
         begin
            accum_sig_l[((pmi_dataa_width + pmi_datab_width) + 16):0] = 0;
         end
         else
         begin
            accum_sig_l[((pmi_dataa_width + pmi_datab_width - 1) + 16):0] = LD;
            if ((signeda_p2 || signedb_p2) == 1'b1)
               accum_sig_l[((pmi_dataa_width + pmi_datab_width) + 16)] = LD[((pmi_dataa_width + pmi_datab_width - 1) + 16)];
            else
               accum_sig_l[((pmi_dataa_width + pmi_datab_width) + 16)] = 1'b0;
         end
      end
      else
      begin
         accum_sig_l[((pmi_dataa_width + pmi_datab_width - 1) + 16):0] = accum_reg[((pmi_dataa_width + pmi_datab_width - 1) + 16):0];
         if ((signeda_p2 || signedb_p2) == 1'b1)
            accum_sig_l[((pmi_dataa_width + pmi_datab_width) + 16)] = accum_reg[((pmi_dataa_width + pmi_datab_width - 1) + 16)];
         else
            accum_sig_l[((pmi_dataa_width + pmi_datab_width) + 16)] = 1'b0;
      end
    end

    assign accum_sig = addnsub_p2 ? (accum_sig_l + p_sig_ps_accum) : (accum_sig_l - p_sig_ps_accum);

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
          overflow_sig_1 <= 0;
      else if (output_ce_sig == 1'b1)
          overflow_sig_1 <= accum_reg[((pmi_dataa_width + pmi_datab_width) + 16)];
    end

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
      begin
          overflow_sig_2 <= 1'b0;
          p_sig_ps_accum_2 <= 0;
          accumsload_p3 <= 0;
      end
      else if (output_ce_sig == 1'b1)
      begin
          overflow_sig_2 <= (!accum_reg[((pmi_dataa_width + pmi_datab_width) + 16)] && accum_reg[((pmi_dataa_width + pmi_datab_width - 1) + 16)] || accum_reg[((pmi_dataa_width + pmi_datab_width) + 16)] && !accum_reg[((pmi_dataa_width + pmi_datab_width -1) + 16)]);
          p_sig_ps_accum_2 <= p_sig_ps_accum;
          accumsload_p3 <= accumsload_p2;
      end
    end

    assign OVERFLOW_ecp = accumsload_p3 ?
                         (!addnsub_p2 && !signedab_p2) ? ((p_sig_ps_accum_2 == 0) ? 1'b0: 1'b1) :
                         (!addnsub_p2 && signedab_p2)  ? 1'b0:
                         (addnsub_p2  && !signedab_p2) ? 1'b0:
                         (addnsub_p2  &&  signedab_p2) ? 1'b0: p_sig_ps_accum_2[((pmi_dataa_width + pmi_datab_width) + 16)] :
                         signedab_p2 ? (!overflow_sig_2 && (!accum_reg[((pmi_dataa_width + pmi_datab_width) + 16)] && accum_reg[((pmi_dataa_width + pmi_datab_width) + 16 -1)] || accum_reg[((pmi_dataa_width + pmi_datab_width) + 16)] && !accum_reg[((pmi_dataa_width + pmi_datab_width) + 16 -1)])): (accum_reg[((pmi_dataa_width + pmi_datab_width) + 16)] && !overflow_sig_1);

    assign OVERFLOW_ecp2 = (signeda_p2 || signedb_p2) ? ((!accum_reg[(pmi_dataa_width + pmi_datab_width + 16)] && accum_reg[(pmi_dataa_width + pmi_datab_width + 15)]) || accum_reg[(pmi_dataa_width + pmi_datab_width + 16)] && !accum_reg[(pmi_dataa_width + pmi_datab_width + 15)]): (accum_reg[(pmi_dataa_width + pmi_datab_width + 16)]);

    assign SROA = a_sig_p;
    assign SROB = b_sig_p;
    assign ACCUM = accum_reg;
    assign OVERFLOW = OVERFLOW_sig;

    always @(OVERFLOW_ecp or OVERFLOW_ecp2)
    begin
       if (pmi_family == "ECP")
          OVERFLOW_sig = OVERFLOW_ecp;
       else
          OVERFLOW_sig = OVERFLOW_ecp2;
    end
//pragma translate_on

endmodule

