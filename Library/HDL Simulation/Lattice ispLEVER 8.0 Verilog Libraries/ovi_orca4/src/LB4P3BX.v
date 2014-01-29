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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/LB4P3BX.v,v 1.3 2005/05/19 19:01:40 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 10 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue May 17 12:03:48 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module LB4P3BX (D0, D1, D2, D3, CI, SP, CK, SD, PD, CON, CO, Q0, Q1, Q2, Q3);
parameter DISABLED_GSR = 0;
defparam g.DISABLED_GSR = DISABLED_GSR;
input  D0, D1, D2, D3, CI, SP, CK, SD, PD, CON;
output CO, Q0, Q1, Q2, Q3;

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;

LB4P3BX_GSR  g (.D0(D0), .D1(D1), .D2(D2), .D3(D3), .CI(CI), .SP(SP), .CK(CK), .SD(SD), .PD(PD), .CON(CON), .GSR(GSR), .PUR(PUR), .CO(CO), .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3));

endmodule
`endcelldefine
