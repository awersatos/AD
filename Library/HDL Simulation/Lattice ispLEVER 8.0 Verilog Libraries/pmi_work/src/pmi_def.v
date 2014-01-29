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
// Synthesis Black Box definition for PMI Blocks
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_def.v,v 1.4 2005/10/14 18:51:55 rag Exp $

module pmi_distributed_dpram 
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_distributed_dpram")

    (
    input [(pmi_addr_width-1):0] WrAddress,
    input [(pmi_data_width-1):0] Data,
    input WrClock,
    input WE,
    input WrClockEn,
    input [(pmi_addr_width-1):0] RdAddress,
    input RdClock,
    input RdClockEn,
    input Reset,
    output [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;

endmodule // pmi_distributed_dpram

module pmi_distributed_rom
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_distributed_rom")
    (
     input [(pmi_addr_width-1):0] Address,
     input OutClock,
     input OutClockEn,
     input Reset,
     output [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;
   
endmodule // pmi_distributed_rom


module pmi_distributed_spram 
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_distributed_spram")

    (
     input [(pmi_addr_width-1):0] Address,
     input [(pmi_data_width-1):0] Data,
     input Clock,
     input ClockEn,
     input WE,
     input Reset,
     output [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;

endmodule // pmi_distributed_spram

module pmi_distributed_shift_reg
  #(parameter pmi_data_width = 16,
    parameter pmi_regmode = "reg",
    parameter pmi_shiftreg_type = "fixed",
    parameter pmi_num_shift = 16,
    parameter pmi_num_width = 4,
    parameter pmi_max_shift = 16,
    parameter pmi_max_width = 4,
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_distributed_shift_reg")
  
    (
     input [(pmi_data_width-1):0] Din,
     input [(pmi_max_width-1):0] Addr,
     input Clock,
     input ClockEn,
     input Reset,
     output [(pmi_data_width-1):0] Q)/*synthesis syn_black_box*/;

endmodule // pmi_distributed_shift_reg

module pmi_constant_mult #(parameter pmi_dataa_width = 8, 
                  parameter pmi_datab_width = 8,
                  parameter module_type = "pmi_constant_mult",
                  parameter pmi_sign = "on",
                  parameter pmi_additional_pipeline = 1,
                  parameter pmi_constant_value = 2,
                  parameter pmi_input_reg = "on",
                  parameter pmi_output_reg = "on",
                  parameter pmi_family = "EC",
                  parameter pmi_implementation = "LUT")

              (input   [(pmi_dataa_width-1):0]  DataA,
               input   Clock, ClkEn, Aclr,
               output  [(pmi_dataa_width + pmi_datab_width - 1):0]  Result)/*synthesis syn_black_box*/;

endmodule // pmi_constant_mult

module pmi_mult #(parameter pmi_dataa_width = 8, 
	       parameter pmi_datab_width = 8,
	       parameter module_type = "pmi_mult",
	       parameter pmi_sign = "on",
	       parameter pmi_additional_pipeline = 1,
	       parameter pmi_input_reg = "on",
	       parameter pmi_output_reg = "on",
	       parameter pmi_family = "EC",
	       parameter pmi_implementation = "LUT")

	      (input   [(pmi_dataa_width-1):0]  DataA,
	       input   [(pmi_datab_width-1):0]  DataB,
	       input   Clock, ClkEn, Aclr,
	       output  [(pmi_dataa_width + pmi_datab_width - 1):0]  Result)/*synthesis syn_black_box*/;

endmodule // pmi_mult

module pmi_mac #(parameter pmi_dataa_width = 8,
	       parameter pmi_datab_width = 8,
	       parameter pmi_accum_width = 32,
	       parameter module_type = "pmi_mac",
	       parameter pmi_sign = "on",
	       parameter pmi_additional_pipeline = 1,
	       parameter pmi_add_sub = "add",
	       parameter pmi_input_reg = "on",
	       parameter pmi_family = "EC",
	       parameter pmi_implementation = "LUT")

	      (input   [(pmi_dataa_width - 1):0]  DataA,
	       input   [(pmi_datab_width - 1):0]  DataB,
	       input   Clock, ClkEn, Aclr,
	       output  [(pmi_accum_width - 1):0]  Result)/*synthesis syn_black_box*/;

endmodule // pmi_mac

module pmi_multaddsub #(parameter pmi_dataa_width = 8, 
	       parameter pmi_datab_width = 8,
	       parameter module_type = "pmi_multaddsub",
	       parameter pmi_sign = "on",
	       parameter pmi_additional_pipeline = 1,
	       parameter pmi_add_sub = "add",
	       parameter pmi_input_reg = "on",
	       parameter pmi_output_reg = "on",
	       parameter pmi_family = "EC",
	       parameter pmi_implementation = "LUT")

	      (input   [(pmi_dataa_width-1):0]  DataA0,
	       input   [(pmi_dataa_width-1):0]  DataA1,
	       input   [(pmi_datab_width-1):0]  DataB0,
	       input   [(pmi_datab_width-1):0]  DataB1,
	       input   Clock, ClkEn, Aclr,
	       output  [(pmi_dataa_width + pmi_datab_width):0]  Result)/*synthesis syn_black_box*/;

endmodule // pmi_multaddsub

module pmi_multaddsubsum #(parameter pmi_dataa_width = 8, 
	       parameter pmi_datab_width = 8,
	       parameter module_type = "pmi_multaddsubsum",
	       parameter pmi_sign = "on",
	       parameter pmi_additional_pipeline = 1,
	       parameter pmi_add_sub0 = "add",
	       parameter pmi_add_sub1 = "add",
	       parameter pmi_input_reg = "on",
	       parameter pmi_output_reg = "on",
	       parameter pmi_family = "EC",
	       parameter pmi_implementation = "LUT")

	      (input   [(pmi_dataa_width-1):0]  DataA0,
	       input   [(pmi_dataa_width-1):0]  DataA1,
	       input   [(pmi_dataa_width-1):0]  DataA2,
	       input   [(pmi_dataa_width-1):0]  DataA3,
	       input   [(pmi_datab_width-1):0]  DataB0,
	       input   [(pmi_datab_width-1):0]  DataB1,
	       input   [(pmi_datab_width-1):0]  DataB2,
	       input   [(pmi_datab_width-1):0]  DataB3,
	       input   Clock, ClkEn, Aclr,
	       output  [(pmi_dataa_width + pmi_datab_width + 1):0]  Result)/*synthesis syn_black_box*/;

endmodule // pmi_multaddsubsum

module pmi_complex_mult #(parameter pmi_dataa_width = 8,
	       parameter pmi_datab_width = 8,
	       parameter module_type = "pmi_complex_mult",
	       parameter pmi_sign = "on",
	       parameter pmi_additional_pipeline = 1,
	       parameter pmi_input_reg = "on",
	       parameter pmi_output_reg = "on",
	       parameter pmi_family = "EC",
	       parameter pmi_mult_mode = 3,
	       parameter pmi_implementation = "LUT")

	      (input   [(pmi_dataa_width-1):0]  DataA_Re,
	       input   [(pmi_dataa_width-1):0]  DataA_Im,
	       input   [(pmi_datab_width-1):0]  DataB_Re,
	       input   [(pmi_datab_width-1):0]  DataB_Im,
	       input   Clock, ClkEn, Aclr,
	       output  [(pmi_dataa_width + pmi_datab_width):0]  Result_Re,
	       output  [(pmi_dataa_width + pmi_datab_width):0]  Result_Im)/*synthesis syn_black_box*/;

