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
// Simulation Library File for Distributed RAM Shift Register PMI Block
//
// Parameter Definition
//Name                  Value                                          Default
/*
------------------------------------------------------------------------------
pmi_data_width          <integer>                                         16
pmi_shiftreg_type       "fixed"|"lossless"|"variable"                  "fixed"
pmi_num_shift           <integer>                                         16
pmi_num_width           <integer>                                          4
pmi_max_shift           <integer>                                         16
pmi_max_width           <integer>                                          4
pmi_regmode             "reg"|"noreg"                                    "reg"
pmi_init_file           <string>                                        "none"
pmi_init_file_format    "binary"|"hex"                                "binary"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"   "EC"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
 redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_distributed_shift_reg.v,v 1.4 2005/09/28 14:37:38 rag Exp $

`timescale 1ns/1ps
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

//pragma translate_off
   generate
      if (pmi_shiftreg_type == "fixed")
	
	pmi_distributed_shift_reg_fixed #(
				       .pmi_data_width(pmi_data_width),
				       .pmi_regmode(pmi_regmode),
				       .pmi_shiftreg_type(pmi_shiftreg_type),
				       .pmi_num_shift(pmi_num_shift),
				       .pmi_num_width(pmi_num_width),
				       .pmi_init_file(pmi_init_file),
				       .pmi_init_file_format(pmi_init_file_format),
				       .pmi_family(pmi_family)
				       )
       
	  instfixed (.Din(Din),
		     .Clock(Clock),
		     .ClockEn(ClockEn),
		     .Reset(Reset),
		     .Q(Q)
	);
      else if (pmi_shiftreg_type == "lossless")
	pmi_distributed_shift_reg_lossless #(
					.pmi_data_width(pmi_data_width),
					.pmi_regmode(pmi_regmode),
					.pmi_shiftreg_type(pmi_shiftreg_type),
					.pmi_max_shift(pmi_max_shift),
					.pmi_max_width(pmi_max_width),
					.pmi_init_file(pmi_init_file),
					.pmi_init_file_format(pmi_init_file_format),
					.pmi_family(pmi_family)
					)
	  
	  instlossless (.Din(Din),
		   .Addr(Addr),
		   .Clock(Clock),
		   .ClockEn(ClockEn),
		   .Reset(Reset),
		   .Q(Q)
		   );
      else //if (pmi_shiftreg_type == "variable")
	pmi_distributed_shift_reg_lossy #(
					.pmi_data_width(pmi_data_width),
					.pmi_regmode(pmi_regmode),
					.pmi_shiftreg_type(pmi_shiftreg_type),
					.pmi_max_shift(pmi_max_shift),
					.pmi_max_width(pmi_max_width),
					.pmi_init_file(pmi_init_file),
					.pmi_init_file_format(pmi_init_file_format),
					.pmi_family(pmi_family)
					)
	  
	  instlossy (.Din(Din),
		   .Addr(Addr),
		   .Clock(Clock),
		   .ClockEn(ClockEn),
		   .Reset(Reset),
		   .Q(Q)
		   );
   endgenerate
//pragma translate_on

endmodule // pmi_distributed_shift_reg

//Submodules
     
module pmi_distributed_shift_reg_fixed
  #(parameter pmi_data_width = 16,
    parameter pmi_regmode = "reg",
    parameter pmi_shiftreg_type = "fixed",
    parameter pmi_num_shift = 16,
    parameter pmi_num_width = 4,
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC")
  
    (
     input [(pmi_data_width-1):0] Din,
     input Clock,
     input ClockEn,
     input Reset,
     output [(pmi_data_width-1):0] Q)/*synthesis syn_black_box*/;

