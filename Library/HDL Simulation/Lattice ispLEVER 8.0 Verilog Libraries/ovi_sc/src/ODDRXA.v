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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ODDRXA.v,v 1.4 2005/05/19 19:06:54 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDRXA(DA, DB, CLK, RST, Q);
   input DA, DB, CLK, RST;
   output Q;

   parameter REGSET = "RESET";    // "RESET" or "SET"

   reg Qb;
   reg QP, QN0, QN1;
   reg last_CLK;

   wire DAb, DBb, CLKB, RSTB;

   buf (DAb, DA);
   buf (DBb, DB);
   buf (CLKB, CLK);
   buf (RSTB, RST);

   buf (Q, Qb);

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
      if (QP !== DAb)
         QP <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               QP <= 1'b0;
            else if (REGSET == "SET")
               QP <= 1'b1;
         end
         else
            QP <= DAb;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QN0 !== DBb)
         QN0 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               QN0 <= 1'b0;
            else if (REGSET == "SET")
               QN0 <= 1'b1;
         end
         else
            QN0 <= DBb;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QN1 !== QN0)
         QN1 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b0 && last_CLK === 1'b1)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               QN1 <= 1'b0;
            else if (REGSET == "SET")
               QN1 <= 1'b1;
         end
         else
            QN1 <= QN0;
      end
   end
end

always @ (QP or QN1 or CLKB)
begin
   case (CLKB)
        1'b0 :  Qb = QP;
        1'b1 :  Qb = QN1;
        default Qb = DataSame(QP, QN1);
   endcase
end

endmodule

`endcelldefine
