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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/SYN3RAM.v,v 1.3 2005/05/19 19:02:16 pradeep Exp $ 
//
// LUCENT TECHNOLOGIES ORCA VERILOG LIBRARY
// Release 9.2  -  Created December 27, 1997 
//*****************************************
// Mod History
// Revision: Date:         Author: Description:
// 1.0       Dec 1997      swt     original model
// 1.1       Jan 1998      swt     initialize rams to zero or param
//*****************************************
/* 
   Verilog model for ORCA's synchronous memory dual port RAM.

   This model is originally from ASIC Verilog library and modified to
   make it asynchronous Read ALWAYS.

   BRAM equivalent for Verilog. This model is for BRAM with options:
   Positive-edge CK
   Active-high   RW
   Output during write = Previously read data

   Usage notes: 

   This is a primitive used in some Maclog macrocell models. It models
   bulk memory storage in a procedural fashion. Features include:
     a) warnings for ill-defined conditions
     b) parameter-driven memory size
     c) self-contained diagnostic tasks.

   Warning messages are issued whenever the model sees ill-defined 
   inputs. Each warning message indicates the time, the input condition
   that causes an ill-defined operation, and the action that is taken as
   a result. Warning messages appear on the terminal as well as the log
   file by default. It is possible to direct this output elsewhere by 
   assigning the integer 'log' to your own multi-channel file descriptor.
   This might be done as follows:
		  initial begin
		     A.B.C.log = $fopen("warnings");
		  end


   Two tasks, 'show' and 'load', are provided to assist you in simulation 
   and debug of your circuit. Use the 'show' task to display memory 
   contents. The task is called with the full path name to the task and 
   must be passed the address range to display. An example would be:
		  A.B.C.show(0,10);
   The above would show the contents of the first eleven addresses in the
   primitive A.B.C.

   Use the 'load' task to initialize contents of a memory. You may
   invoke this task with the full path name to task. This task requires
   a file name as a string argument. The file must be in '$readmemb' format.
   An example of using 'load' is:
		  A.B.C.load("mem.init");
*/
`resetall
`timescale 1 ns / 100 ps
module SYN3RAM (DI3, DI2, DI1, DI0, WAD4, WAD3, WAD2, WAD1, WAD0, WREN, WPE0,
                WPE1, CK, GSR, PUR, RAD4, RAD3, RAD2, RAD1, RAD0, DO3, DO2, 
                DO1, DO0, QDO3 ,QDO2 ,QDO1 ,QDO0);
  parameter [127:0] init_value = 128'h00000000000000000000000000000000;
  parameter DISABLED_GSR = 0;

  input WAD0,WAD1,WAD2,WAD3,WAD4,DI0,DI1,DI2,DI3,CK,WREN,WPE0,WPE1;
  input RAD0,RAD1,RAD2,RAD3,RAD4,GSR, PUR;
  output DO0,DO1,DO2,DO3,QDO0,QDO1,QDO2,QDO3;

  reg wren_reg;
  reg [3:0] din_reg;
  reg [4:0] wadr_reg;
  reg [4:0] radr_reg;
  reg [3:0] Q, Qrg, Unknown;

  wire [4:0] Ab;
  wire CKb, GSRb, PURb;
  reg [4:0] mem [0:31]; 
  reg [4:0] dmem [0:31]; 
  reg [4:0] Aunk;
  reg [3:0] Dunk;
  reg GP;
  integer log, k, m, i;
  reg [127:0] pick_data;

  assign DO0 = Q[0];
  assign DO1 = Q[1];
  assign DO2 = Q[2];
  assign DO3 = Q[3];
  assign QDO0 = Qrg[0];
  assign QDO1 = Qrg[1];
  assign QDO2 = Qrg[2];
  assign QDO3 = Qrg[3];
  assign CKb = CK;
  assign GSRb = GSR;
  assign PURb = PUR;
  assign Ab = {WAD4, WAD3, WAD2, WAD1, WAD0};

  function isUndef;
    input a;
    isUndef = (a !== 1'b0 && a !== 1'b1);
  endfunction

  initial begin
    $timeformat(-9, 1, " ns", 5);
    log = 1;
  end

  initial begin
      pick_data = init_value;
    for (i=0; i<32; i=i+1) begin
      mem[i] = pick_data[3:0];
      dmem[i] = pick_data[3:0];
      pick_data = (pick_data >> 4);
    end
  end


   // Latch the address and data in for writing
   // Registers are rising edge enabled
  always @ (posedge CKb) begin
    if (GP == 1) begin
       wren_reg = WREN && WPE0 && WPE1;
       din_reg = {DI3, DI2, DI1, DI0};
       wadr_reg = {WAD4, WAD3, WAD2, WAD1, WAD0};
    end
  end

