// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2008 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Foore Court
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
//Name                        Value                                    Default
/*
------------------------------------------------------------------------------
pmi_data_width_w            <integer>                                      18
pmi_data_width_r            <integer>                                      18
pmi_data_depth_w            <integer>                                     256
pmi_data_depth_r            <integer>                                     256
pmi_full_flag               <integer>                                     256
pmi_empty_flag              <integer>                                       0
pmi_almost_full_flag        <integer>                                     252
pmi_almost_empty_flag       <integer>                                       4
pmi_regmode               "reg"|"noreg"                                  "reg"
pmi_resetmode             "async"|"sync"                               "async"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"   "EC"
pmi_implementation         "EBR"|"LUT"                                   "EBR"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.

NOTE: The purpose of RPReset (Read Point Reset) is to indicate a retransmit, 
and it is more commonly used in "packetized" communications. In this 
application, the user must keep careful track of when the packet is written 
into or read from fifo.

RPReset does not affect the write port, nor any data that has been written 
into the fifo.  However, using RPReset imposes two restrictions on the write 
operation:

  - Packet size must not exceed the maximum FIFO depth.

  - The write pointer should be reset (using Reset) before writing each new 
    packet to replace the previous one.

 
These restrictions prevent the read and write pointers from recirculating 
around the address space and back to location 0 at any time during packet 
storage.  Such a pointer wraparound would lose the packet's original starting
point from which to retransmit.  These restrictions are only required when 
using the retransmit function.

*/
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_fifo_dc.v,v 1.7 2005/10/05 18:44:27 rag Exp $

