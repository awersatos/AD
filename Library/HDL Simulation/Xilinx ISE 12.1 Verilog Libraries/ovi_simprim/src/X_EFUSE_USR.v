// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/blanc/X_EFUSE_USR.v,v 1.3 2009/08/22 00:02:06 harikr Exp $
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
// /__/   /\       Filename    : X_EFUSE_USR.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//  Revision:		1.0
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

module X_EFUSE_USR (
  EFUSEUSR
);

  parameter LOC = "UNPLACED";
  parameter [31:0] SIM_EFUSE_VALUE = 32'h00000000;

  output [31:0] EFUSEUSR;

  assign EFUSEUSR = SIM_EFUSE_VALUE;


endmodule
