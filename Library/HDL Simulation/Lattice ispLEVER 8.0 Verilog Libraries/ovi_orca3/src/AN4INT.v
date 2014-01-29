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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/AN4INT.v,v 1.2 2005/05/19 18:29:09 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module AN4INT (A0, A1, A2, A3, B0, B1, B2, B3, CI, 
       NE);
input  A0, A1, A2, A3, B0, B1, B2, B3, CI;
output NE;

xnor  (RES_A, A0, B0);
xnor  (RES_B, A1, B1);
xnor  (RES_C, A2, B2);
xnor  (RES_D, A3, B3);
and   (EQ, RES_A, RES_B, RES_C, RES_D);
not   (PNE, EQ);
or    (NE, PNE, CI);

endmodule

`endcelldefine

