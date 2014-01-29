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
// /___/   /\     Filename : X_ODDR2.v
// \   \  /  \    Timestamp : Thu Mar 25 16:44:07 PST 2005
//  \___\/\___\
//
// Revision:
//    03/23/04 - Initial version.
//    04/22/05 - Added LOC parameter, removed GSR ports and initialized outpus.
//    12/07/07 - CR 456124 -- added input port buffers
//    04/30/08 - CR 468871 Negative SetupHold fix
//    08/20/08 - CR 478850 added pulldown on R/S and pullup on CE.
//    01/12/09 - IR 503207 Reworked C0/C1 alignments
//    06/24/09 - CR 525390 Fixed delta cycle race condition issue using generate statements
// End Revision

`timescale 1 ps / 1 ps

module X_ODDR2 (Q, C0, C1, CE, D0, D1, R, S);
    
    output Q;

    input C0;
    input C1;
    input CE;
    input D0;
    input D1;
    tri0 GSR = glbl.GSR;
    input R;
    input S;

    parameter DDR_ALIGNMENT = "NONE";    
    parameter INIT = 1'b0;
    parameter LOC = "UNPLACED";
    parameter SRTYPE = "SYNC";

    pullup   P1 (CE);
    pulldown P2 (R);
    pulldown P3 (S);

    reg q_out = INIT, q_d1_c0_out_int;    
    reg notifier;

    wire c0_in;
    wire c1_in;
//    wire pc0_in;
//    wire pc1_in;
    wire ce_in;
    wire d0_in;
    wire d1_in;
    wire r_in;
    wire s_in;

//    buf buf_c0 (c0_in, C0);
//    buf buf_c1 (c1_in, C1);
    buf buf_ce (ce_in, CE);
    buf buf_d0 (d0_in, D0);
    buf buf_d1 (d1_in, D1);
    buf buf_r (r_in, R);
    buf buf_s (s_in, S);

    
    buf buf_q (Q, q_out);

//    assign pc0_in = ((DDR_ALIGNMENT== "C0") || (DDR_ALIGNMENT== "NONE"))?  c0_in : c1_in;
//    assign pc1_in = ((DDR_ALIGNMENT== "C0") || (DDR_ALIGNMENT== "NONE"))?  c1_in : c0_in;

    initial begin

	if ((INIT != 1'b0) && (INIT != 1'b1)) begin
	    $display("Attribute Syntax Error : The attribute INIT on X_ODDR2 instance %m is set to %d.  Legal values for this attribute are 0 or 1.", INIT);
	    $finish;
	end
	
    	if ((DDR_ALIGNMENT != "NONE") && (DDR_ALIGNMENT != "C0") && (DDR_ALIGNMENT != "C1")) begin
	    $display("Attribute Syntax Error : The attribute DDR_ALIGNMENT on X_ODDR2 instance %m is set to %s.  Legal values for this attribute are NONE, C0 or C1.", DDR_ALIGNMENT);
	    $finish;
	end
	
	if ((SRTYPE != "ASYNC") && (SRTYPE != "SYNC")) begin
	    $display("Attribute Syntax Error : The attribute SRTYPE on X_ODDR2 instance %m is set to %s.  Legal values for this attribute are ASYNC or SYNC.", SRTYPE);
	    $finish;
	end

    end // initial begin
    

    always @(GSR or r_in or s_in) begin

	if (GSR == 1) begin

	    assign q_out = INIT;
	    assign q_d1_c0_out_int = INIT;

	end
	else begin

	    deassign q_out;
	    deassign q_d1_c0_out_int;
	    
	    if (SRTYPE == "ASYNC") begin
		if (r_in == 1) begin
		    assign q_out = 0;
		    assign q_d1_c0_out_int = 0;
		end
		else if (r_in == 0 && s_in == 1) begin
		    assign q_out = 1;
		    assign q_d1_c0_out_int = 1;
		end
	    end // if (SRTYPE == "ASYNC")
	    
	end // if (GSR == 1'b0)
	
    end // always @ (GSR or r_in or s_in)

    generate if((DDR_ALIGNMENT== "C0")  || (DDR_ALIGNMENT== "NONE"))
    begin
        always @(posedge c0_in) begin
	
 	    if (r_in == 1 && SRTYPE == "SYNC") begin
	        q_out <= 0;
	        q_d1_c0_out_int <= 0;
    	    end
	    else if (r_in == 0 && s_in == 1 && SRTYPE == "SYNC") begin
	        q_out <= 1;
	        q_d1_c0_out_int <= 1;
	    end
	    else if (ce_in == 1 && r_in == 0 && s_in == 0) begin
	                q_out <= d0_in;
		        q_d1_c0_out_int <= d1_in;
	    end // if (ce_in == 1 && r_in == 0 && s_in == 0)
	
        end // always @ (posedge c0_in)
    
    
        always @(posedge c1_in) begin
	
	    if (r_in == 1 && SRTYPE == "SYNC") begin
	        q_out <= 0;
	    end
	    else if (r_in == 0 && s_in == 1 && SRTYPE == "SYNC") begin
	            q_out <= 1;
	        end
	    else if (ce_in == 1 && r_in == 0 && s_in == 0) begin
	    
	        if (DDR_ALIGNMENT == "NONE")
		    q_out <= d1_in;
	        else  
		    q_out <= q_d1_c0_out_int;
	    
	    end // if (ce_in == 1 && r_in == 0 && s_in == 0)
	
        end // always @ (negedge c1_in)
    end


   else
      begin
    
        always @(posedge c0_in) begin
	
 	    if (r_in == 1 && SRTYPE == "SYNC") begin
	        q_out <= 0;
	        q_d1_c0_out_int <= 0;
	    end
	    else if (r_in == 0 && s_in == 1 && SRTYPE == "SYNC") begin
	        q_out <= 1;
	        q_d1_c0_out_int <= 1;
	    end
	    else if (ce_in == 1 && r_in == 0 && s_in == 0) begin
	                q_out <= d0_in;
		        q_d1_c0_out_int <= d1_in;
	    end // if (ce_in == 1 && r_in == 0 && s_in == 0)
	
        end // always @ (posedge c0_in)
    
    
        always @(posedge c1_in) begin
	
	    if (r_in == 1 && SRTYPE == "SYNC") begin
	        q_out <= 0;
	    end
	    else if (r_in == 0 && s_in == 1 && SRTYPE == "SYNC") begin
	            q_out <= 1;
	        end
	    else if (ce_in == 1 && r_in == 0 && s_in == 0) begin
	    
	        if (DDR_ALIGNMENT == "NONE")
		    q_out <= d1_in;
	        else  
		    q_out <= q_d1_c0_out_int;
	    
	    end // if (ce_in == 1 && r_in == 0 && s_in == 0)
	
        end // always @ (negedge c1_in)
      end
    endgenerate
    
    
//*** Timing Checks Start here

    always @(notifier) begin
	q_out <= 1'bx;
    end

    specify

	if (C0) (C0 => Q) = (100:100:100, 100:100:100);
	if (C1) (C1 => Q) = (100:100:100, 100:100:100);
	(R => Q) = (0:0:0, 0:0:0);
	(S => Q) = (0:0:0, 0:0:0);
	
	$setuphold (posedge C0, posedge CE, 0:0:0, 0:0:0, notifier, , , c0_in, ce_in);
	$setuphold (posedge C0, negedge CE, 0:0:0, 0:0:0, notifier, , , c0_in, ce_in);
	$setuphold (posedge C1, posedge CE, 0:0:0, 0:0:0, notifier, , , c1_in, ce_in);
	$setuphold (posedge C1, negedge CE, 0:0:0, 0:0:0, notifier, , , c1_in, ce_in);
	
	$setuphold (posedge C0, posedge D0, 0:0:0, 0:0:0, notifier, , , c0_in, d0_in);
	$setuphold (posedge C0, negedge D0, 0:0:0, 0:0:0, notifier, , , c0_in, d0_in);
	$setuphold (posedge C0, posedge D1, 0:0:0, 0:0:0, notifier, , , c0_in, d1_in);
	$setuphold (posedge C0, negedge D1, 0:0:0, 0:0:0, notifier, , , c0_in, d1_in);

	$setuphold (posedge C1, posedge D0, 0:0:0, 0:0:0, notifier, , , c1_in, d0_in);
	$setuphold (posedge C1, negedge D0, 0:0:0, 0:0:0, notifier, , , c1_in, d0_in);
	$setuphold (posedge C1, posedge D1, 0:0:0, 0:0:0, notifier, , , c1_in, d1_in);
	$setuphold (posedge C1, negedge D1, 0:0:0, 0:0:0, notifier, , , c1_in, d1_in);
	
	$setuphold (posedge C0, posedge R, 0:0:0, 0:0:0, notifier, , , c0_in, r_in);
	$setuphold (posedge C0, negedge R, 0:0:0, 0:0:0, notifier, , , c0_in, r_in);
	$setuphold (posedge C0, posedge S, 0:0:0, 0:0:0, notifier, , , c0_in, s_in);
	$setuphold (posedge C0, negedge S, 0:0:0, 0:0:0, notifier, , , c0_in, s_in);

	$setuphold (posedge C1, posedge R, 0:0:0, 0:0:0, notifier, , , c1_in, r_in);
	$setuphold (posedge C1, negedge R, 0:0:0, 0:0:0, notifier, , , c1_in, r_in);
	$setuphold (posedge C1, posedge S, 0:0:0, 0:0:0, notifier, , , c1_in, s_in);
	$setuphold (posedge C1, negedge S, 0:0:0, 0:0:0, notifier, , , c1_in, s_in);
	
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

endmodule // X_ODDR2
