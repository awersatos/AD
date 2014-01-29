// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_FIFO18.v,v 1.14 2009/08/22 00:02:07 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.23)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  18K-Bit FIFO
// /___/   /\     Filename : X_FIFO18.v
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

module X_FIFO18 (ALMOSTEMPTY, ALMOSTFULL, DO, DOP, EMPTY, FULL, RDCOUNT, RDERR, WRCOUNT, WRERR,
		 DI, DIP, RDCLK, RDEN, RST, WRCLK, WREN);
 
    output ALMOSTEMPTY;
    output ALMOSTFULL;
    output [15:0] DO;
    output [1:0] DOP;
    output EMPTY;
    output FULL;
    output [11:0] RDCOUNT;
    output RDERR;
    output [11:0] WRCOUNT;
    output WRERR;

    input [15:0] DI;
    input [1:0] DIP;
    input RDCLK;
    input RDEN;
    input RST;
    input WRCLK;
    input WREN;

    tri0 GSR = glbl.GSR;
    
    parameter ALMOST_EMPTY_OFFSET = 12'h080;
    parameter ALMOST_FULL_OFFSET = 12'h080;
    parameter integer DATA_WIDTH = 4;
    parameter integer DO_REG = 1;
    parameter EN_SYN = "FALSE";
    parameter FIRST_WORD_FALL_THROUGH = "FALSE";
    parameter LOC = "UNPLACED";
    
    wire [47:0] dangle_out48;
    wire [5:0] dangle_out6;
    wire [7:0] dangle_out8;
    wire dangle_out;
    reg notifier, notifier_wrclk, notifier_rdclk;
    reg [15:0] do_out;
    reg [1:0] dop_out;
    reg [11:0] wrcount_out, rdcount_out;
    reg almostempty_out, almostfull_out, empty_out, full_out;
    reg rderr_out, wrerr_out;
    
    wire almostempty_wire, empty_wire, rderr_wire;
    wire almostfull_wire, full_wire, wrerr_wire;
    wire [11:0] wrcount_wire, rdcount_wire;
    wire [15:0] di_in, do_wire;
    wire [1:0] dip_in, dop_wire;
    wire rdclk_in, rden_in, rst_in, wrclk_in, wren_in;
    wire nrst, wren_enable;
    
    buf b_di[15:0] (di_in, DI);
    buf b_dip[1:0] (dip_in, DIP);
    buf b_do[15:0] (DO, do_out);
    buf b_dop[1:0] (DOP, dop_out);
    buf b_rdclk (rdclk_in, RDCLK);
    buf b_rden (rden_in, RDEN);
    buf b_rst (rst_in, RST);
    buf b_wrclk (wrclk_in, WRCLK);
    buf b_wren (wren_in, WREN);

    buf b_out0 (ALMOSTEMPTY, almostempty_out);
    buf b_out1 (ALMOSTFULL, almostfull_out);
    buf b_empty (EMPTY, empty_out);
    buf b_full (FULL, full_out);
    buf b_rderr (RDERR, rderr_out);
    buf b_wrerr (WRERR, wrerr_out);    
    buf b_rdcount[11:0] (RDCOUNT, rdcount_out);
    buf b_wrcount[11:0] (WRCOUNT, wrcount_out);
    
    always @(almostfull_wire or wrclk_in) almostfull_out = almostfull_wire;
    always @(full_wire or wrclk_in) full_out = full_wire;
    always @(wrerr_wire or wrclk_in) wrerr_out = wrerr_wire;
    always @(wrcount_wire or wrclk_in) wrcount_out = wrcount_wire;

    always @(almostempty_wire or rdclk_in) almostempty_out = almostempty_wire;
    always @(empty_wire or rdclk_in) empty_out = empty_wire;
    always @(rderr_wire or rdclk_in) rderr_out = rderr_wire;
    always @(rdcount_wire or rdclk_in) rdcount_out = rdcount_wire;
    
    always @(do_wire or rdclk_in) do_out = do_wire;
    always @(dop_wire or rdclk_in) dop_out = dop_wire;
    
    X_AFIFO36_INTERNAL INT_FIFO (.ALMOSTEMPTY(almostempty_wire), .ALMOSTFULL(almostfull_wire), .DBITERR(dangle_out), .DO({dangle_out48,do_wire}), .DOP({dangle_out6,dop_wire}), .ECCPARITY(dangle_out8), .EMPTY(empty_wire), .FULL(full_wire), .RDCOUNT({dangle_out,rdcount_wire}), .RDERR(rderr_wire), .SBITERR(dangle_out), .WRCOUNT({dangle_out,wrcount_wire}), .WRERR(wrerr_wire), .DI({48'b0,di_in}), .DIP({6'b0,dip_in}), .RDCLK(rdclk_in), .RDEN(rden_in), .RDRCLK(rdclk_in), .RST(rst_in), .WRCLK(wrclk_in), .WREN(wren_in));

    defparam INT_FIFO.FIFO_SIZE = 18;
    defparam INT_FIFO.ALMOST_EMPTY_OFFSET = ALMOST_EMPTY_OFFSET;
    defparam INT_FIFO.ALMOST_FULL_OFFSET = ALMOST_FULL_OFFSET;
    defparam INT_FIFO.DATA_WIDTH = DATA_WIDTH;
    defparam INT_FIFO.DO_REG = DO_REG;
    defparam INT_FIFO.EN_SYN = EN_SYN;
    defparam INT_FIFO.FIRST_WORD_FALL_THROUGH = FIRST_WORD_FALL_THROUGH;


