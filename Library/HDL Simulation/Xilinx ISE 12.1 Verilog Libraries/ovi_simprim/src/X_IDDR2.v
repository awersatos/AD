// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/versclibs/data/spartan4/X_IDDR2.v,v 1.8 2010/01/13 01:49:11 fphillip Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2005 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.13)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Dual Data Rate Input D Flip-Flop
// /___/   /\     Filename : X_IDDR2.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:06 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    04/22/05 - Added LOC parameter, removed GSR ports and initialized outpus.
//    12/07/07 - CR 456124 -- added input port buffers
//    04/30/08 - CR 468871 Negative SetupHold fix
//    08/20/08 - CR 478850 added pulldown on R/S and pullup on CE.
//    04/08/09 - CR 517973 Reworked to matched Holistic tests.
//    01/12/10 - CR 538181 Fixed R/S to take INIT values.
// End Revision

// End Revision

`timescale  1 ps / 1 ps

module X_IDDR2 (Q0, Q1, C0, C1, CE, D, R, S);
    
    output Q0;
    output Q1;
    
    input C0;
    input C1;
    input CE;
    input D;
    tri0 GSR = glbl.GSR;
    input R;
    input S;

    parameter DDR_ALIGNMENT = "NONE";
    parameter INIT_Q0 = 1'b0;
    parameter INIT_Q1 = 1'b0;
    parameter LOC = "UNPLACED";
    parameter SRTYPE = "SYNC";

    pullup   P1 (CE);
    pulldown P2 (R);
    pulldown P3 (S);

    reg q0_out = INIT_Q0;
    reg q1_out = INIT_Q1;
    reg q0_out_int = INIT_Q0;
    reg q1_out_int = INIT_Q1;
    reg q0_c0_out_int = INIT_Q0;
    reg q1_c0_out_int = INIT_Q1;
    reg notifier;
   
    wire c0_in; 
    wire c1_in; 
    wire ce_in; 
    wire d_in; 
    wire r_in; 
    wire s_in; 

    wire PC0, PC1;

    buf buf_c0 (c0_in, C0);
    buf buf_c1 (c1_in, C1);
    buf buf_ce (ce_in, CE);
    buf buf_d (d_in, D);
    buf buf_r (r_in, R);
    buf buf_s (s_in, S);

    buf buf_q0 (Q0, q0_out);
    buf buf_q1 (Q1, q1_out);
    
    initial begin

	if ((INIT_Q0 != 1'b0) && (INIT_Q0 != 1'b1)) begin
	    $display("Attribute Syntax Error : The attribute INIT_Q0 on X_IDDR2 instance %m is set to %d.  Legal values for this attribute are 0 or 1.", INIT_Q0);
	    $finish;
	end
	
    	if ((INIT_Q1 != 1'b0) && (INIT_Q1 != 1'b1)) begin
	    $display("Attribute Syntax Error : The attribute INIT_Q0 on X_IDDR2 instance %m is set to %d.  Legal values for this attribute are 0 or 1.", INIT_Q1);
	    $finish;
	end

    	if ((DDR_ALIGNMENT != "C1") && (DDR_ALIGNMENT != "C0") && (DDR_ALIGNMENT != "NONE")) begin
	    $display("Attribute Syntax Error : The attribute DDR_ALIGNMENT on X_IDDR2 instance %m is set to %s.  Legal values for this attribute are C0, C1 or NONE.", DDR_ALIGNMENT);
	    $finish;
	end
	
	if ((SRTYPE != "ASYNC") && (SRTYPE != "SYNC")) begin
	    $display("Attribute Syntax Error : The attribute SRTYPE on X_IDDR2 instance %m is set to %s.  Legal values for this attribute are ASYNC or SYNC.", SRTYPE);
	    $finish;
	end

    end // initial begin

    assign PC0 = ((DDR_ALIGNMENT== "C0") || (DDR_ALIGNMENT== "NONE"))?  c0_in : c1_in;
    assign PC1 = ((DDR_ALIGNMENT== "C0") || (DDR_ALIGNMENT== "NONE"))?  c1_in : c0_in;

    always @(GSR or r_in or s_in) begin

	if (GSR == 1) begin

	    assign q0_out_int = INIT_Q0;
	    assign q1_out_int = INIT_Q1;
	    assign q0_c0_out_int = INIT_Q0;
	    assign q1_c0_out_int = INIT_Q1;

	end
	else begin
	    
	    deassign q0_out_int;
	    deassign q1_out_int;
	    deassign q0_c0_out_int;
	    deassign q1_c0_out_int;
	    
	    if (SRTYPE == "ASYNC") begin
		if (r_in == 1) begin
		    assign q0_out_int = ~INIT_Q0;
		    assign q1_out_int = ~INIT_Q1;
		    assign q0_c0_out_int = 0;
		    assign q1_c0_out_int = 0;
		end
		else if (r_in == 0 && s_in == 1) begin
		    assign q0_out_int = INIT_Q0;
		    assign q1_out_int = INIT_Q1;
		end
	    end // if (SRTYPE == "ASYNC")
	    
	end // if (GSR == 1'b0)
	
    end // always @ (GSR or r_in or s_in)

	    
    always @(posedge PC0) begin
 	if (r_in == 1 && SRTYPE == "SYNC") begin
	    q0_out_int <= 0;
	    q0_c0_out_int <= 0;
	    q1_c0_out_int <= 0;
	end
	else if (r_in == 0 && s_in == 1 && SRTYPE == "SYNC") begin
	    q0_out_int <= 1;
	end
	else if (ce_in == 1 && r_in == 0 && s_in == 0) begin
            q0_out_int <= d_in;
            q0_c0_out_int <= q0_out_int;
            q1_c0_out_int <= q1_out_int;
	end
    end // always @ (posedge PC0)

    
    always @(posedge PC1) begin
 	if (r_in == 1 && SRTYPE == "SYNC") begin
	    q1_out_int <= 0;
	end
	else if (r_in == 0 && s_in == 1 && SRTYPE == "SYNC") begin
	    q1_out_int <= 1;
	end
	else if (ce_in == 1 && r_in == 0 && s_in == 0) begin
            q1_out_int <= d_in;
	end
    end // always @ (posedge c1_in)
    
    
    always @(q0_out_int or q1_out_int or q1_c0_out_int or q0_c0_out_int) begin

	case (DDR_ALIGNMENT)
	    "NONE" : begin
		       q0_out <= q0_out_int;
		       q1_out <= q1_out_int;
	             end
	    "C0" : begin
	               q0_out <= q0_out_int;
	               q1_out <= q1_c0_out_int;
	           end
	    "C1" : begin
                       q0_out <= q0_out_int;
                       q1_out <= q1_c0_out_int;
	           end
	endcase // case(DDR_ALIGNMENT)

    end // always @ (q0_out_int or q1_out_int or q1_c0_out_int or q0_c0_out_int)
    

//*** Timing Checks Start here

    always @(notifier) begin
	q0_out <= 1'bx;
	q1_out <= 1'bx;
    end

    specify
	
	if (C0) (C0 => Q0) = (100:100:100, 100:100:100);
	if (C0) (C0 => Q1) = (100:100:100, 100:100:100);
	if (C1) (C1 => Q1) = (100:100:100, 100:100:100);
	if (C1) (C1 => Q0) = (100:100:100, 100:100:100);
	(R => Q0) = (0:0:0, 0:0:0);
	(R => Q1) = (0:0:0, 0:0:0);
	(S => Q0) = (0:0:0, 0:0:0);
	(S => Q1) = (0:0:0, 0:0:0);
	
	$setuphold (posedge C0, negedge CE, 0:0:0, 0:0:0, notifier, , , c0_in, ce_in);
	$setuphold (posedge C0, negedge D, 0:0:0, 0:0:0,  notifier, , , c0_in, d_in);
	$setuphold (posedge C0, negedge R, 0:0:0, 0:0:0,  notifier, , , c0_in, r_in);
	$setuphold (posedge C0, negedge S, 0:0:0, 0:0:0,  notifier, , , c0_in, s_in);
	$setuphold (posedge C0, posedge CE, 0:0:0, 0:0:0, notifier, , , c0_in, ce_in);
	$setuphold (posedge C0, posedge D, 0:0:0, 0:0:0,  notifier, , , c0_in, d_in);
	$setuphold (posedge C0, posedge R, 0:0:0, 0:0:0,  notifier, , , c0_in, r_in);
	$setuphold (posedge C0, posedge S, 0:0:0, 0:0:0,  notifier, , , c0_in, s_in);
	$setuphold (posedge C1, negedge CE, 0:0:0, 0:0:0, notifier, , , c1_in, ce_in);
	$setuphold (posedge C1, negedge D, 0:0:0, 0:0:0,  notifier, , , c1_in, d_in);
	$setuphold (posedge C1, negedge R, 0:0:0, 0:0:0,  notifier, , , c1_in, r_in);
	$setuphold (posedge C1, negedge S, 0:0:0, 0:0:0,  notifier, , , c1_in, s_in);
	$setuphold (posedge C1, posedge CE, 0:0:0, 0:0:0, notifier, , , c1_in, ce_in);
	$setuphold (posedge C1, posedge D, 0:0:0, 0:0:0,  notifier, , , c1_in, d_in);
	$setuphold (posedge C1, posedge R, 0:0:0, 0:0:0,  notifier, , , c1_in, r_in);
	$setuphold (posedge C1, posedge S, 0:0:0, 0:0:0,  notifier, , , c1_in, s_in);
	
	$recrem (negedge R, posedge C0, 0:0:0, 0:0:0, notifier);
	$recrem (negedge R, posedge C1, 0:0:0, 0:0:0, notifier);
	$recrem (negedge S, posedge C0, 0:0:0, 0:0:0, notifier);
	$recrem (negedge S, posedge C1, 0:0:0, 0:0:0, notifier);
	
	$period (posedge C0, 0:0:0, notifier);
	$period (posedge C1, 0:0:0, notifier);
        $width (posedge C0, 0:0:0, 0, notifier);
        $width (negedge C0, 0:0:0, 0, notifier);
        $width (posedge C1, 0:0:0, 0, notifier);
        $width (negedge C1, 0:0:0, 0, notifier);
	$width (posedge R, 0:0:0, 0, notifier);
	$width (posedge S, 0:0:0, 0, notifier);

	specparam PATHPULSE$ = 0;
	
    endspecify

endmodule // X_IDDR2
