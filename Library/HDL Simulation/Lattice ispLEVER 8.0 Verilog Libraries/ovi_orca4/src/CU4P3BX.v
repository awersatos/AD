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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/CU4P3BX.v,v 1.3 2005/05/19 19:01:03 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 10 ps

/* Created by DB2VERILOG Version 1.0.1.1 on Tue May 17 11:43:44 1994 */
/* module compiled from "lsl2db 3.6.4" run */

`celldefine
module CU4P3BX (CI, SP, CK, PD, CO, Q0, Q1, Q2, Q3);
parameter DISABLED_GSR = 0;
defparam g.DISABLED_GSR = DISABLED_GSR;
input  CI, SP, CK, PD;
output CO, Q0, Q1, Q2, Q3;

  tri1 GSR = GSR_INST.GSRNET;
  tri1 PUR = PUR_INST.PURNET;


CU4P3BX_GSR  g (.CI(CI), .SP(SP), .CK(CK), .PD(PD), .GSR(GSR), .PUR(PUR), .CO(CO), .Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3));

endmodule
`endcelldefine
