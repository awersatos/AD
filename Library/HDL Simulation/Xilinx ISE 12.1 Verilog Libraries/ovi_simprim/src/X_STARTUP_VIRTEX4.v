///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  User Interface to Global Clock, Reset and 3-State Controls for VIRTEX4
// /___/   /\     Filename : X_STARTUP_VIRTEX4.v
// \   \  /  \    Timestamp : Fri Apr 18 16:30:09 PDT 2008
//  \___\/\___\
//
// Revision:
//    04/18/08 - Initial version -- CR 448436.
// End Revision


`timescale  1 ps / 1 ps


module X_STARTUP_VIRTEX4 (EOS, CLK, GSR, GTS, USRCCLKO, USRCCLKTS, USRDONEO, USRDONETS);

    output EOS;
    
    input CLK;
    input GSR;
    input GTS;
    input USRCCLKO;
    input USRCCLKTS;
    input USRDONEO;
    input USRDONETS;
    
    tri0 GSR, GTS;

	assign glbl.GSR = GSR;
	assign glbl.GTS = GTS;

endmodule
