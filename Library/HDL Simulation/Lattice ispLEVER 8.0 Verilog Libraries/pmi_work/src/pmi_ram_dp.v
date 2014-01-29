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
// Simulation Library File for Dual Port Block RAM PMI Block
//
// Parameter Definition
//Name                        Value                             Default
/*
------------------------------------------------------------------------------
pmi_wr_addr_depth           <integer>                                     512
pmi_wr_addr_width           <integer>                                       9
pmi_wr_data_width           <integer>                                      18
pmi_rd_addr_depth           <integer>                                     512
pmi_rd_addr_width           <integer>                                       9
pmi_rd_data_width           <integer>                                      18
pmi_regmode               "reg"|"noreg"                                  "reg"
pmi_gsr                 "enable"|"disable"                           "disable"
pmi_resetmode             "async"|"sync"                                "sync"
pmi_optimization          "area"|"speed"                               "speed"
pmi_init_file               <string>                                    "none"
pmi_init_file_format      "binary"|"hex"                              "binary"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"   "EC"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_ram_dp.v,v 1.8 2005/09/14 21:06:07 rag Exp $

`timescale 1ns/1ps
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
   parameter pmi_optimization = "speed",
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

//pragma translate_off
   localparam array_size_wr = pmi_wr_addr_depth * pmi_wr_data_width;
   localparam array_size_rd = pmi_rd_addr_depth * pmi_rd_data_width;

   wire Reset_sig;

   reg [((2**pmi_wr_addr_width)*pmi_wr_data_width)-1:0] mem;
   reg [pmi_wr_data_width-1:0] mem1 [(2**pmi_wr_addr_width)-1:0];
     
//Define internal Signals

   reg [(pmi_wr_data_width-1):0]   Data_reg = 0;
   reg [(pmi_wr_addr_width-1):0]   WrAddress_reg = 0;
   reg [(pmi_rd_addr_width-1):0]   RdAddress_reg = 0;
   reg WE_reg = 0;
   
   reg [(pmi_wr_data_width-1):0]   Data_reg_async = 0;
   reg [(pmi_wr_addr_width-1):0]   WrAddress_reg_async = 0;
   reg [(pmi_rd_addr_width-1):0]   RdAddress_reg_async = 0;
   reg WE_reg_async = 0;
   
   reg [(pmi_wr_data_width-1):0]   Data_reg_sync = 0;
   reg [(pmi_wr_addr_width-1):0]   WrAddress_reg_sync = 0;
   reg [(pmi_rd_addr_width-1):0]   RdAddress_reg_sync = 0;
   reg WE_reg_sync = 0;

   reg [(pmi_rd_data_width-1):0]   Q_int = 0;
  
   reg [(pmi_rd_data_width-1):0]   Q_reg = 0;
   reg [(pmi_rd_data_width-1):0]   Q_reg_sync = 0;
   reg [(pmi_rd_data_width-1):0]   Q_reg_async = 0;
  
   integer h, i, j, n, m;

   reg memchg = 0;
   
   reg WrClock_valid = 0;
   reg RdClock_valid = 0;
   reg WrClock_valid_new1 = 0, WrClock_valid_new2 = 0, WrClock_valid_new3 = 0;
   reg RdClock_valid_new1 = 0, RdClock_valid_new2 = 0, RdClock_valid_new3 = 0;
   reg last_RdClock_valid = 0, last_RdClock_valid1 = 0;

   integer v_WADDR,v_RADDR;
   integer WADDR, RADDR, DN_WADDR, UP_WADDR, DN_RADDR, UP_RADDR;

   reg wr_rd_coll = 0; // write/read collision flag
   integer dn_coll_addr, up_coll_addr; // lower & upper collision addresses

   reg [(pmi_rd_data_width-1):0] QQ = 0;
//   reg 				 SRN;

   assign Q = QQ;
      
   //Function to calculate log2 of depth   
 function  integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>0;  clogb2=clogb2+1)
             depth=depth>>>1;
    end
 endfunction // clogb2					

   //async resetmode is not supported for ECP3
   initial begin
      if ((pmi_family == "ECP3") && (pmi_resetmode == "async")) begin
         $display("\nError! The async reset mode is not supported for %s.", pmi_family);
         $stop;
      end
   end

   //Error Check
   initial begin
      if(array_size_wr !== array_size_rd) begin
	$display("\nError! Total value of (Address Depth * Data Width) must be the same for Write and Read ports!");
      $stop;
      end
   end

   //Check for Address_width vs Address_depth
initial begin
   if (clogb2(pmi_wr_addr_depth-1) > pmi_wr_addr_width) begin
       $display("\nError! Address depth of Write Port can not exceed (2**pmi_wr_addr_width)!");
       $stop;
   end
   
   if (clogb2(pmi_rd_addr_depth-1) > pmi_rd_addr_width) begin
       $display("\nError! Address depth of Read Port can not exceed (2**pmi_rd_addr_width)!");
       $stop;
   end
end

//Check if Ratio of Write Port/Read Port or Read Port/Write Port Data widths is a power of 2.
//Module Manager supports 1, 2, 4, 8 and 16 only.

initial begin
   if (pmi_wr_data_width > pmi_rd_data_width)
     begin
	  if ((pmi_wr_data_width / pmi_rd_data_width) >16)
	    begin
	       $display("\nError! The ratio of Write and Read Data width values can not be greater than 16!");
	       $stop;
	    end
	  else if ( (pmi_wr_data_width / pmi_rd_data_width !== 2) && (pmi_wr_data_width / pmi_rd_data_width !== 4) && (pmi_wr_data_width / pmi_rd_data_width !== 8) && (pmi_wr_data_width / pmi_rd_data_width !== 16))
	    begin
	     $display("\nError! The ratio of Write Port and Read Port Data widths is: %d !", pmi_wr_data_width / pmi_rd_data_width);
 	     $display("Error! It must be a power of 2!");
	     $stop;
	    end
     end
   else if (pmi_wr_data_width < pmi_rd_data_width)
     begin
	if ((pmi_rd_data_width / pmi_wr_data_width) >16)
	    begin
	       $display("\nError! The ratio of Read and Write Data width values can not be greater than 16!");
	       $stop;
	    end
	  else if ( (pmi_rd_data_width / pmi_wr_data_width !== 2) && (pmi_rd_data_width / pmi_wr_data_width !== 4) && (pmi_rd_data_width / pmi_wr_data_width !== 8) && (pmi_rd_data_width / pmi_wr_data_width !== 16))
	    begin
	     $display("\nError! The ratio of Read Port and Write Port Data widths is: %d !", pmi_rd_data_width / pmi_wr_data_width);
 	     $display("Error! It must be a power of 2!");
	     $stop;
	    end
	end
end // initial begin

//initialize the Memory. 
//X for SC/SCM, 0 for other families.
	initial begin
		if ((pmi_init_file == "none") && ((pmi_family == "SC") || (pmi_family == "SCM")))
		begin
			for (h = 0; h < (2**pmi_wr_addr_width)*pmi_wr_data_width; h = h+1)
				mem[h] = 1'bX;
		end
		else if ((pmi_init_file == "none") && (pmi_family != "SC") && (pmi_family != "SCM"))
		begin
			for (h = 0; h < (2**pmi_wr_addr_width)*pmi_wr_data_width; h = h+1) 
				mem[h] = 1'b0;
		end
		else if ((pmi_init_file_format == "binary") && (pmi_init_file != "none"))
		begin
			$readmemb(pmi_init_file, mem1);
			for (i = 0; i < 2**pmi_wr_addr_width; i = i+1)
				for (j = 0; j < pmi_wr_data_width; j = j+1)
					mem[(i*pmi_wr_data_width)+j] = mem1[i][j];
		end
		else if ((pmi_init_file_format == "hex") && (pmi_init_file != "none")) 
		begin
			$readmemh(pmi_init_file, mem1);
			for (i = 0; i < 2**pmi_wr_addr_width; i = i+1)
				for (j = 0; j < pmi_wr_data_width; j = j+1)
					mem[(i*pmi_wr_data_width)+j] = mem1[i][j];
		end
	end // initial begin

/*
   not (SR1, SRN);
   or INST1 (Reset_sig, Reset, SR1);
*/

   buf (Reset_sig, Reset);

