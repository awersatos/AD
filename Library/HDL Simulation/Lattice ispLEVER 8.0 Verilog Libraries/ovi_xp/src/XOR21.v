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
// Simulation Library File for SC
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/XOR21.v,v 1.3 2005/05/19 19:07:06 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module XOR21 (
    A, B, C, D, E, F, G, 
    H, I, J, K, L, M, N, 
    O, P, Q, R, S, T, U,
    Z);
  input  A, B, C, D, E, F, G;
  input  H, I, J, K, L, M, N;
  input  O, P, Q, R, S, T, U; 
  output Z;

  xor (Z, 
    A, B, C, D, E, F, G, 
    H, I, J, K, L, M, N, 
    O, P, Q, R, S, T, U);


endmodule 

`endcelldefine