//---- Programmable GSR ----

  always @ (GSRb or PURb) begin
    if (DISABLED_GSR == 0) begin
      GP = GSRb && PURb;
    end
    else if (DISABLED_GSR == 1)
      GP = PURb;
  end
//--------------------------

  always @ (GP) begin
    if (GP == 0) begin
       wadr_reg = 5'b0;
       wren_reg = 1'b0;
       Qrg = 4'b0;
    end
  end //end of always loop

  always @ (RAD4 or RAD3 or RAD2 or RAD1 or RAD0) begin
     radr_reg = {RAD4, RAD3, RAD2, RAD1, RAD0};
  end

 always @ (negedge CKb) begin
     if (wren_reg === 1'b1) begin
	  doWrite(din_reg);
     end
   end

   //read process  
    always @ (radr_reg[4] or radr_reg[3] or radr_reg[2] or radr_reg[1] or 
    radr_reg[0] or mem[31] or mem[30] or mem[29] or mem[28] or mem[27] or 
    mem[26] or mem[25] or mem[24] or mem[23] or mem[22] or mem[21] or mem[20] 
    or mem[19] or mem[18] or mem[17] or mem[16] or mem[15] or mem[14] or 
    mem[13] or mem[12] or mem[11] or mem[10] or mem[9] or mem[8] or mem[7] or 
    mem[6] or mem[5] or mem[4] or mem[3] or mem[2] or mem[1] or mem[0]) begin
    Q = mem[radr_reg];
    end

//synchronous reads
 always @ (posedge CKb)
// doRead;
   if (GP == 1) begin
      Qrg = mem[radr_reg];
   end

   task write_unknown;
         input [4:0] wadr_reg;
         reg [3:0] Dunk;
         begin

          if(((wadr_reg[4] === 1'bx) && wadr_reg[3] === 1'bx) && (wadr_reg[2] === 1'bx) && (wadr_reg[1] === 1'bx) && (wadr_reg[0] === 1'bx)) begin
	    for (k=0; k<=31; k=k+1) begin
	     mem[k] = Unknown;
	     dmem[k] = Unknown;
            end // end of for loop
          end 
          else if(wadr_reg[0] === 1'bx) begin
            if((wadr_reg[2] === 1'bx) && (wadr_reg[1] === 1'bx))begin
              mem[{wadr_reg[3],1'b1,1'b1,1'b1}] = Dunk;
              mem[{wadr_reg[3],1'b1,1'b1,1'b0}] = Dunk;
              mem[{wadr_reg[3],1'b1,1'b0,1'b1}] = Dunk;
              mem[{wadr_reg[3],1'b1,1'b0,1'b0}] = Dunk;
              mem[{wadr_reg[3],1'b0,1'b1,1'b1}] = Dunk;
              mem[{wadr_reg[3],1'b0,1'b1,1'b0}] = Dunk;
              mem[{wadr_reg[3],1'b0,1'b0,1'b1}] = Dunk;
              mem[{wadr_reg[3],1'b0,1'b0,1'b0}] = Dunk;
              dmem[{wadr_reg[3],1'b1,1'b1,1'b1}] = Dunk;
              dmem[{wadr_reg[3],1'b1,1'b1,1'b0}] = Dunk;
              dmem[{wadr_reg[3],1'b1,1'b0,1'b1}] = Dunk;
              dmem[{wadr_reg[3],1'b1,1'b0,1'b0}] = Dunk;
              dmem[{wadr_reg[3],1'b0,1'b1,1'b1}] = Dunk;
              dmem[{wadr_reg[3],1'b0,1'b1,1'b0}] = Dunk;
              dmem[{wadr_reg[3],1'b0,1'b0,1'b1}] = Dunk;
              dmem[{wadr_reg[3],1'b0,1'b0,1'b0}] = Dunk;
            end
            else if((wadr_reg[3] === 1'bx) && (wadr_reg[1] === 1'bx))begin
              mem[{1'b1,wadr_reg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b1,wadr_reg[2],1'b0,1'b1}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b0,1'b1}] = Dunk;
              mem[{1'b1,wadr_reg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b1,wadr_reg[2],1'b0,1'b0}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b0,1'b0}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b0,1'b1}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b0,1'b1}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b0,1'b0}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b0,1'b0}] = Dunk;
            end
            else if((wadr_reg[3] === 1'bx) && (wadr_reg[2] === 1'bx))begin
              mem[{1'b1,wadr_reg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b1,wadr_reg[2],1'b0,1'b1}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b1,wadr_reg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b1,wadr_reg[2],1'b0,1'b0}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b0,1'b1}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b0,1'b0}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b1,1'b0}] = Dunk;
            end
            else if((wadr_reg[3] === 1'bx))begin
              mem[{1'b1,wadr_reg[2],wadr_reg[1],1'b1}] = Dunk;
              mem[{1'b0,wadr_reg[2],wadr_reg[1],1'b1}] = Dunk;
              mem[{1'b1,wadr_reg[2],wadr_reg[1],1'b0}] = Dunk;
              mem[{1'b0,wadr_reg[2],wadr_reg[1],1'b0}] = Dunk;
              dmem[{1'b1,wadr_reg[2],wadr_reg[1],1'b1}] = Dunk;
              dmem[{1'b0,wadr_reg[2],wadr_reg[1],1'b1}] = Dunk;
              dmem[{1'b1,wadr_reg[2],wadr_reg[1],1'b0}] = Dunk;
              dmem[{1'b0,wadr_reg[2],wadr_reg[1],1'b0}] = Dunk;
            end
            else if((wadr_reg[2] === 1'bx))begin
              mem[{wadr_reg[3],1'b1,wadr_reg[1],1'b1}] = Dunk;
              mem[{wadr_reg[3],1'b1,wadr_reg[1],1'b0}] = Dunk;
              mem[{wadr_reg[3],1'b0,wadr_reg[1],1'b1}] = Dunk;
              mem[{wadr_reg[3],1'b0,wadr_reg[1],1'b0}] = Dunk;
              dmem[{wadr_reg[3],1'b1,wadr_reg[1],1'b1}] = Dunk;
              dmem[{wadr_reg[3],1'b1,wadr_reg[1],1'b0}] = Dunk;
              dmem[{wadr_reg[3],1'b0,wadr_reg[1],1'b1}] = Dunk;
              dmem[{wadr_reg[3],1'b0,wadr_reg[1],1'b0}] = Dunk;
            end
            else if((wadr_reg[1] === 1'bx))begin
              mem[{wadr_reg[3],wadr_reg[2],1'b1,1'b1}] = Dunk;
              mem[{wadr_reg[3],wadr_reg[2],1'b1,1'b0}] = Dunk;
              mem[{wadr_reg[3],wadr_reg[2],1'b0,1'b1}] = Dunk;
              mem[{wadr_reg[3],wadr_reg[2],1'b0,1'b0}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],1'b1,1'b1}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],1'b1,1'b0}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],1'b0,1'b1}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],1'b0,1'b0}] = Dunk;
            end
            else begin
              mem[{wadr_reg[3],wadr_reg[2],wadr_reg[1],1'b1}] = Dunk;
              mem[{wadr_reg[3],wadr_reg[2],wadr_reg[1],1'b0}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],wadr_reg[1],1'b1}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],wadr_reg[1],1'b0}] = Dunk;
            end
           end
          else if(wadr_reg[1] === 1'bx) begin
            if((wadr_reg[3] === 1'bx) && (wadr_reg[2] === 1'bx))begin
              mem[{1'b1,1'b1,1'b1,wadr_reg[0]}] = Dunk;
              mem[{1'b1,1'b1,1'b0,wadr_reg[0]}] = Dunk;
              mem[{1'b1,1'b0,1'b1,wadr_reg[0]}] = Dunk;
              mem[{1'b1,1'b0,1'b0,wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b1,1'b1,wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b1,1'b0,wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b0,1'b1,wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b0,1'b0,wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b1,1'b1,wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b1,1'b0,wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b0,1'b1,wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b0,1'b0,wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b1,1'b1,wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b1,1'b0,wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b0,1'b1,wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b0,1'b0,wadr_reg[0]}] = Dunk;
            end
            else if (wadr_reg[3] === 1'bx) begin
              mem[{1'b1,wadr_reg[2],1'b1,wadr_reg[0]}] = Dunk;
              mem[{1'b1,wadr_reg[2],1'b0,wadr_reg[0]}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b1,wadr_reg[0]}] = Dunk;
              mem[{1'b0,wadr_reg[2],1'b0,wadr_reg[0]}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b1,wadr_reg[0]}] = Dunk;
              dmem[{1'b1,wadr_reg[2],1'b0,wadr_reg[0]}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b1,wadr_reg[0]}] = Dunk;
              dmem[{1'b0,wadr_reg[2],1'b0,wadr_reg[0]}] = Dunk;
            end
            else if (wadr_reg[2] === 1'bx) begin
              mem[{wadr_reg[3],1'b1,1'b1,wadr_reg[0]}] = Dunk;
              mem[{wadr_reg[3],1'b1,1'b0,wadr_reg[0]}] = Dunk;
              mem[{wadr_reg[3],1'b0,1'b1,wadr_reg[0]}] = Dunk;
              mem[{wadr_reg[3],1'b0,1'b0,wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],1'b1,1'b1,wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],1'b1,1'b0,wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],1'b0,1'b1,wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],1'b0,1'b0,wadr_reg[0]}] = Dunk;
            end 
            else begin
              mem[{wadr_reg[3],wadr_reg[2],1'b1,wadr_reg[0]}] = Dunk;
              mem[{wadr_reg[3],wadr_reg[2],1'b0,wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],1'b1,wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],wadr_reg[2],1'b0,wadr_reg[0]}] = Dunk;
            end
          end
          else if(wadr_reg[2] === 1'bx) begin
            if(wadr_reg[3] === 1'bx)begin
              mem[{1'b1,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b1,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b1,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b1,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b0,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b1,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b0,1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
            end
            else begin
              mem[{wadr_reg[3],1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{wadr_reg[3],1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],1'b0,wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{wadr_reg[3],1'b1,wadr_reg[1],wadr_reg[0]}] = Dunk;
            end
          end
          else if(wadr_reg[3] === 1'bx) begin
              mem[{1'b1,wadr_reg[2],wadr_reg[1],wadr_reg[0]}] = Dunk;
              mem[{1'b0,wadr_reg[2],wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b1,wadr_reg[2],wadr_reg[1],wadr_reg[0]}] = Dunk;
              dmem[{1'b0,wadr_reg[2],wadr_reg[1],wadr_reg[0]}] = Dunk;
          end
         end
  endtask

  task doWrite;
    input [3:0] data;
       if (Ab >= 32) begin
         // write-cycle address out-of-range
	   $fdisplay(log, "\n\tWarning! SYN3RAM instance, %m:",
	    "\n\t\t Out-of-range write-cycle address at time %t.", $realtime,
	    "\n\t\t Contents unchanged.");
       end
       else begin
	  // valid write-cycle address
	    mem[wadr_reg] = data;
//   dmem[wadr_reg] = data;
      end
  endtask

/*task doRead;
    if (^Ab === 1'bx) begin
      // unknown read-cycle address
      Q = Unknown;
    end
    else begin
      // known read-cycle address
      if (Ab >= 32) begin
	// read-cycle address out-of-range
	$fdisplay(log, "\n\tWarning! SYN5RAM instance, %m:",
	  "\n\t\t Out-of-range read-cycle address at time %t.", $realtime,
	  "\n\t\t Contents unchanged - Outputs set unknown.");
	Q = Unknown;
      end
      else begin
	// valid read-cycle address
//    QRDr = mem[Ab];
      Q = mem[radr_reg];
      end
    end
  endtask*/

  task doRead_ro;
    if (^radr_reg === 1'bx) begin
      // unknown read-cycle address
      Qrg = Unknown;
    end
    else begin
      // known read-cycle address
      if (radr_reg >= 32) begin
	// read-cycle address out-of-range
	$fdisplay(log, "\n\tWarning! SYN5RAM instance, %m:",
	  "\n\t\t Out-of-range read-cycle address at time %t.", $realtime,
	  "\n\t\t Contents unchanged - Outputs set unknown.");
	Qrg = Unknown;
      end
      else begin
	// valid read-cycle address
	Qrg = mem[radr_reg];
      end
    end
  endtask

  // Tasks for loading and displaying contents of a memory
  task load;			// USAGE: initial inst.load("file");
    input [8*256:1] initfile;
    begin
      $readmemb(initfile, mem);
      $readmemb(initfile, dmem);
   end
  endtask

  task show;			// USAGE: inst.show(low,high);
    input [31:0] low, high;
    integer i;
    begin
      $display("\n\t%m: Memory content dump\n");
      if (low < 0 || low >= 32 || low > high || high >= 32) 
	$display("\n\tError! Invalid address range.",
	  "\n\tUSAGE: inst.show(low,high); where low >= 0 and high <= %0d.",
	  15);
      else begin
	$display("\n\tAddress\tValue\tBank A");
	for (i=low; i<=high; i=i+1)
	  $display("%d\t%b", i, mem[i]);
	$display("\n\tAddress\tValue\tBank B");
	for (i=low; i<=high; i=i+1)
	  $display("%d\t%b", i, dmem[i]);
      end
    end
  endtask

endmodule
`endcelldefine
