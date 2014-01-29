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
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/XOR11.v,v 1.2 2005/05/19 18:06:39 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module XOR11 (
    A, B, C, D, E, F, G, H, I, J, K,
    Z);
  input A, B, C, D, E, F, G, H, I, J, K;
  output Z;

  xor (Z, A, B, C, D, E, F, G, H, I, J, K);

specify
   // unit delay will be 0.1 ns for all transitions
   specparam unit_delay = 0.1:0.1:0.1 ;

   (A => Z)=unit_delay;
   (B => Z)=unit_delay;
   (C => Z)=unit_delay;
   (D => Z)=unit_delay;
   (E => Z)=unit_delay;
   (F => Z)=unit_delay;
   (G => Z)=unit_delay;
   (H => Z)=unit_delay;
   (I => Z)=unit_delay;
   (J => Z)=unit_delay;
   (K => Z)=unit_delay;
   // actual delays can only be back-annotated to paths specified here.
endspecify

endmodule 

`endcelldefine
