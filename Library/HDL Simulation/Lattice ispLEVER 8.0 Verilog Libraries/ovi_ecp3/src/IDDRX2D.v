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

module IDDRX2D(D, ECLKDQSR, SCLK, DDRLAT, ECLK, DDRCLKPOL, QA0, QA1, QB0, QB1);

input  D, ECLKDQSR, SCLK, DDRLAT, ECLK, DDRCLKPOL;
output QA0, QA1, QB0, QB1;

parameter SCLKLATENCY = 1;
parameter DELAYMODE = "ALIGNED";

wire Db, SCLKb1, ECLKb, DDRCLKPOLb, CLKP, ECLKDQSRb, DDRLATb;

reg QP0, QN0, QN1, IP0, IP1, IN0, IN1, IN2, IP2, IN4, IP4;
reg last_SCLKb, last_ECLKb, last_CLKP, last_ECLKDQSRb;
reg IPB, INB, POLB, INA, IPA;
wire IN3, IP3;
reg SCLKb;
reg INA_1, IPA_1, INB_1, IPB_1, INA_2, IPA_2, INB_2, IPB_2;
 
buf (Db, D);
buf (SCLKb1, SCLK);
buf (ECLKb, ECLK);
buf (ECLKDQSRb, ECLKDQSR);
buf (DDRCLKPOLb, DDRCLKPOL);
buf (DDRLATb, DDRLAT);

buf (QA0, IPA);
buf (QB0, INA);
buf (QA1, IPB);
buf (QB1, INB);

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
IP2 = 0;
IN4 = 0;
IP4 = 0;
INA_1 = 0;
IPA_1 = 0;
INB_1 = 0;
IPB_1 = 0;
INA_2 = 0;
IPA_2 = 0;
INB_2 = 0;
IPB_2 = 0;
INA = 0;
IPA = 0;
IPB = 0;
INB = 0;
POLB = 0;
end

assign CLKP = POLB ? ~ECLKb : ECLKb;

always @ (SCLKb1)
begin
   SCLKb <= #0.001 SCLKb1;
end

initial
begin
last_SCLKb = 1'b0;
last_ECLKb = 1'b0;
last_CLKP = 1'b0;
last_ECLKDQSRb = 1'b0;
end

always @ (SCLKb or ECLKb or CLKP or ECLKDQSRb)
begin
   last_SCLKb <= SCLKb;
   last_ECLKb <= ECLKb;
   last_CLKP <= CLKP;
   last_ECLKDQSRb <= ECLKDQSRb;
end

always @ (ECLKDQSRb)     // falling edge
begin
   if (ECLKDQSRb === 1'bX)
   begin
      if (QN0 !== Db)
         QN0 <= 1'bX;
   end
   else
   begin
      if (ECLKDQSRb === 1'b0 && last_ECLKDQSRb === 1'b1)
      begin
         QN0 <= Db;
      end
   end
end

always @ (ECLKDQSRb or Db)     // negative latch
begin
   if (ECLKDQSRb === 1'bX)
   begin
      if (QP0 !== Db)
         QP0 <= 1'bX;
   end
   else
   begin
      if (ECLKDQSRb == 1'b0)
      begin
         QP0 <= Db;
      end
   end
end

always @ (ECLKDQSRb or DDRCLKPOLb)     // negative latch
begin
   if (ECLKDQSRb === 1'bX)
   begin
      if (POLB !== DDRCLKPOLb)
         POLB <= 1'bX;
   end
   else
   begin
      if (ECLKDQSRb == 1'b0)
      begin
         POLB <= DDRCLKPOLb;
      end
   end
end

always @ (ECLKDQSRb)     // falling edge
begin
   if (ECLKDQSRb === 1'bX)
   begin
      if (QN1 !== QP0)
         QN1 <= 1'bX;
   end
   else
   begin
      if (ECLKDQSRb === 1'b0 && last_ECLKDQSRb === 1'b1)
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

always @ (ECLKb or IN0)     // positive latch
begin
   if (ECLKb === 1'bX)
   begin
      if (IN1 !== IN0)
         IN1 <= 1'bX;
   end
   else
   begin
      if (ECLKb == 1'b1)
      begin
         IN1 <= IN0;
      end
   end
end

always @ (ECLKb or IP0)     // positive latch
begin
   if (ECLKb === 1'bX)
   begin
      if (IP1 !== IP0)
         IP1 <= 1'bX;
   end
   else
   begin
      if (ECLKb == 1'b1)
      begin
         IP1 <= IP0;
      end
   end
end

always @ (ECLKb)
begin
   if (ECLKb === 1'bX)
   begin
      if (IN2 !== IN1)
         IN2 <= 1'bX;
      if (IP2 !== IP1)
         IP2 <= 1'bX;
   end
   else
   begin
      if (ECLKb === 1'b1 && last_ECLKb === 1'b0)
      begin
         IN2 <= IN1;
      end
      if (ECLKb === 1'b1 && last_ECLKb === 1'b0)
      begin
         IP2 <= IP1;
      end
   end
end

assign IN3 = (DDRLATb == 1'b1) ? IN2 : IN1;
assign IP3 = (DDRLATb == 1'b1) ? IP2 : IP1;

always @ (SCLKb)
begin
   if (SCLKb === 1'bX)
   begin
      if (INA_1 !== IN4)
         INA_1 <= 1'bX;
      if (INB_1 !== IN3)
         INB_1 <= 1'bX;
      if (INA_2 !== INA_1)
         INA_2 <= 1'bX;
      if (INB_2 !== INB_1)
         INB_2 <= 1'bX;
   end
   else
   begin
      if (SCLKb === 1'b1 && last_SCLKb === 1'b0)
      begin
         INA_1 <= IN4;
         INB_1 <= IN3;
         INA_2 <= INA_1;
         INB_2 <= INB_1;
      end
   end
end

always @ (SCLKb)
begin
   if (SCLKb === 1'bX)
   begin
      if (IPA_1 !== IP4)
         IPA_1 <= 1'bX;
      if (IPB_1 !== IP3)
         IPB_1 <= 1'bX;
      if (IPA_2 !== IPA_1)
         IPA_2 <= 1'bX;
      if (IPB_2 !== IPB_1)
         IPB_2 <= 1'bX;
   end
   else
   begin
      if (SCLKb === 1'b1 && last_SCLKb === 1'b0)
      begin
         IPA_1 <= IP4;
         IPB_1 <= IP3;
         IPA_2 <= IPA_1;
         IPB_2 <= IPB_1;
      end
   end
end

always @ (INA_1, IPA_1, INB_1, IPB_1, INA_2, IPA_2, INB_2, IPB_2)
begin
   if (SCLKLATENCY == 1)
   begin
      INA <= INA_1;
      IPA <= IPA_1;
      INB <= INB_1;
      IPB <= IPB_1;
   end
   else if (SCLKLATENCY == 2)
   begin
      INA <= INA_2;
      IPA <= IPA_2;
      INB <= INB_2;
      IPB <= IPB_2;
   end
end

always @ (SCLKb or IN3)
begin
   if (SCLKb === 1'bX)
   begin
      if (IN4 !== IN3)
         IN4 <= 1'bX;
   end
   else
   begin
      if (SCLKb == 1'b1)
      begin
         IN4 <= IN3;
      end
   end
end

always @ (SCLKb or IP3)
begin
   if (SCLKb === 1'bX)
   begin
      if (IP4 !== IP3)
         IP4 <= 1'bX;
   end
   else
   begin
      if (SCLKb == 1'b1)
      begin
         IP4 <= IP3;
      end
   end
end

endmodule

`endcelldefine
