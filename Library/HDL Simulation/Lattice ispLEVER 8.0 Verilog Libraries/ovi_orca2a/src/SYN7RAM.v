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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca2a/RCS/SYN7RAM.v,v 1.3 2005/05/19 18:26:23 pradeep Exp $ 
//
// LUCENT TECHNOLOGIES ORCA VERILOG LIBRARY
// Release 9.2  -  Created December 2, 1997
//******************************************
// Mod history
// Rev:   Date:  Author:  Description: 
// 1.0    Dec 97   swt    original 
// 1.1    Feb 98   swt    initialize ram to 0 
// 1.2    Jun 98   swt    ROM16X1 Read Only Memory 
//************************************************
/* 
   Verilog model for ORCA's 32 word by 1 bit Read Only Memory.

   Usage notes: 

   This is a primitive used in some Maclog macrocell models. It models
   bulk memory storage in a procedural fashion. Features include:
     a) warnings for ill-defined conditions
     b) self-contained diagnostic tasks.

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

`celldefine

module SYN7RAM (A, Q);
  parameter [31:0] init_value = 32'h00000000;

  input [4:0] A;
  output Q;

  wire [4:0] Ab;
  reg [4:0] Aunk;
  reg Qr, Unknown;
  reg [0:0] mem [31:0]; 
  integer log, k, i;
  reg [4:0] Areg;
  reg [31:0] pick_data;

  assign Q = Qr;
  assign Ab = A;

  function isUndef;
    input a;
    isUndef = (a !== 1'b0 && a !== 1'b1);
  endfunction

  initial begin
    $timeformat(-9, 1, " ns", 5); //when time is displayed use 1 nanosecond increments
                                  //1 location after the decimel and allow 5 spaces 
                                  //for printing of the time number.
    log = 1;
  end


/*initial begin
    pick_data = init_value;
    for (i=0; i<32; i=i+1) begin
      mem[i] = pick_data[3:0];
      pick_data = (pick_data >> 4);
    end
  end*/

  initial begin  
    pick_data = init_value;
    for (i=0; i<32; i=i+1) begin 
      mem[i] = pick_data[0]; 
      pick_data = (pick_data >> 1);
    end  
  end   


`ifdef DEBUG
initial begin
  $display ("in SYN7RAM.v, init_value: %h", init_value);
   for (i=0; i < 32; i=i+1) begin
     $display ("mem[%d] = %h", i, mem[i]);
    end
end
`endif      

  // Latch the address and data in for writing
  // Latches are pos level enabled
/*always @ (CKb or Ab[3] or Ab[2] or Ab[1] or Ab[0] or RWb or Db[3]or Db[2] or Db[1] or Db[0]) begin
  always @ (CKb or Ab[3] or Ab[2] or Ab[1] or Ab[0]) begin
    if (isUndef (CKb)) begin 
      if ($realtime != 0) 
      $fdisplay(log, "\n\tWarning! SYN4RAM instance, %m:",
        "\n\t\t Clock undefined at time %t.", $realtime);
     Areg = Aunk;
     Dreg = Dunk; 
     end
    else if (CKb === 1'b1) begin
     Areg = Ab;
     Dreg = Db; 
     RWreg = RWb; 
    end
  end*/

/*always @ (GSRb) begin
    if (GSRb == 0) begin
       Areg = 5'b0;
       Qrrg = 4'b0;
    end
  end*/

/*  always @ (negedge CKb) begin
    if (isUndef (RWb)) begin 
      $fdisplay(log, "\n\tWarning! SYN4RAM instance, %m:",
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
       doRead;
     end
   end */

  
  // Added changes to output new data when Address changes for
  // asynchronous output. Also made the model Level sensitive to
  // Clock (latch) and also data could change due to a change in RWb
  // if clock is high.

  // write process
/*always @ (posedge RWb) begin
	// Check for unknown input states
        if (RWb === 1'b1) begin  
	if (^Areg === 1'bx) begin
	  //write xxxx to the possible addresses that it could be 
	  $fdisplay(log, "\n\tWarning! SYN4RAM instance, %m:",
	    "\n\t\t One or More Address Lines Undefined at time %t.", $realtime,
	    "\n\t\t One or More Addresses will be written Unknown.");
           write_unknown(Areg); //call to task to write unkowns to certain address locations
           doRead;
         end
         else begin
	  // do Write operation and then Read 
	  // valid write
          // $stop;
	  doWrite(Dreg);
          doRead;
         end // end of write operation
         end
  end // end of always loop
*/

//Read process
  always @ (Ab[4] or Ab[3] or Ab[2] or Ab[1] or Ab[0]) begin
   // $stop;
// doRead;
  Qr = mem[Ab];

  //$display ($time,"Qr at address %h == %h", Ab, Qr);
  end

