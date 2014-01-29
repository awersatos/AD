///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2007 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Cyclic Redundancy Check 32-bit Input Simulation Model
// /___/   /\     Filename : X_CRC32.v
// \   \  /  \    Timestamp : Fri Jun 18 10:57:01 PDT 2004
//  \___\/\___\
//
// Revision:
//    10/04/05 - Initial version.
//    12/04/05 - Added functionality
//    01/09/06 - Added Timing and LOC parameter
//    08/18/06 - CRS#421781 - CRCOUT initialized to 0 when GSR is high
//    09/14/06 - CR#423918  - CRCRESET is high, CRCOUT is INIT
//    07/24/07 - CR#442758 - Use CRCCLK instead of crcclk_int in always block
//    08/16/07 - CR#446564 - Add data_width as part of always block sensitivity list
//    10/22/07 - CR#452418 - Add all to sensitivity list
//    12/06/07 - CR#456124 - Add input/output buffers
//    05/13/08 - CR#468870 - Add negative setuphold support
//    07/01/08 - CR#475983 - Update CRCDATAWIDTH buffer - bus to bit
// End Revision
////////////////////////////////////////////////////////////////////////////////

`timescale  1 ps / 1 ps

`define POLYNOMIAL 32'h04C11DB7	// 00000100 11000001 00011101 10110111

module X_CRC32 (CRCOUT,
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
   input [31:0]  CRCIN;
   input 	 CRCRESET;

   tri0 GSR = glbl.GSR;
   
   wire gsr_in;

   reg 		 notifier;
   
   wire 	 crcclk_in, crcdatavalid_in, crcreset_in;
   wire [2:0] 	 crcdatawidth_in;
   wire [31:0]   crcin_in;
   
   reg [7:0] 	 data_in_32, data_in_24, data_in_16, data_in_8;
   reg [2:0] 	 data_width;
   reg 		 data_valid;
   
   reg [31:0] 	 crcd, crcreg;
   reg [40:0] 	 msg;
   reg [63:0] 	 i;
   
   reg [31:0] 	 crcgen_out_32, crcgen_out_24, crcgen_out_16, crcgen_out_8;
   wire [31:0] 	 crcgen_in_32, crcgen_in_24, crcgen_in_16, crcgen_in_8;

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
   
   always @(gsr_in, crcreg)
     begin
	if (gsr_in == 1'b1)
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
	  end // if (gsr_in == 1'b0)
     end // always @ (gsr_in, crcreg)
   
   // Register input data 

   always @ (posedge crcclk_in)
     begin
	data_in_8  <= crcin_in[31:24];
	data_in_16 <= crcin_in[23:16];
	data_in_24 <= crcin_in[15:8];
	data_in_32 <= crcin_in[7:0];
	data_valid <= crcdatavalid_in;
	data_width <= crcdatawidth_in;
     end 

   // Select between CRC8, CRC16, CRC24, CRC32 based on CRCDATAWIDTH
   
   always @ (crcgen_out_8 or  crcgen_out_16 or crcgen_out_24 or crcgen_out_32 or crcd or data_width)
     begin
	casex (data_width)
	  3'b000: crcd <= crcgen_out_8;
	  3'b001: crcd <= crcgen_out_16;
	  3'b010: crcd <= crcgen_out_24;
	  3'b011: crcd <= crcgen_out_32;
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
   

   // CRC Generator Logic
   
   always @(crcreg or crcin_in or data_width or data_in_8 or data_in_16 or data_in_24 or data_in_32)

     begin

	// CRC-8
	
	if (data_width == 3'b000) begin 
	   msg = crcreg ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7],24'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 8; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[40] == 1'b1) begin
		 msg[39:8] = msg[39:8] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_8 = msg[39:8];
	end 

	// CRC-16
	
	else if (data_width == 3'b001) begin 
	   msg = crcreg ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7],data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], 16'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 16; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[40] == 1'b1) begin
		 msg[39:8] = msg[39:8] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_16 = msg[39:8];
	end 
	
	//CRC-24
	
	else if (data_width == 3'b010) begin 
	   msg = crcreg ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7],8'h0};
	   msg = msg << 8;
	   
	   for (i = 0; i < 24; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[40] == 1'b1) begin
		 msg[39:8] = msg[39:8] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_24 = msg[39:8];
	   
	end 
	
	//CRC-32
	
	else if (data_width == 3'b011) begin 
	   msg = crcreg ^ {data_in_8[0], data_in_8[1], data_in_8[2], data_in_8[3], data_in_8[4], data_in_8[5], data_in_8[6], data_in_8[7], data_in_16[0], data_in_16[1], data_in_16[2], data_in_16[3], data_in_16[4], data_in_16[5], data_in_16[6], data_in_16[7], data_in_24[0], data_in_24[1], data_in_24[2], data_in_24[3], data_in_24[4], data_in_24[5], data_in_24[6], data_in_24[7], data_in_32[0], data_in_32[1], data_in_32[2], data_in_32[3], data_in_32[4], data_in_32[5], data_in_32[6], data_in_32[7]};
	   msg = msg << 8;
	   
	   for (i = 0; i < 32; i = i + 1) begin
	      msg = msg << 1;
	      if (msg[40] == 1'b1) begin
		 msg[39:8] = msg[39:8] ^ `POLYNOMIAL;
	      end
	   end
	   crcgen_out_32 = msg[39:8];
	   
	end 

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
      $setuphold (posedge CRCCLK, negedge CRCIN[3], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[3]);
      $setuphold (posedge CRCCLK, negedge CRCIN[4], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[4]);
      $setuphold (posedge CRCCLK, negedge CRCIN[5], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[5]);
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
      $setuphold (posedge CRCCLK, posedge CRCIN[3], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[3]);
      $setuphold (posedge CRCCLK, posedge CRCIN[4], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[4]);
      $setuphold (posedge CRCCLK, posedge CRCIN[5], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[5]);
      $setuphold (posedge CRCCLK, posedge CRCIN[6], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[6]);
      $setuphold (posedge CRCCLK, posedge CRCIN[7], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[7]);
      $setuphold (posedge CRCCLK, posedge CRCIN[8], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[8]);
      $setuphold (posedge CRCCLK, posedge CRCIN[9], 0:0:0, 0:0:0, notifier, , , crcclk_in, crcin_in[9]);
      $setuphold (posedge CRCCLK, posedge CRCRESET, 0:0:0, 0:0:0, notifier, , , crcclk_in, crcreset_in);
   
      specparam PATHPULSE$ = 0;

   endspecify
   
endmodule // X_CRC32


