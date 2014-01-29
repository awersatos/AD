///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  User Interface to Global Clock, Reset and 3-State Controls for SPARTAN3E
// /___/   /\     Filename : X_STARTUP_SPARTAN3E.v
// \   \  /  \    Timestamp : Fri Apr 18 16:30:09 PDT 2008
//  \___\/\___\
//
// Revision:
//    04/18/08 - Initial version -- CR 448436.
// End Revision

`timescale  1 ns / 1 ps

module X_STARTUP_SPARTAN3E (CLK, GSR, GTS, MBT);

    input  CLK, GSR, GTS, MBT;

    tri0 GSR, GTS;

    reg  disable_mbt = 0;
    time init_time, min_time;
    
    assign glbl.GSR = GSR;
    assign glbl.GTS = GTS;

    // only the first valid active low MBT ( > 300ns) will put out the message
    always @(MBT) begin

	if (!disable_mbt) begin

	    if (MBT == 1'b0) begin
		if ($time != 0)
		    init_time = $time;
	    end
	    else if (MBT == 1'b1) begin
		min_time = $time - init_time;
		if (min_time >= 300) begin
		    $display ("Soft Boot has been initiated.");
		    disable_mbt = 1;
		end
	    end

	end // if (!disable_mbt)
	
    end // always @ (MBT)
    
endmodule

