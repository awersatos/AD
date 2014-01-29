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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/RCE32X4.v,v 1.12 2005/05/19 18:30:52 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps
`celldefine

module RCE32X4 ( AD0,AD1,AD2,AD3,AD4,DI0,DI1,DI2,DI3,CK,WREN,WPE0,WPE1,
                 DO0,DO1,DO2,DO3,QDO0,QDO1,QDO2,QDO3);

  input  AD0,AD1,AD2,AD3,AD4,DI0,DI1,DI2,DI3,CK,WREN,WPE0,WPE1;
  output DO0,DO1,DO2,DO3,QDO0,QDO1,QDO2,QDO3;

  parameter [127:0] initval = 128'h00000000000000000000000000000000;
  parameter DISABLED_GSR = 0;
 
  defparam INST5.init_value = initval;
  defparam INST5.DISABLED_GSR = DISABLED_GSR;

  and  INST1 (RW, WREN, WPE0, WPE1);

  `ifdef GSR_SIGNAL
  wire GSR = `GSR_SIGNAL;
  `else
  pullup (weak1) (GSR);
  `endif

 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

  SYN5RAM INST5 ({DI3,DI2,DI1,DI0},{AD4,AD3,AD2,AD1,AD0},RW,
                CK,GSR,PUR,{DO3,DO2,DO1,DO0},{QDO3,QDO2,QDO1,QDO0});

endmodule
