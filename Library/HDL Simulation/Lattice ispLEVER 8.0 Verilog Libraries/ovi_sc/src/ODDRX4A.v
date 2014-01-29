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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/ODDRX4A.v,v 1.8 2005/05/19 19:06:54 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module ODDRX4A (DA0, DB0, DA1, DB1, DA2, DB2, DA3, DB3, ECLK, SCLK, RST, Q, UPDATE);
   input DA0, DA1, DA2, DA3, DB0, DB1, DB2, DB3, ECLK, SCLK, RST;
   output Q, UPDATE;

   parameter LSRMODE = "LOCAL";
   parameter UPDT = "POS";
   parameter REGSET = "RESET";    // "RESET" or "SET"

   reg Qb;
   reg Q0P0, Q0N0, Q0P1, Q0N1, Q0P2, Q0N2;
   reg Q1P0, Q1N0, Q1P1, Q1N1, Q1P2, Q1N2;
   reg Q2P0, Q2N0, Q2P1, Q2N1, Q2P2, Q2N2;
   reg Q3P0, Q3N0, Q3P1, Q3N1, Q3P2, Q3N2;
   reg lsr_int0, lsr_int1, lsr_int, up_q0, up_q1, up_q2, up_pos, up_neg;
   reg update_int;
   reg last_ECLK, last_SCLK;
   reg new1_Q0P, new1_Q0N, new2_Q0P, new2_Q0N, new3_Q0P, new3_Q0N;

   wire DA0b, DA1b, DA2b, DA3b, DB0b, DB1b, DB2b, DB3b, ECLKB, SCLKB, RSTB;

   buf (DA0b, DA0);
   buf (DA1b, DA1);
   buf (DA2b, DA2);
   buf (DA3b, DA3);
   buf (DB0b, DB0);
   buf (DB1b, DB1);
   buf (DB2b, DB2);
   buf (DB3b, DB3);
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

always @ (ECLK, SCLK)
begin
   last_ECLK <= ECLK;
   last_SCLK <= SCLK;
end

initial
  begin
    lsr_int0 = 1'b0;
    lsr_int1 = 1'b0;
    lsr_int = 1'b0;
  end

//Update block
always @ (posedge SCLK)
begin
   lsr_int0 <= RST;
   lsr_int1 <= #0.3 lsr_int0;
end

always @ (posedge ECLK)
begin
   if (LSRMODE == "LOCAL")
      lsr_int <= lsr_int1;
   else if (LSRMODE == "EDGE")
      lsr_int <= RST;
end

always @ (posedge ECLK)
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

always @ (negedge ECLK)
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

