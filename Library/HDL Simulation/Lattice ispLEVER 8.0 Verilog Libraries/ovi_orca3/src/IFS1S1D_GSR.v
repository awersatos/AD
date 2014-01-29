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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/IFS1S1D_GSR.v,v 1.6 2005/05/19 18:30:15 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

module IFS1S1D_GSR (D, SCLK, CD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D, SCLK, CD, GSR, PUR;
  output Q;
  reg SR;
  reg notifier; 

  or INST38 (I35, CDI, SR);
//  not INST43 (I46, GSR);
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

  UDFDL1_UDP_X INST6 (Q, I35, D, SCLK, notifier); 
  buf INST997 (CDI, CD);

  not (GSR_CD, I35);
  not (BCD,CD);

endmodule

`endcelldefine
