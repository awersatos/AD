///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  User Interface to Global Clock, Reset and 3-State Controls for FPGACORE
// /___/   /\     Filename : X_STARTUP_FPGACORE.v
// \   \  /  \    Timestamp : Fri Apr 18 16:30:09 PDT 2008
//  \___\/\___\
//
// Revision:
//    04/18/08 - Initial version -- CR 448436.
// End Revision

`timescale  1 ps / 1 ps


module X_STARTUP_FPGACORE (CLK, GSR);

    input  CLK, GSR;

    tri0 GSR;

	assign glbl.GSR = GSR;

endmodule
