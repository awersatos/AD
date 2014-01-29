// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_FIFO36_EXP.v,v 1.15 2009/08/22 00:02:07 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.23)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  36K-Bit FIFO
// /___/   /\     Filename : X_FIFO36_EXP.v
// \   \  /  \    Timestamp : Tues July 26 16:44:06 PST 2005
//  \___\/\___\
//
// Revision:
//    07/26/05 - Initial version.
//    12/07/06 - Fixed data output (CR 426370).
//    06/01/07 - Added wire declaration for internal signals.
//    04/29/09 - Fixed timing violation for asynchronous reset (CR 519016).
// End Revision

`timescale 1 ps/1 ps

module X_FIFO36_EXP (ALMOSTEMPTY, ALMOSTFULL, DO, DOP, EMPTY, FULL, RDCOUNT, RDERR, WRCOUNT, WRERR,
		     DI, DIP, RDCLKL, RDCLKU, RDEN, RDRCLKL, RDRCLKU, RST, WRCLKL, WRCLKU, WREN);
 
    output ALMOSTEMPTY;
    output ALMOSTFULL;
    output [31:0] DO;
    output [3:0] DOP;
    output EMPTY;
    output FULL;
    output [12:0] RDCOUNT;
    output RDERR;
    output [12:0] WRCOUNT;
    output WRERR;

    input [31:0] DI;
    input [3:0] DIP;
    input RDCLKL;
    input RDCLKU;
    input RDEN;
    input RDRCLKL;
    input RDRCLKU;
    input RST;
    input WRCLKL;
    input WRCLKU;
    input WREN;

    tri0 GSR = glbl.GSR;
    
    parameter ALMOST_EMPTY_OFFSET = 13'h0080;
    parameter ALMOST_FULL_OFFSET = 13'h0080;
    parameter integer DATA_WIDTH = 4;
    parameter integer DO_REG = 1;
    parameter EN_SYN = "FALSE";
    parameter FIRST_WORD_FALL_THROUGH = "FALSE";
    parameter LOC = "UNPLACED";
    
    wire [31:0] dangle_out32, di_in, do_wire;
    wire [3:0] dangle_out4, dip_in, dop_wire;
    wire [7:0] dangle_out8;
    wire dangle_out;
    reg notifier, notifier_wrclk, notifier_rdclk;
    reg [31:0] do_out;
    reg [3:0] dop_out;
    reg [12:0] wrcount_out, rdcount_out;
    reg almostempty_out, almostfull_out, empty_out, full_out;
    reg rderr_out, wrerr_out;
    
    wire almostempty_wire, empty_wire, rderr_wire;
    wire almostfull_wire, full_wire, wrerr_wire;
    wire [12:0] wrcount_wire, rdcount_wire;
    wire nrst, wren_enable;
    wire rdclkl_in, wrclkl_in, rden_in, wren_in, rst_in;
    wire rdrclkl_in, sbiterr_out, dbiterr_out;
	 
    buf b_di[31:0] (di_in, DI);
    buf b_dip[3:0] (dip_in, DIP);
    buf b_do[31:0] (DO, do_out);
    buf b_dop[3:0] (DOP, dop_out);
    buf b_rdclkl (rdclkl_in, RDCLKL);
    buf b_rdrclkl (rdrclkl_in, RDRCLKL);
    buf b_rden (rden_in, RDEN);
    buf b_rst (rst_in, RST);
    buf b_wrclk (wrclkl_in, WRCLKL);
    buf b_wren (wren_in, WREN);

    buf b_out0 (ALMOSTEMPTY, almostempty_out);
    buf b_out1 (ALMOSTFULL, almostfull_out);
    buf b_empty (EMPTY, empty_out);
    buf b_full (FULL, full_out);
    buf b_rderr (RDERR, rderr_out);
    buf b_wrerr (WRERR, wrerr_out);    
    buf b_rdcount[12:0] (RDCOUNT, rdcount_out);
    buf b_wrcount[12:0] (WRCOUNT, wrcount_out);

    always @(almostfull_wire or wrclkl_in) almostfull_out = almostfull_wire;
    always @(full_wire or wrclkl_in) full_out = full_wire;
    always @(wrerr_wire or wrclkl_in) wrerr_out = wrerr_wire;
    always @(wrcount_wire or wrclkl_in) wrcount_out = wrcount_wire;

    always @(almostempty_wire or rdclkl_in) almostempty_out = almostempty_wire;
    always @(empty_wire or rdclkl_in) empty_out = empty_wire;
    always @(rderr_wire or rdclkl_in) rderr_out = rderr_wire;
    always @(rdcount_wire or rdclkl_in) rdcount_out = rdcount_wire;
    
    always @(do_wire or rdclkl_in) do_out = do_wire;
    always @(dop_wire or rdclkl_in) dop_out = dop_wire;
    
    X_AFIFO36_INTERNAL INT_FIFO (.ALMOSTEMPTY(almostempty_wire), .ALMOSTFULL(almostfull_wire), .DBITERR(dangle_out), .DO({dangle_out32,do_wire}), .DOP({dangle_out4,dop_wire}), .ECCPARITY(dangle_out8), .EMPTY(empty_wire), .FULL(full_wire), .RDCOUNT(rdcount_wire), .RDERR(rderr_wire), .SBITERR(dangle_out), .WRCOUNT(wrcount_wire), .WRERR(wrerr_wire),
			      .DI({32'b0,di_in}), .DIP({4'b0,dip_in}), .RDCLK(rdclkl_in), .RDEN(rden_in), .RDRCLK(rdrclkl_in), .RST(rst_in), .WRCLK(wrclkl_in), .WREN(wren_in));

    defparam INT_FIFO.ALMOST_EMPTY_OFFSET = ALMOST_EMPTY_OFFSET;
    defparam INT_FIFO.ALMOST_FULL_OFFSET = ALMOST_FULL_OFFSET;
    defparam INT_FIFO.DATA_WIDTH = DATA_WIDTH;
    defparam INT_FIFO.DO_REG = DO_REG;    
    defparam INT_FIFO.EN_SYN = EN_SYN;
    defparam INT_FIFO.FIRST_WORD_FALL_THROUGH = FIRST_WORD_FALL_THROUGH;


//*** Timing Checks Start here
    
    always @(notifier) begin
	do_out <= 32'bx;
	dop_out <= 4'bx;
    end

    always @(notifier_wrclk) begin
	almostfull_out <= 1'bx;
	full_out <= 1'bx;
	wrcount_out <= 13'bx;
	wrerr_out <= 1'bx;
    end
    
    always @(notifier_rdclk) begin
	almostempty_out <= 1'bx;
	empty_out <= 1'bx;
	rdcount_out <= 13'bx;
	rderr_out <= 1'bx;
    end
    
    not (nrst, RST);
    and (wren_enable, WREN, nrst);

    specify

	(RDCLKL => ALMOSTEMPTY) = (100:100:100, 100:100:100);
	(RDCLKL => DOP[0]) = (100:100:100, 100:100:100);
	(RDCLKL => DOP[1]) = (100:100:100, 100:100:100);
	(RDCLKL => DOP[2]) = (100:100:100, 100:100:100);
	(RDCLKL => DOP[3]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[0]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[10]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[11]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[12]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[13]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[14]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[15]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[16]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[17]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[18]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[19]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[1]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[20]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[21]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[22]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[23]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[24]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[25]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[26]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[27]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[28]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[29]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[2]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[30]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[31]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[3]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[4]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[5]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[6]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[7]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[8]) = (100:100:100, 100:100:100);
	(RDCLKL => DO[9]) = (100:100:100, 100:100:100);
	(RDCLKL => EMPTY) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[0]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[10]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[11]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[12]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[1]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[2]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[3]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[4]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[5]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[6]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[7]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[8]) = (100:100:100, 100:100:100);
	(RDCLKL => RDCOUNT[9]) = (100:100:100, 100:100:100);
	(RDCLKL => RDERR) = (100:100:100, 100:100:100);

	(RDRCLKL => ALMOSTEMPTY) = (100:100:100, 100:100:100);
	(RDRCLKL => DOP[0]) = (100:100:100, 100:100:100);
	(RDRCLKL => DOP[1]) = (100:100:100, 100:100:100);
	(RDRCLKL => DOP[2]) = (100:100:100, 100:100:100);
	(RDRCLKL => DOP[3]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[0]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[10]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[11]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[12]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[13]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[14]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[15]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[16]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[17]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[18]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[19]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[1]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[20]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[21]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[22]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[23]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[24]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[25]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[26]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[27]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[28]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[29]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[2]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[30]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[31]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[3]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[4]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[5]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[6]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[7]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[8]) = (100:100:100, 100:100:100);
	(RDRCLKL => DO[9]) = (100:100:100, 100:100:100);
	(RDRCLKL => EMPTY) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[0]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[10]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[11]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[12]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[1]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[2]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[3]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[4]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[5]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[6]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[7]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[8]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDCOUNT[9]) = (100:100:100, 100:100:100);
	(RDRCLKL => RDERR) = (100:100:100, 100:100:100);
	
	(WRCLKL => ALMOSTFULL) = (100:100:100, 100:100:100);
	(WRCLKL => FULL) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[0]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[10]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[11]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[12]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[1]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[2]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[3]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[4]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[5]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[6]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[7]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[8]) = (100:100:100, 100:100:100);
	(WRCLKL => WRCOUNT[9]) = (100:100:100, 100:100:100);
	(WRCLKL => WRERR) = (100:100:100, 100:100:100);

	(RST => ALMOSTEMPTY) = (0:0:0, 0:0:0);
	(RST => EMPTY) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[0]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[10]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[11]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[12]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[1]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[2]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[3]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[4]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[5]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[6]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[7]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[8]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[9]) = (0:0:0, 0:0:0);
	(RST => RDERR) = (0:0:0, 0:0:0);
	(RST => ALMOSTFULL) = (0:0:0, 0:0:0);
	(RST => FULL) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[0]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[10]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[11]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[12]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[1]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[2]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[3]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[4]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[5]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[6]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[7]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[8]) = (0:0:0, 0:0:0);
	(RST => WRCOUNT[9]) = (0:0:0, 0:0:0);
	(RST => WRERR) = (0:0:0, 0:0:0);
	
	$setuphold (posedge RDCLKL, negedge RST, 0:0:0, 0:0:0);
	$setuphold (posedge RDCLKL, posedge RST, 0:0:0, 0:0:0);
	$setuphold (posedge RDCLKL, negedge RDEN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge RDCLKL, posedge RDEN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge RDRCLKL, negedge RDEN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge RDRCLKL, posedge RDEN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DIP[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DIP[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DIP[2] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DIP[3] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[10] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[11] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[12] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[13] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[14] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[15] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[16] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[17] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[18] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[19] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[20] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[21] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[22] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[23] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[24] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[25] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[26] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[27] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[28] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[29] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[2] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[30] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[31] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[3] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[4] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[5] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[6] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[7] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[8] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge DI[9] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, negedge WREN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DIP[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DIP[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DIP[2] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DIP[3] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[10] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[11] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[12] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[13] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[14] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[15] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[16] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[17] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[18] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[19] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[20] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[21] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[22] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[23] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[24] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[25] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[26] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[27] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[28] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[29] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[2] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[30] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[31] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[3] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[4] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[5] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[6] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[7] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[8] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge DI[9] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLKL, posedge WREN &&& (RST==0), 0:0:0, 0:0:0);

	$recrem (negedge RST, posedge RDCLKL, 0:0:0, 0:0:0, notifier_rdclk);
	$recrem (negedge RST, posedge RDRCLKL, 0:0:0, 0:0:0, notifier_rdclk);
	$recrem (negedge RST, posedge WRCLKL, 0:0:0, 0:0:0, notifier_wrclk);
	$period (posedge RDCLKL, 0:0:0, notifier);
	$period (posedge RDRCLKL, 0:0:0, notifier);
	$period (posedge WRCLKL, 0:0:0, notifier);
	$width (posedge RDCLKL, 0:0:0, 0, notifier);
	$width (negedge RDCLKL, 0:0:0, 0, notifier);
	$width (posedge RDRCLKL, 0:0:0, 0, notifier);
	$width (negedge RDRCLKL, 0:0:0, 0, notifier);
	$width (posedge WRCLKL, 0:0:0, 0, notifier);
	$width (negedge WRCLKL, 0:0:0, 0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	specparam PATHPULSE$ = 0;

    endspecify
    
endmodule // X_FIFO36_EXP
