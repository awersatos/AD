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
// Simulation Library File for PMI Counter
//
// Paramater Definition
//    Name                      Value                                  Default
/*
------------------------------------------------------------------------------
 pmi_data_width               <integer>                                    8
 pmi_updown             "up"|"down"|"updown"                              "up"
 pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"  "EC"
------------------------------------------------------------------------------
Note: 
 
  1. For Count UP, UpDown port should be tied to HI.

  2. For Count DOWN, UpDown port should be tied to LO.
 
  3. The parameter pmi_updown must be set to appropriate value in a top
     level design that instantiates this block.
 
  4. For SC/M families, only "up" and "down" are valid values for pmi_updown.
 
  5. for SC/M families, pmi_data_width ranges from 1 to 256.
     For all other families, the range is from 1 to 64.

WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/ 
 
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_counter.v,v 1.1 2005/08/15 13:05:22 rag Exp $

`timescale 1 ns / 1 ps
module pmi_counter
  #(
    parameter pmi_data_width = 8,
    parameter pmi_updown = "up",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_counter")
   (
    input Clock,
    input Clk_En,
    input Aclr,
    input UpDown,
    output reg [pmi_data_width-1:0] Q)/*synthesis syn_black_box */;

//pragma translate_off
   initial
	  if ((pmi_family == "SC" || pmi_family == "SCM") && pmi_updown != "up" &&  pmi_updown != "down")
	  begin
	    $display("The UpDown mode is not support for SC/M families!");
	    $stop;
	  end

   always @(posedge Clock, posedge Aclr)
   begin
	  if (Aclr)
	    Q <= 0;
	  else
	  begin
	    if (Clk_En == 1)
	    begin
		   if (pmi_updown == "up")
				Q <= Q + 1'b1;
			else if (pmi_updown == "down")
				Q <= Q - 1'b1;
	      else if (UpDown == 1)
				Q <= Q + 1'b1;
	      else if (UpDown == 0)
				Q <= Q - 1'b1;
	    end
	  end // else: !if(Aclr)
   end // always @ (posedge Clock, posedge Aclr)
//pragma translate_on

endmodule // pmi_counter

