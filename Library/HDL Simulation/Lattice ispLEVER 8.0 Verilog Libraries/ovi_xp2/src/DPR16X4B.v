`resetall
`timescale 1 ns / 1 ps

`celldefine

module DPR16X4B ( DI0, DI1, DI2, DI3, WAD0, WAD1, WAD2, WAD3, WRE, WCK,
                  RAD0, RAD1, RAD2, RAD3, DO0, DO1, DO2, DO3);
 
  input WAD0,WAD1,WAD2,WAD3,DI0, DI1, DI2, DI3, WCK, WRE;
  input RAD0,RAD1,RAD2,RAD3;
  output DO0, DO1, DO2, DO3;

  parameter [63:0] initval = 64'h0000000000000000;

  integer i;
  reg wre_reg;
  reg [3:0] din_reg;
  reg [3:0] wadr_reg;
  reg [3:0] radr_reg;
  reg [3:0] MEM [15:0];
  reg [3:0] DOb;
  reg [63:0] pick_data;
  reg memchg;

  buf  (WAD0b, WAD0);
  buf  (WAD1b, WAD1);
  buf  (WAD2b, WAD2);
  buf  (WAD3b, WAD3);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (DI2b, DI2);
  buf  (DI3b, DI3);
  buf  (WCKb, WCK);
  buf  (WREb, WRE);
  buf  (RAD0b, RAD0);
  buf  (RAD1b, RAD1);
  buf  (RAD2b, RAD2);
  buf  (RAD3b, RAD3);

  buf  (DO0, DOb[0]);
  buf  (DO1, DOb[1]);
  buf  (DO2, DOb[2]);
  buf  (DO3, DOb[3]);

  initial
  begin
     memchg = 1'b0;
     pick_data = initval; 
     for ( i = 0 ; i < 16; i = i + 1)
     begin
        MEM[i] = pick_data[3:0];
        pick_data = (pick_data >> 4);
     end
  end

   // Latch the address and data in for writing
   // Registers are rising edge enabled
  always @ (posedge WCKb) begin
       wre_reg <= WREb;
       din_reg <= {DI3b, DI2b, DI1b, DI0b};
       wadr_reg <= {WAD3b, WAD2b, WAD1b, WAD0b};
  end


  always @ (RAD3b or RAD2b or RAD1b or RAD0b) begin
     radr_reg = {RAD3b, RAD2b, RAD1b, RAD0b};
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

