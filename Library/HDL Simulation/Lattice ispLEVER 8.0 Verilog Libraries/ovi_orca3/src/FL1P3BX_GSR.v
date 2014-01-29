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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FL1P3BX_GSR.v,v 1.8 2005/05/19 18:29:55 pradeep Exp $ 
//
`resetall
`timescale 1ns / 100ps

`celldefine

module FL1P3BX_GSR (D0, D1, SP, CK, SD, PD, GSR, PUR, Q);
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

  and INST52 (I60, SP, DATAIN);
  not INST53 (I61, SP);
  and INST54 (I59, Q, I61);
  or INST58 (I63, I59, I60);
  UDFDL7_UDP_X INST6 (Q, I63, CK, I25, notifier);
  or INST38 (I25, PDI, SR); 
  buf INST997 (PDI, PD); 

//not (GSR_PD,I57);
//xor (D_XOR_Q,D,Q);
//and (GSR_PD_SP,GSR_PD,SP);
//and (GSR_PD_D_XOR_Q,D_XOR_Q,GSR_PD);

endmodule

`endcelldefine
