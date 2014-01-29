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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/BNDSCAN.v,v 1.2 2005/05/19 19:00:48 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module BNDSCAN (PTDI,PTMS,PTCK,BSO1,BSO2,TDI,TCK,BSEN1,BSEN2,TDO);
 input  PTDI,PTMS,PTCK,BSO1,BSO2;
 output  TDI,TCK,BSEN1,BSEN2,TDO;

 supply0 GND;
 buf (TDI, PTDI);
 buf (TCK, PTCK);
 or  (TDO, I3, I2);
 not (I4, PTMS);
 and (I2, PTMS, BSO2);
 and (I3, I4, BSO1);
 buf (BSEN1, GND);
 buf (BSEN2, GND);

endmodule

`endcelldefine
