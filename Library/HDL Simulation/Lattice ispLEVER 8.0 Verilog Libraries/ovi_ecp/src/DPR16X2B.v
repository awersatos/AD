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
// Simulation Library File for EC/XP
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/DPR16X2B.v,v 1.3 2005/05/19 20:08:32 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DPR16X2B ( DI0, DI1, WAD0, WAD1, WAD2, WAD3, WRE, WCK,
                 RAD0, RAD1, RAD2, RAD3, WDO0, WDO1, RDO0, RDO1);
 
  input WAD0,WAD1,WAD2,WAD3,DI0, DI1, WCK, WRE;
  input RAD0,RAD1,RAD2,RAD3;
  output WDO0, WDO1, RDO0, RDO1;


  integer i,j;
  reg wre_reg;
  reg [1:0] din_reg;
  reg [3:0] wadr_reg;
  reg [3:0] wadr_reg1;
  reg [3:0] radr_reg;
  reg [31:0] MEM;
  reg [1:0] WDOb, RDOb;

  buf  (WAD0b, WAD0);
  buf  (WAD1b, WAD1);
  buf  (WAD2b, WAD2);
  buf  (WAD3b, WAD3);
  buf  (DI0b, DI0);
  buf  (DI1b, DI1);
  buf  (WCKb, WCK);
  buf  (WREb, WRE);
  buf  (RAD0b, RAD0);
  buf  (RAD1b, RAD1);
  buf  (RAD2b, RAD2);
  buf  (RAD3b, RAD3);

  buf  (WDO0, WDOb[0]);
  buf  (WDO1, WDOb[1]);
  buf  (RDO0, RDOb[0]);
  buf  (RDO1, RDOb[1]);

   // Latch the address and data in for writing
   // Registers are rising edge enabled
  always @ (posedge WCKb) begin
       wre_reg <= WREb;
       din_reg <= {DI1b, DI0b};
       wadr_reg <= {WAD3b, WAD2b, WAD1b, WAD0b};
  end


  always @ (RAD3b or RAD2b or RAD1b or RAD0b) begin
     radr_reg = {RAD3b, RAD2b, RAD1b, RAD0b};
  end

  always @ (WAD3b or WAD2b or WAD1b or WAD0b) begin
     wadr_reg1 = {WAD3b, WAD2b, WAD1b, WAD0b};
  end

   always @ (din_reg,wadr_reg,wre_reg) begin
     if (wre_reg === 1'b1) begin
         for (i = 0; i < 2; i = i + 1)
          begin
           MEM[2*wadr_reg+i] = din_reg[i];
          end
     end
   end

    always @ (radr_reg or MEM)
    begin
       for (i = 0; i < 2; i = i + 1)
        RDOb[i] = MEM[2*radr_reg+i];
    end

    always @ (wadr_reg1 or MEM)
    begin
      for (j = 0; j < 2; j = j + 1)
        WDOb[j] = MEM[2*wadr_reg1+j];
    end

endmodule

`endcelldefine

