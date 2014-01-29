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
// Simulation Library File for PMI Complex Multiplier
//
// Paramater Definition
//Name                           Value                                 Default
/*
------------------------------------------------------------------------------
 pmi_dataa_width              <integer>                                    8
 pmi_datab_width              <integer>                                    8
 pmi_sign                     "on"|"off"                                  "on"
 pmi_additional_pipeline      <integer>                                    1
 pmi_input_reg                "on"|"off"                                  "on"
 pmi_output_reg               "on"|"off"                                  "on"
 pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"  "EC"
 pmi_mult_mode                 3 to 4                               3
 pmi_implementation           "DSP"|"LUT"                                "LUT"
------------------------------------------------------------------------------
Note:
 
1. To get a non-pipelined multiplier, set pmi_additional_pipeline to 0 and
   tie the ports Aclr and Clock to LO and port ClkEn to HI.

2. To get a pipelined multiplier, set pmi_additional_pipeline to a positive
   integer (desired number of pipelined stages) and make appropriate
   connections to the ports Clock, ClkEn, Aclr.
   
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
*/

`timescale 1 ns / 1 ps

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

      if (pmi_additional_pipeline > 3)
      begin
         $display("\nError! # of PL stages must be from 0 to 3 for DSP implementations.");
         $stop;
      end
   end
end

     MultAddSub #(.pmi_dataa_width(pmi_dataa_width),
                  .pmi_datab_width(pmi_datab_width),
                  .pmi_sign(pmi_sign),
                  .pmi_additional_pipeline(pmi_additional_pipeline),
                  .pmi_add_sub("sub"),
                  .pmi_input_reg(pmi_input_reg),
                  .pmi_output_reg(pmi_output_reg)
                 )
         inst_re (.DataA0(DataA_Re),
                  .DataA1(DataA_Im),
                  .DataB0(DataB_Re),
                  .DataB1(DataB_Im),
                  .Clock(Clock),
                  .ClkEn(ClkEn),
                  .Aclr(Aclr),
                  .Result(Result_Re)
                 );

     MultAddSub #(.pmi_dataa_width(pmi_dataa_width),
                  .pmi_datab_width(pmi_datab_width),
                  .pmi_sign(pmi_sign),
                  .pmi_additional_pipeline(pmi_additional_pipeline),
                  .pmi_add_sub("add"),
                  .pmi_input_reg(pmi_input_reg),
                  .pmi_output_reg(pmi_output_reg)
                 )
         inst_im (.DataA0(DataA_Im),
                  .DataA1(DataA_Re),
                  .DataB0(DataB_Re),
                  .DataB1(DataB_Im),
                  .Clock(Clock),
                  .ClkEn(ClkEn),
                  .Aclr(Aclr),
                  .Result(Result_Im)
                 );
endmodule


//Supporting modules

module MultAddSub #(parameter pmi_dataa_width = 8, 
	      	  parameter pmi_datab_width = 8,
	      	  parameter pmi_sign = "on",
	      	  parameter pmi_additional_pipeline = 1,
	      	  parameter pmi_add_sub = "add",
	      	  parameter pmi_input_reg = "on",
	      	  parameter pmi_output_reg = "on")

	      (input   [(pmi_dataa_width-1):0]  DataA0,
	       input   [(pmi_dataa_width-1):0]  DataA1,
	       input   [(pmi_datab_width-1):0]  DataB0,
	       input   [(pmi_datab_width-1):0]  DataB1,
	       input   Clock, ClkEn, Aclr,
	       output  [(pmi_dataa_width + pmi_datab_width):0]  Result)/*synthesis syn_black_box*/;

//synopsys translate_off
tri0  Aclr_wire;
tri0  Clock_wire;
tri1  ClkEn_wire;
//synopsys translate_on

buf (Aclr_wire, Aclr);
buf (Clock_wire, Clock);
buf (ClkEn_wire, ClkEn);

reg   [(pmi_dataa_width + pmi_datab_width):0]  Result_reg;
assign Result = Result_reg;

reg  [(pmi_dataa_width - 1):0]  DataA0_reg, DataA1_reg;
reg  [(pmi_datab_width - 1):0]  DataB0_reg, DataB1_reg;
wire [(pmi_dataa_width + pmi_datab_width - 1):0]  Mult1_out, Mult2_out;
wire  [(pmi_dataa_width + pmi_datab_width):0]  Result_wire;

generate
	if (pmi_input_reg == "on")
		always @(posedge Clock_wire or posedge Aclr_wire)
		begin
			if (Aclr_wire == 1'b1)
			begin
				DataA0_reg <= {((pmi_dataa_width)){1'b0}};
				DataA1_reg <= {((pmi_dataa_width)){1'b0}};
				DataB0_reg <= {((pmi_datab_width)){1'b0}};
				DataB1_reg <= {((pmi_datab_width)){1'b0}};
			end
			else
				if (ClkEn_wire == 1'b1)
				begin
					DataA0_reg <= DataA0;
					DataA1_reg <= DataA1;
					DataB0_reg <= DataB0;
					DataB1_reg <= DataB1;
				end
		end // always @ (posedge Clock or posedge Aclr)
	else
		always @(DataA0 or DataA1 or DataB0 or DataB1)
		begin
			DataA0_reg <= DataA0;
			DataA1_reg <= DataA1;
			DataB0_reg <= DataB0;
			DataB1_reg <= DataB1;
		end
endgenerate

generate
	if (pmi_output_reg == "on")
		always @(posedge Clock_wire or posedge Aclr_wire)
		begin
			if (Aclr_wire == 1'b1)
				Result_reg <= {((pmi_dataa_width + pmi_datab_width + 1)){1'b0}};
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
	end
	else if (pmi_sign == "off" && pmi_additional_pipeline == 0)
	begin
		MultUnSign #(pmi_dataa_width, pmi_datab_width) unsign1_inst (.UA(DataA0_reg), .UB(DataB0_reg),
			.uproduct(Mult1_out));
		MultUnSign #(pmi_dataa_width, pmi_datab_width) unsign2_inst (.UA(DataA1_reg), .UB(DataB1_reg),
			.uproduct(Mult2_out));
	end
	else if (pmi_sign == "on" && pmi_additional_pipeline != 0)
	begin
		MultSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) psign1_inst (
			.PSA(DataA0_reg), .PSB(DataB0_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire),
			.PSAclr(Aclr_wire),.psproduct(Mult1_out));
		MultSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) psign2_inst (
			.PSA(DataA1_reg), .PSB(DataB1_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire),
			.PSAclr(Aclr_wire),.psproduct(Mult2_out));
	end
	else
	begin
		MultUnSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) punsign1_inst (
			.PUA(DataA0_reg), .PUB(DataB0_reg), .PUClock(Clock_wire), .PUClkEn(ClkEn_wire),
			.PUAclr(Aclr_wire),.puproduct(Mult1_out));
		MultUnSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) punsign2_inst (
			.PUA(DataA1_reg), .PUB(DataB1_reg), .PUClock(Clock_wire), .PUClkEn(ClkEn_wire),
			.PUAclr(Aclr_wire),.puproduct(Mult2_out));
	end
endgenerate	
//pragma translate_on

//pragma translate_off
generate
	if (pmi_sign == "on" && pmi_add_sub == "add")
		AddSign #(pmi_dataa_width+pmi_datab_width + 1) sign_add_inst (
			.SA({Mult1_out[pmi_dataa_width+pmi_datab_width-1], Mult1_out}),
			.SB({Mult2_out[pmi_dataa_width+pmi_datab_width-1], Mult2_out}), .ssum(Result_wire));
	else if (pmi_sign == "off" && pmi_add_sub == "add")
		AddUnSign #(pmi_dataa_width+pmi_datab_width + 1) unsign_add_inst (.UA({1'b0, Mult1_out}),
			.UB({1'b0, Mult2_out}), .usum(Result_wire));
	else if (pmi_sign == "on" && pmi_add_sub == "sub")
		SubSign #(pmi_dataa_width+pmi_datab_width + 1) sign_sub_inst (
			.SA({Mult1_out[pmi_dataa_width+pmi_datab_width-1], Mult1_out}),
			.SB({Mult2_out[pmi_dataa_width+pmi_datab_width-1], Mult2_out}), .ssum(Result_wire));
	else
		SubUnSign #(pmi_dataa_width+pmi_datab_width + 1) unsign_sub_inst (.UA({1'b0, Mult1_out}),
			.UB({1'b0, Mult2_out}), .usum(Result_wire));
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

