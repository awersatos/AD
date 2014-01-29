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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5ecp/RCS/FSU4INT.v,v 1.2 2005/05/19 19:12:30 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FSU4INT (A0, A1, A2, A3, B0, B1, B2, B3, BI, BO, S0, S1, S2, S3);
  input  A0, A1, A2, A3, B0, B1, B2, B3, BI;
  output BO, S0, S1, S2, S3;

  and INST10 (I3, BI, I9);
  and INST11 (I4, A0, BI);
  or INST12 (I6, I3, I4, I5);
  xor INST13 (S0, A0, I9, BI);
  not INST19 (I9, B0);
  and INST2 (I5, I9, A0);
  xor INST23 (S1, A1, I22, I6);
  or INST24 (I29, I32, I31, I30);
  and INST25 (I31, A1, I6);
  and INST26 (I32, I6, I22);
  and INST27 (I30, I22, A1);
  not INST35 (I22, B1);
  xor INST38 (S2, A2, I37, I29);
  or INST39 (I44, I47, I46, I45);
  and INST40 (I46, A2, I29);
  and INST41 (I47, I29, I37);
  and INST42 (I45, I37, A2);
  not INST50 (I37, B2);
  xor INST53 (S3, A3, I52, I44);
  or INST54 (BO, I62, I61, I60);
  and INST55 (I61, A3, I44);
  and INST56 (I62, I44, I52);
  and INST57 (I60, I52, A3);
  not INST65 (I52, B3);

endmodule 

`endcelldefine
