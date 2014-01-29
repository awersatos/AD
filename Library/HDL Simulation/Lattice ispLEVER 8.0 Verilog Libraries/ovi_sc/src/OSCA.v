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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/OSCA.v,v 1.3 2005/05/19 19:06:58 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSCA (OSC);
  output OSC;

 parameter  DIV = 1;

  reg TEST, OSCb, ckout2, ckout4, ckout8, ckout16, ckout32, ckout64, ckout128;

  initial
  begin
     ckout2 = 1'b0;
     ckout4 = 1'b0;
     ckout8 = 1'b0;
     ckout16 = 1'b0;
     ckout32 = 1'b0;
     ckout64 = 1'b0;
     ckout128 = 1'b0;
  end

  initial
  begin
     TEST = 1'b0;
     forever begin
        #5 TEST = ~TEST;
     end
  end

  always @(posedge TEST)
  begin
     ckout2 = ~ckout2;
  end

  always @(posedge ckout2)
  begin
     ckout4 = ~ckout4; 
  end

  always @(posedge ckout4)
  begin
     ckout8 = ~ckout8; 
  end

  always @(posedge ckout8)
  begin
     ckout16 = ~ckout16; 
  end

  always @(posedge ckout16)
  begin
     ckout32 = ~ckout32; 
  end

  always @(posedge ckout32)
  begin
     ckout64 = ~ckout64; 
  end

  always @(posedge ckout64)
  begin
     ckout128 = ~ckout128; 
  end

  always @(TEST or ckout2 or ckout4 or ckout8 or ckout16 or ckout32 or ckout64 or ckout128)
  begin
     if (DIV == 1)
        OSCb = TEST;
     else if (DIV == 2)
        OSCb = ckout2;
     else if (DIV == 4)
        OSCb = ckout4;
     else if (DIV == 8)
        OSCb = ckout8;
     else if (DIV == 16)
        OSCb = ckout16;
     else if (DIV == 32)
        OSCb = ckout32;
     else if (DIV == 64)
        OSCb = ckout64;
     else if (DIV == 128)
        OSCb = ckout128;
  end

  buf (OSC, OSCb);

endmodule 

`endcelldefine
