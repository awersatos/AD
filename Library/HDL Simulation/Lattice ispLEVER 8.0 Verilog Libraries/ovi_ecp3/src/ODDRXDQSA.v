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

module ODDRXDQSA(DA, SCLK, DQSW, DQCLK1, DQSTCLK, Q);
   input DA, SCLK, DQSW, DQCLK1;
   output Q, DQSTCLK;

parameter MEMMODE = "DISABLED";

   reg QP1, QP2, Q_b;
   reg last_SCLK;
   wire SCLKB, OPOSA, DQSWB, DQCLK1B;

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);
   buf (OPOSA, DA);
   buf (DQSTCLK, SCLK);
   buf (DQSWB, DQSW);
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
      if (QP1 != OPOSA)
         QP1 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            QP1 <= OPOSA;
         end
   end
end

always @ (QP1 or DQCLK1B)
begin
   case (DQCLK1B)
        1'b0 :  QP2 = 1'b0;
        1'b1 :  QP2 = QP1;
        default QP2 = DataSame(1'b0, QP1);
   endcase
end

always @ (DQSWB)
begin
   if (DQSWB === 1'bX)
   begin
      if (Q_b != QP2)
         Q_b <= 1'bX;
   end
   else
   begin
      Q_b <= QP2;
   end
end

endmodule

`endcelldefine
