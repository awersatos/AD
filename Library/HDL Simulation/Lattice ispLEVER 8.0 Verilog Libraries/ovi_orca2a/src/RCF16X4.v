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
// Simulation Library File for ORCA2A
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/RCF16X4.v,v 1.4 2005/05/19 18:26:21 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps
`celldefine
`delay_mode_unit 

module RCF16X4 ( AD0,AD1,AD2,AD3,DI0,DI1,DI2,DI3,CK,WREN,WPE,
                 DO0,DO1,DO2,DO3);
 
input AD0,AD1,AD2,AD3,DI0,DI1,DI2,DI3,CK,WREN,WPE;
output DO0,DO1,DO2,DO3;
parameter [63:0] init_value = 64'h0000000000000000;

defparam 
  INST5.init_value = init_value;
 
AND2  INST2 (.Z(RW), .A(WREN), .B(WPE));
   
SYN1RAM INST5 ({DI3,DI2,DI1,DI0},{AD3,AD2,AD1,AD0},RW,
     CK,{DO3,DO2,DO1,DO0});

endmodule
`endcelldefine
