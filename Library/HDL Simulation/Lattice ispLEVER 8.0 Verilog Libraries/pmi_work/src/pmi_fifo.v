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
// Simulation Library File for FIFO Dual Clock PMI Block
//
// Parameter Definition
//Name                        Value                             Default
/*
-------------------------------------------------------------------------
pmi_data_width              <integer>                                  8
pmi_data_depth              <integer>                                256
pmi_full_flag               <integer>                                256
pmi_empty_flag              <integer>                                  0
pmi_almost_full_flag        <integer>                                252
pmi_almost_empty_flag       <integer>                                  4
pmi_regmode               "reg"|"noreg"                             "reg"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"ECP3"   "EC"
pmi_implementation         "EBR"|"LUT"                              "EBR"
-------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_fifo.v,v 1.2 2005/09/27 19:45:59 rag Exp $

`timescale 1ns / 1ps
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
			  parameter pmi_implementation = "EBR"
		     )

  (input [pmi_data_width-1:0] Data,
   input Clock,
   input WrEn,
   input RdEn,
   input Reset,
   output reg [pmi_data_width-1:0] Q,
   output Empty,
   output Full,
   output AlmostEmpty,
   output AlmostFull)/*synthesis syn_black_box */;

//pragma translate_off
//   tri1       GSR_sig = GSR_INST.GSRNET;
//   tri1       PUR_sig = PUR_INST.PURNET;
//   reg 			      SRN;
   wire RST_sig;

   reg [pmi_data_width-1:0] fifo_mem [pmi_data_depth-1:0];

   reg [pmi_data_width-1:0] Data_reg = 0;
   reg [pmi_data_width-1:0] Q_reg = 0;
   reg [pmi_data_width-1:0] Q_node = 0;
   reg [pmi_data_width-1:0] Q_int = 0;

   integer 		 h;

//function to convert fifo depth to pointer width
/*
function  integer clogb2 (input integer depth);
    begin
        for(clogb2=0;  depth>0;  clogb2=clogb2+1)
              depth=depth>>>1;
    end
 endfunction // clogb2

 localparam pmi_addr_width = (pmi_data_depth > 0) ? clogb2(pmi_data_depth) - 1 : 0;
*/

   localparam pmi_addr_width = 
		(pmi_data_depth == 2) ? 1 : (pmi_data_depth == 4) ? 2 : (pmi_data_depth == 8) ? 3 :
		(pmi_data_depth == 16) ? 4 : (pmi_data_depth == 32) ? 5 : (pmi_data_depth == 64) ? 6 :
		(pmi_data_depth == 128) ? 7 : (pmi_data_depth == 256) ? 8 : (pmi_data_depth == 512) ? 9 :
		(pmi_data_depth == 1024) ? 10 : (pmi_data_depth == 2048) ? 11 : (pmi_data_depth == 4096) ? 12 :
		(pmi_data_depth == 8192) ? 13 : (pmi_data_depth == 16384) ? 14 : (pmi_data_depth == 32768) ? 15 :
		(pmi_data_depth == 65536) ? 16 : 17 ;

   reg [pmi_addr_width:0] wr_pointer = 0;
   reg [pmi_addr_width:0] rd_pointer = 0;
   wire [pmi_addr_width:0] fifo_words_used;

//Task to check if proper fifo depth is set.
   task ec_depth_check (input integer depth);
   begin
	  if (depth > 8192 && pmi_implementation == "LUT")
	  begin
	      $display("\nError! Fifo depth is too large! Maximum Fifo depth can be 8192.");
	      $stop;
	  end
	  else if (depth > 65536 && (pmi_family == "EC" || pmi_family == "XP" || pmi_family == "ECP"))
	  begin
	      $display("\nError! Fifo depth is too large! Maximum Fifo depth can be 65536.");
	      $stop;
	  end
	  else if (depth > 131072)
	  begin
	      $display("\nError! Fifo depth is too large! Maximum Fifo depth can be 131072.");
	      $stop;
	  end
	 
	  if ((depth != 2) && (depth != 4) && (depth != 8) && (depth != 16) && (depth != 32) && (depth != 64)&& (depth != 128) && (depth != 256) && (depth!= 512) && (depth != 1024) && (depth != 2048) && (depth != 4096) && (depth != 8192) && (depth != 16384) && (depth != 32768) && (depth != 65536) && (depth != 131072)/* && (depth != 262144) && (depth != 524288)*/)
	  begin
	      $display("\nError! Fifo depth can only be power of 2!");
	      $stop;
	  end
   end
   endtask // ec_depth_check
 
