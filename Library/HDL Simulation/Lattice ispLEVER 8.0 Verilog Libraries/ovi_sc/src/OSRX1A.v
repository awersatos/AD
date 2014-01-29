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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/OSRX1A.v,v 1.5 2005/05/19 19:06:58 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSRX1A(D, CLK, RST, Q);
   input D, CLK, RST;
   output Q;

   parameter REGSET = "RESET";    // "RESET" or "SET"
   reg Qb;
   reg last_CLK;

   wire Db, CLKB, RSTB;

   buf (Db, D);
   buf (CLKB, CLK);
   buf (RSTB, RST);

   buf (Q, Qb);

// Shift Generation
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
      if (Qb !== Db)
         Qb <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               Qb <= 1'b0;
            else if (REGSET == "SET")
               Qb <= 1'b1;
         end
         else
            Qb <= Db;
      end
   end
end


endmodule

`endcelldefine
