// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/CLK_DIV4SD.v,v 1.6 2008/05/01 20:24:36 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.2i (I.28)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Global Clock Divider with Start Delay
// /___/   /\     Filename : CLK_DIV4SD.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:47 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    02/22/06 - CR#226003 - Added integer, real parameter type
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale 1 ps / 1 ps

module CLK_DIV4SD (CLKDV,CLKIN);


input CLKIN;
output CLKDV;
reg CLKDV;

localparam integer DIVIDE_BY = 4;
localparam integer DIVIDER_DELAY = 1;

integer CLOCK_DIVIDER;
integer START_WAIT_COUNT;
integer DELAY_START;

initial begin
 CLOCK_DIVIDER = 0;
 START_WAIT_COUNT = 0;
 DELAY_START = DIVIDER_DELAY;
 CLKDV = 1'b0;
end

always @(posedge CLKIN)
begin

if (DELAY_START == 1) 
 begin
 START_WAIT_COUNT = START_WAIT_COUNT + 1;
	if (START_WAIT_COUNT == DIVIDE_BY)
	begin
	START_WAIT_COUNT = 0;
	DELAY_START  = 0;
	end
 end

if (DELAY_START == 0) 
 begin
 CLOCK_DIVIDER = CLOCK_DIVIDER + 1;
	if (CLOCK_DIVIDER == (DIVIDE_BY/2 + 1)) 
	begin
	CLOCK_DIVIDER = 1;
	CLKDV = ~CLKDV;
	end
 end

end

endmodule
