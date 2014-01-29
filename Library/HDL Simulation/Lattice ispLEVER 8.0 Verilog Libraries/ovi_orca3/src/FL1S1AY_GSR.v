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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FL1S1AY_GSR.v,v 1.7 2005/05/19 18:30:00 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FL1S1AY_GSR (D0, D1, CK, SD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D0, D1, CK, SD, GSR, PUR;
  output Q;
  reg SR;
  reg notifier;

  or INST34 (I31, I38, I40);
  and INST35 (I38, D0I, I43);
//DELAY  INST981 (.A(D0), .Z(D0I));
  buf     (D0I, D0);
  and INST36 (I40, SDI, D1I);
//DELAY  INST980 (.A(SD), .Z(SDI));
  buf     (SDI, SD);
//DELAY  INST982 (.A(D1), .Z(D1I));
  buf     (D1I, D1);
  not INST37 (I43, SDI);
//  not INST50 (I29, GSR);
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

  UDFDL3_UDP_X INST6 (Q, SR, I31, CK, notifier);
  and (GSR_SD,GSR,SD);
  and (GSR_BSD,GSR,I43);
  xor (D0_XOR_D1,D0,D1); 

endmodule

`endcelldefine
