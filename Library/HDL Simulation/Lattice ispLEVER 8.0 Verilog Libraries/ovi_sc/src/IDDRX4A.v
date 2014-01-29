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
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/orca5/RCS/IDDRX4A.v,v 1.7 2005/09/02 19:02:57 pradeep Exp $
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRX4A(D, ECLK, SCLK, RST, RSTAIL, RUNAIL, QA0, QB0, QA1, QB1, QA2, QB2, QA3, QB3, UPDATE, LOCK);
   input D, ECLK, SCLK, RST, RSTAIL, RUNAIL;
   output QA0, QA1, QA2, QA3, QB0, QB1, QB2, QB3, UPDATE, LOCK;

   parameter LSRMODE = "LOCAL";
   parameter UPDT = "POS";
   parameter AILRST = "ENABLED";

   reg QP0, QN0, LOCKB, LOCKB_int;
   reg Q0P1, Q1P1, Q2P1, Q0N1, Q1N1, Q2N1;
   reg Q0P2, Q1P2, Q2P2, Q3P2, Q0N2, Q1N2, Q2N2, Q3N2;
   reg Q0P3, Q1P3, Q2P3, Q3P3, Q0N3, Q1N3, Q2N3, Q3N3;
   reg update_int;
   reg lsr_int0, lsr_int1, lsr_int, up_q0, up_q1, up_q2, up_pos, up_neg;
   integer LOCK_COUNT, DATA_COUNT;
   reg last_ECLK, last_SCLK, last_RUNAILB;

   wire Db, ECLKB, SCLKB, RSTB, RUNAILB, RSTAILB;

   buf (Db, D);
   buf (ECLKB, ECLK);
   buf (SCLKB, SCLK);
   buf (RSTB, RST);
   buf (RSTAILB, RSTAIL);
   buf (RUNAILB, RUNAIL);

   buf (QA0, Q3N3);
   buf (QB0, Q3P3);
   buf (QA1, Q2N3);
   buf (QB1, Q2P3);
   buf (QA2, Q1N3);
   buf (QB2, Q1P3);
   buf (QA3, Q0N3);
   buf (QB3, Q0P3);
   buf (LOCK, LOCKB);
   buf (UPDATE, update_int);

initial
begin
DATA_COUNT = 0;
LOCK_COUNT = 0;
LOCKB_int = 1'b0;
LOCKB = 1'b0;
last_ECLK = 1'b0;
last_SCLK = 1'b0;
last_RUNAILB = 1'b0;
end

always @ (ECLKB, SCLKB)
begin
   last_ECLK <= ECLKB;
   last_SCLK <= SCLKB;
end

//Update block
always @ (posedge SCLKB)
begin
   lsr_int0 <= RSTB;
   lsr_int1 <= #0.3 lsr_int0;
end

always @ (posedge ECLKB)
begin
   if (LSRMODE == "LOCAL")
      lsr_int <= lsr_int1;
   else if (LSRMODE == "EDGE")
      lsr_int <= RSTB;
end

