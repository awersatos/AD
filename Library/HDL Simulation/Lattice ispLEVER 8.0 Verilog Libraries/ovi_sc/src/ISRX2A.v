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
// $Header: /home/rlp/Orfdry/env_rcs/verilog/pkg/versclibs/data/orca5/RCS/ISRX2A.v,v 1.7 2005/09/02 19:02:59 pradeep Exp $
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ISRX2A(D, ECLK, SCLK, RST, RSTAIL, RUNAIL, Q0, Q1, UPDATE, LOCK);
   input D, ECLK, SCLK, RST, RSTAIL, RUNAIL;
   output Q0, Q1, UPDATE, LOCK;

   parameter AILRST = "ENABLED";
   parameter LSRMODE = "LOCAL";
   parameter UPDT = "POS";

   reg q0_int, q1_int;
   reg update_int;
   reg LOCKB, LOCKB_int;
   reg lsr_int0, lsr_int1, lsr_int, up_q0, up_q1, up_q2, up_pos, up_neg;  
   reg d_int0, d_int1, d_int2, d_int3;
   integer LOCK_COUNT, DATA_COUNT;
   reg last_ECLK, last_SCLK;

   wire Db, ECLKB, SCLKB, RSTB, RUNAILB, RSTAILB;

   buf (Db, D);
   buf (ECLKB, ECLK);
   buf (SCLKB, SCLK);
   buf (RSTB, RST);
   buf (RSTAILB, RSTAIL);
   buf (RUNAILB, RUNAIL);

   buf (Q0, q0_int);
   buf (Q1, q1_int);
   buf (UPDATE, update_int);
   buf (LOCK, LOCKB);

initial
begin
DATA_COUNT = 0;
LOCK_COUNT = 0;
LOCKB_int = 1'b0;
LOCKB = 1'b0;
last_ECLK = 1'b0;
last_SCLK = 1'b0;
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
      up_q0 <= 1'b1;
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

always @ (posedge ECLKB or posedge RSTAILB)
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

// Shift Generation

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (d_int0 !== Db)
         d_int0 <= 1'bX;
      if (d_int1 !== d_int0)
         d_int1 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            d_int0 <= 1'b0;
            d_int1 <= 1'b0;
         end
         else
         begin
            d_int0 <= Db;
            d_int1 <= d_int0;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (d_int2 !== d_int0)
         d_int2 <= 1'bX;
      if (d_int3 !== d_int1)
         d_int3 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            d_int2 <= 1'b0;
            d_int3 <= 1'b0;
         end
         else if (up_pos == 1'b1)
         begin
            d_int2 <= d_int0;
            d_int3 <= d_int1;
         end
      end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (q0_int !== d_int3)
         q0_int <= 1'bX;
      if (q1_int !== d_int2)
         q1_int <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            q0_int <= 1'b0;
            q1_int <= 1'b0;
         end
         else
         begin
            q0_int <= d_int3;
            q1_int <= d_int2;
         end
      end
   end
end

initial
begin
   if (LSRMODE != "LOCAL" && LSRMODE != "EDGE")
   begin
      $display("ERROR: LSRMODE <%s> is not valid", LSRMODE);
      $finish;
   end
end

endmodule

`endcelldefine
