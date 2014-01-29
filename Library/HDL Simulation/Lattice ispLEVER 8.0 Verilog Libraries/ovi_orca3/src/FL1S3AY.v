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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/FL1S3AY.v,v 1.10 2005/05/19 18:30:05 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FL1S3AY (D0, D1, CK, SD, Q, QN);
  parameter DISABLED_GSR = 0;
  input  D0, D1, CK, SD;
  output Q, QN;
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
  not(QN,Q);
  or INST34 (I31, I38, I40);
  and INST35 (I38, D0, I43);
  and INST36 (I40, SD, D1);
  not INST37 (I43, SD);

  UDFDL7_UDP_X INST6 (Q, I31, CK, SR, notifier);


endmodule

`endcelldefine
