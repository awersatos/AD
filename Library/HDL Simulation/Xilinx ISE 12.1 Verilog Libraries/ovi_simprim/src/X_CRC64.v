///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2007 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Cyclic Redundancy Check 64-bit Input Simulation Model// /___/   /\     Filename : X_CRC64.v
// \   \  /  \    Timestamp : Fri Jun 18 10:57:01 PDT 2004
//  \___\/\___\
//
// Revision:
//    10/04/05 - Initial version.
//    12/06/05 - Added functionality
//    01/09/05 - Added Timing and LOC parameter
//    08/18/06 - CRS#421781 - CRCOUT initialized to 0 when GSR is high
//    09/14/06 - CR#423918  - CRCRESET is high, CRCOUT is INIT
//    07/24/07 - CR#442758 - Use CRCCLK instead of crcclk_int in always block
//    08/16/07 - CR#446564 - Add data_width as part of always block sensitivity list
//    10/22/07 - CR#452418 - Add all to sensitivity list
//    12/06/07 - CR#456124 - Add input/output buffers
//    05/13/08 - CR#468870 - Add negative setuphold support
//    07/01/08 - CR#475983 - Update CRCDATAWIDTH buffer - bus to bit
// End Revision
///////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`define POLYNOMIAL 32'h04C11DB7	// 00000100 11000001 00011101 10110111

