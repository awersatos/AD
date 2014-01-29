///////////////////////////////////////////////////////
//  Copyright (c) 1995/2006 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 12.i (M.51)
//  \  \           Description : 
//  /  /                      
// /__/   /\       Filename    : X_ICAP_VIRTEX6.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//  Revision:		
//  04/22/09 - Initial version.
//  07/08/09 - Set BUSY to 1 during icap initial (CR525847)
//  09/17/09 - Remove DCMLOCK pin for SIM_CONFIG (CR530867)
//  10/09/09 - Add initialzion message and check (CR525847)
//  12/17/09 - Allow ICAP use without RBT file (CR537437)
//  03/02/10 - Support desync when icap initial done (CR551856)
///////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

module X_ICAP_VIRTEX6 (
  BUSY,
  O,
  CLK,
  CSB,
  I,
  RDWRB
);
  parameter [31:0] DEVICE_ID = 32'h04244093;
  parameter LOC = "UNPLACED";
  parameter ICAP_WIDTH = "X8";
  parameter SIM_CFG_FILE_NAME = "NONE";

  output BUSY;
  output [31:0] O;

  input CLK;
  input CSB;
  input RDWRB;
  input [31:0] I;

  wire cso_b;
  reg  prog_b;
  reg  init_b;
  reg [3:0] bw = 4'b0000;
  wire busy_out;
  reg cs_bi = 0, rdwr_bi = 0;
  wire cs_b_t;
  wire clk_in;
  wire rdwr_b_t;
  wire [31:0] dix;
  reg [31:0] di;
  reg [31:0] data_rbt;
  reg [7:0] tmp_byte0;
  reg [7:0] tmp_byte1;
  reg [7:0] tmp_byte2;
  reg [7:0] tmp_byte3;
  reg icap_idone;
  reg sim_file_flag;
  integer icap_fd;
  reg notifier;
  wire delay_CLK;
  wire delay_CSB;
  wire delay_RDWRB;
  wire [31:0] delay_I;
  tri1 p_up; 
  tri init_tri = (icap_idone == 0) ? init_b : p_up;
  tri (weak1, strong0) done_o = p_up;
  tri (pull1, supply0) [31:0] di_t = (icap_idone == 1 && delay_RDWRB == 1)? 32'bz : dix;
 
  assign dix = (icap_idone == 1) ? delay_I : di;
  assign BUSY = (icap_idone == 1) ? busy_out : 1;
  assign cs_b_t = (icap_idone == 1) ? delay_CSB : cs_bi;
  assign clk_in = delay_CLK;
  assign rdwr_b_t = (icap_idone == 1) ? delay_RDWRB : rdwr_bi;
  assign O = (icap_idone == 1 && delay_RDWRB == 1) ? di_t : 32'b0;
  
  always @(delay_CSB or delay_RDWRB)
    if ($time > 1 && icap_idone == 0) begin
          $display (" Warning : X_ICAP_VIRTEX6 on instance %m at time %t has not finished initialization. A message will be printed after the initialization. User need start read/write operation after that.", $time);
    end


  X_SIM_CONFIG_V6 #(
      .DEVICE_ID(DEVICE_ID),
      .ICAP_SUPPORT("TRUE"),
      .ICAP_WIDTH(ICAP_WIDTH)
    )
    X_SIM_CONFIG_V6_INST (
      .BUSY(busy_out),
      .CSOB(cso_b),
      .DONE(done_o),
      .CCLK(clk_in),
      .CSB(cs_b_t),
      .D(di_t),
      .INITB(init_tri),
      .M(3'b110),
      .PROGB(prog_b),
      .RDWRB(rdwr_b_t)
  );


  initial begin

    case (ICAP_WIDTH)
      "X8" : bw = 4'b0000;
      "X16" : bw = 4'b0010;
      "X32" : bw = 4'b0011;
      default : begin
        $display("Attribute Syntax Error : The Attribute ICAP_WIDTH on X_ICAP_VIRTEX6 instance %m is set to %s.  Legal values for this attribute are X8, X16 or X32.", ICAP_WIDTH);
      end
    endcase
 
    icap_idone = 0;
    sim_file_flag = 0;
    if (SIM_CFG_FILE_NAME == "NONE") begin
//       $display(" Error: The configure rbt data file for X_ICAP_VIRTEX6 instance %m was not found. Use the SIM_CFG_FILE_NAME parameter to pass the file name.\n");
       sim_file_flag = 1;
    end
    else begin
      icap_fd = $fopen(SIM_CFG_FILE_NAME, "r");
      if  (icap_fd == 0)
      begin
         $display(" Error: The configure rbt data file %s for X_ICAP_VIRTEX6 instance %m was not found. Use the SIM_CFG_FILE_NAME parameter to pass the file name.\n", SIM_CFG_FILE_NAME);
         sim_file_flag = 1;
      end
    end

      init_b = 1;
      prog_b = 1;
      rdwr_bi = 0;
      cs_bi = 1;
      #300000;
      @(posedge clk_in)
       prog_b = 0;
      @(negedge clk_in)
       init_b = 0;
     #300000;
      @(posedge clk_in)
       prog_b = 1;
      @(negedge clk_in) begin
       init_b = 1;
       cs_bi = 0;
      end
      if (sim_file_flag == 0) begin
        while ($fscanf(icap_fd, "%b", data_rbt) != -1) begin
         if (done_o == 0) begin
          tmp_byte3 = bit_revers8(data_rbt[31:24]);
          tmp_byte2 = bit_revers8(data_rbt[23:16]);
          tmp_byte1 = bit_revers8(data_rbt[15:8]);
          tmp_byte0 = bit_revers8(data_rbt[7:0]);
          if (bw == 4'b0000) begin
            @(negedge clk_in)
               di = {24'b0, tmp_byte3};
            @(negedge clk_in)
               di = {24'b0, tmp_byte2};
            @(negedge clk_in)
               di = {24'b0, tmp_byte1};
            @(negedge clk_in)
               di = {24'b0, tmp_byte0};
           end
           else if (bw == 4'b0010) begin
            @(negedge clk_in)
               di = {16'b0, tmp_byte3, tmp_byte2};
            @(negedge clk_in)
               di = {16'b0, tmp_byte1, tmp_byte0};
           end
           else if (bw == 4'b0011) begin
            @(negedge clk_in)
               di = {tmp_byte3, tmp_byte2, tmp_byte1, tmp_byte0};
           end
        end
        else begin
          @(negedge clk_in);
          di = 32'hFFFFFFFF;
          @(negedge clk_in);
          @(negedge clk_in);
          @(negedge clk_in);
          if (icap_idone == 0) begin 
            $display (" Message: X_ICAP_VIRTEX6 on instance %m at time %t has finished initialization. User can start read/write operation.", $time);
            icap_idone = 1;
          end
        end
      end
      $fclose(icap_fd);
      #1000;
    end
    else begin
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'hFFFFFFFF;
       @(negedge clk_in)
          di = 32'h000000DD;
       @(negedge clk_in) begin
        if (bw == 4'b0000)
           di = 32'h00000088;
        else if (bw == 4'b0010)
           di = 32'h00000044;
        else if (bw == 4'b0011)
           di = 32'h00000022;
       end
      rbt_data_wr(32'hFFFFFFFF);
      rbt_data_wr(32'hFFFFFFFF);
      rbt_data_wr(32'hAA995566);
      rbt_data_wr(32'h30008001);
      rbt_data_wr(32'h00000005);
       @(negedge clk_in);
       @(negedge clk_in);
       @(negedge clk_in);
       @(negedge clk_in);
       @(negedge clk_in);
       @(negedge clk_in);
       if (icap_idone == 0) begin 
            $display (" Message: X_ICAP_VIRTEX6 on instance %m at time %t has finished initialization. User can start read/write operation.", $time);
          icap_idone = 1;
       end
      #1000;
      end
  end
  

  task rbt_data_wr;
    input [31:0] dat_rbt;
    reg [7:0] tp_byte3;
    reg [7:0] tp_byte2;
    reg [7:0] tp_byte1;
    reg [7:0] tp_byte0;
  begin
    tp_byte3 = bit_revers8(dat_rbt[31:24]);
    tp_byte2 = bit_revers8(dat_rbt[23:16]);
    tp_byte1 = bit_revers8(dat_rbt[15:8]);
    tp_byte0 = bit_revers8(dat_rbt[7:0]);
    if (bw == 4'b0000) begin
      @(negedge clk_in)
         di = {24'b0, tp_byte3};
      @(negedge clk_in)
         di = {24'b0, tp_byte2};
      @(negedge clk_in)
         di = {24'b0, tp_byte1};
      @(negedge clk_in)
         di = {24'b0, tp_byte0};
     end
     else if (bw == 4'b0010) begin
      @(negedge clk_in)
         di = {16'b0, tp_byte3, tp_byte2};
      @(negedge clk_in)
         di = {16'b0, tp_byte1, tp_byte0};
     end
     else if (bw == 4'b0011) begin
      @(negedge clk_in)
         di = {tp_byte3, tp_byte2, tp_byte1, tp_byte0};
     end
   end
   endtask

  function [7:0] bit_revers8;
        input [7:0] din8;
        begin
            bit_revers8[0] = din8[7];
            bit_revers8[1] = din8[6];
            bit_revers8[2] = din8[5];
            bit_revers8[3] = din8[4];
            bit_revers8[4] = din8[3];
            bit_revers8[5] = din8[2];
            bit_revers8[6] = din8[1];
            bit_revers8[7] = din8[0];
        end
  endfunction

specify
    $period (posedge CLK, 0:0:0, notifier);
    $setuphold (posedge CLK, negedge CSB, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_CSB);
    $setuphold (posedge CLK, negedge I[0], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[0]);
    $setuphold (posedge CLK, negedge I[10], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[10]);
    $setuphold (posedge CLK, negedge I[11], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[11]);
    $setuphold (posedge CLK, negedge I[12], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[12]);
    $setuphold (posedge CLK, negedge I[13], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[13]);
    $setuphold (posedge CLK, negedge I[14], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[14]);
    $setuphold (posedge CLK, negedge I[15], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[15]);
    $setuphold (posedge CLK, negedge I[16], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[16]);
    $setuphold (posedge CLK, negedge I[17], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[17]);
    $setuphold (posedge CLK, negedge I[18], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[18]);
    $setuphold (posedge CLK, negedge I[19], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[19]);
    $setuphold (posedge CLK, negedge I[1], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[1]);
    $setuphold (posedge CLK, negedge I[20], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[20]);
    $setuphold (posedge CLK, negedge I[21], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[21]);
    $setuphold (posedge CLK, negedge I[22], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[22]);
    $setuphold (posedge CLK, negedge I[23], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[23]);
    $setuphold (posedge CLK, negedge I[24], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[24]);
    $setuphold (posedge CLK, negedge I[25], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[25]);
    $setuphold (posedge CLK, negedge I[26], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[26]);
    $setuphold (posedge CLK, negedge I[27], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[27]);
    $setuphold (posedge CLK, negedge I[28], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[28]);
    $setuphold (posedge CLK, negedge I[29], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[29]);
    $setuphold (posedge CLK, negedge I[2], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[2]);
    $setuphold (posedge CLK, negedge I[30], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[30]);
    $setuphold (posedge CLK, negedge I[31], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[31]);
    $setuphold (posedge CLK, negedge I[3], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[3]);
    $setuphold (posedge CLK, negedge I[4], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[4]);
    $setuphold (posedge CLK, negedge I[5], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[5]);
    $setuphold (posedge CLK, negedge I[6], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[6]);
    $setuphold (posedge CLK, negedge I[7], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[7]);
    $setuphold (posedge CLK, negedge I[8], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[8]);
    $setuphold (posedge CLK, negedge I[9], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[9]);
    $setuphold (posedge CLK, negedge RDWRB, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_RDWRB);
    $setuphold (posedge CLK, posedge CSB, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_CSB);
    $setuphold (posedge CLK, posedge I[0], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[0]);
    $setuphold (posedge CLK, posedge I[10], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[10]);
    $setuphold (posedge CLK, posedge I[11], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[11]);
    $setuphold (posedge CLK, posedge I[12], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[12]);
    $setuphold (posedge CLK, posedge I[13], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[13]);
    $setuphold (posedge CLK, posedge I[14], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[14]);
    $setuphold (posedge CLK, posedge I[15], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[15]);
    $setuphold (posedge CLK, posedge I[16], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[16]);
    $setuphold (posedge CLK, posedge I[17], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[17]);
    $setuphold (posedge CLK, posedge I[18], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[18]);
    $setuphold (posedge CLK, posedge I[19], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[19]);
    $setuphold (posedge CLK, posedge I[1], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[1]);
    $setuphold (posedge CLK, posedge I[20], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[20]);
    $setuphold (posedge CLK, posedge I[21], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[21]);
    $setuphold (posedge CLK, posedge I[22], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[22]);
    $setuphold (posedge CLK, posedge I[23], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[23]);
    $setuphold (posedge CLK, posedge I[24], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[24]);
    $setuphold (posedge CLK, posedge I[25], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[25]);
    $setuphold (posedge CLK, posedge I[26], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[26]);
    $setuphold (posedge CLK, posedge I[27], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[27]);
    $setuphold (posedge CLK, posedge I[28], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[28]);
    $setuphold (posedge CLK, posedge I[29], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[29]);
    $setuphold (posedge CLK, posedge I[2], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[2]);
    $setuphold (posedge CLK, posedge I[30], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[30]);
    $setuphold (posedge CLK, posedge I[31], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[31]);
    $setuphold (posedge CLK, posedge I[3], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[3]);
    $setuphold (posedge CLK, posedge I[4], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[4]);
    $setuphold (posedge CLK, posedge I[5], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[5]);
    $setuphold (posedge CLK, posedge I[6], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[6]);
    $setuphold (posedge CLK, posedge I[7], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[7]);
    $setuphold (posedge CLK, posedge I[8], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[8]);
    $setuphold (posedge CLK, posedge I[9], 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_I[9]);
    $setuphold (posedge CLK, posedge RDWRB, 0:0:0, 0:0:0, notifier,,, delay_CLK, delay_RDWRB);
    ( CLK => BUSY) = (100:100:100, 100:100:100);
    ( CLK => O[0]) = (100:100:100, 100:100:100);
    ( CLK => O[10]) = (100:100:100, 100:100:100);
    ( CLK => O[11]) = (100:100:100, 100:100:100);
    ( CLK => O[12]) = (100:100:100, 100:100:100);
    ( CLK => O[13]) = (100:100:100, 100:100:100);
    ( CLK => O[14]) = (100:100:100, 100:100:100);
    ( CLK => O[15]) = (100:100:100, 100:100:100);
    ( CLK => O[16]) = (100:100:100, 100:100:100);
    ( CLK => O[17]) = (100:100:100, 100:100:100);
    ( CLK => O[18]) = (100:100:100, 100:100:100);
    ( CLK => O[19]) = (100:100:100, 100:100:100);
    ( CLK => O[1]) = (100:100:100, 100:100:100);
    ( CLK => O[20]) = (100:100:100, 100:100:100);
    ( CLK => O[21]) = (100:100:100, 100:100:100);
    ( CLK => O[22]) = (100:100:100, 100:100:100);
    ( CLK => O[23]) = (100:100:100, 100:100:100);
    ( CLK => O[24]) = (100:100:100, 100:100:100);
    ( CLK => O[25]) = (100:100:100, 100:100:100);
    ( CLK => O[26]) = (100:100:100, 100:100:100);
    ( CLK => O[27]) = (100:100:100, 100:100:100);
    ( CLK => O[28]) = (100:100:100, 100:100:100);
    ( CLK => O[29]) = (100:100:100, 100:100:100);
    ( CLK => O[2]) = (100:100:100, 100:100:100);
    ( CLK => O[30]) = (100:100:100, 100:100:100);
    ( CLK => O[31]) = (100:100:100, 100:100:100);
    ( CLK => O[3]) = (100:100:100, 100:100:100);
    ( CLK => O[4]) = (100:100:100, 100:100:100);
    ( CLK => O[5]) = (100:100:100, 100:100:100);
    ( CLK => O[6]) = (100:100:100, 100:100:100);
    ( CLK => O[7]) = (100:100:100, 100:100:100);
    ( CLK => O[8]) = (100:100:100, 100:100:100);
    ( CLK => O[9]) = (100:100:100, 100:100:100);

    specparam PATHPULSE$ = 0;
endspecify

endmodule
