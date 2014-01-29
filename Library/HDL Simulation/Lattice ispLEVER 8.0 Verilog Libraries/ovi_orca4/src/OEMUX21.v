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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/OEMUX21.v,v 1.3 2005/05/19 19:01:58 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module OEMUX21 (D0, D1, ECLK, Z);
input  D0, D1, ECLK;
output Z;

// ECLK is the select input - the output is determined by the value of ECLK
  // ECLK is HIGH - pass D1
and U1 (SEL_1, D1, ECLK);
  // ECLK is LOW - pass D0
not U2 (_ECLK, ECLK);
and U3 (SEL_0, D0, _ECLK);
  // combine the two mutually exclusive AND gate outputs
or  U4 (Z, SEL_0, SEL_1);


endmodule

`endcelldefine
