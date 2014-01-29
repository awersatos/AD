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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/AG4INT.v,v 1.2 2005/05/19 18:29:07 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module AG4INT (A0, A1, A2, A3, B0, B1, B2, B3, CI, 
       GE);
  input  A0, A1, A2, A3, B0, B1, B2, B3, CI;
  output GE;

  and  (I3, CI, I9);
  and  (I4, A0, CI);
  or   (I6, I3, I4, I5);
  not  (I9, B0);
  and  (I5, I9, A0);
  or   (I29, I32, I31, I30);
  and  (I31, A1, I6);
  and  (I32, I6, I22);
  and  (I30, I22, A1);
  not  (I22, B1);
  or   (I44, I47, I46, I45);
  and  (I46, A2, I29);
  and  (I47, I29, I37);
  and  (I45, I37, A2);
  not  (I37, B2);
  or   (GE, I62, I61, I60);
  and  (I61, A3, I44);
  and  (I62, I44, I52);
  and  (I60, I52, A3);
  not  (I52, B3);

endmodule

`endcelldefine
