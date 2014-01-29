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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FMULT81.v,v 1.3 2005/05/19 19:01:26 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FMULT81 (A0, A1, A2, A3, A4, A5, A6, A7, B0, 
       B1, B2, B3, B4, B5, B6, B7, MULT, CI, CO, 
       P0, P1, P2, P3, P4, P5, P6, P7);
input  A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, B3, B4, B5, B6, B7, 
       MULT, CI;
output CO, P0, P1, P2, P3, P4, P5, P6, P7;
FM41INT I1 (.A0(A0), .A1(A1), .A2(A2), .A3(A3), .B0(B0),
      .B1(B1), .B2(B2), .B3(B3), .MULT(MULT), .CI(CI),
      .CO(CO_INT), .P0(P0), .P1(P1), .P2(P2), .P3(P3));
FM41INT I2 (.A0(A4), .A1(A5), .A2(A6), .A3(A7), .B0(B4),
      .B1(B5), .B2(B6), .B3(B7), .MULT(MULT), .CI(CO_INT),
      .CO(CO), .P0(P4), .P1(P5), .P2(P6), .P3(P7));


endmodule

`endcelldefine
