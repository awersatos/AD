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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/DPR16X2.v,v 1.4 2005/05/19 19:06:23 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DPR16X2 ( DI0, DI1, WAD0, WAD1, WAD2, WAD3, WRE, WPE, WCK,
                 RAD0, RAD1, RAD2, RAD3, WDO0, WDO1, RDO0, RDO1);
 
  input WAD0,WAD1,WAD2,WAD3,DI0, DI1, WCK, WRE,WPE;
  input RAD0,RAD1,RAD2,RAD3;
  output WDO0, WDO1, RDO0, RDO1;

  parameter [63:0] initval = 64'h00000000;
  parameter GSR = "ENABLED";

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  integer i;
  reg memchg;
  reg wre_reg;
  reg [1:0] din_reg;
  reg [3:0] wadr_reg;
  reg [3:0] wadr_reg1;
  reg [3:0] radr_reg;
  reg [1:0] MEM [15:0];
  reg SRN;
  reg [1:0] WDOb, RDOb;
  reg [63:0] init_value;
  wire SR;

  buf  (WAD0b, WAD0);
  buf  (WAD1b, WAD1);
  buf  (WAD2b, WAD2);
  buf  (WAD3b, WAD3);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (WCKb, WCK);
  buf  (WREb, WRE);
  buf  (WPEb, WPE);
  buf  (RAD0b, RAD0);
  buf  (RAD1b, RAD1);
  buf  (RAD2b, RAD2);
  buf  (RAD3b, RAD3);

  buf  (WDO0, WDOb[0]);
  buf  (WDO1, WDOb[1]);
  buf  (RDO0, RDOb[0]);
  buf  (RDO1, RDOb[1]);

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
  always @ (posedge WCKb) begin
    if (SRN == 1) begin
       wre_reg = WREb && WPEb;
       din_reg = {DI1b, DI0b};
       wadr_reg = {WAD3b, WAD2b, WAD1b, WAD0b};
    end
  end

  always @ (SRN) begin
    if (SRN == 0) begin
       wadr_reg = 4'b0;
       wre_reg = 1'b0;
    end
  end //end of always loop

  always @ (RAD3b or RAD2b or RAD1b or RAD0b) begin
     radr_reg = {RAD3b, RAD2b, RAD1b, RAD0b};
  end

  always @ (WAD3b or WAD2b or WAD1b or WAD0b) begin
     wadr_reg1 = {WAD3b, WAD2b, WAD1b, WAD0b};
  end

 always @ (negedge WCKb) begin
     if (wre_reg === 1'b1) begin
          MEM[wadr_reg] = din_reg;
          memchg = ~memchg;
     end
   end

    always @ (radr_reg[3] or radr_reg[2] or radr_reg[1] or
    radr_reg[0] or memchg)
    begin
        RDOb = MEM[radr_reg];
    end

    always @ (wadr_reg1[3] or wadr_reg1[2] or wadr_reg1[1] or
    wadr_reg1[0] or memchg)
    begin
        WDOb = MEM[wadr_reg1];
    end

endmodule

`endcelldefine

