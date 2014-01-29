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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/SAOI442.v,v 1.3 2005/05/19 19:02:14 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module SAOI442 (
    A1, A2, A3, A4, 
    B1, B2, B3, B4,
    C1, C2,
    Z);

input  A1, A2, A3, A4;
input  B1, B2, B3, B4;
input  C1, C2;
output Z;

  and U2 (AND4_1, A1, A2, A3, A4);
  and U1 (AND4_2, B1, B2, B3, B4);
  and U3 (AND2_1, C1, C2);

  nor U0 (Z, AND4_1, AND4_2, AND2_1);


endmodule

`endcelldefine