always @ (posedge ECLKB)
begin
   if (lsr_int == 1'b1)
   begin
      up_q0 <= 1'b0;
      up_q1 <= 1'b0;
      up_q2 <= 1'b1;
      up_pos <= 1'b0;
   end
   else
   begin
      up_q0 <= up_pos;
      up_q1 <= up_q0;
      up_q2 <= up_q1;
      up_pos <= up_q2;
   end
end

always @ (negedge ECLKB)
begin
   if (lsr_int == 1'b1)
      up_neg <= 1'b0;
   else
      up_neg <= up_q2;
end

always @ (up_pos or up_neg)
begin
   if (UPDT == "POS")
      update_int <= up_pos;
   else if (UPDT == "NEG")
      update_int <= up_neg;
end

always @ (Db or posedge RSTAILB or posedge RUNAILB)
begin
   if (AILRST == "ENABLED")
   begin
      if (RSTAILB == 1'b1 || (RUNAILB === 1'b1 && last_RUNAILB === 1'b0))
         DATA_COUNT <= 0;
      else
         if (RUNAILB == 1'b1)
         begin
            if (DATA_COUNT < 3)
               DATA_COUNT = DATA_COUNT + 1;
         end
   end
   else
      if (RUNAILB === 1'b1 && last_RUNAILB === 1'b0)
      begin
         DATA_COUNT <= 0;
      end
      else
         if (RUNAILB == 1'b1)
         begin
            if (DATA_COUNT < 3)
               DATA_COUNT = DATA_COUNT + 1;
         end
end

always @ (RUNAILB)
begin
   last_RUNAILB <= RUNAILB;
end

always @ (posedge ECLKB or posedge RSTAILB or posedge RUNAILB)
begin
   if (AILRST == "ENABLED")
   begin
      if (RSTAILB == 1'b1 || (RUNAILB === 1'b1 && last_RUNAILB === 1'b0))
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
      if (RUNAILB === 1'b1 && last_RUNAILB === 1'b0)
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
   end
end

// Data

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (QP0 !== Db)
         QP0 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            QP0 <= 1'b0;
         else
            QP0 <= Db;
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (QN0 !== Db)
         QN0 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RSTB == 1'b1)
            QN0 <= 1'b0;
         else
            QN0 <= Db;
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0P1 !== QP0)
         Q0P1 <= 1'bX;
      if (Q1P1 !== Q0P1)
         Q1P1 <= 1'bX;
      if (Q2P1 !== Q1P1)
         Q2P1 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            Q0P1 <= 1'b0;
            Q1P1 <= 1'b0;
            Q2P1 <= 1'b0;
         end
         else 
         begin
            Q0P1 <= QP0;
            Q1P1 <= Q0P1;
            Q2P1 <= Q1P1;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0N1 !== QN0)
         Q0N1 <= 1'bX;
      if (Q1N1 !== Q0N1)
         Q1N1 <= 1'bX;
      if (Q2N1 !== Q1N1)
         Q2N1 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RSTB == 1'b1)
         begin
            Q0N1 <= 1'b0;
            Q1N1 <= 1'b0;
            Q2N1 <= 1'b0;
         end
         else 
         begin
            Q0N1 <= QN0;
            Q1N1 <= Q0N1;
            Q2N1 <= Q1N1;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0P2 !== QP0)
         Q0P2 <= 1'bX;
      if (Q1P2 !== Q0P1)
         Q1P2 <= 1'bX;
      if (Q2P2 !== Q1P1)
         Q2P2 <= 1'bX;
      if (Q3P2 !== Q2P1)
         Q3P2 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            Q0P2 <= 1'b0;
            Q1P2 <= 1'b0;
            Q2P2 <= 1'b0;
            Q3P2 <= 1'b0;
         end
         else if (up_pos == 1'b1)
         begin
            Q0P2 <= QP0;
            Q1P2 <= Q0P1;
            Q2P2 <= Q1P1;
            Q3P2 <= Q2P1;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0N2 !== QN0)
         Q0N2 <= 1'bX;
      if (Q1N2 !== Q0N1)
         Q1N2 <= 1'bX;
      if (Q2N2 !== Q1N1)
         Q2N2 <= 1'bX;
      if (Q3N2 !== Q2N1)
         Q3N2 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RSTB == 1'b1)
         begin
            Q0N2 <= 1'b0;
            Q1N2 <= 1'b0;
            Q2N2 <= 1'b0;
            Q3N2 <= 1'b0;
         end
         else if (up_neg == 1'b1)
         begin
            Q0N2 <= QN0;
            Q1N2 <= Q0N1;
            Q2N2 <= Q1N1;
            Q3N2 <= Q2N1;
         end
      end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q0P3 !== Q0P2)
         Q0P3 <= 1'bX;
      if (Q1P3 !== Q1P2)
         Q1P3 <= 1'bX;
      if (Q2P3 !== Q2P2)
         Q2P3 <= 1'bX;
      if (Q3P3 !== Q3P2)
         Q3P3 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            Q0P3 <= 1'b0;
            Q1P3 <= 1'b0;
            Q2P3 <= 1'b0;
            Q3P3 <= 1'b0;
         end
         else 
         begin
            Q0P3 <= Q0P2;
            Q1P3 <= Q1P2;
            Q2P3 <= Q2P2;
            Q3P3 <= Q3P2;
         end
      end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q0N3 !== Q0N2)
         Q0N3 <= 1'bX;
      if (Q1N3 !== Q1N2)
         Q1N3 <= 1'bX;
      if (Q2N3 !== Q2N2)
         Q2N3 <= 1'bX;
      if (Q3N3 !== Q3N2)
         Q3N3 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            Q0N3 <= 1'b0;
            Q1N3 <= 1'b0;
            Q2N3 <= 1'b0;
            Q3N3 <= 1'b0;
         end
         else
         begin
            Q0N3 <= Q0N2;
            Q1N3 <= Q1N2;
            Q2N3 <= Q2N2;
            Q3N3 <= Q3N2;
         end
      end
   end
end

endmodule

`endcelldefine
