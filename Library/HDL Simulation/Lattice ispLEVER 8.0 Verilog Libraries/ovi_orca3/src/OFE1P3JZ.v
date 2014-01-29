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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/OFE1P3JZ.v,v 1.7 2005/05/19 18:30:42 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OFE1P3JZ (D, SP, ECLK, PD, Q);
  parameter DISABLED_GSR = 0;
  input  D, SP, ECLK, PD;
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
  or INST33 (I50, I36, I73);
  and INST34 (I36, Q, I54);
  and INST35 (I73, SP, I68);
  not INST52 (I54, SP);
  not(QN,Q);
  or INST67 (I68, D, PD);

  UDFDL7_UDP_X INST6 (Q, I50, ECLK, SR, notifier);


endmodule

`endcelldefine
