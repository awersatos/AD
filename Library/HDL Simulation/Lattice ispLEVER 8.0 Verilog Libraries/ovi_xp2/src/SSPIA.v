// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005-2007 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for XP2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module SSPIA (SI, CLK, CS, SO);
  input SI, CLK, CS;
  output SO;

  parameter TAG_INITSIZE = 2184;
//  parameter TAG_INITIALIZATION = "DISABLED";
  parameter TAG_INITVAL_00 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_01 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_02 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_03 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_04 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_05 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_06 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_07 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_08 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_09 = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_0A = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_0B = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;
  parameter TAG_INITVAL_0C = 320'h00000000000000000000000000000000000000000000000000000000000000000000000000000000;

 initial
    $display ("Warning! Empty model is being used for block \"SSPIA\", for the full functional model please use either the encrypted or the pre-compiled models.");

  supply0 GND;
  buf (SO, GND);

endmodule

`endcelldefine
