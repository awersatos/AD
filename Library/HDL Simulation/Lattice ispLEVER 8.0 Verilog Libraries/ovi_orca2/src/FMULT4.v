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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/FMULT4.v,v 1.2 2005/05/19 18:05:52 pradeep Exp $ 
//
`timescale 1 ns / 100 ps

/* Created by DB2VERILOG Version 1.2.0.3 on Thu Sep  1 10:33:38 1994 */
/* module compiled from "lsl2db 4.0.3" run */

module FMULT4 (A0, A1, A2, A3, B0, B1, B2, B3, S0, 
       S1, S2, S3, S4, S5, S6, S7);
input  A0, A1, A2, A3, B0, B1, B2, B3;
output S0, S1, S2, S3, S4, S5, S6, S7;
AND2 INST114 (.A(A1), .B(B3), .Z(I149));
AND2 INST115 (.A(A1), .B(B2), .Z(I147));
AND2 INST116 (.A(A1), .B(B1), .Z(I145));
AND2 INST117 (.A(A1), .B(B0), .Z(I143));
AND2 INST123 (.A(A2), .B(B3), .Z(I157));
AND2 INST124 (.A(A2), .B(B2), .Z(I155));
AND2 INST125 (.A(A2), .B(B1), .Z(I153));
AND2 INST126 (.A(A2), .B(B0), .Z(I151));
AND2 INST132 (.A(A3), .B(B3), .Z(I166));
AND2 INST133 (.A(A3), .B(B2), .Z(I164));
AND2 INST134 (.A(A3), .B(B1), .Z(I162));
AND2 INST135 (.A(A3), .B(B0), .Z(I159));
VLO INST191 (.Z(I192));
VLO INST195 (.Z(I196));
FADD4 INST68 (.A0(I137), .A1(I139), .A2(I141), .A3(I192),
      .B0(I143), .B1(I145), .B2(I147), .B3(I149), .CI(
      I192), .CO(I175), .S0(S1), .S1(I169), .S2(I171),
      .S3(I173));
FADD4 INST69 (.A0(I169), .A1(I171), .A2(I173), .A3(I175),
      .B0(I151), .B1(I153), .B2(I155), .B3(I157), .CI(
      I196), .CO(I183), .S0(S2), .S1(I177), .S2(I179),
      .S3(I181));
FADD4 INST70 (.A0(I177), .A1(I179), .A2(I181), .A3(I183),
      .B0(I159), .B1(I162), .B2(I164), .B3(I166), .CI(
      I196), .CO(S7), .S0(S3), .S1(S4), .S2(S5), .S3(
      S6));
AND2 INST71 (.A(A0), .B(B3), .Z(I141));
AND2 INST72 (.A(A0), .B(B2), .Z(I139));
AND2 INST73 (.A(A0), .B(B1), .Z(I137));
AND2 INST74 (.A(A0), .B(B0), .Z(S0));

endmodule

