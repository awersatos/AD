`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRXC(D, CLK, CE, RST, QA, QB);

input  D, CLK, CE, RST;
output QA, QB;

wire Db, CLKB, CEB, RSTB;

reg QP0, QN0, QN1;
reg last_CLK;
reg IPOS0, IPOS1;

buf (Db, D);
buf (CLKB, CLK);
buf (CEB, CE);
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

initial
begin
last_CLK = 1'b0;
end

always @ (CLKB)
begin
   last_CLK <= CLKB;
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QN0 !== Db)
         QN0 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b0 && last_CLK === 1'b1)
      begin
         QN0 <= Db;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QP0 !== Db)
         QP0 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
      begin
         QP0 <= Db;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (QN1 !== QP0)
         QN1 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b0 && last_CLK === 1'b1)
      begin
         QN1 <= QP0;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (IPOS0 !== QN0)
         IPOS0 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS0 <= 1'b0;
         else if (CEB == 1'b1)
            IPOS0 <= QN0;
      end
   end
end

always @ (CLKB)
begin
   if (CLKB === 1'bX)
   begin
      if (IPOS1 !== QN1)
         IPOS1 <= 1'bX;
   end
   else
   begin
      if (CLKB === 1'b1 && last_CLK === 1'b0)
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
