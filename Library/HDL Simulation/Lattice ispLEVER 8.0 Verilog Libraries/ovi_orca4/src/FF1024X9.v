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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FF1024X9.v,v 1.12 2005/05/19 19:01:18 pradeep Exp $ 
//
`timescale 1 ns / 1 ps

`celldefine

module FF1024X9 (
                 D8, D7, D6, D5, D4, D3, D2, D1, D0,
                 CKW, CKR, WRE, RDE, RSTN, 
                 PF9, PF8, PF7, PF6, PF5, PF4, PF3, PF2, PF1, PF0,
                 PE9, PE8, PE7, PE6, PE5, PE4, PE3, PE2, PE1, PE0,
                 Q8, Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0, EF, FF, PEF, PFF);

// INPUTS
input D8, D7, D6, D5, D4, D3, D2, D1, D0;
input CKW, CKR, WRE, RDE, RSTN;
input PF9, PF8, PF7, PF6, PF5, PF4, PF3, PF2, PF1, PF0;
input PE9, PE8, PE7, PE6, PE5, PE4, PE3, PE2, PE1, PE0;

// OUTPUTS
output Q8, Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0, EF, FF, PEF, PFF;

// PARAMETERS
parameter FFMODE = "NOREG";
parameter INHIBITMODE = "TRUE";
parameter ASYNCMODE = "FALSE";


wire [8:0] DB;
wire [9:0] PEB;
wire [9:0] PFB;
reg [9:0] RADDR;
reg [9:0] WADDR;
reg [8:0] Q;
reg [8:0] Q_noreg;
reg [8:0] Q_outreg;
  reg [8:0] MEM [1023:0];
  wire [10:0] pe_ptr;
  wire [10:0] pf_ptr;
  wire [9:0] write_address;
  wire [9:0] read_address;
  reg mc1_inhrw_fifo;
  reg mc1_reg_fifo;
  reg mc1_async_fifo;
  reg memchg;
wire [10:0] fifo_words_used_syncr;        // number of words used in fifo in ckr domain
wire [10:0] fifo_words_used_syncw;        // number of words used in fifo in ckw domain
wire [10:0] fifo_words;             // number of words in fifo
reg [10:0] int_write_address;       // internal write address - 1 extra bit
wire [10:0] int_write_address_plus1;       // internal write address - 1 extra bit
reg [10:0] int_write_address_syncb;       
reg [10:0] int_write_address_synca;       
reg [10:0] int_read_address;       // internal read address - 1 extra bit
wire [10:0] int_read_address_plus1;       // internal read address - 1 extra bit
reg [10:0] int_read_address_syncb;       
reg [10:0] int_read_address_synca;       
wire fifo_wre, fifo_rde;                // fifo enables - impacted by ff, ef
wire ef_int, pef_int,pff_int,ff_int;
reg ef_sync, pef_sync,pff_sync,ff_sync;
wire [10:0] int_write_address_sync; // internal write address + 1 extra bit - selected int_write_address
wire [10:0] int_read_address_sync; // internal read address + 1 extra bit -  selected int_read_address
reg  ef_reset;
reg  rd_reset;
reg ef_reset_rd;


  buf (DB[8], D8);
  buf (DB[7], D7);
  buf (DB[6], D6);
  buf (DB[5], D5);
  buf (DB[4], D4);
  buf (DB[3], D3);
  buf (DB[2], D2);
  buf (DB[1], D1);
  buf (DB[0], D0);
  buf (CKWB, CKW);
  buf (CKRB, CKR);
  buf (WREB, WRE);
  buf (RDEB, RDE);
  buf (RSTNB, RSTN);
  buf (PEB[9], PE9);
  buf (PEB[8], PE8);
  buf (PEB[7], PE7);
  buf (PEB[6], PE6);
  buf (PEB[5], PE5);
  buf (PEB[4], PE4);
  buf (PEB[3], PE3);
  buf (PEB[2], PE2);
  buf (PEB[1], PE1);
  buf (PEB[0], PE0);
  buf (PFB[9], PF9);
  buf (PFB[8], PF8);
  buf (PFB[7], PF7);
  buf (PFB[6], PF6);
  buf (PFB[5], PF5);
  buf (PFB[4], PF4);
  buf (PFB[3], PF3);
  buf (PFB[2], PF2);
  buf (PFB[1], PF1);
  buf (PFB[0], PF0);

  buf (Q8_out, Q[8]);
  buf (Q7_out, Q[7]);
  buf (Q6_out, Q[6]);
  buf (Q5_out, Q[5]);
  buf (Q4_out, Q[4]);
  buf (Q3_out, Q[3]);
  buf (Q2_out, Q[2]);
  buf (Q1_out, Q[1]);
  buf (Q0_out, Q[0]);

  buf (Q8, Q8_out);
  buf (Q7, Q7_out);
  buf (Q6, Q6_out);
  buf (Q5, Q5_out);
  buf (Q4, Q4_out);
  buf (Q3, Q3_out);
  buf (Q2, Q2_out);
  buf (Q1, Q1_out);
  buf (Q0, Q0_out);

  initial
  begin
     memchg = 1'b0;

     if (INHIBITMODE == "TRUE")
        mc1_inhrw_fifo = 1'b0;
     else
        mc1_inhrw_fifo = 1'b1;

     if (FFMODE == "OUTREG")
        mc1_reg_fifo = 1'b1;
     else
        mc1_reg_fifo = 1'b0;

     if (ASYNCMODE == "TRUE")
        mc1_async_fifo = 1'b1;
     else
        mc1_async_fifo = 1'b0;

  end

