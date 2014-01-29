`resetall
`timescale 1 ns / 1 ps

`celldefine

module IDDRX2B(D, ECLK, SCLK, CE, RST, QA0, QA1, QB0, QB1);

input  D, ECLK, SCLK, CE, RST;
output QA0, QA1, QB0, QB1;

wire Db, ECLKB, SCLKB, CEB, RSTB;

reg QP0, QN0, QN1;
reg last_ECLK, last_SCLK;
reg IPOS0A, IPOS1A, QPOS0A, QPOS1A;
reg IPOS0B, IPOS1B, QPOS0B, QPOS1B;

buf (Db, D);
buf (ECLKB, ECLK);
buf (SCLKB, SCLK);
buf (CEB, CE);
buf (RSTB, RST);

buf (QA0, QPOS1B);
buf (QA1, QPOS1A);
buf (QB0, QPOS0B);
buf (QB1, QPOS0A);

initial
begin
QP0 = 0;
QN1 = 0;
QN0 = 0;
IPOS0A = 0;
IPOS1A = 0;
IPOS0B = 0;
IPOS1B = 0;
QPOS0A = 0;
QPOS1A = 0;
QPOS0B = 0;
QPOS1B = 0;
end

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

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (IPOS0A !== QN0)
         IPOS0A <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS0A <= 1'b0;
         else if (CEB == 1'b1)
            IPOS0A <= QN0;
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (IPOS1A !== QN1)
         IPOS1A <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS1A <= 1'b0;
         else if (CEB == 1'b1)
            IPOS1A <= QN1;
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (IPOS0B !== IPOS0A)
         IPOS0B <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS0B <= 1'b0;
         else if (CEB == 1'b1)
            IPOS0B <= IPOS0A;
      end
   end
end

always @ (ECLKB)
begin
   if (ECLKB === 1'bX)
   begin
      if (IPOS1B !== IPOS1A)
         IPOS1B <= 1'bX;
   end
   else
   begin
      if (ECLKB === 1'b1 && last_ECLK === 1'b0)
      begin
         if (RSTB == 1'b1)
            IPOS1B <= 1'b0;
         else if (CEB == 1'b1)
            IPOS1B <= IPOS1A;
      end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (QPOS0A !== IPOS0A)
         QPOS0A <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (CEB == 1'b1)
            QPOS0A <= IPOS0A;
      end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (QPOS1A !== IPOS1A)
         QPOS1A <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (CEB == 1'b1)
            QPOS1A <= IPOS1A;
      end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (QPOS0B !== IPOS0B)
         QPOS0B <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (CEB == 1'b1)
            QPOS0B <= IPOS0B;
      end
   end
end

always @ (SCLKB)
begin
   if (SCLKB === 1'bX)
   begin
      if (QPOS1B !== IPOS1B)
         QPOS1B <= 1'bX;
   end
   else
   begin
      if (SCLKB === 1'b1 && last_SCLK === 1'b0)
      begin
         if (CEB == 1'b1)
            QPOS1B <= IPOS1B;
      end
   end
end

endmodule

`endcelldefine