endmodule // pmi_complex_mult

module pmi_add 
  #(parameter pmi_data_width = 8,
    parameter pmi_result_width = 8,
    parameter pmi_sign = "off",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_add"
    )

    (
     input [pmi_data_width-1:0] DataA,
     input [pmi_data_width-1:0] DataB,
     input Cin,
     output [pmi_data_width-1:0] Result,
     output Cout,
     output Overflow)/*synthesis syn_black_box */;
endmodule // pmi_add

module pmi_sub 
  #(parameter pmi_data_width = 8,
    parameter pmi_result_width = 8,
    parameter pmi_sign = "off",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_sub"
    )
    
    (
     input [pmi_data_width-1:0] DataA,
     input [pmi_data_width-1:0] DataB,
     input Cin,
     output [pmi_data_width-1:0] Result,
     output Cout,
     output Overflow)/*synthesis syn_black_box */;
endmodule // pmi_sub

module pmi_counter 
  #(parameter pmi_data_width = 8,
    parameter pmi_updown = "up",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_counter"
    )

  (
   input Clock,
   input Clk_En,
   input Aclr,
   input UpDown,
   output [pmi_data_width-1:0] Q)/*synthesis syn_black_box */;
endmodule // pmi_counter

module pmi_addsub #(parameter pmi_data_width = 8,
		    parameter pmi_result_width = 8,
		    parameter pmi_sign = "off",
		    parameter pmi_family = "EC",
		    parameter module_type = "pmi_addsub"
		    )
  
  (
   input [pmi_data_width-1:0] DataA,
   input [pmi_data_width-1:0] DataB,
   input Cin,
   input Add_Sub,
   output [pmi_data_width-1:0] Result,
   output Cout,
   output Overflow)/*synthesis syn_black_box */;
