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
// Simulation Library File for ORCA2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2/RCS/CREGBRAM.v,v 1.5 2005/05/19 18:05:32 pradeep Exp $ 
//
//*****************************************
// Mod history
// Rev:   Date:  Author: Description:
// 1.0    2-95           original
// 1.1    8-27-96  jmw   added check of is $realtime != 0 to omit 
//                       printout message of writing x to ram at time 0 
//*****************************************
/* 
   BRAM equivalent for Verilog. This model is for BRAM with options:
   Active-high   EN
   Active-high   RW
   Output during write = Previously read data
   This cell has vector ports whose size are defined by parameters.

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

   There are three parameters that determine the size of the memory
   at compile-time. These parameters are set in the HDL description 
   for your macrocell and you should not have to touch them.

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
`celldefine
module CREGBRAM (D, A, RW, EN, Q);
  parameter [63:0]init_value = 64'h0000000000000000;

  input  [3:0] A;
  input  [3:0] D;
  input  RW, EN; 
  output [3:0] Q;

  wire [3:0] Ab;
  wire [3:0] Db;
  wire RWb, ENb; 
  reg [3:0] Qr, Unknown;
  reg [3:0] mem [15:0]; 
  reg [63:0]pick_data;
  integer UEN, URW, UAW, log, i;
  time UENt, URWt, UAWt;

  assign #0.1 Q = Qr;
  assign Ab = A;
  assign Db = D;
  assign RWb = RW;
  assign ENb = EN;


  
  initial begin
    i =0;
    pick_data = init_value;
    for (i=0; i<16; i=i+1) begin
      mem[i] = pick_data[3:0];
      pick_data = (pick_data >> 4);
    end
  end

  function isUndef;
    input a;
    isUndef =  (a!==1'b0 && a!==1'b1);
  endfunction

  initial begin
    $timeformat(-9, 1, " ns", 5);
    UEN = 0; URW = 0; UAW = 0; log = 1;
  end

  // This model is activated by any change on A, D, RW while EN is not low
  always @ (Db or Ab or RWb or ENb) begin
    if (isUndef(ENb)) begin
      // unknown enable
      if (UEN == 0) begin
	$fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		 "\n\t         Unknown enable at time %t.", $realtime,
		 "\n\t         Outputs set unknown; contents unchanged.");
	UENt = $realtime;
      end
      UEN = UEN + 1;
      Qr = Unknown;
    end
    else if (ENb===1'b1) begin
      // known enable
      if (UEN > 1) begin
	$fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		 "\n\t         Total of %0d unknown enable events",UEN,
		 "\n\t         from time %t to time %t.", UENt, $realtime);
      end
      UEN = 0;
      if (isUndef(RWb)) begin
      // unknown read/write
	if (URW == 0) begin
          if ($realtime != 0.0)
	  $fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		   "\n\t         Unknown read/write at time %t.",$realtime,
		   "\n\t         Outputs set unknown;",
		   " unknown written if address is known.");
	  URWt = $realtime;
	end
	URW = URW + 1;
	Qr = Unknown;
	doWrite(Unknown);
      end
      else begin
      // known read/write
	if (URW > 1) begin
	  $fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		   "\n\t         Total of %0d unknown read/write operations",
		   URW,
		   "\n\t         from time %t to time %t.", URWt, $realtime);
	end
	URW = 0;
	if (RWb===1'b0) begin
		doWrite(Db);
                doRead;
                end
	else
		doRead;
      end
    end
  end

  task doWrite;
    input [3:0] data;
      if (^Ab === 1'bx) begin
	// unknown write-cycle address
	if (UAW == 0) begin
	  $fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		   "\n\t         Unknown write-cycle address at time %t.",
		   $realtime,
		   "\n\t         Contents unchanged.");
	  UAWt = $realtime;
	end
	UAW = UAW + 1;
      end
      else begin
	// known write-cycle address
	if (UAW > 1) begin
	  $fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		   "\n\t         Total of %0d unknown write-cycle addresses",
		   UAW,
		   "\n\t         from time %t to time %t.", UAWt, $realtime);
	end
	UAW = 0;
	if (Ab >= 16) begin
	  // write-cycle address out-of-range
	  $fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		   "\n\t         Address out-of-range for write-cycle",
		   " at time %t.", $realtime,
		   "\n\t         Contents unchanged.");
	end
	else begin
	  // valid write-cycle address
	  mem[Ab] = data;
	end
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
	$fdisplay(log,"\n\tWarning! CREGBRAM instance, %m:",
		 "\n\t         Address out-of-range for read-cycle",
		 " at time %t.", $realtime,
		 "\n\t         Outputs set unknown.");
	Qr = Unknown;
      end
      else begin
	// valid read-cycle address
	Qr = mem[Ab];
      end
    end
  endtask

  // Tasks for loading and displaying contents of a memory
  task load;			// USAGE: initial inst.load("file");
    input [8*256:1] initfile;
    $readmemb(initfile,mem);
  endtask

  task show;			// USAGE: inst.show(low,high);
    input [31:0] low, high;
    integer i;
    begin
      $display("\t%m: Memory content dump\n");
      if (low < 0 || low >= 16 || low > high || high >= 16) 
	$display("\tError! Invalid address range.\n",
	  "\tUSAGE: inst.show(low,high); where low >= 0 and high <= %0d.",
	  15);
      else begin
	$display("\tAddress\tValue");
	for (i = low; i <= high; i = i + 1)
	  $display("%d\t%b",i,mem[i]);
      end
    end
  endtask

endmodule
`endcelldefine
