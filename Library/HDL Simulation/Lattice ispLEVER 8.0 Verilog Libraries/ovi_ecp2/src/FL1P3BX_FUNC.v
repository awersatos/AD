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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/FL1P3BX_FUNC.v,v 1.4 2005/05/19 19:06:30 pradeep Exp $ 
//
`resetall
`timescale 1ns / 100ps

`celldefine

module FL1P3BX_FUNC (D0, D1, SP, CK, SD, PD, SR, notifier, Q);
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
or INST58 (I63, I59, I60);
UDFDL7_UDP_X INST6 (QB, I63, CK, I28, notifier);
or INST38 (I28, PDI, I29);
buf INST997 (PDI, PD);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

//not (SR_PD,I57);
//xor (D_XOR_Q,D,Q);
//and (GSR_PD_SP,GSR_PD,SP);
//and (GSR_PD_D_XOR_Q,D_XOR_Q,GSR_PD);

endmodule

`endcelldefine
