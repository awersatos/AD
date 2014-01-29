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
// Simulation Library File for Single Port Block RAM PMI
//
// Parameter Definition
//Name                        Value                                    Default
/*
------------------------------------------------------------------------------
pmi_addr_depth              <integer>                                     512
pmi_addr_width              <integer>                                       9
pmi_data_width              <integer>                                      18
pmi_regmode               "reg"|"noreg"                                  "reg"
pmi_gsr                 "enable"|"disable"                           "disable"
pmi_resetmode             "async"|"sync"                                "sync"
pmi_optimization          "area"|"speed"                               "speed"
pmi_init_file               <string>                                    "none"
pmi_init_file_format      "binary"|"hex"                              "binary"
pmi_write_mode       "normal"|"writethrough"|"readbeforewrite"        "normal"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"   "EC"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_ram_dq.v,v 1.7 2005/08/15 13:06:58 rag Exp $

`timescale 1ns/1ps
module pmi_ram_dq
 #(parameter pmi_addr_depth = 512,
   parameter pmi_addr_width = 9,
   parameter pmi_data_width = 18,
   parameter pmi_regmode = "reg",
   parameter pmi_gsr = "disable",
   parameter pmi_resetmode = "sync",
   parameter pmi_optimization = "speed",
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
//pragma translate_off
  
   wire Reset_sig;
  
//Define internal Signals

   reg [(pmi_data_width-1):0]   DataIn_reg = 0;
   reg [(pmi_addr_width-1):0] 	Address_reg = 0;
   reg 				Wr_reg = 0;

   reg [(pmi_data_width-1):0]   DataIn_reg_async = 0;
   reg [(pmi_addr_width-1):0] 	Address_reg_async = 0;
   reg 				Wr_reg_async = 0;

   
   reg [(pmi_data_width-1):0]   DataIn_reg_sync = 0;
   reg [(pmi_addr_width-1):0] 	Address_reg_sync = 0;
   reg 				Wr_reg_sync = 0;


   reg [(pmi_data_width-1):0] 	Q_rbr = 0;
   reg [(pmi_data_width-1):0] 	Q_int = 0;

   reg [(pmi_data_width-1):0] 	Q_reg = 0;
   reg [(pmi_data_width-1):0] 	Q_reg_sync = 0;
   reg [(pmi_data_width-1):0] 	Q_reg_async = 0;


   integer 				h, z;

   reg 					memchg = 0;
   
   reg Clock_valid = 0;

   reg [pmi_data_width-1:0] mem [2**pmi_addr_width-1:0];
   reg [(pmi_data_width-1):0] QQ = 0;
//   reg 			      SRN;
 			      
   assign 		      Q = QQ;
   
   //Function to calculate log2 of depth      
   function  integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>0;  clogb2=clogb2+1)
             depth=depth>>>1;
    end
   endfunction // clogb2					


   //Error Checks

   //async resetmode is not supported for ECP3
   initial begin
      if ((pmi_family == "ECP3") && (pmi_resetmode == "async")) begin
         $display("\nError! The async reset mode is not supported for %s.", pmi_family);
         $stop;
      end
   end

   //Check for Address_width vs Address_depth
   initial begin
   if (clogb2(pmi_addr_depth-1) > pmi_addr_width) begin
       $display("\nError! Address depth can not exceed (2**pmi_addr_width)!");
       $stop;
       end
   end

//For non-SC/SCM/XO families:
//Read-before-Write is supported for memory configurations in x9, x18, x36 datawidth. Data width should be set to match this requirement.

   initial begin
      if ((pmi_family != "SC") && (pmi_family != "SCM") && (pmi_family != "XO") && (pmi_write_mode == "readbeforewrite"))
	begin
	   if (pmi_data_width % 9 !== 0)
	     begin
		$display("\nError! Read-before-Write is supported for memory configurations in x9, x18, x36 datawidth. Data width should be set to match this requirement.");
		$stop;
	     end
	end
      end

//initialize the Memory. 
//X for SC/SCM, 0 for the rest 
   initial begin
   if ((pmi_init_file == "none") && ((pmi_family == "SC") || (pmi_family == "SCM")))
     begin
      for (h = 0; h < 2**pmi_addr_width; h = h+1) 
       	  begin
	     mem[h] = {pmi_data_width{1'bx}};
	   end // for (h = 0; h < 2**pmi_addr_width; h = h+1)
      end
       else
       if ((pmi_init_file == "none") && (pmi_family != "SC") && (pmi_family != "SCM"))
	 begin
	   for (h = 0; h < 2**pmi_addr_width; h = h+1) 
	    begin
	    mem[h] = {pmi_data_width{1'b0}};
            end // for (h = 0; h < 2**pmi_addr_width; h = h+1)
         end	   
       else if ((pmi_init_file_format == "binary") && (pmi_init_file != "none"))
       begin
	  $readmemb(pmi_init_file, mem);
       end
       else
       if ((pmi_init_file_format == "hex") && (pmi_init_file != "none")) 
	 begin
       $readmemh(pmi_init_file, mem);
	 end
   
   end // initial begin

/*
   tri1 GSR_sig = GSR_INST.GSRNET;
   tri1 PUR_sig = PUR_INST.PURNET;

   always @(GSR_sig or PUR_sig ) begin
    if (pmi_gsr == "enable") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (pmi_gsr == "disable")
      SRN = PUR_sig;
   end

   not (SR1, SRN);
   or INST1 (Reset_sig, Reset, SR1);
*/

   buf (Reset_sig, Reset);

