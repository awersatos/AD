// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/blanc/X_AUTOBUF.v,v 1.3 2009/08/22 00:02:06 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.3i (L.53)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Clock Buffer
// /___/   /\     Filename : X_AUTOBUF.v
// \   \  /  \    Timestamp : 
//  \___\/\___\
//
// Revision:
//    05/08/09 - Initial version.
//    07/23/09 - Add more attrute values (CR521811)
// End Revision

`timescale  1 ps / 1 ps


module X_AUTOBUF (O, I);

    parameter BUFFER_TYPE = "AUTO";
    parameter LOC = "UNPLACED";

    output O;

    input  I;

    initial begin
    case (BUFFER_TYPE)
      "AUTO" : ;
      "BUF" : ;
      "BUFG" : ;
      "BUFGP" : ;
      "BUFH" : ;
      "BUFIO" : ;
      "BUFIO2" : ;
      "BUFIO2FB" : ;
      "BUFR" : ;
      "IBUF" : ;
      "IBUFG" : ;
      "NONE" : ;
      "OBUF" : ;
      default : begin
        $display("Attribute Syntax Error : The Attribute BUFFER_TYPE on AUTOBUF instance %m is set to %s.  Legal values for this attribute are AUTO, BUF, BUFG, BUFGP, BUFH, BUFIO, BUFIO2, BUFIO2FB, BUFR, IBUF, IBUFG, NONE, and OBUF.", BUFFER_TYPE);
      end
    endcase
    end

	buf B1 (O, I);

  specify

      (I => O) = (0:0:0, 0:0:0);

  endspecify   

endmodule

