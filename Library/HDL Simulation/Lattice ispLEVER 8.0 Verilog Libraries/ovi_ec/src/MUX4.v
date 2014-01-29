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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/MUX4.v,v 1.2 2005/05/19 20:08:48 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module MUX4 (D0, D1, D2, D3, SD1, SD2, Z); 
input D0, D1, D2, D3, SD1, SD2; 
output Z; 
supply0 GND; 
supply1 VCC; 
 
 
not INS1 (S0_inv, SD1); 
not INS9 (S1_inv, SD2); 
and INS3 (out_1, D0, S0_inv, S1_inv); 
and INS4 (out_2, D1, SD1, S1_inv); 
and INS5 (out_3, D2, SD1_inv, SD2); 
and INS6 (out_4, D3, SD1, SD2); 
or  INS7 (Z, out_1, out_2, out_3, out_4); 

endmodule 

`endcelldefine