endmodule // pmi_addsub

module pmi_ram_dp
  #(parameter pmi_wr_addr_depth = 512,
    parameter pmi_wr_addr_width = 9,
    parameter pmi_wr_data_width = 18,
    parameter pmi_rd_addr_depth = 512,
    parameter pmi_rd_addr_width = 9,
    parameter pmi_rd_data_width = 18,
    parameter pmi_regmode = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_ram_dp")
    
    (input [(pmi_wr_data_width-1):0] Data,
     input [(pmi_wr_addr_width-1):0] WrAddress,
     input [(pmi_rd_addr_width-1):0] RdAddress,
     input  WrClock,
     input  RdClock,
     input  WrClockEn,
     input  RdClockEn,
     input  WE,
     input  Reset,
     output [(pmi_rd_data_width-1):0]  Q);/*synthesis syn_black_box */

endmodule // pmi_ram_dp

module pmi_ram_dp_true
  #(parameter pmi_addr_depth_a = 512,
    parameter pmi_addr_width_a = 9,
    parameter pmi_data_width_a = 18,
    parameter pmi_addr_depth_b = 512,
    parameter pmi_addr_width_b = 9,
    parameter pmi_data_width_b = 18,
    parameter pmi_regmode_a = "reg",
    parameter pmi_regmode_b = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_write_mode_a = "normal",
    parameter pmi_write_mode_b = "normal",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_ram_dp_true")
  
    (input [(pmi_data_width_a-1):0]	DataInA,
     input [(pmi_data_width_b-1):0]	DataInB,
     input [(pmi_addr_width_a-1):0] AddressA,
     input [(pmi_addr_width_b-1):0] AddressB,
     input  ClockA,
     input  ClockB,
     input  ClockEnA,
     input  ClockEnB,
     input  WrA,
     input  WrB,
     input  ResetA,
     input  ResetB,
     output [(pmi_data_width_a-1):0]  QA,
     output [(pmi_data_width_b-1):0]  QB)/*synthesis syn_black_box */;
   
endmodule // pmi_ram_dp_true

module pmi_ram_dq
  #(parameter pmi_addr_depth = 512,
    parameter pmi_addr_width = 9,
    parameter pmi_data_width = 18,
    parameter pmi_regmode = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_write_mode = "normal",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_ram_dq")
    
    (input [(pmi_data_width-1):0]	Data,
     input [(pmi_addr_width-1):0] Address,
     input  Clock,
     input  ClockEn,
     input  WE,
     input  Reset,
     output [(pmi_data_width-1):0]  Q)/*synthesis syn_black_box*/;
   
endmodule // pmi_ram_dq

module pmi_rom
  #(parameter pmi_addr_depth = 512,
    parameter pmi_addr_width = 9,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_gsr = "disable",
    parameter pmi_resetmode = "sync",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_rom")

    (input [(pmi_addr_width-1):0]	Address,
     input OutClock,
     input OutClockEn,
     input Reset,
     output [(pmi_data_width-1):0] Q)/*synthesis syn_black_box*/;

endmodule // pmi_rom

module pmi_fifo_dc #(
		     parameter pmi_data_width_w = 18,
		     parameter pmi_data_width_r = 18,
		     parameter pmi_data_depth_w = 256,
		     parameter pmi_data_depth_r = 256,
		     parameter pmi_full_flag = 256,
		     parameter pmi_empty_flag = 0,
		     parameter pmi_almost_full_flag = 252,
		     parameter pmi_almost_empty_flag = 4,
		     parameter pmi_regmode = "reg",
		     parameter pmi_resetmode = "async",
		     parameter pmi_family = "EC" ,
		     parameter module_type = "pmi_fifo_dc",
			  parameter pmi_implementation = "EBR"
		     )

  (input  [pmi_data_width_w-1:0] Data,
   input WrClock,
   input RdClock,
   input WrEn,
   input RdEn,
   input Reset,
   input RPReset,
   output [pmi_data_width_r-1:0] Q,
   output Empty,
   output Full,
   output AlmostEmpty,
   output AlmostFull)/*synthesis syn_black_box */;

endmodule // pmi_fifo_dc

