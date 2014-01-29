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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/MUX21E.v,v 1.3 2005/05/19 18:30:33 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module MUX21E (D0, D1, SD, E, Z);
input  D0, D1, SD, E;
output Z;

// SD is the select input - the output is determined by the value of SD when
// when the enable signal is high.
  // SD and E are HIGH - pass D1
and U1 (SEL_1, D1, SD, E);
  // SD is LOW and E is HIGH - pass D0
not U2 (_SD, SD);
and U3 (SEL_0, D0, _SD, E);
  // combine the two mutually exclusive AND gate outputs
or  U4 (Z, SEL_0, SEL_1);


endmodule

`endcelldefine
