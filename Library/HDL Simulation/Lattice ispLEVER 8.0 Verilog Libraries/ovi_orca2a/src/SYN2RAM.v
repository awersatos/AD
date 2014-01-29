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
// Simulation Library File for ORCA2A
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/SYN2RAM.v,v 1.9 2005/05/19 18:26:23 pradeep Exp $ 
//
// LUCENT TECHNOLOGIES ORCA VERILOG LIBRARY
// Release 4.1  -  Created August 27, 1996 
//*****************************************
// Mod History
// Revision: Date:         Author: Description:
// 1.0       Feb 1995      jmw     original model
// 1.1       Aug 27, 1996  jmw     deleted RWb from model
// 1.2       Oct 3, 1996   jmw     initialize rams to zero or param
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
`timescale 1 ns / 10 ps
`celldefine
module SYN2RAM (D, A, RW, CK, RD, Q, QRD);
  parameter [63:0] init_value = 64'h0000000000000000;

  input [3:0] A;
  input [3:0] RD;
  input [1:0] D;
  input RW, CK; 
  output [1:0] Q;
  output [1:0] QRD;

  wire [3:0] Ab;
  wire [3:0] RDb;
  wire [1:0] Db;
  wire CKb, RWb;
  reg [1:0] QRDr, Qr, Unknown;
  reg [1:0] mem [15:0]; 
  reg [1:0] dmem [15:0]; 
  reg [3:0] Areg;
  reg [1:0] Dreg;
  reg [3:0] Aunk;
  reg [1:0] Dunk;
  reg RWreg;
  integer log, k, m, i;
  reg [63:0] pick_data;

  assign Q = Qr;
  assign QRD = QRDr;
  assign Ab = A;
  assign RDb = RD;
  assign Db = D;
  assign CKb = CK;
  assign RWb = RW;

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
    for (i=0; i<16; i=i+1) begin
      mem[i] = pick_data[1:0];
      dmem[i] = pick_data[1:0];
      pick_data = (pick_data >> 4);
    end
  end


   // Latch the address and data in for writing
   // Latch is negative enabled
  always @ (CKb or Ab[3] or Ab[2] or Ab[1] or Ab[0] or RWb or Db[1] or Db[0]) begin
    if (isUndef (CKb)) begin
      if ($realtime != 0)
      $fdisplay(log, "\n\tWarning! SYN2RAM instance, %m:",
        "\n\t\t Clock undefined at time %t.", $realtime);
     Areg = Aunk;
     Dreg = Dunk;
     end
    else if (CKb === 1'b0) begin
     Areg = Ab;
     Dreg = Db;
     RWreg = RWb;
    end
  end

 always @ (posedge CKb) begin
    if (isUndef (RWb)) begin
      $fdisplay(log, "\n\tWarning! SYN2RAM instance, %m:",
        "\n\t\t Control Signals for Read/Write  undefined at time %t.", $realtime,
        "\n\t\t check state of WREN and WPE. One or More Addresses will be written Unknown.");
        if (^Areg === 1'bx) begin
           write_unknown(Areg);
           doRead;
        end
        else
        mem[Areg] = Unknown;
      end
     else if (RWreg === 1'b1) begin
	  doWrite(Dreg);
	  // valid read
	  doRead;
	  doRead_ro;
     end
   end


   //read process for bank one 
    always @ (Ab[3] or Ab[2] or Ab[1] or Ab[0]) begin
      doRead;
    end

   //read process for bank two 
    always @ (RDb[3] or RDb[2] or RDb[1] or RDb[0]) begin
      doRead_ro;
    end

   task write_unknown;
         input [3:0] Areg;
         reg [1:0] Dunk;
         begin
          if((Areg[3] === 1'bx) && (Areg[2] === 1'bx) && (Areg[1] === 1'bx) && (Areg[0] === 1'bx)) begin
	    for (k=0; k<=15; k=k+1) begin
	     mem[k] = Unknown;
	     dmem[k] = Unknown;
            end // end of for loop
          end 
          else if(Areg[0] === 1'bx) begin
            if((Areg[2] === 1'bx) && (Areg[1] === 1'bx))begin
              mem[{Areg[3],1'b1,1'b1,1'b1}] = Dunk;
              mem[{Areg[3],1'b1,1'b1,1'b0}] = Dunk;
              mem[{Areg[3],1'b1,1'b0,1'b1}] = Dunk;
              mem[{Areg[3],1'b1,1'b0,1'b0}] = Dunk;
              mem[{Areg[3],1'b0,1'b1,1'b1}] = Dunk;
              mem[{Areg[3],1'b0,1'b1,1'b0}] = Dunk;
              mem[{Areg[3],1'b0,1'b0,1'b1}] = Dunk;
              mem[{Areg[3],1'b0,1'b0,1'b0}] = Dunk;
              dmem[{Areg[3],1'b1,1'b1,1'b1}] = Dunk;
              dmem[{Areg[3],1'b1,1'b1,1'b0}] = Dunk;
              dmem[{Areg[3],1'b1,1'b0,1'b1}] = Dunk;
              dmem[{Areg[3],1'b1,1'b0,1'b0}] = Dunk;
              dmem[{Areg[3],1'b0,1'b1,1'b1}] = Dunk;
              dmem[{Areg[3],1'b0,1'b1,1'b0}] = Dunk;
              dmem[{Areg[3],1'b0,1'b0,1'b1}] = Dunk;
              dmem[{Areg[3],1'b0,1'b0,1'b0}] = Dunk;
            end
            else if((Areg[3] === 1'bx) && (Areg[1] === 1'bx))begin
              mem[{1'b1,Areg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b1,Areg[2],1'b0,1'b1}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b0,Areg[2],1'b0,1'b1}] = Dunk;
              mem[{1'b1,Areg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b1,Areg[2],1'b0,1'b0}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b0,Areg[2],1'b0,1'b0}] = Dunk;
              dmem[{1'b1,Areg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b1,Areg[2],1'b0,1'b1}] = Dunk;
              dmem[{1'b0,Areg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b0,Areg[2],1'b0,1'b1}] = Dunk;
              dmem[{1'b1,Areg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b1,Areg[2],1'b0,1'b0}] = Dunk;
              dmem[{1'b0,Areg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b0,Areg[2],1'b0,1'b0}] = Dunk;
            end
            else if((Areg[3] === 1'bx) && (Areg[2] === 1'bx))begin
              mem[{1'b1,Areg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b1,Areg[2],1'b0,1'b1}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,1'b1}] = Dunk;
              mem[{1'b1,Areg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b1,Areg[2],1'b0,1'b0}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,1'b0}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b1,Areg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b1,Areg[2],1'b0,1'b1}] = Dunk;
              dmem[{1'b0,Areg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b0,Areg[2],1'b1,1'b1}] = Dunk;
              dmem[{1'b1,Areg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b1,Areg[2],1'b0,1'b0}] = Dunk;
              dmem[{1'b0,Areg[2],1'b1,1'b0}] = Dunk;
              dmem[{1'b0,Areg[2],1'b1,1'b0}] = Dunk;
            end
            else if((Areg[3] === 1'bx))begin
              mem[{1'b1,Areg[2],Areg[1],1'b1}] = Dunk;
              mem[{1'b0,Areg[2],Areg[1],1'b1}] = Dunk;
              mem[{1'b1,Areg[2],Areg[1],1'b0}] = Dunk;
              mem[{1'b0,Areg[2],Areg[1],1'b0}] = Dunk;
              dmem[{1'b1,Areg[2],Areg[1],1'b1}] = Dunk;
              dmem[{1'b0,Areg[2],Areg[1],1'b1}] = Dunk;
              dmem[{1'b1,Areg[2],Areg[1],1'b0}] = Dunk;
              dmem[{1'b0,Areg[2],Areg[1],1'b0}] = Dunk;
            end
            else if((Areg[2] === 1'bx))begin
              mem[{Areg[3],1'b1,Areg[1],1'b1}] = Dunk;
              mem[{Areg[3],1'b1,Areg[1],1'b0}] = Dunk;
              mem[{Areg[3],1'b0,Areg[1],1'b1}] = Dunk;
              mem[{Areg[3],1'b0,Areg[1],1'b0}] = Dunk;
              dmem[{Areg[3],1'b1,Areg[1],1'b1}] = Dunk;
              dmem[{Areg[3],1'b1,Areg[1],1'b0}] = Dunk;
              dmem[{Areg[3],1'b0,Areg[1],1'b1}] = Dunk;
              dmem[{Areg[3],1'b0,Areg[1],1'b0}] = Dunk;
            end
            else if((Areg[1] === 1'bx))begin
              mem[{Areg[3],Areg[2],1'b1,1'b1}] = Dunk;
              mem[{Areg[3],Areg[2],1'b1,1'b0}] = Dunk;
              mem[{Areg[3],Areg[2],1'b0,1'b1}] = Dunk;
              mem[{Areg[3],Areg[2],1'b0,1'b0}] = Dunk;
              dmem[{Areg[3],Areg[2],1'b1,1'b1}] = Dunk;
              dmem[{Areg[3],Areg[2],1'b1,1'b0}] = Dunk;
              dmem[{Areg[3],Areg[2],1'b0,1'b1}] = Dunk;
              dmem[{Areg[3],Areg[2],1'b0,1'b0}] = Dunk;
            end
            else begin
              mem[{Areg[3],Areg[2],Areg[1],1'b1}] = Dunk;
              mem[{Areg[3],Areg[2],Areg[1],1'b0}] = Dunk;
              dmem[{Areg[3],Areg[2],Areg[1],1'b1}] = Dunk;
              dmem[{Areg[3],Areg[2],Areg[1],1'b0}] = Dunk;
            end
           end
          else if(Areg[1] === 1'bx) begin
            if((Areg[3] === 1'bx) && (Areg[2] === 1'bx))begin
              mem[{1'b1,1'b1,1'b1,Areg[0]}] = Dunk;
              mem[{1'b1,1'b1,1'b0,Areg[0]}] = Dunk;
              mem[{1'b1,1'b0,1'b1,Areg[0]}] = Dunk;
              mem[{1'b1,1'b0,1'b0,Areg[0]}] = Dunk;
              mem[{1'b0,1'b1,1'b1,Areg[0]}] = Dunk;
              mem[{1'b0,1'b1,1'b0,Areg[0]}] = Dunk;
              mem[{1'b0,1'b0,1'b1,Areg[0]}] = Dunk;
              mem[{1'b0,1'b0,1'b0,Areg[0]}] = Dunk;
              dmem[{1'b1,1'b1,1'b1,Areg[0]}] = Dunk;
              dmem[{1'b1,1'b1,1'b0,Areg[0]}] = Dunk;
              dmem[{1'b1,1'b0,1'b1,Areg[0]}] = Dunk;
              dmem[{1'b1,1'b0,1'b0,Areg[0]}] = Dunk;
              dmem[{1'b0,1'b1,1'b1,Areg[0]}] = Dunk;
              dmem[{1'b0,1'b1,1'b0,Areg[0]}] = Dunk;
              dmem[{1'b0,1'b0,1'b1,Areg[0]}] = Dunk;
              dmem[{1'b0,1'b0,1'b0,Areg[0]}] = Dunk;
            end
            else if (Areg[3] === 1'bx) begin
              mem[{1'b1,Areg[2],1'b1,Areg[0]}] = Dunk;
              mem[{1'b1,Areg[2],1'b0,Areg[0]}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,Areg[0]}] = Dunk;
              mem[{1'b0,Areg[2],1'b0,Areg[0]}] = Dunk;
              dmem[{1'b1,Areg[2],1'b1,Areg[0]}] = Dunk;
              dmem[{1'b1,Areg[2],1'b0,Areg[0]}] = Dunk;
              dmem[{1'b0,Areg[2],1'b1,Areg[0]}] = Dunk;
              dmem[{1'b0,Areg[2],1'b0,Areg[0]}] = Dunk;
            end
            else if (Areg[2] === 1'bx) begin
              mem[{Areg[3],1'b1,1'b1,Areg[0]}] = Dunk;
              mem[{Areg[3],1'b1,1'b0,Areg[0]}] = Dunk;
              mem[{Areg[3],1'b0,1'b1,Areg[0]}] = Dunk;
              mem[{Areg[3],1'b0,1'b0,Areg[0]}] = Dunk;
              dmem[{Areg[3],1'b1,1'b1,Areg[0]}] = Dunk;
              dmem[{Areg[3],1'b1,1'b0,Areg[0]}] = Dunk;
              dmem[{Areg[3],1'b0,1'b1,Areg[0]}] = Dunk;
              dmem[{Areg[3],1'b0,1'b0,Areg[0]}] = Dunk;
            end 
            else begin
              mem[{Areg[3],Areg[2],1'b1,Areg[0]}] = Dunk;
              mem[{Areg[3],Areg[2],1'b0,Areg[0]}] = Dunk;
              dmem[{Areg[3],Areg[2],1'b1,Areg[0]}] = Dunk;
              dmem[{Areg[3],Areg[2],1'b0,Areg[0]}] = Dunk;
            end
          end
          else if(Areg[2] === 1'bx) begin
            if(Areg[3] === 1'bx)begin
              mem[{1'b1,1'b1,Areg[1],Areg[0]}] = Dunk;
              mem[{1'b1,1'b1,Areg[1],Areg[0]}] = Dunk;
              mem[{1'b1,1'b0,Areg[1],Areg[0]}] = Dunk;
              mem[{1'b1,1'b0,Areg[1],Areg[0]}] = Dunk;
              mem[{1'b0,1'b1,Areg[1],Areg[0]}] = Dunk;
              mem[{1'b0,1'b1,Areg[1],Areg[0]}] = Dunk;
              mem[{1'b0,1'b0,Areg[1],Areg[0]}] = Dunk;
              mem[{1'b0,1'b0,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b1,1'b1,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b1,1'b1,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b1,1'b0,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b1,1'b0,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b0,1'b1,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b0,1'b1,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b0,1'b0,Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b0,1'b0,Areg[1],Areg[0]}] = Dunk;
            end
            else begin
              mem[{Areg[3],1'b0,Areg[1],Areg[0]}] = Dunk;
              mem[{Areg[3],1'b1,Areg[1],Areg[0]}] = Dunk;
              dmem[{Areg[3],1'b0,Areg[1],Areg[0]}] = Dunk;
              dmem[{Areg[3],1'b1,Areg[1],Areg[0]}] = Dunk;
            end
          end
          else if(Areg[3] === 1'bx) begin
              mem[{1'b1,Areg[2],Areg[1],Areg[0]}] = Dunk;
              mem[{1'b0,Areg[2],Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b1,Areg[2],Areg[1],Areg[0]}] = Dunk;
              dmem[{1'b0,Areg[2],Areg[1],Areg[0]}] = Dunk;
          end
         end
  endtask

  task doWrite;
    input [1:0] data;
       if (Ab >= 16) begin
         // write-cycle address out-of-range
	   $fdisplay(log, "\n\tWarning! SYN2RAM instance, %m:",
	    "\n\t\t Out-of-range write-cycle address at time %t.", $realtime,
	    "\n\t\t Contents unchanged.");
       end
       else begin
	  // valid write-cycle address
	    mem[Areg] = data;
	    dmem[Areg] = data;
      end
  endtask

  task doRead;
    if (^Ab === 1'bx) begin
      // unknown read-cycle address
      Qr = Unknown;
    end
    else begin
      // known read-cycle address
      if (Ab >= 16) begin
	// read-cycle address out-of-range
	$fdisplay(log, "\n\tWarning! SYN2RAM instance, %m:",
	  "\n\t\t Out-of-range read-cycle address at time %t.", $realtime,
	  "\n\t\t Contents unchanged - Outputs set unknown.");
	Qr = Unknown;
      end
      else begin
	// valid read-cycle address
	Qr = mem[Ab];
      end
    end
  endtask

  task doRead_ro;
    if (^RDb === 1'bx) begin
      // unknown read-cycle address
      QRDr = Unknown;
    end
    else begin
      // known read-cycle address
      if (RDb >= 16) begin
	// read-cycle address out-of-range
	$fdisplay(log, "\n\tWarning! SYN2RAM instance, %m:",
	  "\n\t\t Out-of-range read-cycle address at time %t.", $realtime,
	  "\n\t\t Contents unchanged - Outputs set unknown.");
	QRDr = Unknown;
      end
      else begin
	// valid read-cycle address
	QRDr = dmem[RDb];
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
      if (low < 0 || low >= 16 || low > high || high >= 16) 
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