//*** Timing Checks Start here

    always @(notifier) begin
	do_out <= 16'bx;
	dop_out <= 2'bx;
    end

    always @(notifier_wrclk) begin
	almostfull_out <= 1'bx;
	full_out <= 1'bx;
	wrcount_out <= 12'bx;
	wrerr_out <= 1'bx;
    end
    
    always @(notifier_rdclk) begin
	almostempty_out <= 1'bx;
	empty_out <= 1'bx;
	rdcount_out <= 12'bx;
	rderr_out <= 1'bx;
    end
    
    not (nrst, RST);
    and (wren_enable, WREN, nrst);

    specify

	(RDCLK => ALMOSTEMPTY) = (100:100:100, 100:100:100);
	(RDCLK => DOP[0]) = (100:100:100, 100:100:100);
	(RDCLK => DOP[1]) = (100:100:100, 100:100:100);
	(RDCLK => DO[0]) = (100:100:100, 100:100:100);
	(RDCLK => DO[10]) = (100:100:100, 100:100:100);
	(RDCLK => DO[11]) = (100:100:100, 100:100:100);
	(RDCLK => DO[12]) = (100:100:100, 100:100:100);
	(RDCLK => DO[13]) = (100:100:100, 100:100:100);
	(RDCLK => DO[14]) = (100:100:100, 100:100:100);
	(RDCLK => DO[15]) = (100:100:100, 100:100:100);
	(RDCLK => DO[1]) = (100:100:100, 100:100:100);
	(RDCLK => DO[2]) = (100:100:100, 100:100:100);	
	(RDCLK => DO[3]) = (100:100:100, 100:100:100);
	(RDCLK => DO[4]) = (100:100:100, 100:100:100);
	(RDCLK => DO[5]) = (100:100:100, 100:100:100);
	(RDCLK => DO[6]) = (100:100:100, 100:100:100);
	(RDCLK => DO[7]) = (100:100:100, 100:100:100);
	(RDCLK => DO[8]) = (100:100:100, 100:100:100);
	(RDCLK => DO[9]) = (100:100:100, 100:100:100);
	(RDCLK => EMPTY) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[0]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[10]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[11]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[1]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[2]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[3]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[4]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[5]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[6]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[7]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[8]) = (100:100:100, 100:100:100);
	(RDCLK => RDCOUNT[9]) = (100:100:100, 100:100:100);
	(RDCLK => RDERR) = (100:100:100, 100:100:100);
	(WRCLK => ALMOSTFULL) = (100:100:100, 100:100:100);
	(WRCLK => FULL) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[0]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[10]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[11]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[1]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[2]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[3]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[4]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[5]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[6]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[7]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[8]) = (100:100:100, 100:100:100);
	(WRCLK => WRCOUNT[9]) = (100:100:100, 100:100:100);
	(WRCLK => WRERR) = (100:100:100, 100:100:100);

	(RST => ALMOSTEMPTY) = (0:0:0, 0:0:0);
	(RST => EMPTY) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[0]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[10]) = (0:0:0, 0:0:0);
	(RST => RDCOUNT[11]) = (0:0:0, 0:0:0);
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

	$setuphold (posedge RDCLK, negedge RDEN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge RDCLK, posedge RDEN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DIP[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DIP[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[10] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[11] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[12] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[13] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[14] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[15] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[2] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[3] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[4] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[5] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[6] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[7] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[8] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge DI[9] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, negedge WREN &&& (RST==0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DIP[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DIP[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[0] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[10] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[11] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[12] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[13] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[14] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[15] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[1] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[2] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[3] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[4] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[5] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[6] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[7] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[8] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge DI[9] &&& (wren_enable!=0), 0:0:0, 0:0:0);
	$setuphold (posedge WRCLK, posedge WREN &&& (RST==0), 0:0:0, 0:0:0);

	$recrem (negedge RST, posedge RDCLK, 0:0:0, 0:0:0, notifier_rdclk);
	$recrem (negedge RST, posedge WRCLK, 0:0:0, 0:0:0, notifier_wrclk);
	$period (posedge RDCLK, 0:0:0, notifier);
	$period (posedge WRCLK, 0:0:0, notifier);
	$width (posedge RDCLK, 0:0:0, 0, notifier);
	$width (negedge RDCLK, 0:0:0, 0, notifier);
	$width (posedge WRCLK, 0:0:0, 0, notifier);
	$width (negedge WRCLK, 0:0:0, 0, notifier);
	$width (posedge RST, 0:0:0, 0, notifier);
	specparam PATHPULSE$ = 0;

    endspecify
    
endmodule // X_FIFO18

