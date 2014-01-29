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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ODDRA.v,v 1.4 2005/05/19 19:06:53 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDRA(DA, DB, CLK, RST, Q);
   input DA, DB, CLK, RST;
   output Q;

   parameter REGSET = "RESET";    // "RESET" or "SET"

   wire DAb, DBb, CLKB, RSTB;

   buf (DAb, DA);
   buf (DBb, DB);
   buf (CLKB, CLK);
   buf (RSTB, RST);

   reg Qb;
   reg QP, QN;
   reg last_CLK;

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
      if (QN !== DBb)
         QN <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b0 && last_CLK === 1'b1)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               QN <= 1'b0;
            else if (REGSET == "SET")
               QN <= 1'b1;
         end
         else
            QN <= DBb;
      end
   end
end

always @ (QP or QN or CLKB)
begin
   case (CLKB)
        1'b0 :  Qb = QP;
        1'b1 :  Qb = QN;
        default Qb = DataSame(QP, QN);
   endcase
end

endmodule

`endcelldefine
