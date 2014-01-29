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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/MPI960.v,v 1.13 2005/05/19 18:30:31 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module MPI960 (ADSN, ALE, CLK, CS0N, CS1, WRRDN, ADIN7, ADIN6, ADIN5, ADIN4, 
               ADIN3, ADIN2, ADIN1, ADIN0, BE1N, BE0N, RRCVNIN, UEND, UIRQN, 
               UDOUT7, UDOUT6, UDOUT5, UDOUT4, UDOUT3, UDOUT2, UDOUT1, UDOUT0,
               DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0, DDRVCTL,
               IRQN, RDYRCVN, RDRCVTS, MPGSR, URDWRN, USTART, UA3, UA2, UA1,
               UA0, UDIN7, UDIN6, UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0);

  input CLK, CS0N, CS1, WRRDN, ADSN, ALE, BE1N, BE0N, RRCVNIN, UEND, UIRQN;
  input ADIN7, ADIN6, ADIN5, ADIN4, ADIN3, ADIN2, ADIN1, ADIN0;
  input UDOUT7, UDOUT6, UDOUT5, UDOUT4, UDOUT3, UDOUT2, UDOUT1, UDOUT0;
  output DDRVCTL, IRQN, RDYRCVN, RDRCVTS, MPGSR, URDWRN, USTART;
  output DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0;
  output UA3, UA2, UA1, UA0;
  output UDIN7, UDIN6, UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0;

 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

MPI960_PUR  g (.CLK(CLK), .CS0N(CS0N), .CS1(CS1), .WRRDN(WRRDN), .ADSN(ADSN), 
               .ALE(ALE), .ADIN7(ADIN7), .ADIN6(ADIN6), .ADIN5(ADIN5), 
               .ADIN4(ADIN4), .ADIN3(ADIN3), .ADIN2(ADIN2), .ADIN1(ADIN1), 
               .ADIN0(ADIN0), .BE1N(BE1N), .BE0N(BE0N), .RRCVNIN(RRCVNIN),
               .UEND(UENDb), .UIRQN(UIRQNb), .UDOUT7(UDOUT7), .UDOUT6(UDOUT6),
               .UDOUT5(UDOUT5), .UDOUT4(UDOUT4), .UDOUT3(UDOUT3), .UDOUT2(UDOUT2),
               .UDOUT1(UDOUT1),.UDOUT0(UDOUT0), .PUR(PUR), .DDRVCTL(DDRVCTL),
               .IRQN(IRQN), .RDYRCVN(RDYRCVNb), .DOUT7(DOUT7), .DOUT6(DOUT6),
               .DOUT5(DOUT5), .DOUT4(DOUT4), .DOUT3(DOUT3), .DOUT2(DOUT2),
               .DOUT1(DOUT1), .DOUT0(DOUT0), .MPGSR(MPGSR), .URDWRN(URDWRNb),
               .USTART(USTARTb), .UA3(UA3b), .UA2(UA2b), .UA1(UA1b), .UA0(UA0b),
               .UDIN7(UDIN7), .UDIN6(UDIN6), .UDIN5(UDIN5), .UDIN4(UDIN4),
               .UDIN3(UDIN3), .UDIN2(UDIN2), .UDIN1(UDIN1), .UDIN0(UDIN0),
               .RDRCVTS(RDRCVTS));

   buf  (UENDb, UEND);
   buf  (UIRQNb, UIRQN);

   buf  (USTART, USTARTb);
   buf  (URDWRN, URDWRNb);
   buf  (RDYRCVN, RDYRCVNb);
   buf  (UA0, UA0b);
   buf  (UA1, UA1b);
   buf  (UA2, UA2b);
   buf  (UA3, UA3b);

   not (SR, PUR);
 

endmodule

`endcelldefine
