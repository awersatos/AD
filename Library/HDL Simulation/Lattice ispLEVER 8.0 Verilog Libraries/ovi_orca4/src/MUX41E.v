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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/MUX41E.v,v 1.3 2005/05/19 19:01:52 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module MUX41E (D0, D1, D2, D3, SD1, SD2, E, Z);
input  D0, D1, D2, D3, SD1, SD2, E;
output Z;

// SD1 and SD2 are the select inputs - the output is determined by the value 
// of the two SD signals when E is HIGH

  // SD1, SD2 = 0 - pass D0
and U0 (SEL_0, D0, IS0, E);
  // SD1, SD2 = 1 - pass D1
and U1 (SEL_1, D1, IS1, E);
  // SD1, SD2 = 2 - pass D2
and U2 (SEL_2, D2, IS2, E);
  // SD1, SD2 = 3 - pass D3
and U3 (SEL_3, D3, IS3, E);
  // combine the four mutually exclusive AND gate outputs
or  U4 (Z, SEL_0, SEL_1, SEL_2, SEL_3);

// Decode the SD1 and SD2 inputs
  // provide both the SD signals and their inverses
not U5 (_SD1, SD1);
not U6 (_SD2, SD2);
  // decode
and U7  (IS0, _SD2, _SD1);
and U8  (IS1, _SD2,  SD1);
and U9  (IS2,  SD2, _SD1);
and U10 (IS3,  SD2,  SD1);


endmodule
`endcelldefine
