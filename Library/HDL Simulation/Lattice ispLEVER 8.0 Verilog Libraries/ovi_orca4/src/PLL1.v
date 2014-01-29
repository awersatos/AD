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
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/PLL1.v,v 1.3 2005/05/19 19:02:10 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module PLL1 (CLKIN, CLKOUT, LOCK);

input  CLKIN;
output CLKOUT, LOCK;
reg  CLKOUTB, LOCKB;

   buf (CLKINB, CLKIN);
   buf (CLKOUT, CLKOUTB);
   buf (LOCK, LOCKB);

   always @ (CLKINB) begin
      if (CLKINB === 1'b1)
        begin
          CLKOUTB = CLKINB;
          LOCKB = 1;
        end
      else
        begin
          CLKOUTB = CLKINB;
        end
   end //end of the always loop


endmodule

`endcelldefine

