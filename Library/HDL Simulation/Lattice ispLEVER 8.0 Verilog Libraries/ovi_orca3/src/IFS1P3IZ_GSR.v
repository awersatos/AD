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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/IFS1P3IZ_GSR.v,v 1.6 2005/05/19 18:30:13 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

module IFS1P3IZ_GSR (D, SP, SCLK, CD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, SCLK, CD, GSR, PUR;
  output Q;
  reg SR;

  reg notifier;

  or INST33 (I50, I36, I38);
  and INST34 (I36, Q, I54);
  and INST35 (I38, SP, I65, D);
  not INST52 (I54, SP);
  not INST57 (I65, CD);
//---- Programmable GSR ----
  and (GP, GSR, PUR);
  not INST58 (I29, GP);
  not INST59 (I28, PUR);

  always @ (GSR or PUR  or I29 or I28) begin
    if (DISABLED_GSR == 0) begin
      SR = I29;
    end
    else if (DISABLED_GSR == 1)
      SR = I28;
  end
//--------------------------

  UDFDL5_UDP_X INST6 (Q, I50, SCLK, SR, notifier);
//  not INST69 (I29, GSR);

  xor (D_XOR_Q, D, Q);
  not (BCD,CD);
  not (BD,D);
  and (GSR_BCD_SP,GSR,BCD,SP);
  and (GSR_D_XOR_Q,GSR,D_XOR_Q);
  and (GSR_BD_SP,GSR,BD,SP);

endmodule

`endcelldefine
