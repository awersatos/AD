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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/MPIPPC.v,v 1.12 2005/05/19 18:30:32 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 100 ps

`celldefine

module MPIPPC (CLK, CS0N, CS1, RDWRN, TSN, A27, A28, A29, A30, A31, DIN7,
              DIN6, DIN5, DIN4, DIN3, DIN2, DIN1, DIN0, UEND, UIRQN, UDOUT7,
              UDOUT6, UDOUT5, UDOUT4, UDOUT3, UDOUT2, UDOUT1, UDOUT0,
              DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0, DDRVCTL,
              BIN, IRQN, TAN, TANTS, MPGSR, URDWRN, USTART, UA3, UA2, UA1, UA0,
              UDIN7, UDIN6, UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0); 
 
  input CLK, CS0N, CS1, RDWRN, TSN, UEND, UIRQN;
  input A27, A28, A29, A30, A31;
  input DIN7, DIN6, DIN5, DIN4, DIN3, DIN2, DIN1, DIN0;
  input UDOUT7, UDOUT6, UDOUT5, UDOUT4, UDOUT3, UDOUT2, UDOUT1, UDOUT0;
  output TANTS, BIN, DDRVCTL, IRQN, TAN, MPGSR, URDWRN, USTART;
  output UDIN7, UDIN6, UDIN5, UDIN4, UDIN3, UDIN2, UDIN1, UDIN0;   
  output DOUT7, DOUT6, DOUT5, DOUT4, DOUT3, DOUT2, DOUT1, DOUT0;
  output UA3, UA2, UA1, UA0;

 `ifdef PUR_SIGNAL
  wire PUR = `PUR_SIGNAL;
 `else
  pullup (weak1) (PUR);
 `endif

MPIPPC_PUR  g (.CLK(CLK), .CS0N(CS0N), .CS1(CS1), .RDWRN(RDWRN), .TSN(TSN), 
               .A27(A27), .A28(A28), .A29(A29), .A30(A30), .A31(A31), .DIN7(DIN7),
               .DIN6(DIN6), .DIN5(DIN5), .DIN4(DIN4), .DIN3(DIN3), .DIN2(DIN2), 
               .DIN1(DIN1), .DIN0(DIN0), .UEND(UENDb), .UIRQN(UIRQNb), .UDOUT7(UDOUT7),
               .UDOUT6(UDOUT6), .UDOUT5(UDOUT5), .UDOUT4(UDOUT4), .UDOUT3(UDOUT3), 
               .UDOUT2(UDOUT2), .UDOUT1(UDOUT1), .UDOUT0(UDOUT0), .PUR(PUR), 
               .TANTS(TANTS), .BIN(BINb), .DDRVCTL(DDRVCTL), .IRQN(IRQN), .TAN(TANb),
               .DOUT7(DOUT7), .DOUT6(DOUT6), .DOUT5(DOUT5), .DOUT4(DOUT4), .DOUT3(DOUT3), 
               .DOUT2(DOUT2), .DOUT1(DOUT1), .DOUT0(DOUT0), .MPGSR(MPGSR), 
               .URDWRN(URDWRNb), .USTART(USTARTb), .UA3(UA3b), .UA2(UA2b), .UA1(UA1b), 
               .UA0(UA0b), .UDIN7(UDIN7), .UDIN6(UDIN6), .UDIN5(UDIN5), .UDIN4(UDIN4), 
               .UDIN3(UDIN3), .UDIN2(UDIN2), .UDIN1(UDIN1), .UDIN0(UDIN0)); 

   buf  (UENDb, UEND);
   buf  (UIRQNb, UIRQN);

   buf  (TAN, TANb);
   buf  (BIN, BINb);
   buf  (USTART, USTARTb);
   buf  (URDWRN, URDWRNb);
   buf  (UA0, UA0b);
   buf  (UA1, UA1b);
   buf  (UA2, UA2b);
   buf  (UA3, UA3b);
   
   not (SR, PUR);


endmodule

`endcelldefine
