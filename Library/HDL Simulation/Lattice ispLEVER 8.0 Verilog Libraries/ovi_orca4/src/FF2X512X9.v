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
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/orca4/RCS/FF2X512X9.v,v 1.17 2005/05/19 19:01:19 pradeep Exp $ 
//
`timescale 1 ns / 1 ps

`celldefine

module FF2X512X9 (D18, D17, D16, D15, D14, D13, D12, D11, D10,
                  CKW1, CKR1, WRE1, RDE1, RSTN1,
                  PF18, PF17, PF16, PF15, PF14, PF13, PF12, PF11, PF10,
                  PE18, PE17, PE16, PE15, PE14, PE13, PE12, PE11, PE10,
                  D08, D07, D06, D05, D04, D03, D02, D01, D00,
                  CKW0, CKR0, WRE0, RDE0, RSTN0,
                  PF08, PF07, PF06, PF05, PF04, PF03, PF02, PF01, PF00,
                  PE08, PE07, PE06, PE05, PE04, PE03, PE02, PE01, PE00,
                  Q18, Q17, Q16, Q15, Q14, Q13, Q12, Q11, Q10, EF1, FF1, PEF1, PFF1,
                  Q08, Q07, Q06, Q05, Q04, Q03, Q02, Q01, Q00, EF0, FF0, PEF0, PFF0);

// INPUTS
input D18, D17, D16, D15, D14, D13, D12, D11, D10;
input D08, D07, D06, D05, D04, D03, D02, D01, D00;
input CKW1, CKR1, WRE1, RDE1, RSTN1;
input CKW0, CKR0, WRE0, RDE0, RSTN0;
input PF18, PF17, PF16, PF15, PF14, PF13, PF12, PF11, PF10;
input PE18, PE17, PE16, PE15, PE14, PE13, PE12, PE11, PE10;
input PF08, PF07, PF06, PF05, PF04, PF03, PF02, PF01, PF00;
input PE08, PE07, PE06, PE05, PE04, PE03, PE02, PE01, PE00;

// OUTPUTS
output Q18, Q17, Q16, Q15, Q14, Q13, Q12, Q11, Q10, EF1, FF1, PEF1, PFF1;
output Q08, Q07, Q06, Q05, Q04, Q03, Q02, Q01, Q00, EF0, FF0, PEF0, PFF0;

// PARAMETERS
parameter FFMODE0 = "NOREG";
parameter FFMODE1 = "NOREG";
parameter INHIBITMODE0 = "TRUE";
parameter INHIBITMODE1 = "TRUE";
parameter ASYNCMODE0 = "FALSE";

reg  port0_valid;
reg  first_time;
wire [8:0] DB_A;
wire [8:0] PEB_A;
wire [8:0] PFB_A;
reg [8:0] RADDR_A;
reg [8:0] WADDR_A;
reg [8:0] Q_A;
reg [8:0] Q_noreg_A;
reg [8:0] Q_outreg_A;
  reg [8:0] MEM_A [511:0];
  wire [10:0] pe_ptr_A;
  wire [10:0] pf_ptr_A;
  wire [9:0] write_address_A;
  wire [9:0] read_address_A;
  reg mc1_inhrw_fifo_A;
  reg mc1_reg_fifo_A;
  reg mc1_async_fifo_A;
  reg memchg_A;
wire [10:0] fifo_words_used_syncr_A;        // number of words used in fifo in ckr domain
wire [10:0] fifo_words_used_syncw_A;        // number of words used in fifo in ckw domain
wire [10:0] fifo_words_A;             // number of words in fifo
reg [10:0] int_write_address_A;       // internal write address - 1 extra bit
wire [10:0] int_write_address_plus1_A;       // internal write address - 1 extra bit
reg [10:0] int_write_address_syncb_A;       
reg [10:0] int_write_address_synca_A;       
reg [10:0] int_read_address_A;       // internal read address - 1 extra bit
wire [10:0] int_read_address_plus1_A;       // internal read address - 1 extra bit
reg [10:0] int_read_address_syncb_A;       
reg [10:0] int_read_address_synca_A;       
wire fifo_wre_A, fifo_rde_A;                // fifo enables - impacted by ff, ef
wire ef_int_A, pef_int_A,pff_int_A,ff_int_A;
reg ef_sync_A, pef_sync_A,pff_sync_A,ff_sync_A;
wire [10:0] int_write_address_sync_A; // internal write address + 1 extra bit - selected int_write_address
wire [10:0] int_read_address_sync_A; // internal read address + 1 extra bit -  selected int_read_address
reg  ef_reset_A;
reg  rd_reset_A;
reg ef_reset_rd_A;


