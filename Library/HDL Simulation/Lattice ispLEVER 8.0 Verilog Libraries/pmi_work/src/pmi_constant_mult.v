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
// Simulation Library File for PMI Constant Multiplier
//
// Paramater Definition
//    Name                      Value                                  Default
/*
------------------------------------------------------------------------------
 pmi_dataa_width              <integer>                                    8
 pmi_datab_width              <integer>                                    8
 pmi_sign                     "on"|"off"                                  "on"
 pmi_additional_pipeline      <integer>                                    1
 pmi_constant_value           <integer>                                    2
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

3. Mixed-sign multiplication is allowed. pmi_sign represents the sign for DataA,
   while pmi_constant_value becomes unsigned when having a positive value (thus
   reducing Result's width by one bit) and signed when having a negative value.
   
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/ 
 
// $Header: 

`timescale 1 ns / 1 ps

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

//synopsys translate_off
tri0  Aclr_wire;
tri0  Clock_wire;
tri1  ClkEn_wire;
//synopsys translate_on

buf (Aclr_wire, Aclr);
buf (Clock_wire, Clock);
buf (ClkEn_wire, ClkEn);

reg   [(pmi_dataa_width + pmi_datab_width - 1):0]  Result_reg;
assign Result = Result_reg;

reg   [(pmi_dataa_width-1):0]  DataA_reg;
reg   [(pmi_datab_width-1):0]  DataB_reg = pmi_constant_value;
wire  [(pmi_dataa_width + pmi_datab_width - 1):0]  Result_wire;
wire  dummy_bit;

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
				DataA_reg <= 0;
			end
			else
				if (ClkEn_wire == 1'b1)
				begin
					DataA_reg <= DataA;
				end
		end // always @ (posedge Clock or posedge Aclr)
	else
		always @(DataA)
		begin
			DataA_reg <= DataA;
		end
endgenerate

generate
	if (pmi_output_reg == "on")
		always @(posedge Clock_wire or posedge Aclr_wire)
		begin
			if (Aclr_wire == 1'b1)
				Result_reg <= 0;
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
	if (pmi_sign == "on" && pmi_additional_pipeline == 0 && pmi_constant_value <= 0)
		MultSign #(pmi_dataa_width, pmi_datab_width) sign_inst (.SA(DataA_reg), .SB(DataB_reg), .sproduct(Result_wire));
	else if (pmi_sign == "on" && pmi_additional_pipeline == 0 && pmi_constant_value > 0)
		MultSign #(pmi_dataa_width, pmi_datab_width+1) sign_inst1 (.SA(DataA_reg), .SB({1'b0, DataB_reg}), .sproduct({dummy_bit, Result_wire}));
	else if (pmi_sign == "off" && pmi_additional_pipeline == 0 && pmi_constant_value >= 0)
		MultUnSign #(pmi_dataa_width, pmi_datab_width) unsign_inst (.UA(DataA_reg), .UB(DataB_reg), .uproduct(Result_wire));
	else if (pmi_sign == "off" && pmi_additional_pipeline == 0 && pmi_constant_value < 0)
		MultSign #(pmi_dataa_width+1, pmi_datab_width) unsign_inst1 (.SA({1'b0, DataA_reg}), .SB(DataB_reg), .sproduct({dummy_bit, Result_wire}));
	else if (pmi_sign == "on" && pmi_additional_pipeline != 0 && pmi_constant_value <= 0)
		MultSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) psign_inst (.PSA(DataA_reg), .PSB(DataB_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire), .PSAclr(Aclr_wire),.psproduct(Result_wire));
	else if (pmi_sign == "on" && pmi_additional_pipeline != 0 && pmi_constant_value > 0)
		MultSignPipe #(pmi_dataa_width, pmi_datab_width+1, pmi_additional_pipeline) psign_inst1 (.PSA(DataA_reg), .PSB({1'b0, DataB_reg}), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire), .PSAclr(Aclr_wire),.psproduct({dummy_bit, Result_wire}));
	else if (pmi_sign == "off" && pmi_additional_pipeline != 0 && pmi_constant_value >= 0)
		MultUnSignPipe #(pmi_dataa_width, pmi_datab_width, pmi_additional_pipeline) punsign_inst (.PUA(DataA_reg), .PUB(DataB_reg), .PUClock(Clock_wire), .PUClkEn(ClkEn_wire), .PUAclr(Aclr_wire),.puproduct(Result_wire));
	else if (pmi_sign == "off" && pmi_additional_pipeline != 0 && pmi_constant_value < 0)
		MultSignPipe #(pmi_dataa_width+1, pmi_datab_width, pmi_additional_pipeline) punsign_inst1 (.PSA({1'b0, DataA_reg}), .PSB(DataB_reg), .PSClock(Clock_wire), .PSClkEn(ClkEn_wire), .PSAclr(Aclr_wire),.psproduct({dummy_bit, Result_wire}));
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

