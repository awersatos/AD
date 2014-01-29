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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/DLL1X.v,v 1.10 2005/05/19 18:29:36 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

module DLL1X (CLKIN, ECLK, SCLK, GSR, PUR, LOCK);
   // The duty cycle is passed as a percentage
   parameter DIV0=1, DISABLED_GSR=0, dutycycle=50.0;  

`define  jitter 2.0
`define  acq_tm 5

   input     CLKIN;
   input     GSR, PUR;
   output    ECLK, SCLK, LOCK;

   buf       (CLKINb, CLKIN);

   wire      CLKIN;
   wire      GSR, PUR;
   wire      ECLK, SCLK, LOCK;

   integer   duty;
   integer   clkin_count, good_count;
   
   reg 	     EclkReg, SclkReg, LockReg;
   reg [3:0] Div0Reg;

   realtime  d;
   realtime  cycle_last, cycle_now, last_posedge;

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

   buf U1 (LOCK, LockReg);
   buf U2 (ECLK, EclkReg);
   buf U3 (SCLK, SclkReg);

   initial
     begin
	LockReg = 1'b0;
	EclkReg = 1'b0;
	SclkReg = 1'b0;
        cycle_last = 5.0;
        clkin_count = 0;
   
        duty=((32.0*dutycycle)/100.0);
        if(duty < 1 || duty > 31)
	  begin
             $display("ERROR: DLL1X - dutycycle = %4.3f", dutycycle);
             $display("ERROR: The Delay Tap must be between 1 and 31: %f", duty);
	     $finish;
	  end // if (duty < 0 || duty > 30)

        if(DIV0 < 1 || DIV0 > 8) // DIV0 may be bad
          begin
             if (DIV0 == 0)
               Div0Reg = 1;
             else
               begin
                  $display("ERROR: DLL1X - DIV0 is not valid: %0d", DIV0);
                  $finish;
               end
          end // if (DIV0 < 1 || DIV0 > 8)
	else // DIV0 is good
	  Div0Reg = DIV0;
     end
   
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
	  end // else: !if(SR)
     end // always @ (SR)

   always @(posedge CLKINb) 
     begin: cycle
	cycle_now = $realtime - last_posedge;
	last_posedge = $realtime; // save this time until the next edge

	clkin_count = ((clkin_count + 1) % (Div0Reg));
	if (clkin_count == 0) // pos edge of divided clock
	  begin: create_clocks
	     cycle_now = cycle_now * Div0Reg; // slow cycle
	     
	     // if the cycle time is constant, then lock the PCM after acq_tm cycles
	     if ((cycle_now < cycle_last + `jitter ) && (cycle_now > cycle_last - `jitter ))
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

	     d = (cycle_now * duty) / 32.0;
	     
	     EclkReg = 1'b1;
	     SclkReg = 1'b1;

	  end // block: create_clocks
     end // block: cycle
   
   always @(posedge SclkReg)
     #d begin
	EclkReg = 1'b0;
	SclkReg = 1'b0;
     end 

endmodule
