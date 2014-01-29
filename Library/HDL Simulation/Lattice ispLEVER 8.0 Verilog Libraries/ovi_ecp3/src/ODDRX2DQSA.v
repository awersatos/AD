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

module ODDRX2DQSA(DB0, DB1, SCLK, DQCLK0, DQCLK1, DQSW, Q, DQSTCLK);
   input DB0, DB1, SCLK, DQCLK0, DQCLK1, DQSW;
   output Q, DQSTCLK;

   parameter ISI_CAL  = "BYPASS";
   parameter MEMMODE  = "DISABLED";

   reg QP1, QP2, QP3, QP4, Q_b, same1, same2;
   reg last_SCLK;
   wire QN_sig, SCLKB, OPOSA, OPOSB, DQSWB;
   wire [1:0] DQCLK;

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);
   buf (OPOSA, DB0);
   buf (OPOSB, DB1);
   not (DQCLK0B, DQCLK0);
   not (DQCLK1B, DQCLK1);
   buf (DQSTCLK, DQCLK1B);
   buf (DQSWB, DQSW);
   buf (SCLKB, SCLK);

assign DQCLK = {DQCLK1B, DQCLK0B};

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
      if (QP2 != OPOSB)
         QP2 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            QP1 <= OPOSA;
            QP2 <= OPOSB;
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

always @ (QP1 or QP3 or DQCLK)
begin
   case (DQCLK)
        2'b00 :  QP4 = QP3;
        2'b01 :  QP4 = 1'b0;
        2'b10 :  QP4 = 1'b0;
        2'b11 :  QP4 = QP1;
        default begin
                 same1 = DataSame(QP1, 1'b0);
                 same2 = DataSame(1'b0, QP3);
                 QP4 = DataSame(same1,same2);
                 end
   endcase
end

always @ (DQSWB)
begin
   if (DQSWB === 1'bX)
   begin
      if (Q_b != QP4)
         Q_b <= 1'bX;
   end
   else
   begin
      Q_b <= QP4;
   end
end

endmodule

`endcelldefine