wire [8:0] DB_B;
wire [8:0] PEB_B;
wire [8:0] PFB_B;
reg [8:0] RADDR_B;
reg [8:0] WADDR_B;
reg [8:0] Q_B;
reg [8:0] Q_noreg_B;
reg [8:0] Q_outreg_B;
  reg [8:0] MEM_B [511:0];
  wire [10:0] pe_ptr_B;
  wire [10:0] pf_ptr_B;
  wire [9:0] write_address_B;
  wire [9:0] read_address_B;
  reg mc1_inhrw_fifo_B;
  reg mc1_reg_fifo_B;
  reg mc1_async_fifo_B;
  reg memchg_B;
wire [10:0] fifo_words_used_syncr_B;        // number of words used in fifo in ckr domain
wire [10:0] fifo_words_used_syncw_B;        // number of words used in fifo in ckw domain
wire [10:0] fifo_words_B;             // number of words in fifo
reg [10:0] int_write_address_B;       // internal write address - 1 extra bit
wire [10:0] int_write_address_plus1_B;       // internal write address - 1 extra bit
reg [10:0] int_write_address_syncb_B;       
reg [10:0] int_write_address_synca_B;       
reg [10:0] int_read_address_B;       // internal read address - 1 extra bit
wire [10:0] int_read_address_plus1_B;       // internal read address - 1 extra bit
reg [10:0] int_read_address_syncb_B;       
reg [10:0] int_read_address_synca_B;       
wire fifo_wre_B, fifo_rde_B;                // fifo enables - impacted by ff, ef
wire ef_int_B, pef_int_B,pff_int_B,ff_int_B;
reg ef_sync_B, pef_sync_B,pff_sync_B,ff_sync_B;
wire [10:0] int_write_address_sync_B; // internal write address + 1 extra bit - selected int_write_address
wire [10:0] int_read_address_sync_B; // internal read address + 1 extra bit -  selected int_read_address
reg  ef_reset_B;
reg  rd_reset_B;
reg ef_reset_rd_B;
reg ASYNCMODE1;

  buf (DB_A[8], D08);
  buf (DB_A[7], D07);
  buf (DB_A[6], D06);
  buf (DB_A[5], D05);
  buf (DB_A[4], D04);
  buf (DB_A[3], D03);
  buf (DB_A[2], D02);
  buf (DB_A[1], D01);
  buf (DB_A[0], D00);
  buf (CKWB_A, CKW0);
  buf (CKRB_A, CKR0);
  buf (WREB_A, WRE0);
  buf (RDEB_A, RDE0);
  buf (RSTNB_A, RSTN0);
  buf (PEB_A[8], PE08);
  buf (PEB_A[7], PE07);
  buf (PEB_A[6], PE06);
  buf (PEB_A[5], PE05);
  buf (PEB_A[4], PE04);
  buf (PEB_A[3], PE03);
  buf (PEB_A[2], PE02);
  buf (PEB_A[1], PE01);
  buf (PEB_A[0], PE00);
  buf (PFB_A[8], PF08);
  buf (PFB_A[7], PF07);
  buf (PFB_A[6], PF06);
  buf (PFB_A[5], PF05);
  buf (PFB_A[4], PF04);
  buf (PFB_A[3], PF03);
  buf (PFB_A[2], PF02);
  buf (PFB_A[1], PF01);
  buf (PFB_A[0], PF00);

  buf (Q8_out_A, Q_A[8]);
  buf (Q7_out_A, Q_A[7]);
  buf (Q6_out_A, Q_A[6]);
  buf (Q5_out_A, Q_A[5]);
  buf (Q4_out_A, Q_A[4]);
  buf (Q3_out_A, Q_A[3]);
  buf (Q2_out_A, Q_A[2]);
  buf (Q1_out_A, Q_A[1]);
  buf (Q0_out_A, Q_A[0]);

  buf (Q08, Q8_out_A);
  buf (Q07, Q7_out_A);
  buf (Q06, Q6_out_A);
  buf (Q05, Q5_out_A);
  buf (Q04, Q4_out_A);
  buf (Q03, Q3_out_A);
  buf (Q02, Q2_out_A);
  buf (Q01, Q1_out_A);
  buf (Q00, Q0_out_A);

  initial
  begin
     memchg_A = 1'b0;
     first_time = 1'b1;
     port0_valid = 1'b0;

     if (INHIBITMODE0 == "TRUE")
        mc1_inhrw_fifo_A = 1'b0;
     else
        mc1_inhrw_fifo_A = 1'b1;

     if (FFMODE0 == "OUTREG")
        mc1_reg_fifo_A = 1'b1;
     else
        mc1_reg_fifo_A = 1'b0;

     if (ASYNCMODE0 == "TRUE")
        mc1_async_fifo_A = 1'b1;
     else
        mc1_async_fifo_A = 1'b0;

  end

  buf (DB_B[8], D18);
  buf (DB_B[7], D17);
  buf (DB_B[6], D16);
  buf (DB_B[5], D15);
  buf (DB_B[4], D14);
  buf (DB_B[3], D13);
  buf (DB_B[2], D12);
  buf (DB_B[1], D11);
  buf (DB_B[0], D10);
  buf (CKWB_B, CKW1);
  buf (CKRB_B, CKR1);
  buf (WREB_B, WRE1);
  buf (RDEB_B, RDE1);
  buf (RSTNB_B, RSTN1);
  buf (PEB_B[8], PE18);
  buf (PEB_B[7], PE17);
  buf (PEB_B[6], PE16);
  buf (PEB_B[5], PE15);
  buf (PEB_B[4], PE14);
  buf (PEB_B[3], PE13);
  buf (PEB_B[2], PE12);
  buf (PEB_B[1], PE11);
  buf (PEB_B[0], PE10);
  buf (PFB_B[8], PF18);
  buf (PFB_B[7], PF17);
  buf (PFB_B[6], PF16);
  buf (PFB_B[5], PF15);
  buf (PFB_B[4], PF14);
  buf (PFB_B[3], PF13);
  buf (PFB_B[2], PF12);
  buf (PFB_B[1], PF11);
  buf (PFB_B[0], PF10);

  buf (Q8_out_B, Q_B[8]);
  buf (Q7_out_B, Q_B[7]);
  buf (Q6_out_B, Q_B[6]);
  buf (Q5_out_B, Q_B[5]);
  buf (Q4_out_B, Q_B[4]);
  buf (Q3_out_B, Q_B[3]);
  buf (Q2_out_B, Q_B[2]);
  buf (Q1_out_B, Q_B[1]);
  buf (Q0_out_B, Q_B[0]);

  buf (Q18, Q8_out_B);
  buf (Q17, Q7_out_B);
  buf (Q16, Q6_out_B);
  buf (Q15, Q5_out_B);
  buf (Q14, Q4_out_B);
  buf (Q13, Q3_out_B);
  buf (Q12, Q2_out_B);
  buf (Q11, Q1_out_B);
  buf (Q10, Q0_out_B);

  initial
  begin
     memchg_B = 1'b0;
     ASYNCMODE1 = "FALSE";

     if (INHIBITMODE1 == "TRUE")
        mc1_inhrw_fifo_B = 1'b0;
     else
        mc1_inhrw_fifo_B = 1'b1;

     if (FFMODE1 == "OUTREG")
        mc1_reg_fifo_B = 1'b1;
     else
        mc1_reg_fifo_B = 1'b0;

     if (ASYNCMODE1 == "TRUE")
        mc1_async_fifo_B = 1'b1;
     else
        mc1_async_fifo_B = 1'b0;

  end



