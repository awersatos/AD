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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ODDRX2A.v,v 1.7 2005/05/19 19:06:54 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDRX2A(DA0, DB0, DA1, DB1, ECLK, SCLK, RST, Q, UPDATE);
   input DA0, DA1, DB0, DB1, ECLK, SCLK, RST;
   output Q, UPDATE;

   parameter LSRMODE = "LOCAL";
   parameter UPDT = "POS";
   parameter REGSET = "RESET";    // "RESET" or "SET"

   reg Qb;
   reg Q0P0, Q0N0, Q0P1, Q0N1, Q0P2, Q0N2;
   reg Q1P0, Q1N0, Q1P1, Q1N1, Q1P2, Q1N2;
   reg lsr_int0, lsr_int1, lsr_int, up_q0, up_q1, up_q2, up_pos, up_neg;
   reg update_int;
   reg last_ECLK, last_SCLK;
   reg new_Q0P, new_Q0N;

   wire DA0b, DA1b, DB0b, DB1b, ECLKB, SCLKB, RSTB;

   buf (DA0b, DA0);
   buf (DA1b, DA1);
   buf (DB0b, DB0);
   buf (DB1b, DB1);
   buf (ECLKB, ECLK);
   buf (SCLKB, SCLK);
   buf (RSTB, RST);

   buf (UPDATE, update_int);

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

// DDR/Shift generation

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (Q0N0 !== DA0b)
         Q0N0 <= 1'bX;
      if (Q0P0 !== DB0b)
         Q0P0 <= 1'bX;
      if (Q1N0 !== DA1b)
         Q1N0 <= 1'bX;
      if (Q1P0 !== DB1b)
         Q1P0 <= 1'bX;
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
               Q0N0 <= 1'b0;
               Q1P0 <= 1'b0;
               Q1N0 <= 1'b0;
            end
            else if (REGSET == "SET")
            begin
               Q0P0 <= 1'b1;
               Q0N0 <= 1'b1;
               Q1P0 <= 1'b1;
               Q1N0 <= 1'b1;
            end
         end
         else
         begin
            Q0N0 <= DA0b;
            Q0P0 <= DB0b;
            Q1N0 <= DA1b;
            Q1P0 <= DB1b;
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
            end
            else if (REGSET == "SET")
            begin
               Q0P1 <= 1'b1;
               Q1P1 <= 1'b1;
            end
         end
         else if (up_pos == 1'b1)
         begin
            Q0P1 <= Q0P0;
            Q1P1 <= Q1P0;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0N1 !== Q0N0)
         Q0N1 <= 1'bX;
      if (Q1N1 !== Q1N0)
         Q1N1 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
            begin
               Q0N1 <= 1'b0;
               Q1N1 <= 1'b0;
            end
            else if (REGSET == "SET")
            begin
               Q0N1 <= 1'b1;
               Q1N1 <= 1'b1;
            end
         end
         else if (up_pos == 1'b1)
         begin
            Q0N1 <= Q0N0;
            Q1N1 <= Q1N0;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q1P2 !== Q1P1)
         Q1P2 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               Q1P2 <= 1'b0;
            else if (REGSET == "SET")
               Q1P2 <= 1'b1;
         end
         else if (up_pos == 1'b1)
         begin
            Q1P2 <= Q1P1;
         end
      end
   end
end

always @ (Q0P1 or Q1P2 or up_pos)
begin
   if (up_pos == 1'b1)
      new_Q0P <= Q0P1;
   else
      new_Q0P <= Q1P2;
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0P2 !== new_Q0P)
         Q0P2 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               Q0P2 <= 1'b0;
            else if (REGSET == "SET")
               Q0P2 <= 1'b1;
         end
         else 
         begin
            Q0P2 <= new_Q0P;
         end 
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q1N2 !== Q1N1)
         Q1N2 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               Q1N2 <= 1'b0;
            else if (REGSET == "SET")
               Q1N2 <= 1'b1;
         end
         else if (up_neg == 1'b1)
         begin
            Q1N2 <= Q1N1;
         end
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (Q0N2 !== new_Q0N)
         Q0N2 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RSTB == 1'b1)
         begin
            if (REGSET == "RESET")
               Q0N2 <= 1'b0;
            else if (REGSET == "SET")
               Q0N2 <= 1'b1;
         end
         else
         begin
            Q0N2 <= new_Q0N;
         end
      end
   end
end

always @ (Q0N1 or Q1N2 or up_neg)
begin
   if (up_neg == 1'b1)
      new_Q0N <= Q0N1;
   else
      new_Q0N <= Q1N2;
end

always @ (Q0P2 or Q0N2 or ECLKB)
begin
   case (ECLKB)
        1'b0 :  Qb = Q0P2;
        1'b1 :  Qb = Q0N2;
        default Qb = DataSame(Q0P2, Q0N2);
   endcase
end

endmodule

`endcelldefine
