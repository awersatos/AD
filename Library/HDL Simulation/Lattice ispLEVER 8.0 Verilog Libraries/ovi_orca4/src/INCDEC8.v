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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/INCDEC8.v,v 1.3 2005/05/19 19:01:38 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module INCDEC8 (CI, PC0, PC1, PC2, PC3, PC4, PC5, 
       PC6, PC7, CON, CO, NC0, NC1, NC2, NC3, NC4, 
       NC5, NC6, NC7);
input  CI, PC0, PC1, PC2, PC3, PC4, PC5, PC6, PC7, CON;
output CO, NC0, NC1, NC2, NC3, NC4, NC5, NC6, NC7;
INDE4INT INST1 (.CI(CI), .PC0(PC0), .PC1(PC1), .PC2(PC2),
      .PC3(PC3), .CON(CON), .CO(CO_INT), .NC0(NC0),
      .NC1(NC1), .NC2(NC2), .NC3(NC3));
INDE4INT INST2 (.CI(CO_INT), .PC0(PC4), .PC1(PC5), .PC2(
      PC6), .PC3(PC7), .CON(CON), .CO(CO), .NC0(NC4),
      .NC1(NC5), .NC2(NC6), .NC3(NC7));


endmodule

`endcelldefine
