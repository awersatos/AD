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
  pmi_source_control_a             "parallel"|"shift"               "parallel"
  pmi_source_control_b             "parallel"|"shift"               "parallel"
  pmi_reg_inputa_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputa_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputa_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_inputb_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_inputb_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_inputb_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_pipeline_clk             "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_pipeline_ce              "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_pipeline_rst             "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_output_clk               "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_output_ce                "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_output_rst               "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signeda_clk              "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signeda_ce               "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_signeda_rst              "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_reg_signedb_clk              "CLK0"|"CLK1"|"CLK2"|"CLK3"          "CLK0"
  pmi_reg_signedb_ce               "CE0"|"CE1"|"CE2"|"CE3"              "CE0"
  pmi_reg_signedb_rst              "RST0"|"RST1"|"RST2"|"RST3"          "RST0"
  pmi_pipelined_mode               "on"|"off"                           "off"
------------------------------------------------------------------------------
*/
// $Header:
//

`timescale  1 ns / 1 ps

module pmi_dsp_mult 
 #(parameter pmi_dataa_width = 8,
   parameter pmi_datab_width = 8,
   parameter pmi_additional_pipeline = 0,
   parameter pmi_input_reg = "on",
   parameter pmi_output_reg = "on",
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
   parameter pmi_reg_signeda_clk = "CLK0",
   parameter pmi_reg_signeda_ce = "CE0",
   parameter pmi_reg_signeda_rst = "RST0",
   parameter pmi_reg_signedb_clk = "CLK0",
   parameter pmi_reg_signedb_ce = "CE0",
   parameter pmi_reg_signedb_rst = "RST0",
   parameter pmi_pipelined_mode = "off",
   parameter module_type = "pmi_dsp_mult")

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
   output [(pmi_dataa_width + pmi_datab_width - 1):0]  P,
   output [17:0]  SROA,
   output [17:0]  SROB)/*synthesis syn_black_box*/;

//pragma translate_off
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig, p_sig2;
reg input_a_clk_sig, input_b_clk_sig;
reg pipeline_clk_sig, output_clk_sig;
reg reg_ctrl_clk_sig_a, reg_ctrl_clk_sig_b;
reg input_a_ce_sig, input_b_ce_sig;
reg pipeline_ce_sig, output_ce_sig;
reg reg_ctrl_ce_sig_a, reg_ctrl_ce_sig_b;
reg input_a_rst_sig, input_b_rst_sig;
reg pipeline_rst_sig, output_rst_sig;
reg reg_ctrl_rst_sig_a, reg_ctrl_rst_sig_b;
reg [(pmi_dataa_width-1):0] a_sig_reg;
reg [(pmi_dataa_width-1):0] a_sig_p;
reg [(pmi_datab_width-1):0] b_sig_reg;
reg [(pmi_datab_width-1):0] b_sig_p;
reg [(pmi_dataa_width-1):0] a_sig_s_0;
reg [(pmi_dataa_width-1):0] a_sig_s_1;
reg [(pmi_datab_width-1):0] b_sig_s_0;
reg [(pmi_datab_width-1):0] b_sig_s_1;
reg signeda_reg1, signeda_p1;
reg signedb_reg1, signedb_p1;
reg [(pmi_dataa_width-1):0] a_sig_gen;
reg [(pmi_datab_width-1):0] b_sig_gen;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] a_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] b_sig_m;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig_o[pmi_additional_pipeline-1:0];
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig_ps;
reg [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig_o1, p_sig_o2;
wire [(pmi_dataa_width + pmi_datab_width - 1):0] p_sig_i;
integer j, k;
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
      if (pmi_reg_signeda_clk == "CLK0")
          reg_ctrl_clk_sig_a = CLK0;
      else if (pmi_reg_signeda_clk == "CLK1")
          reg_ctrl_clk_sig_a = CLK1;
      else if (pmi_reg_signeda_clk == "CLK2")
          reg_ctrl_clk_sig_a = CLK2;
      else if (pmi_reg_signeda_clk == "CLK3")
          reg_ctrl_clk_sig_a = CLK3;
    end

    always @(CLK0 or CLK1 or CLK2 or CLK3)
    begin
      if (pmi_reg_signedb_clk == "CLK0")
          reg_ctrl_clk_sig_b = CLK0;
      else if (pmi_reg_signedb_clk == "CLK1")
          reg_ctrl_clk_sig_b = CLK1;
      else if (pmi_reg_signedb_clk == "CLK2")
          reg_ctrl_clk_sig_b = CLK2;
      else if (pmi_reg_signedb_clk == "CLK3")
          reg_ctrl_clk_sig_b = CLK3;
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
      if (pmi_reg_signeda_ce == "CE0")
          reg_ctrl_ce_sig_a = CE0;
      else if (pmi_reg_signeda_ce == "CE1")
          reg_ctrl_ce_sig_a = CE1;
      else if (pmi_reg_signeda_ce == "CE2")
          reg_ctrl_ce_sig_a = CE2;
      else if (pmi_reg_signeda_ce == "CE3")
          reg_ctrl_ce_sig_a = CE3;
    end

    always @(CE0 or CE1 or CE2 or CE3)
    begin
      if (pmi_reg_signedb_ce == "CE0")
          reg_ctrl_ce_sig_b = CE0;
      else if (pmi_reg_signedb_ce == "CE1")
          reg_ctrl_ce_sig_b = CE1;
      else if (pmi_reg_signedb_ce == "CE2")
          reg_ctrl_ce_sig_b = CE2;
      else if (pmi_reg_signedb_ce == "CE3")
          reg_ctrl_ce_sig_b = CE3;
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
      if (pmi_reg_signeda_rst == "RST0")
          reg_ctrl_rst_sig_a = RST0;
      else if (pmi_reg_signeda_rst == "RST1")
          reg_ctrl_rst_sig_a = RST1;
      else if (pmi_reg_signeda_rst == "RST2")
          reg_ctrl_rst_sig_a = RST2;
      else if (pmi_reg_signeda_rst == "RST3")
          reg_ctrl_rst_sig_a = RST3;
    end

    always @(RST0 or RST1 or RST2 or RST3)
    begin
      if (pmi_reg_signedb_rst == "RST0")
          reg_ctrl_rst_sig_b = RST0;
      else if (pmi_reg_signedb_rst == "RST1")
          reg_ctrl_rst_sig_b = RST1;
      else if (pmi_reg_signedb_rst == "RST2")
          reg_ctrl_rst_sig_b = RST2;
      else if (pmi_reg_signedb_rst == "RST3")
          reg_ctrl_rst_sig_b = RST3;
    end

    always @(posedge input_a_clk_sig or posedge input_a_rst_sig)
    begin
      if (input_a_rst_sig == 1'b1)
        begin
          a_sig_reg = 0;
        end
      else if (input_a_ce_sig == 1'b1)
        begin
          a_sig_reg = a_sig_s_1;
        end
    end

    always @(a_sig_s_1 or a_sig_reg)
    begin
      if (pmi_input_reg == "off")
          a_sig_gen = a_sig_s_1;
      else
          a_sig_gen = a_sig_reg;
    end

    always @(posedge input_b_clk_sig or posedge input_b_rst_sig)
    begin
      if (input_b_rst_sig == 1'b1)
        begin
          b_sig_reg = 0;
        end
      else if (input_b_ce_sig == 1'b1)
        begin
          b_sig_reg = b_sig_s_1;
        end
    end

    always @(b_sig_s_1 or b_sig_reg)
    begin
      if (pmi_input_reg == "off")
          b_sig_gen = b_sig_s_1;
      else
          b_sig_gen = b_sig_reg;
    end

    always @(posedge reg_ctrl_clk_sig_a or posedge reg_ctrl_rst_sig_a)
    begin
      if (reg_ctrl_rst_sig_a == 1'b1)
        begin
          signeda_reg1 <= 0;
        end
      else if (reg_ctrl_ce_sig_a == 1'b1)
        begin
          signeda_reg1 <= SignA;
        end
    end

    always @(SignA or signeda_reg1)
    begin
      if (pmi_input_reg == "off")
          signeda_p1 <= SignA;
      else
          signeda_p1 <= signeda_reg1;
    end

    always @(posedge reg_ctrl_clk_sig_b or posedge reg_ctrl_rst_sig_b)
    begin
      if (reg_ctrl_rst_sig_b == 1'b1)
        begin
          signedb_reg1 <= 0;
        end
      else if (reg_ctrl_ce_sig_b == 1'b1)
        begin
          signedb_reg1 <= SignB_new;
        end
    end

    always @(SignB_new or signedb_reg1)
    begin
      if (pmi_input_reg == "off")
          signedb_p1 <= SignB_new;
      else
          signedb_p1 <= signedb_reg1;
    end

    always @(A or SRIA or SourceA)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_a == "shift")
            a_sig_s_1 = SRIA;
         else 
            a_sig_s_1 = A;
      end
      else
      begin 
         if (SourceA == 1'b1)
             a_sig_s_1 = SRIA;
         else if (SourceA == 1'b0)
             a_sig_s_1 = A;
      end
    end

    always @(B or SRIB or SourceB)
    begin
      if (pmi_family == "ECP")
      begin
         if (pmi_source_control_b == "shift")
            b_sig_s_1 = SRIB;
         else 
            b_sig_s_1 = B;
      end
      else
      begin
         if (SourceB == 1'b1)
             b_sig_s_1 = SRIB;
         else if (SourceB == 1'b0)
             b_sig_s_1 = B;
      end
    end

    always @(a_sig_gen or signeda_p1)
    begin
      if (signeda_p1 == 1'b1)
        begin
          a_sig_m = {{(pmi_datab_width){a_sig_gen[(pmi_dataa_width - 1)]}} , a_sig_gen};  
        end
      else
        begin
          a_sig_m[(pmi_dataa_width - 1):0] =  a_sig_gen[(pmi_dataa_width - 1):0];
          a_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_dataa_width] = 0;
        end
    end

    always @(b_sig_gen or signedb_p1)
    begin
      if (signedb_p1 == 1'b1)
        begin
          b_sig_m = {{(pmi_dataa_width){b_sig_gen[(pmi_datab_width - 1)]}} , b_sig_gen};
        end
      else
        begin
          b_sig_m[(pmi_datab_width - 1):0] =  b_sig_gen[(pmi_datab_width - 1):0];
          b_sig_m[(pmi_dataa_width + pmi_datab_width - 1):pmi_datab_width] = 0;
        end
    end

    assign p_sig_i = (!a_sig_m || !b_sig_m)? 0 : a_sig_m * b_sig_m ;

    genvar i;
    generate
       for (i = 0; i <= (pmi_additional_pipeline - 1); i = i + 1) 
       begin : pipeline_reg
          always @(posedge pipeline_clk_sig or posedge pipeline_rst_sig)
          begin
             if (pipeline_rst_sig == 1'b1)
                p_sig_o[i][(pmi_dataa_width + pmi_datab_width - 1):0] <= 0;
             else if (pipeline_ce_sig == 1'b1)
             begin
                p_sig_o[0][(pmi_dataa_width + pmi_datab_width - 1):0] <= p_sig_i;
                for (j = 0; j <= (pmi_additional_pipeline - 2); j = j + 1)
                   p_sig_o[j+1][(pmi_dataa_width + pmi_datab_width - 1):0] <= p_sig_o[j][(pmi_dataa_width + pmi_datab_width - 1):0];
             end
          end
       end
    endgenerate

    always @(p_sig_i or p_sig_o[pmi_additional_pipeline - 1])
    begin
      if (pmi_additional_pipeline == 0)
          p_sig_ps = p_sig_i;
      else
          p_sig_ps = p_sig_o[pmi_additional_pipeline - 1];
    end

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
          p_sig_o1 <= 0;
      else if (output_ce_sig == 1'b1)
          p_sig_o1 <= p_sig_ps;
    end

    always @(p_sig_ps or p_sig_o1)
    begin
      if (pmi_output_reg == "off")
          p_sig = p_sig_ps;
      else
          p_sig = p_sig_o1;
    end

    always @(posedge output_clk_sig or posedge output_rst_sig)
    begin
      if (output_rst_sig == 1'b1)
          p_sig_o2 <= 0;
      else if (output_ce_sig == 1'b1)
          p_sig_o2 <= p_sig;
    end

    always @(p_sig or p_sig_o2)
    begin
      if (pmi_pipelined_mode == "off")
          p_sig2 = p_sig;
      else
      begin
         if ( pmi_dataa_width <= 18 || pmi_datab_width <= 18 ||
              (pmi_dataa_width >= 19 && pmi_dataa_width <= 27 && pmi_datab_width >= 37 && pmi_datab_width <= 45) ||
              (pmi_datab_width >= 19 && pmi_datab_width <= 27 && pmi_dataa_width >= 37 && pmi_dataa_width <= 45) )
            p_sig2 = p_sig;
         else
            p_sig2 = p_sig_o2;
      end
    end

    assign P = p_sig2;

    assign SROA = a_sig_gen;
    assign SROB = b_sig_gen;
//pragma translate_on

endmodule

