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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/IFS1S1D.v,v 1.9 2005/05/19 18:30:14 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IFS1S1D (D, SCLK, CD, Q);
  parameter DISABLED_GSR = 0;
  input  D, SCLK, CD;
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

  not (SR1, SRN);
  or INST1 (SR, CD, SR1);
  not(QN,Q);

  UDFDL1_UDP_X INST6 (Q, SR, D, SCLK, notifier);


endmodule
