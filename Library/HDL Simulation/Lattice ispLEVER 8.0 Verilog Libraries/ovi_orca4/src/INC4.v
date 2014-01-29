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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/INC4.v,v 1.3 2005/05/19 19:01:37 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module INC4 (CI, PC0, PC1, PC2, PC3, CO, NC0, NC1, NC2, NC3);
  input  CI, PC0, PC1, PC2, PC3;
  output CO, NC0, NC1, NC2, NC3;

  and INST11 (I6, PC0, CII);
  xor INST13 (NC0, PC0, CII);
  and INST24 (I18, PC1, I6);
  xor INST26 (NC1, PC1, I6);
  and INST37 (I31, PC2, I18);
  xor INST39 (NC2, PC2, I18);
  and INST50 (CO, PC3, I31);
  xor INST52 (NC3, PC3, I31);
  buf INST99 (CII, CI);
//DELAY  INST990 (.A(CI), .Z(CII));


endmodule 

`endcelldefine
