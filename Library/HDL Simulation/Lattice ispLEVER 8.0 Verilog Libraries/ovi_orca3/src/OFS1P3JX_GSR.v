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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/OFS1P3JX_GSR.v,v 1.6 2005/05/19 18:30:45 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

module OFS1P3JX_GSR (D, SP, SCLK, PD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, SCLK, PD, GSR, PUR;
  output Q;
  reg SR;

  reg notifier;

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

  UDFDL7_UDP_X INST6 (Q,I50,SCLK,SR,notifier);
//  not (I29, GSR);
  or  (I50, PD, I36, I73);
  and (I36, Q, I54);
  and (I73, SP, D);
  not (I54, SP);



endmodule

`endcelldefine
