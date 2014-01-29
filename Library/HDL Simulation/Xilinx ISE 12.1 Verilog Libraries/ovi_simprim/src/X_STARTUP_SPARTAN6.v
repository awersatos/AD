///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  User Interface to Global Clock, Reset and 3-State Controls for SPARTAN6
// /___/   /\     Filename : X_STARTUP_SPARTAN6.v
// \   \  /  \    Timestamp : Fri May 15 09:54:56 PDT 2009
//  \___\/\___\
//
// Revision:
//    05/15/09 - Initial version
//    09/09/09 - CR 532733 -- Fixed contention on GSR
//    10/30/09 - CR 537641 -- Added CFGMCLK functionality.
// End Revision

`timescale 1 ps / 1 ps 

module X_STARTUP_SPARTAN6 (
  CFGCLK,
  CFGMCLK,
  EOS,
  CLK,
  GSR,
  GTS,
  KEYCLEARB
);

  parameter LOC = "UNPLACED";

  output CFGCLK;
  output CFGMCLK;
  output EOS;

  input CLK;
  input GSR;
  input GTS;
  input KEYCLEARB;

  pulldown( GSR );
  pulldown( GTS );
  pullup( KEYCLEARB );

  tri0 GSR, GTS;
  time CFGMCLK_PERIOD = 20000;

  reg cfgmclk_out;

  initial begin
      cfgmclk_out = 0;
      forever #(CFGMCLK_PERIOD/2.0) cfgmclk_out = !cfgmclk_out;
  end

  assign CFGMCLK = cfgmclk_out;

  assign glbl.GSR = GSR;
  assign glbl.GTS = GTS;

  specify
        specparam PATHPULSE$ = 0;
  endspecify

endmodule
