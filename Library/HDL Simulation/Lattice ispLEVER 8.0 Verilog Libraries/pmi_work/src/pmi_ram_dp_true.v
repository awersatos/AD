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
// Simulation Library File for True Dual Port Block RAM PMI
//
// Parameter Definition
//Name                        Value                                    Default
/*
------------------------------------------------------------------------------
pmi_addr_depth_a            <integer>                                     512
pmi_addr_width_a            <integer>                                       9
pmi_data_width_a            <integer>                                      18
pmi_addr_depth_b            <integer>                                     512
pmi_addr_width_b            <integer>                                       9
pmi_data_width_b            <integer>                                      18
pmi_regmode_a             "reg"|"noreg"                                  "reg"
pmi_regmode_b             "reg"|"noreg"                                  "reg"
pmi_gsr                 "enable"|"disable"                           "disable"
pmi_resetmode             "async"|"sync"                                "sync"
pmi_optimization          "area"|"speed"                               "speed"
pmi_init_file               <string>                                    "none"
pmi_init_file_format      "binary"|"hex"                              "binary"
pmi_write_mode_a     "normal"|"writethrough"|"readbeforewrite"        "normal"
pmi_write_mode_b     "normal"|"writethrough"|"readbeforewrite"        "normal"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"   "EC"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
  
*/
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_ram_dp_true.v,v 1.7 2005/08/15 13:06:44 rag Exp $