/*
   always @(SR1, Data, WrAddress, WE)
     begin
	if (SR1 == 1)
	  begin
	     assign Data_reg = 0;
	     assign WrAddress_reg = 0;
	     assign WE_reg = 0;
	     assign Q_reg = 0;
	  end
	else begin
	   deassign Data_reg;
	   deassign WrAddress_reg;
	   deassign WE_reg;
	   deassign Q_reg;
	end // else: !if(SR1 == 1)
     end //
*/

   always @(posedge WrClock)
     begin
	if (Reset_sig == 1)
	  WrClock_valid_new1 <= 0;
	else
	  begin
	     if (WrClockEn == 1)
	       begin
	     WrClock_valid_new1 <= 1;
	     #0.2 WrClock_valid_new1 <= 0;
	       end
	  end
     end
   
   always @(posedge RdClock)
     begin
	if (Reset_sig == 1)
	  RdClock_valid_new1 <= 0;
	else
	  begin
	     if (RdClockEn == 1)
	       begin
	     RdClock_valid_new1 <= 1;
	     #0.2 RdClock_valid_new1 <= 0;
	       end
	  end
     end

   always @(WrClock_valid_new1 or WrClock_valid_new2 or WrClock_valid_new3)
   begin
      WrClock_valid_new2 <= WrClock_valid_new1;
      WrClock_valid_new3 <= WrClock_valid_new2;
      WrClock_valid <= WrClock_valid_new3;
   end

   always @(RdClock_valid_new1 or RdClock_valid_new2 or RdClock_valid_new3)
   begin
      RdClock_valid_new2 <= RdClock_valid_new1;
      RdClock_valid_new3 <= RdClock_valid_new2;
      RdClock_valid <= RdClock_valid_new3;
   end

   always @(RdClock_valid, last_RdClock_valid1)
   begin
     last_RdClock_valid1 <= RdClock_valid;
     last_RdClock_valid <= last_RdClock_valid1;
   end

