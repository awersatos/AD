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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5mg/RCS/EPLLB.v,v 1.5 2005/05/19 20:08:33 pradeep Exp $ 
//
`celldefine 
`timescale 1 ns / 10 fs

module EPLLB (CLKI, RST, CLKFB, CLKOP, LOCK);

parameter   FIN    = "100.0";
parameter   CLKI_DIV        = "1";
parameter   CLKOP_DIV       = "8";
parameter   CLKFB_DIV       = "1";
parameter   FDEL    = "0";
parameter   WAKE_ON_LOCK = "OFF";
parameter   LOCK_CYC   = 2;
parameter   FB_MODE   = "CLOCKTREE";


input  CLKI, RST, CLKFB;
output CLKOP, LOCK;

EHXPLLB EHXPLLB_u1 (
   .RST ( RST ),
   .CLKI ( CLKI ),
   .CLKFB ( CLKFB ),
   .DDAMODE ( 1'b0),
   .DDAIZR ( 1'b0), 
   .DDAILAG ( 1'b0), 
   .DDAIDEL0 (1'b0 ),
   .DDAIDEL1 ( 1'b0),
   .DDAIDEL2 (1'b0 ), 
   .CLKOP ( CLKOP ),
   .CLKOK( ), 
   .CLKOS ( ), 
   .LOCK ( LOCK ),
   .DDAOZR ( ),
   .DDAOLAG ( ),
   .DDAODEL0 ( ),
   .DDAODEL1 ( ), 
   .DDAODEL2 ( )
);

defparam EHXPLLB_u1.FIN = FIN;
defparam EHXPLLB_u1.CLKFB_DIV = CLKFB_DIV; 
defparam EHXPLLB_u1.CLKI_DIV = CLKI_DIV;
defparam EHXPLLB_u1.CLKOP_DIV = CLKOP_DIV;
defparam EHXPLLB_u1.CLKOK_DIV = "2";
defparam EHXPLLB_u1.DELAY_CNTL = "STATIC";
defparam EHXPLLB_u1.FDEL = FDEL;
defparam EHXPLLB_u1.WAKE_ON_LOCK = WAKE_ON_LOCK;
defparam EHXPLLB_u1.PHASEADJ = "0";
defparam EHXPLLB_u1.DUTY = "4";
defparam EHXPLLB_u1.LOCK_CYC   = LOCK_CYC;   
defparam EHXPLLB_u1.FB_MODE   = FB_MODE;   

endmodule

`endcelldefine 
