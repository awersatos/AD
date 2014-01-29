// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_RAM64M.v,v 1.6 2008/05/13 00:22:33 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1i (L.12)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                 64-Deep by 4-bit Wide Multi Port RAM 
// /___/   /\     Filename : X_RAM64M.v
// \   \  /  \    Timestamp : 
//  \___\/\___\
//
// Revision:
//    03/21/06 - Initial version.
//    12/01/06 - Fix the cut/past error for port C and D (CR 430051)
//    05/07/08 - Add negative setup/hold support (CR468872)
// End Revision

`timescale 1 ps/1 ps

module X_RAM64M (DOA, DOB, DOC, DOD, ADDRA, ADDRB, ADDRC, ADDRD, DIA, DIB, DIC, DID, WCLK, WE);

  parameter  INIT_A = 64'h0000000000000000;
  parameter  INIT_B = 64'h0000000000000000;
  parameter  INIT_C = 64'h0000000000000000;
  parameter  INIT_D = 64'h0000000000000000;

  parameter LOC = "UNPLACED";
  output DOA;
  output DOB;
  output DOC;
  output DOD;
  input [5:0] ADDRA;
  input [5:0] ADDRB;
  input [5:0] ADDRC;
  input [5:0] ADDRD;
  input  DIA;
  input  DIB;
  input  DIC;
  input  DID;
  input WCLK;
  input WE;

  reg [63:0] mem_a, mem_b, mem_c, mem_d;
  wire [5:0] ADDRD_dly;
  wire DIA_dly, DIB_dly, DIC_dly, DID_dly, WCLK_dly, WE_dly;
  reg notifier;


  initial begin
    mem_a = INIT_A;
    mem_b = INIT_B;
    mem_c = INIT_C;
    mem_d = INIT_D;
  end

  always @(posedge WCLK_dly)
    if (WE_dly) begin
      mem_a[ADDRD_dly] <= #100 DIA_dly;
      mem_b[ADDRD_dly] <= #100 DIB_dly;
      mem_c[ADDRD_dly] <= #100 DIC_dly;
      mem_d[ADDRD_dly] <= #100 DID_dly;
  end

   assign  DOA = mem_a[ADDRA];
   assign  DOB = mem_b[ADDRB];
   assign  DOC = mem_c[ADDRC];
   assign  DOD = mem_d[ADDRD];

  always @(notifier) begin
      mem_a[ADDRD_dly] <= 1'bx;
      mem_b[ADDRD_dly] <= 1'bx;
      mem_c[ADDRD_dly] <= 1'bx;
      mem_d[ADDRD_dly] <= 1'bx;
  end


  specify

	(WCLK => DOA) = (0:0:0, 0:0:0);
	(WCLK => DOB) = (0:0:0, 0:0:0);
	(WCLK => DOC) = (0:0:0, 0:0:0);
	(WCLK => DOD) = (0:0:0, 0:0:0);
	(ADDRA *> DOA) = (0:0:0, 0:0:0);
	(ADDRB *> DOB) = (0:0:0, 0:0:0);
	(ADDRC *> DOC) = (0:0:0, 0:0:0);
	(ADDRD *> DOD) = (0:0:0, 0:0:0);

	$setuphold (posedge WCLK, posedge DIA &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIA_dly);
	$setuphold (posedge WCLK, negedge DIA &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIA_dly);
	$setuphold (posedge WCLK, posedge DIB &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIB_dly);
	$setuphold (posedge WCLK, negedge DIB &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIB_dly);
	$setuphold (posedge WCLK, posedge DIC &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIC_dly);
	$setuphold (posedge WCLK, negedge DIC &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DIC_dly);
	$setuphold (posedge WCLK, posedge DID &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DID_dly);
	$setuphold (posedge WCLK, negedge DID &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,DID_dly);

	$setuphold (posedge WCLK, posedge ADDRD[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[0]);
	$setuphold (posedge WCLK, negedge ADDRD[0] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[0]);
	$setuphold (posedge WCLK, posedge ADDRD[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[1]);
	$setuphold (posedge WCLK, negedge ADDRD[1] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[1]);
	$setuphold (posedge WCLK, posedge ADDRD[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[2]);
	$setuphold (posedge WCLK, negedge ADDRD[2] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[2]);
	$setuphold (posedge WCLK, posedge ADDRD[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[3]);
	$setuphold (posedge WCLK, negedge ADDRD[3] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[3]);
	$setuphold (posedge WCLK, posedge ADDRD[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[4]);
	$setuphold (posedge WCLK, negedge ADDRD[4] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[4]);
	$setuphold (posedge WCLK, posedge ADDRD[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[5]);
	$setuphold (posedge WCLK, negedge ADDRD[5] &&& WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,ADDRD_dly[5]);

	$setuphold (posedge WCLK, posedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);
	$setuphold (posedge WCLK, negedge WE, 0:0:0, 0:0:0, notifier,,,WCLK_dly,WE_dly);

        $period (posedge WCLK &&& WE, 0:0:0, notifier);

	specparam PATHPULSE$ = 0;

  endspecify

endmodule