module X_CRC64 (
		CRCOUT,
		CRCCLK,
		CRCDATAVALID,
		CRCDATAWIDTH,
		CRCIN,
		CRCRESET
		);
   
   parameter CRC_INIT = 32'hFFFFFFFF;
   parameter LOC = "UNPLACED";
   
   output [31:0] CRCOUT;
   reg [31:0] crcout_out = 32'h00000000;
   
   input 	 CRCCLK;
   input 	 CRCDATAVALID;
   input [2:0] 	 CRCDATAWIDTH;
   input [63:0]  CRCIN;
   input 	 CRCRESET;

   tri0 	 GSR = glbl.GSR;
   wire 	 gsr_in;
   
   reg 		 notifier;
   
   wire 	 crcclk_in, crcdatavalid_in, crcreset_in;
   wire [2:0] 	 crcdatawidth_in;
   wire [63:0]   crcin_in;
   
   reg [7:0] 	 data_in_32, data_in_24, data_in_16, data_in_8;
   reg [7:0] 	 data_in_64, data_in_56, data_in_48, data_in_40;
   
   reg [2:0] 	 data_width;
   reg [1:0] 	 data_width_32;
   reg 		 data_width_64;
   reg 		 data_valid;
   
   reg [31:0] 	 crcd, crcreg;
   reg [72:0] 	 msg;
   reg [63:0] 	 i;
   
   reg [31:0] 	 crcgen_out_32, crcgen_out_24, crcgen_out_16, crcgen_out_8; 
   reg [31:0] 	 crcgen_out_64, crcgen_out_56, crcgen_out_48, crcgen_out_40;
   
   buf b_crcout[31:0] (CRCOUT, crcout_out);
   
   buf b_gsr (gsr_in, GSR);
   buf b_crcclk (crcclk_in, CRCCLK);
   buf b_crcdatavalid (crcdatavalid_in, CRCDATAVALID);
   buf b_crcdatawidth0 (crcdatawidth_in[0], CRCDATAWIDTH[0]);
   buf b_crcdatawidth1 (crcdatawidth_in[1], CRCDATAWIDTH[1]);
   buf b_crcdatawidth2 (crcdatawidth_in[2], CRCDATAWIDTH[2]);
   buf b_crcreset (crcreset_in, CRCRESET);
   buf b_crcin0 (crcin_in[0], CRCIN[0]);
   buf b_crcin1 (crcin_in[1], CRCIN[1]);
   buf b_crcin2 (crcin_in[2], CRCIN[2]);
   buf b_crcin3 (crcin_in[3], CRCIN[3]);
   buf b_crcin4 (crcin_in[4], CRCIN[4]);
   buf b_crcin5 (crcin_in[5], CRCIN[5]);
   buf b_crcin6 (crcin_in[6], CRCIN[6]);
   buf b_crcin7 (crcin_in[7], CRCIN[7]);
   buf b_crcin8 (crcin_in[8], CRCIN[8]);
   buf b_crcin9 (crcin_in[9], CRCIN[9]);
   buf b_crcin10 (crcin_in[10], CRCIN[10]);
   buf b_crcin11 (crcin_in[11], CRCIN[11]);
   buf b_crcin12 (crcin_in[12], CRCIN[12]);
   buf b_crcin13 (crcin_in[13], CRCIN[13]);
   buf b_crcin14 (crcin_in[14], CRCIN[14]);
   buf b_crcin15 (crcin_in[15], CRCIN[15]);
   buf b_crcin16 (crcin_in[16], CRCIN[16]);
   buf b_crcin17 (crcin_in[17], CRCIN[17]);
   buf b_crcin18 (crcin_in[18], CRCIN[18]);
   buf b_crcin19 (crcin_in[19], CRCIN[19]);
   buf b_crcin20 (crcin_in[20], CRCIN[20]);
   buf b_crcin21 (crcin_in[21], CRCIN[21]);
   buf b_crcin22 (crcin_in[22], CRCIN[22]);
   buf b_crcin23 (crcin_in[23], CRCIN[23]);
   buf b_crcin24 (crcin_in[24], CRCIN[24]);
   buf b_crcin25 (crcin_in[25], CRCIN[25]);
   buf b_crcin26 (crcin_in[26], CRCIN[26]);
   buf b_crcin27 (crcin_in[27], CRCIN[27]);
   buf b_crcin28 (crcin_in[28], CRCIN[28]);
   buf b_crcin29 (crcin_in[29], CRCIN[29]);
   buf b_crcin30 (crcin_in[30], CRCIN[30]);
   buf b_crcin31 (crcin_in[31], CRCIN[31]);
   buf b_crcin32 (crcin_in[32], CRCIN[32]);
   buf b_crcin33 (crcin_in[33], CRCIN[33]);
   buf b_crcin34 (crcin_in[34], CRCIN[34]);
   buf b_crcin35 (crcin_in[35], CRCIN[35]);
   buf b_crcin36 (crcin_in[36], CRCIN[36]);
   buf b_crcin37 (crcin_in[37], CRCIN[37]);
   buf b_crcin38 (crcin_in[38], CRCIN[38]);
   buf b_crcin39 (crcin_in[39], CRCIN[39]);
   buf b_crcin40 (crcin_in[40], CRCIN[40]);
   buf b_crcin41 (crcin_in[41], CRCIN[41]);
   buf b_crcin42 (crcin_in[42], CRCIN[42]);
   buf b_crcin43 (crcin_in[43], CRCIN[43]);
   buf b_crcin44 (crcin_in[44], CRCIN[44]);
   buf b_crcin45 (crcin_in[45], CRCIN[45]);
   buf b_crcin46 (crcin_in[46], CRCIN[46]);
   buf b_crcin47 (crcin_in[47], CRCIN[47]);
   buf b_crcin48 (crcin_in[48], CRCIN[48]);
   buf b_crcin49 (crcin_in[49], CRCIN[49]);
   buf b_crcin50 (crcin_in[50], CRCIN[50]);
   buf b_crcin51 (crcin_in[51], CRCIN[51]);
   buf b_crcin52 (crcin_in[52], CRCIN[52]);
   buf b_crcin53 (crcin_in[53], CRCIN[53]);
   buf b_crcin54 (crcin_in[54], CRCIN[54]);
   buf b_crcin55 (crcin_in[55], CRCIN[55]);
   buf b_crcin56 (crcin_in[56], CRCIN[56]);
   buf b_crcin57 (crcin_in[57], CRCIN[57]);
   buf b_crcin58 (crcin_in[58], CRCIN[58]);
   buf b_crcin59 (crcin_in[59], CRCIN[59]);
   buf b_crcin60 (crcin_in[60], CRCIN[60]);
   buf b_crcin61 (crcin_in[61], CRCIN[61]);
   buf b_crcin62 (crcin_in[62], CRCIN[62]);
   buf b_crcin63 (crcin_in[63], CRCIN[63]);

   always @(gsr_in, crcreg)
     begin
	if (gsr_in)
	  begin
	     assign crcout_out = 32'h00000000;
	  end
	else 
 	  begin
	     assign crcout_out = {!crcreg[24],!crcreg[25],!crcreg[26],
		    !crcreg[27],!crcreg[28],!crcreg[29],!crcreg[30],
		    !crcreg[31],!crcreg[16],!crcreg[17],!crcreg[18],
		    !crcreg[19],!crcreg[20],!crcreg[21],!crcreg[22],
		    !crcreg[23],
		    !crcreg[8],!crcreg[9],!crcreg[10],!crcreg[11],
		    !crcreg[12],!crcreg[13],!crcreg[14],!crcreg[15],
		    !crcreg[0],!crcreg[1],!crcreg[2],!crcreg[3],
		    !crcreg[4],!crcreg[5],!crcreg[6],!crcreg[7]};
	  end 
     end 
   
   
   // Register input data

   always @ (posedge crcclk_in)
     begin
	data_in_8  <= crcin_in[63:56];
	data_in_16 <= crcin_in[55:48];
	data_in_24 <= crcin_in[47:40];
	data_in_32 <= crcin_in[39:32];
	data_in_40 <= crcin_in[31:24];
	data_in_48 <= crcin_in[23:16];
	data_in_56 <= crcin_in[15:8];
	data_in_64 <= crcin_in[7:0];
	data_valid <= crcdatavalid_in;
	data_width <= crcdatawidth_in;
     end
   
   // Select between 8-bit, 16-bit, 24-bit, 32-bit, 40-bit, 48-bit, 56-bit and 64-bit based on CRCDATAWIDTH
   
   always @ (crcgen_out_8 or  crcgen_out_16 or crcgen_out_24 or crcgen_out_32 or 
	     crcgen_out_40 or  crcgen_out_48 or crcgen_out_56 or crcgen_out_64 or 
	     crcd or data_width)
     begin
	casex (data_width)
	  3'b000: crcd <= crcgen_out_8;
	  3'b001: crcd <= crcgen_out_16;
	  3'b010: crcd <= crcgen_out_24;
	  3'b011: crcd <= crcgen_out_32;
	  3'b100: crcd <= crcgen_out_40;
	  3'b101: crcd <= crcgen_out_48;
	  3'b110: crcd <= crcgen_out_56;
	  3'b111: crcd <= crcgen_out_64;
	  default: crcd <= crcgen_out_8;
	endcase
     end
   
   // 32-bit CRC internal register
   
   always @ (posedge crcclk_in)
     begin
	
	if (crcreset_in)
	  begin
	     crcreg <= CRC_INIT;
	  end
	else if (!data_valid)
	  begin
	     crcreg <= crcreg;
	  end
	else
	  begin
	     crcreg <= crcd;
	  end
     end
   
   
   //CRC Generator Logic
   
   always @(crcreg or crcin_in or data_width or data_in_8 or data_in_16 or data_in_24 or data_in_32 or data_in_40 or data_in_48 or data_in_56 or data_in_64)

     begin
	
	//CRC-8
	
	if (data_width == 3'b000) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7],56'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 8; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_8 = msg[71:40];
	end // if (data_width == 3'b000)
	
	//CRC-16
	
	else if (data_width ==3'b001) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7],data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], 48'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 16; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_16 = msg[71:40];
	end
	
	//CRC-24
	
	else if (data_width == 3'b010) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7],40'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 24; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_24 = msg[71:40];
	   
	end // if (data_width == 3'b010)
	
	//CRC-32
	
	else if (data_width == 3'b011) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7], data_in_32[0], data_in_32[1], data_in_32[2], data_in_32[3], data_in_32[4], data_in_32[5], data_in_32[6], data_in_32[7], 32'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 32; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_32 = msg[71:40];
	   
	end // if (data_width == 3'b011)
	
	//CRC-40
	
	else if (data_width == 3'b100) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7], data_in_32[0], data_in_32[1], data_in_32[2], data_in_32[3], data_in_32[4], data_in_32[5], data_in_32[6], data_in_32[7], data_in_40[0], data_in_40[1], data_in_40[2], data_in_40[3], data_in_40[4], data_in_40[5], data_in_40[6], data_in_40[7], 24'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 40; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_40 = msg[71:40];
	   
	end // if (data_width == 3'b100)
	
	//CRC-48
	
	else if (data_width == 3'b101) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7], data_in_32[0], data_in_32[1], data_in_32[2], data_in_32[3], data_in_32[4], data_in_32[5], data_in_32[6], data_in_32[7], data_in_40[0], data_in_40[1], data_in_40[2], data_in_40[3], data_in_40[4], data_in_40[5], data_in_40[6], data_in_40[7], data_in_48[0], data_in_48[1], data_in_48[2], data_in_48[3], data_in_48[4], data_in_48[5], data_in_48[6], data_in_48[7], 16'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 48; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_48 = msg[71:40];
	   
	end // if (data_width == 3'b101)
	
	//CRC-56
	
	else if (data_width == 3'b110) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7], data_in_32[0], data_in_32[1], data_in_32[2], data_in_32[3], data_in_32[4], data_in_32[5], data_in_32[6], data_in_32[7], data_in_40[0], data_in_40[1], data_in_40[2], data_in_40[3], data_in_40[4], data_in_40[5], data_in_40[6], data_in_40[7], data_in_48[0], data_in_48[1], data_in_48[2], data_in_48[3], data_in_48[4], data_in_48[5], data_in_48[6], data_in_48[7], data_in_56[0], data_in_56[1], data_in_56[2], data_in_56[3], data_in_56[4], data_in_56[5], data_in_56[6], data_in_56[7], 8'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 56; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_56 = msg[71:40];
	   
	end // if (data_width == 3'b110)

	//CRC-64
	
	else if (data_width == 3'b111) begin 
	   msg = {crcreg, 32'h0} ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7], data_in_32[0], data_in_32[1], data_in_32[2], data_in_32[3], data_in_32[4], data_in_32[5], data_in_32[6], data_in_32[7], data_in_40[0], data_in_40[1], data_in_40[2], data_in_40[3], data_in_40[4], data_in_40[5], data_in_40[6], data_in_40[7], data_in_48[0], data_in_48[1], data_in_48[2], data_in_48[3], data_in_48[4], data_in_48[5], data_in_48[6], data_in_48[7], data_in_56[0], data_in_56[1], data_in_56[2], data_in_56[3], data_in_56[4], data_in_56[5], data_in_56[6], data_in_56[7], data_in_64[0], data_in_64[1], data_in_64[2], data_in_64[3], data_in_64[4], data_in_64[5], data_in_64[6], data_in_64[7]};
	   msg = msg << 8;
	   
	   for (i = 0; i < 64; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[72] == 1'b1) begin
		 msg[71:40] = msg[71:40] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_64 = msg[71:40];
	   
	end // if (data_width == 3'b111)
	
     end // always @ (crcreg)

   
   specify
      
      (CRCCLK => CRCOUT[0]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[10]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[11]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[12]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[13]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[14]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[15]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[16]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[17]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[18]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[19]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[1]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[20]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[21]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[22]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[23]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[24]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[25]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[26]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[27]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[28]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[29]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[2]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[30]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[31]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[3]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[4]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[5]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[6]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[7]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[8]) = (100:100:100, 100:100:100);
      (CRCCLK => CRCOUT[9]) = (100:100:100, 100:100:100);
      
      $period (posedge CRCCLK, 0:0:0, notifier);
      
      $setuphold (posedge CRCCLK, negedge CRCDATAVALID, 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatavalid_in);
      $setuphold (posedge CRCCLK, negedge CRCDATAWIDTH[0], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatawidth_in[0]);
      $setuphold (posedge CRCCLK, negedge CRCDATAWIDTH[1], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatawidth_in[1]);
      $setuphold (posedge CRCCLK, negedge CRCDATAWIDTH[2], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatawidth_in[2]);
      $setuphold (posedge CRCCLK, negedge CRCIN[0], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[0]);
      $setuphold (posedge CRCCLK, negedge CRCIN[10], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[10]);
      $setuphold (posedge CRCCLK, negedge CRCIN[11], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[11]);
      $setuphold (posedge CRCCLK, negedge CRCIN[12], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[12]);
      $setuphold (posedge CRCCLK, negedge CRCIN[13], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[13]);
      $setuphold (posedge CRCCLK, negedge CRCIN[14], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[14]);
      $setuphold (posedge CRCCLK, negedge CRCIN[15], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[15]);
      $setuphold (posedge CRCCLK, negedge CRCIN[16], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[16]);
      $setuphold (posedge CRCCLK, negedge CRCIN[17], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[17]);
      $setuphold (posedge CRCCLK, negedge CRCIN[18], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[18]);
      $setuphold (posedge CRCCLK, negedge CRCIN[19], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[19]);
      $setuphold (posedge CRCCLK, negedge CRCIN[1], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[1]);
      $setuphold (posedge CRCCLK, negedge CRCIN[20], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[20]);
      $setuphold (posedge CRCCLK, negedge CRCIN[21], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[21]);
      $setuphold (posedge CRCCLK, negedge CRCIN[22], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[22]);
      $setuphold (posedge CRCCLK, negedge CRCIN[23], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[23]);
      $setuphold (posedge CRCCLK, negedge CRCIN[24], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[24]);
      $setuphold (posedge CRCCLK, negedge CRCIN[25], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[25]);
      $setuphold (posedge CRCCLK, negedge CRCIN[26], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[26]);
      $setuphold (posedge CRCCLK, negedge CRCIN[27], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[27]);
      $setuphold (posedge CRCCLK, negedge CRCIN[28], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[28]);
      $setuphold (posedge CRCCLK, negedge CRCIN[29], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[29]);
      $setuphold (posedge CRCCLK, negedge CRCIN[2], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[2]);
      $setuphold (posedge CRCCLK, negedge CRCIN[30], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[30]);
      $setuphold (posedge CRCCLK, negedge CRCIN[31], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[31]);
      $setuphold (posedge CRCCLK, negedge CRCIN[32], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[32]);
      $setuphold (posedge CRCCLK, negedge CRCIN[33], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[33]);
      $setuphold (posedge CRCCLK, negedge CRCIN[34], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[34]);
      $setuphold (posedge CRCCLK, negedge CRCIN[35], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[35]);
      $setuphold (posedge CRCCLK, negedge CRCIN[36], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[36]);
      $setuphold (posedge CRCCLK, negedge CRCIN[37], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[37]);
      $setuphold (posedge CRCCLK, negedge CRCIN[38], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[38]);
      $setuphold (posedge CRCCLK, negedge CRCIN[39], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[39]);
      $setuphold (posedge CRCCLK, negedge CRCIN[3], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[3]);
      $setuphold (posedge CRCCLK, negedge CRCIN[40], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[40]);
      $setuphold (posedge CRCCLK, negedge CRCIN[41], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[41]);
      $setuphold (posedge CRCCLK, negedge CRCIN[42], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[42]);
      $setuphold (posedge CRCCLK, negedge CRCIN[43], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[43]);
      $setuphold (posedge CRCCLK, negedge CRCIN[44], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[44]);
      $setuphold (posedge CRCCLK, negedge CRCIN[45], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[45]);
      $setuphold (posedge CRCCLK, negedge CRCIN[46], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[46]);
      $setuphold (posedge CRCCLK, negedge CRCIN[47], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[47]);
      $setuphold (posedge CRCCLK, negedge CRCIN[48], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[48]);
      $setuphold (posedge CRCCLK, negedge CRCIN[49], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[49]);
      $setuphold (posedge CRCCLK, negedge CRCIN[4], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[4]);
      $setuphold (posedge CRCCLK, negedge CRCIN[50], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[50]);
      $setuphold (posedge CRCCLK, negedge CRCIN[51], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[51]);
      $setuphold (posedge CRCCLK, negedge CRCIN[52], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[52]);
      $setuphold (posedge CRCCLK, negedge CRCIN[53], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[53]);
      $setuphold (posedge CRCCLK, negedge CRCIN[54], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[54]);
      $setuphold (posedge CRCCLK, negedge CRCIN[55], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[55]);
      $setuphold (posedge CRCCLK, negedge CRCIN[56], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[56]);
      $setuphold (posedge CRCCLK, negedge CRCIN[57], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[57]);
      $setuphold (posedge CRCCLK, negedge CRCIN[58], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[58]);
      $setuphold (posedge CRCCLK, negedge CRCIN[59], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[59]);
      $setuphold (posedge CRCCLK, negedge CRCIN[5], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[5]);
      $setuphold (posedge CRCCLK, negedge CRCIN[60], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[60]);
      $setuphold (posedge CRCCLK, negedge CRCIN[61], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[61]);
      $setuphold (posedge CRCCLK, negedge CRCIN[62], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[62]);
      $setuphold (posedge CRCCLK, negedge CRCIN[63], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[63]);
      $setuphold (posedge CRCCLK, negedge CRCIN[6], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[6]);
      $setuphold (posedge CRCCLK, negedge CRCIN[7], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[7]);
      $setuphold (posedge CRCCLK, negedge CRCIN[8], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[8]);
      $setuphold (posedge CRCCLK, negedge CRCIN[9], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[9]);
      $setuphold (posedge CRCCLK, negedge CRCRESET, 0:0:0, 0:0:0, notifier, , , crcclk_in, crcreset_in);
      $setuphold (posedge CRCCLK, posedge CRCDATAVALID, 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatavalid_in);
      $setuphold (posedge CRCCLK, posedge CRCDATAWIDTH[0], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatawidth_in[0]);
      $setuphold (posedge CRCCLK, posedge CRCDATAWIDTH[1], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatawidth_in[1]);
      $setuphold (posedge CRCCLK, posedge CRCDATAWIDTH[2], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcdatawidth_in[2]);
      $setuphold (posedge CRCCLK, posedge CRCIN[0], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[0]);
      $setuphold (posedge CRCCLK, posedge CRCIN[10], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[10]);
      $setuphold (posedge CRCCLK, posedge CRCIN[11], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[11]);
      $setuphold (posedge CRCCLK, posedge CRCIN[12], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[12]);
      $setuphold (posedge CRCCLK, posedge CRCIN[13], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[13]);
      $setuphold (posedge CRCCLK, posedge CRCIN[14], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[14]);
      $setuphold (posedge CRCCLK, posedge CRCIN[15], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[15]);
      $setuphold (posedge CRCCLK, posedge CRCIN[16], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[16]);
      $setuphold (posedge CRCCLK, posedge CRCIN[17], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[17]);
      $setuphold (posedge CRCCLK, posedge CRCIN[18], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[18]);
      $setuphold (posedge CRCCLK, posedge CRCIN[19], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[19]);
      $setuphold (posedge CRCCLK, posedge CRCIN[1], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[1]);
      $setuphold (posedge CRCCLK, posedge CRCIN[20], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[20]);
      $setuphold (posedge CRCCLK, posedge CRCIN[21], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[21]);
      $setuphold (posedge CRCCLK, posedge CRCIN[22], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[22]);
      $setuphold (posedge CRCCLK, posedge CRCIN[23], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[23]);
      $setuphold (posedge CRCCLK, posedge CRCIN[24], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[24]);
      $setuphold (posedge CRCCLK, posedge CRCIN[25], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[25]);
      $setuphold (posedge CRCCLK, posedge CRCIN[26], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[26]);
      $setuphold (posedge CRCCLK, posedge CRCIN[27], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[27]);
      $setuphold (posedge CRCCLK, posedge CRCIN[28], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[28]);
      $setuphold (posedge CRCCLK, posedge CRCIN[29], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[29]);
      $setuphold (posedge CRCCLK, posedge CRCIN[2], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[2]);
      $setuphold (posedge CRCCLK, posedge CRCIN[30], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[30]);
      $setuphold (posedge CRCCLK, posedge CRCIN[31], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[31]);
      $setuphold (posedge CRCCLK, posedge CRCIN[32], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[32]);
      $setuphold (posedge CRCCLK, posedge CRCIN[33], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[33]);
      $setuphold (posedge CRCCLK, posedge CRCIN[34], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[34]);
      $setuphold (posedge CRCCLK, posedge CRCIN[35], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[35]);
      $setuphold (posedge CRCCLK, posedge CRCIN[36], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[36]);
      $setuphold (posedge CRCCLK, posedge CRCIN[37], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[37]);
      $setuphold (posedge CRCCLK, posedge CRCIN[38], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[38]);
      $setuphold (posedge CRCCLK, posedge CRCIN[39], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[39]);
      $setuphold (posedge CRCCLK, posedge CRCIN[3], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[3]);
      $setuphold (posedge CRCCLK, posedge CRCIN[40], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[40]);
      $setuphold (posedge CRCCLK, posedge CRCIN[41], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[41]);
      $setuphold (posedge CRCCLK, posedge CRCIN[42], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[42]);
      $setuphold (posedge CRCCLK, posedge CRCIN[43], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[43]);
      $setuphold (posedge CRCCLK, posedge CRCIN[44], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[44]);
      $setuphold (posedge CRCCLK, posedge CRCIN[45], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[45]);
      $setuphold (posedge CRCCLK, posedge CRCIN[46], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[46]);
      $setuphold (posedge CRCCLK, posedge CRCIN[47], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[47]);
      $setuphold (posedge CRCCLK, posedge CRCIN[48], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[48]);
      $setuphold (posedge CRCCLK, posedge CRCIN[49], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[49]);
      $setuphold (posedge CRCCLK, posedge CRCIN[4], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[4]);
      $setuphold (posedge CRCCLK, posedge CRCIN[50], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[50]);
      $setuphold (posedge CRCCLK, posedge CRCIN[51], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[51]);
      $setuphold (posedge CRCCLK, posedge CRCIN[52], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[52]);
      $setuphold (posedge CRCCLK, posedge CRCIN[53], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[53]);
      $setuphold (posedge CRCCLK, posedge CRCIN[54], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[54]);
      $setuphold (posedge CRCCLK, posedge CRCIN[55], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[55]);
      $setuphold (posedge CRCCLK, posedge CRCIN[56], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[56]);
      $setuphold (posedge CRCCLK, posedge CRCIN[57], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[57]);
      $setuphold (posedge CRCCLK, posedge CRCIN[58], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[58]);
      $setuphold (posedge CRCCLK, posedge CRCIN[59], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[59]);
      $setuphold (posedge CRCCLK, posedge CRCIN[5], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[5]);
      $setuphold (posedge CRCCLK, posedge CRCIN[60], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[60]);
      $setuphold (posedge CRCCLK, posedge CRCIN[61], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[61]);
      $setuphold (posedge CRCCLK, posedge CRCIN[62], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[62]);
      $setuphold (posedge CRCCLK, posedge CRCIN[63], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[63]);
      $setuphold (posedge CRCCLK, posedge CRCIN[6], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[6]);
      $setuphold (posedge CRCCLK, posedge CRCIN[7], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[7]);
      $setuphold (posedge CRCCLK, posedge CRCIN[8], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[8]);
      $setuphold (posedge CRCCLK, posedge CRCIN[9], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[9]);
      $setuphold (posedge CRCCLK, posedge CRCRESET, 0:0:0, 0:0:0, notifier, , , crcclk_in, crcreset_in);
   
      specparam PATHPULSE$ = 0;

   endspecify

endmodule // X_CRC64




