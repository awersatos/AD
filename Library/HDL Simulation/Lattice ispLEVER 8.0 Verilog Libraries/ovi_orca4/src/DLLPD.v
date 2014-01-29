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
// Simulation Library File for ORCA4
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/DLLPD.v,v 1.2 2005/05/19 19:01:07 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

module DLLPD (CLKIN, ECLK, SCLK, GSR, PUR, LOCK);
   // The delay tap is passed as an integer from 0 to 30 (31 is not
   // allowed) and is the number of 32nds the output is high.
   parameter PDELAY=1, DIV0=1, DIV2=1, DISABLED_GSR=0;  

`define  jitter 2.0
`define  acq_tm 5

   input     CLKIN;
   input     GSR, PUR;
   output    ECLK, SCLK, LOCK;

   wire      CLKIN;
   wire      GSR, PUR;
   wire      ECLK, SCLK, LOCK;

   integer   clkin_count, good_count;

   reg 	     EclkReg, SclkReg, LockReg;
   reg [3:0] Div0Reg, Div2Reg;
   reg 	     alternate;

   realtime  start_delay;
   realtime  cycle_last, cycle_now, last_posedge;
   realtime  declk, dsclk;

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

   buf (LOCK, LockReg);
   buf (ECLK, EclkReg);
   buf (SCLK, SclkReg);

   initial
     begin: setup
        LockReg = 1'b0;
        EclkReg = 1'b0;
        SclkReg = 1'b0;
        clkin_count = 0;
	last_posedge = 0;
	cycle_last = -1;
	cycle_now  = -2;
	alternate = 1'b0;

	if(PDELAY < 1 || PDELAY > 31)
	  begin
             $display("ERROR: DLLPD - Delay Tap is not valid: %d", PDELAY);
	     $finish;
	  end // if (PDELAY < 1 || PDELAY >= 31)

        if(DIV0 < 1 || DIV0 > 8) // DIV0 may be bad
          begin
             if (DIV0 == 0)
               Div0Reg = 1;
             else
               begin
                  $display("ERROR: PLL - DIV0 is not valid: %0d", DIV0);
                  $finish;
               end
          end // if (DIV0 < 1 || DIV0 > 8)
	else // DIV0 is good
	  Div0Reg = DIV0;

        if(DIV2 < 1 || DIV2 > 8) // DIV2 may be bad
          begin
             if (DIV2 == 0)
               Div2Reg = 1;
             else
               begin
                  $display("ERROR: PLL - DIV2 is not valid: %0d", DIV2);
                  $finish;
               end
          end // if (DIV2 < 1 || DIV2 > 8)
	else // DIV2 is good
	  Div2Reg = DIV2;
     end // block: setup

   always @(SR)
     begin
	if (SR)
	  begin
	     clkin_count = 0;
	     good_count = 0;
	     deassign EclkReg;
	     assign EclkReg = 1'b0;
	     deassign SclkReg;
	     assign SclkReg = 1'b0;
             deassign LockReg;
	     assign LockReg = 1'b0;
	  end // if (SR)
	else
	  begin
	     deassign EclkReg;
	     deassign SclkReg;
             deassign LockReg;
	     cycle_last = -1;
	     cycle_now = -2;
	     alternate = 1'b0;
	  end // else: !if(SR)
     end // always @ (SR)

   always @(posedge CLKIN) 
     begin: cycle
	cycle_now = $realtime - last_posedge;
	last_posedge = $realtime;

        // We have to base the long cycle on ECLK since that is the SLOWEST clock in the PCM. 
	//  However, the phase delay is based on SCLK.
	clkin_count = ((clkin_count + 1) % (Div0Reg * Div2Reg));
	if (clkin_count == 0) // pos edge of ECLK
	  begin: create_clocks
             cycle_now = (cycle_now * Div0Reg) * Div2Reg; // ECLK 

	     // if the cycle time is constant, then lock the PCM after acq_tm cycles
	     if ((cycle_now < (cycle_last + `jitter)) && (cycle_now > (cycle_last - `jitter)))
	       begin
		  good_count = good_count + 1;
		  if (good_count > `acq_tm)
		    begin
		       LockReg = 1'b1;
                       good_count = `acq_tm;
		    end
	       end
	     else 
	       begin
		  good_count = 0;
		  LockReg = 1'b0;
	       end

	     cycle_last = cycle_now; // set up for the next clock cycle

	     // start delay is based on SCLK
	     start_delay = ((cycle_now / Div2Reg) * PDELAY / 32.0);
             // the half period of the two clocks
	     declk = cycle_now / 2.0;
	     dsclk = declk / Div2Reg;
	     
	     alternate = !alternate;
	  end // block: create_clocks
     end // block: cycle
   
   always @(posedge alternate) 
     #start_delay begin
	SclkReg <= 1'b1;
	EclkReg <= 1'b1;

	fork
	   #declk EclkReg <= 1'b0;
	   repeat (2 * Div2Reg - 1)
	     begin
		#dsclk SclkReg <= !SclkReg;
	     end
	join
     end // cyclel
   
   always @(negedge alternate) 
     #start_delay begin
	EclkReg <= 1'b1;
	SclkReg <= 1'b1;

	fork
	   #declk EclkReg <= 1'b0;
	   repeat (2 * Div2Reg - 1)
	     begin
		#dsclk SclkReg <= !SclkReg;
	     end
	join
     end // cycle2
   
endmodule
