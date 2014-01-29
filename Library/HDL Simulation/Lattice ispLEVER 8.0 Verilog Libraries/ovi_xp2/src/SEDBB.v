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
// Simulation Library File for XP2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module SEDBB (SEDERR, SEDDONE, SEDINPROG);
  output SEDERR, SEDDONE, SEDINPROG;

  supply0 GND;
  buf (SEDERR, GND);
  buf (SEDDONE, GND);
  buf (SEDINPROG, GND);

endmodule 

`endcelldefine
