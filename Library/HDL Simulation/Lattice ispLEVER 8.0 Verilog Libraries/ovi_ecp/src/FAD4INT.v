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
// Simulation Library File for ECP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5ecp/RCS/FAD4INT.v,v 1.2 2005/05/19 19:12:28 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 10 ps

`celldefine

module FAD4INT (A0, A1, A2, A3, B0, B1, B2, B3, CI, 
       CO, S0, S1, S2, S3);
input  A0, A1, A2, A3, B0, B1, B2, B3, CI;
output CO, S0, S1, S2, S3;
and INST10 (I3, CI, B0);
and INST11 (I4, A0, CI);
or  INST12 (I6, I3, I4, I5);
xor INST13 (S0, A0, B0, CI);
and INST2  (I5, B0, A0);
and INST22 (I17, B1, A1);
and INST23 (I15, I6, B1);
and INST24 (I16, A1, I6);
or  INST25 (I18, I15, I16, I17);
xor INST66 (S1, A1, B1, I6);
and INST35 (I30, B2, A2);
and INST36 (I28, I18, B2);
and INST37 (I29, A2, I18);
or  INST38 (I31, I28, I29, I30);
xor INST39 (S2, A2, B2, I18);
and INST48 (I43, B3, A3);
and INST49 (I41, I31, B3);
and INST50 (I42, A3, I31);
or  INST51 (CO, I41, I42, I43);
xor INST52 (S3, A3, B3, I31);

endmodule

`endcelldefine
