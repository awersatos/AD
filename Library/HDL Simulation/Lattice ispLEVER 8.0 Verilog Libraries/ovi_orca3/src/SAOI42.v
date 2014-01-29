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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/SAOI42.v,v 1.4 2005/05/19 18:30:54 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module SAOI42 (A1, A2, A3, A4, B1, B2, Z);
  input  A1, A2, A3, A4, B1, B2;
  output Z;

  and U2 (AND4_1, A1, A2, A3, A4);
  and U1 (AND2_1, B1, B2);

  nor U0 (Z, AND4_1, AND2_1);


endmodule

`endcelldefine
