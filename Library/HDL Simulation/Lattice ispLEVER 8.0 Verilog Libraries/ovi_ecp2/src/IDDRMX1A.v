`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRMX1A(D, ECLK, SCLK, CE, RST, DDRCLKPOL, QA, QB);

input  D, ECLK, SCLK, CE, DDRCLKPOL, RST;
output QA, QB;

wire Db, ECLKB, SCLKB, CEB, DDRCLKPOLB, RSTB;

reg QP0, QN0, QN1;
reg last_ECLK, last_sclk_pol;
reg IPOS0, IPOS1;
wire sclk_pol;
wire sclk_pol_p;
wire sclk_pol_n;

buf (Db, D);
buf (ECLKB, ECLK);
buf (SCLKB, SCLK);
buf (CEB, CE);
buf (DDRCLKPOLB, DDRCLKPOL);
buf (RSTB, RST);

//buf (QA, IPOS0);
//buf (QB, IPOS1);
buf (QA, IPOS1);
buf (QB, IPOS0);

initial
begin
QP0 = 0;
QN1 = 0;
QN0 = 0;
IPOS0 = 0;
IPOS1 = 0;
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

endmodule

`endcelldefine
