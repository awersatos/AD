// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2007 by Lattice Semiconductor Corporation
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
// Simulation Library File for ECP3
//
// $Header: 
//

`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRXD(D, ECLKDQSR, SCLK, DDRCLKPOL, QA, QB);

input  D, ECLKDQSR, SCLK, DDRCLKPOL;
output QA, QB;

parameter SCLKLATENCY = 1;
parameter DELAYMODE = "ALIGNED";

wire Db, SCLKb, ECLKb, DDRCLKPOLb, CLKP;

reg QP0, QN0, QN1, IP0, IP1, IN0, IN1, IN2, IP2, IN3, IP3;
reg last_SCLKb, last_ECLKb, last_CLKP;
reg IPB, INB, POLB;

buf (Db, D);
buf (SCLKb, SCLK);
buf (ECLKb, ECLKDQSR);
buf (DDRCLKPOLb, DDRCLKPOL);

buf (QA, IPB);
buf (QB, INB);

initial
begin
QP0 = 0;
QN1 = 0;
QN0 = 0;
IP0 = 0;
IP1 = 0;
IN0 = 0;
IN1 = 0;
IN2 = 0;
IN3 = 0;
IP2 = 0;
IP3 = 0;
IPB = 0;
INB = 0;
POLB = 0;
end

assign CLKP = POLB ? ~SCLKb : SCLKb;

initial
begin
last_SCLKb = 1'b0;
last_ECLKb = 1'b0;
last_CLKP = 1'b0;
end

always @ (SCLKb or ECLKb or CLKP)
begin
   last_SCLKb <= SCLKb;
   last_ECLKb <= ECLKb;
   last_CLKP <= CLKP;
end

always @ (ECLKb)     // falling edge
begin
   if (ECLKb === 1'bX)
   begin
      if (QN0 !== Db)
         QN0 <= 1'bX;
   end
   else
   begin
      if (ECLKb === 1'b0 && last_ECLKb === 1'b1)
      begin
         QN0 <= Db;
      end
   end
end

always @ (ECLKb or Db or DDRCLKPOLb)     // negative latch
begin
   if (ECLKb === 1'bX)
   begin
      if (QP0 !== Db)
         QP0 <= 1'bX;
      if (POLB !== DDRCLKPOLb)
         POLB <= 1'bX;
   end
   else
   begin
      if (ECLKb == 1'b0)
      begin
         QP0 <= Db;
         POLB <= DDRCLKPOLb;
      end
   end
end

always @ (ECLKb)     // falling edge
begin
   if (ECLKb === 1'bX)
   begin
      if (QN1 !== QP0)
         QN1 <= 1'bX;
   end
   else
   begin
      if (ECLKb === 1'b0 && last_ECLKb === 1'b1)
      begin
         QN1 <= QP0;
      end
   end
end

always @ (CLKP)
begin
   if (CLKP === 1'bX)
   begin
      if (IN0 !== QN0)
         IN0 <= 1'bX;
   end
   else
   begin
      if (CLKP === 1'b1 && last_CLKP === 1'b0)
      begin
         IN0 <= QN0;
      end
   end
end

always @ (CLKP)
begin
   if (CLKP === 1'bX)
   begin
      if (IP0 !== QN1)
         IP0 <= 1'bX;
   end
   else
   begin
      if (CLKP === 1'b1 && last_CLKP === 1'b0)
      begin
         IP0 <= QN1;
      end
   end
end

always @ (SCLKb or IN0)
begin
   if (SCLKb === 1'bX)
   begin
      if (IN1 !== IN0)
         IN1 <= 1'bX;
   end
   else
   begin
      if (SCLKb == 1'b1)
      begin
         IN1 <= IN0;
      end
   end
end

always @ (SCLKb or IP0)
begin
   if (SCLKb === 1'bX)
   begin
      if (IP1 !== IP0)
         IP1 <= 1'bX;
   end
   else
   begin
      if (SCLKb == 1'b1)
      begin
         IP1 <= IP0;
      end
   end
end

always @ (SCLKb)
begin
   if (SCLKb === 1'bX)
   begin
      if (IN2 !== IN1)
         IN2 <= 1'bX;
      if (IN3 !== IN2)
         IN3 <= 1'bX;
   end
   else
   begin
      if (SCLKb === 1'b1 && last_SCLKb === 1'b0)
      begin
         IN2 <= IN1;
         IN3 <= IN2;
      end
   end
end

always @ (SCLKb)
begin
   if (SCLKb === 1'bX)
   begin
      if (IP2 !== IP1)
         IP2 <= 1'bX;
      if (IP3 !== IP2)
         IP3 <= 1'bX;
   end
   else
   begin
      if (SCLKb === 1'b1 && last_SCLKb === 1'b0)
      begin
         IP2 <= IP1;
         IP3 <= IP2;
      end
   end
end

always @ (IN2, IN3, IP2, IP3)
begin
   if (SCLKLATENCY == 1)
   begin
      INB <= IN2;
      IPB <= IP2;
   end
   else if (SCLKLATENCY == 2) 
   begin
      INB <= IN3;
      IPB <= IP3;
   end
end

endmodule

`endcelldefine
