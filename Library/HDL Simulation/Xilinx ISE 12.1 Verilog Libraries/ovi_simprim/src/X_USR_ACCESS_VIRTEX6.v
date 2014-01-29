// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/blanc/X_USR_ACCESS_VIRTEX6.v,v 1.3 2009/08/22 00:02:07 harikr Exp $
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
// /__/   /\       Filename    : X_USR_ACCESS_VIRTEX6.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//  Revision:		1.0
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

module X_USR_ACCESS_VIRTEX6 (
  CFGCLK,
  DATA,
  DATAVALID
);

  parameter LOC = "UNPLACED";

  output CFGCLK;
  output DATAVALID;
  output [31:0] DATA;

endmodule
