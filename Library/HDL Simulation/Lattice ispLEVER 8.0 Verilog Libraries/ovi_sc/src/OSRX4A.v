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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/OSRX4A.v,v 1.7 2005/05/19 19:06:58 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module OSRX4A(D0, D1, D2, D3, ECLK, SCLK, RST, Q, UPDATE);
   input D0, D1, D2, D3, ECLK, SCLK, RST;
   output Q, UPDATE;

   parameter LSRMODE = "LOCAL";
   parameter UPDT = "POS";
   parameter REGSET = "RESET";    // "RESET" or "SET"

   reg lsr_int0, lsr_int1, lsr_int, up_q0, up_q1, up_q2, up_pos, up_neg;  
   reg Q0P0, Q1P0, Q2P0, Q3P0;
   reg Q0P1, Q1P1, Q2P1, Q3P1;
   reg Q0P2, Q1P2, Q2P2, Q3P2;
   reg update_int;
   reg last_ECLK, last_SCLK;
   reg new1_Q0P, new2_Q0P, new3_Q0P;

   wire D0b, D1b, D2b, D3b, ECLKB, SCLKB, RSTB;

   buf (D0b, D0);
   buf (D1b, D1);
   buf (D2b, D2);
   buf (D3b, D3);
   buf (ECLKB, ECLK);
   buf (SCLKB, SCLK);
   buf (RSTB, RST);

   buf (Q, Q0P2);
   buf (UPDATE, update_int);

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

// Shift Generation

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q0P0 !== D0b)
         Q0P0 <= 1'bX;
      if (Q1P0 !== D1b)
         Q1P0 <= 1'bX;
      if (Q2P0 !== D2b)
         Q2P0 <= 1'bX;
      if (Q3P0 !== D3b)
         Q3P0 <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
            begin
               Q0P0 <= 1'b0;
               Q1P0 <= 1'b0;
               Q2P0 <= 1'b0;
               Q3P0 <= 1'b0;
            end
            else if (REGSET == "SET")
            begin
               Q0P0 <= 1'b1;
               Q1P0 <= 1'b1;
               Q2P0 <= 1'b1;
               Q3P0 <= 1'b1;
            end
         end
         else
         begin
            Q0P0 <= D0b;
            Q1P0 <= D1b;
            Q2P0 <= D2b;
            Q3P0 <= D3b;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0P1 !== Q0P0)
         Q0P1 <= 1'bX;
      if (Q1P1 !== Q1P0)
         Q1P1 <= 1'bX;
      if (Q2P1 !== Q2P0)
         Q2P1 <= 1'bX;
      if (Q3P1 !== Q3P0)
         Q3P1 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
            begin
               Q0P1 <= 1'b0;
               Q1P1 <= 1'b0;
               Q2P1 <= 1'b0;
               Q3P1 <= 1'b0;
            end
            else if (REGSET == "SET")
            begin
               Q0P1 <= 1'b1;
               Q1P1 <= 1'b1;
               Q2P1 <= 1'b1;
               Q3P1 <= 1'b1;
            end
         end
         else if (up_pos == 1'b1)
         begin
            Q0P1 <= Q0P0;
            Q1P1 <= Q1P0;
            Q2P1 <= Q2P0;
            Q3P1 <= Q3P0;
         end
      end
   end
end

always @ (Q0P1, Q1P1, Q2P1, up_pos, Q1P2, Q2P2, Q3P2)
begin
   if (up_pos == 1'b1)
   begin
      new1_Q0P <= Q0P1;
      new2_Q0P <= Q1P1;
      new3_Q0P <= Q2P1;
   end
   else 
   begin
      new1_Q0P <= Q1P2;
      new2_Q0P <= Q2P2;
      new3_Q0P <= Q3P2;
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0P2 !== new1_Q0P)
         Q0P2 <= 1'bX;
      if (Q1P2 !== new2_Q0P)
         Q1P2 <= 1'bX;
      if (Q2P2 !== new3_Q0P)
         Q2P2 <= 1'bX;
      if (Q3P2 !== Q3P1)
         Q3P2 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
            begin
               Q0P2 <= 1'b0;
               Q1P2 <= 1'b0;
               Q2P2 <= 1'b0;
               Q3P2 <= 1'b0;
            end
            else if (REGSET == "SET")
            begin
               Q0P2 <= 1'b1;
               Q1P2 <= 1'b1;
               Q2P2 <= 1'b1;
               Q3P2 <= 1'b1;
            end
         end
         else 
         begin
            Q0P2 <= new1_Q0P;
            Q1P2 <= new2_Q0P;
            Q2P2 <= new3_Q0P;
            if (up_pos == 1'b1)
               Q3P2 <= Q3P1;
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
