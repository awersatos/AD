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
// Simulation Library File for PMI Adder
//
// Paramater Definition
//Name                         Value                                   Default
/*
------------------------------------------------------------------------------
 pmi_data_width               <integer>                                    8
 pmi_result_width             <integer>                                    8
 pmi_sign                     "on"|"off"                                 "off"
 pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"  "EC"
------------------------------------------------------------------------------
Note: 
 
 1. Cin should be tied to LO if Carry-in is not being used.
 
 2. To get an adder without Cout or Overflow, leave Cout and Overflow ports
    unconnected.
 
 3. For signed adder, Overflow ports should be used; Cout port should be left
    unconneced.
 
 4. For unsigned adder, Carry port should be used; Overflow port should be 
    left unconnected.

WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/ 
 
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_add.v,v 1.3 2005/09/14 21:10:23 rag Exp $

`timescale 1 ns / 1 ps
module pmi_add #(parameter pmi_data_width = 8,
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

   //synopsys translate_off
   tri0   Cin_wire;
   //synopsys translate_on

   buf (Cin_wire, Cin);

   //pragma translate_off
   generate
      if (pmi_sign == "off")
      pmi_add_unsign #(.pmi_data_width(pmi_data_width),
		       .pmi_result_width(pmi_result_width)
		       )
      unsign_inst (
		   .DataA(DataA),
		   .DataB(DataB),
		   .Cin(Cin_wire),
		   .Result(Result),
		   .Cout(Cout)
		   );
      else
      pmi_add_sign #(.pmi_data_width(pmi_data_width),
		     .pmi_result_width(pmi_result_width)
		     )
      sign_inst (
		 .DataA(DataA),
		   .DataB(DataB),
		   .Cin(Cin_wire),
		   .Result(Result),
		   .Overflow(Overflow)
		 );
   endgenerate
   //pragma translate_on

endmodule // pmi_add

//SubModules

module pmi_add_unsign #(parameter pmi_data_width = 8,
			parameter pmi_result_width = 8)
  (
   input [pmi_data_width-1:0] DataA,
   input [pmi_data_width-1:0] DataB,
   input Cin,
   output [pmi_data_width-1:0] Result,
   output Cout);

   assign {Cout, Result} = DataA + DataB + Cin;
   
endmodule // pmi_add_unsign

module pmi_add_sign #(parameter pmi_data_width = 8,
		      parameter pmi_result_width = 8)
  (
   input [pmi_data_width-1:0] DataA,
   input [pmi_data_width-1:0] DataB,
   input Cin,
   output [pmi_data_width-1:0] Result,
   output Overflow);
   
   wire [pmi_data_width-1:0] tmp_Result = DataA + DataB + Cin;
   
   assign 		     Overflow = (DataA[pmi_data_width-1] == DataB[pmi_data_width-1]) && (DataA[pmi_data_width-1] != tmp_Result[pmi_data_width-1]) ? 1:0;
   
   assign 		     Result = tmp_Result[pmi_data_width-1:0];
      
endmodule // pmi_add_sign


