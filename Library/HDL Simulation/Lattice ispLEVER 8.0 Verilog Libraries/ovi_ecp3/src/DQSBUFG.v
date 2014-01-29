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

module DQSBUFG(SCLK, DDRCLKPOL, DQCLK1); 

   input SCLK;
   output  DDRCLKPOL, DQCLK1;

   wire SCLKB;
   reg DDRCLKPOL_int;

   buf (SCLKB, SCLK);
   buf inst_buf0 (DDRCLKPOL, DDRCLKPOL_int);

initial
begin
   DDRCLKPOL_int = 1'b0;
end

   assign DQCLK1 = SCLKB;

endmodule

`endcelldefine