wire reset_A=~RSTNB_A;
wire fifo_reset_A = reset_A;
wire rd_reset_int_A = fifo_reset_A | rd_reset_A;

// generate sync versions of the number of words used in read and write ck domains
// number of words in fifo  = write counter value - read counter value
assign fifo_words_used_syncr_A={int_write_address_sync_A[10]^int_read_address_A[10],int_write_address_sync_A[9:0]} - {1'b0,int_read_address_A[9:0]};

assign fifo_words_A=11'd512;

// number of words in fifo  = write counter value - read counter value
assign fifo_words_used_syncw_A={int_read_address_sync_A[10]^int_write_address_A[10],int_write_address_A[9:0]} - {1'b0,int_read_address_sync_A[9:0]};

// generate EF/PEF
assign ef_int_A=(fifo_words_used_syncr_A[10:1]==0)&~(((mc1_async_fifo_A)?ef_reset_rd_A:ef_reset_A) &rd_reset_A);
assign pef_int_A=(fifo_words_used_syncr_A[9:0]<pe_ptr_A);

assign EF0=(mc1_reg_fifo_A)?ef_sync_A:ef_int_A;
assign PEF0=(mc1_reg_fifo_A)?pef_sync_A:pef_int_A;

// generate FF/PFF
assign ff_int_A=(fifo_words_used_syncw_A==fifo_words_A)?1:0;
assign pff_int_A=(fifo_words_used_syncw_A[9:0]>=pf_ptr_A);

assign FF0=(mc1_reg_fifo_A)?ff_sync_A:ff_int_A;
assign PFF0=(mc1_reg_fifo_A)?pff_sync_A:pff_int_A;

assign fifo_wre_A=(WRE0 & (~(ff_int_A & PFF0) | mc1_inhrw_fifo_A));  // enable write if csw and not full

assign fifo_rde_A=(RDE0 & (~(EF0 & PEF0) | mc1_inhrw_fifo_A));  // enable read if csw and not full

assign pe_ptr_A = {1'b0, PEB_A};
assign pf_ptr_A = {1'b0, PFB_A};

always @(posedge CKRB_B)
begin
   if (first_time == 1'b1)
   begin
      port0_valid <= 1'b1;
      first_time <= 1'b0;
   end
end

always @( posedge CKWB_A or posedge fifo_reset_A)
        begin
        if (fifo_reset_A) ef_reset_A<=1'b0;
        else if (fifo_wre_A) ef_reset_A<=1'b1;
        end

always @( posedge CKRB_A )
    begin
    ef_reset_rd_A=ef_reset_A;
    end

always @( posedge CKRB_A or posedge fifo_reset_A)
        begin
        if (fifo_reset_A) rd_reset_A<=1'b1;
        else if (fifo_rde_A & ((ef_reset_rd_A&mc1_async_fifo_A)|(ef_reset_A&~mc1_async_fifo_A))) rd_reset_A<=1'b0;
        end

// generate sync flags
always @(posedge CKRB_A or negedge RSTNB_A)
    begin
    if (!RSTNB_A) ef_sync_A <= 1;
    else ef_sync_A <= ef_int_A;
    end

always @(posedge CKRB_A or negedge RSTNB_A)
    begin
    if (!RSTNB_A) pef_sync_A <= 1;
    else pef_sync_A <= pef_int_A;
    end

always @(posedge CKWB_A or negedge RSTNB_A)
    begin
    if (!RSTNB_A) ff_sync_A <= 0;
    else ff_sync_A <= ff_int_A;
    end

always @(posedge CKWB_A or negedge RSTNB_A)
    begin
    if (!RSTNB_A) pff_sync_A <= 0;
    else pff_sync_A <= pff_int_A;
    end

// Generate FIFO write address with 12 bit counter
assign int_write_address_plus1_A = int_write_address_A + 1;

assign int_write_address_sync_A = (mc1_async_fifo_A) ? int_write_address_syncb_A : int_write_address_A;
assign int_read_address_sync_A = (mc1_async_fifo_A) ? int_read_address_syncb_A : int_read_address_A;

always @ (posedge CKWB_A or negedge RSTNB_A)
        begin
        if(!RSTNB_A) int_write_address_A <= 0;  // no reset for Gray code counter
        else if (fifo_wre_A) int_write_address_A <= int_write_address_plus1_A;
        end


always @ (posedge CKWB_A or negedge RSTNB_A)
        begin
        if(!RSTNB_A) int_write_address_synca_A <= 0;  
        else  if (fifo_wre_A) int_write_address_synca_A <= int_write_address_plus1_A ;
        end

always @ (posedge CKRB_A or negedge RSTNB_A)
        begin
        if(!RSTNB_A) int_write_address_syncb_A <= 0;
        else  int_write_address_syncb_A <= int_write_address_synca_A ;
        end

// Generate FIFO read address with 12 bit counter

assign int_read_address_plus1_A = int_read_address_A + 1;

always @ (posedge CKRB_A or posedge rd_reset_int_A)
        begin
        if(rd_reset_int_A) int_read_address_A <= 0;
        else if (fifo_rde_A) int_read_address_A <= int_read_address_plus1_A;
        end

always @ (posedge CKRB_A or negedge RSTNB_A)
        begin
        if(!RSTNB_A) int_read_address_synca_A <= 0;
        else if (fifo_rde_A) int_read_address_synca_A <= int_read_address_plus1_A ;
        end

always @ (posedge CKWB_A or negedge RSTNB_A)
        begin
        if(!RSTNB_A) int_read_address_syncb_A <= 0;
        else int_read_address_syncb_A <= int_read_address_synca_A ;
        end

assign read_address_A = int_read_address_A[8:0];
assign write_address_A = int_write_address_A[8:0];

 always @(posedge CKRB_A or negedge RSTNB_A) begin
  if (RSTNB_A == 1'b0)
  begin
     RADDR_A <= 9'b0;
  end
  else
     if (fifo_rde_A == 1'b1)
     begin
        RADDR_A <= read_address_A;
     end
  end

 always @(posedge CKWB_A or negedge RSTNB_A) begin
  if (RSTNB_A == 1'b0)
     WADDR_A <= 9'b0;
  else
  begin
   if (fifo_wre_A == 1'b1)
     begin
        WADDR_A = write_address_A;
        MEM_A[write_address_A] = DB_A;
     end
  end
  end

 always @(RSTNB_A or posedge CKRB_A or read_address_A) begin
  if (RSTNB_A == 1'b0)
  begin
     Q_noreg_A <= 18'b0;
  end
  else
     Q_noreg_A = MEM_A[read_address_A];
  end

 always @(posedge CKRB_A or negedge RSTNB_A) begin
  if (RSTNB_A == 1'b0)
  begin
     Q_outreg_A <= 18'b0;
  end
  else
     Q_outreg_A <= Q_noreg_A;
  end

 always @(Q_outreg_A or Q_noreg_A) begin
     if (FFMODE0 == "OUTREG")
     begin
        if (ASYNCMODE0 == "TRUE")
        begin
           if (port0_valid == 1'b1)
              Q_A = Q_outreg_A;
        end
        else if (ASYNCMODE0 == "FALSE")
        begin
           Q_A = Q_outreg_A;
        end
     end
     else
        Q_A = Q_noreg_A;
     end


wire reset_B=~RSTNB_B;
wire fifo_reset_B = reset_B;
wire rd_reset_int_B = fifo_reset_B | rd_reset_B;

// generate sync versions of the number of words used in read and write ck domains
// number of words in fifo  = write counter value - read counter value
assign fifo_words_used_syncr_B={int_write_address_sync_B[10]^int_read_address_B[10],int_write_address_sync_B[9:0]} - {1'b0,int_read_address_B[9:0]};

assign fifo_words_B=11'd512;

// number of words in fifo  = write counter value - read counter value
assign fifo_words_used_syncw_B={int_read_address_sync_B[10]^int_write_address_B[10],int_write_address_B[9:0]} - {1'b0,int_read_address_sync_B[9:0]};

// generate EF/PEF
assign ef_int_B=(fifo_words_used_syncr_B[10:1]==0)&~(((mc1_async_fifo_B)?ef_reset_rd_B:ef_reset_B) &rd_reset_B);
assign pef_int_B=(fifo_words_used_syncr_B[9:0]<pe_ptr_B);

assign EF1=(mc1_reg_fifo_B)?ef_sync_B:ef_int_B;
assign PEF1=(mc1_reg_fifo_B)?pef_sync_B:pef_int_B;

// generate FF/PFF
assign ff_int_B=(fifo_words_used_syncw_B==fifo_words_B)?1:0;
assign pff_int_B=(fifo_words_used_syncw_B[9:0]>=pf_ptr_B);

assign FF1=(mc1_reg_fifo_B)?ff_sync_B:ff_int_B;
assign PFF1=(mc1_reg_fifo_B)?pff_sync_B:pff_int_B;

assign fifo_wre_B=(WRE1 & (~(ff_int_B & PFF1) | mc1_inhrw_fifo_B));  // enable write if csw and not full

assign fifo_rde_B=(RDE1 & (~(EF1 & PEF1) | mc1_inhrw_fifo_B));  // enable read if csw and not full

assign pe_ptr_B = {1'b0, PEB_B};
assign pf_ptr_B = {1'b0, PFB_B};


always @( posedge CKWB_B or posedge fifo_reset_B)
        begin
        if (fifo_reset_B) ef_reset_B<=1'b0;
        else if (fifo_wre_B) ef_reset_B<=1'b1;
        end

always @( posedge CKRB_B )
    begin
    ef_reset_rd_B=ef_reset_B;
    end

always @( posedge CKRB_B or posedge fifo_reset_B)
        begin
        if (fifo_reset_B) rd_reset_B<=1'b1;
        else if (fifo_rde_B & ((ef_reset_rd_B&mc1_async_fifo_B)|(ef_reset_B&~mc1_async_fifo_B))) rd_reset_B<=1'b0;
        end

// generate sync flags
always @(posedge CKRB_B or negedge RSTNB_B)
    begin
    if (!RSTNB_B) ef_sync_B <= 1;
    else ef_sync_B <= ef_int_B;
    end

always @(posedge CKRB_B or negedge RSTNB_B)
    begin
    if (!RSTNB_B) pef_sync_B <= 1;
    else pef_sync_B <= pef_int_B;
    end

always @(posedge CKWB_B or negedge RSTNB_B)
    begin
    if (!RSTNB_B) ff_sync_B <= 0;
    else ff_sync_B <= ff_int_B;
    end

always @(posedge CKWB_B or negedge RSTNB_B)
    begin
    if (!RSTNB_B) pff_sync_B <= 0;
    else pff_sync_B <= pff_int_B;
    end

// Generate FIFO write address with 12 bit counter
assign int_write_address_plus1_B = int_write_address_B + 1;

assign int_write_address_sync_B = (mc1_async_fifo_B) ? int_write_address_syncb_B : int_write_address_B;
assign int_read_address_sync_B = (mc1_async_fifo_B) ? int_read_address_syncb_B : int_read_address_B;

always @ (posedge CKWB_B or negedge RSTNB_B)
        begin
        if(!RSTNB_B) int_write_address_B <= 0;  // no reset for Gray code counter
        else if (fifo_wre_B) int_write_address_B <= int_write_address_plus1_B;
        end


always @ (posedge CKWB_B or negedge RSTNB_B)
        begin
        if(!RSTNB_B) int_write_address_synca_B <= 0;  
        else  if (fifo_wre_B) int_write_address_synca_B <= int_write_address_plus1_B ;
        end

always @ (posedge CKRB_B or negedge RSTNB_B)
        begin
        if(!RSTNB_B) int_write_address_syncb_B <= 0;
        else  int_write_address_syncb_B <= int_write_address_synca_B ;
        end

// Generate FIFO read address with 12 bit counter

assign int_read_address_plus1_B = int_read_address_B + 1;

always @ (posedge CKRB_B or posedge rd_reset_int_B)
        begin
        if(rd_reset_int_B) int_read_address_B <= 0;
        else if (fifo_rde_B) int_read_address_B <= int_read_address_plus1_B;
        end

always @ (posedge CKRB_B or negedge RSTNB_B)
        begin
        if(!RSTNB_B) int_read_address_synca_B <= 0;
        else if (fifo_rde_B) int_read_address_synca_B <= int_read_address_plus1_B ;
        end

always @ (posedge CKWB_B or negedge RSTNB_B)
        begin
        if(!RSTNB_B) int_read_address_syncb_B <= 0;
        else int_read_address_syncb_B <= int_read_address_synca_B ;
        end

assign read_address_B = int_read_address_B[8:0];
assign write_address_B = int_write_address_B[8:0];

 always @(posedge CKRB_B or negedge RSTNB_B) begin
  if (RSTNB_B == 1'b0)
  begin
     RADDR_B <= 9'b0;
  end
  else
     if (fifo_rde_B == 1'b1)
     begin
        RADDR_B <= read_address_B;
     end
  end

 always @(posedge CKWB_B or negedge RSTNB_B) begin
  if (RSTNB_B == 1'b0)
     WADDR_B <= 9'b0;
  else
  begin
   if (fifo_wre_B == 1'b1)
     begin
        WADDR_B = write_address_B;
        MEM_B[write_address_B] = DB_B;
     end
  end
  end

 always @(RSTNB_B or posedge CKRB_B or read_address_B) begin
  if (RSTNB_B == 1'b0)
  begin
     Q_noreg_B <= 18'b0;
  end
  else
     Q_noreg_B = MEM_B[read_address_B];
  end

 always @(posedge CKRB_B or negedge RSTNB_B) begin
  if (RSTNB_B == 1'b0)
  begin
     Q_outreg_B <= 18'b0;
  end
  else
     Q_outreg_B <= Q_noreg_B;
  end

 always @(Q_outreg_B or Q_noreg_B) begin
     if (FFMODE1 == "OUTREG")
        Q_B = Q_outreg_B;
     else
        Q_B = Q_noreg_B;
     end

endmodule

