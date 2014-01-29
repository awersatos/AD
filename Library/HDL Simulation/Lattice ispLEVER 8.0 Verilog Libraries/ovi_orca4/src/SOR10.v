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
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/SOR10.v,v 1.3 2005/05/19 19:02:15 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module SOR10 (
    A, B, C, D, E, F, G, H, I, J,
    Z
    );
  input A, B, C, D, E, F, G, H, I, J;
  output Z;

  or (Z,
    A, B, C, D, E, F, G, H, I, J
    );


endmodule 

`endcelldefine
