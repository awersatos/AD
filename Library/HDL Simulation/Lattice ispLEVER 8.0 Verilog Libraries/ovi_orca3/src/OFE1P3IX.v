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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/OFE1P3IX.v,v 1.7 2005/05/19 18:30:41 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OFE1P3IX (D, SP, ECLK, CD, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, ECLK, CD;
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
  or  (I50, I54, D);
  or  (I51, SP, Q);
  and (I38, I51, I65, I50);
  not (I54, SP);
  not (I65, CD);
  not(QN,Q);

  UDFDL5_UDP_X INST6 (Q, I38, ECLK, SR, notifier);


endmodule

`endcelldefine