always @ (SCLK)
begin
   if (SCLK === 1'bX)
   begin
      if (Q0N0 !== DA0b)
         Q0N0 <= 1'bX;
      if (Q0P0 !== DB0b)
         Q0P0 <= 1'bX;
      if (Q1N0 !== DA1b)
         Q1N0 <= 1'bX;
      if (Q1P0 !== DB1b)
         Q1P0 <= 1'bX;
      if (Q2N0 !== DA2b)
         Q2N0 <= 1'bX;
      if (Q2P0 !== DB2b)
         Q2P0 <= 1'bX;
      if (Q3N0 !== DA3b)
         Q3N0 <= 1'bX;
      if (Q3P0 !== DB3b)
         Q3P0 <= 1'bX;
   end
   else
   begin
      if (SCLK === 1'b1 && last_SCLK === 1'b0)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
            begin
               Q0P0 <= 1'b0;
               Q0N0 <= 1'b0;
               Q1P0 <= 1'b0;
               Q1N0 <= 1'b0;
               Q2P0 <= 1'b0;
               Q2N0 <= 1'b0;
               Q3P0 <= 1'b0;
               Q3N0 <= 1'b0;
            end
            else if (REGSET == "SET")
            begin
               Q0P0 <= 1'b1;
               Q0N0 <= 1'b1;
               Q1P0 <= 1'b1;
               Q1N0 <= 1'b1;
               Q2P0 <= 1'b1;
               Q2N0 <= 1'b1;
               Q3P0 <= 1'b1;
               Q3N0 <= 1'b1;
            end
         end
         else
         begin
            Q0N0 <= DA0b;
            Q0P0 <= DB0b;
            Q1N0 <= DA1b;
            Q1P0 <= DB1b;
            Q2N0 <= DA2b;
            Q2P0 <= DB2b;
            Q3N0 <= DA3b;
            Q3P0 <= DB3b;
         end
      end
   end
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
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
      if (ECLK === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RST == 1'b1)
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

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q0N1 !== Q0N0)
         Q0N1 <= 1'bX;
      if (Q1N1 !== Q1N0)
         Q1N1 <= 1'bX;
      if (Q2N1 !== Q2N0)
         Q2N1 <= 1'bX;
      if (Q3N1 !== Q3N0)
         Q3N1 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
            begin
               Q0N1 <= 1'b0;
               Q1N1 <= 1'b0;
               Q2N1 <= 1'b0;
               Q3N1 <= 1'b0;
            end
            else if (REGSET == "SET")
            begin
               Q0N1 <= 1'b1;
               Q1N1 <= 1'b1;
               Q2N1 <= 1'b1;
               Q3N1 <= 1'b1;
            end
         end
         else if (up_pos == 1'b1)
         begin
            Q0N1 <= Q0N0;
            Q1N1 <= Q1N0;
            Q2N1 <= Q2N0;
            Q3N1 <= Q3N0;
         end
      end
   end
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q3P2 !== Q3P1)
         Q3P2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q3P2 <= 1'b0;
            else if (REGSET == "SET")
               Q3P2 <= 1'b1;
         end
         else if (up_pos == 1'b1)
         begin
            Q3P2 <= Q3P1;
         end
      end
   end
end

always @ (Q2P1 or Q3P2 or up_pos)
begin
   if (up_pos == 1'b1)
      new1_Q0P <= Q2P1;
   else
      new1_Q0P <= Q3P2;
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q2P2 !== new1_Q0P)
         Q2P2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q2P2 <= 1'b0;
            else if (REGSET == "SET")
               Q2P2 <= 1'b1;
         end
         else
         begin
            Q2P2 <= new1_Q0P;
         end
      end
   end
end

always @ (Q1P1 or Q2P2 or up_pos)
begin
   if (up_pos == 1'b1)
      new2_Q0P <= Q1P1;
   else
      new2_Q0P <= Q2P2;
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q1P2 !== new2_Q0P)
         Q1P2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q1P2 <= 1'b0;
            else if (REGSET == "SET")
               Q1P2 <= 1'b1;
         end
         else
         begin
            Q1P2 <= new2_Q0P;
         end
      end
   end
end

always @ (Q0P1 or Q1P2 or up_pos)
begin
   if (up_pos == 1'b1)
      new3_Q0P <= Q0P1;
   else
      new3_Q0P <= Q1P2;
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q0P2 !== new3_Q0P)
         Q0P2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q0P2 <= 1'b0;
            else if (REGSET == "SET")
               Q0P2 <= 1'b1;
         end
         else
         begin
            Q0P2 <= new3_Q0P;
         end
      end
   end
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q3N2 !== Q3N1)
         Q3N2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q3N2 <= 1'b0;
            else if (REGSET == "SET")
               Q3N2 <= 1'b1;
         end
         else if (up_neg == 1'b1)
         begin
            Q3N2 <= Q3N1;
         end
      end
   end
end

always @ (Q2N1 or Q3N2 or up_neg)
begin
   if (up_neg == 1'b1)
      new1_Q0N <= Q2N1;
   else
      new1_Q0N <= Q3N2;
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q2N2 !== new1_Q0N)
         Q2N2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q2N2 <= 1'b0;
            else if (REGSET == "SET")
               Q2N2 <= 1'b1;
         end
         else
         begin
            Q2N2 <= new1_Q0N;
         end
      end
   end
end

always @ (Q1N1 or Q2N2 or up_neg)
begin
   if (up_neg == 1'b1)
      new2_Q0N <= Q1N1;
   else
      new2_Q0N <= Q2N2;
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q1N2 !== new2_Q0N)
         Q1N2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q1N2 <= 1'b0;
            else if (REGSET == "SET")
               Q1N2 <= 1'b1;
         end
         else
         begin
            Q1N2 <= new2_Q0N;
         end
      end
   end
end

always @ (Q0N1 or Q1N2 or up_neg)
begin
   if (up_neg == 1'b1)
      new3_Q0N <= Q0N1;
   else
      new3_Q0N <= Q1N2;
end

always @ (ECLK)
begin
   if (ECLK === 1'bX)
   begin
      if (Q0N2 !== new3_Q0N)
         Q0N2 <= 1'bX;
   end
   else
   begin
      if (ECLK === 1'b0 && last_ECLK === 1'b1)
      begin
         if (RST == 1'b1)
         begin
            if (REGSET == "RESET")
               Q0N2 <= 1'b0;
            else if (REGSET == "SET")
               Q0N2 <= 1'b1;
         end
         else
         begin
            Q0N2 <= new3_Q0N;
         end
      end
   end
end

always @ (Q0P2 or Q0N2 or ECLK)
begin
   case (ECLK)
        1'b0 :  Qb = Q0P2;
        1'b1 :  Qb = Q0N2;
        default Qb = DataSame(Q0P2, Q0N2);
   endcase
end

endmodule

`endcelldefine
