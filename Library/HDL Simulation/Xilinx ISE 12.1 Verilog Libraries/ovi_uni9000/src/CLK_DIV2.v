// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/verunilibs/data/uni9000/CLK_DIV2.v,v 1.6 2008/05/01 20:24:36 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.2i (I.28)
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Global Clock Divider
// /___/   /\     Filename : CLK_DIV2.v
// \   \  /  \    Timestamp : Thu Mar 25 16:41:44 PST 2004
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    02/22/06 - CR#226003 - Added integer, real parameter type
//    05/23/07 - Changed timescale to 1 ps / 1 ps.

`timescale 1 ps / 1 ps

module CLK_DIV2 (CLKDV,CLKIN);


input CLKIN;
output CLKDV;
reg CLKDV;

localparam integer DIVIDE_BY = 2;

integer CLOCK_DIVIDER;

initial begin
 CLOCK_DIVIDER = 0;
 CLKDV = 1'b0;
end

always @(posedge CLKIN)
begin
 CLOCK_DIVIDER = CLOCK_DIVIDER + 1;
	if (CLOCK_DIVIDER == (DIVIDE_BY/2 + 1)) 
	begin
	CLOCK_DIVIDER = 1;
	CLKDV = ~CLKDV;
	end
end

endmodule
