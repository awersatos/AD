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
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/RPP16X4Z.v,v 1.4 2005/05/19 18:06:28 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.1.0 on Tue Sep 27 08:12:40 1994 */
/* module compiled from "lsl2db 4.1.0" run */

module RPP16X4Z (AD0, AD1, AD2, AD3, DI0, DI1, DI2, 
       DI3, WREN, TRI, DO0, DO1, DO2, DO3);
input  AD0, AD1, AD2, AD3, DI0, DI1, DI2, DI3, WREN, TRI;
output DO0, DO1, DO2, DO3;

supply1 vdd;
supply0 vss;

reg DSBL;
reg DOUT0, DOUT1, DOUT2, DOUT3;
parameter [63:0] init_value = 64'h0000000000000000;

defparam 
  INST5.INST5.init_value = init_value;
 
NOT INST25 (.A(WREN), .Z(I28));

RAM16X4 INST5 (.A0(AD0I), .A1(AD1I), .A2(AD2I), .A3(AD3I),
      .DSBL(TRI), .R_W(I28), .DIN0(DI0I), .DIN1(DI1I),
      .DIN2(DI2I), .DIN3(DI3I), .DOUT0(DO0), .DOUT1(DO1),
      .DOUT2(DO2), .DOUT3(DO3));
DELAY INST980 (.A(AD0), .Z(AD0I));
DELAY INST981 (.A(AD1), .Z(AD1I));
DELAY INST982 (.A(AD2), .Z(AD2I));
DELAY INST983 (.A(AD3), .Z(AD3I));
DELAY INST984 (.A(DI0), .Z(DI0I));
DELAY INST985 (.A(DI1), .Z(DI1I));
DELAY INST986 (.A(DI2), .Z(DI2I));
DELAY INST987 (.A(DI3), .Z(DI3I));



endmodule

