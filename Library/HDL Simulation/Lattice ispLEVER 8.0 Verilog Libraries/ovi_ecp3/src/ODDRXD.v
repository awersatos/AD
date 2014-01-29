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

module ODDRXD(DA, DB, SCLK, DQCLK1, Q);
   input DA, DB, SCLK, DQCLK1;
   output Q;

parameter MEMMODE = "DISABLED";

   reg Q_b;
   reg QP1, QP2, QP3;
   reg last_SCLK;
   wire QN_sig;
   wire SCLKB, OPOSA, ONEGB, DQCLK1B;

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);
   buf (OPOSA, DA);
   buf (ONEGB, DB);
   buf (SCLKB, SCLK);
   buf (DQCLK1B, DQCLK1);

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
QP1 = 0;
QP2 = 0;
QP3 = 0;
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
      if (QP1 != OPOSA)
         QP1 <= 1'bX;
      if (QP2 != ONEGB)
         QP2 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            QP1 <= OPOSA;
            QP2 <= ONEGB;
         end
   end
end

always @ (SCLKB or QP2)
begin
   if (SCLKB === 1'bX)
   begin
      if (QP3 != QP2)
         QP3 <= 1'bX;
   end
   else
   begin
      if (SCLKB == 1'b0)
         begin
            QP3 <= QP2;
         end
   end
end

always @ (QP1 or QP3 or DQCLK1B)
begin
   case (DQCLK1B)
        1'b0 :  Q_b = QP3;
        1'b1 :  Q_b = QP1;
        default Q_b = DataSame(QP3, QP1);
   endcase
end

endmodule

`endcelldefine
