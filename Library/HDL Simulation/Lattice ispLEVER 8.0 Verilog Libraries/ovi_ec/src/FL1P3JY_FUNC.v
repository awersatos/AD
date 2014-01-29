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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/FL1P3JY_FUNC.v,v 1.4 2005/05/19 19:06:31 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module FL1P3JY_FUNC (D0, D1, SP, CK, SD, PD, SR, notifier, Q);
input  D0, D1, SP, CK, SD, PD, SR, notifier;
output Q;

reg QR;
wire QB;

or INST34 (DATAIN, I38, I40);
and INST35 (I38, D0, I43);
and INST36 (I40, SD, D1);
not INST37 (I43, SD);
not INST50 (I29, SR);
and INST52 (I60, SP, DATAIN);
not INST53 (I61, SP);
and INST54 (I59, Q, I61);
or INST58 (I63, PD, I59, I60);
UDFDL7_UDP_X INST6 (QB, I63, CK, I29, notifier);

//xor (D_XOR_Q, D, Q);
//not (BPD,PD);
//not (BD,D);
//and (SR_BPD_SP,GSR,BPD,SP);
//and (GSR_BD_SP,GSR,BD);
//and (GSR_D_XOR_Q,GSR,D_XOR_Q);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule

`endcelldefine
