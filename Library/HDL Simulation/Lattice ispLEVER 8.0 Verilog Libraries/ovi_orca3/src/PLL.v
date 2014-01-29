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
// Simulation Library File for ORCA3
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/PLL.v,v 1.15 2005/05/19 18:30:50 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

module PLL (CLKIN, FB, ECLK, GSR, PUR, SCLK, LOCK);
   parameter DIV0 = 1, DIV1 = 1, DIV2 = 1, 
             FBDELAY = 0.0, DISABLED_GSR=0;
   
`define   jitter 2.0
`define   acq_tm 5

   input     CLKIN, FB;
   input     GSR, PUR;
   output    ECLK, SCLK, LOCK;
   
   buf       (CLKINb, CLKIN);

   wire      CLKIN, FB;
   wire      GSR, PUR;
   wire      ECLK, SCLK, LOCK;

   reg 	     EclkReg, SclkReg, LockReg;
   reg [3:0] Div0Reg, Div1Reg, Div2Reg;

   realtime  clkin_cycle, fb_cycle;
   realtime  clkin_last, fb_last;
   realtime  PD1_cycle, PD2_cycle;
   realtime  declk, dsclk; // half period of each clock
   realtime  PD1_edge, PD2_edge; // used for phase diff
   realtime  phase_diff, start_delay;  // delay offset within cycle

   integer   clkin_count, fb_count, sclk_count;
   integer   error_count, good_count;
   integer   mult_factor;

   reg       SR;

//---- Programmable GSR ----
   and (GP, GSR, PUR);
   not INST58 (GP_NOT, GP);
   not INST59 (PUR_NOT, PUR);

   always @ (GSR or PUR or GP_NOT or PUR_NOT or DISABLED_GSR) begin
      if (DISABLED_GSR == 0) begin
	 SR = GP_NOT;
      end
      else if (DISABLED_GSR == 1)
	SR = PUR_NOT;
   end
