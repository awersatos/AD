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

module CLKDIVB (CLKI, RST, RELEASE, CDIV1, CDIV2, CDIV4, CDIV8);
   input CLKI, RST, RELEASE;
   output CDIV1, CDIV2, CDIV4, CDIV8;
   parameter GSR = "DISABLED";

  reg cdiv_sig0, cdiv_sig1, SRN;
  wire cdiv_sig2, SR, count_dn0, count_dn1, count_dn2;
  reg [2:0] count_dn;

  buf inst_buf0 (CDIV1, cdiv_sig2);
  buf inst_buf1 (CDIV2, count_dn0);
  buf inst_buf2 (CDIV4, count_dn1);
  buf inst_buf3 (CDIV8, count_dn2);

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

  always @ (posedge CLKI or posedge SR)
  begin
     if (SR == 1'b1)
        cdiv_sig0 <= 1'b0;
     else
        cdiv_sig0 <= 1'b1;
  end

  always @ (negedge CLKI or posedge SR)
  begin
     if (SR == 1'b1)
        cdiv_sig1 <= 1'b0;
     else
        cdiv_sig1 <= cdiv_sig0;
  end

  and (cdiv_sig2, CLKI, cdiv_sig0, cdiv_sig1, ~SR);
  and (count_dn0, count_dn[0], cdiv_sig0, cdiv_sig1, ~SR);
  and (count_dn1, count_dn[1], cdiv_sig0, cdiv_sig1, ~SR);
  and (count_dn2, count_dn[2], cdiv_sig0, cdiv_sig1, ~SR);

  always @ (posedge CLKI or negedge RELEASE)
  begin
     if (cdiv_sig0 == 1'b0 || RELEASE ==1'b0)
        count_dn <= 3'b000;
     else
     begin
        if (RELEASE == 1'b1)
           count_dn <= count_dn - 1;
     end
  end


endmodule

`endcelldefine