//synchronous reads
/*always @ (posedge CKb)
// doRead;
  Qrrg = mem[Ab];*/

   task write_unknown;
         input [4:0] Areg;
         reg [3:0] Dunk;
         begin
          if(((Areg[4] === 1'bx) && Areg[3] === 1'bx) && (Areg[2] === 1'bx) && (Areg[1] === 1'bx) && (Areg[0] === 1'bx)) begin
	    for (k=0; k<=31; k=k+1) begin
	     mem[k] = Unknown;
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
            end
            else if((Areg[3] === 1'bx))begin
              mem[{1'b1,Areg[2],Areg[1],1'b1}] = Dunk;
              mem[{1'b0,Areg[2],Areg[1],1'b1}] = Dunk;
              mem[{1'b1,Areg[2],Areg[1],1'b0}] = Dunk;
              mem[{1'b0,Areg[2],Areg[1],1'b0}] = Dunk;
            end
            else if((Areg[2] === 1'bx))begin
              mem[{Areg[3],1'b1,Areg[1],1'b1}] = Dunk;
              mem[{Areg[3],1'b1,Areg[1],1'b0}] = Dunk;
              mem[{Areg[3],1'b0,Areg[1],1'b1}] = Dunk;
              mem[{Areg[3],1'b0,Areg[1],1'b0}] = Dunk;
            end
            else if((Areg[1] === 1'bx))begin
              mem[{Areg[3],Areg[2],1'b1,1'b1}] = Dunk;
              mem[{Areg[3],Areg[2],1'b1,1'b0}] = Dunk;
              mem[{Areg[3],Areg[2],1'b0,1'b1}] = Dunk;
              mem[{Areg[3],Areg[2],1'b0,1'b0}] = Dunk;
            end
            else begin
              mem[{Areg[3],Areg[2],Areg[1],1'b1}] = Dunk;
              mem[{Areg[3],Areg[2],Areg[1],1'b0}] = Dunk;
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
            end
            else if (Areg[3] === 1'bx) begin
              mem[{1'b1,Areg[2],1'b1,Areg[0]}] = Dunk;
              mem[{1'b1,Areg[2],1'b0,Areg[0]}] = Dunk;
              mem[{1'b0,Areg[2],1'b1,Areg[0]}] = Dunk;
              mem[{1'b0,Areg[2],1'b0,Areg[0]}] = Dunk;
            end
            else if (Areg[2] === 1'bx) begin
              mem[{Areg[3],1'b1,1'b1,Areg[0]}] = Dunk;
              mem[{Areg[3],1'b1,1'b0,Areg[0]}] = Dunk;
              mem[{Areg[3],1'b0,1'b1,Areg[0]}] = Dunk;
              mem[{Areg[3],1'b0,1'b0,Areg[0]}] = Dunk;
            end 
            else begin
              mem[{Areg[3],Areg[2],1'b1,Areg[0]}] = Dunk;
              mem[{Areg[3],Areg[2],1'b0,Areg[0]}] = Dunk;
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
            end
            else begin
              mem[{Areg[3],1'b0,Areg[1],Areg[0]}] = Dunk;
              mem[{Areg[3],1'b1,Areg[1],Areg[0]}] = Dunk;
            end
          end
          else if(Areg[3] === 1'bx) begin
              mem[{1'b1,Areg[2],Areg[1],Areg[0]}] = Dunk;
              mem[{1'b0,Areg[2],Areg[1],Areg[0]}] = Dunk;
          end
         // $fdisplay(log, "a3=%b a2=%b a1=%b a0=%b",Areg[3],Areg[2],Areg[1],Areg[0]);
         // show(0,15);

         end
  endtask

/*task doWrite;
    input [3:0] data;
    integer c;
	if (Areg >= 16) begin
	  // write-cycle address out-of-range
	  $fdisplay(log, "\n\tWarning! SYN4RAM instance, %m:",
	    "\n\t\t Out-of-range write-cycle address at time %t.", $realtime,
	    "\n\t\t Contents unchanged.");
	end
	else begin
	  // valid write-cycle address
	  mem[Areg] = data;
	end
  endtask*/

  task doRead;
    if (^Ab === 1'bx) begin
      // unknown read-cycle address
      Qr = Unknown;
    end
    else begin
      // known read-cycle address
      if (Ab >= 32) begin
	// read-cycle address out-of-range
	$fdisplay(log, "\n\tWarning! SYN7RAM instance, %m:",
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

  // Tasks for loading and displaying contents of a memory
  task load;			// USAGE: initial inst.load("file");
    input [8*256:1] initfile;
    $readmemb(initfile, mem);
  endtask

  task show;			// USAGE: inst.show(low,high);
    input [31:0] low, high;
    integer i;
    begin
      $display("\n\t%m: Memory content dump\n");
      if (low < 0 || low >= 32 || low > high || high >= 32) 
	$display("\n\tError! Invalid address range.",
	  "\n\tUSAGE: inst.show(low,high); where low >= 0 and high <= %0d.",
	  31);
      else begin
	$display("\n\tAddress\tValue");
	for (i=low; i<=high; i=i+1)
	  $display("%d\t%b", i, mem[i]);
      end
    end
  endtask

endmodule
`endcelldefine

