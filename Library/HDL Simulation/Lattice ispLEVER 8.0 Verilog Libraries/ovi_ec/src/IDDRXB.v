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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/IDDRXB.v,v 1.3 2005/05/19 20:08:44 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRXB(D, ECLK, SCLK, CE, LSR, DDRCLKPOL, QA, QB);
   input D, ECLK, SCLK, CE, LSR, DDRCLKPOL;
   output QA, QB;

   parameter REGSET  = "RESET";

   reg QP, QP_n, QN;
   reg QPreg, QNreg;
   reg last_ECLK, last_sclk_pol;

   wire sclk_pol;

   wire sclk_pol_p;
   wire sclk_pol_n;

   wire Db, ECLKB, SCLKB, CEB, LSRB, DDRCLKPOLB;

   buf (Db, D);
   buf (ECLKB, ECLK);
   buf (SCLKB, SCLK);
   buf (CEB, CE);
   buf (LSRB, LSR);
   buf (DDRCLKPOLB, DDRCLKPOL);
   buf (QA, QPreg);
   buf (QB, QNreg);

initial 
begin
QP = 0;
QP_n = 0;
QN = 0;
QPreg = 0;
QNreg = 0;
end

assign sclk_pol_p = SCLKB;
assign sclk_pol_n = ~SCLKB;

assign sclk_pol = DDRCLKPOLB ? sclk_pol_n : sclk_pol_p;

initial
begin
last_ECLK = 1'b0;
last_sclk_pol = 1'b0;
end

always @ (ECLKB, sclk_pol)
begin
   last_ECLK <= ECLKB;
   last_sclk_pol <= sclk_pol;
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (QP !== Db)
         QP <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 &&  last_ECLK === 1'b0)
         QP <= Db;
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (QP_n !== QP)
         QP_n <= 1'bX;
   end      
   else
   begin
      if (ECLKB === 1'b0 &&  last_ECLK === 1'b1)
         QP_n <= QP;
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (QN !== Db)
         QN <= 1'bX;
   end      
   else
   begin
      if (ECLKB === 1'b0 &&  last_ECLK === 1'b1)
         QN <= Db;
   end
end

always @ (sclk_pol)
begin
   if (sclk_pol === 1'bX)
   begin
      if (QPreg !== QP_n)
         QPreg <= 1'bX;
   end      
   else
   begin
      if (sclk_pol === 1'b1 && last_sclk_pol === 1'b0)
      begin
         if ((LSRB == 1'b1) && (REGSET == "RESET"))
            QPreg <= 1'b0;
         else if ((LSRB == 1'b1) && (REGSET == "SET"))
            QPreg <= 1'b1;
         else if (CEB == 1'b1)
            QPreg <= QP_n;
      end
   end
end

always @ (sclk_pol)
begin
   if (sclk_pol === 1'bX)
   begin
      if (QNreg !== QN)
         QNreg <= 1'bX;
   end    
   else
   begin
      if (sclk_pol === 1'b1 && last_sclk_pol === 1'b0)
      begin
         if ((LSRB == 1'b1) && (REGSET == "RESET"))
            QNreg <= 1'b0;
         else if ((LSRB == 1'b1) && (REGSET == "SET"))
            QNreg <= 1'b1;
         else if ( CEB == 1'b1)
            QNreg <= QN;
      end
   end
end

endmodule

`endcelldefine
