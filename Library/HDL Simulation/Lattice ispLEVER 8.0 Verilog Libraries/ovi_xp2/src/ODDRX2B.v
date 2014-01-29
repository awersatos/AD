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
// Simulation Library File for ECP2
//
// $Header:
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDRX2B(DA0, DB0, DA1, DB1, RST, ECLK, SCLK, Q);
   input DA0, DB0, DA1, DB1, RST, ECLK, SCLK;
   output Q;

   reg Q_b, Q_a, Q_d, Q_a_0, Q_b_0, Q_b_1;
   reg last_ECLK;
   reg last_SCLK;
   reg Q0B0, Q1B1, Q2B1, Q0A0, Q1A1, Q2A1;
   wire QN_sig;
   wire RSTB, ECLKB, SCLKB;

   assign QN_sig = Q_d; 

   buf (Q, QN_sig);
//   buf (OPOS0, DA0);
//   buf (OPOS1, DB0);
//   buf (ONEG0, DA1);
//   buf (ONEG1, DB1);
   buf (ONEG1, DA0);
   buf (OPOS1, DA1);
   buf (OPOS0, DB1);
   buf (ONEG0, DB0);
   buf (RSTB, RST);
   buf (ECLKB, ECLK);
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
Q0B0 = 0;
Q1B1 = 0;
Q2B1 = 0;
Q0A0 = 0;
Q1A1 = 0;
Q2A1 = 0;
end

initial
begin
last_ECLK = 1'b0;
last_SCLK = 1'b0;
end

always @ (ECLKB, SCLKB)
begin
   last_ECLK <= ECLKB;
   last_SCLK <= SCLKB;
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q0B0 != ONEG0)
         Q0B0 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            Q0B0 <= ONEG0;
         end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q1B1 != OPOS0)
         Q1B1 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            Q1B1 <= OPOS0;
         end
   end
end

always @ (SCLKB or Q1B1)   //latch
begin
   if (SCLKB === 1'bX)
   begin
      if (Q2B1 != Q1B1)
         Q1B1 <= 1'bX;
   end
   else
   begin
      if (SCLKB == 1'b1)
         Q2B1 <= Q2B1;
      else if (SCLKB == 1'b0)
         Q2B1 <= Q1B1;
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q0A0 != ONEG1)
         Q0A0 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            Q0A0 <= ONEG1;
         end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q1A1 != OPOS1)
         Q1A1 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
         begin
            Q1A1 <= OPOS1;
         end
   end
end

always @ (SCLKB or Q1A1)   //latch
begin
   if (SCLKB === 1'bX)
   begin
      if (Q2A1 != Q1A1)
         Q1A1 <= 1'bX;
   end
   else
   begin
      if (SCLKB == 1'b1)
         Q2A1 <= Q2A1;
      else if (SCLKB == 1'b0)
         Q2A1 <= Q1A1;
   end
end

always @ (Q0A0 or Q2A1 or SCLKB)
begin
   case (SCLKB)
        1'b0 :  Q_a = Q0A0;
        1'b1 :  Q_a = Q2A1;
        default Q_a = DataSame(Q0A0, Q2A1);
   endcase
end

always @ (Q0B0 or Q2B1 or SCLKB)
begin
   case (SCLKB)
        1'b0 :  Q_b = Q0B0;
        1'b1 :  Q_b = Q2B1;
        default Q_b = DataSame(Q0B0, Q2B1);
   endcase
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q_a_0 != Q_a)
         Q_a_0 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
         begin
            if (RSTB == 1'b1)
               Q_a_0 <= 1'b0;
            else
               Q_a_0 <= Q_a;
         end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q_b_0 != Q_b)
         Q_b_0 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
         begin
            Q_b_0 <= Q_b;
         end
   end
end

always @ (ECLKB or Q_b_0)    //Latch
begin
   if (ECLKB === 1'bX)
   begin
      if (Q_b_1 != Q_b_0)
         Q_b_1 <= 1'bX;
   end
   else
   begin
      if (ECLKB == 1'b0)
         begin
            Q_b_1 <= Q_b_0;
         end
   end
end

always @ (Q_a_0 or Q_b_1 or ECLKB)
begin
   case (ECLKB)
        1'b0 :  Q_d = Q_a_0;
        1'b1 :  Q_d = Q_b_1;
        default Q_d = DataSame(Q_a_0, Q_b_1);
   endcase
end

endmodule

`endcelldefine