`timescale 1ns / 1ps
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
   output reg [pmi_data_width_r-1:0] Q = 0,
   output Empty,
   output Full,
   output AlmostEmpty,
   output AlmostFull)/*synthesis syn_black_box */;

//pragma translate_off
   localparam pmi_array_size_w = pmi_data_width_w * pmi_data_depth_w;
   localparam pmi_array_size_r = pmi_data_width_r * pmi_data_depth_r;

   localparam r_w_ratio = pmi_data_width_w/pmi_data_width_r;
   localparam w_r_ratio = pmi_data_width_r/pmi_data_width_w;
   
//   tri1       GSR_sig = GSR_INST.GSRNET;
//   tri1       PUR_sig = PUR_INST.PURNET;
//   reg 			      SRN;
   wire RST_sig, RPRST_sig;

   reg [pmi_array_size_w-1:0] fifo_mem = {pmi_array_size_w{1'b0}};

   reg [pmi_data_width_w-1:0] Data_reg = 0;
   reg [pmi_data_width_w-1:0] Data_reg_sync = 0;
   reg [pmi_data_width_w-1:0] Data_reg_async = 0;
   reg [pmi_data_width_r-1:0] Q_reg = 0;
   reg [pmi_data_width_r-1:0] Q_reg_sync = 0;
   reg [pmi_data_width_r-1:0] Q_reg_async = 0;
   reg [pmi_data_width_r-1:0] Q_node = 0;
   reg [pmi_data_width_r-1:0] Q_int = 0;

   localparam pmi_addr_width_w = 
		(pmi_data_depth_w == 2) ? 1 : (pmi_data_depth_w == 4) ? 2 : (pmi_data_depth_w == 8) ? 3 :
		(pmi_data_depth_w == 16) ? 4 : (pmi_data_depth_w == 32) ? 5 : (pmi_data_depth_w == 64) ? 6 :
		(pmi_data_depth_w == 128) ? 7 : (pmi_data_depth_w == 256) ? 8 : (pmi_data_depth_w == 512) ? 9 :
		(pmi_data_depth_w == 1024) ? 10 : (pmi_data_depth_w == 2048) ? 11 : (pmi_data_depth_w == 4096) ? 12 :
		(pmi_data_depth_w == 8192) ? 13 : (pmi_data_depth_w == 16384) ? 14 : (pmi_data_depth_w == 32768) ? 15 :
		(pmi_data_depth_w == 65536) ? 16 : 17 ;

   localparam pmi_addr_width_r = 
		(pmi_data_depth_r == 2) ? 1 : (pmi_data_depth_r == 4) ? 2 : (pmi_data_depth_r == 8) ? 3 :
		(pmi_data_depth_r == 16) ? 4 : (pmi_data_depth_r == 32) ? 5 : (pmi_data_depth_r == 64) ? 6 :
		(pmi_data_depth_r == 128) ? 7 : (pmi_data_depth_r == 256) ? 8 : (pmi_data_depth_r == 512) ? 9 :
		(pmi_data_depth_r == 1024) ? 10 : (pmi_data_depth_r == 2048) ? 11 : (pmi_data_depth_r == 4096) ? 12 :
		(pmi_data_depth_r == 8192) ? 13 : (pmi_data_depth_r == 16384) ? 14 : (pmi_data_depth_r == 32768) ? 15 :
		(pmi_data_depth_r == 65536) ? 16 : 17 ;

   localparam bit_ptr_extra_width_w = 
		(pmi_data_width_w == 1) ? 0 : (pmi_data_width_w == 2) ? 1 : (pmi_data_width_w <= 4) ? 2 :
		(pmi_data_width_w <= 8) ? 3: (pmi_data_width_w <= 16) ? 4 : (pmi_data_width_w <= 32) ? 5 :
		(pmi_data_width_w <= 64) ? 6 : (pmi_data_width_w <= 128) ? 7 : 8;

   localparam bit_ptr_width = pmi_addr_width_w + bit_ptr_extra_width_w;

   reg [pmi_addr_width_w:0] wr_pointer = {(pmi_addr_width_w+1){1'b1}};
   reg [pmi_addr_width_r:0] rd_pointer = {(pmi_addr_width_r+1){1'b1}};
   reg [pmi_addr_width_w:0] wr_pointer_sync = {(pmi_addr_width_w+1){1'b1}};
   reg [pmi_addr_width_r:0] rd_pointer_sync = {(pmi_addr_width_r+1){1'b1}};
   reg [pmi_addr_width_w:0] wr_pointer_sync1 = {(pmi_addr_width_w+1){1'b1}}, wr_pointer_sync2 = {(pmi_addr_width_w+1){1'b1}};
   reg [pmi_addr_width_r:0] rd_pointer_sync1 = {(pmi_addr_width_r+1){1'b1}}, rd_pointer_sync2 = {(pmi_addr_width_r+1){1'b1}};

   reg [bit_ptr_width:0] wr_pointer_lsb = 0, rd_pointer_lsb = 0;
   reg [bit_ptr_width:0] wr_pointer_bit = 0, wr_pointer_sync_bit = 0;
   reg [bit_ptr_width:0] rd_pointer_bit = 0, rd_pointer_sync_bit = 0;

   wire [pmi_addr_width_w:0] wr_pointer_1 = wr_pointer + 1;
   wire [pmi_addr_width_r:0] rd_pointer_1 = rd_pointer + 1;

   reg [pmi_addr_width_w:0] wr_pointer_var, wr_pointer_sync_var;
   reg [pmi_addr_width_r:0] rd_pointer_var, rd_pointer_sync_var;

   wire [bit_ptr_width:0] fifo_words_used_syncr, fifo_words_used_syncw;
   wire [bit_ptr_width:0] ae_ptr, empty_ptr, af_ptr, full_ptr;

   integer i, j;

   reg RPRST_reg1 = 0;


//For SC/M
//Task to check if proper fifo depth is set.
   task sc_depth_check (input integer depth_w, depth_r);
      begin
	 if ((depth_w != 2) && (depth_w != 4) && (depth_w != 8) && (depth_w != 16) && (depth_w != 32) && (depth_w != 64)&& (depth_w != 128) && (depth_w != 256) && (depth_w!= 512) && (depth_w != 1024) && (depth_w != 2048) && (depth_w != 4096) && (depth_w != 8192) && (depth_w != 16384) && (depth_w != 32768) && (depth_w != 65536) && (depth_w != 131072))
	   begin
	      $display("\nError! Invalid Write Port Depth!");
	      $display("\nValid values are: 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072.");
	      $stop;
	   end
	 
	 if ((depth_r != 2) && (depth_r != 4) && (depth_r != 8) && (depth_r != 16) && (depth_r != 32) && (depth_r != 64)&& (depth_r != 128) && (depth_r != 256) && (depth_r!= 512) && (depth_r != 1024) && (depth_r != 2048) && (depth_r != 4096) && (depth_r != 8192) && (depth_r != 16384) && (depth_r != 32768) && (depth_r != 65536) && (depth_r != 131072))
	   begin
	      $display("\nError! Invalid Read Port Depth!");
	      $display("\nValid values are: 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072.");
	      $stop;
	   end
      end
   endtask // sc_depth_check

//For XO
//Task to check if proper fifo depth is set.
   task xo_depth_check (input integer depth_w, depth_r);
      begin
	 if ((depth_w != 2) && (depth_w != 4) && (depth_w != 8) && (depth_w != 16) && (depth_w != 32) && (depth_w != 64)&& (depth_w != 128) && (depth_w != 256) && (depth_w!= 512) && (depth_w != 1024) && (depth_w != 2048) && (depth_w != 4096) && (depth_w != 8192) && (depth_w != 16384))
	   begin
	      $display("\nError! Invalid Write Port Depth!");
	      $display("\nValid values are: 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384.");
	      $stop;
	   end
	 
	 if ((depth_r != 2) && (depth_r != 4) && (depth_r != 8) && (depth_r != 16) && (depth_r != 32) && (depth_r != 64)&& (depth_r != 128) && (depth_r != 256) && (depth_r!= 512) && (depth_r != 1024) && (depth_r != 2048) && (depth_r != 4096) && (depth_r != 8192) && (depth_r != 16384))
	   begin
	      $display("\nError! Invalid Read Port Depth!");
	      $display("\nValid values are: 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384.");
	      $stop;
	   end
      end
   endtask // xo_depth_check

//Task to check if Depth * Width are same for read and write ports
   task sc_array_check (input integer array_w, array_r);
      begin
	 if (array_w != array_r)
	   begin
	      $display("\nError! Total value of (Depth * Width) must be the same for read set and write set ports.");
	      $stop;
	   end
      end
   endtask // sc_array_check
   

//For All Other families
//Task to check if proper fifo depth is set.
   task ec_depth_check (input integer depth_w, depth_r, width_w, width_r);
   begin
	  if (depth_w != depth_r)
	  begin
	      $display("\nError! Write Port and Read Port Depths must match for this family or implementation.");
	      $stop;
	  end
	 
	  if (width_w != width_r)
	  begin
	      $display("\nError! Write Port and Read Port Widths must match for this family or implementation.");
	      $stop;
	  end
	 
	  if (depth_w > 8192 && pmi_implementation == "LUT")
	  begin
	      $display("\nError! Fifo depth is too large! Maximum Fifo depth can be 8192.");
	      $stop;
	  end
	  else if (depth_w > 65536 && (pmi_family == "EC" || pmi_family == "XP" || pmi_family == "ECP"))
	  begin
	      $display("\nError! Fifo depth is too large! Maximum Fifo depth can be 65536.");
	      $stop;
	  end
	  else if (depth_w > 131072)
	  begin
	      $display("\nError! Fifo depth is too large! Maximum Fifo depth can be 131072.");
	      $stop;
	  end
	 
	  if ((depth_w != 2) && (depth_w != 4) && (depth_w != 8) && (depth_w != 16) && (depth_w != 32) && (depth_w != 64)&& (depth_w != 128) && (depth_w != 256) && (depth_w!= 512) && (depth_w != 1024) && (depth_w != 2048) && (depth_w != 4096) && (depth_w != 8192) && (depth_w != 16384) && (depth_w != 32768) && (depth_w != 65536) && (depth_w != 131072)/* && (depth_w != 262144) && (depth_w != 524288)*/)
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

      if (pmi_full_flag !== pmi_data_depth_w)
	begin
	   $display("\nError! Full Flag must equal the total depth of the FIFO!");
	   $stop;
	end

      if ( (((pmi_family != "SC") && (pmi_family != "SCM") && (pmi_family != "XO")) || (pmi_implementation == "LUT"))
				&& (pmi_resetmode == "sync") )
	begin
	   $display("\nError! Synchronous Reset is not supported for this family or implementation!");
	   $stop;
	end

      if ( ((pmi_family == "SC") || (pmi_family == "SCM") || (pmi_family == "XO")) && (pmi_implementation == "EBR") ) begin
	 sc_array_check(pmi_array_size_w, pmi_array_size_r);
	 end

      if ( ((pmi_family == "SC") || (pmi_family == "SCM")) && (pmi_implementation == "EBR") ) begin
	 sc_depth_check(pmi_data_depth_w, pmi_data_depth_r);
	 end

      if ( (pmi_family == "XO") && (pmi_implementation == "EBR") ) begin
	 xo_depth_check(pmi_data_depth_w, pmi_data_depth_r);
	 end

      if ( ((pmi_family != "SC") && (pmi_family != "SCM") && (pmi_family != "XO")) || (pmi_implementation == "LUT") ) begin
	 ec_depth_check(pmi_data_depth_w, pmi_data_depth_r, pmi_data_width_w, pmi_data_width_r);
      end

   end // initial begin
   
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
   or  INST2  (RPRST_sig, RPReset, SR1);

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
   buf INST2 (RPRST_sig, RPReset);
   
   always @(posedge WrClock)
     begin
	     RPRST_reg1 <= RPRST_sig;
     end

   always @(RST_sig or RPRST_sig or RPRST_reg1)
     begin
	if (RST_sig == 1)
	  begin
	     assign wr_pointer = {(pmi_addr_width_w+1){1'b1}};
	     assign wr_pointer_sync = {(pmi_addr_width_w+1){1'b1}};
	     assign wr_pointer_sync1 = {(pmi_addr_width_w+1){1'b1}};
	     assign wr_pointer_sync2 = {(pmi_addr_width_w+1){1'b1}};
        assign wr_pointer_lsb = 0;
        assign wr_pointer_bit = 0;
        assign wr_pointer_sync_bit = 0;
	  end
	else
	  begin
	     deassign wr_pointer;
	     deassign wr_pointer_sync;
	     deassign wr_pointer_sync1;
	     deassign wr_pointer_sync2;
        deassign wr_pointer_lsb;
        deassign wr_pointer_bit;
        deassign wr_pointer_sync_bit;
	  end // else: !if(RST_sig == 1)
	
	if (RST_sig == 1 || RPRST_sig == 1)
	  begin
	     assign rd_pointer = {(pmi_addr_width_r+1){1'b1}};
        assign rd_pointer_lsb = 0;
        assign rd_pointer_bit = 0;
	  end
	else
	  begin
	     deassign rd_pointer;
        deassign rd_pointer_lsb;
        deassign rd_pointer_bit;
	  end // else: !if(RPRST_sig == 1 || RST_sig == 1)

	if (RPRST_reg1 == 1 || RST_sig == 1)
	  begin
	     assign rd_pointer_sync = {(pmi_addr_width_r+1){1'b1}};
	     assign rd_pointer_sync1 = {(pmi_addr_width_r+1){1'b1}};
	     assign rd_pointer_sync2 = {(pmi_addr_width_r+1){1'b1}};
	     assign rd_pointer_sync_bit = 0;
	  end
	else
	  begin
	     deassign rd_pointer_sync;
	     deassign rd_pointer_sync1;
	     deassign rd_pointer_sync2;
	     deassign rd_pointer_sync_bit;
	  end
     end 

   //Additional Warning checks for RPRST Usage
/*
   always @(RPRST_sig)
     begin
	if (wr_pointer > pmi_data_depth_w)
	  begin
	     $display("\nWarning! Illegal Operation! RPReset is being asserted when the packet size has exceeded fifo depth!");
	     $display("\nSimulation mismatches are possible at time: %d !", $time);
	     $display("\nPlease refer to the header information of pmi_fifo_dc.v model for proper RPReset usage.");
	  end
     end // always @ (RPRST_sig)
*/

//Asynchronous Reset
   always @(posedge RST_sig or posedge WrClock)
     begin
	if (RST_sig == 1)
	  begin
             Data_reg_async <= 0;
	  end
	else
	  begin
             if (WrEn == 1 && Full != 1)
               Data_reg_async <= Data;
	  end
     end

//Synchronous Reset
   always @(posedge WrClock)
     begin
	if (RST_sig == 1)
	  begin
             Data_reg_sync <= 0;
	  end
	else
	  begin
             if (WrEn == 1 && Full != 1)
               Data_reg_sync <= Data;
	  end
     end

//Choice between Async and Sync Reset   
   always @(Data_reg_sync or Data_reg_async)
     begin
	if (pmi_resetmode == "async")
          Data_reg = Data_reg_async;
	else
          Data_reg = Data_reg_sync;
     end

//Write and Read Pointers

always @(posedge WrClock)
   begin
	if (WrEn == 1)
	  begin
	     if (Full != 1)
	     begin
	       wr_pointer <= wr_pointer_1;
	       wr_pointer_lsb <= (wr_pointer_1 % pmi_data_depth_w) * pmi_data_width_w;
	     end
	  end
   end

always @(posedge RdClock)
   begin
	if (RdEn == 1)
	  begin
	     if (Empty != 1)
	     begin
		    rd_pointer <= rd_pointer_1;
		    rd_pointer_lsb <= (rd_pointer_1 % pmi_data_depth_r) * pmi_data_width_r;
	     end // if (Empty != 1)
	  end // if (RdEn == 1)
   end // always @ (posedge RdClock)


//Synchronization Logic
     
//Sync Write Pointer to Rd Clock
//Delayed by 2 clock cycles for EC based families   
   always @(posedge RdClock)
    if ( ((pmi_family == "SC") || (pmi_family == "SCM") || (pmi_family == "XO")) && (pmi_implementation == "EBR") )
	 begin
	    wr_pointer_sync <= wr_pointer;
	 end
    else begin
	    wr_pointer_sync1 <= wr_pointer;
	    wr_pointer_sync2 <= wr_pointer_sync1;
	    wr_pointer_sync <= wr_pointer_sync2;
    end

//Sync Read Pointer to Wr Clock
//Delayed by 2 clock cycles for EC based families.
//For SC and XO, rd_pointer_sync depends on the adjusted rd_pointer
//which depends on pmi_data_depth_w and pmi_data_depth_r
   
   always @(posedge WrClock)
    if ( ((pmi_family == "SC") || (pmi_family == "SCM") || (pmi_family == "XO")) && (pmi_implementation == "EBR") )
	 begin
	    rd_pointer_sync <= rd_pointer;
	 end
    else begin
	    rd_pointer_sync1 <= rd_pointer;
	    rd_pointer_sync2 <= rd_pointer_sync1;
	    rd_pointer_sync <= rd_pointer_sync2;
    end

   //Write Data into FIFO
   always @(Data_reg, wr_pointer, wr_pointer_lsb)
     begin
		 for (i = 0; i < pmi_data_width_w; i = i + 1)
		   fifo_mem[wr_pointer_lsb + i] = Data_reg[i];
     end

   //Read from FIFO
   always @(rd_pointer, rd_pointer_lsb, posedge RST_sig, posedge RPRST_sig) begin
      if (RST_sig == 1'b1 || RPRST_sig == 1'b1)
        Q_node = 0;
      else if (RST_sig == 0 && RPRST_sig == 0) begin
		  for (j = 0; j < pmi_data_width_r; j = j + 1)
		    Q_node[j] = fifo_mem[rd_pointer_lsb + j];
	   end // if (RST_sig == 0 && RPRST_sig == 0)
   end // always @ (rd_pointer, posedge RST_sig, posedge RPRST_sig)
   
	      
//Asynchronous Reset   
   always @(posedge RST_sig or posedge RPRST_sig or posedge RdClock)
     begin
	if (RST_sig == 1 || RPRST_sig == 1)
	  begin
             Q_reg_async <= 0;
	  end
	else
	  begin
//             if (RdEn == 1)             cr45303
               Q_reg_async <= Q_node;
	  end
     end

//Synchronous Reset   
   always @(posedge RdClock)
     begin
	if (RST_sig == 1 || RPRST_sig == 1)
	  begin
             Q_reg_sync <= 0;
	  end
	else
	  begin
//             if (RdEn == 1)             cr45303
               Q_reg_sync <= Q_node;
	  end
     end

//Choice between Async and Sync Reset      
   always @(Q_reg_sync or Q_reg_async)
     begin
	if (pmi_resetmode == "async")
          Q_reg = Q_reg_async;
	else
          Q_reg = Q_reg_sync;
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


//Flag Generation

  always @(wr_pointer)
  begin
     wr_pointer_var = wr_pointer + 1;
     wr_pointer_bit <= wr_pointer_var * pmi_data_width_w;
  end

  always @(wr_pointer_sync, posedge RPRST_sig, posedge RdClock)
  begin
     if (RPRST_sig == 1)
        wr_pointer_sync_bit <= 0;
     else
     begin
        wr_pointer_sync_var = wr_pointer_sync + 1;
        wr_pointer_sync_bit <= wr_pointer_sync_var * pmi_data_width_w;
     end
  end

  always @(rd_pointer)
  begin
     rd_pointer_var = rd_pointer + 1;
     rd_pointer_bit <= rd_pointer_var * pmi_data_width_r;
  end

  always @(rd_pointer_sync)
  begin
     rd_pointer_sync_var = rd_pointer_sync + 1;
     rd_pointer_sync_bit <= rd_pointer_sync_var * pmi_data_width_r;
  end

  assign fifo_words_used_syncr = (wr_pointer_sync_bit < pmi_array_size_w) && (rd_pointer_bit >= pmi_array_size_w) ?
    (wr_pointer_sync_bit + pmi_array_size_w) - (rd_pointer_bit - pmi_array_size_w) : wr_pointer_sync_bit - rd_pointer_bit;
  assign fifo_words_used_syncw = (wr_pointer_bit < pmi_array_size_w) && (rd_pointer_sync_bit >= pmi_array_size_w) ?
    (wr_pointer_bit + pmi_array_size_w) - (rd_pointer_sync_bit - pmi_array_size_w) : wr_pointer_bit - rd_pointer_sync_bit;

  assign ae_ptr = (pmi_almost_empty_flag * pmi_data_width_r) + (pmi_data_width_r - 1);
  assign empty_ptr = pmi_data_width_r - 1;
  assign af_ptr = (pmi_almost_full_flag * pmi_data_width_w) - (pmi_data_width_w - 1);
  assign full_ptr = pmi_array_size_w - (pmi_data_width_w - 1);

  assign Empty = (fifo_words_used_syncr <= empty_ptr);
  assign AlmostEmpty = (fifo_words_used_syncr <= ae_ptr);
  assign AlmostFull = (fifo_words_used_syncw >= af_ptr);
  assign Full = (fifo_words_used_syncw >= full_ptr);
//pragma translate_on

endmodule

