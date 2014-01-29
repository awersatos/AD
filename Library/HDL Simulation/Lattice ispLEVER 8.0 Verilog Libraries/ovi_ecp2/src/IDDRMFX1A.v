`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRMFX1A(D, ECLK, CLK1, CLK2, CE, RST, DDRCLKPOL, QA, QB);

input  D, ECLK, CLK1, CLK2, CE, DDRCLKPOL, RST;
output QA, QB;

wire Db, ECLKB, CLK1B, CLK2B, CEB, DDRCLKPOLB, RSTB;

reg QP0, QN0, QN1;
reg last_ECLK, last_sclk_pol, last_CLK2;
reg IPOS0, IPOS1, QPOS0, QPOS1;
wire sclk_pol;
wire sclk_pol_p;
wire sclk_pol_n;

buf (Db, D);
buf (ECLKB, ECLK);
buf (CLK1B, CLK1);
buf (CLK2B, CLK2);
buf (CEB, CE);
buf (DDRCLKPOLB, DDRCLKPOL);
buf (RSTB, RST);

//buf (QA, QPOS0);
//buf (QB, QPOS1);
buf (QA, QPOS1);
buf (QB, QPOS0);

initial
begin
QP0 = 0;
QN1 = 0;
QN0 = 0;
IPOS0 = 0;
IPOS1 = 0;
QPOS0 = 0;
QPOS1 = 0;
end

assign sclk_pol_p = CLK1B;
assign sclk_pol_n = ~CLK1B;
assign sclk_pol = DDRCLKPOLB ? sclk_pol_n : sclk_pol_p;

initial
begin
last_ECLK = 1'b0;
last_sclk_pol = 1'b0;
last_CLK2 = 1'b0;
end

always @ (ECLKB, sclk_pol, CLK2B)
begin
   last_ECLK <= ECLKB;
   last_sclk_pol <= sclk_pol;
   last_CLK2 <= CLK2B;
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
         QN0 <= Db;
      end
   end
end

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
         QP0 <= Db;
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (QN1 !== QP0)
         QN1 <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b0 && last_ECLK === 1'b1)
      begin
         QN1 <= QP0;
      end
   end
end

always @ (sclk_pol)
begin
   if (sclk_pol === 1'bX)
   begin
      if (IPOS0 !== QN0)
         IPOS0 <= 1'bX;
   end
   else
   begin
      if (sclk_pol === 1'b1 && last_sclk_pol === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS0 <= 1'b0;
         else if (CEB == 1'b1)
            IPOS0 <= QN0;
      end
   end
end

always @ (sclk_pol)
begin
   if (sclk_pol === 1'bX)
   begin
      if (IPOS1 !== QN1)
         IPOS1 <= 1'bX;
   end
   else
   begin
      if (sclk_pol === 1'b1 && last_sclk_pol === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS1 <= 1'b0;
         else if (CEB == 1'b1)
            IPOS1 <= QN1;
      end
   end
end

always @ (CLK2B)
begin
   if (CLK2B === 1'bX)
   begin
      if (QPOS0 !== IPOS0)
         QPOS0 <= 1'bX;
   end
   else
   begin
      if (CLK2B === 1'b1 && last_CLK2 === 1'b0)
      begin
         if (CEB == 1'b1)
            QPOS0 <= IPOS0;
      end
   end
end

always @ (CLK2B)
begin
   if (CLK2B === 1'bX)
   begin
      if (QPOS1 !== IPOS1)
         QPOS1 <= 1'bX;
   end
   else
   begin
      if (CLK2B === 1'b1 && last_CLK2 === 1'b0)
      begin
         if (CEB == 1'b1)
            QPOS1 <= IPOS1;
      end
   end
end

endmodule

`endcelldefine
