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
// Simulation Library File for ECP2
//
// $Header: 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module CLKDIVB (CLKI, RST, RELEASE, CDIV1, CDIV2, CDIV4, CDIV8);
   input CLKI, RST, RELEASE;
   output CDIV1, CDIV2, CDIV4, CDIV8;
   parameter GSR = "DISABLED";

  reg cdiv_sig0, cdiv_sig1, SRN, cdiv_sig5;
  wire cdiv_sig2, cdiv_sig3, cdiv_sig4, SR;
  reg [2:0] count_dn;
  reg CLKI_buf;

  buf inst_buf0 (CDIV1, cdiv_sig4);
  buf inst_buf1 (CDIV2, count_dn[0]);
  buf inst_buf2 (CDIV4, count_dn[1]);
  buf inst_buf3 (CDIV8, count_dn[2]);

  initial 
  begin
     count_dn = 3'b000;
  end

  tri1 GSR_sig = GSR_INST.GSRNET;
  tri1 PUR_sig = PUR_INST.PURNET;

  always @ (GSR_sig or PUR_sig ) begin
    if (GSR == "ENABLED") begin
      SRN = GSR_sig & PUR_sig ;
    end
    else if (GSR == "DISABLED")
      SRN = PUR_sig;
  end

  not (SR1, SRN);
  or INST1 (SR, RST, SR1);

  always @ (posedge CLKI)
  begin
     cdiv_sig0 <= SR;
  end

  always @ (CLKI)
  begin
     CLKI_buf <= CLKI;
  end

  not INST0 (cdiv_sig2, cdiv_sig0);
  assign cdiv_sig3 = (cdiv_sig2 == 1'b1) ? CLKI_buf : 1'b0;

  always @ (posedge CLKI)
  begin
     cdiv_sig1 <= ~cdiv_sig0;
  end

  assign cdiv_sig4 = cdiv_sig3 & cdiv_sig1;

  always @ (posedge CLKI or posedge SR)
  begin
     if (SR == 1'b1)
        cdiv_sig5 <= 1'b0;
     else
        cdiv_sig5 <= 1'b1;
  end

  always @ (posedge CLKI or negedge cdiv_sig5 or negedge RELEASE)
  begin
     if (cdiv_sig5 == 1'b0 || RELEASE ==1'b0)
        count_dn <= 3'b000;
     else
     begin
        if (RELEASE == 1'b1)
           count_dn <= count_dn - 1;
     end
  end


endmodule

`endcelldefine

