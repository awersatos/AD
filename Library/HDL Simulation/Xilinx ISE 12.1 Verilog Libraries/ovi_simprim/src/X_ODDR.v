// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/virtex4/X_ODDR.v,v 1.13 2009/08/22 00:02:08 harikr Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Dual Data Rate Output D Flip-Flop
// /___/   /\     Filename : X_ODDR.v
// \   \  /  \    Timestamp : Thu Mar 11 16:44:07 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Added LOC parameter, removed GSR ports and initialized outpus.
//    05/29/07 - Added wire declaration for internal signals
//    04/17/08 - CR 468871 Negative SetupHold fix
//    05/12/08 - CR 455447 add XON MSGON property to support async reg
//    12/03/08 - CR 498674 added pulldown on R/S.
//    07/28/09 - CR 527698 According to holistic, CE has to be high for both rise/fall CLK
//             - If CE is low on the rising edge, it has an effect of no change in the falling CLK.
// End Revision

`timescale 1 ps / 1 ps

module X_ODDR (Q, C, CE, D1, D2, R, S);
    
    output Q;
    
    input C;
    input CE;
    input D1;
    input D2;    
    input R;
    input S;

    parameter DDR_CLK_EDGE = "OPPOSITE_EDGE";    
    parameter INIT = 1'b0;
    parameter SRTYPE = "SYNC";
    parameter LOC = "UNPLACED";

    parameter MSGON = "TRUE";
    parameter XON = "TRUE";

    pulldown P1 (R);
    pulldown P2 (S);

    reg q_out = INIT, qd2_posedge_int;    
    reg notifier;
    wire notifierx;
    tri0 GSR = glbl.GSR;
    
    wire c_in;
    wire ce_in;
    wire d1_in;
    wire d2_in;
    wire gsr_in;
    wire r_in;
    wire s_in;

//    buf buf_c (c_in, C);
//    buf buf_ce (ce_in, CE);
//    buf buf_d1 (d1_in, D1);
//    buf buf_d2 (d2_in, D2);    
    buf buf_gsr (gsr_in, GSR);
    buf buf_q (Q, q_out);
//    buf buf_r (r_in, R);
//    buf buf_s (s_in, S);    
   
    wire nr, ns, ngsr;
    wire ce_c_enable, d_c_enable, r_c_enable, s_c_enable; 
    wire ce_c_enable1, d_c_enable1, r_c_enable1, s_c_enable1;

    not (nr, R);
    not (ns, S);
    not (ngsr, GSR);

    and (ce_c_enable, ngsr, nr, ns);
    and (d_c_enable, ngsr, nr, ns, CE);
    and (s_c_enable, ngsr, nr);

    assign notifierx = (XON == "FALSE") ?  1'bx : notifier;

    assign ce_c_enable1 = (MSGON =="FALSE") ? 1'b0 : ce_c_enable;
    assign d_c_enable1 = (MSGON =="FALSE") ? 1'b0 : d_c_enable;
    assign r_c_enable1 = (MSGON =="FALSE") ? 1'b0 : ngsr;
    assign s_c_enable1 = (MSGON =="FALSE") ? 1'b0 : s_c_enable;


    initial begin

	if ((INIT != 0) && (INIT != 1)) begin
	    $display("Attribute Syntax Error : The attribute INIT on X_ODDR instance %m is set to %d.  Legal values for this attribute are 0 or 1.", INIT);
	    $finish;
	end
	
    	if ((DDR_CLK_EDGE != "OPPOSITE_EDGE") && (DDR_CLK_EDGE != "SAME_EDGE")) begin
	    $display("Attribute Syntax Error : The attribute DDR_CLK_EDGE on X_ODDR instance %m is set to %s.  Legal values for this attribute are OPPOSITE_EDGE or SAME_EDGE.", DDR_CLK_EDGE);
	    $finish;
	end
	
	if ((SRTYPE != "ASYNC") && (SRTYPE != "SYNC")) begin
	    $display("Attribute Syntax Error : The attribute SRTYPE on X_ODDR instance %m is set to %s.  Legal values for this attribute are ASYNC or SYNC.", SRTYPE);
	    $finish;
	end

    end // initial begin
    

    always @(gsr_in or r_in or s_in) begin
	if (gsr_in == 1'b1) begin
	    assign q_out = INIT;
	    assign qd2_posedge_int = INIT;
	end
	else if (gsr_in == 1'b0) begin
	    if (r_in == 1'b1 && SRTYPE == "ASYNC") begin
		assign q_out = 1'b0;
		assign qd2_posedge_int = 1'b0;
	    end
	    else if (r_in == 1'b0 && s_in == 1'b1 && SRTYPE == "ASYNC") begin
		assign q_out = 1'b1;
		assign qd2_posedge_int = 1'b1;
	    end
	    else if ((r_in == 1'b1 || s_in == 1'b1) && SRTYPE == "SYNC") begin
		deassign q_out;
		deassign qd2_posedge_int;
	    end	    
	    else if (r_in == 1'b0 && s_in == 1'b0) begin
		deassign q_out;
		deassign qd2_posedge_int;
	    end
	end // if (gsr_in == 1'b0)
    end // always @ (gsr_in or r_in or s_in)

	    
    always @(posedge c_in) begin
 	if (r_in == 1'b1) begin
	    q_out <= 1'b0;
	    qd2_posedge_int <= 1'b0;
	end
	else if (r_in == 1'b0 && s_in == 1'b1) begin
	    q_out <= 1'b1;
	    qd2_posedge_int <= 1'b1;
	end
	else if (ce_in == 1'b1 && r_in == 1'b0 && s_in == 1'b0) begin
	    q_out <= d1_in;
	    qd2_posedge_int <= d2_in;
	end
// CR 527698 
	else if (ce_in == 1'b0 && r_in == 1'b0 && s_in == 1'b0) begin
	    qd2_posedge_int <= q_out;
	end
    end // always @ (posedge c_in)
    
	
    always @(negedge c_in) begin
	if (r_in == 1'b1)
	    q_out <= 1'b0;
	else if (r_in == 1'b0 && s_in == 1'b1)
	    q_out <= 1'b1;
	else if (ce_in == 1'b1 && r_in == 1'b0 && s_in == 1'b0) begin
	    if (DDR_CLK_EDGE == "SAME_EDGE")
		q_out <= qd2_posedge_int;
	    else if (DDR_CLK_EDGE == "OPPOSITE_EDGE")
		q_out <= d2_in;
	end
    end // always @ (negedge c_in)
    
    
//*** Timing Checks Start here

    always @(notifierx) begin
	q_out <= 1'bx;
    end
        
    specify

	(C => Q) = (100:100:100, 100:100:100);
	(R => Q) = (0:0:0, 0:0:0);
	(S => Q) = (0:0:0, 0:0:0);
	
	$setuphold (posedge C, posedge CE &&& (ce_c_enable1!=0), 0:0:0, 0:0:0, notifier, , , c_in, ce_in);
	$setuphold (posedge C, negedge CE &&& (ce_c_enable1!=0), 0:0:0, 0:0:0, notifier, , , c_in, ce_in);
	$setuphold (negedge C, posedge CE &&& (ce_c_enable1!=0), 0:0:0, 0:0:0, notifier, , , c_in, ce_in);
	$setuphold (negedge C, negedge CE &&& (ce_c_enable1!=0), 0:0:0, 0:0:0, notifier, , , c_in, ce_in);
	$setuphold (posedge C, posedge D1 &&& (d_c_enable1!=0),  0:0:0, 0:0:0, notifier, , , c_in, d1_in);
	$setuphold (posedge C, negedge D1 &&& (d_c_enable1!=0),  0:0:0, 0:0:0, notifier, , , c_in, d1_in);
	$setuphold (posedge C, posedge D2 &&& (d_c_enable1!=0),  0:0:0, 0:0:0, notifier, , , c_in, d2_in);
	$setuphold (posedge C, negedge D2 &&& (d_c_enable1!=0),  0:0:0, 0:0:0, notifier, , , c_in, d2_in);
	$setuphold (negedge C, posedge D2 &&& (d_c_enable1!=0),  0:0:0, 0:0:0, notifier, , , c_in, d2_in);
	$setuphold (negedge C, negedge D2 &&& (d_c_enable1!=0),  0:0:0, 0:0:0, notifier, , , c_in, d2_in);
	$setuphold (posedge C, posedge R  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, r_in);
	$setuphold (posedge C, negedge R  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, r_in);
	$setuphold (negedge C, posedge R  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, r_in);
	$setuphold (negedge C, negedge R  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, r_in);
	$setuphold (posedge C, posedge S  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, s_in);
	$setuphold (posedge C, negedge S  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, s_in);
	$setuphold (negedge C, posedge S  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, s_in);
	$setuphold (negedge C, negedge S  &&& (r_c_enable1!=0),  0:0:0, 0:0:0,  notifier, , , c_in, s_in);
	
	$recrem (negedge R, posedge C, 0:0:0, 0:0:0, notifier);
	$recrem (posedge R, posedge C, 0:0:0, 0:0:0, notifier);
	$recrem (negedge R, negedge C, 0:0:0, 0:0:0, notifier);
	$recrem (posedge R, negedge C, 0:0:0, 0:0:0, notifier);
	$recrem (negedge S, posedge C, 0:0:0, 0:0:0, notifier);
	$recrem (posedge S, posedge C, 0:0:0, 0:0:0, notifier);
	$recrem (negedge S, negedge C, 0:0:0, 0:0:0, notifier);
	$recrem (posedge S, negedge C, 0:0:0, 0:0:0, notifier);
	
	$period (posedge C, 0:0:0, notifier);
        $width (posedge C, 0:0:0, 0, notifier);
        $width (negedge C, 0:0:0, 0, notifier);
	$width (posedge R, 0:0:0, 0, notifier);
	$width (posedge S, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;
	
    endspecify

endmodule // X_ODDR
