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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/IFS1P3BX_GSR.v,v 1.7 2005/05/19 18:30:11 pradeep Exp $ 
//
`resetall
`timescale 1ns / 100ps

module IFS1P3BX_GSR (D, SP, SCLK, PD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, SCLK, PD, GSR, PUR;
  output Q;
  reg SR;

  reg notifier; 

  or INST33 (I50, I36, I38);
  and INST34 (I36, Q, I54);
  and INST35 (I38, SP, D);
  not INST52 (I54, SP);
  or INST60 (I57, PDI, SR);
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

  UDFDL7_UDP_X INST6 (Q, I50, SCLK, I57, notifier); 
//  not INST64 (I66, GSR);
  buf INST997 (PDI, PD);
  not (GSR_PD,I57);
  xor (D_XOR_Q,D,Q);
  and (GSR_PD_SP,GSR_PD,SP);
  and (GSR_PD_D_XOR_Q,D_XOR_Q,GSR_PD);

endmodule

`endcelldefine
