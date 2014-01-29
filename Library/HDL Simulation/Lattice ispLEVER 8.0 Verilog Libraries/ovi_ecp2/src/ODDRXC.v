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

module ODDRXC(DA, DB, RST, CLK,Q);
   input DA, DB, RST, CLK;
   output Q;

   reg Q_b;
   reg QP0, QP1, QN;
   reg last_CLK;
   wire QN_sig;
   wire RSTB, CLKB;

   assign QN_sig = Q_b; 

   buf (Q, QN_sig);
   buf (ONEG0, DA);
   buf (OPOS0, DB);
   buf (RSTB, RST);
   buf (CLKB, CLK);

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
QP0 = 0;
QP1 = 0;
QN = 0;
end

initial
begin
last_CLK = 1'b0;
end

always @ (CLKB)
begin
   last_CLK <= CLKB;
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QN != ONEG0)
         QN <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
         begin
            if (RSTB == 1'b1)
               QN <= 1'b0;
            else
               QN <= ONEG0;
         end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QP0 != OPOS0)
         QP0 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
         begin
            QP0 <= OPOS0;
         end
   end
end

always @ (CLKB or QP0)
begin
   if (CLKB === 1'bX)
   begin
      if (QP1 != QP0)
         QP1 <= 1'bX;
   end
   else
   begin
      if (CLKB == 1'b0)
         begin
            QP1 <= QP0;
         end
   end
end

always @ (QP1 or QN or CLKB)
begin
   case (CLKB)
        1'b0 :  Q_b = QN;
        1'b1 :  Q_b = QP1;
        default Q_b = DataSame(QN, QP1);
   endcase
end

endmodule

`endcelldefine
