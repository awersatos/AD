// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/FIFO_DUALCLOCK_MACRO.v,v 1.6 2009/08/27 18:32:47 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2007 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Macro for FIFO 
// /___/   /\     Filename : FIFO_DUALCLOCK_MACRO.v
// \   \  /  \    Timestamp : Wed April 04 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//    04/04/08 - Initial version.
// End Revision


`timescale 1 ps/1 ps

module FIFO_DUALCLOCK_MACRO (ALMOSTEMPTY, ALMOSTFULL, DO, EMPTY, FULL, RDCOUNT, RDERR, WRCOUNT, WRERR,
	       DI, RDCLK, RDEN, RST, WRCLK, WREN);

    parameter ALMOST_EMPTY_OFFSET = 9'h080;
    parameter ALMOST_FULL_OFFSET = 9'h080;
    parameter integer DATA_WIDTH = 22; 
   parameter DEVICE = "VIRTEX5";
    parameter FIFO_SIZE = "36Kb"; 
    parameter FIRST_WORD_FALL_THROUGH = "FALSE";
    parameter INIT = 72'h0; // This parameter is valid only for Virtex6
    parameter SRVAL = 72'b0; // This parameter is valid only for Virtex6
    parameter SIM_MODE = "SAFE"; // This parameter is valid only for Virtex5


    //Parameter checks for invalid combinations
    initial begin
      if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6")
        begin
           if (DATA_WIDTH == 0)
            begin
              $display("Attribute Syntax Error : The attribute DATA_WIDTH on FIFO_DUALCLOCK_MACRO instance %m is set to %d.  This attribute must atleast be equal to 1", DATA_WIDTH);
              $finish;
            end
          else if (DATA_WIDTH > 36 && FIFO_SIZE == "18Kb")
            begin
              $display("Attribute Syntax Error : The attribute DATA_WIDTH on FIFO_DUALCLOCK_MACRO instance %m is set to %d.  For FIFO_SIZE of 18Kb, allowed values of this attribute are 1 to 36", DATA_WIDTH);
              $finish;
            end
          else if (DATA_WIDTH > 72)
            begin
              $display("Attribute Syntax Error : The attribute DATA_WIDTH on FIFO_DUALCLOCK_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 36 for FIFO_SIZE of 18Kb and 1 to 72 for FIFO_SIZE of 36Kb", DATA_WIDTH);
              $finish;
            end
          if(FIFO_SIZE == "18Kb" || FIFO_SIZE == "36Kb") ;
          else
             begin
               $display("Attribute Syntax Error : The attribute FIFO_SIZE on FIFO_DUALCLOCK_MACRO instance %m is set to %s.  Legal values for this attribute are 18Kb or 36Kb", FIFO_SIZE);
               $finish;
             end
        end
      else 
        begin
          $display("Attribute Syntax Error : The attribute DEVICE on FIFO_DUALCLOCK_MACRO instance %m is set to %s.  Legal values of this attribute are VIRTEX5, VIRTEX6", DEVICE);
          $finish;
        end
    end // initial begin

    localparam DATA_P = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (DATA_WIDTH == 9) ||  (DATA_WIDTH == 17) || (DATA_WIDTH == 18) || (DATA_WIDTH == 33) || (DATA_WIDTH == 34) || (DATA_WIDTH == 35) || (DATA_WIDTH == 36) || (DATA_WIDTH == 65) || (DATA_WIDTH == 66) || (DATA_WIDTH == 67) || (DATA_WIDTH == 68) || (DATA_WIDTH == 69) || (DATA_WIDTH == 70) || (DATA_WIDTH == 71) || (DATA_WIDTH == 72) ? "TRUE" : "FALSE") : "FALSE";

    localparam d_size = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (FIFO_SIZE == "18Kb") ? ( (DATA_WIDTH >= 0 && DATA_WIDTH <= 4) ? 4 : (DATA_WIDTH > 4 && DATA_WIDTH <= 9) ? 9 : (DATA_WIDTH > 9 && DATA_WIDTH <= 18) ? 18 : (DATA_WIDTH > 18 && DATA_WIDTH <= 36) ? 36 : 18) : (FIFO_SIZE == "36Kb") ? ( (DATA_WIDTH >= 0 && DATA_WIDTH <= 4) ? 4 : (DATA_WIDTH > 4 && DATA_WIDTH <= 9) ? 9 : (DATA_WIDTH > 9 && DATA_WIDTH <= 18) ? 18 : (DATA_WIDTH > 18 && DATA_WIDTH <= 36) ? 36 : (DATA_WIDTH > 36 && DATA_WIDTH <= 72) ? 72 : 36) : 36) : 36;

    localparam D_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (FIFO_SIZE == "18Kb") ? ( ( DATA_WIDTH > 0 && DATA_WIDTH <= 4) ? 4 : (DATA_WIDTH > 4 && DATA_WIDTH <= 9) ? 8 : (DATA_WIDTH > 9 && DATA_WIDTH <= 18) ? 16 : (DATA_WIDTH > 18 && DATA_WIDTH <= 36) ? 32 : 16) : (FIFO_SIZE == "36Kb") ? ( (DATA_WIDTH > 0 && DATA_WIDTH <= 4) ? 4 : (DATA_WIDTH > 4 && DATA_WIDTH <= 9) ? 8 : (DATA_WIDTH > 9 && DATA_WIDTH <= 18) ? 16 : (DATA_WIDTH > 18 && DATA_WIDTH <= 36) ? 32 : (DATA_WIDTH > 36 && DATA_WIDTH <= 72) ? 64 : 32) : 32 ) : 32;

    localparam DIP_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (DATA_WIDTH < 9 ) ? 0 : (DATA_WIDTH == 9) ? 1 : (DATA_WIDTH == 17) ? 1 : (DATA_WIDTH == 18) ? 2 : (DATA_WIDTH == 33) ? 1 : (DATA_WIDTH == 34) ? 2 : (DATA_WIDTH == 35) ? 3 : (DATA_WIDTH == 36) ? 4 : (DATA_WIDTH == 65) ? 1 : (DATA_WIDTH == 66) ? 2 : (DATA_WIDTH == 67) ? 3 : (DATA_WIDTH == 68) ? 4 : (DATA_WIDTH == 69) ? 5 : (DATA_WIDTH == 70) ? 6 : (DATA_WIDTH == 71) ? 7 : (DATA_WIDTH == 72) ? 8 : 0 ) : 0; 
    localparam DOP_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (DATA_WIDTH < 9 ) ? 1 : (DATA_WIDTH == 9) ? 1 : (DATA_WIDTH == 17) ? 1 : (DATA_WIDTH == 18) ? 2 : (DATA_WIDTH == 33) ? 1 : (DATA_WIDTH == 34) ? 2 : (DATA_WIDTH == 35) ? 3 : (DATA_WIDTH == 36) ? 4 : (DATA_WIDTH == 65) ? 1 : (DATA_WIDTH == 66) ? 2 : (DATA_WIDTH == 67) ? 3 : (DATA_WIDTH == 68) ? 4 : (DATA_WIDTH == 69) ? 5 : (DATA_WIDTH == 70) ? 6 : (DATA_WIDTH == 71) ? 7 : (DATA_WIDTH == 72) ? 8 : 1 ) : 1; 

    localparam COUNT_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (FIFO_SIZE == "18Kb") ? ( (DATA_WIDTH <= 4) ? 12 : (DATA_WIDTH > 4 && DATA_WIDTH <= 9) ? 11 : (DATA_WIDTH > 9 && DATA_WIDTH <= 18) ? 10 : (DATA_WIDTH > 18 && DATA_WIDTH <= 36) ? 9 : 12 ) : (FIFO_SIZE == "36Kb") ? ( (DATA_WIDTH <= 4) ? 13 : (DATA_WIDTH > 4 && DATA_WIDTH <=9) ? 12 : (DATA_WIDTH > 9 && DATA_WIDTH <= 18) ? 11 : (DATA_WIDTH > 18 && DATA_WIDTH <= 36) ? 10 : (DATA_WIDTH > 36 && DATA_WIDTH <= 72) ? 9 : 13 ) : 13 ) : 13;

    localparam MAX_D_WIDTH = (DEVICE == "VIRTEX5") ? ( (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 18) ? 16 : (FIFO_SIZE == "18Kb" && DATA_WIDTH > 18 && DATA_WIDTH <= 36)  ? 32 : (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 36) ? 32 : (FIFO_SIZE == "36Kb" && DATA_WIDTH > 36 && DATA_WIDTH <= 72) ? 64 : 64 ) : 
    (DEVICE == "VIRTEX6") ? ( (FIFO_SIZE == "18Kb") ? 32 : (FIFO_SIZE == "36Kb") ? 64 : 64 ) : 
    64;

    localparam MAX_DP_WIDTH = (DEVICE == "VIRTEX5") ? ( (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 18) ? 2 : (FIFO_SIZE == "18Kb" && DATA_WIDTH > 18 && DATA_WIDTH <= 36)  ? 4 : (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 36) ? 4 : (FIFO_SIZE == "36Kb" && DATA_WIDTH > 36 && DATA_WIDTH <= 72) ? 8 : 8 ) : 
    (DEVICE == "VIRTEX6") ? ( (FIFO_SIZE == "18Kb") ? 4 : (FIFO_SIZE == "36Kb") ? 8 : 8 ) : 
    8;

    localparam MAX_COUNT_WIDTH = (DEVICE == "VIRTEX5") ? ( (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 18) ? 12 : (FIFO_SIZE == "18Kb" && DATA_WIDTH > 18 && DATA_WIDTH <= 36)  ? 9 : (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 36) ? 13 : (FIFO_SIZE == "36Kb" && DATA_WIDTH > 36 && DATA_WIDTH <= 72) ? 9 : 13 ) : 
    (DEVICE == "VIRTEX6") ? ( (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 36)  ? 12 : (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 72) ? 13 : 13 ) : 
    13;


    localparam fin_width = (DATA_WIDTH == 0) ? 1 : DATA_WIDTH;

    output ALMOSTEMPTY;
    output ALMOSTFULL;
    output [DATA_WIDTH-1:0] DO;
    output EMPTY;
    output FULL;
    output [COUNT_WIDTH-1:0] RDCOUNT;
    output RDERR;
    output [COUNT_WIDTH-1:0] WRCOUNT;
    output WRERR;

    input [DATA_WIDTH-1:0] DI;
    input RDCLK;
    input RDEN;
    input RST;
    input WRCLK;
    input WREN;

    wire [MAX_D_WIDTH-1:0] DI_PATTERN;
    wire [MAX_D_WIDTH-1:0] DO_PATTERN;
    wire [MAX_DP_WIDTH-1:0] DIP_PATTERN;
    wire [MAX_DP_WIDTH-1:0] DOP_PATTERN;
    wire [MAX_COUNT_WIDTH-1:0] RDCOUNT_PATTERN;
    wire [MAX_COUNT_WIDTH-1:0] WRCOUNT_PATTERN;

  // Pattern for DATA bus
      generate
        case(DEVICE)
          "VIRTEX5", "VIRTEX6": 
             begin
               if (DATA_P == "FALSE" && ( (FIFO_SIZE == "18Kb" && DATA_WIDTH == 36) || (FIFO_SIZE == "36Kb" && DATA_WIDTH == 72)))
                 begin : di1
                   assign DIP_PATTERN = 0;
                   assign DI_PATTERN = DI;
                 end
               if (DATA_P == "FALSE" && ( (FIFO_SIZE == "18Kb" && DATA_WIDTH < 36) || (FIFO_SIZE == "36Kb" && DATA_WIDTH < 72)))
                 begin : di2
                   assign DIP_PATTERN = 0;
                   assign DI_PATTERN = {{((MAX_D_WIDTH)-fin_width){1'b0}}, DI};
                 end
             end
          default : ;
        endcase
      endgenerate
      generate
        case(DEVICE)
          "VIRTEX5", "VIRTEX6": 
            begin
              if (DATA_P == "TRUE" && ( (FIFO_SIZE == "18Kb" && DATA_WIDTH == 36) || (FIFO_SIZE == "36Kb" && DATA_WIDTH == 72)))
                begin : di3
                  assign DI_PATTERN = DI[D_WIDTH-1:0];
                  assign DIP_PATTERN = DI[fin_width-1 : D_WIDTH];
                end
                if (DATA_P == "TRUE" && ( (FIFO_SIZE == "18Kb" && DATA_WIDTH < 36) || (FIFO_SIZE == "36Kb" && DATA_WIDTH < 72)))
                begin : di4
                  assign DI_PATTERN = {{((MAX_D_WIDTH)-D_WIDTH){1'b0}}, DI[D_WIDTH-1:0]};
                  assign DIP_PATTERN = {{((MAX_DP_WIDTH)-DIP_WIDTH){1'b0}}, DI[fin_width-1 : D_WIDTH]};
                end
            end
          default : ;
        endcase
      endgenerate
     generate 
        case(DEVICE)
          "VIRTEX5", "VIRTEX6": 
            begin
              if (DATA_P == "FALSE" && ( (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 36) || (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 72)))
                begin : do1
                  assign DO = DO_PATTERN[fin_width-1:0];
                end
            end
          default : ;
       endcase
     endgenerate
     generate 
        case(DEVICE)
          "VIRTEX5", "VIRTEX6": 
            begin
              if (DATA_P == "TRUE" && ( (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 36) || (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 72)))
                begin : do2
                  assign DO = {DOP_PATTERN[DOP_WIDTH-1:0], DO_PATTERN[D_WIDTH-1:0]};
                end
            end
          default : ;
        endcase
    endgenerate
 
    assign RDCOUNT = RDCOUNT_PATTERN[COUNT_WIDTH-1:0];
    assign WRCOUNT = WRCOUNT_PATTERN[COUNT_WIDTH-1:0];
   
    generate
      case (DEVICE)
        //  begin generate virtex5
        "VIRTEX5":
           begin
             if (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 18) begin : fifo_18
               FIFO18 #( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DATA_WIDTH(d_size),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .SIM_MODE (SIM_MODE)
                  ) fifo_18 (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .RST(RST),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
             end
     
             else if (FIFO_SIZE == "18Kb" && DATA_WIDTH > 18 && DATA_WIDTH <= 36) begin : fifo_18_36 
               FIFO18_36 #( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .SIM_MODE (SIM_MODE)
                 ) fifo_18_36 (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .RST(RST),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
                end

             else if (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 36) begin : fifo_36
               FIFO36 #( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DATA_WIDTH(d_size),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .SIM_MODE (SIM_MODE)
                 ) fifo_36 (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .RST(RST),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
                end
    
             else if (FIFO_SIZE == "36Kb" && DATA_WIDTH > 36 && DATA_WIDTH <= 72) begin : fifo_36_72
               FIFO36_72 # ( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .SIM_MODE (SIM_MODE)
                 ) fifo_18_36 (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DBITERR(),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .ECCPARITY(),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .RST(RST),
                 .SBITERR(),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
             end
       end // end generate virtex5
       // begin generate virtex6
       "VIRTEX6":
           begin
             if (FIFO_SIZE == "18Kb" && DATA_WIDTH <= 18) begin : fifo_18_bl
               FIFO18E1 #( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DATA_WIDTH(d_size),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIFO_MODE("FIFO18"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .INIT(INIT[35:0]),
                 .SRVAL(SRVAL[35:0])
                  ) fifo_18_bl (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .REGCE(1'b1),
                 .RST(RST),
                 .RSTREG(1'b1),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
             end
             else if (FIFO_SIZE == "18Kb" && DATA_WIDTH > 18 && DATA_WIDTH <= 36) begin : fifo_18_bl_1
               FIFO18E1 #( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DATA_WIDTH(d_size),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIFO_MODE("FIFO18_36"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .INIT(INIT[35:0]),
                 .SRVAL(SRVAL[35:0])
                  ) fifo_18_bl_1 (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .REGCE(1'b1),
                 .RST(RST),
                 .RSTREG(1'b1),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
             end
 
             else if (FIFO_SIZE == "36Kb" && DATA_WIDTH <= 36) begin : fifo_36_bl
               FIFO36E1 #( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DATA_WIDTH(d_size),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIFO_MODE("FIFO36"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .INIT(INIT),
                 .SRVAL(SRVAL)
                 ) fifo_36_bl (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DBITERR(),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .ECCPARITY(),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .SBITERR(),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .INJECTDBITERR(1'b0),
                 .INJECTSBITERR(1'b0),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .REGCE(1'b1),
                 .RST(RST),
                 .RSTREG(1'b1),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
                end
             else if (FIFO_SIZE == "36Kb" && DATA_WIDTH > 36 && DATA_WIDTH <= 72) begin : fifo_36_bl_1
               FIFO36E1 #( 
                 .ALMOST_EMPTY_OFFSET(ALMOST_EMPTY_OFFSET),
                 .ALMOST_FULL_OFFSET(ALMOST_FULL_OFFSET),
                 .DATA_WIDTH(d_size),
                 .DO_REG(1),
                 .EN_SYN("FALSE"),
                 .FIFO_MODE("FIFO36_72"),
                 .FIRST_WORD_FALL_THROUGH(FIRST_WORD_FALL_THROUGH),
                 .INIT(INIT),
                 .SRVAL(SRVAL)
                 ) fifo_36_bl_1 (
                 .ALMOSTEMPTY(ALMOSTEMPTY),
                 .ALMOSTFULL(ALMOSTFULL),
                 .DBITERR(),
                 .DO(DO_PATTERN),
                 .DOP(DOP_PATTERN),
                 .ECCPARITY(),
                 .EMPTY(EMPTY),
                 .FULL(FULL),
                 .RDCOUNT(RDCOUNT_PATTERN),
                 .RDERR(RDERR),
                 .SBITERR(),
                 .WRCOUNT(WRCOUNT_PATTERN),
                 .WRERR(WRERR),
                 .DI(DI_PATTERN),
                 .DIP(DIP_PATTERN),
                 .INJECTDBITERR(1'b0),
                 .INJECTSBITERR(1'b0),
                 .RDCLK(RDCLK),
                 .RDEN(RDEN),
                 .REGCE(1'b1),
                 .RST(RST),
                 .RSTREG(1'b1),
                 .WRCLK(WRCLK),
                 .WREN(WREN)
                  );
                end
       end // end generate virtex6
       default : ;
     endcase 
   endgenerate
endmodule

 

     
