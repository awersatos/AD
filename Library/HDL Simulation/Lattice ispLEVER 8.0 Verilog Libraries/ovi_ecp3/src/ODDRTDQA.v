// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2007 by Lattice Semiconductor Corporation
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
// Simulation Library File for ECP3
//
// $Header:
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDRTDQA(TA, SCLK, DQCLK0, DQCLK1, Q);
   input TA, SCLK, DQCLK0, DQCLK1;
   output Q;

   reg QT1, QT2;
   reg last_SCLK, last_DQCLK;
   wire QN_sig;
   wire SCLKB, OPOSA, DQCLK0N, DQCLK1N, DQCLK;

   assign QN_sig = QT2; 

   buf (Q, QN_sig);
   buf (OPOSA, TA);
   not (DQCLK0N, DQCLK0);
   not (DQCLK1N, DQCLK1);
   buf (SCLKB, SCLK);
   and (DQCLK, DQCLK0N, DQCLK1N);

initial
begin
QT1 = 0;
QT2 = 0;
last_SCLK = 0;
last_DQCLK = 0;
end

always @ (SCLKB, DQCLK)
begin
   last_SCLK <= SCLKB;
   last_DQCLK <= DQCLK;
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (QT1 != OPOSA)
         QT1 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            QT1 <= OPOSA;
         end
   end
end

always @ (DQCLK)
begin
   if (DQCLK === 1'bX)
   begin
      if (QT2 != QT1)
         QT2 <= 1'bX;
   end
   else
   begin
      if (DQCLK === 1'b1 && last_DQCLK === 1'b0)
         begin
            QT2 <= QT1;
         end
   end
end

endmodule

`endcelldefine
