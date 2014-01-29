// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2007 by Lattice Semiconductor Corporation
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

`celldefine
`timescale  1 ns / 1 ps

module ECLKSYNCA (ECLKI, STOP, ECLKO);

input  ECLKI, STOP;
output ECLKO;

reg eclk1, eclk2;
wire ECLKIb, STOPb, ECLKOb;

    buf (ECLKIb, ECLKI);
    buf (STOPb, STOP);
    buf (ECLKO, ECLKOb);

initial
begin
eclk1 = 0;
eclk2 = 0;
end

    always @(negedge ECLKIb)
    begin
       if (STOPb == 1'b1)
          eclk1 <= 1'b0;
       else
          eclk1 <= 1'b1;
    end

    always @(negedge ECLKIb)
    begin
       if (STOPb == 1'b1)
          eclk2 <= 1'b0;
       else
          eclk2 <= eclk1;
    end

    assign ECLKOb = ECLKIb & eclk2;

endmodule

`endcelldefine

