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

module ODDRTDQSA(TA, SCLK, DQSTCLK, DQSW, DB, Q);
   input TA, SCLK, DQSTCLK, DQSW, DB;
   output Q;

   reg QT1, QB1, QB2, QB3, Q_b;
   reg last_SCLK;
   wire QN_sig;
   wire SCLKB, OPOSA, ONEGB, DQSWB, DQCLK;

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);
   buf (OPOSA, TA);
   buf (ONEGB, DB);
   buf (DQCLK, DQSTCLK);
   buf (DQSWB, DQSW);
   buf (SCLKB, SCLK);

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

initial
begin
QT1 = 0;
QB1 = 0;
QB2 = 0;
QB3 = 0;
Q_b = 0;
last_SCLK = 0;
end

always @ (SCLKB)
begin
   last_SCLK <= SCLKB;
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (QT1 != OPOSA)
         QT1 <= 1'bX;
      if (QB1 != ONEGB)
         QB1 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            QT1 <= OPOSA;
            QB1 <= ONEGB;
         end
   end
end

always @ (SCLKB or QB1)
begin
   if (SCLKB === 1'bX)
   begin
      if (QB2 != QB1)
         QB2 <= 1'bX;
   end
   else
   begin
      if (SCLKB == 1'b0)
         begin
            QB2 <= QB1;
         end
   end
end

always @ (QT1 or QB2 or DQCLK)
begin
   case (DQCLK)
        1'b0 :  QB3 = QB2;
        1'b1 :  QB3 = QT1;
        default QB3 = DataSame(QB2, QT1);
   endcase
end

always @ (DQSWB)
begin
   if (DQSWB === 1'bX)
   begin
      if (Q_b != QB3)
         Q_b <= 1'bX;
   end
   else
   begin
      Q_b <= QB3;
   end
end

endmodule

`endcelldefine
