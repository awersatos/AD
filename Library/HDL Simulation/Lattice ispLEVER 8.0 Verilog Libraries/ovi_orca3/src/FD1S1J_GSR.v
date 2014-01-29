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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FD1S1J_GSR.v,v 1.6 2005/05/19 18:29:50 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FD1S1J_GSR (D, CK, PD, GSR, PUR, Q);
  parameter DISABLED_GSR = 0;
  input  D, CK, PD, GSR, PUR;
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

  UDFDL3_UDP_X INST6 (Q, SR, I70, CK, notifier);
  or INST67 (I70, D, PD);
//  not INST74 (I54, GSR);
  not (BPD,PD);
  not (BD,D);
  and (GSR_BPD,GSR,BPD);
  and (GSR_BD,GSR,D);

endmodule

`endcelldefine   
