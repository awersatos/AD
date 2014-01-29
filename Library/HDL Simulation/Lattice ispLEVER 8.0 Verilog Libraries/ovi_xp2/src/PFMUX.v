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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/PFMUX.v,v 1.2 2005/05/19 20:08:57 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module PFMUX (ALUT, BLUT, C0, Z); 
input ALUT, BLUT, C0; 
output Z; 
supply0 GND; 
supply1 VCC; 
 
not INS1 (S_inv, C0); 
and INS2 (out_1, ALUT, S_inv); 
and INS3 (out_2, BLUT, C0); 
or  INS4 (Z, out_1, out_2); 
 
endmodule 
`endcelldefine
