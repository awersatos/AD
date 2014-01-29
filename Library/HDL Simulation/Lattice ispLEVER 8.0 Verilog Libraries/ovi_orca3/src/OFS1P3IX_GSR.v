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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/OFS1P3IX_GSR.v,v 1.6 2005/05/19 18:30:44 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

module OFS1P3IX_GSR (D, SP, SCLK, CD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, SCLK, CD, GSR, PUR;
  output Q;
  reg SR;

  reg notifier;

//  not (I29, GSR);
  or  (I50, I54, D);
  or  (I51, SP, Q);
  and (I38, I51, I65, I50);
  not (I54, SP);
  not (I65, CD);
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

  UDFDL5_UDP_X INST6 (Q, I38, SCLK, SR, notifier);


endmodule
