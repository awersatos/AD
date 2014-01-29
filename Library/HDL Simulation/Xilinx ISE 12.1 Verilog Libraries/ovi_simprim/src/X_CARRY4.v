// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/rainier/X_CARRY4.v,v 1.10 2007/06/04 18:17:37 yanx Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 10.1i (K.17)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Fast Carry Logic with Look Ahead 
// /___/   /\     Filename : X_CARRY4.v
// \   \  /  \    Timestamp : Thu Mar 25 16:42:55 PST 2004
//  \___\/\___\
//
// Revision:
//    04/11/05 - Initial version.
//    05/06/05 - Unused CYINT or CI pin need grounded instead of open (CR207752)
//    05/31/05 - Change pin order, remove connection check for CYINIT and CI.
//    12/21/05 - Add timing path.
//    04/13/06 - Add full timing path for DI to O (CR228786)
//    06/04/07 - Add wire definition.
// End Revision

`timescale  1 ps / 1 ps


module X_CARRY4 (CO, O, CI, CYINIT, DI, S);

    parameter LOC = "UNPLACED";

    output [3:0] CO;
    output [3:0] O;
    input        CI;
    input        CYINIT;
    input  [3:0] DI;
    input  [3:0] S;

    wire [3:0] di_in, s_in, o_out, co_out;
    wire ci_or_cyinit;
    wire ci_in, cyinit_in;


    buf b_ci (ci_in, CI);
    buf b_cyinit (cyinit_in, CYINIT);
    buf b_di0 (di_in[0], DI[0]);
    buf b_di1 (di_in[1], DI[1]);
    buf b_di2 (di_in[2], DI[2]);
    buf b_di3 (di_in[3], DI[3]);
    buf b_s0 (s_in[0], S[0]);
    buf b_s1 (s_in[1], S[1]);
    buf b_s2 (s_in[2], S[2]);
    buf b_s3 (s_in[3], S[3]);
    buf b_o0 (O[0], o_out[0]);
    buf b_o1 (O[1], o_out[1]);
    buf b_o2 (O[2], o_out[2]);
    buf b_o3 (O[3], o_out[3]);
    buf b_co0 (CO[0], co_out[0]);
    buf b_co1 (CO[1], co_out[1]);
    buf b_co2 (CO[2], co_out[2]);
    buf b_co3 (CO[3], co_out[3]);

    assign o_out = s_in ^ {co_out[2:0], ci_or_cyinit};
    assign co_out[0] = s_in[0] ? ci_or_cyinit : di_in[0];
    assign co_out[1] = s_in[1] ? co_out[0] : di_in[1];
    assign co_out[2] = s_in[2] ? co_out[1] : di_in[2];
    assign co_out[3] = s_in[3] ? co_out[2] : di_in[3];
    assign  ci_or_cyinit = ci_in | cyinit_in;


  specify

        (CI => O[0]) = (0:0:0, 0:0:0);
        (CI => O[1]) = (0:0:0, 0:0:0);
        (CI => O[2]) = (0:0:0, 0:0:0);
        (CI => O[3]) = (0:0:0, 0:0:0);
        (CI => CO[0]) = (0:0:0, 0:0:0);
        (CI => CO[1]) = (0:0:0, 0:0:0);
        (CI => CO[2]) = (0:0:0, 0:0:0);
        (CI => CO[3]) = (0:0:0, 0:0:0);
        (CYINIT => O[0]) = (0:0:0, 0:0:0);
        (CYINIT => O[1]) = (0:0:0, 0:0:0);
        (CYINIT => O[2]) = (0:0:0, 0:0:0);
        (CYINIT => O[3]) = (0:0:0, 0:0:0);
        (CYINIT => CO[0]) = (0:0:0, 0:0:0);
        (CYINIT => CO[1]) = (0:0:0, 0:0:0);
        (CYINIT => CO[2]) = (0:0:0, 0:0:0);
        (CYINIT => CO[3]) = (0:0:0, 0:0:0);
        (S[0] => O[0]) = (0:0:0, 0:0:0);
        (S[0] => O[1]) = (0:0:0, 0:0:0);
        (S[0] => O[2]) = (0:0:0, 0:0:0);
        (S[0] => O[3]) = (0:0:0, 0:0:0);

        (S[1] => O[0]) = (0:0:0, 0:0:0);
        (S[1] => O[1]) = (0:0:0, 0:0:0);
        (S[1] => O[2]) = (0:0:0, 0:0:0);
        (S[1] => O[3]) = (0:0:0, 0:0:0);

        (S[2] => O[0]) = (0:0:0, 0:0:0);
        (S[2] => O[1]) = (0:0:0, 0:0:0);
        (S[2] => O[2]) = (0:0:0, 0:0:0);
        (S[2] => O[3]) = (0:0:0, 0:0:0);

        (S[3] => O[0]) = (0:0:0, 0:0:0);
        (S[3] => O[1]) = (0:0:0, 0:0:0);
        (S[3] => O[2]) = (0:0:0, 0:0:0);
        (S[3] => O[3]) = (0:0:0, 0:0:0);

        (S[0] => CO[0]) = (0:0:0, 0:0:0);
        (S[0] => CO[1]) = (0:0:0, 0:0:0);
        (S[0] => CO[2]) = (0:0:0, 0:0:0);
        (S[0] => CO[3]) = (0:0:0, 0:0:0);

        (S[1] => CO[0]) = (0:0:0, 0:0:0);
        (S[1] => CO[1]) = (0:0:0, 0:0:0);
        (S[1] => CO[2]) = (0:0:0, 0:0:0);
        (S[1] => CO[3]) = (0:0:0, 0:0:0);

        (S[2] => CO[0]) = (0:0:0, 0:0:0);
        (S[2] => CO[1]) = (0:0:0, 0:0:0);
        (S[2] => CO[2]) = (0:0:0, 0:0:0);
        (S[2] => CO[3]) = (0:0:0, 0:0:0);

        (S[3] => CO[0]) = (0:0:0, 0:0:0);
        (S[3] => CO[1]) = (0:0:0, 0:0:0);
        (S[3] => CO[2]) = (0:0:0, 0:0:0);
        (S[3] => CO[3]) = (0:0:0, 0:0:0);

        (DI[0] => CO[0]) = (0:0:0, 0:0:0);
        (DI[0] => CO[1]) = (0:0:0, 0:0:0);
        (DI[0] => CO[2]) = (0:0:0, 0:0:0);
        (DI[0] => CO[3]) = (0:0:0, 0:0:0);

        (DI[1] => CO[0]) = (0:0:0, 0:0:0);
        (DI[1] => CO[1]) = (0:0:0, 0:0:0);
        (DI[1] => CO[2]) = (0:0:0, 0:0:0);
        (DI[1] => CO[3]) = (0:0:0, 0:0:0);

        (DI[2] => CO[0]) = (0:0:0, 0:0:0);
        (DI[2] => CO[1]) = (0:0:0, 0:0:0);
        (DI[2] => CO[2]) = (0:0:0, 0:0:0);
        (DI[2] => CO[3]) = (0:0:0, 0:0:0);

        (DI[3] => CO[0]) = (0:0:0, 0:0:0);
        (DI[3] => CO[1]) = (0:0:0, 0:0:0);
        (DI[3] => CO[2]) = (0:0:0, 0:0:0);
        (DI[3] => CO[3]) = (0:0:0, 0:0:0);

        (DI[0] => O[0]) = (0:0:0, 0:0:0);
        (DI[0] => O[1]) = (0:0:0, 0:0:0);
        (DI[0] => O[2]) = (0:0:0, 0:0:0);
        (DI[0] => O[3]) = (0:0:0, 0:0:0);

        (DI[1] => O[0]) = (0:0:0, 0:0:0);
        (DI[1] => O[1]) = (0:0:0, 0:0:0);
        (DI[1] => O[2]) = (0:0:0, 0:0:0);
        (DI[1] => O[3]) = (0:0:0, 0:0:0);

        (DI[2] => O[0]) = (0:0:0, 0:0:0);
        (DI[2] => O[1]) = (0:0:0, 0:0:0);
        (DI[2] => O[2]) = (0:0:0, 0:0:0);
        (DI[2] => O[3]) = (0:0:0, 0:0:0);

        (DI[3] => O[0]) = (0:0:0, 0:0:0);
        (DI[3] => O[1]) = (0:0:0, 0:0:0);
        (DI[3] => O[2]) = (0:0:0, 0:0:0);
        (DI[3] => O[3]) = (0:0:0, 0:0:0);
        specparam PATHPULSE$ = 0;

  endspecify



endmodule

