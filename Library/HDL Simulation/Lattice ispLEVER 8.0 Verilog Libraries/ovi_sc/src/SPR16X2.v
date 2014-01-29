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
// Simulation Library File for SC
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/SPR16X2.v,v 1.4 2005/05/19 19:07:02 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module SPR16X2 ( DI0, DI1, AD0, AD1, AD2, AD3, WRE, WPE, CK, DO0, DO1);
 
  input AD0, AD1, AD2, AD3, DI0, DI1, CK, WRE, WPE;
  output DO0, DO1;

  parameter [63:0] initval = 64'h0000000000000000;
  parameter GSR = "ENABLED";

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  integer i;
  reg memchg;
  reg wre_reg;
  reg [1:0] din_reg;
  reg [3:0] wadr_reg;
  reg [3:0] radr_reg;
  reg [1:0] MEM [15:0];
  reg SRN;
  reg [1:0] DOb;
  reg [63:0] init_value;

  buf  (AD0b, AD0);
  buf  (AD1b, AD1);
  buf  (AD2b, AD2);
  buf  (AD3b, AD3);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (CKb, CK);
  buf  (WREb, WRE);
  buf  (WPEb, WPE);

  buf  (DO0, DOb[0]);
  buf  (DO1, DOb[1]);

  initial
  begin
    init_value = initval;
    memchg = 1'b0;

    for (i = 0; i < 16; i = i+1)
    begin
        MEM[i] = init_value[1:0];
        init_value = (init_value >> 4);
    end
  end

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end


   // Latch the address and data in for writing
   // Registers are rising edge enabled
  always @ (posedge CKb) begin
    if (SRN == 1) begin
       wre_reg = WREb && WPEb;
       din_reg = {DI1b, DI0b};
       wadr_reg = {AD3b, AD2b, AD1b, AD0b};
    end
  end

  always @ (SRN) begin
    if (SRN == 0) begin
       wadr_reg = 4'b0;
       wre_reg = 1'b0;
    end
  end //end of always loop

 always @ (negedge CKb) begin
     if (wre_reg === 1'b1) begin
          MEM[wadr_reg] = din_reg;
          memchg = ~memchg;
     end
   end

  always @ (AD3b or AD2b or AD1b or AD0b) begin
     radr_reg = {AD3b, AD2b, AD1b, AD0b};
  end

  always @ (radr_reg[3] or radr_reg[2] or radr_reg[1] or
  radr_reg[0] or memchg)
  begin
      DOb = MEM[radr_reg];
  end

endmodule

`endcelldefine

