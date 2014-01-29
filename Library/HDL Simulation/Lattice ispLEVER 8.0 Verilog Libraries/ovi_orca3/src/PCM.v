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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca3/RCS/PCM.v,v 1.19 2005/05/19 18:30:48 pradeep Exp $ 
//
//****************************************************************
// PROGRAMMABLE CLOCK MODULE
//****************************************************************
// 
// The data book includes 'clkin_pic' and 'clkin_rn' inputs.  These 
// are mutually exclusive clock inputs which are combined here into 
// a single 'CLKIN'.
// 
// In a like manner, 'fb_eclk' and 'fb_rn' are mutually exclusive 
// feedback signals
// 
// NOTE: in DLL modes, the freq of 'SCLK' is equal to the freq of
// 'ECLK'
// 
// NOTE: in PLL mode, the freq of 'SCLK' is equal to DIV2 times the
// freq of 'ECLK'
//   
// 'WE' is the write enable input to the PCM.  Asserted it allows 
// the user to write 'DI' to the register at 'A'.
// 
// 'RE' is the read enable input to the PCM.  Asserted it allows the
// user to read 'DO' from the register at 'A'.  When low,
// 'DO' is HiZ.
// 
// 'LOCK' is high when the PCM is phase locked.
// 
// 'A', 'DI' and 'DO' allow reading and writing to the eight 
// configuration registers that affect the mode of the PCM.   
// 
//****************************************************************

`resetall
`timescale 1 ns / 1 ps

module PCM (CLKIN, FB, WE, RE, A,
            GSR, PUR,
            DI, DO, 
	    ECLK, SCLK, LOCK
	    );
   parameter PCM="PCMBUF", FREQUENCY=10.0, DUTY=50.0,
	     PDELAY=1, DIV0=0, DIV1=0, DIV2=0, DISABLED_GSR=0,
             DISABLED_DONE=0, PWRON=1, FBDELAY=0.000;

// MODE VALUES
`define buf 0
`define d1x 1

