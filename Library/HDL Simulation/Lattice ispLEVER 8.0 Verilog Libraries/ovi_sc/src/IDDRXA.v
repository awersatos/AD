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
// $Header: /home/rel01/env5_1a.34/verilog/pkg/versclibs/data/orca5/RCS/IDDRXA.v,v 1.4 2005/05/19 19:06:35 pradeep Exp $
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRXA(D, CLK, RST, RSTAIL, RUNAIL, QA, QB, UPDATE, LOCK);
   input D, CLK, RST, RSTAIL, RUNAIL;
   output QA, QB, UPDATE, LOCK;

   parameter AILRST = "ENABLED";

   reg QP0, QN, QP1, LOCKB, LOCKB_int, UPDATEB;
   integer LOCK_COUNT, DATA_COUNT;
   reg last_CLK;

   wire Db, CLKB, RSTB, RUNAILB, RSTAILB;

   buf (Db, D);
   buf (CLKB, CLK);
   buf (RSTB, RST);
   buf (RSTAILB, RSTAIL);
   buf (RUNAILB, RUNAIL);

   buf (QA, QP0);
   buf (QB, QP1);
   buf (LOCK, LOCKB);
   buf (UPDATE, UPDATEB);

initial
begin
DATA_COUNT = 0;
LOCK_COUNT = 0;
LOCKB_int = 1'b0;
LOCKB = 1'b0;
last_CLK = 1'b0;
UPDATEB = 1'b0;
end

always @ (CLKB)
begin
   last_CLK <= CLKB;
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QP0 !== Db)
         QP0 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            QP0 <= 1'b0;
         else
            QP0 <= Db;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QN !== Db)
         QN <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b0 && last_CLK === 1'b1)
      begin
         if (RSTB == 1'b1)
            QN <= 1'b0;
         else
            QN <= Db;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QP1 !== QN)
         QP1 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            QP1 <= 1'b0;
         else
            QP1 <= QN;
      end
   end
end

always @ (Db or posedge RSTAILB)
begin
   if (AILRST == "ENABLED")
   begin
      if (RSTAILB == 1'b1)
         DATA_COUNT <= 0;
      else
         if (RUNAILB == 1'b1)
         begin
            if (DATA_COUNT < 3)
               DATA_COUNT = DATA_COUNT + 1;
         end
   end
   else
      if (RUNAILB == 1'b1)
      begin
         if (DATA_COUNT < 3)
            DATA_COUNT = DATA_COUNT + 1;
      end
end

always @ (posedge CLKB or posedge RSTAILB)
begin
   if (AILRST == "ENABLED")
   begin
      if (RSTAILB == 1'b1)
      begin
         LOCKB <= 1'b0;
         LOCK_COUNT <= 0;
      end
      else
         if (RUNAILB == 1'b1)
         begin
            if (LOCK_COUNT < 32)
            begin
                LOCKB <= 1'b0;
                LOCK_COUNT <= LOCK_COUNT + 1;
            end
            else
               if (LOCK_COUNT >= 32)
               begin
                  if (DATA_COUNT >= 1)
                     LOCKB <= 1'b1;
               end
         end
         else
            if (RUNAILB == 1'b0)
            begin
               if (LOCK_COUNT >= 32)
               begin
                  if (DATA_COUNT >= 1)
                     LOCKB <= 1'b1;
               end
            end
   else
      if (RUNAILB == 1'b1)
      begin
         if (LOCK_COUNT < 32)
         begin
             LOCKB <= 1'b0;
             LOCK_COUNT <= LOCK_COUNT + 1;
         end
         else
            if (LOCK_COUNT >= 32)
            begin
               if (DATA_COUNT >= 1)
                  LOCKB <= 1'b1;
            end
      end
   end
end

endmodule

`endcelldefine
