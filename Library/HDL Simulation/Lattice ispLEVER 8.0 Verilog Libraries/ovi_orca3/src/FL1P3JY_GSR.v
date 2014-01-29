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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FL1P3JY_GSR.v,v 1.8 2005/05/19 18:29:58 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FL1P3JY_GSR (D0, D1, SP, CK, SD, PD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D0, D1, SP, CK, SD, PD, GSR, PUR;
  output Q;
  reg SR;
  reg notifier; 

  or INST34 (DATAIN, I38, I40);
  and INST35 (I38, D0, I43);
  and INST36 (I40, SD, D1);
  not INST37 (I43, SD);
//  not INST50 (I29, GSR);
  and INST52 (I60, SP, DATAIN);
  not INST53 (I61, SP);
  and INST54 (I59, Q, I61);
  or INST58 (I63, PD, I59, I60);
//---- Programmable GSR ----
  and (GP, GSR, PUR);
  not INST68 (I29, GP);
  not INST69 (I28, PUR);

  always @ (GSR or PUR  or I29 or I28) begin
    if (DISABLED_GSR == 0) begin
      SR = I29;
    end
    else if (DISABLED_GSR == 1)
      SR = I28;
  end
//--------------------------

  UDFDL7_UDP_X INST6 (Q, I63, CK, SR, notifier);

//xor (D_XOR_Q, D, Q);
//not (BPD,PD);
//not (BD,D);
//and (GSR_BPD_SP,GSR,BPD,SP);
//and (GSR_BD_SP,GSR,BD);
//and (GSR_D_XOR_Q,GSR,D_XOR_Q);

endmodule

`endcelldefine
