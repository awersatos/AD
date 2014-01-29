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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/FL1P3AZ_FUNC.v,v 1.4 2005/05/19 19:06:30 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

/* Created by DB2VERILOG Version 1.0.1.1 on Tue Apr  5 13:52:00 1994 */
/* module compiled from "lsl2db 3.6.4" run */

module FL1P3AZ_FUNC (D0, D1, SP, CK, SD, SR, notifier, Q);
input  D0, D1, SP, CK, SD, SR, notifier;
output Q;

reg QR;
wire QB;

//gsrb INST27 (.GSRI(GSRI), .Z(I49));
or INST34 (DATAIN, I38, I40);
and INST35 (I38, D0, I43);
and INST36 (I40, SD, D1);
not INST37 (I43, SD);
//not INST50 (I29, I49);
not INST50 (I29, SR);
and INST52 (I60, SP, DATAIN);
not INST53 (I61, SP);
and INST54 (I59, Q, I61);
or INST58 (I63, I59, I60);
UDFDL5_UDP_X INST6 (QB, I63, CK, I29, notifier); 
//xor (D_XOR_Q,DATAIN,Q);

  always @ QB
  begin
      QR <= QB;
  end

  buf (Q, QR);

endmodule

`endcelldefine
