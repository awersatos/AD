///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2004 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 8.1i (I.19)
//  \   \         Description : Xilinx Timing Simulation Library Component
//  /   /                  Dynamically Adjustable Differential Input Delay Buffer
// /___/   /\     Filename : X_IBUFDS_DLY_ADJ.v
// \   \  /  \    Timestamp : Fri Jun 3 16:44:07 PST 2005
//  \___\/\___\
//
// Revision:
//    06/03/05 - Initial version.
//    05/29/07 - Added wire declaration for internal signals
//    08/08/07 - CR 439320 -- Simprim fix -- Added attributes SIM_DELAY0, ... SIM_DELAY16 to fix timing issues
//    09/11/07 - CR 447604 -- When S[2:0]=0, it should correlate to 1 tap
//    03/28/08 - CR 469907 -- Corrected bus path of S[2:0] in the specify block elaboration
// End Revision

`timescale  1 ps / 1 ps

module X_IBUFDS_DLY_ADJ (O, I, IB, S);

    output O;

    input I, IB;
    input [2:0] S;

    parameter DELAY_OFFSET = "OFF";
    parameter DIFF_TERM    = "FALSE";
    parameter IOSTANDARD   = "DEFAULT";    

    parameter LOC = "UNPLACED";
    parameter SIM_TAPDELAY_VALUE = 200;

    parameter integer SIM_DELAY0 = 0;
    parameter integer SIM_DELAY1 = 0;
    parameter integer SIM_DELAY2 = 0;
    parameter integer SIM_DELAY3 = 0;
    parameter integer SIM_DELAY4 = 0;
    parameter integer SIM_DELAY5 = 0;
    parameter integer SIM_DELAY6 = 0;
    parameter integer SIM_DELAY7 = 0;
    parameter integer SIM_DELAY8 = 0;
    parameter integer SIM_DELAY9 = 0;
    parameter integer SIM_DELAY10 = 0;
    parameter integer SIM_DELAY11 = 0;
    parameter integer SIM_DELAY12 = 0;
    parameter integer SIM_DELAY13 = 0;
    parameter integer SIM_DELAY14 = 0;
    parameter integer SIM_DELAY15 = 0;
    parameter integer SIM_DELAY16 = 0;

    parameter SPECTRUM_OFFSET_DELAY = 1600;

//    localparam DELAY_D_1 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY1 - SIM_DELAY0) : (SIM_DELAY9  - SIM_DELAY0);
    localparam DELAY_D_1 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY1) : (SIM_DELAY9);
    localparam DELAY_D_2 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY2 - SIM_DELAY1) : (SIM_DELAY10 - SIM_DELAY9);
    localparam DELAY_D_3 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY3 - SIM_DELAY2) : (SIM_DELAY11 - SIM_DELAY10);
    localparam DELAY_D_4 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY4 - SIM_DELAY3) : (SIM_DELAY12 - SIM_DELAY11);
    localparam DELAY_D_5 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY5 - SIM_DELAY4) : (SIM_DELAY13 - SIM_DELAY12);
    localparam DELAY_D_6 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY6 - SIM_DELAY5) : (SIM_DELAY14 - SIM_DELAY13);
    localparam DELAY_D_7 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY7 - SIM_DELAY6) : (SIM_DELAY15 - SIM_DELAY14);
    localparam DELAY_D_8 = (DELAY_OFFSET == "OFF") ? (SIM_DELAY8 - SIM_DELAY7) : (SIM_DELAY16 - SIM_DELAY15);


    reg notifier;    
    reg o_out;

    reg i_int;

    wire [2:0] s_in;
    wire i_in;
    wire ib_in;

    integer delay_count;

    wire delay_chain_0,  delay_chain_1,  delay_chain_2,  delay_chain_3,
         delay_chain_4,  delay_chain_5,  delay_chain_6,  delay_chain_7;
    
    buf buf_o (O, o_out);

    buf buf_i (i_in, I);
    buf buf_ib (ib_in, IB);
    buf buf_s[2:0] (s_in, S);
   
    time INITIAL_DELAY = 0;
    time FINAL_DELAY   = 0;
   

    initial begin
        case (DIFF_TERM)

            "TRUE", "FALSE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute DIFF_TERM on IBUFDS instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DIFF_TERM);
                          $finish;
                      end
        endcase // case(DIFF_TERM)

	if (DELAY_OFFSET != "ON" && DELAY_OFFSET != "OFF") begin

	    $display("Attribute Syntax Error : The attribute DELAY_OFFSET on X_IBUFDS_DLY_ADJ instance %m is set to %s.  Legal values for this attribute are ON or OFF", DELAY_OFFSET);
	    $finish;

        end
        
        if(DELAY_OFFSET == "ON")
// CR 447604
//          INITIAL_DELAY = SPECTRUM_OFFSET_DELAY; 
          INITIAL_DELAY = SPECTRUM_OFFSET_DELAY + SIM_TAPDELAY_VALUE;
        else
//          INITIAL_DELAY = 0; 
          INITIAL_DELAY = SIM_TAPDELAY_VALUE; 
	
    end // initial begin
    
    
//------------------------------------------------------------
//---------------------- delay the chain  --------------------
//------------------------------------------------------------
    always @(i_in or ib_in) begin
        if (i_in == 1'b1 && ib_in == 1'b0)
            i_int <= i_in;
        else if (i_in == 1'b0 && ib_in == 1'b1)
            i_int <= i_in;
    end

//------------------------------------------------------------    
//----------------------- S input ----------------------------    
//------------------------------------------------------------    
    always@s_in
// #FINAL_DELAY = s_in * SIM_TAP_DELAY_VALUE + INITIAL_DELAY;
	delay_count = s_in;

//------------------------------------------------------------
//---------------------- delay the chain  --------------------
//------------------------------------------------------------
    assign #DELAY_D_1 delay_chain_0  = i_in;
    assign #DELAY_D_2 delay_chain_1  = delay_chain_0;
    assign #DELAY_D_3 delay_chain_2  = delay_chain_1;
    assign #DELAY_D_4 delay_chain_3  = delay_chain_2;
    assign #DELAY_D_5 delay_chain_4  = delay_chain_3;
    assign #DELAY_D_6 delay_chain_5  = delay_chain_4;
    assign #DELAY_D_7 delay_chain_6  = delay_chain_5;
    assign #DELAY_D_8 delay_chain_7  = delay_chain_6;

//------------------------------------------------------------
//---------------------- Assign to output  -------------------
//------------------------------------------------------------
    always @(delay_count) begin

        case (delay_count)
            0:  assign o_out = delay_chain_0;
            1:  assign o_out = delay_chain_1;
            2:  assign o_out = delay_chain_2;
            3:  assign o_out = delay_chain_3;
            4:  assign o_out = delay_chain_4;
            5:  assign o_out = delay_chain_5;
            6:  assign o_out = delay_chain_6;
            7:  assign o_out = delay_chain_7;
            default:
                assign o_out = delay_chain_0;

        endcase
    end // always @ (s_in)


//*** Timing Checks Start here

    always @(notifier) begin
	o_out <= 1'bx;
    end

    specify
	
	(I  => O) = (0:0:0, 0:0:0);
	(IB => O) = (0:0:0, 0:0:0);
	(S  *> O) = (0:0:0, 0:0:0);

	specparam PATHPULSE$ = 0;

    endspecify

endmodule // X_IBUFDS_DLY_ADJ

