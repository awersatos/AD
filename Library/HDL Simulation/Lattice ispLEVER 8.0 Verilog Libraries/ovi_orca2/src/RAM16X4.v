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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/RAM16X4.v,v 1.4 2005/05/19 18:06:24 pradeep Exp $ 
//
`resetall
`timescale 1ns/ 100 ps

`celldefine
module RAM16X4 (A0, A1, A2, A3, DSBL, R_W, DIN0, DIN1, DIN2, DIN3, DOUT0, DOUT1, DOUT2, DOUT3);
input A0, A1, A2, A3, DSBL, R_W, DIN0, DIN1, DIN2, DIN3;
output DOUT0, DOUT1, DOUT2, DOUT3;

supply1 vdd;

wire [3:0] Q;


NOT INST992 (.A(DSBL), .Z(DSBL_0));

TBUF INST988 (Q[0], DSBL, DOUT0);
TBUF INST989 (Q[1], DSBL, DOUT1);
TBUF INST990 (Q[2], DSBL, DOUT2);
TBUF INST991 (Q[3], DSBL, DOUT3);


CREGBRAM INST5 ({DIN3,DIN2,DIN1,DIN0}, {A3,A2,A1,A0}, R_W, vdd, {Q[3],Q[2],Q[1],Q[0]});



endmodule
`endcelldefine