//Asynchronous Reset   
   always @(posedge WrClock, posedge Reset_sig)
     begin
	if (Reset_sig == 1)
	  begin
	     Data_reg_async <= 0;
	     WrAddress_reg_async <= 0;
	     WE_reg_async <= 0;
	  end
	else
	  begin
	     if (WrClockEn == 1) 
	       begin
		  Data_reg_async <= Data;
		  WrAddress_reg_async <= WrAddress;
		  WE_reg_async <= WE;
	       end
	     
	  end // else: !if(Reset_sig)
     end // always @ (posedge WrClock, posedge Reset)

   always @(posedge RdClock, posedge Reset_sig)
     begin
	if (Reset_sig == 1)
	  begin
	     RdAddress_reg_async <= 0;
	     Q_reg_async <= 0;
	  end
	else
	  begin
	     if (RdClockEn == 1) 
	       begin
		  RdAddress_reg_async <= RdAddress;
		  Q_reg_async <= Q_int;
	       end
	     
	    end // else: !if(Reset)
     end // always @ (posedge RdClock, posedge Reset)
   
//Synchronous Reset   
   always @(posedge WrClock)
     begin
	if (Reset_sig == 1)
	  begin
	     Data_reg_sync <= 0;
	     WrAddress_reg_sync <= 0;
	     WE_reg_sync <= 0;
	  end
	else
	  begin
	     if (WrClockEn == 1) 
	       begin
		  Data_reg_sync <= Data;
		  WrAddress_reg_sync <= WrAddress;
		  WE_reg_sync <= WE;
		end  
	  end // else: !if(Reset)
     end // always @ (posedge WrClock)

   always @(posedge RdClock)
     begin
	if (Reset_sig == 1)
	  begin
	     RdAddress_reg_sync <= 0;
	     //Q_reg_sync <= 0;
	  end
	else
	  begin
	     if (RdClockEn == 1) 
	       begin
		  RdAddress_reg_sync <= RdAddress;
		  //Q_reg_sync <= Q_int;
	       end
	   end // else: !if(Reset)
     end // always @ (posedge RdClock)  

//Synchronous Reset for Data Out. ClockEn gets precedence over Reset.
   always @(posedge RdClock)
     begin
	if (RdClockEn == 1)
	  begin
	    if (Reset_sig == 1)
	      Q_reg_sync <= 0;
	    else
	      Q_reg_sync <= Q_int;
	  end
     end
   