wire reset=~RSTNB;
wire fifo_reset = reset;
wire rd_reset_int = fifo_reset | rd_reset;

// generate sync versions of the number of words used in read and write ck domains
// number of words in fifo  = write counter value - read counter value
assign fifo_words_used_syncr={int_write_address_sync[10]^int_read_address[10],int_write_address_sync[9:0]} - {1'b0,int_read_address[9:0]};

assign fifo_words=11'd1024;

// number of words in fifo  = write counter value - read counter value
assign fifo_words_used_syncw={int_read_address_sync[10]^int_write_address[10],int_write_address[9:0]} - {1'b0,int_read_address_sync[9:0]};

//Commented out

//assign int_write_address_sync= int_write_address;
//assign int_write_address_sync= (mc1_async_fifo)?int_write_address_syncb:int_write_address;
//assign int_write_address_sync= (mc1_async_fifo)?int_write_address:int_write_address_syncb;

//assign int_read_address_sync= int_read_address;
//assign int_read_address_sync= (mc1_async_fifo)?int_read_address_syncb:int_read_address;
//assign int_read_address_sync= (mc1_async_fifo)?int_read_address:int_read_address_syncb;

// generate EF/PEF
assign ef_int=(fifo_words_used_syncr[10:1]==0)&~(((mc1_async_fifo)?ef_reset_rd:ef_reset) &rd_reset);
assign pef_int=(fifo_words_used_syncr[9:0]<pe_ptr);

assign EF=(mc1_reg_fifo)?ef_sync:ef_int;
assign PEF=(mc1_reg_fifo)?pef_sync:pef_int;

// generate FF/PFF
assign ff_int=(fifo_words_used_syncw==fifo_words)?1:0;
assign pff_int=(fifo_words_used_syncw[9:0]>=pf_ptr);

assign FF=(mc1_reg_fifo)?ff_sync:ff_int;
assign PFF=(mc1_reg_fifo)?pff_sync:pff_int;

assign fifo_wre=(WRE & (~(ff_int & PFF) | mc1_inhrw_fifo));  // enable write if csw and not full

assign fifo_rde=(RDE & (~(EF & PEF) | mc1_inhrw_fifo));  // enable read if csw and not full

assign pe_ptr = {1'b0, PEB};
assign pf_ptr = {1'b0, PFB};


always @( posedge CKWB or posedge fifo_reset)
        begin
        if (fifo_reset) ef_reset<=1'b0;
        else if (fifo_wre) ef_reset<=1'b1;
        end

always @( posedge CKRB )
    begin
    ef_reset_rd=ef_reset;
    end

always @( posedge CKRB or posedge fifo_reset)
        begin
        if (fifo_reset) rd_reset<=1'b1;
        else if (fifo_rde & ((ef_reset_rd&mc1_async_fifo)|(ef_reset&~mc1_async_fifo))) rd_reset<=1'b0;
        end

// generate sync flags
always @(posedge CKRB or negedge RSTNB)
    begin
    if (!RSTNB) ef_sync <= 1;
    else ef_sync <= ef_int;
    end

always @(posedge CKRB or negedge RSTNB)
    begin
    if (!RSTNB) pef_sync <= 1;
    else pef_sync <= pef_int;
    end

always @(posedge CKWB or negedge RSTNB)
    begin
    if (!RSTNB) ff_sync <= 0;
    else ff_sync <= ff_int;
    end

always @(posedge CKWB or negedge RSTNB)
    begin
    if (!RSTNB) pff_sync <= 0;
    else pff_sync <= pff_int;
    end

// Generate FIFO write address with 12 bit counter
assign int_write_address_plus1 = int_write_address + 1;

assign int_write_address_sync = (mc1_async_fifo) ? int_write_address_syncb : int_write_address;
assign int_read_address_sync = (mc1_async_fifo) ? int_read_address_syncb : int_read_address;

always @ (posedge CKWB or negedge RSTNB)
        begin
        if(!RSTNB) int_write_address <= 0;  // no reset for Gray code counter
        else if (fifo_wre) int_write_address <= int_write_address_plus1;
        end


always @ (posedge CKWB or negedge RSTNB)
        begin
        if(!RSTNB) int_write_address_synca <= 0;  
        else  if (fifo_wre) int_write_address_synca <= int_write_address_plus1 ;
        end

always @ (posedge CKRB or negedge RSTNB)
        begin
        if(!RSTNB) int_write_address_syncb <= 0;
        else  int_write_address_syncb <= int_write_address_synca ;
        end

// Generate FIFO read address with 12 bit counter

assign int_read_address_plus1 = int_read_address + 1;

always @ (posedge CKRB or posedge rd_reset_int)
        begin
        if(rd_reset_int) int_read_address <= 0;
        else if (fifo_rde) int_read_address <= int_read_address_plus1;
        end

always @ (posedge CKRB or negedge RSTNB)
        begin
        if(!RSTNB) int_read_address_synca <= 0;
        else if (fifo_rde) int_read_address_synca <= int_read_address_plus1 ;
        end

always @ (posedge CKWB or negedge RSTNB)
        begin
        if(!RSTNB) int_read_address_syncb <= 0;
        else int_read_address_syncb <= int_read_address_synca ;
        end

assign read_address = int_read_address[9:0];
assign write_address = int_write_address[9:0];

 always @(posedge CKRB or negedge RSTNB) begin
  if (RSTNB == 1'b0)
  begin
     RADDR <= 10'b0;
  end
  else
     if (fifo_rde == 1'b1)
     begin
        RADDR <= read_address;
     end
  end

 always @(posedge CKWB or negedge RSTNB) begin
  if (RSTNB == 1'b0)
     WADDR <= 10'b0;
  else
  begin
   if (fifo_wre == 1'b1)
     begin
        WADDR = write_address;
//        MEM[WADDR] = DB;
        MEM[write_address] = DB;
//        memchg = ~memchg;
     end
  end
  end

// always @(RADDR or memchg or RSTNB) begin
 always @(RSTNB or posedge CKRB or read_address) begin
  if (RSTNB == 1'b0)
  begin
     Q_noreg <= 9'b0;
  end
  else
//     Q_noreg = MEM[RADDR];
     Q_noreg = MEM[read_address];
  end

 always @(posedge CKRB or negedge RSTNB) begin
  if (RSTNB == 1'b0)
  begin
     Q_outreg <= 9'b0;
  end
  else
     Q_outreg <= Q_noreg;
  end

 always @(Q_outreg or Q_noreg) begin
     if (FFMODE == "OUTREG")
        Q = Q_outreg;
     else
        Q = Q_noreg;
     end

endmodule