/*
   always @(SR1, Data, Address, WE)
     begin
	if (SR1 == 1)
	  begin
	     assign DataIn_reg = 0;
	     assign Address_reg = 0;
	     assign Wr_reg = 0;
	     assign Q_reg = 0;
	  end
	else begin
	   deassign DataIn_reg;
	   deassign Address_reg;
	   deassign Wr_reg;
	   deassign Q_reg;
	end // else: !if(SR1 == 1)
     end // always @ (SR1, Data, Address, WE)
   	
*/

   always @(posedge Clock)
     begin
	if (Reset == 1)
	  Clock_valid <=0;
	else
	  begin
	     if (ClockEn == 1)
	       begin
	     Clock_valid <= 1;
	     #0.2 Clock_valid <= 0;
	       end
	  end
     end
   
//Asynchronous Reset   
   always @(posedge Clock, posedge Reset_sig)
     begin
	if (Reset_sig == 1)
	  begin
	     DataIn_reg_async <= 0;
	     Address_reg_async <= 0;
	     Wr_reg_async <= 0;
	     Q_reg_async <= 0;
	  end
	else
	  begin
	     if (ClockEn == 1) 
	       begin
		  DataIn_reg_async <= Data;
		  Address_reg_async <= Address;
		  Wr_reg_async <= WE;
		  Q_reg_async <= Q_int;
		end
	     
	  end // else: !if(ResetA)
     end // always @ (posedge ClockA, posedge ResetA)

//Synchronous Reset   
   always @(posedge Clock)
     begin
	if (Reset_sig == 1)
	  begin
	     DataIn_reg_sync <= 0;
	     Address_reg_sync <= 0;
	     Wr_reg_sync <= 0;
	     //Q_reg_sync <= 0;
	  end
	else
	  begin
	     if (ClockEn == 1) 
	       begin
		  DataIn_reg_sync <= Data;
		  Address_reg_sync <= Address;
		  Wr_reg_sync <= WE;
		  //Q_reg_sync <= Q_int;
		end  
	  end // else: !if(Reset)
     end // always @ (posedge Clock)

//Synchronous Reset for Data Out. ClockEn gets precedence over Reset
   always @(posedge Clock)
     begin
	if (ClockEn == 1)
	  begin
	     if (Reset_sig == 1)
	       Q_reg_sync <= 0;
	     else
	       Q_reg_sync <= Q_int;
	  end
     end
   
//Choice between async/sync resetmode
   
   always @(DataIn_reg_sync, Address_reg_sync, Wr_reg_sync, DataIn_reg_async, Address_reg_async, Wr_reg_async, Q_reg_async, Q_reg_sync) begin
      if (pmi_resetmode == "async")
	begin
	   DataIn_reg = DataIn_reg_async;
	   Address_reg = Address_reg_async;
	   Wr_reg = Wr_reg_async;
	   Q_reg = Q_reg_async;
	end
      else
	begin
	   DataIn_reg = DataIn_reg_sync;
	   Address_reg = Address_reg_sync;
	   Wr_reg = Wr_reg_sync;
	   Q_reg = Q_reg_sync;
	end // else: !if(pmi_resetmode == "async")
   end //
   
//Write Operation

   always @(Wr_reg, Address_reg,  DataIn_reg, Clock_valid)
     begin
	memchg = ~memchg;
	if (Wr_reg == 1 && Clock_valid == 1) 
	  begin
	     Q_rbr = mem[Address_reg]; //read before write
	     mem[Address_reg] = DataIn_reg;
	  end // if (Wr_reg)
 end // always @ (posedge Clock, Wr_reg, Address_reg, DataIn_reg)

//Read Operation
   
   always @(!Wr_reg, Address_reg, posedge Reset_sig, memchg, Clock_valid, mem[Address_reg])
   begin
	  if (Reset_sig == 1) begin
         if (pmi_resetmode == "sync")
         begin
            if (Clock ==  1'b1)
               Q_int  = 0;
         end
         else
            Q_int = 0;
	  end
	  else if (Clock_valid == 1)
	    begin
	    if (Wr_reg == 0) 
	      begin//Normal
	      Q_int = mem[Address_reg];
	      end
	    else
	    if (Wr_reg == 1) //Writethrough or readbeforewrite
	      begin
		if (pmi_write_mode == "writethrough") 
		  begin
		  Q_int = mem[Address_reg];
		  end
		else if (pmi_write_mode == "readbeforewrite") 
		  begin
			if (pmi_family == "SC" || pmi_family == "SCM" ||
				 pmi_family == "ECP2" || pmi_family == "ECP2M" || pmi_family == "XP2")
				$display ("ERROR! WRITEMODE of READBEFOREWRITE is not supported !!!");
		  Q_int = Q_rbr;
		  end
	      end
	    end // if (Clock_valid == 1)
     end // always @ (posedge Clock, !Wr_reg, Address_reg, posedge Reset)

   //REGMODE
   always @ (Q_reg, Q_int) 
     begin
      if (pmi_regmode == "reg")
	QQ = Q_reg;
      else
	QQ = Q_int;
     end

//pragma translate_on
endmodule // pmi_ram_dq

