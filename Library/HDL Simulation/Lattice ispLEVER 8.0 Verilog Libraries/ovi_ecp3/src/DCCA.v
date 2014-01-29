// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
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
// Simulation Library File for ECP3
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DCCA (CLKI, CE, CLKO);
  input CLKI, CE;
  output CLKO;

  reg q = 0;
  wire l, clk, clk1;
  reg clk2;

  buf (l, CE);
  buf (clk1, CLKI);

  always @(clk1) // added to to prevent race condition
    clk2 = clk1;

  and (clk, clk2, q);

  always @(clk, l)
  begin
    if (clk == 0)
       q = l;
  end

  buf (CLKO, clk);

endmodule

`endcelldefine

