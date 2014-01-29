`resetall
`timescale 1 ns / 1 ps

`celldefine

module SPR16X4A (DI0, DI1, DI2, DI3, AD0, AD1, AD2, AD3, WRE, CK,
                 DO0, DO1, DO2, DO3);
 
  input AD0,AD1,AD2,AD3,DI0, DI1, DI2, DI3, CK, WRE;
  output DO0, DO1, DO2, DO3;

  integer i;
  reg wre_reg;
  reg [3:0] din_reg;
  reg [3:0] wadr_reg;
  reg [3:0] radr_reg;
  reg [3:0] MEM [15:0];
  reg [3:0] DOb;
  reg [63:0] pick_data;
  reg memchg;

  buf  (AD0b, AD0);
  buf  (AD1b, AD1);
  buf  (AD2b, AD2);
  buf  (AD3b, AD3);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (DI2b, DI2);
  buf  (DI3b, DI3);
  buf  (CKb, CK);
  buf  (WREb, WRE);

  buf  (DO0, DOb[0]);
  buf  (DO1, DOb[1]);
  buf  (DO2, DOb[2]);
  buf  (DO3, DOb[3]);

  initial
  begin
     memchg = 1'b0;
  end

   // Latch the address and data in for writing
   // Registers are rising edge enabled
  always @ (posedge CKb) begin
       wre_reg <= WREb;
       din_reg <= {DI3b, DI2b, DI1b, DI0b};
       wadr_reg <= {AD3b, AD2b, AD1b, AD0b};
  end


  always @ (AD3b or AD2b or AD1b or AD0b) begin
     radr_reg = {AD3b, AD2b, AD1b, AD0b};
  end

  always @ (din_reg,wadr_reg,wre_reg) begin
     if (wre_reg === 1'b1) begin
        MEM[wadr_reg] = din_reg;
        memchg = ~memchg;
     end
  end

  always @ (radr_reg or memchg)
  begin
        DOb = MEM[radr_reg];
  end

endmodule

`endcelldefine

