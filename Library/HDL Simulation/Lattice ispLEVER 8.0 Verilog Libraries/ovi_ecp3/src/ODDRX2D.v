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

module ODDRX2D(DA0, DB0, DA1, DB1, SCLK, DQCLK0, DQCLK1, Q);
   input DA0, DB0, DA1, DB1, SCLK, DQCLK0, DQCLK1 ;
   output Q;

   parameter ISI_CAL  = "BYPASS";
   parameter MEMMODE  = "DISABLED";

   reg Q_b, same1, same2;
   reg QP1, QP2, QP3, QP4, QP5, QP6;
   reg last_SCLK;
   wire QN_sig;
   wire SCLKB, OPOSA, OPOSB, ONEGA, ONEGB, DQCLK0B, DQCLK1B;
   wire [1:0] DQCLK;

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);
   buf (OPOSA, DA0);
   buf (ONEGA, DB0);
   buf (OPOSB, DA1);
   buf (ONEGB, DB1);
   buf (SCLKB, SCLK);
   not (DQCLK0B, DQCLK0);
   not (DQCLK1B, DQCLK1);

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
QP4 = 0;
QP5 = 0;
QP6 = 0;
last_SCLK = 0;
end

assign DQCLK = {DQCLK1B, DQCLK0B};

initial
begin
last_SCLK = 1'b0;
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
      if (QP2 != ONEGA)
         QP2 <= 1'bX;
      if (QP3 != OPOSB)
         QP3 <= 1'bX;
      if (QP4 != ONEGB)
         QP4 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            QP1 <= OPOSA;
            QP2 <= ONEGA;
            QP3 <= OPOSB;
            QP4 <= ONEGB;
         end
   end
end

always @ (SCLKB or QP3)
begin
   if (SCLKB === 1'bX)
   begin
      if (QP5 != QP3)
         QP5 <= 1'bX;
   end
   else
   begin
      if (SCLKB == 1'b0)
         begin
            QP5 <= QP3;
         end
   end
end

always @ (SCLKB or QP4)
begin
   if (SCLKB === 1'bX)
   begin
      if (QP6 != QP4)
         QP6 <= 1'bX;
   end
   else
   begin
      if (SCLKB == 1'b0)
         begin
            QP6 <= QP4;
         end
   end
end

always @ (QP1 or QP2 or QP5 or QP6 or DQCLK)
begin
   case (DQCLK)
        2'b00 :  Q_b = QP5;
        2'b01 :  Q_b = QP6;
        2'b10 :  Q_b = QP2;
        2'b11 :  Q_b = QP1;
        2'b0x :  Q_b = DataSame(QP5, QP6);
        2'b1x :  Q_b = DataSame(QP2, QP1);
        2'bx0 :  Q_b = DataSame(QP5, QP2);
        2'bx1 :  Q_b = DataSame(QP6, QP1);
        default begin
                 same1 = DataSame(QP1, QP2);
                 same2 = DataSame(QP6, QP5);
                 Q_b = DataSame(same1,same2);
                 end
   endcase
end

endmodule

`endcelldefine