`define dpd 3
`define pll 4
`define unk 9
   
`define jitter 2.0
`define acq_tm 4

   output    ECLK, SCLK, LOCK;
   output [7:0] DO; 

   input  [7:0] DI;
   input     CLKIN, FB, WE, RE, A;
   input     GSR, PUR;

   // EXTERNAL DATA TYPES
   wire 	CLKIN, FB, WE, RE, LOCK;
   wire 	ECLK, SCLK; 
   wire [2:0] 	A;
   wire [7:0] 	DI, DO;
   wire 	GSR, PUR;

   // INTERNAL DATA TYPES
   // Since we need to look at multiple registers simultaneously, it's 
   // better to use individual registers than a memory array.
   reg [ 7: 0]  ConfigReg0, ConfigReg1, ConfigReg2, ConfigReg3;
   reg [ 7: 0]  ConfigReg4, ConfigReg5, ConfigReg6, ConfigReg7;
   reg [ 7: 0] 	DOreg; // holds output data

   // The following hold the properties and are changable.
   reg [ 3: 0] 	Div0Reg, Div1Reg, Div2Reg ;
   reg [ 3: 0] 	Mode;
   reg 		EclkReg, SclkReg, LockReg;
   reg [ 7: 0]	PDEL_ ; 

   integer 	mult_factor;
   integer 	clkin_count;
   integer 	sclk_count;
   integer 	fb_count;
   integer 	good_count, err_count;
   integer 	rpt_val;
   integer 	Duty_1;

   realtime 	last_clock, last_fb;
   realtime 	Clkin_cycle, PDclkin_cycle, PDclkin_edge;
   realtime     Fb_cycle, Compare_cycle, start_delay;
   realtime 	phase_diff;
   realtime 	dsclk, dsclk2, declk;
   
   reg 		SR;
   
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

   bufif1 (DO[0], DOreg[0], RE);
   bufif1 (DO[1], DOreg[1], RE);
   bufif1 (DO[2], DOreg[2], RE);
   bufif1 (DO[3], DOreg[3], RE);
   bufif1 (DO[4], DOreg[4], RE);
   bufif1 (DO[5], DOreg[5], RE);
   bufif1 (DO[6], DOreg[6], RE);
   bufif1 (DO[7], DOreg[7], RE);

   //buf #start_delay U1 (SCLK, SclkReg);
   //buf #start_delay U2 (ECLK, EclkReg);
   buf U1 (SCLK, SclkReg);
   buf U2 (ECLK, EclkReg);
   buf (LOCK, LockReg);
   

//****************************************************************
// PROPERTIES AND THEIR DATA TYPES (FROM CAPTURE except FBDELAY)
//****************************************************************
// 
//  property PCM         {PCMBUF,DLL1X,DLL2X,DLLPD,PLL};
//  property FREQUENCY   is numeric;          
//  property DUTY        is numeric;          
//  property PDELAY      is numeric;          
//  property DIV0        is numeric;          
//  property DIV1        is numeric;          
//  property DIV2        is numeric;          
// 
//  property DISABLED_GSR     {DISABLED, ENABLED};
//  property DISABLED_DONE    {ENABLED, DISABLED};
//  property PWRON       {ON, OFF};
//  
//  property FBDELAY     is numeric;
// 
//****************************************************************
// MODE TO REGISTER MAPPING, PROPERTY TO REGISTER MAPPING
//****************************************************************
// 
// Mode = DLL1X      R5[4]=1, R5[2]=1, R5[0]=0,
//                    R6[7:6]=1, R6[5:4]=1,
//                    R4[7:0]
// Mode = DLL2X      R5[4]=0, R5[2]=1, R5[0]=0,
//  DLL2X is no       R6[7:6]=1, R6[5:4]=1,
//  longer valid      R3[7:0]
// Mode = DLLPD      R5[4]=0, R5[2]=1, R5[0]=0,
//                    R6[7:6]=2, R6[5:4]=2 or 3,
//                    R4[7:0],
//                   if R6[5:4] is 3, ECLK uses R2[3:0]
// Mode = PCMBUF     R5[4]=1, R5[2]=1, R5[0]=0,
//                    R0[3:0] = R1[3:0] = R2[3:0] = 0
// Mode = PLL        R5[4]=0, R5[2]=0, R5[0]=1,
//                    R0[3:0], R1[3:0], R2[3:0],
//                    R4[7:0]
// 
// FREQUENCY (PCM=PLL)
//     The FREQUENCY property is not used - 
//       when needed, R4 defaults to ~50 MHz on 3C = 00000111
//     5.0 to 100.0  R4[7:0]
// 
// DUTY (PCM=DLL2X)
//      0% to <50%   R3[7] = 0
//                   R3[5:3] = 0 to 7 DUTY
//     50% to <100%  R3[7] = 1
//                   R3[5:3] = 0 to 6 DUTY
// 
// DUTY (PCM=DLL1X)
//      0% to <25%   R4[7:6] = 0
//                   R4[5:3] = XXX
//                   R4[2:0] = 0 to 7
//     25% to <50%   R4[7:6] = 1
//                   R4[5:3] = XXX
//                   R4[2:0] = 0 to 7
//     50% to <75%   R4[7:6] = 2
//                   R4[5:3] = 0 to 7
//                   R4[2:0] = XXX
//     75% to <100%  R4[7:6] = 3
//                   R4[5:3] = 0 to 6
//                   R4[2:0] = XXX
// 
// PDELAY  1 to 31   R4[7:0] (same as DUTY above)
//       	       
// DIV0    1 to 8    R0[3:0]
// DIV1    1 to 8    R1[3:0]
// DIV2    1 to 8    R2[3:0]
// 
// DISABLED_GSR  0 or 1   R7[7]
// DISABLED_DONE 1 or 0   R7[6]
// PWRON   1 or 0    R7[0]
// 
// DIV0RES 0 or 1    R0[7]
// DIV1RES 0 or 1    R0[7]
// DIV2RES 0 or 1    R0[7]
// DLLRES  0 or 1    R7[2]
// PCMRES  0 or 1    R7[1]
// 
//****************************************************************
// REGISTER CONTENTS
//****************************************************************
// 
//  '-'     Supported by current or proposed properties
//  'R0'    Reserved, always zero (not programmable)
//  '0|1'   Always programmed to this value at startup
//  P1|P2   depend on BS_NOD_* values
// 
//    BITS:  7   6   5   4   3   2   1   0
// PCMREG0   0   R0  R0  R0  -   -   -   -  DIV0RESET(7), DIV0(3:0)
// PCMREG1   0   R0  R0  R0  -   -   -   -  DIV1RESET(7), DIV1(3:0)
// PCMREG2   0   R0  R0  R0  -   -   -   -  DIV2RESET(7), DIV2(3:0)
// PCMREG3   -   -   -   -   -   -   -   -  DUTY(7,5:3) & DUTY2(6,2:0) for DLL2X (VOID)
// PCMREG4   -   -   -   -   -   -   -   -  DUTY(7:0) for DLL1X, DLLPD
// PCMREG5   R0  R0  R0  -   R0  -   R0  -  1X/2X(4), FB(2), DLL/PLL(0)
// PCMREG6   -   -   -   -   -   -   -   -  SCLKOUT(7:6), ECLKOUT(5:4), FB(3:2), In(1:0)
// PCMREG7   -   -   R0  R0  R0  0   0   1  DISABLED_GSR(7), DISABLED_DONE(6), DLLRES(2), 
//                                          PCMRES(1), PWRON(0)
//****************************************************************
   
   // FUNCTION: Ensure that DIV register has a valid value
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
   
   // FUNCTION: Convert a PDELAY to a register value
   function [7:0] convert_delay;
      input [7:0] Pdelay;
      
      begin
	 if(Pdelay < 1 || Pdelay > 31)
	   begin
	      $display("ERROR: DLLPD - Delay Tap is not valid: %d", PDELAY);
	      $finish;
	   end // if (PDELAY < 1 || PDELAY >= 31)
	 else

	 if (Pdelay < 1)
	   convert_delay = 8'b00_000_000;
	 else if (Pdelay < 9)
	   convert_delay = (Pdelay - 1);
	 else if (Pdelay < 17)
	   convert_delay = 8'h40 | (Pdelay - 1);
	 else if (Pdelay < 25)
	   convert_delay = 8'h80 | ((Pdelay - 1) << 3);
	 else if (Pdelay < 32)
	   convert_delay = 8'hC0 | ((Pdelay - 1) << 3);
	 else
	   convert_delay = 8'b00_000_000;
      end
   endfunction // convert_delay

   // FUNCTION: Convert a duty cycle in percent to a register value
   function [7:0] get_duty1;
      input DutyCycle1;

      real  DutyCycle1;

      begin
	 if (DutyCycle1 < (100.0/64.0))
	   get_duty1 = 8'b00_000_000;
	 else if (DutyCycle1 < (1600.0/64.0))
	   get_duty1 = (DutyCycle1 * 32.0 / 100.0);
	 else if (DutyCycle1 < (3200.0/64.0))
           begin
	      get_duty1 = (((DutyCycle1 - 25.0) * 32.0 / 100.0) - 1.0);
	      get_duty1 = 8'h40 | get_duty1;
	   end
	 else if (DutyCycle1 < (4800.0/64.0))
           begin
	      get_duty1 = (((DutyCycle1 - 50.0) * 32.0 / 100.0) - 1.0) ;
	      get_duty1 = 8'h80 | (get_duty1 << 3);
	   end
	 else if (DutyCycle1 < (6300.0/64.0))
           begin
	      get_duty1 = (((DutyCycle1 - 75.0) * 32.0 / 100.0) - 1.0);
	      get_duty1 = 8'hB0 | (get_duty1 << 3);
	   end
	 else
	   get_duty1 = 8'b00_000_000;
      end
   endfunction // get_duty1
   

//    // FUNCTION: Convert two duty cycles in percent to a register value
//    function [7:0] get_duty2;
//       input DutyCycle1; // The duty cycle in percent
//       input DutyCycle2; // The duty cycle in percent
// 
//       real  DutyCycle1;
//       real  DutyCycle2;
// 
//       begin
// 	 if (DutyCycle1 < (100.0/32.0))
// 	     get_duty2 = 8'b10111000 & get_duty2; // reset DutyCycle1
// 	 else if (DutyCycle1 < (1600.0/32.0)) 
// 	   begin
// 	      get_duty2[6] = 1'b0;
// 	      get_duty2[2:0] = ((DutyCycle1 * 16.0 / 100.0) - 1.0);
// 	   end // if (DutyCycle1 < 46.875)
// 	 else if (DutyCycle1 < (3100.0/32.0))
// 	   begin
// 	      get_duty2[6] = 1'b1;
// 	      get_duty2[2:0] = (((DutyCycle1 - 50.0) * 16.0 / 100.0) - 1.0);
// 	   end // if (DutyCycle1 < 96.875)
// 	 else
// 	   get_duty2 = 8'b10111000 & get_duty2; // reset DutyCycle1
// 
// 	 if (DutyCycle2 < (100.0/32.0))
// 	   get_duty2 = 8'b01000111 & get_duty2; // reset DutyCycle2
// 	 else if (DutyCycle2 < (1600.0/32.0)) 
// 	   begin
// 	      get_duty2[7] = 1'b0;
// 	      get_duty2[5:3] = ((DutyCycle2 * 16.0 / 100.0) - 1.0);
// 	   end // if (DutyCycle2 < 46.875)
// 	 else if (DutyCycle2 < (3100.0/32.0))
// 	   begin
// 	      get_duty2[7] = 1'b1;
// 	      get_duty2[5:3] = (((DutyCycle2 - 50.0) * 16.0 / 100.0) - 1.0);
// 	   end // if (DutyCycle2 < 96.875)
// 	 else
// 	   get_duty2 = 8'b01000111 & get_duty2; // reset DUTY2
//       end
// 		 
//    endfunction // get_duty2

   // TASK: Reinitialize the PCM to initial conditions
   task reinit;
      begin
	 EclkReg = 1'b0;
	 SclkReg = 1'b0;
	 LockReg = 1'b0;
	 good_count = 0;
	 err_count = 0;
	 clkin_count = 1;
         fb_count = 1;
         sclk_count = 0;
         rpt_val = 1;
         Compare_cycle = 5.0;
         phase_diff = 0.0;
      end
   endtask // reinit

   initial
     begin: start_up
	Div0Reg = check_value(0, DIV0);
        ConfigReg0 = Div0Reg;
	Div1Reg = check_value(1, DIV1);
        ConfigReg1 = Div1Reg;
	Div2Reg = check_value(2, DIV2);
        ConfigReg2 = Div2Reg;

        reinit;

	// default start_delay is zero
	start_delay = 0.0;
	dsclk = 12.5; // start sclk at 40 MHz (this is an arbitrary value)
        declk = dsclk * Div2Reg;  // eclk always is Sclk/DIV2
        dsclk2 = dsclk;

        // Sclk freq is PDet freq times 'mult_factor'
	mult_factor = 1;
        if (Mode == `pll) // initially assume Eclk feedback for PLL Mode
	  mult_factor = Div1Reg * Div2Reg;

        PDEL_  = PDELAY;
      
        ConfigReg7 = 8'h00 + (PWRON + (DISABLED_DONE * 64) + (DISABLED_GSR *128));

	// default mode is unknown: `unk
        Mode = `unk;
	
        // define the time format for displaying time values
	$timeformat(-9, 3, "ns", 8);

	if (PCM == "PCMBUF")
	  begin
             Mode = `buf;
	     // PROGRAM REGISTERS
             // ConfigReg0, ConfigReg1 and ConfigReg2 are already programmed
	     ConfigReg3 = 8'b0_0_000_000; // not used in this mode

             ConfigReg4 = 8'b00_000_111; // arbitrary frequency setting

             //      DLL2X   RRR_0_R_0_R_0
      	     ConfigReg5 = 8'b000_0_0_0_0_0;

             ConfigReg6 = 8'b00_00_00_01;
	     
	     // ConfigReg7 already programmed
	  end //

        if (PCM == "DLL1X")
          begin
             Mode = `d1x;
	     // PROGRAM REGISTERS
             // ConfigReg0, ConfigReg1 and ConfigReg2 are already programmed
	     ConfigReg3 = 8'b0_0_000_000; // not used in this mode

             ConfigReg4 = get_duty1(DUTY);
	     // ...0.1.0/010101.. = DLL1X S
	     // ...0.1.0/010100.. = DLL1X E

	     if (ConfigReg4[7])
	       Duty_1 = (ConfigReg4[5:3] + 1) + (ConfigReg4[7:6] * 8);
	     else
	       Duty_1 = (ConfigReg4[2:0] + 1) | (ConfigReg4[7:6] * 8);

	     ConfigReg5 = 8'b000_1_0_1_0_0;

	     ConfigReg6 = 8'b01_01_00_01; // default to CLK_IN_PIC

	     // ConfigReg7 already programmed
	  end

//	if (PCM == "DLL2X")
//	  begin
//             Mode = `d2x;
//	     // PROGRAM REGISTERS
//             // ConfigReg0, ConfigReg1 and ConfigReg2 are already programmed
//
//             ConfigReg3 = get_duty2(DUTY, DUTY2);
//	     
//	     Duty_1 = (ConfigReg3[2:0] + 1) + (ConfigReg3[6] * 8);
//	     Duty_2 = (ConfigReg3[5:3] + 1) + (ConfigReg3[7] * 8);
//
//             ConfigReg4 = 8'b00_000_111; // arbitrary frequency setting
//
//	     // ...1.1.0/010101.. = DLL2X S
//	     // ...1.1.0/010100.. = DLL2X E
//	     ConfigReg5 = 8'b000_0_0_1_0_0;
//
//	     ConfigReg6 = 8'b01_01_00_01; // default to CLK_IN_PIC
//
//	     // ConfigReg7 already programmed
//	  end
//
	if (PCM == "DLLPD")
	  begin
             Mode = `dpd;
	     // PROGRAM REGISTERS
             // ConfigReg0, ConfigReg1 and ConfigReg2 are already programmed

             ConfigReg3 = 8'b00_000_000;

             ConfigReg4 = convert_delay(PDEL_);

	     if (ConfigReg4[7])
	       PDEL_ = ConfigReg4[7:4] + 8'h01;
	     else
	       PDEL_ = (ConfigReg4[2:0] + (ConfigReg4[6] << 3) + 8'h01);

	     // ...0.1.0/101001.. = DLLPD S
	     // ...0.1.0/101000.. = DLLPD E
	     // ...0.1.0/101101.. = DLLPD S with DIV2
	     // ...0.1.0/101100.. = DLLPD E with DIV2
	     ConfigReg5 = 8'b000_0_0_1_0_0;

	     // If DIV2 is greater than 1, then it is used for DLLPD
             if (Div2Reg < 2) // no DIV2
	       ConfigReg6 = 8'b10_10_00_01; // default to CLK_IN_PIC
	     else // DIV2
	       ConfigReg6 = 8'b10_11_00_01; // default to CLK_IN_PIC

	     // ConfigReg7 already programmed
	  end

	if (PCM == "PLL")
	  begin
             Mode = `pll;
	     // PROGRAM REGISTERS
             // ConfigReg0, ConfigReg1 and ConfigReg2 are already programmed

             ConfigReg3 = 8'b00_000_000;

             ConfigReg4 = 8'b00_000_111; // arbitrary frequency setting
	     
	     // ...0.0.1/101101.. = PLL S (uses reg4 - frequency) with DIV2
	     // ...0.0.1/101100.. = PLL E (uses reg4 - frequency) With DIV2
	     // ...0.0.1/101001.. = PLL S (uses reg4 - frequency)
	     // ...0.0.1/101000.. = PLL E (uses reg4 - frequency)
	     ConfigReg5 = 8'b000_0_0_0_0_1;

	     // If DIV2 is greater than 1, then it is used for DLLPD
             if (Div2Reg < 2) // no DIV2
	       ConfigReg6 = 8'b10_10_00_01; // default to CLK_IN_PIC
	     else // DIV2
	       ConfigReg6 = 8'b10_11_00_01; // default to CLK_IN_PIC

	     // ConfigReg7 already programmed             
	  end
     end // block: start_up
   
   always @(WE or A or DI)
     begin
       if (WE == 1'b1)
	 begin
            //if (RE == 1'b1)
	    //$display("WARNING: WE and RE overlap at %t", $realtime);
	    casez (A)
	      3'h0: ConfigReg0 = DI;
	      3'h1: ConfigReg1 = DI;
	      3'h2: ConfigReg2 = DI;
	      3'h3: ConfigReg3 = DI;
	      3'h4: ConfigReg4 = DI;
	      3'h5: ConfigReg5 = DI;
              3'h6: ConfigReg6[7:4] = DI[7:4];
	      3'h7: ConfigReg7 = DI;
              3'b00?:
		begin
		   ConfigReg0 = 8'hXX;
		   ConfigReg1 = 8'hXX;
		end // case: 3'b00?
	      3'b0?0:
		begin
		   ConfigReg0 = 8'hXX;
		   ConfigReg2 = 8'hXX;
		end // case: 3'b0?0
	      3'b?00:
		begin
		   ConfigReg0 = 8'hXX;
		   ConfigReg4 = 8'hXX;
		end // case: 3'b?00
	      3'b0??:
		begin
		   ConfigReg0 = 8'hXX;
		   ConfigReg1 = 8'hXX;
		   ConfigReg2 = 8'hXX;
		   ConfigReg3 = 8'hXX;
		end // case: 3'b0??
	      3'b?0?:
		begin
		   ConfigReg0 = 8'hXX;
		   ConfigReg1 = 8'hXX;
		   ConfigReg4 = 8'hXX;
		   ConfigReg5 = 8'hXX;
		end // case: 3'b?0?
	      3'b??0:
		begin
		   ConfigReg0 = 8'hXX;
		   ConfigReg2 = 8'hXX;
		   ConfigReg4 = 8'hXX;
		   ConfigReg6 = 8'hXX;
		end // case: 3'b?0?
	      default:
		begin
		   ConfigReg0 = 8'hXX;
		   ConfigReg1 = 8'hXX;
		   ConfigReg2 = 8'hXX;
		   ConfigReg3 = 8'hXX;
		   ConfigReg4 = 8'hXX;
		   ConfigReg5 = 8'hXX;
		   ConfigReg6 = 8'hXX;
		   ConfigReg7 = 8'hXX;
		end // case: default
	    endcase // case(A)
	 end // if (WE = 1'b1)
     end // always @ (WE or A or DI)
   
   always @(RE or A)
     begin
	//if (WE == 1'b1)
	  //$display("WARNING: WE and RE overlap at %t", $realtime);
	if(RE == 1'b1)
	  begin
	     case (A)
	       3'h0: DOreg = ConfigReg0;
	       3'h1: DOreg = ConfigReg1;
	       3'h2: DOreg = ConfigReg2;
	       3'h3: DOreg = ConfigReg3;
	       3'h4: DOreg = ConfigReg4;
	       3'h5: DOreg = ConfigReg5;
	       3'h6: DOreg = ConfigReg6;
	       3'h7: DOreg = ConfigReg7;
	       default:	DOreg = 8'hXX;
	     endcase // case(A)
	  end // if (RE == 1'b1)
	else
	  DOreg = 8'hZZ;
     end // always @ (RE or A)
   
   always @(ConfigReg0)
     begin
	if (ConfigReg0[7] == 1'b1)
	  begin
	     // DIV0 Registers Reset - output clock frozen
	     deassign SclkReg;
	     assign SclkReg = 1'b0; // freeze Sclk
	  end
        else if (ConfigReg0[3:0] == 4'h0)
	  begin
	     deassign SclkReg;
	     Div0Reg = 4'h1;
             if (Mode != `buf)
	       reinit;
	  end
        else if (ConfigReg0[3:0] > 4'h8)
	  begin
	     deassign SclkReg;
	     Div0Reg = ConfigReg0[3:0] - 4'h8;
             if (Mode != `buf)
	       reinit;
	  end
	else
	  begin
	     deassign SclkReg;
	     Div0Reg = ConfigReg0[3:0];
             if (Mode != `buf)
	       reinit;
	  end
     end // always @ (ConfigReg0)

   always @(ConfigReg1)
     begin
	if (ConfigReg1[7] == 1'b1)
	  begin
	     // DIV0 Registers Reset - output clock frozen
	     deassign SclkReg;
	     assign SclkReg = 1'b0; // freeze Sclk
	  end
        else if (ConfigReg1[3:0] == 4'h0)
	  begin
	     deassign SclkReg;
	     Div1Reg = 4'h1;
             if (Mode == `pll)
	       reinit;
	  end
        else if (ConfigReg1[3:0] > 4'h8)
	  begin
	     deassign SclkReg;
	     Div1Reg = ConfigReg1[3:0] - 4'h8;
             if (Mode == `pll)
	       reinit;
	  end
	else
	  begin
	     deassign SclkReg;
	     Div1Reg = ConfigReg1[3:0];
             if (Mode == `pll)
	       reinit;
	  end
	if (Mode == `pll)
	  mult_factor = Div1Reg * Div2Reg;
     end // always @ (ConfigReg1)

   always @(ConfigReg2)
     begin
	if (ConfigReg2[7] == 1'b1)
	  begin
	     // DIV0 Registers Reset - output clock frozen
	     deassign SclkReg;
	     assign SclkReg = 1'b0; // freeze Sclk
	  end
        else if (ConfigReg2[3:0] == 4'h0)
	  begin
	     deassign SclkReg;
	     Div2Reg = 4'h1;
             if ((Mode == `pll) | (Mode == `dpd))
	       reinit;
	  end
        else if (ConfigReg2[3:0] > 4'h8)
	  begin
	     deassign SclkReg;
	     Div2Reg = ConfigReg2[3:0] - 4'h8;
             if ((Mode == `pll) | (Mode == `dpd))
	       reinit;
	  end
	else
	  begin
	     deassign SclkReg;
	     Div2Reg = ConfigReg2[3:0];
             if ((Mode == `pll) | (Mode == `dpd))
	       reinit;
	  end
	if (Mode == `pll)
	  mult_factor = Div1Reg * Div2Reg;
     end // always @ (ConfigReg2)

   // A quick summary of R5 & R6 programming:
        //  REG5     REG6
        // ...0.0.0/00000001 = PCMBUF
	// ...0.1.0/01010001 = VOID: DLL2X E (uses reg3 - duty cycle)
	// ...0.1.0/01010101 = VOID: DLL2X S (uses reg3 - duty cycle)
        // ...1.1.0/01010001 = DLL1X E (uses reg4 - duty cycle)
        // ...1.1.0/01010101 = DLL1X S (uses reg4 - duty cycle)
	// ...0.1.0/10100001 = DLLPD E (uses reg4 - phase)
	// ...0.1.0/10100101 = DLLPD S (uses reg4 - phase)
	// ...0.1.0/10110001 = DLLPD E with DIV2 (uses reg4 - phase)
	// ...0.1.0/10110101 = DLLPD S with DIV2 (uses reg4 - phase)
	// ...0.0.1/10110001 = PLL E (uses reg4 - frequency) With DIV2
	// ...0.0.1/10110101 = PLL S (uses reg4 - frequency) with DIV2
	// ...0.0.1/10100001 = PLL E (uses reg4 - frequency)
	// ...0.0.1/10100101 = PLL S (uses reg4 - frequency)

   always @(ConfigReg3)
     begin // NOT NEEDED - NO DLL2X MODE
	   // if (Mode == `d2x)
	   //   begin
	   //     Duty_1 = (ConfigReg3[2:0] + 1) + (ConfigReg3[6] * 8);
	   //     Duty_2 = (ConfigReg3[5:3] + 1) + (ConfigReg3[7] * 8);
           //     reinit;
	   //   end
     end   // always @ (ConfigReg3)

   always @(ConfigReg4)
     begin
`ifdef DEBUG
	$display("REG4 changed: %2b %3b %3b", 
		 ConfigReg4[7:6], ConfigReg4[5:3], ConfigReg4[2:0]);
`endif
	if (Mode == `d1x)
	  begin
	     if (ConfigReg4[7])
	       Duty_1 = (ConfigReg4[5:3] + 1) + (ConfigReg4[7:6] * 8);
	     else
	       Duty_1 = (ConfigReg4[2:0] + 1) | (ConfigReg4[7:6] * 8);
             reinit;
	  end // if (Mode == `d1x)
	else if (Mode == `dpd)
	  begin
	     if (ConfigReg4[7])
	       PDEL_ = ConfigReg4[7:4] + 8'h01;
	     else
	       PDEL_ = (ConfigReg4[2:0] + (ConfigReg4[6] << 3) + 8'h01);
             reinit;
	  end
     end

   always @(ConfigReg5)
     begin
        if (!ConfigReg5[2] && ConfigReg5[0])
		Mode = `pll;
        else if (ConfigReg5[4] && ConfigReg5[2] && !ConfigReg5[0])
	        Mode = `d1x;
	else if (!ConfigReg5[4] && ConfigReg5[2] && !ConfigReg5[0])

	     if (ConfigReg6[7:4] == 4'h0) // DLL1X (not DLL2X)

		    Mode = `buf; // bit 4 is 1 for dll1x

		  else if (ConfigReg6[7:4] == 4'b101x)

                    Mode = `dpd;
	else
	  Mode = `unk;
        reinit;
     end // always @ (ConfigReg5)

   always @(ConfigReg6)
     begin
        if (ConfigReg6[7:6] == 2'b0)
	  Mode = `buf;
	else if (ConfigReg6[7:6] == 2'b01)
	  begin
	     if (!ConfigReg5[4] && ConfigReg5[2])
	       Mode = `unk; // d2x mode is not allowed.
	     else if (ConfigReg5[4] && ConfigReg5[2] && !ConfigReg5[0])
	       Mode = `d1x;
	  end
	else if (ConfigReg6[7:6] == 2'b10)
	  begin
	     if (!ConfigReg5[4] && ConfigReg5[2])
	       Mode = `dpd;
	     else if (!ConfigReg5[4] && !ConfigReg5[2])
	       Mode = `pll;
	  end // if (ConfigReg6[7:6] == 2'b10)
	else
	  Mode = `unk;
	reinit;
     end

   always @(ConfigReg7)
     begin // CMBLRS                     PCM_RES                    PWR_ON
	if ((ConfigReg7[2] == 1'b1) && (ConfigReg7[1] == 1'b1) && (ConfigReg7[0] == 1'b0))
	  begin
	     deassign SclkReg;
	     assign SclkReg = 1'b0;
	     deassign LockReg;
	     assign LockReg = 1'b0;
	  end
	else
	  begin
	     deassign SclkReg;
	     deassign LockReg;
	     reinit;
	  end
     end // always @ (ConfigReg7)

   always @(SR)
     begin
        if (SR)
	  begin
	     clkin_count = 0;
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
             deassign LockReg;
             SclkReg <= 1'b1;
             mult_factor = 1;
             if (Mode == `pll)
	       mult_factor = Div1Reg * Div2Reg;
             Clkin_cycle = 5.0;
	     Fb_cycle = 5.0;
	     last_clock = $realtime - 5.0;
	     last_fb = $realtime - 5.0;
	     phase_diff = 0.0;
             clkin_count = 0;
	     fb_count = 0;
	     sclk_count = 0;
	     err_count = 0;
	  end // else: !if(SR)
     end // always @ (SR)

   always @(posedge CLKIN)
     begin
        if (Mode == `buf)
	  begin
	     EclkReg = 1'b1;
	     SclkReg = 1'b1;
	     LockReg = 1'b1;
	  end
	else if ((Mode == `d1x) || (Mode == `dpd) || (Mode == `pll))
	  begin
	     Clkin_cycle = $realtime - last_clock;
	     last_clock = $realtime;

	     if (clkin_count == 0) // This is one PDet cycle
	       begin: create_sclk
                  PDclkin_cycle = Clkin_cycle * Div0Reg; // cycle time at phase detector

		  PDclkin_edge = last_clock; // used for `pll only

		  if ((PDclkin_cycle < Compare_cycle + `jitter) && (PDclkin_cycle > Compare_cycle - `jitter))
		    begin: equal_cycles
		       good_count = good_count + 1;
		       if (good_count > `acq_tm)
			 begin
			    good_count = `acq_tm;
			 end
		       else if (good_count == `acq_tm)
			 begin
			    LockReg = 1'b1;
			    err_count = 1'b0;
`ifdef DEBUG
			    $display("The Locked Values of [freq, cycle, PD1, dsclk, declk]");
			    $display("LOCK: %f %t %t %f %f (%t)", `frequency, Clkin_cycle, 
				     PDclkin_cycle, dsclk, declk, $realtime);
`endif
			 end
		    end
		  else
		    begin: not_equal_cycles
		       LockReg = 1'b0;
                       good_count = 0;
		       err_count = err_count + 1;
		       if ((Mode == `pll) && (err_count == 7)) // switch the feedback
			 begin
			    mult_factor = mult_factor * (Compare_cycle / PDclkin_cycle);
			    clkin_count = 1; // synchronize the counters
			    fb_count = 1;
			    sclk_count = 0;
			    Compare_cycle = PDclkin_cycle;
			 end // pl 
		       if ((Mode == `pll) && (err_count == 17)) // switch the feedback
			 begin
			    mult_factor = mult_factor * (Compare_cycle / PDclkin_cycle);
			    clkin_count = 1; // synchronize the counters
			    fb_count = 1;
			    sclk_count = 0;
			    Compare_cycle = PDclkin_cycle;
			 end // pl 
		       if ((Mode == `pll) && (err_count == 37)) // switch the feedback
			 begin
			    mult_factor = mult_factor * (Compare_cycle / PDclkin_cycle);
			    clkin_count = 1; // synchronize the counters
			    fb_count = 1;
			    sclk_count = 0;
			    Compare_cycle = PDclkin_cycle;
			 end // pl 
		       if (err_count == 53)
			 begin
			    $display("ERROR: no lock achieved in %0d cycles", 53);
			    $finish;
			 end
		    end

		  if (Mode != `pll)
		    Compare_cycle = PDclkin_cycle; // set up for the next clock cycle

                  if (Mode == `d1x)
		    begin
		       dsclk  = (PDclkin_cycle * Duty_1) / 32.0;  // Positive PW
		       dsclk2 =  PDclkin_cycle - dsclk;      // Negative PW
                       declk  = dsclk * Div2Reg;
		    end
		  else if ((Mode == `dpd) || (Mode == `pll))
		    begin
		       dsclk = PDclkin_cycle / (2 * mult_factor); // mult_factor is one except PLL
                       dsclk2 = dsclk;
                       declk = dsclk * Div2Reg;
		       if (Mode == `dpd)
			 start_delay = (PDclkin_cycle * PDELAY / 32.0); // portion of PDcyc cycle
		    end
	       end // block: create_sclk
	     clkin_count = ((clkin_count + 1) % Div0Reg);
	  end
	else
	  begin
	     $display("ERROR: Invalid mode: %0d.", Mode);
	  end
     end // always @ (posedge CLKIN)
   
   always @(negedge CLKIN)
     begin
        if (Mode == `buf) 
	  begin
	     EclkReg = 1'b0;
	     SclkReg = 1'b0;
	  end
     end

   always @(posedge SclkReg)
     begin 
        if (Mode != `buf) 
	  begin
	     sclk_count = ((sclk_count + 1) % Div2Reg);
	     if (sclk_count == 0)
	       EclkReg = 1'b1;         // start the cycle
	     #dsclk SclkReg = 1'b0;
	  end // if (Mode == `d1x)
     end // always @ (posedge SclkReg)
	
   always @(negedge SclkReg)
     begin
	if ((Mode == `d1x) || (Mode == `dpd) || (Mode == `pll))
	  #dsclk2 SclkReg = 1'b1;  // pulse width adjustment
     end
   
   always @(posedge EclkReg)
     begin
        if ((Mode == `d1x) || (Mode == `dpd) || (Mode == `pll))
	  #declk EclkReg = 1'b0;  // pulse width adjustment
     end

   always @(posedge FB)
     begin: create_PD2sig
        if (Mode == `pll)
	  begin
	     // determine the FB cycle time
	     Fb_cycle = $realtime - last_fb;
	     last_fb = $realtime;

	     // The input to the phase detector only occurs every Div1Reg'th time.
	     if (fb_count == 0)  // pos edge PD2 input
	       begin: PD2_input
		  Compare_cycle = Fb_cycle * Div1Reg;
		  phase_diff = $realtime - PDclkin_edge;
		  
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
	  end // if (Mode == `pll)
     end // block: create_PD2sig

endmodule // pcm
