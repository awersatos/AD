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
// Simulation Library File for ECP3
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module DQSBUFE(ECLK, SCLK, ECLKW, RST,
               DYNDELPOL, DYNDELAY6, DYNDELAY5, DYNDELAY4, DYNDELAY3, DYNDELAY2, DYNDELAY1, DYNDELAY0,
               DQCLK0, DQCLK1, DDRCLKPOL, DDRLAT);

   input ECLK, SCLK, ECLKW, RST;
   input DYNDELPOL, DYNDELAY6, DYNDELAY5, DYNDELAY4, DYNDELAY3, DYNDELAY2, DYNDELAY1, DYNDELAY0;
   output DQCLK0, DQCLK1, DDRCLKPOL, DDRLAT;

   parameter DYNDEL_TYPE = "NORMAL";
   parameter DYNDEL_VAL = 0;
   parameter DYNDEL_CNTL = "DYNAMIC";

   reg READB;
   realtime delta, cntl_delay, DCAB_delay;
   integer DYNDELAY_int, DCAB_int;
   wire [6:0] DYNDELAYB, DCAB;
   reg CLKP, ECLKWB_int1, DQSO_int, DQSO_int1, DQSO_int0, DDRLAT_int0, DDRLAT_int1;
   reg ECLKWB_int, DDRCLKPOL_int1, ECLKB_int1;
   reg PRMBDET_int, DDRCLKPOL_int, DDRLAT_int, DQCLK0_int, DQCLK1_int;

   buf (RSTB, RST);
   buf (SCLKB, SCLK);
   buf (ECLKB, ECLK);
   buf (ECLKWB, ECLKW);
   buf (DCAB[6], DCA6);
   buf (DCAB[5], DCA5);
   buf (DCAB[4], DCA4);
   buf (DCAB[3], DCA3);
   buf (DCAB[2], DCA2);
   buf (DCAB[1], DCA1);
   buf (DCAB[0], DCA0);
   buf (DYNDELPOLB, DYNDELPOL);
   buf (DYNDELAYB[6], DYNDELAY6);
   buf (DYNDELAYB[5], DYNDELAY5);
   buf (DYNDELAYB[4], DYNDELAY4);
   buf (DYNDELAYB[3], DYNDELAY3);
   buf (DYNDELAYB[2], DYNDELAY2);
   buf (DYNDELAYB[1], DYNDELAY1);
   buf (DYNDELAYB[0], DYNDELAY0);
   buf inst_buf0 (DDRCLKPOL, DDRCLKPOL_int);
   buf inst_buf3 (DDRLAT, DDRLAT_int);
   buf inst_buf6 (DQCLK0, DQCLK0_int);
   buf inst_buf7 (DQCLK1, DQCLK1_int);

initial
begin
   delta = 0.026;
   READB = 0;
   DYNDELAY_int = 0;
   cntl_delay = 0.0;
   DCAB_delay = 0.0;
   DQCLK1_int = 1'b1;
   DQCLK0_int = 1'b0;
   PRMBDET_int = 1'b0;
   DDRCLKPOL_int = 1'b0;
   DDRLAT_int = 1'b0;
   DDRLAT_int0 = 1'b0;
   DDRLAT_int1 = 1'b0;
   CLKP = 1'b0;
   ECLKWB_int1 = 1'b0;
   DQSO_int = 1'b0;
   DQSO_int1 = 1'b0;
   DQSO_int0 = 1'b0;
end

   nor inst0 (C, READB, A);
   nor inst1 (A, C, D);
   nor inst2 (B, D, E);
   nor inst3 (D, B, READB, PRMBDET_int);
   nor inst4 (E, C, PRMBDET_int);

      function DataSame;
        input a, b;
        begin
          if (a === b)
            DataSame = a;
          else
            DataSame = 1'bx;
        end
      endfunction

  always @(DCAB)
  begin
     DCAB_int = DCAB;
  end

  always @(DCAB_int)
  begin
        DCAB_delay = (DCAB_int * delta) + 0.140;
  end

   always @(negedge D)
   begin
      DDRCLKPOL_int <= SCLKB;
   end

   always @(ECLKB)
   begin
      if (ECLKB === 1'bX)
         PRMBDET_int <= 1'b1;
      else
         PRMBDET_int <= ECLKB;
   end

   always @(SCLKB or DDRCLKPOL_int)
   begin
      if (DDRCLKPOL_int == 1'b0)
         CLKP <= SCLKB;
      else if (DDRCLKPOL_int == 1'b1)
         CLKP <= ~SCLKB;
   end

   always @(ECLKB, DCAB_delay)
   begin
      DQSO_int <= #(DCAB_delay) ECLKB;
   end

   always @(posedge DQSO_int or posedge CLKP)
   begin
      if (CLKP == 1'b1)
         DQSO_int1 <= 1'b0;
      else
         DQSO_int1 <= 1'b1;
   end

   always @(DQSO_int)
   begin
      DQSO_int0 <= DQSO_int;
   end

   or inst5 (DQSO_int3, DQSO_int1, DQSO_int0);
   assign ECLKDQSR_int = DQSO_int3;


   always @(posedge SCLKB or posedge D)
   begin
      if (D == 1'b1)
         DDRLAT_int0 <= 1'b1;
      else
         DDRLAT_int0 <= 1'b0;
   end

   always @(posedge SCLKB)
   begin
      if (DDRLAT_int0 == 1'b1)
         DDRLAT_int1 <= SCLKB;
   end

//   always @(posedge SCLKB)
//   begin
//      DDRLAT_int <= DDRLAT_int1;
//   end

   always @(ECLKWB or DYNDELPOLB)
   begin
      if (DYNDELPOLB == 1'b0)
         ECLKWB_int <= ECLKWB;
      else if (DYNDELPOLB == 1'b1)
         ECLKWB_int <= ~ECLKWB;
   end

  always @(DYNDELAYB)
  begin
     DYNDELAY_int = DYNDELAYB;
  end

  always @(DYNDELAY_int)
  begin
        cntl_delay = (DYNDELAY_int * delta) + 0.140;
  end

  always @(ECLKWB_int)
  begin
     ECLKWB_int1 <= #cntl_delay ECLKWB_int;
  end

  always @(negedge ECLKWB_int1 or posedge RSTB)
  begin
     if (RSTB == 1'b1)
        DQCLK0_int <= 1'b0;
     else
        DQCLK0_int <= ~DQCLK1_int;
  end

  always @(posedge ECLKWB_int1 or posedge RSTB)
  begin
     if (RSTB == 1'b1)
        DQCLK1_int <= 1'b1;
     else
        DQCLK1_int <= ~DQCLK1_int;
  end


endmodule

`endcelldefine


