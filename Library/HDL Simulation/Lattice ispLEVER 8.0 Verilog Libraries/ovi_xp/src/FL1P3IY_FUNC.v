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
// Simulation Library File for SC
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/FL1P3IY_FUNC.v,v 1.4 2005/05/19 19:06:31 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FL1P3IY_FUNC (D0, D1, SP, CK, SD, CD, SR, notifier, Q);
input  D0, D1, SP, CK, SD, CD, SR, notifier;
output Q;

reg QR;
wire QB;

or  INST34 (DATAIN, I38, I40);
and INST35 (I38, D0, I43);
and INST36 (I40, SD, D1);
not INST37 (I43, SD);
or  INST32 (I50, DATAIN, I54);
or  INST33 (I51, SP, Q);
and INST45 (I48, I65, I50, I51);
not INST52 (I54, SP);
not INST57 (I65, CD);
UDFDL5_UDP_X INST6 (QB, I48, CK, I29, notifier);
not INST69 (I29, SR);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule

`endcelldefine
