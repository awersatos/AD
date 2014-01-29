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
// Simulation Library File for XP2
//
// $Header:  
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module STFA (STOREN, UFMFAIL, UFMBUSYN);
  input STOREN;
  output UFMFAIL, UFMBUSYN;

  supply0 GND;
  buf (UFMFAIL, GND);
//  buf (UFMBUSYN, GND);

  buf (STOREN_buf, STOREN);

  reg UFMBUSYN_r = 1;
  realtime t_neg_to_pos = 0, neg_edge = 0, pos_edge = 0;
  reg active_store = 0;

  always @(STOREN_buf)
  begin
    if (STOREN_buf == 0)
    begin
       neg_edge = $realtime;
       active_store = 1;
    end
    else if (STOREN_buf == 1 && active_store == 1)
    begin
       pos_edge = $realtime;
       t_neg_to_pos = pos_edge - neg_edge;
       active_store = 0;
       if (t_neg_to_pos > 0 && t_neg_to_pos < 1000)
          $display ("WARNING: Pulse width of STOREN is less than 1 us, which is illegal!");
    end
  end

  always @(negedge STOREN_buf)
    if (STOREN_buf == 0)
    begin
      #1500 UFMBUSYN_r = 0;
      #2000 UFMBUSYN_r = 1;
    end

  buf (UFMBUSYN, UFMBUSYN_r);

endmodule 

`endcelldefine
