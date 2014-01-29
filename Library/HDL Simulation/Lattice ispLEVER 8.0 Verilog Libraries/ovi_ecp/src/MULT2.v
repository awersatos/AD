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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/MULT2.v,v 1.3 2005/05/19 20:08:47 pradeep Exp $ 
//
`celldefine
`timescale 1 ns / 1 ps

module MULT2 (P0, P1,CO, A0, A1, A2, A3, B0, B1, B2, B3, CI);
input  A0, A1, A2, A3, B0, B1, B2, B3, CI ;
output P0, P1, CO; 
 
supply0 GND; 
supply1 VCC; 

and  INS1_1  (out2, A2, B2);
and  INS2_1  (out3, A3, B3);

xor  INS3_1 (P1, out2, C_int, out3); 
and  INS4_1 (out_4, out2, out3); 
and  INS5_1 (out_5, out2, C_int); 
and  INS6_1 (out_6, C_int, out3); 
or   INS7_1 (CO, out_4, out_5, out_6); 

 
and  INS1  (out0, A0, B0);
and  INS2  (out1, A1, B1);

xor  INS3 (P0, out0, CI, out1); 
and  INS4 (out_1, out0, out1); 
and  INS5 (out_2, out0, CI); 
and  INS6 (out_3, CI, out1); 
or   INS7 (C_int, out_1, out_2, out_3); 
 
endmodule 

`endcelldefine
