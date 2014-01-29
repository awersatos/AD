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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FD1P3AY_GSR.v,v 1.6 2005/05/19 18:29:42 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 10 ps

`celldefine

module FD1P3AY_GSR (D, SP, CK, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;

  input  D, SP, CK, GSR, PUR;
  output Q;
  reg notifier; 
  reg SR;

  or INST33 (I50, I36, I38);
  and INST34 (I36, Q, I54);
  and INST35 (I38, SP, D);
  not INST52 (I54, SP);
  //  not INST58 (I29, GSR);
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

  UDFDL7_UDP_X INST6 (Q, I50, CK, I29, notifier); 
  xor(D_XOR_Q,D,Q);
  and(GSR_SP,GSR,SP);
  and(GSR_D_XOR_Q,GSR,D_XOR_Q);

endmodule

`endcelldefine
