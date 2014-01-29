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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/ANEB4.v,v 1.2 2005/05/19 18:26:18 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps
`celldefine

/* Created by DB2VERILOG Version 1.3.0.3 on Tue Jan 23 16:47:22 1996 */
/* module compiled from "lsl2db 4.1.3" run */

module ANEB4 (A0, A1, A2, A3, B0, B1, B2, B3, CI, 
       NE);
input  A0, A1, A2, A3, B0, B1, B2, B3, CI;
output NE;
XNOR2 XNOR_A (.A(A0), .B(B0), .Z(RES_A));
XNOR2 XNOR_B (.A(A1), .B(B1), .Z(RES_B));
XNOR2 XNOR_C (.A(A2), .B(B2), .Z(RES_C));
XNOR2 XNOR_D (.A(A3), .B(B3), .Z(RES_D));
AND4 AND_A (.A(RES_A), .B(RES_B), .C(RES_C), .D(RES_D),
      .Z(EQ));
NOT NAND_A (.A(EQ), .Z(PNE));
OR2 NEOR (.A(PNE), .B(CI), .Z(NE));

endmodule
`endcelldefine