`timescale 1ns/1ps
module pmi_ram_dp_true
 #(parameter pmi_addr_depth_a = 512,
   parameter pmi_addr_width_a = 9,
   parameter pmi_data_width_a = 18,
   parameter pmi_addr_depth_b = 512,
   parameter pmi_addr_width_b = 9,
   parameter pmi_data_width_b = 18,
   parameter pmi_regmode_a = "reg",
   parameter pmi_regmode_b = "reg",
   parameter pmi_gsr = "disable",
   parameter pmi_resetmode = "sync",
   parameter pmi_optimization = "speed",
   parameter pmi_init_file = "none",
   parameter pmi_init_file_format = "binary",
   parameter pmi_write_mode_a = "normal",
   parameter pmi_write_mode_b = "normal",
   parameter pmi_family = "EC",
   parameter module_type = "pmi_ram_dp_true")

  
  (input [(pmi_data_width_a-1):0]	DataInA,
   input [(pmi_data_width_b-1):0]	DataInB,
   input [(pmi_addr_width_a-1):0] AddressA,
   input [(pmi_addr_width_b-1):0] AddressB,
   input  ClockA,
   input  ClockB,
   input  ClockEnA,
   input  ClockEnB,
   input  WrA,
   input  WrB,
   input  ResetA,
   input  ResetB,
   output [(pmi_data_width_a-1):0]  QA,
   output [(pmi_data_width_b-1):0]  QB)/*synthesis syn_black_box */;

//pragma translate_off
   localparam array_size_a = pmi_addr_depth_a * pmi_data_width_a;
   localparam array_size_b = pmi_addr_depth_b * pmi_data_width_b;

   wire ResetA_sig, ResetB_sig;

   reg [((2**pmi_addr_width_a)*pmi_data_width_a)-1:0] mem;
   reg [pmi_data_width_a-1:0] mem1 [(2**pmi_addr_width_a)-1:0];
     
//Define internal Signals

   reg [(pmi_data_width_a-1):0]   DataInA_reg = 0;
   reg [(pmi_data_width_b-1):0]   DataInB_reg = 0;
   reg [(pmi_addr_width_a-1):0]   AddressA_reg = 0;
   reg [(pmi_addr_width_b-1):0]   AddressB_reg = 0;
   reg WrA_reg = 0;
   reg WrB_reg = 0;
   
   reg [(pmi_data_width_a-1):0]   DataInA_reg_async = 0;
   reg [(pmi_data_width_b-1):0]   DataInB_reg_async = 0;
   reg [(pmi_addr_width_a-1):0]   AddressA_reg_async = 0;
   reg [(pmi_addr_width_b-1):0]   AddressB_reg_async = 0;
   reg WrA_reg_async = 0;
   reg WrB_reg_async = 0;
   
   reg [(pmi_data_width_a-1):0]   DataInA_reg_sync = 0;
   reg [(pmi_data_width_b-1):0]   DataInB_reg_sync = 0;
   reg [(pmi_addr_width_a-1):0]   AddressA_reg_sync = 0;
   reg [(pmi_addr_width_b-1):0]   AddressB_reg_sync = 0;
   reg WrA_reg_sync = 0;
   reg WrB_reg_sync = 0;

   reg [(pmi_data_width_a-1):0]   QA_rbr = 0;
   reg [(pmi_data_width_b-1):0]   QB_rbr = 0;
   
   reg [(pmi_data_width_a-1):0]   QA_int = 0;
   reg [(pmi_data_width_b-1):0]   QB_int = 0;

   reg [(pmi_data_width_a-1):0]   QA_reg = 0;
   reg [(pmi_data_width_a-1):0]   QA_reg_sync = 0;
   reg [(pmi_data_width_a-1):0]   QA_reg_async = 0;

   reg [(pmi_data_width_b-1):0]   QB_reg = 0;
   reg [(pmi_data_width_b-1):0]   QB_reg_sync = 0;
   reg [(pmi_data_width_b-1):0]   QB_reg_async = 0;

   integer h, i, j, n, k, l, m;

   reg memchg = 0;
   
   reg ClockA_valid = 0;
   reg ClockB_valid = 0;
   reg ClockA_valid_new1 = 0, ClockA_valid_new2 = 0, ClockA_valid_new3 = 0;
   reg ClockB_valid_new1 = 0, ClockB_valid_new2 = 0, ClockB_valid_new3 = 0;
   reg last_ClockA_valid = 0, last_ClockA_valid1 = 0;
   reg last_ClockB_valid = 0, last_ClockB_valid1 = 0;

   integer v_WADDR_A,v_RADDR_A,v_WADDR_B,v_RADDR_B;
   integer ADDR_A, ADDR_B, DN_ADDR_A, UP_ADDR_A, DN_ADDR_B, UP_ADDR_B;

   reg wr_a_wr_b_coll = 0, wr_a_rd_b_coll = 0, rd_a_wr_b_coll = 0; // write & read/write collision flags
   integer dn_coll_addr, up_coll_addr; // lower & upper collision addresses

   reg [(pmi_data_width_a-1):0] QQA = 0;
   reg [(pmi_data_width_b-1):0] QQB = 0;
//   reg 				SRN;

   assign QA = QQA;
   assign QB = QQB;

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
      if(array_size_a !== array_size_b) begin
	$display("\nError! Total value of (Address Depth * Data Width) must be the same for A and B ports!");
      $stop;
      end
   end

   //Check for Address_width vs Address_depth
initial begin
   if (clogb2(pmi_addr_depth_a-1) > pmi_addr_width_a) begin
       $display("\nError! Address depth on Port A can not exceed (2**pmi_addr_width_a)!");
       $stop;
       end
end

initial begin
   if (clogb2(pmi_addr_depth_b-1) > pmi_addr_width_b) begin
       $display("\nError! Address depth on Port B can not exceed (2**pmi_addr_width_b)!");
       $stop;
       end
end

//Check if Ratio of Port A/Port B or Port B/Port A Data width is a power of 2.
//Module Manager supports 1, 2, 4, 8 and 16 only.
   

initial begin
   if (pmi_data_width_a > pmi_data_width_b)
     begin
	  if ((pmi_data_width_a / pmi_data_width_b) >16)
	    begin
	       $display("\nError! The ratio of Port A and Port B Data width values can not be greater than 16!");
	       $stop;
	    end
	  else if ( (pmi_data_width_a / pmi_data_width_b !== 2) && (pmi_data_width_a / pmi_data_width_b !== 4) && (pmi_data_width_a / pmi_data_width_b !== 8) && (pmi_data_width_a / pmi_data_width_b !== 16))
	    begin
	     $display("\nError! The ratio of Port A and Port B Data widths is: %d !", pmi_data_width_a / pmi_data_width_b);
 	     $display("Error! It must be a power of 2!");
	     $stop;
	    end
     end
   else if (pmi_data_width_a < pmi_data_width_b)
     begin
	if ((pmi_data_width_b / pmi_data_width_a) >16)
	    begin
	       $display("\nError! The ratio of Port B and Port A Data width values can not be greater than 16!");
	       $stop;
	    end
	  else if ( (pmi_data_width_b / pmi_data_width_a !== 2) && (pmi_data_width_b / pmi_data_width_a !== 4) && (pmi_data_width_b / pmi_data_width_a !== 8) && (pmi_data_width_b / pmi_data_width_a !== 16))
	    begin
	     $display("\nError! The ratio of Port B and Port A Data widths is: %d !", pmi_data_width_b / pmi_data_width_a);
 	     $display("Error! It must be a power of 2!");
	     $stop;
	    end
	end
end // initial begin

//For non-SC/SCM/XO families:
//Read-before-Write is supported for memory configurations in x9, x18, x36 datawidth. Data width should be set to match this requirement.

   initial begin
      if ((pmi_family != "SC") && (pmi_family != "SCM") && (pmi_family != "XO") && (pmi_write_mode_a == "readbeforewrite"))
	begin
	   if (pmi_data_width_a % 9 !== 0)
	     begin
		$display("\nError! Read-before-Write is supported for memory configurations in x9, x18, x36 datawidth. Data width for port A should be set to match this requirement.");
		$stop;
	     end
	end
      if ((pmi_family != "SC") && (pmi_family != "SCM") && (pmi_family != "XO") && (pmi_write_mode_b == "readbeforewrite"))
	begin
	   if (pmi_data_width_b % 9 !== 0)
	     begin
		$display("\nError! Read-before-Write is supported for memory configurations in x9, x18, x36 datawidth. Data width for port B should be set to match this requirement.");
		$stop;
	     end
	end
     end
 
//initialize the Memory. 
//X for SC/SCM, 0 for other families. 
	initial
	begin
		if ((pmi_init_file == "none") && ((pmi_family == "SC") || (pmi_family == "SCM")))
		begin
			for (h = 0; h < (2**pmi_addr_width_a)*pmi_data_width_a; h = h+1)
				mem[h] = 1'bX;
		end
		else if ((pmi_init_file == "none") && (pmi_family != "SC") && (pmi_family != "SCM"))
		begin
			for (h = 0; h < (2**pmi_addr_width_a)*pmi_data_width_a; h = h+1)
				mem[h] = 1'b0;
		end
		else if ((pmi_init_file_format == "binary") && (pmi_init_file != "none"))
		begin
			$readmemb(pmi_init_file, mem1);
			for (i = 0; i < 2**pmi_addr_width_a; i = i+1)
				for (j = 0; j < pmi_data_width_a; j = j+1)
					mem[(i*pmi_data_width_a)+j] = mem1[i][j];
		end
		else if ((pmi_init_file_format == "hex") && (pmi_init_file != "none")) 
		begin
			$readmemh(pmi_init_file, mem1);
			for (i = 0; i < 2**pmi_addr_width_a; i = i+1)
				for (j = 0; j < pmi_data_width_a; j = j+1)
					mem[(i*pmi_data_width_a)+j] = mem1[i][j];
		end
end // initial begin

/*
   not (SR1, SRN);
   or INST1 (ResetA_sig, ResetA, SR1);
   or INST2 (ResetB_sig, ResetB, SR1);
*/

  buf (ResetA_sig, ResetA);
  buf (ResetB_sig, ResetB);

/*
   always @(SR1, DataInA, AddressA, WrA, DataInB, AddressB, WrB)
     begin
	if (SR1 == 1)
	  begin
	     assign DataInA_reg = 0;
	     assign AddressA_reg = 0;
	     assign WrA_reg = 0;
	     assign DataInB_reg = 0;
	     assign AddressB_reg = 0;
	     assign WrB_reg = 0;
	     assign QA_reg = 0;
	     assign QB_reg = 0;
	  end
	else begin
	   deassign DataInA_reg;
	   deassign AddressA_reg;
	   deassign WrA_reg;
	   deassign DataInB_reg;
	   deassign AddressB_reg;
	   deassign WrB_reg;
	   deassign QA_reg;
	   deassign QB_reg;
	end // else: !if(SR1 == 1)
     end //
*/

   always @(posedge ClockA)
   begin
	if (ResetA_sig == 1)
	  ClockA_valid_new1 <= 0;
	else
	begin
	  if (ClockEnA == 1)
	  begin
	     ClockA_valid_new1 <= 1;
	     #0.2 ClockA_valid_new1 <= 0;
	  end
	end
   end

   always @(posedge ClockB)
   begin
	if (ResetB_sig == 1)
	  ClockB_valid_new1 <= 0;
	else
	begin
	  if (ClockEnB == 1)
	  begin
	     ClockB_valid_new1 <= 1;
	     #0.2 ClockB_valid_new1 <= 0;
	  end
	end
   end

   always @(ClockA_valid_new1 or ClockA_valid_new2 or ClockA_valid_new3)
   begin
      ClockA_valid_new2 <= ClockA_valid_new1;
      ClockA_valid_new3 <= ClockA_valid_new2;
      ClockA_valid <= ClockA_valid_new3;
   end

   always @(ClockB_valid_new1 or ClockB_valid_new2 or ClockB_valid_new3)
   begin
      ClockB_valid_new2 <= ClockB_valid_new1;
      ClockB_valid_new3 <= ClockB_valid_new2;
      ClockB_valid <= ClockB_valid_new3;
   end

   always @(ClockA_valid, ClockB_valid, last_ClockA_valid1, last_ClockB_valid1)
   begin
     last_ClockA_valid1 <= ClockA_valid;
     last_ClockB_valid1 <= ClockB_valid;
     last_ClockA_valid <= last_ClockA_valid1;
     last_ClockB_valid <= last_ClockB_valid1;
   end

//Asynchronous Reset   
   always @(posedge ClockA, posedge ResetA_sig)
     begin
	if (ResetA_sig)
	  begin
	     DataInA_reg_async <= 0;
	     AddressA_reg_async <= 0;
	     WrA_reg_async <= 0;
	     QA_reg_async <= 0;
	  end
	else
	  begin
	     if (ClockEnA == 1) 
	       begin
		  DataInA_reg_async <= DataInA;
		  AddressA_reg_async <= AddressA;
		  WrA_reg_async <= WrA;
		  QA_reg_async <= QA_int;
		end
	     
	  end // else: !if(ResetA)
     end // always @ (posedge ClockA, posedge ResetA)

   always @(posedge ClockB, posedge ResetB_sig)
     begin
	if (ResetB_sig)
	  begin
	     DataInB_reg_async <= 0;
	     AddressB_reg_async <= 0;
	     WrB_reg_async <= 0;
	     QB_reg_async <= 0;
	  end
	else
	  begin
	     if (ClockEnB == 1) 
	       begin
		  DataInB_reg_async <= DataInB;
		  AddressB_reg_async <= AddressB;
		  WrB_reg_async <= WrB;
		  QB_reg_async <= QB_int;
	       end
	     
	    end // else: !if(ResetB)
     end // always @ (posedge ClockB, posedge ResetB)
   
//Synchronous Reset   
   always @(posedge ClockA)
     begin
	if (ResetA_sig)
	  begin
	     DataInA_reg_sync <= 0;
	     AddressA_reg_sync <= 0;
	     WrA_reg_sync <= 0;
	     //QA_reg_sync <= 0;
	  end
	else
	  begin
	     if (ClockEnA == 1) 
	       begin
		  DataInA_reg_sync <= DataInA;
		  AddressA_reg_sync <= AddressA;
		  WrA_reg_sync <= WrA;
		  //QA_reg_sync <= QA_int;
		end  
	  end // else: !if(ResetA)
     end // always @ (posedge ClockA)

   always @(posedge ClockB)
     begin
	if (ResetB_sig)
	  begin
	     DataInB_reg_sync <= 0;
	     AddressB_reg_sync <= 0;
	     WrB_reg_sync <= 0;
	     //QB_reg_sync <= 0;
	  end
	else
	  begin
	     if (ClockEnB == 1) 
	       begin
		  DataInB_reg_sync <= DataInB;
		  AddressB_reg_sync <= AddressB;
		  WrB_reg_sync <= WrB;
		  //QB_reg_sync <= QB_int;
	       end
	   end // else: !if(ResetB)
     end // always @ (posedge ClockB)  

//Synchronous Reset for Data Out. ClockEn gets precedence over Reset
   always @(posedge ClockA)
     begin
	if (ClockEnA == 1)
	  begin
	     if (ResetA_sig == 1)
	       QA_reg_sync <= 0;
	     else
	       QA_reg_sync <= QA_int;
	  end
     end

   always @(posedge ClockB)
     begin
	if (ClockEnB == 1)
	  begin
	     if (ResetB_sig == 1)
	       QB_reg_sync <= 0;
	     else
	       QB_reg_sync <= QB_int;
	  end
     end

//Choice between async/sync resetmode
   
   always @(DataInA_reg_sync, AddressA_reg_sync, WrA_reg_sync, DataInA_reg_async, AddressA_reg_async, WrA_reg_async, QA_reg_async, QA_reg_sync) begin
      if (pmi_resetmode == "async")
	begin
	   DataInA_reg = DataInA_reg_async;
	   AddressA_reg = AddressA_reg_async;
	   WrA_reg = WrA_reg_async;
	   QA_reg = QA_reg_async;
	end
      else
	begin
	   DataInA_reg = DataInA_reg_sync;
	   AddressA_reg = AddressA_reg_sync;
	   WrA_reg = WrA_reg_sync;
	   QA_reg = QA_reg_sync;
	end // else: !if(pmi_resetmode == "async")
   end // always @ (DataInA_reg_sync, AddressA_reg_sync, WrA_reg_sync, DataInA_reg_async, AddressA_reg_async, WrA_reg_async)
   
   always @(DataInB_reg_sync, AddressB_reg_sync, WrB_reg_sync, DataInB_reg_async, AddressB_reg_async, WrB_reg_async, QB_reg_async, QB_reg_sync) begin
      if (pmi_resetmode == "async")
	begin
	   DataInB_reg = DataInB_reg_async;
	   AddressB_reg = AddressB_reg_async;
	   WrB_reg = WrB_reg_async;
	   QB_reg = QB_reg_async;
	end
      else
	begin
	   DataInB_reg = DataInB_reg_sync;
	   AddressB_reg = AddressB_reg_sync;
	   WrB_reg = WrB_reg_sync;
	   QB_reg = QB_reg_sync;
	end // else: !if(pmi_resetmode == "async")
   end // always @ (DataInB_reg_sync, AddressB_reg_sync, WrB_reg_sync, DataInB_reg_async, AddressB_reg_async, WrB_reg_async)

   always @(AddressA_reg, AddressB_reg, WrA_reg, WrB_reg, ClockA_valid_new2, ClockB_valid_new2)
   begin
      ADDR_A = AddressA_reg;
      ADDR_B = AddressB_reg;
      DN_ADDR_A = ADDR_A * pmi_data_width_a;
      UP_ADDR_A = ((ADDR_A + 1) * pmi_data_width_a) - 1;
      DN_ADDR_B = ADDR_B * pmi_data_width_b;
      UP_ADDR_B = ((ADDR_B + 1) * pmi_data_width_b) - 1;

//reset collision flags when needed
      if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
      begin
         if (wr_a_wr_b_coll == 1)
         begin
            if (ClockA_valid_new2 == 0 && ClockB_valid_new2 == 0)
               wr_a_wr_b_coll = 0;
         end
         if (wr_a_rd_b_coll == 1)
         begin
            if (ClockA_valid_new2 == 0 && ClockB_valid_new2 == 0)
               wr_a_rd_b_coll = 0;
         end
         if (rd_a_wr_b_coll == 1)
         begin
            if (ClockA_valid_new2 == 0 && ClockB_valid_new2 == 0)
               rd_a_wr_b_coll = 0;
         end
      end
      else
      begin
         wr_a_wr_b_coll = 0;
         wr_a_rd_b_coll = 0;
         rd_a_wr_b_coll = 0;
      end

//get possible collision addresses
      if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
      begin
         if ((DN_ADDR_A > DN_ADDR_B) && (UP_ADDR_A < UP_ADDR_B))
         begin
            dn_coll_addr = DN_ADDR_A;
            up_coll_addr = UP_ADDR_A;
         end
         else if ((DN_ADDR_B > DN_ADDR_A) && (UP_ADDR_B < UP_ADDR_A))
         begin
            dn_coll_addr = DN_ADDR_B;
            up_coll_addr = UP_ADDR_B;
         end
         else if ((UP_ADDR_A - DN_ADDR_B) <= (UP_ADDR_B - DN_ADDR_A))
         begin
            dn_coll_addr = DN_ADDR_B;
            up_coll_addr = UP_ADDR_A;
         end
         else
         begin
            dn_coll_addr = DN_ADDR_A;
            up_coll_addr = UP_ADDR_B;
         end
      end

//set collision flags
      if ((WrA_reg == 1 && ClockA_valid_new2 == 1) && (WrB_reg == 1 && ClockB_valid_new2 == 1))
      begin
         if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
         begin
//            $display ("Warning! Block-Ram instance, %m:",
//                      "\n\t simulation time:",$time,
//                      "\n\t has possible write address collision.");
				wr_a_wr_b_coll = 1;
         end
      end

      if ((WrA_reg == 1 && ClockA_valid_new2 == 1) && (WrB_reg == 0 && ClockB_valid_new2 == 1))
      begin
         if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
         begin
//            $display ("Warning! Block-Ram instance, %m:",
//                      "\n\t simulation time:",$time,
//                      "\n\t has possible write (Port A) and read (Port B) address collision.");
				wr_a_rd_b_coll = 1;
         end
      end

      if ((WrA_reg == 0 && ClockA_valid_new2 == 1) && (WrB_reg == 1 && ClockB_valid_new2 == 1))
      begin
         if (~((UP_ADDR_B < DN_ADDR_A) || (DN_ADDR_B > UP_ADDR_A)))
         begin
//            $display ("Warning! Block-Ram instance, %m:",
//                      "\n\t simulation time:",$time,
//                      "\n\t has possible write (Port B) and read (Port A) address collision.");
				rd_a_wr_b_coll = 1;
         end
      end
   end

//Write Operation

   //always @(WrA_reg, WrB_reg, AddressA_reg, AddressB_reg, DataInA_reg, DataInB_reg, ClockA_valid, ClockB_valid)
	always @(ClockA_valid, ClockB_valid)
	begin
		v_WADDR_A = AddressA_reg;
		v_WADDR_B = AddressB_reg;
		memchg = ~memchg;

		if (WrA_reg == 1 && ClockA_valid == 1) 
		begin
			for (n = 0; n < pmi_data_width_a; n = n+1)
				QA_rbr[n] = mem[v_WADDR_A * pmi_data_width_a + n];
			for (n = 0; n < pmi_data_width_a; n = n+1)
			begin
				if ( (wr_a_wr_b_coll == 1) &&
					  ((v_WADDR_A * pmi_data_width_a + n) >= dn_coll_addr) &&
					  ((v_WADDR_A * pmi_data_width_a + n) <= up_coll_addr) )
					mem[v_WADDR_A * pmi_data_width_a + n] = 1'bX;
				else
					mem[v_WADDR_A * pmi_data_width_a + n] = DataInA_reg[n];
			end
		end // if (WrA_reg)
	
		if (WrB_reg == 1 && ClockB_valid == 1) 
		begin
			for (k = 0; k < pmi_data_width_b; k = k+1)
				QB_rbr[k] = mem[v_WADDR_B * pmi_data_width_b + k];
			for (k = 0; k < pmi_data_width_b; k = k+1)
			begin
				if ( (wr_a_wr_b_coll == 1) &&
					  ((v_WADDR_B * pmi_data_width_b + k) >= dn_coll_addr) &&
					  ((v_WADDR_B * pmi_data_width_b + k) <= up_coll_addr) )
					mem[v_WADDR_B * pmi_data_width_b + k] = 1'bX;
				else
					mem[v_WADDR_B * pmi_data_width_b + k] = DataInB_reg[k];
			end
		end // if (WrB_reg)
	end

//Read Operation

   //always @(!WrA_reg, AddressA_reg, posedge ResetA_sig, !WrB_reg, AddressB_reg, posedge ResetB_sig, memchg, ClockA_valid, ClockB_valid)
	always @(posedge ResetA_sig, posedge ResetB_sig, posedge ClockA, posedge ClockB, memchg, ClockA_valid, ClockB_valid)
	begin
		v_RADDR_A = AddressA_reg;
		v_RADDR_B = AddressB_reg;

		if (ResetA_sig == 1) begin
         if (pmi_resetmode == "sync")
         begin
            if (ClockA ==  1'b1)
               QA_int  <= 0;
         end
         else
            QA_int <= 0;
		end
		else if (ClockA_valid == 1)
		begin
			if (WrA_reg == 0)
			begin //Normal
				if (last_ClockA_valid == 0)
					for (l = 0; l < pmi_data_width_a; l = l+1)
					begin
						if ( (rd_a_wr_b_coll == 1) &&
							  ((v_RADDR_A * pmi_data_width_a + l) >= dn_coll_addr) &&
							  ((v_RADDR_A * pmi_data_width_a + l) <= up_coll_addr) )
							QA_int[l] <= 1'bX;
						else
							QA_int[l] <= mem[v_RADDR_A * pmi_data_width_a + l];
					end
			end
			else if (WrA_reg == 1) //Writethrough or readbeforewrite
			begin
				if (pmi_write_mode_a == "writethrough")
				begin
					for (l = 0; l < pmi_data_width_a; l = l+1)
						QA_int[l] <= mem[v_RADDR_A * pmi_data_width_a + l];
				end
				else if (pmi_write_mode_a == "readbeforewrite")
				begin
					if (pmi_family == "SC" || pmi_family == "SCM" ||
						 pmi_family == "ECP2" || pmi_family == "ECP2M" || pmi_family == "XP2")
						$display ("ERROR! WRITEMODE of READBEFOREWRITE is not supported !!!");
					if (last_ClockA_valid == 0)
						QA_int <= QA_rbr;
				end
			end
		end // if (ClockA_valid == 1)
	
		if (ResetB_sig == 1) begin
         if (pmi_resetmode == "sync")
         begin
            if (ClockB ==  1'b1)
               QB_int  <= 0;
         end
         else
            QB_int <= 0;
		end
		else if (ClockB_valid == 1)
		begin
			if (WrB_reg == 0)
			begin //Normal
				if (last_ClockB_valid == 0)
					for (m = 0; m < pmi_data_width_b; m = m+1)
					begin
						if ( (wr_a_rd_b_coll == 1) &&
							  ((v_RADDR_B * pmi_data_width_b + m) >= dn_coll_addr) &&
							  ((v_RADDR_B * pmi_data_width_b + m) <= up_coll_addr) )
							QB_int[m] <= 1'bX;
						else
							QB_int[m] <= mem[v_RADDR_B * pmi_data_width_b + m];
					end
			end
			else if (WrB_reg == 1) //Writethrough or readbeforewrite
			begin
				if (pmi_write_mode_b == "writethrough")
				begin
					for (m = 0; m < pmi_data_width_b; m = m+1)
						QB_int[m] <= mem[v_RADDR_B * pmi_data_width_b + m];
				end
				else if (pmi_write_mode_b == "readbeforewrite")
				begin
					if (pmi_family == "SC" || pmi_family == "SCM" ||
						 pmi_family == "ECP2" || pmi_family == "ECP2M" || pmi_family == "XP2")
						$display ("ERROR! WRITEMODE of READBEFOREWRITE is not supported !!!");
					if (last_ClockB_valid == 0)
						QB_int <= QB_rbr;
				end
			end
		end // if (ClockB_valid == 1)
	end

   //REGMODE
   always @ (QA_reg, QA_int) 
     begin
      if (pmi_regmode_a == "reg")
	QQA = QA_reg;
      else
	QQA = QA_int;
     end

      always @ (QB_reg, QB_int) 
     begin
      if (pmi_regmode_b == "reg")
	QQB = QB_reg;
      else
	QQB = QB_int;
     end

//pragma translate_on
endmodule // pmi_ram_dp_true

