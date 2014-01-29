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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca5/RCS/DELAY.v,v 1.6 2005/05/19 19:06:22 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps
`celldefine
module DELAY (A, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6, DCNTL7, DCNTL8, Z);
  input A, DCNTL0, DCNTL1, DCNTL2, DCNTL3, DCNTL4, DCNTL5, DCNTL6, DCNTL7, DCNTL8;
  output Z;
  
parameter DELAYTYPE="CFGBIT", COARSE="CDEL0", FINE="FDEL0";

wire [8:0] cntl_reg;
integer cntl_reg_int;
realtime delta, cntl_delay, c_delay, f_delay;

wire Ab;
reg Zb;

initial 
begin
   delta = 0.02;
   cntl_reg_int = 0;
   cntl_delay = 0;
end

initial
begin
   case (COARSE)
     "CDEL0" :  c_delay = 0.0 ;
     "CDEL1" :  c_delay = 0.672 ;
     "CDEL2" :  c_delay = (2 * 0.672);
     "CDEL3" :  c_delay = (3 * 0.672);
     default c_delay = 0.0;
   endcase
end

initial
begin
   case (FINE)
     "FDEL0" :  f_delay = 0.0 ;
     "FDEL1" :  f_delay = 0.021 ;
     "FDEL2" :  f_delay = (2 * 0.021);
     "FDEL3" :  f_delay = (3 * 0.021);
     "FDEL4" :  f_delay = (4 * 0.021);
     "FDEL5" :  f_delay = (5 * 0.021);
     "FDEL6" :  f_delay = (6 * 0.021);
     "FDEL7" :  f_delay = (7 * 0.021);
     "FDEL8" :  f_delay = (8 * 0.021);
     "FDEL9" :  f_delay = (9 * 0.021);
     "FDEL10" :  f_delay = (10 * 0.021);
     "FDEL11" :  f_delay = (11 * 0.021);
     "FDEL12" :  f_delay = (12 * 0.021);
     "FDEL13" :  f_delay = (13 * 0.021);
     "FDEL14" :  f_delay = (14 * 0.021);
     "FDEL15" :  f_delay = (15 * 0.021);
     "FDEL16" :  f_delay = (16 * 0.021);
     "FDEL17" :  f_delay = (17 * 0.021);
     "FDEL18" :  f_delay = (18 * 0.021);
     "FDEL19" :  f_delay = (19 * 0.021);
     "FDEL20" :  f_delay = (20 * 0.021);
     "FDEL21" :  f_delay = (21 * 0.021);
     "FDEL22" :  f_delay = (22 * 0.021);
     "FDEL23" :  f_delay = (23 * 0.021);
     "FDEL24" :  f_delay = (24 * 0.021);
     "FDEL25" :  f_delay = (25 * 0.021);
     "FDEL26" :  f_delay = (26 * 0.021);
     "FDEL27" :  f_delay = (27 * 0.021);
     "FDEL28" :  f_delay = (28 * 0.021);
     "FDEL29" :  f_delay = (29 * 0.021);
     "FDEL30" :  f_delay = (30 * 0.021);
     "FDEL31" :  f_delay = (31 * 0.021);
     "FDEL32" :  f_delay = (32 * 0.021);
     "FDEL33" :  f_delay = (33 * 0.021);
     "FDEL34" :  f_delay = (34 * 0.021);
     "FDEL35" :  f_delay = (35 * 0.021);
     "FDEL36" :  f_delay = (36 * 0.021);
     "FDEL37" :  f_delay = (37 * 0.021);
     "FDEL38" :  f_delay = (38 * 0.021);
     "FDEL39" :  f_delay = (39 * 0.021);
     "FDEL40" :  f_delay = (40 * 0.021);
     "FDEL41" :  f_delay = (41 * 0.021);
     "FDEL42" :  f_delay = (42 * 0.021);
     "FDEL43" :  f_delay = (43 * 0.021);
     "FDEL44" :  f_delay = (44 * 0.021);
     "FDEL45" :  f_delay = (45 * 0.021);
     "FDEL46" :  f_delay = (46 * 0.021);
     "FDEL47" :  f_delay = (47 * 0.021);
     default f_delay = 0.0;
   endcase
end

  buf U4 (cntl_reg[0], DCNTL0);
  buf U5 (cntl_reg[1], DCNTL1);
  buf U6 (cntl_reg[2], DCNTL2);
  buf U7 (cntl_reg[3], DCNTL3);
  buf U8 (cntl_reg[4], DCNTL4);
  buf U9 (cntl_reg[5], DCNTL5);
  buf U10 (cntl_reg[6], DCNTL6);
  buf U11 (cntl_reg[7], DCNTL7);
  buf U12 (cntl_reg[8], DCNTL8);

  always @(cntl_reg)
  begin
//     if (DELAYTYPE == "DLL")
        cntl_reg_int = cntl_reg;
  end

  always @(cntl_reg_int)
  begin
        cntl_delay = cntl_reg_int * delta;
  end

  buf (Ab, A);

  always @(Ab)
  begin
     if (DELAYTYPE == "DLL")
        Zb <= #cntl_delay Ab;
     else
        Zb <= #(c_delay + f_delay) Ab;
  end

  buf (Z, Zb);

endmodule
`endcelldefine
