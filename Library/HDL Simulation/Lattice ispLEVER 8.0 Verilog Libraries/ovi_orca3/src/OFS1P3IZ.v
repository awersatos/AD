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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/OFS1P3IZ.v,v 1.7 2005/05/19 18:30:44 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OFS1P3IZ (D, SP, SCLK, CD, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, SCLK, CD;
  output Q;
  reg SRN;
  reg notifier; 

  `ifdef GSR_SIGNAL
  wire GSR = `GSR_SIGNAL;
  `else
  pullup (weak1) (GSR);
  `endif

 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

  always @ (GSR or PUR ) begin
    if (DISABLED_GSR == 0) begin
      SRN = GSR & PUR ;
    end
    else if (DISABLED_GSR == 1)
      SRN = PUR;
  end

  not (SR, SRN);
  or INST33 (I50, I36, I38);
  and INST34 (I36, Q, I54);
  and INST35 (I38, SP, I65, D);
  not INST52 (I54, SP);
  not INST57 (I65, CD);
  not(QN,Q);

  UDFDL5_UDP_X INST6 (Q, I50, SCLK, SR, notifier);


endmodule

`endcelldefine