//--------------------------

   //buf #start_delay U1 (ECLK, EclkReg);
   //buf #start_delay U2 (SCLK, SclkReg);
   buf U1 (ECLK, EclkReg);
   buf U2 (SCLK, SclkReg);
   buf U3 (LOCK, LockReg);

   // 1. The freqency and phase of the two inputs to the phase detector 
   //    are equal. (PD1_cycle and PD2_cycle) (phase_diff = 0)
   // 2. the frequency at the phase detector is always CLKIN divided by
   //    DIV0.
   // 3. the frequency at the phase detector is always the frequency at
   //    the feedback pin divided by DIV1.
   // 4. the frequency at the feedback pin is either SCLK or ECLK.
   // 5. ECLK frequency is always SCLK frequency divided by DIV2.

   // FUNCTION TO CHECK DIV VALUES
   //
   // The value of DIV0, DIV1 and DIV2 must be between zero and eight.  If 
   // the divisor is zero, then it should be set to one.  We need to change
   // these from parameters to registers because we do a modulo remainder
   // 'a % b' and you can't use a parameter for 'b'.

   function [3:0] check_value;
      input [3:0] RegNo;
      input [3:0] Divisor;

      begin
        if(Divisor < 1 || Divisor > 8)
          begin
             if (Divisor == 0)
               check_value = 1;
             else
               begin
                  $display("ERROR: PLL - DIV%0d is not valid: %0d", RegNo, Divisor);
                  $finish;
               end
          end // if (Divisor < 1 || Divisor > 8)
	else
	  check_value = Divisor;
      end
   endfunction // check_value
   
   initial
     fork: start_up
        EclkReg = 1'b0;
        SclkReg = 1'b0;
        LockReg = 1'b0;
        Div0Reg = check_value(0, DIV0);
        Div1Reg = check_value(1, DIV1);
        Div2Reg = check_value(2, DIV2);
	mult_factor = Div1Reg * Div2Reg;
        start_delay = 0.0;
	// arbitrary initialization values.  The '*_last' should be negative
	// to give an initial cycle time greater than zero.
        clkin_cycle = 5.0;
	fb_cycle = 5.0;
	clkin_last = $realtime - 5.0;
	fb_last = $realtime - 5.0;
        phase_diff = 0.0;
	dsclk = 12.5; // start sclk at 40 MHz (this is an arbitrary value)
        declk = dsclk * Div2Reg;  // eclk always is Sclk/DIV2
	// Initialize counters and flags to zero
        clkin_count = 1; // skip the first half cycle
	fb_count = 1;    // skip the first cycle
        error_count = 0;
        good_count = 0;
        // define the time format for displaying time values
	$timeformat(-9, 3, "ns", 8);
     join // block: start_up

   always @(SR)
     begin
        if (SR)
	  begin
	     clkin_count = 1;
             fb_count = 1;
             deassign good_count;
	     assign good_count = 0;
	     deassign EclkReg;
	     assign EclkReg = 1'b0;
	     deassign SclkReg;
	     assign SclkReg = 1'b0;
             deassign LockReg;
	     assign LockReg = 1'b0;
	  end // if (SR)
	else
          begin
             deassign good_count;
	     deassign EclkReg;
	     deassign SclkReg;
             SclkReg <= 1'b1;
             deassign LockReg;
             mult_factor = Div1Reg * Div2Reg; // start over
             clkin_cycle = 5.0;
	     fb_cycle = 5.0;
	     clkin_last = $realtime - 5.0;
	     fb_last = $realtime - 5.0;
	     phase_diff = 0.0;
             clkin_count = 1;
	     fb_count = 1;
	     sclk_count = 0;
	     error_count = 0;
	  end // else: !if(SR)
     end // always @ (SR)

   always @(posedge CLKINb)
     begin: create_PD1sig

	// determine the CLKIN cycle time
        clkin_cycle = $realtime - clkin_last;
        clkin_last = $realtime;  // get ready for the next cycle

	// The input to the phase detector only occurs every Div0Reg'th time.

	if (clkin_count == 0)  // pos edge at PD1 input
	  begin: PD1_input
	     PD1_cycle = clkin_cycle * Div0Reg; // Basic fact
	     PD1_edge = $realtime; // used to find phase difference

	     // give the feedback enough cycles to lock, then switch the 
	     // mult factor if necessary.
	     // CHECK TO SEE IF THE FREQUENCY AT PD1 and PD2 are not equal
	     if ((PD2_cycle > PD1_cycle + `jitter) ||
		 (PD2_cycle < PD1_cycle - `jitter))
	       begin: not_equal_cycles
                  // No frequency lock at this time
                  LockReg = 1'b0;
                  good_count = 0;
		  error_count = error_count + 1;
		  if (error_count == 7) // switch to Sclk feedback
		    begin 
		       mult_factor = mult_factor * (PD2_cycle / PD1_cycle);
                       clkin_count = 0; // synchronize the counters
		       fb_count = 1;
		       sclk_count = 0;
                       PD2_cycle = PD1_cycle;
		    end
                  if (error_count == 17) // switch to Sclk feedback
		    begin 
		       mult_factor = mult_factor * (PD2_cycle / PD1_cycle);
                       clkin_count = 0; // synchronize the counters
		       fb_count = 1;
		       sclk_count = 0;
                       PD2_cycle = PD1_cycle;
		    end
		  // It couldn't lock on with any feedback
		  if (error_count == 37) // Still no lock
		    begin 
		       mult_factor = mult_factor * (PD2_cycle / PD1_cycle);
                       clkin_count = 0; // synchronize the counters
		       fb_count = 1;
		       sclk_count = 0;
                       PD2_cycle = PD1_cycle;
		    end
		  if (error_count == 53) // Still no lock
		    begin
		       $display("ERROR: no lock achieved in 53 cycles. $t != %t", 
				clkin_cycle, fb_cycle);
		       $finish;
		    end
	       end // block: not_equal_cycles
	     else // PD1 and PD2 are approximately equal
	       begin: equal_cycles
		  good_count = good_count + 1;
                  if (good_count > `acq_tm) // fast exit when already locked
		    begin
		       good_count = `acq_tm;
		    end
		  else if (good_count == `acq_tm) // after acq_tm good cycles
		    begin                   // 
		       LockReg = 1'b1;      // assert the LOCK signal
                       error_count = 1'b0;  // and reset the error_count
`ifdef DEBUG
		       $display("The Locked Values of [freq, cycle, PD1, dsclk, declk]");
		       $display("LOCK: %f %t %t %f %f (%t)", `frequency, clkin_cycle, 
				PD1_cycle, dsclk, declk, $realtime);
`endif
		    end // if (good_count > `acq_tm)
	       end // block: equal_cycles
	     
	     dsclk = ((Div0Reg * clkin_cycle) / (2 * mult_factor));
	     declk = dsclk * Div2Reg; // compute the pulse width

	  end // block: PD1_input
	clkin_count = ((clkin_count + 1) % (Div0Reg));
     end // block: create_PD1sig
   
   always @(posedge SclkReg)
     begin 
        sclk_count = ((sclk_count + 1) % Div2Reg);
	if (sclk_count == 0)
          begin: SCLK_cycle
	     EclkReg = 1'b1;         // start the cycle
	  end // block: SCLK_cycle
        #dsclk SclkReg = 1'b0;
     end // always @ (posedge SclkReg)
	
   always @(negedge SclkReg)
     begin
	#dsclk SclkReg = 1'b1;
     end
   
   always @(posedge EclkReg)
     begin
	#declk EclkReg = 1'b0;  // finish the cycle
     end

   always @(posedge FB)
     begin: create_PD2sig
	// determine the FB cycle time
	fb_cycle = $realtime - fb_last;
	fb_last = $realtime;

	// The input to the phase detector only occurs every Div1Reg'th time.

	if (fb_count == 0)  // pos edge PD2 input
	  begin: PD2_input
	     PD2_cycle = fb_cycle * Div1Reg; // Basic fact
	     PD2_edge = $realtime;  // used to find phase difference
	     phase_diff = PD2_edge - PD1_edge;

	     // if the FBDELAY is zero, use the actual phase difference
	     if (FBDELAY == 0.0)
	       start_delay = start_delay - phase_diff;
	     // otherwise use FBDELAY
	     else    
	       start_delay = (2.0 * dsclk) - FBDELAY;
	     
	     // ensure the delay is positive and less than one cycle
	     while ((start_delay < 0.0) && ((2.0 * dsclk) > 0.0))
	       start_delay = start_delay + (2.0 * dsclk);

	  end // block: PD2_input
	fb_count = ((fb_count + 1) % (Div1Reg)) ;
	
     end // block: create_PD2sig
   
endmodule


