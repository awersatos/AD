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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/OFS1P3JZ_GSR.v,v 1.5 2005/05/19 18:30:45 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

module OFS1P3JZ_GSR (D, SP, SCLK, PD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, SCLK, PD, GSR, PUR;
  output Q;
  reg SR;

  reg notifier; 

  or INST33 (I50, I36, I73);
  and INST34 (I36, Q, I54);
  and INST35 (I73, SP, I68);
  not INST52 (I54, SP);
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
  UDFDL7_UDP_X INST6 (Q, I50, SCLK, SR, notifier); 
  or INST67 (I68, D, PD);
//  not INST76 (I29, GSR);

  xor (D_XOR_Q, D, Q);
  not (BPD,PD);
  not (BD,D);
  and (GSR_BPD_SP,GSR,BPD,SP);
  and (GSR_BD_SP,GSR,BD);
  and (GSR_D_XOR_Q,GSR,D_XOR_Q);


endmodule
