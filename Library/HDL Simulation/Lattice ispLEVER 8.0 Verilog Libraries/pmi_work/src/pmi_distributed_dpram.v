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
// Simulation Library File for Dual Port Distributed RAM PMI
//
// Parameter Definition
//Name                  Value                                          Default
/*
------------------------------------------------------------------------------
pmi_addr_depth          <integer>                                         32
pmi_addr_width          <integer>                                          5
pmi_data_width          <integer>                                          8
pmi_regmode             "reg"|"noreg"                                    "reg"
pmi_init_file           <string>                                        "none"
pmi_init_file_format    "binary"|"hex"                                "binary"
pmi_family  "EC"|"XP"|"XP2"|"SC"|"SCM"|"ECP"|"ECP2"|"ECP2M"|"XO"|"ECP3"   "EC"
------------------------------------------------------------------------------
WARNING: Do not change the default parameters in this model. Parameter 
redefinition must be done using defparam or in-line (#) paramater 
redefinition in a top level file that instantiates this model.
 
*/

// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/pmi/RCS/pmi_distributed_dpram.v,v 1.6 2005/08/15 13:05:40 rag Exp $

`timescale 1 ns / 1 ps

module pmi_distributed_dpram 
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_regmode = "reg",
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC",
    parameter module_type = "pmi_distributed_dpram")

    (
    input [(pmi_addr_width-1):0] WrAddress,
    input [(pmi_data_width-1):0] Data,
    input WrClock,
    input WE,
    input WrClockEn,
    input [(pmi_addr_width-1):0] RdAddress,
    input RdClock,
    input RdClockEn,
    input Reset,
    output [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;

   //synopsys translate_off
   tri1    RdClock_wire;
   tri1    RdClockEn_wire;
   tri0    Reset_wire;
   //synopsys translate_on
    
   buf (RdClock_wire, RdClock);
   buf (RdClockEn_wire, RdClockEn);
   buf (Reset_wire, Reset);

//pragma translate_off

generate
   
   if (pmi_regmode == "reg")
   
   pmi_distributed_dpram_reg # (
				.pmi_addr_depth(pmi_addr_depth),
				.pmi_addr_width(pmi_addr_width),
				.pmi_data_width(pmi_data_width),
				.pmi_init_file(pmi_init_file),
				.pmi_init_file_format(pmi_init_file_format),
				.pmi_family(pmi_family))
      instreg (.Data(Data),
				  .WrAddress(WrAddress),
				  .RdAddress(RdAddress),
				  .WrClock(WrClock),
				  .RdClock(RdClock_wire),
				  .WrClockEn(WrClockEn),
				  .RdClockEn(RdClockEn_wire),
				  .WE(WE),
				  .Reset(Reset_wire),
				  .Q(Q));

   else

   pmi_distributed_dpram_noreg # (
				.pmi_addr_depth(pmi_addr_depth),
				.pmi_addr_width(pmi_addr_width),
				.pmi_data_width(pmi_data_width),
				.pmi_init_file(pmi_init_file),
				.pmi_init_file_format(pmi_init_file_format),
				.pmi_family(pmi_family))
      instnoreg (.Data(Data),
				  .WrAddress(WrAddress),
				  .RdAddress(RdAddress),
				  .WrClock(WrClock),
				  .WrClockEn(WrClockEn),
				  .WE(WE),
				  .Q(Q));
   endgenerate

//pragma translate_on
   
endmodule   
       
module pmi_distributed_dpram_noreg
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC")
    ( 
    input [(pmi_addr_width-1):0] WrAddress,
    input [(pmi_data_width-1):0] Data,
    input WrClock,
    input WE,
    input WrClockEn,
    input [(pmi_addr_width-1):0] RdAddress,
    output reg [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;

//pragma translate_off

   integer h;
   reg 	   memchg = 0;
   reg 	   wre_reg;
   reg [(pmi_data_width-1):0] din_reg;
   reg [(pmi_addr_width-1):0] waddr_reg;
   reg [(pmi_addr_width-1):0] raddr_reg;

   reg [pmi_data_width-1:0] mem [(2**pmi_addr_width)-1:0];

   //Function to calculate log2 of depth
   function  integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>0;  clogb2=clogb2+1)
             depth=depth>>>1;
    end
   endfunction // clogb2

//Error Checks
//Check for Address_width vs Address_depth
initial begin
   if (clogb2(pmi_addr_depth-1) > pmi_addr_width) begin
       $display("\nError! Address depth can not exceed (2**pmi_addr_width)!");
       $stop;
   end
	//These families don't support init files
   if ( ( (pmi_family == "EC") || (pmi_family == "XP") || (pmi_family == "XO") ||
          (pmi_family == "ECP") || (pmi_family == "ECP2") || (pmi_family == "ECP2M") ) &&
        (pmi_init_file != "none") )
	begin
       $display("\nError! This family doesn't support init files!");
       $stop;
   end
end

//Initialize the Memory. 

initial begin
   if (pmi_init_file == "none")
	begin
      if ( (pmi_family != "EC") && (pmi_family != "XP") && (pmi_family != "XO") &&
           (pmi_family != "ECP") && (pmi_family != "ECP2") && (pmi_family != "ECP2M") )
      	for (h = 0; h < 2**pmi_addr_width; h = h+1)
         	mem[h] = {pmi_data_width{1'b0}};
      else //Initialize memories of other families to X's
			for (h = 0; h < 2**pmi_addr_width; h = h+1)
         	mem[h] = {pmi_data_width{1'bX}};
	end
   else if ((pmi_init_file_format == "binary") && (pmi_init_file != "none"))
   begin
       $readmemb(pmi_init_file, mem);
   end
   else if ((pmi_init_file_format == "hex") && (pmi_init_file != "none")) 
   begin
       $readmemh(pmi_init_file, mem);
   end
end // initial begin


      // Latch the address and data in for writing
   // Registers are rising edge enabled
   always @ (posedge WrClock) begin
    if ((pmi_family == "SC") || (pmi_family == "SCM")) begin
       wre_reg <= WE && WrClockEn;
       din_reg <= Data;
       waddr_reg <= WrAddress;
    end
   end

   always @ (posedge WrClock) begin
      if ((pmi_family != "SC") && (pmi_family != "SCM")) begin
       wre_reg <= WE && WrClockEn;
       din_reg <= Data;
       waddr_reg <= WrAddress;
      end
   end


  always @ (RdAddress) begin
     raddr_reg = RdAddress;
  end

  always @ (negedge WrClock) begin
     if ((wre_reg === 1'b1) && ((pmi_family == "SC") || (pmi_family == "SCM"))) begin
          mem[waddr_reg] <= din_reg;
          memchg <= ~memchg;
     end
   end

 always @(din_reg, waddr_reg, wre_reg) begin
    if ((wre_reg === 1'b1) && ((pmi_family != "SC") && (pmi_family != "SCM"))) begin
       mem[waddr_reg] = din_reg;
       memchg = ~memchg;
    end
 end

  always @ (raddr_reg, memchg, mem[raddr_reg])
    begin
       Q = mem[raddr_reg];
    end

//pragma translate_on

endmodule   
    
  
module pmi_distributed_dpram_reg 
  #(parameter pmi_addr_depth = 32,
    parameter pmi_addr_width = 5,
    parameter pmi_data_width = 8,
    parameter pmi_init_file = "none",
    parameter pmi_init_file_format = "binary",
    parameter pmi_family = "EC")
   (
    input [(pmi_addr_width-1):0] WrAddress,
    input [(pmi_data_width-1):0] Data,
    input WrClock,
    input WE,
    input WrClockEn,
    input [(pmi_addr_width-1):0] RdAddress,
    input RdClock,
    input RdClockEn,
    input Reset,
    output reg [(pmi_data_width-1):0] Q)/* synthesis syn_black_box */;
//pragma translate_off

   integer h;
   reg 	   memchg = 0;
   reg 	   wre_reg;
   reg [(pmi_data_width-1):0] din_reg;
   reg [(pmi_addr_width-1):0] waddr_reg;
   reg [(pmi_addr_width-1):0] raddr_reg;

   reg [(pmi_data_width-1):0] data_out;	
 
   reg [pmi_data_width-1:0] mem [(2**pmi_addr_width)-1:0];

   //Function to calculate log2 of depth
   function  integer clogb2 (input integer depth);
    begin
        for(clogb2=0; depth>0;  clogb2=clogb2+1)
             depth=depth>>>1;
    end
   endfunction // clogb2

//Error Checks
//Check for Address_width vs Address_depth
initial begin
   if (clogb2(pmi_addr_depth-1) > pmi_addr_width) begin
       $display("\nError! Address depth can not exceed (2**pmi_addr_width)!");
       $stop;
   end
	//These families don't support init files
   if ( ( (pmi_family == "EC") || (pmi_family == "XP") || (pmi_family == "XO") ||
          (pmi_family == "ECP") || (pmi_family == "ECP2") || (pmi_family == "ECP2M") ) &&
        (pmi_init_file != "none") )
	begin
       $display("\nError! This family doesn't support init files!");
       $stop;
   end
end

//Initialize the Memory. 

initial begin
   if (pmi_init_file == "none")
	begin
      if ( (pmi_family != "EC") && (pmi_family != "XP") && (pmi_family != "XO") &&
           (pmi_family != "ECP") && (pmi_family != "ECP2") && (pmi_family != "ECP2M") )
      	for (h = 0; h < 2**pmi_addr_width; h = h+1)
         	mem[h] = {pmi_data_width{1'b0}};
      else //Initialize memories of other families to X's
			for (h = 0; h < 2**pmi_addr_width; h = h+1)
         	mem[h] = {pmi_data_width{1'bX}};
	end
   else if ((pmi_init_file_format == "binary") && (pmi_init_file != "none"))
   begin
       $readmemb(pmi_init_file, mem);
   end
   else if ((pmi_init_file_format == "hex") && (pmi_init_file != "none")) 
   begin
       $readmemh(pmi_init_file, mem);
   end
end // initial begin


   // Latch the address and data in for writing
   // Registers are rising edge enabled
   always @ (posedge WrClock) begin
    if ((pmi_family == "SC") || (pmi_family == "SCM")) begin
       wre_reg <= WE && WrClockEn;
       din_reg <= Data;
       waddr_reg <= WrAddress;
    end
   end

   always @ (posedge WrClock) begin
      if ((pmi_family != "SC") && (pmi_family != "SCM")) begin
       wre_reg <= WE && WrClockEn;
       din_reg <= Data;
       waddr_reg <= WrAddress;
      end
   end


  always @ (RdAddress) begin
     raddr_reg = RdAddress;
  end

  always @ (negedge WrClock) begin
     if ((wre_reg === 1'b1) && ((pmi_family == "SC") || (pmi_family == "SCM"))) begin
          mem[waddr_reg] <= din_reg;
          memchg <= ~memchg;
     end
   end

 always @(din_reg, waddr_reg, wre_reg) begin
    if ((wre_reg === 1'b1) && ((pmi_family != "SC") && (pmi_family != "SCM"))) begin
       mem[waddr_reg] = din_reg;
       memchg = ~memchg;
    end
 end

  always @ (raddr_reg, memchg, mem[raddr_reg])
    begin
       data_out = mem[raddr_reg];
    end

   always @(posedge Reset, posedge RdClock) begin
     if (Reset)
       Q <= 0;
     else if (RdClockEn) begin
	Q <= data_out;
     end
     else
       Q <= Q;
   end
   
//pragma translate_on

endmodule