//Choice between async/sync resetmode
   
   always @(Data_reg_sync, WrAddress_reg_sync, WE_reg_sync, Data_reg_async, WrAddress_reg_async, WE_reg_async) begin
      if (pmi_resetmode == "async")
	begin
	   Data_reg = Data_reg_async;
	   WrAddress_reg = WrAddress_reg_async;
	   WE_reg = WE_reg_async;
	end
      else
	begin
	   Data_reg = Data_reg_sync;
	   WrAddress_reg = WrAddress_reg_sync;
	   WE_reg = WE_reg_sync;
	end // else: !if(pmi_resetmode == "async")
   end 
   
   always @(RdAddress_reg_sync, RdAddress_reg_async, Q_reg_async, Q_reg_sync ) begin
      if (pmi_resetmode == "async")
	begin
	   RdAddress_reg = RdAddress_reg_async;
	   Q_reg = Q_reg_async;
	end
      else
	begin
	   RdAddress_reg = RdAddress_reg_sync;
	   Q_reg = Q_reg_sync;
	end // else: !if(pmi_resetmode == "async")
   end 

   always @(WrAddress_reg or RdAddress_reg or WE_reg or WrClock_valid_new2 or RdClock_valid_new2)
   begin
      WADDR = WrAddress_reg;
      RADDR = RdAddress_reg;
      DN_WADDR = WADDR * pmi_wr_data_width;
      UP_WADDR = ((WADDR + 1) * pmi_wr_data_width) - 1;
      DN_RADDR = RADDR * pmi_rd_data_width;
      UP_RADDR = ((RADDR + 1) * pmi_rd_data_width) - 1;

//reset collision flag when needed
      if (~((UP_RADDR < DN_WADDR) || (DN_RADDR > UP_WADDR)))
      begin
         if (wr_rd_coll == 1)
         begin
            if (WrClock_valid_new2 == 0 && RdClock_valid_new2 == 0)
               wr_rd_coll = 0;
         end
      end
      else
      begin
         wr_rd_coll = 0;
      end

//get possible collision addresses
      if (~((UP_RADDR < DN_WADDR) || (DN_RADDR > UP_WADDR)))
      begin
         if ((DN_WADDR > DN_RADDR) && (UP_WADDR < UP_RADDR))
         begin
            dn_coll_addr = DN_WADDR;
            up_coll_addr = UP_WADDR;
         end
         else if ((DN_RADDR > DN_WADDR) && (UP_RADDR < UP_WADDR))
         begin
            dn_coll_addr = DN_RADDR;
            up_coll_addr = UP_RADDR;
         end
         else if ((UP_WADDR - DN_RADDR) <= (UP_RADDR - DN_WADDR))
         begin
            dn_coll_addr = DN_RADDR;
            up_coll_addr = UP_WADDR;
         end
         else
         begin
            dn_coll_addr = DN_WADDR;
            up_coll_addr = UP_RADDR;
         end
      end

//set collision flag
      if (WE_reg == 1 && WrClock_valid_new2 == 1 && RdClock_valid_new2 == 1)
      begin
         if (~((UP_RADDR < DN_WADDR) || (DN_RADDR > UP_WADDR)))
         begin
//            $display ("Warning! Block-Ram instance, %m:",
//                      "\n\t simulation time:",$time,
//                      "\n\t has possible write port and read port address collision.");
				wr_rd_coll = 1;
         end
      end
   end

//Write Operation

   //always @(WE_reg, WrAddress_reg, Data_reg, WrClock_valid)
	always @(WrClock_valid)
	begin
		v_WADDR = WrAddress_reg;
		memchg = ~memchg;

		if (WE_reg == 1 && WrClock_valid == 1) 
		begin
			for (n = 0; n < pmi_wr_data_width; n = n+1)
				mem[v_WADDR * pmi_wr_data_width + n] = Data_reg[n];
		end // if (WE_reg)
	end

//Read Operation

   //always @(RdAddress_reg, posedge Reset_sig, memchg, RdClock_valid)
	always @(posedge Reset_sig, posedge RdClock, memchg, RdClock_valid)
	begin
		v_RADDR = RdAddress_reg;

		if (Reset_sig == 1) begin
         if (pmi_resetmode == "sync")
         begin
            if (RdClock ==  1'b1)
               Q_int  <= 0;
         end
         else
            Q_int <= 0;
		end
		else if (RdClock_valid == 1 && last_RdClock_valid == 0)
		begin
			for (m = 0; m < pmi_rd_data_width; m = m+1)
			begin
				if ( (wr_rd_coll == 1) &&
					  ((v_RADDR * pmi_rd_data_width + m) >= dn_coll_addr) &&
					  ((v_RADDR * pmi_rd_data_width + m) <= up_coll_addr) )
					Q_int[m] <= 1'bX;
				else
					Q_int[m] <= mem[v_RADDR * pmi_rd_data_width + m];
			end
		end // if (RdClock_valid == 1)
	end

   //REGMODE
   always @ (Q_reg, Q_int) 
     begin
      if (pmi_regmode == "reg")
	QQ = Q_reg;
      else
	QQ = Q_int;
     end
//pragma translate_on
 endmodule // pmi_ram_dp

