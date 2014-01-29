`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRFXA(D, CLK1, CLK2, CE, RST, QA, QB);

input  D, CLK1, CLK2, CE, RST;
output QA, QB;

wire Db, CLK1B, CLK2B, CEB, RSTB;

reg QP0, QN0, QN1;
reg last_CLK1, last_CLK2;
reg IPOS0, IPOS1, QPOS0, QPOS1;

buf (Db, D);
buf (CLK1B, CLK1);
buf (CLK2B, CLK2);
buf (CEB, CE);
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

initial
begin
last_CLK1 = 1'b0;
last_CLK2 = 1'b0;
end

always @ (CLK1B, CLK2B)
begin
   last_CLK1 <= CLK1B;
   last_CLK2 <= CLK2B;
end

always @ (CLK1B)
begin
   if (CLK1B === 1'bX)
   begin
      if (QN0 !== Db)
         QN0 <= 1'bX;
   end
   else
   begin
      if (CLK1B === 1'b0 && last_CLK1 === 1'b1)
      begin
         QN0 <= Db;
      end
   end
end

always @ (CLK1B)
begin
   if (CLK1B === 1'bX)
   begin
      if (QP0 !== Db)
         QP0 <= 1'bX;
   end
   else
   begin
      if (CLK1B === 1'b1 && last_CLK1 === 1'b0)
      begin
         QP0 <= Db;
      end
   end
end

always @ (CLK1B)
begin
   if (CLK1B === 1'bX)
   begin
      if (QN1 !== QP0)
         QN1 <= 1'bX;
   end
   else
   begin
      if (CLK1B === 1'b0 && last_CLK1 === 1'b1)
      begin
         QN1 <= QP0;
      end
   end
end

always @ (CLK1B)
begin
   if (CLK1B === 1'bX)
   begin
      if (IPOS0 !== QN0)
         IPOS0 <= 1'bX;
   end
   else
   begin
      if (CLK1B === 1'b1 && last_CLK1 === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS0 <= 1'b0;
         else if (CEB == 1'b1)
            IPOS0 <= QN0;
      end
   end
end

always @ (CLK1B)
begin
   if (CLK1B === 1'bX)
   begin
      if (IPOS1 !== QN1)
         IPOS1 <= 1'bX;
   end
   else
   begin
      if (CLK1B === 1'b1 && last_CLK1 === 1'b0)
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