module pmi_fifo #(
		     parameter pmi_data_width = 8,
		     parameter pmi_data_depth = 256,
		     parameter pmi_full_flag = 256,
		     parameter pmi_empty_flag = 0,
		     parameter pmi_almost_full_flag = 252,
		     parameter pmi_almost_empty_flag = 4,
		     parameter pmi_regmode = "reg",
		     parameter pmi_family = "EC" ,
		     parameter module_type = "pmi_fifo",
			  parameter pmi_implementation = "EBR")

  (input  [pmi_data_width-1:0] Data,
   input Clock,
   input WrEn,
   input RdEn,
   input Reset,
   output [pmi_data_width-1:0] Q,
   output Empty,
   output Full,
   output AlmostEmpty,
   output AlmostFull)/*synthesis syn_black_box */;

endmodule // pmi_fifo

module pmi_dsp_mac #(
parameter pmi_dataa_width = 8,
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
   output [17:0]  SROB)/*synthesis syn_black_box */;

endmodule // pmi_dsp_mac

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
   output [17:0]  SROB)/*synthesis syn_black_box */;

endmodule //pmi_dsp_mult

module pmi_dsp_multaddsub
 #(parameter pmi_dataa_width = 8,
   parameter pmi_datab_width = 8,
   parameter pmi_additional_pipeline = 0,
   parameter pmi_input_reg = "on",
   parameter pmi_output_reg = "on",
   parameter pmi_family = "ECP2",
   parameter pmi_gsr = "enable",
   parameter pmi_source_control_a0 = "parallel",
   parameter pmi_source_control_a1 = "parallel",
   parameter pmi_source_control_b0 = "parallel",
   parameter pmi_source_control_b1 = "parallel",
   parameter pmi_reg_inputa0_clk = "CLK0",
   parameter pmi_reg_inputa0_ce = "CE0",
   parameter pmi_reg_inputa0_rst = "RST0",
   parameter pmi_reg_inputa1_clk = "CLK0",
   parameter pmi_reg_inputa1_ce = "CE0",
   parameter pmi_reg_inputa1_rst = "RST0",
   parameter pmi_reg_inputb0_clk = "CLK0",
   parameter pmi_reg_inputb0_ce = "CE0",
   parameter pmi_reg_inputb0_rst = "RST0",
   parameter pmi_reg_inputb1_clk = "CLK0",
   parameter pmi_reg_inputb1_ce = "CE0",
   parameter pmi_reg_inputb1_rst = "RST0",
   parameter pmi_reg_pipeline0_clk = "CLK0",
   parameter pmi_reg_pipeline0_ce = "CE0",
   parameter pmi_reg_pipeline0_rst = "RST0",
   parameter pmi_reg_pipeline1_clk = "CLK0",
   parameter pmi_reg_pipeline1_ce = "CE0",
   parameter pmi_reg_pipeline1_rst = "RST0",
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
   parameter module_type = "pmi_dsp_multaddsub")

  (input [(pmi_dataa_width-1):0]       A0, A1,
   input [(pmi_datab_width-1):0]       B0, B1,
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
   input ShiftB0,
   input ShiftB1,
   input ADDNSUB,
   output [(pmi_dataa_width + pmi_datab_width):0]  SUM,
   output [17:0]  SROA,
   output [17:0]  SROB)/*synthesis syn_black_box */;

endmodule // pmi_dsp_multaddsub

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
   parameter module_type = "pmi_dsp_multaddsubsum")

  (input [(pmi_dataa_width-1):0]       A0, A1, A2, A3,
   input [(pmi_datab_width-1):0]       B0, B1, B2, B3,
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
   output [17:0]  SROB)/*synthesis syn_black_box */;

endmodule //pmi_dsp_multaddsubsum

module pmi_pll
 #(parameter pmi_freq_clki = 100,
   parameter pmi_freq_clkfb = 100,
   parameter pmi_freq_clkop = 100,
   parameter pmi_freq_clkos = 100,
   parameter pmi_freq_clkok = 100,
   parameter pmi_family = "SC",
   parameter pmi_phase_adj = 0,
   parameter pmi_duty_cycle = 50,
   parameter pmi_clkfb_source = "CLKOP",
   parameter pmi_fdel = "off",     // ECP2 Only
   parameter pmi_fdel_val = 0,
   parameter module_type = "pmi_pll")

  (input       CLKI,
   input       CLKFB,
   input       RESET,
   output      CLKOP,
   output      CLKOS,
   output      CLKOK,
   output      CLKOK2,
   output      LOCK)/*synthesis syn_black_box */;

endmodule //pmi_pll