//pragma translate_off
   reg [pmi_num_width-1:0] 	   address = 0;
 				   
   always @(posedge Clock)
     begin
	if (Reset == 1'b1)
	  address <= 0;
	else if (ClockEn == 1'b1)
	  begin
	     address <= (address == pmi_num_shift-1) ? 0 : address+1;
	  end
     end

   pmi_distributed_spram #(
		      .pmi_addr_depth(pmi_num_shift),
		      .pmi_addr_width(pmi_num_width),
		      .pmi_data_width(pmi_data_width),
		      .pmi_regmode(pmi_regmode),
		      .pmi_init_file(pmi_init_file),
		      .pmi_init_file_format(pmi_init_file_format),
		      .pmi_family(pmi_family)
		      )

		   instspr
		   (
		    .Address(address),
		    .Data(Din),
		    .Clock(Clock),
		    .ClockEn(ClockEn),
		    .WE(~Reset),
		    .Reset(Reset),
		    .Q(Q)
		    );
//pragma translate_on

endmodule // pmi_distributed_shift_reg_fixed

module pmi_distributed_shift_reg_lossless
  #(parameter pmi_data_width = 16,
    parameter pmi_regmode = "reg",
    parameter pmi_shiftreg_type = "var",
    parameter pmi_max_shift = 16,
    parameter pmi_max_width = 4,
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC")
  
    (
     input [(pmi_data_width-1):0] Din,
     input [(pmi_max_width-1):0] Addr,
     input Clock,
     input ClockEn,
     input Reset,
     output [(pmi_data_width-1):0] Q)/*synthesis syn_black_box*/;

//pragma translate_off
	  reg [pmi_max_width-1:0] waddr = 0;
	  reg [pmi_max_width-1:0] raddr = 0;
 				   
   always @(posedge Clock)
	begin
	 if (Reset == 1'b1)
	    waddr <= 0;
	 else if (ClockEn == 1'b1)
      begin
		  waddr <= (waddr >= (pmi_max_shift-1)) ? 0 : waddr+1;
      end
	end

   always @ (Addr, waddr, ClockEn)
	begin
	 if (ClockEn == 1'b1)
      raddr = waddr-Addr-1;
	end

	pmi_distributed_dpram #(
		      .pmi_addr_depth(pmi_max_shift),
		      .pmi_addr_width(pmi_max_width),
		      .pmi_data_width(pmi_data_width),
		      .pmi_regmode(pmi_regmode),
		      .pmi_init_file(pmi_init_file),
		      .pmi_init_file_format(pmi_init_file_format),
		      .pmi_family(pmi_family)
		      )

		   instspr
		   (
		    .WrAddress(waddr),
		    .Data(Din),
		    .WrClock(Clock),
		    .WE(~Reset),
		    .WrClockEn(ClockEn),
			 .RdAddress(raddr),
		    .RdClock(Clock),
		    .RdClockEn(ClockEn),
		    .Reset(Reset),
		    .Q(Q)
		    );
//pragma translate_on

endmodule


module pmi_distributed_shift_reg_lossy
  #(parameter pmi_data_width = 16,
    parameter pmi_regmode = "reg",
    parameter pmi_shiftreg_type = "var",
    parameter pmi_max_shift = 16,
    parameter pmi_max_width = 4,
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC")
  
    (
     input [(pmi_data_width-1):0] Din,
     input [(pmi_max_width-1):0] Addr,
     input Clock,
     input ClockEn,
     input Reset,
     output [(pmi_data_width-1):0] Q)/*synthesis syn_black_box*/;

//pragma translate_off
     reg [pmi_max_width-1:0] address = 0;
 				   
     always @(posedge Clock)
	begin
	 if (Reset == 1'b1)
	  address <= 0;
	 else if (ClockEn == 1'b1)
	   if (Addr == 0)
	     address <= 0;
	   else
	     begin
		address <= (address >= (Addr)) ? 0 : address+1;
	     end
	end

pmi_distributed_spram #(
		      .pmi_addr_depth(pmi_max_shift),
		      .pmi_addr_width(pmi_max_width),
		      .pmi_data_width(pmi_data_width),
		      .pmi_regmode(pmi_regmode),
		      .pmi_init_file(pmi_init_file),
		      .pmi_init_file_format(pmi_init_file_format),
		      .pmi_family(pmi_family)
		      )

		   instspr
		   (
		    .Address(address),
		    .Data(Din),
		    .Clock(Clock),
		    .ClockEn(ClockEn),
		    .WE(~Reset),
		    .Reset(Reset),
		    .Q(Q)
		    );
//pragma translate_on

endmodule // pmi_distributed_shift_reg_lossy

