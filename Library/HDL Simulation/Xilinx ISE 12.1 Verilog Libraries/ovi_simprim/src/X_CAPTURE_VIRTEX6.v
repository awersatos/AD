// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/blanc/X_CAPTURE_VIRTEX6.v,v 1.4 2009/09/16 22:18:14 yanx Exp $
///////////////////////////////////////////////////////
//  Copyright (c) 2009 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 11.1i 
//  \  \           Description : 
//  /  /                      
// /__/   /\       Filename    : X_CAPTURE_VIRTEX6.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//  Revision:		1.0
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

module X_CAPTURE_VIRTEX6 (
  CAP,
  CLK
);

  parameter LOC = "UNPLACED";
  parameter ONESHOT = "TRUE";


  input CAP;
  input CLK;

  pulldown( CAP );

  reg ONESHOT_BINARY;

  reg notifier;


  wire CAP_IN;
  wire CLK_IN;
  wire CAP_INDELAY;
  wire CLK_INDELAY;
  wire delay_CLK;
  wire delay_CAP;

  initial begin
    case (ONESHOT)
      "FALSE" : ONESHOT_BINARY = 1'b0;
      "TRUE" : ONESHOT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute ONESHOT on X_CAPTURE_VIRTEX6 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", ONESHOT);
        $finish;
      end
    endcase

  end


  buf B_CAP (CAP_IN, CAP);
  buf B_CLK (CLK_IN, CLK);

  specify
    $period (posedge CLK, 0:0:0, notifier);
    $setuphold (posedge CLK, negedge CAP, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_CAP);
    $setuphold (posedge CLK, posedge CAP, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_CAP);

    specparam PATHPULSE$ = 0;
  endspecify
endmodule
