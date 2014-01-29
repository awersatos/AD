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
// Simulation Library File for PMI MultAddSubSum
//
// Paramater Definition
//Name                           Value                                 Default
/*
------------------------------------------------------------------------------
 pmi_dataa_width              <integer>                                    8
 pmi_datab_width              <integer>                                    8
 pmi_sign                     "on"|"off"                                  "on"
 pmi_additional_pipeline      <integer>                                    1
 pmi_add_sub0                 "add"|"sub"                                 "add"
 pmi_add_sub1                 "add"|"sub"                                 "add"
 pmi_input_reg                "on"|"off"                                  "on"
 pmi_output_reg               "on"|"off"                                  "on"
 pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"  "EC"
 pmi_implementation           "DSP"|"LUT"                                "LUT"
------------------------------------------------------------------------------
Note: 
 
1. To get a non pipelined multiplier, set pmi_additional_pipeline to 0 and
   tie the ports Aclr and Clock to LO and port ClkEn to HI.

2. To get a pipelined multiplier, set pmi_additional_pipeline to a positive
   integer (desired number of pipelined stages) and make appropriate
   connections to the ports Clock, ClkEn, Aclr.
   
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/ 
 
// $Header: /home/rel01/env5_1p.38/verilog/pkg/versclibs/data/pmi/RCS/pmi_mult.v,v 1.9 2005/10/14 18:51:30 rag Exp $

`timescale 1 ns / 1 ps

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

//synopsys translate_off
tri0  Aclr_wire;
tri0  Clock_wire;
tri1  ClkEn_wire;
//synopsys translate_on

buf (Aclr_wire, Aclr);
buf (Clock_wire, Clock);
buf (ClkEn_wire, ClkEn);

reg  [(pmi_dataa_width + pmi_datab_width + 1):0]  Result_reg;
assign Result = Result_reg;

reg  [(pmi_dataa_width - 1):0]  DataA0_reg, DataA1_reg, DataA2_reg, DataA3_reg;
reg  [(pmi_datab_width - 1):0]  DataB0_reg, DataB1_reg, DataB2_reg, DataB3_reg;
wire [(pmi_dataa_width + pmi_datab_width - 1):0]  Mult1_out, Mult2_out, Mult3_out, Mult4_out;
//wire [(pmi_dataa_width + pmi_datab_width):0]  Add1_out, Add2_out;
wire [(pmi_dataa_width + pmi_datab_width + 1):0]  Add1_out, Add2_out; //add extra sign/zero extension
wire [(pmi_dataa_width + pmi_datab_width + 1):0]  Result_wire;

initial
begin
   if (pmi_implementation == "DSP")
   begin
      if ( (pmi_family == "SC") || (pmi_family == "SCM") || (pmi_family == "XO") ||
           (pmi_family == "EC") || (pmi_family == "XP") )
      begin
         $display("\nError! The %s family doesn't support DSP implementations.", pmi_family);
         $stop;
      end

      if (pmi_additional_pipeline > 1)
      begin
         $display("\nError! # of PL stages must be 0 or 1 for DSP implementations.");
         $stop;
      end
   end
end

generate
	if (pmi_input_reg == "on")
		always @(posedge Clock_wire or posedge Aclr_wire)
		begin
			if (Aclr_wire == 1'b1)
			begin
				DataA0_reg <= {((pmi_dataa_width)){1'b0}};
				DataA1_reg <= {((pmi_dataa_width)){1'b0}};
				DataA2_reg <= {((pmi_dataa_width)){1'b0}};
				DataA3_reg <= {((pmi_dataa_width)){1'b0}};
				DataB0_reg <= {((pmi_datab_width)){1'b0}};
				DataB1_reg <= {((pmi_datab_width)){1'b0}};
				DataB2_reg <= {((pmi_datab_width)){1'b0}};
				DataB3_reg <= {((pmi_datab_width)){1'b0}};
			end
			else
				if (ClkEn_wire == 1'b1)
				begin
					DataA0_reg <= DataA0;
					DataA1_reg <= DataA1;
					DataA2_reg <= DataA2;
					DataA3_reg <= DataA3;
					DataB0_reg <= DataB0;
					DataB1_reg <= DataB1;
					DataB2_reg <= DataB2;
					DataB3_reg <= DataB3;
				end
		end // always @ (posedge Clock or posedge Aclr)
	else
		always @(DataA0 or DataA1 or DataA2 or DataA3 or DataB0 or DataB1 or DataB2 or DataB3)
		begin
			DataA0_reg <= DataA0;
			DataA1_reg <= DataA1;
			DataA2_reg <= DataA2;
			DataA3_reg <= DataA3;
			DataB0_reg <= DataB0;
			DataB1_reg <= DataB1;
			DataB2_reg <= DataB2;
			DataB3_reg <= DataB3;
		end
endgenerate

generate
	if (pmi_output_reg == "on")
		always @(posedge Clock_wire or posedge Aclr_wire)
		begin
			if (Aclr_wire == 1'b1)
				Result_reg <= {((pmi_dataa_width + pmi_datab_width + 2)){1'b0}};
			else
				if (ClkEn_wire == 1'b1)
					Result_reg <= Result_wire;
		end // always @ (posedge Clock or posedge Aclr)
	else
		always @(Result_wire)
		begin
			Result_reg <= Result_wire;
		end
endgenerate

//pragma translate_off
generate
	if (pmi_sign == "on" && pmi_additional_pipeline == 0)
	begin
		MultSign #(pmi_dataa_width, pmi_datab_width) sign1_inst (.SA(DataA0_reg), .SB(DataB0_reg),
			.sproduct(Mult1_out));
		MultSign #(pmi_dataa_width, pmi_datab_width) sign2_inst (.SA(DataA1_reg), .SB(DataB1_reg),
			.sproduct(Mult2_out));
		MultSign #(pmi_dataa_width, pmi_datab_width) sign3_inst (.SA(DataA2_reg), .SB(DataB2_reg),
			.sproduct(Mult3_out));
		MultSign #(pmi_dataa_width, pmi_datab_width) sign4_inst (.SA(DataA3_reg), .SB(DataB3_reg),
			.sproduct(Mult4_out));
	end
	else if (pmi_sign == "off" && pmi_additional_pipeline == 0)
	begin
		MultUnSign #(pmi_dataa_width, pmi_datab_width) unsign1_inst (.UA(DataA0_reg), .UB(DataB0_reg),
			.uproduct(Mult1_out));
		MultUnSign #(pmi_dataa_width, pmi_datab_width) unsign2_inst (.UA(DataA1_reg), .UB(DataB1_reg),
			.uproduct(Mult2_out));
		MultUnSign #(pmi_dataa_width, pmi_datab_width) unsign3_inst (.UA(DataA2_reg), .UB(DataB2_reg),
			.uproduct(Mult3_out));
		MultUnSign #(pmi_dataa_width, pmi_datab_width) unsign4_inst (.UA(DataA3_reg), .UB(DataB3_reg),
			.uproduct(Mult4_out));
	end
	else if (pmi_sign == "on" && pmi_additional_pipeline != 0)
	begin
		MultSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) psign1_inst (
			.PSA(DataA0_reg), .PSB(DataB0_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire),
			.PSAclr(Aclr_wire),.psproduct(Mult1_out));
		MultSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) psign2_inst (
			.PSA(DataA1_reg), .PSB(DataB1_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire),
			.PSAclr(Aclr_wire),.psproduct(Mult2_out));
		MultSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) psign3_inst (
			.PSA(DataA2_reg), .PSB(DataB2_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire),
			.PSAclr(Aclr_wire),.psproduct(Mult3_out));
		MultSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) psign4_inst (
			.PSA(DataA3_reg), .PSB(DataB3_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire),
			.PSAclr(Aclr_wire),.psproduct(Mult4_out));
	end
	else
	begin
		MultUnSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) punsign1_inst (
			.PUA(DataA0_reg), .PUB(DataB0_reg), .PUClock(Clock_wire), .PUClkEn(ClkEn_wire),
			.PUAclr(Aclr_wire),.puproduct(Mult1_out));
		MultUnSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) punsign2_inst (
			.PUA(DataA1_reg), .PUB(DataB1_reg), .PUClock(Clock_wire), .PUClkEn(ClkEn_wire),
			.PUAclr(Aclr_wire),.puproduct(Mult2_out));
		MultUnSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) punsign3_inst (
			.PUA(DataA2_reg), .PUB(DataB2_reg), .PUClock(Clock_wire), .PUClkEn(ClkEn_wire),
			.PUAclr(Aclr_wire),.puproduct(Mult3_out));
		MultUnSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) punsign4_inst (
			.PUA(DataA3_reg), .PUB(DataB3_reg), .PUClock(Clock_wire), .PUClkEn(ClkEn_wire),
			.PUAclr(Aclr_wire),.puproduct(Mult4_out));
	end
endgenerate	
//pragma translate_on

//pragma translate_off
generate
/*
	if (pmi_sign == "on")
	begin
		if (pmi_add_sub0 == "add")
			AddSign #(pmi_dataa_width+pmi_datab_width + 1) sign_add1_inst (
				.SA({Mult1_out[pmi_dataa_width+pmi_datab_width-1], Mult1_out}),
				.SB({Mult2_out[pmi_dataa_width+pmi_datab_width-1], Mult2_out}), .ssum(Add1_out));
		else
			SubSign #(pmi_dataa_width+pmi_datab_width + 1) sign_sub1_inst (
				.SA({Mult1_out[pmi_dataa_width+pmi_datab_width-1], Mult1_out}),
				.SB({Mult2_out[pmi_dataa_width+pmi_datab_width-1], Mult2_out}), .ssum(Add1_out));
		if (pmi_add_sub1 == "add")
			AddSign #(pmi_dataa_width+pmi_datab_width + 1) sign_add2_inst (
				.SA({Mult3_out[pmi_dataa_width+pmi_datab_width-1], Mult3_out}),
				.SB({Mult4_out[pmi_dataa_width+pmi_datab_width-1], Mult4_out}), .ssum(Add2_out));
		else
			SubSign #(pmi_dataa_width+pmi_datab_width + 1) sign_sub2_inst (
				.SA({Mult3_out[pmi_dataa_width+pmi_datab_width-1], Mult3_out}),
				.SB({Mult4_out[pmi_dataa_width+pmi_datab_width-1], Mult4_out}), .ssum(Add2_out));
		AddSign #(pmi_dataa_width+pmi_datab_width + 2) sign_add3_inst (
			.SA({Add1_out[pmi_dataa_width+pmi_datab_width], Add1_out}),
			.SB({Add2_out[pmi_dataa_width+pmi_datab_width], Add2_out}), .ssum(Result_wire));
	end
	else
	begin
		if (pmi_add_sub0 == "add")
			AddUnSign #(pmi_dataa_width+pmi_datab_width + 1) unsign_add1_inst (.UA({1'b0, Mult1_out}),
				.UB({1'b0, Mult2_out}), .usum(Add1_out));
		else
			SubUnSign #(pmi_dataa_width+pmi_datab_width + 1) unsign_sub1_inst (.UA({1'b0, Mult1_out}),
				.UB({1'b0, Mult2_out}), .usum(Add1_out));
		if (pmi_add_sub1 == "add")
			AddUnSign #(pmi_dataa_width+pmi_datab_width + 1) unsign_add2_inst (.UA({1'b0, Mult3_out}),
				.UB({1'b0, Mult4_out}), .usum(Add2_out));
		else
			SubUnSign #(pmi_dataa_width+pmi_datab_width + 1) unsign_sub2_inst (.UA({1'b0, Mult3_out}),
				.UB({1'b0, Mult4_out}), .usum(Add2_out));
		AddUnSign #(pmi_dataa_width+pmi_datab_width + 2) unsign_add3_inst (.UA({1'b0, Add1_out}),
			.UB({1'b0, Add2_out}), .usum(Result_wire));
	end
*/
// Add extra sign/zero extension to allow consistency with hardware for *illegal* unsigned subtractions
	if (pmi_sign == "on")
	begin
		if (pmi_add_sub0 == "add")
			AddSign #(pmi_dataa_width+pmi_datab_width + 2) sign_add1_inst (
				.SA({{2{Mult1_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult1_out}),
				.SB({{2{Mult2_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult2_out}), .ssum(Add1_out));
		else
			SubSign #(pmi_dataa_width+pmi_datab_width + 2) sign_sub1_inst (
				.SA({{2{Mult1_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult1_out}),
				.SB({{2{Mult2_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult2_out}), .ssum(Add1_out));
		if (pmi_add_sub1 == "add")
			AddSign #(pmi_dataa_width+pmi_datab_width + 2) sign_add2_inst (
				.SA({{2{Mult3_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult3_out}),
				.SB({{2{Mult4_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult4_out}), .ssum(Add2_out));
		else
			SubSign #(pmi_dataa_width+pmi_datab_width + 2) sign_sub2_inst (
				.SA({{2{Mult3_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult3_out}),
				.SB({{2{Mult4_out[pmi_dataa_width+pmi_datab_width-1]}}, Mult4_out}), .ssum(Add2_out));
		AddSign #(pmi_dataa_width+pmi_datab_width + 2) sign_add3_inst (
			.SA(Add1_out), .SB(Add2_out), .ssum(Result_wire));
	end
	else
	begin
		if (pmi_add_sub0 == "add")
			AddUnSign #(pmi_dataa_width+pmi_datab_width + 2) unsign_add1_inst (
				.UA({2'b00, Mult1_out}), .UB({2'b00, Mult2_out}), .usum(Add1_out));
		else
			SubUnSign #(pmi_dataa_width+pmi_datab_width + 2) unsign_sub1_inst (
				.UA({2'b00, Mult1_out}), .UB({2'b00, Mult2_out}), .usum(Add1_out));
		if (pmi_add_sub1 == "add")
			AddUnSign #(pmi_dataa_width+pmi_datab_width + 2) unsign_add2_inst (
				.UA({2'b00, Mult3_out}), .UB({2'b00, Mult4_out}), .usum(Add2_out));
		else
			SubUnSign #(pmi_dataa_width+pmi_datab_width + 2) unsign_sub2_inst (
				.UA({2'b00, Mult3_out}), .UB({2'b00, Mult4_out}), .usum(Add2_out));
		AddUnSign #(pmi_dataa_width+pmi_datab_width + 2) unsign_add3_inst (
			.UA(Add1_out), .UB(Add2_out), .usum(Result_wire));
	end
endgenerate	
//pragma translate_on
endmodule

//SubModules

`ifndef PMI_MULT_SUPPORT
`define PMI_MULT_SUPPORT

module MultSign 
  #(parameter pmi_dataa_width = 8, 
    parameter pmi_datab_width = 8,
    parameter module_type = "Mult")
   (input   signed [(pmi_dataa_width-1):0]  SA,
    input   signed [(pmi_datab_width-1):0]  SB,
    output  signed [(pmi_dataa_width + pmi_datab_width - 1):0]  sproduct)/*synthesis syn_black_box*/; 
//synopsys translate_off
   assign   sproduct = SA * SB;
//synopsys translate_on
endmodule

module MultUnSign 
  #(parameter pmi_dataa_width = 8, 
    parameter pmi_datab_width = 8,
    parameter module_type = "Mult")
   (input   [(pmi_dataa_width-1):0]  UA,
    input   [(pmi_datab_width-1):0]  UB,
    output  [(pmi_dataa_width + pmi_datab_width - 1):0]  uproduct)/*synthesis syn_black_box*/; 
//synopsys translate_off
assign uproduct = UA * UB;
//synopsys translate_on
endmodule

module MultUnSignPipe 
  #(parameter pmi_dataa_width = 8, 
    parameter pmi_datab_width = 8,
    parameter pmi_pl = 1,
    parameter module_type = "Mult")
   (input   [(pmi_dataa_width-1):0]  PUA,
    input   [(pmi_datab_width-1):0]  PUB,
    input   PUClock, PUClkEn, PUAclr,
    output  [(pmi_dataa_width + pmi_datab_width - 1):0]  puproduct)/*synthesis syn_black_box*/;
//synopsys translate_off       
wire [(pmi_dataa_width + pmi_datab_width - 1):0] pg = PUA * PUB;
   
reg  [(pmi_dataa_width + pmi_datab_width - 1):0] p_pipe[pmi_pl-1:0];
   
integer 	 i, j;

initial begin
	for (i = 0; i <= pmi_pl-1; i = i + 1)	  
		p_pipe[i][(pmi_dataa_width + pmi_datab_width - 1):0] <= {((pmi_dataa_width + pmi_datab_width)){1'b0}};
end

always @(posedge PUClock or posedge PUAclr)
begin
	if (PUAclr == 1'b1)
	begin
		for (i = 0; i <= pmi_pl-1; i = i + 1)	  
			p_pipe[i][(pmi_dataa_width + pmi_datab_width - 1):0] <= {((pmi_dataa_width + pmi_datab_width)){1'b0}};
	end
	else
		if (PUClkEn == 1'b1) 
		begin
			p_pipe[0][(pmi_dataa_width + pmi_datab_width - 1):0] <= pg;
			for (j = 0; j <= pmi_pl-2; j = j + 1)
				p_pipe[j+1][(pmi_dataa_width + pmi_datab_width - 1):0] <= p_pipe[j][(pmi_dataa_width + pmi_datab_width - 1):0];
		end
end // always @ (posedge Clock or posedge Aclr)
   
assign puproduct = p_pipe[pmi_pl-1];
//synopsys translate_on
endmodule

module MultSignPipe 
  #(parameter pmi_dataa_width = 8, 
    parameter pmi_datab_width = 8,
    parameter pmi_pl = 1,
    parameter module_type = "Mult")
    (input signed [(pmi_dataa_width-1):0]  PSA,
     input signed  [(pmi_datab_width-1):0]  PSB,
     input 	PSClock, PSClkEn, PSAclr,
     output signed [(pmi_dataa_width + pmi_datab_width - 1):0]  psproduct)/*synthesis syn_black_box*/;
//synopsys translate_off       
wire signed [(pmi_dataa_width + pmi_datab_width - 1):0] pg = PSA * PSB;
   
reg signed [(pmi_dataa_width + pmi_datab_width - 1):0] p_pipe[pmi_pl-1:0];
   
integer 	 i, j;

initial begin
	for (i = 0; i <= pmi_pl-1; i = i + 1)	  
		p_pipe[i][(pmi_dataa_width + pmi_datab_width - 1):0] <= {((pmi_dataa_width + pmi_datab_width)){1'b0}};
end

always @(posedge PSClock or posedge PSAclr)
begin
	if (PSAclr == 1'b1)
	begin
		for (i = 0; i <= pmi_pl-1; i = i + 1)	  
			p_pipe[i][(pmi_dataa_width + pmi_datab_width - 1):0] <= {((pmi_dataa_width + pmi_datab_width)){1'b0}};
	end
	else
		if (PSClkEn == 1'b1) 
		begin
			p_pipe[0][(pmi_dataa_width + pmi_datab_width - 1):0] <= pg;
			for (j = 0; j <= pmi_pl-2; j = j + 1)
				p_pipe[j+1][(pmi_dataa_width + pmi_datab_width - 1):0] <= p_pipe[j][(pmi_dataa_width + pmi_datab_width - 1):0];
		end
end // always @ (posedge Clock or posedge Aclr)
   
assign psproduct = p_pipe[pmi_pl-1];
//synopsys translate_on
endmodule

`endif //PMI_MULT_SUPPORT

`ifndef PMI_ADDSUB_SUPPORT
`define PMI_ADDSUB_SUPPORT

module AddSign 
  #(parameter pmi_data_width = 8, 
    parameter module_type = "Add")
   (input   signed [(pmi_data_width-1):0]  SA,
    input   signed [(pmi_data_width-1):0]  SB,
    output  signed [(pmi_data_width - 1):0]  ssum)/*synthesis syn_black_box*/; 
//synopsys translate_off
   assign   ssum = SA + SB;
//synopsys translate_on
endmodule

module AddUnSign 
  #(parameter pmi_data_width = 8, 
    parameter module_type = "Add")
   (input   [(pmi_data_width-1):0]  UA,
    input   [(pmi_data_width-1):0]  UB,
    output  [(pmi_data_width - 1):0]  usum)/*synthesis syn_black_box*/; 
//synopsys translate_off
assign usum = UA + UB;
//synopsys translate_on
endmodule

module SubSign 
  #(parameter pmi_data_width = 8, 
    parameter module_type = "Sub")
   (input   signed [(pmi_data_width-1):0]  SA,
    input   signed [(pmi_data_width-1):0]  SB,
    output  signed [(pmi_data_width - 1):0]  ssum)/*synthesis syn_black_box*/; 
//synopsys translate_off
   assign   ssum = SA - SB;
//synopsys translate_on
endmodule

module SubUnSign 
  #(parameter pmi_data_width = 8, 
    parameter module_type = "Sub")
   (input   [(pmi_data_width-1):0]  UA,
    input   [(pmi_data_width-1):0]  UB,
    output  [(pmi_data_width - 1):0]  usum)/*synthesis syn_black_box*/; 
//synopsys translate_off
assign usum = UA - UB;
//synopsys translate_on
endmodule

`endif //PMI_ADDSUB_SUPPORT