// Error Checks
   initial begin
      if (pmi_empty_flag != 0)
	begin
	   $display("\nError! Empty Flag must be set to 0!");
	   $stop;
	end

      if (pmi_full_flag !== pmi_data_depth)
	begin
	   $display("\nError! Full Flag must equal the total depth of the FIFO!");
	   $stop;
	end
	 ec_depth_check(pmi_data_depth);
      
   end // initial begin
   
//Initialize the fifo memory
   initial begin
      for (h = 0; h < pmi_data_depth; h = h+1)
      	begin
			  fifo_mem[h] = {pmi_data_width{1'b0}};
        end // for (h = 0; h < pmi_data_depth_w; h = h+1)
      end
   
//Following commented out code for pmi_gsr is for future compatibility
/*   always @ (GSR_sig or PUR_sig ) begin
    if (pmi_gsr == "enable") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (pmi_gsr == "disable")
      SRN = PUR_sig;
   end

   not INST0  (SR1, SRN);
   or  INST1  (RST_sig, Reset, SR1);

 always @(SR1 or Data)
     begin
	if (SR1 == 1)
	  begin
             assign Data_reg = 0;
             assign Q_reg = 0;
	  end
	else
	  begin
             deassign Data_reg;
             deassign Q_reg;
	  end
     end // always @ (SR1 or Data)
*/
   buf INST1 (RST_sig, Reset);

   always @(RST_sig)
     begin
	if (RST_sig == 1)
	  begin
	     assign wr_pointer = 0;
	     assign rd_pointer = 0;
	  end
	else
	  begin
	     deassign wr_pointer;
	     deassign rd_pointer;
	  end
     end
   
//Asynchronous Reset
   
   always @(posedge Clock, posedge RST_sig)
     begin
	if (RST_sig == 1)
	  begin
             Data_reg <= 0;
	  end
	else
	  begin
             if (WrEn == 1 && Full != 1)
               Data_reg <= Data;
	  end
     end // always @ (posedge Clock, posedge RST_sig)

//Write and Read Pointers
   
always @(posedge Clock)
  begin
	if (WrEn == 1)
	  begin
	     if (Full != 1)
	       begin
		  wr_pointer <= wr_pointer + 1;
	       end
	     else
	       begin
		  wr_pointer <= wr_pointer;
	       end
	  end
     end


always @(posedge Clock)
  begin
     if (RdEn == 1)
	  begin
	     if (Empty != 1)
	       rd_pointer <= rd_pointer + 1;
	     else
	       rd_pointer <= rd_pointer;
	  end
     end // always @ (posedge RdClock)
   
   //Write Data into FIFO
   
   always @(Data_reg, wr_pointer)
     begin
	    fifo_mem[wr_pointer%pmi_data_depth] = Data_reg;
     end

   //Read from FIFO
 
  always @(rd_pointer, RST_sig)
    begin
      if (RST_sig == 1'b1)
         Q_node = Q_node;
      else if (RST_sig == 1'b0)
	   begin
	      if (Empty == 0)
				Q_node = fifo_mem[rd_pointer%pmi_data_depth];
	      else
				Q_node = Q_node;
	   end // if (RST_sig == 0)
    end

//Asynchronous Reset   
   always @(posedge RST_sig, posedge Clock)
   begin
	  if (RST_sig == 1)
	  begin
             Q_reg <= 0;
	  end
	  else
	  begin
             if (RdEn == 1)
               Q_reg <= Q_node;
	  end
   end

   always @(Q_reg or Q_node)
     begin
	if (pmi_regmode == "reg")
	  begin
             Q_int = Q_reg;
	  end
	else
	  begin
             Q_int = Q_node;
	  end
     end
   
   always @(Q_int)
     begin
        Q = Q_int ;
     end

// Flag Generation

   assign fifo_words_used = 
	   {wr_pointer[pmi_addr_width] ^ rd_pointer[pmi_addr_width], wr_pointer[pmi_addr_width-1:0]} - {1'b0, rd_pointer[pmi_addr_width-1:0]};

   assign Empty = (fifo_words_used == 0);
   assign AlmostEmpty = (fifo_words_used <= pmi_almost_empty_flag);
   assign Full = (fifo_words_used == pmi_data_depth);
   assign AlmostFull = (fifo_words_used >= pmi_almost_full_flag);
//pragma translate_on

endmodule

