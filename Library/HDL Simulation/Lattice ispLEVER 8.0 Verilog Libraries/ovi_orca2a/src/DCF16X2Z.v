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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/DCF16X2Z.v,v 1.5 2005/05/19 18:26:19 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps
`celldefine
`delay_mode_unit 

module DCF16X2Z ( AD0,AD1,AD2,AD3,DI0,DI1,CK,WREN,WPE,TRI,
                 RAD0,RAD1,RAD2,RAD3,RDO0,RDO1,DO0,DO1);
 
input AD0,AD1,AD2,AD3,DI0,DI1,CK,WREN,WPE,TRI,RAD0,RAD1,RAD2,RAD3;
output DO0,DO1,RDO0,RDO1;
wire [1:0] TMP;
parameter [63:0] init_value = 64'h0000000000000000;

defparam 
  INST5.init_value = init_value;
 

AND2  INST1 (.Z(RW), .A(WREN), .B(WPE));
   
SYN2RAM INST5 ({DI1,DI0},{AD3,AD2,AD1,AD0},RW,
     CK,{RAD3,RAD2,RAD1,RAD0},{DO1,DO0},{TMP[1],TMP[0]});

TBUF INST2 (TMP[0], TRI, RDO0);
TBUF INST3 (TMP[1], TRI, RDO1);

endmodule
`endcelldefine
