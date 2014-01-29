// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/simprims/X_CLK_DIV.v,v 1.6 2007/12/07 19:47:35 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Global Clock Divider
// /___/   /\     Filename : X_CLK_DIV.v
// \   \  /  \    Timestamp : Thu Mar 25 16:43:54 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
//    12/07/07 - CR 456124 Added buffers on ports;
// End Revision

`timescale 1 ps/1 ps

module X_CLK_DIV (CLKDV,CDRST,CLKIN);

parameter DIVIDE_BY = 2;
parameter DIVIDER_DELAY = 0;

input CDRST,CLKIN;
  parameter LOC = "UNPLACED";
output CLKDV;
integer CLOCK_DIVIDER;
integer RESET_WAIT_COUNT;
integer START_WAIT_COUNT;
integer DELAY_RESET;
integer DELAY_START;
integer STARTUP;
integer NO_BITS_REMAINING;
reg clkdv_out;
reg CDRST_i;
reg notifier;

 wire cdrst_in;
 wire clkin_in;

 buf buf_cdrst (cdrst_in, CDRST);
 buf buf_clkin (clkin_in, CLKIN);
 buf buf_clkdv (CLKDV, clkdv_out);


initial begin
 CLOCK_DIVIDER = 0;
 RESET_WAIT_COUNT = 0;
 START_WAIT_COUNT = 0;
 DELAY_RESET = 0;
 NO_BITS_REMAINING = 0;
 DELAY_START = DIVIDER_DELAY;
 clkdv_out = 1'b0;
 STARTUP = 1;
end

always @(negedge clkin_in)
begin
CDRST_i = cdrst_in;
end

always @(posedge clkin_in)
begin

if (CDRST_i && (clkdv_out == 1'b1) && (STARTUP == 1))
begin
clkdv_out = 1'b0;
CLOCK_DIVIDER = 0;
DELAY_START = DIVIDER_DELAY;
end
 
if (CDRST_i && (clkdv_out == 1'b1) && (STARTUP == 0))
 begin
	NO_BITS_REMAINING = ((DIVIDE_BY/2 + 1) - CLOCK_DIVIDER);
	DELAY_RESET = 1 ;
	DELAY_START = DIVIDER_DELAY ;
 end

if (DELAY_RESET == 1)		
	begin
	RESET_WAIT_COUNT = RESET_WAIT_COUNT + 1;
		 if (RESET_WAIT_COUNT == NO_BITS_REMAINING)
 		 begin
			clkdv_out = 1'b0;
			DELAY_RESET = 0;
			RESET_WAIT_COUNT = 0;
			STARTUP = 1;
			CLOCK_DIVIDER = 0;
		 end
	end


if (CDRST_i == 1'b0 && DELAY_START == 1) 
 begin
 START_WAIT_COUNT = START_WAIT_COUNT + 1;
	if (START_WAIT_COUNT == DIVIDE_BY)
	begin
	START_WAIT_COUNT = 0;
	DELAY_START  = 0;
	end
 end


if (CDRST_i == 1'b0 && DELAY_START == 0 && DELAY_RESET == 0) 
 begin
	if ((CLOCK_DIVIDER == 0) && (STARTUP == 1))
	begin
	clkdv_out = 1'b1;
	end

 CLOCK_DIVIDER = CLOCK_DIVIDER + 1;
	if ((CLOCK_DIVIDER == 0) && (STARTUP == 1))
	begin
	clkdv_out = 1'b1;
	end
	if (CLOCK_DIVIDER == (DIVIDE_BY/2 + 1)) 
	begin
	STARTUP = 0;
	CLOCK_DIVIDER = 1;
	clkdv_out = ~clkdv_out;
	end
 end

end


specify

	$width (posedge CLKIN, 0:0:0, 0, notifier);
	$width (negedge CLKIN, 0:0:0, 0, notifier);
	$width (posedge CDRST, 0:0:0, 0, notifier);
	$period (posedge CLKIN, 0:0:0, notifier);
	specparam PATHPULSE$ = 0;

endspecify


endmodule
