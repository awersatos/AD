// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/BRAM_TDP_MACRO.v,v 1.13 2010/01/20 18:29:26 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2007 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Macro for True Dual Port Block RAM 
// /___/   /\     Filename : BRAM_TDP_MACRO.v
// \   \  /  \    Timestamp : Wed April 04 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//    04/04/08 - Initial version.
//    02/05/09 - Corrected RDADDRECC width.
// End Revision


`timescale 1 ps/1 ps

module BRAM_TDP_MACRO (DOA, DOB,
                   ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, ENA, ENB, REGCEA, REGCEB, RSTA, RSTB, WEA, WEB); 

   parameter BRAM_SIZE = "18Kb";  
   parameter DEVICE = "VIRTEX5";
   parameter DOA_REG = 0;
   parameter DOB_REG = 0;
   parameter INIT_A = 36'h0;
   parameter INIT_B = 36'h0;
   parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_40 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_41 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_42 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_43 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_44 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_45 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_46 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_47 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_48 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_49 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_4A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_4B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_4C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_4D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_4E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_4F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_50 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_51 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_52 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_53 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_54 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_55 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_56 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_57 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_58 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_59 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_5A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_5B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_5C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_5D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_5E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_5F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_60 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_61 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_62 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_63 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_64 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_65 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_66 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_67 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_68 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_69 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_6A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_6B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_6C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_6D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_6E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_6F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_70 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_71 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_72 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_73 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_74 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_75 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_76 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_77 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_78 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_79 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_7A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_7B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_7C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_7D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_7E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_7F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INITP_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
   parameter INIT_FILE = "NONE";
   parameter READ_WIDTH_A  = 1;
   parameter READ_WIDTH_B  = 1;
   parameter SIM_COLLISION_CHECK = "ALL";
   parameter SIM_MODE = "FAST"; // This parameter is valid only for Virtex5
   parameter SRVAL_A = 36'h0;
   parameter SRVAL_B = 36'h0;
   parameter WRITE_MODE_A = "WRITE_FIRST";
   parameter WRITE_MODE_B = "WRITE_FIRST";
   parameter WRITE_WIDTH_A = 1;
   parameter WRITE_WIDTH_B = 1;
  
   // Parameter Checks for invalid combinations
   
   localparam WRITEA_P =  (WRITE_WIDTH_A == 9 || WRITE_WIDTH_A == 17 || WRITE_WIDTH_A == 18 || WRITE_WIDTH_A == 33 || WRITE_WIDTH_A == 34 || WRITE_WIDTH_A == 35 || WRITE_WIDTH_A == 36) ? "TRUE" : "FALSE";
   localparam WRITEB_P =  (WRITE_WIDTH_B == 9 || WRITE_WIDTH_B == 17 || WRITE_WIDTH_B == 18 || WRITE_WIDTH_B == 33 || WRITE_WIDTH_B == 34 || WRITE_WIDTH_B == 35 || WRITE_WIDTH_B == 36) ? "TRUE" : "FALSE";
   localparam READA_P =  (READ_WIDTH_A == 9 || READ_WIDTH_A == 17 || READ_WIDTH_A == 18 || READ_WIDTH_A == 33 || READ_WIDTH_A == 34 || READ_WIDTH_A == 35 || READ_WIDTH_A == 36) ? "TRUE" : "FALSE";
   localparam READB_P =  (READ_WIDTH_B == 9 || READ_WIDTH_B == 17 || READ_WIDTH_B == 18 || READ_WIDTH_B == 33 || READ_WIDTH_B == 34 || READ_WIDTH_B == 35 || READ_WIDTH_B == 36) ? "TRUE" : "FALSE";

   initial
     begin
       if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6");
       else
        begin 
           $display("Attribute Syntax Error : The attribute DEVICE on BRAM_TDP_MACRO instance %m is set to %d.  Allowed values of this attribute are VIRTEX5, VIRTEX6, SPARTAN6.", DEVICE);
           $finish;
        end

       if (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6")
        begin
          case ({WRITEA_P, WRITEB_P, READA_P, READB_P})

            {"FALSE", "FALSE", "FALSE", "FALSE"} , {"FALSE", "TRUE", "TRUE", "FALSE"} , {"TRUE", "FALSE", "TRUE", "FALSE"} , {"FALSE", "TRUE", "FALSE", "TRUE"} , {"TRUE", "FALSE", "FALSE", "TRUE"} , {"TRUE", "TRUE", "FALSE", "TRUE"} , {"TRUE", "TRUE", "TRUE", "FALSE"},  {"TRUE", "FALSE", "TRUE", "TRUE"},  {"FALSE", "TRUE", "TRUE", "TRUE"}, {"TRUE", "TRUE", "TRUE", "TRUE"} :  ;

            {"FALSE", "TRUE", "FALSE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on WRITE_WIDTH_B: The width WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  The parity bit(s) cannot be read ", WRITE_WIDTH_B);
	      end
            {"TRUE", "FALSE", "FALSE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on WRITE_WIDTH_A: The width WRITE_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  The parity bit(s) cannot be read ", WRITE_WIDTH_A);
	      end
            {"TRUE", "TRUE", "FALSE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on WRITE_WIDTH_A and WRITE_WIDTH_B: The widths WRITE_WIDTH_A, WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m are set to %d, %d. The parity bit(s) cannot be read. ", WRITE_WIDTH_A, WRITE_WIDTH_B);
	      end
            {"FALSE", "FALSE", "TRUE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on READ_WIDTH_A : The width READ_WIDTH_A on BRAM_TDP_MACRO instance %m are set to %d.  The parity bit(s) has not been written and hence cannot be read ", READ_WIDTH_A);
	      end
            {"FALSE", "FALSE", "FALSE", "TRUE"}: 
              begin 
	        $display("Port Width Mismatch on READ_WIDTH_B : The width READ_WIDTH_B on BRAM_TDP_MACRO instance %m are set to %d.  The parity bit(s) has not been written and hence cannot be read", READ_WIDTH_B);
	      end
             {"FALSE", "FALSE", "TRUE", "TRUE"}: 
               begin 
	         $display("Port Width Mismatch on READ_WIDTH_A and READ_WIDTH_B: The widths READ_WIDTH_A, READ_WIDTH_B on BRAM_TDP_MACRO instance %m are set to %d, %d.  The parity bit(s) have not been written and hence cannot be read. ", READ_WIDTH_A, READ_WIDTH_B);
	       end
 
          endcase
          if(BRAM_SIZE == "18Kb" || BRAM_SIZE == "36Kb") ;
          else
            begin
	      $display("Attribute Syntax Error : The attribute BRAM_SIZE on BRAM_TDP_MACRO instance %m is set to %s.  Legal values for this attribute are 18Kb or 36Kb", BRAM_SIZE);
              $finish;
            end
          if (READ_WIDTH_A == 0 )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must be atleast equal to 1.", READ_WIDTH_A);
              $finish;
            end
          else if (READ_WIDTH_A > 18 && BRAM_SIZE == "18Kb" )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  For BRAM_SIZE of 18Kb, allowed values of this attribute are 1 to 18.", READ_WIDTH_A);
              $finish;
            end
          else if (READ_WIDTH_A > 36)
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 18Kb and 1 to 36 for BRAM_SIZE of 36Kb.", READ_WIDTH_A);
              $finish;
            end
          if (READ_WIDTH_B == 0 )
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must be atleast equal to 1.", READ_WIDTH_B);
              $finish;
            end
          else if (READ_WIDTH_B > 18 && BRAM_SIZE == "18Kb" )
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  For BRAM_SIZE of 18Kb, Allowed values of this attribute are 1 to 18.", READ_WIDTH_B);
              $finish;
            end
          else if (READ_WIDTH_B > 36)
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 18Kb and 1 to 36 for BRAM_SIZE of 36Kb.", READ_WIDTH_B);
              $finish;
            end
          if (WRITE_WIDTH_A == 0 )
	    begin 
              $display("Attribute Syntax Error : The attribute WRITE_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must atleast be equal to 1.", WRITE_WIDTH_A);
              $finish;
            end
          else if (WRITE_WIDTH_A > 18 && BRAM_SIZE == "18Kb" )
	    begin 
              $display("Attribute Syntax Error : The attribute WRITE_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  For BRAM_SIZE of 18Kb, allowed values of this attribute are 1 to 18.", WRITE_WIDTH_A);
              $finish;
            end
          else if (WRITE_WIDTH_A > 36)
	    begin 
              $display("Attribute Syntax Error : The attribute WRITE_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 18Kb and 1 to 36 for BRAM_SIZE of 36Kb.", WRITE_WIDTH_A);
              $finish;
            end
          if (WRITE_WIDTH_B == 0)
	    begin 
              $display("Attribute Syntax Error : The attribute WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must atleast be equal to 1.", WRITE_WIDTH_B);
              $finish;
            end
          else if (WRITE_WIDTH_B > 18 && BRAM_SIZE == "18Kb" )
	   begin 
             $display("Attribute Syntax Error : The attribute WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  For BRAM_SIZE of 18Kb, allowed values of this attribute are 1 to 18.", WRITE_WIDTH_B);
             $finish;
           end
          else if (WRITE_WIDTH_B > 36)
	    begin 
              $display("Attribute Syntax Error : The attribute WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 18Kb and 1 to 36 for BRAM_SIZE of 36Kb.", WRITE_WIDTH_B);
             $finish;
            end
         end // end checks Virtex5
      if (DEVICE == "SPARTAN6")
        begin
          if(BRAM_SIZE == "18Kb" || BRAM_SIZE == "9Kb") ;
          else
            begin
	      $display("Attribute Syntax Error : The attribute BRAM_SIZE on BRAM_TDP_MACRO instance %m is set to %s.  Legal values for this attribute are 9Kb or 18Kb", BRAM_SIZE);
              $finish;
            end
          if (READ_WIDTH_A != WRITE_WIDTH_A )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  READ_WIDTH_A must be equal to WRITE_WIDTH_A", READ_WIDTH_A);
              $finish;
            end
          else if (READ_WIDTH_A == 0 )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must be atleast equal to 1.", READ_WIDTH_A);
              $finish;
            end
          else if (READ_WIDTH_A > 18 && BRAM_SIZE == "9Kb" )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  For BRAM_SIZE of 9Kb, allowed values of this attribute are 1 to 18.", READ_WIDTH_A);
              $finish;
            end
          else if (READ_WIDTH_A > 36)
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 9Kb and 1 to 36 for BRAM_SIZE of 18Kb.", READ_WIDTH_A);
              $finish;
            end
          if (READ_WIDTH_B != WRITE_WIDTH_B )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  READ_WIDTH_B must be equal to WRITE_WIDTH_B", READ_WIDTH_B);
              $finish;
            end
          else if (READ_WIDTH_B == 0 )
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must be atleast equal to 1.", READ_WIDTH_B);
              $finish;
            end
          else if (READ_WIDTH_B > 18 && BRAM_SIZE == "9Kb" )
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  For BRAM_SIZE of 9Kb, Allowed values of this attribute are 1 to 18.", READ_WIDTH_B);
              $finish;
            end
          else if (READ_WIDTH_B > 36)
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 9Kb and 1 to 36 for BRAM_SIZE of 18Kb.", READ_WIDTH_B);
              $finish;
            end
          if (WRITE_WIDTH_A == 0 )
	    begin 
              $display("Attribute Syntax Error : The attribute WRITE_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must atleast be equal to 1.", WRITE_WIDTH_A);
              $finish;
            end
          if (WRITE_WIDTH_B == 0)
	    begin 
              $display("Attribute Syntax Error : The attribute WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  This attribute must atleast be equal to 1.", WRITE_WIDTH_B);
              $finish;
            end
          case ({WRITEA_P, WRITEB_P, READA_P, READB_P})

            {"FALSE", "FALSE", "FALSE", "FALSE"} , {"FALSE", "TRUE", "TRUE", "FALSE"} , {"TRUE", "FALSE", "TRUE", "FALSE"} , {"FALSE", "TRUE", "FALSE", "TRUE"} , {"TRUE", "FALSE", "FALSE", "TRUE"} , {"TRUE", "TRUE", "FALSE", "TRUE"} , {"TRUE", "TRUE", "TRUE", "FALSE"},  {"TRUE", "FALSE", "TRUE", "TRUE"},  {"FALSE", "TRUE", "TRUE", "TRUE"}, {"TRUE", "TRUE", "TRUE", "TRUE"} :  ;

            {"FALSE", "TRUE", "FALSE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on WRITE_WIDTH_B: The width WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m is set to %d.  The parity bit(s) cannot be read ", WRITE_WIDTH_B);
	      end
            {"TRUE", "FALSE", "FALSE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on WRITE_WIDTH_A: The width WRITE_WIDTH_A on BRAM_TDP_MACRO instance %m is set to %d.  The parity bit(s) cannot be read ", WRITE_WIDTH_A);
	      end
            {"TRUE", "TRUE", "FALSE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on WRITE_WIDTH_A and WRITE_WIDTH_B: The widths WRITE_WIDTH_A, WRITE_WIDTH_B on BRAM_TDP_MACRO instance %m are set to %d, %d. The parity bit(s) cannot be read. ", WRITE_WIDTH_A, WRITE_WIDTH_B);
	      end
            {"FALSE", "FALSE", "TRUE", "FALSE"}: 
              begin 
	        $display("Port Width Mismatch on READ_WIDTH_A : The width READ_WIDTH_A on BRAM_TDP_MACRO instance %m are set to %d.  The parity bit(s) has not been written and hence cannot be read ", READ_WIDTH_A);
	      end
            {"FALSE", "FALSE", "FALSE", "TRUE"}: 
              begin 
	        $display("Port Width Mismatch on READ_WIDTH_B : The width READ_WIDTH_B on BRAM_TDP_MACRO instance %m are set to %d.  The parity bit(s) has not been written and hence cannot be read", READ_WIDTH_B);
	      end
             {"FALSE", "FALSE", "TRUE", "TRUE"}: 
               begin 
	         $display("Port Width Mismatch on READ_WIDTH_A and READ_WIDTH_B: The widths READ_WIDTH_A, READ_WIDTH_B on BRAM_TDP_MACRO instance %m are set to %d, %d.  The parity bit(s) have not been written and hence cannot be read. ", READ_WIDTH_A, READ_WIDTH_B);
	       end
 
          endcase
         end //  end checks spartan6 

     end
  

   localparam rd_width_a =  (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH_A == 0) ? 0 : (READ_WIDTH_A == 1) ? 1 : (READ_WIDTH_A == 2) ? 2 : (READ_WIDTH_A > 2 && READ_WIDTH_A <= 4) ? 4 : (READ_WIDTH_A > 4 && READ_WIDTH_A <= 9) ? 9 : (READ_WIDTH_A > 9 && READ_WIDTH_A <= 18) ? 18 : (READ_WIDTH_A > 18 && READ_WIDTH_A <= 36) ? 36 : (BRAM_SIZE == "18Kb") ? 18 : 36 ) : 36;

   localparam rd_width_b = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH_B == 0) ? 0 : (READ_WIDTH_B == 1) ? 1 : (READ_WIDTH_B == 2) ? 2 : (READ_WIDTH_B > 2 && READ_WIDTH_B <= 4) ? 4 : (READ_WIDTH_B > 4 && READ_WIDTH_B <= 9) ? 9 : (READ_WIDTH_B > 9 && READ_WIDTH_B <= 18) ? 18 : (READ_WIDTH_B > 18 && READ_WIDTH_B <= 36) ? 36 : (BRAM_SIZE == "18Kb") ? 18 : 36 ) : 36;

   localparam wr_width_a = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_A == 0) ? 0 : (WRITE_WIDTH_A == 1) ? 1 : (WRITE_WIDTH_A == 2) ? 2 : (WRITE_WIDTH_A > 2 && WRITE_WIDTH_A <= 4) ? 4 : (WRITE_WIDTH_A > 4 && WRITE_WIDTH_A <= 9) ? 9 : (WRITE_WIDTH_A > 9 && WRITE_WIDTH_A <= 18) ? 18 : (WRITE_WIDTH_A > 18 && WRITE_WIDTH_A <= 36) ? 36 : (BRAM_SIZE == "18Kb") ? 18 : 36 ) : 36;
   
   localparam wr_width_b = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_B == 0) ? 0 : (WRITE_WIDTH_B == 1) ? 1 : (WRITE_WIDTH_B == 2) ? 2 : (WRITE_WIDTH_B > 2 && WRITE_WIDTH_B <= 4) ? 4 : (WRITE_WIDTH_B > 4 && WRITE_WIDTH_B <= 9) ? 9 : (WRITE_WIDTH_B > 9 && WRITE_WIDTH_B <= 18) ? 18 : (WRITE_WIDTH_B > 18 && WRITE_WIDTH_B <= 36) ? 36 : (BRAM_SIZE == "18Kb") ? 18 : 36 ) : 36;

   // Widths of Data Bus
   localparam DIA_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_A == 1) ? 1 : (WRITE_WIDTH_A == 2) ? 2 : (WRITE_WIDTH_A > 2 && WRITE_WIDTH_A <= 4) ? 4 : (WRITE_WIDTH_A > 4 && WRITE_WIDTH_A <= 9) ? 8 : (WRITE_WIDTH_A > 9 && WRITE_WIDTH_A <= 18) ? 16 : (WRITE_WIDTH_A > 18 && WRITE_WIDTH_A <= 36) ? 32 : (BRAM_SIZE == "18Kb") ? 16 : 32 ) : 32;

   localparam DIB_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_B == 1) ? 1 : (WRITE_WIDTH_B == 2) ? 2 : (WRITE_WIDTH_B > 2 && WRITE_WIDTH_B <= 4) ? 4 : (WRITE_WIDTH_B > 4 && WRITE_WIDTH_B <= 9) ? 8 : (WRITE_WIDTH_B > 9 && WRITE_WIDTH_B <= 18) ? 16 : (WRITE_WIDTH_B > 18 && WRITE_WIDTH_B <= 36) ? 32 : (BRAM_SIZE == "18Kb") ? 16 : 32 ) : 32;

   localparam DOA_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH_A == 1) ? 1 : (READ_WIDTH_A == 2) ? 2 : (READ_WIDTH_A > 2 && READ_WIDTH_A <= 4) ? 4 : (READ_WIDTH_A > 4 && READ_WIDTH_A <= 9) ? 8 : (READ_WIDTH_A > 9 && READ_WIDTH_A <= 18) ? 16 : (READ_WIDTH_A > 18 && READ_WIDTH_A <= 36) ? 32 : (BRAM_SIZE == "18Kb") ? 16 : 32 ) : 32;

   localparam DOB_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH_B == 1) ? 1 : (READ_WIDTH_B == 2) ? 2 : (READ_WIDTH_B > 2 && READ_WIDTH_B <= 4) ? 4 : (READ_WIDTH_B > 4 && READ_WIDTH_B <= 9) ? 8 : (READ_WIDTH_B > 9 && READ_WIDTH_B <= 18) ? 16 : (READ_WIDTH_B > 18 && READ_WIDTH_B <= 36) ? 32 : (BRAM_SIZE == "18Kb") ? 16 : 32 ) : 32;


   // Widths of Parity Bus
   localparam DIPA_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_A < 9) ? 0 : (WRITE_WIDTH_A == 9) ? 1 : (WRITE_WIDTH_A == 17) ? 1 : (WRITE_WIDTH_A == 18) ? 2 : (WRITE_WIDTH_A == 33) ? 1 : (WRITE_WIDTH_A == 34) ? 2 : (WRITE_WIDTH_A == 35) ? 3 : (WRITE_WIDTH_A == 36) ? 4 : 0 ) : 0;

   localparam DIPB_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_B < 9) ? 0 : (WRITE_WIDTH_B == 9) ? 1 : (WRITE_WIDTH_B == 17) ? 1 : (WRITE_WIDTH_B == 18) ? 2 : (WRITE_WIDTH_B == 33) ? 1 : (WRITE_WIDTH_B == 34) ? 2 : (WRITE_WIDTH_B == 35) ? 3 : (WRITE_WIDTH_B == 36) ? 4 : 0 ) : 0;

   localparam DOPA_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH_A < 9) ? 1 : (READ_WIDTH_A == 9) ? 1 : (READ_WIDTH_A == 17) ? 1 : (READ_WIDTH_A == 18) ? 2 : (READ_WIDTH_A == 33) ? 1 : (READ_WIDTH_A == 34) ? 2 : (READ_WIDTH_A == 35) ? 3 : (READ_WIDTH_A == 36) ? 4 : 1 ) : 1;

   localparam DOPB_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH_B < 9) ? 1 : (READ_WIDTH_B == 9) ? 1 : (READ_WIDTH_B == 17) ? 1 : (READ_WIDTH_B == 18) ? 2 : (READ_WIDTH_B == 33) ? 1 : (READ_WIDTH_B == 34) ? 2 : (READ_WIDTH_B == 35) ? 3 : (READ_WIDTH_B == 36) ? 4 : 1 ) : 1;

   // Widths of Write Enables
   localparam WEA_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_A <= 9) ? 1 : (WRITE_WIDTH_A > 9 && WRITE_WIDTH_A <= 18) ? 2 : (WRITE_WIDTH_A > 18 && WRITE_WIDTH_A <= 36) ? 4 : (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 4;
   localparam WEB_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH_B <= 9) ? 1 : (WRITE_WIDTH_B > 9 && WRITE_WIDTH_B <= 18) ? 2 : (WRITE_WIDTH_B > 18 && WRITE_WIDTH_B <= 36) ? 4 : (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 4;
   localparam least_width_A =  (DIA_WIDTH <= DOA_WIDTH) ? DIA_WIDTH : DOA_WIDTH;
   localparam least_width_B =  (DIB_WIDTH <= DOB_WIDTH) ? DIB_WIDTH : DOB_WIDTH;

   // Widths of Address Bus
   localparam ADDRA_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (BRAM_SIZE == "9Kb") ? ( (least_width_A == 1) ? 13 : (least_width_A == 2) ? 12 : (least_width_A > 2 && least_width_A <= 4) ? 11 : (least_width_A > 4 && least_width_A <= 9) ? 10 : (least_width_A > 9 && least_width_A <= 18) ? 9 : 13 ) : (BRAM_SIZE == "18Kb") ? ( (least_width_A == 1) ? 14 : (least_width_A == 2) ? 13 : (least_width_A > 2 && least_width_A <= 4) ? 12 : (least_width_A > 4 && least_width_A <= 9) ? 11 : (least_width_A > 9 && least_width_A <= 18) ? 10 : (least_width_A > 18 && least_width_A < 36) ? 9 : 14 ) : (BRAM_SIZE == "36Kb") ? ( (least_width_A == 1) ? 15 : (least_width_A == 2) ? 14 : (least_width_A > 2 && least_width_A <= 4) ? 13 : (least_width_A > 4 && least_width_A <= 9) ? 12 : (least_width_A > 9 && least_width_A <= 18) ? 11 : (least_width_A > 18 && least_width_A <= 36) ? 10 : 15 ) : 15 ): 15; 
   localparam ADDRB_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (BRAM_SIZE == "9Kb") ? ( (least_width_B == 1) ? 13 : (least_width_B == 2) ? 12 : (least_width_B > 2 && least_width_B <= 4) ? 11 : (least_width_B > 4 && least_width_B <= 9) ? 10 : (least_width_B > 9 && least_width_B <= 18) ? 9 : 13 ) : (BRAM_SIZE == "18Kb") ? ( (least_width_B == 1) ? 14 : (least_width_B == 2) ? 13 : (least_width_B > 2 && least_width_B <= 4) ? 12 : (least_width_B > 4 && least_width_B <= 9) ? 11 : (least_width_B > 9 && least_width_B <= 18) ? 10 : (least_width_B > 18 && least_width_B <= 36 ) ? 9 : 14 ) : (BRAM_SIZE == "36Kb") ? ( (least_width_B == 1) ? 15 : (least_width_B == 2) ? 14 : (least_width_B > 2 && least_width_B <= 4) ? 13 : (least_width_B > 4 && least_width_B <= 9) ? 12 : (least_width_B > 9 && least_width_B <= 18) ? 11 : (least_width_B > 18 && least_width_B <= 36) ? 10 : 15 ) : 15 ): 15; 


   // Output Ports
   output [READ_WIDTH_A-1:0] DOA;
   output [READ_WIDTH_B-1:0] DOB;

   // Input Ports
   input [ADDRA_WIDTH-1:0] ADDRA;
   input [ADDRB_WIDTH-1:0] ADDRB;
   input CLKA;
   input CLKB;
   input [WRITE_WIDTH_A-1:0] DIA;
   input [WRITE_WIDTH_B-1:0] DIB;
   input ENA;
   input ENB;
   input REGCEA;
   input REGCEB;
   input RSTA;
   input RSTB;
   input [WEA_WIDTH-1:0] WEA;
   input [WEB_WIDTH-1:0] WEB;

   // Mapping wire sizes
   localparam MAX_ADDRA_SIZE = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 14 : 16 ) :
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 13 : 14 ) : 
   16;
   localparam MAX_ADDRB_SIZE = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 14 : 16 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 13 : 14 ) : 
   16;
   localparam MAX_DIA_SIZE   = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 16 : 32 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 16 : 32 ) : 
   16;
   localparam MAX_DIB_SIZE   = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 16 : 32 ) :
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 16 : 32 ) :
   16;  
   localparam MAX_DIPA_SIZE  = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 2 : 4 ) :
   4;
   localparam MAX_DIPB_SIZE  = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 2 : 4 ) :
   4;
   localparam MAX_DOA_SIZE   = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 16 : 32 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 16 : 32 ) : 
   32;
   localparam MAX_DOB_SIZE   = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 16 : 32 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 16 : 32 ) : 
   32;
   localparam MAX_DOPA_SIZE  = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 2 : 4 ) :
   4;
   localparam MAX_DOPB_SIZE  = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 2 : 4 ) :
   4;
   localparam MAX_WEA_SIZE   = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 2 : 4 ) :
   4;
   localparam MAX_WEB_SIZE   = (DEVICE == "VIRTEX5" ||  DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 2 : 4 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 2 : 4 ) :
   4;
   localparam fin_rd_widtha = (READ_WIDTH_A == 0) ? 1 : READ_WIDTH_A;
   localparam fin_rd_widthb = (READ_WIDTH_B == 0) ? 1 : READ_WIDTH_B;
   localparam fin_wr_widtha = (WRITE_WIDTH_A == 0) ? 1 : WRITE_WIDTH_A;
   localparam fin_wr_widthb = (WRITE_WIDTH_B == 0) ? 1 : WRITE_WIDTH_B;

   wire [MAX_ADDRA_SIZE-1:0] ADDRA_PATTERN;
   wire [MAX_ADDRB_SIZE-1:0] ADDRB_PATTERN;
   wire [MAX_DIA_SIZE-1:0] DIA_PATTERN;
   wire [MAX_DIB_SIZE-1:0] DIB_PATTERN;
   wire [MAX_DIPA_SIZE-1:0] DIPA_PATTERN;
   wire [MAX_DIPB_SIZE-1:0] DIPB_PATTERN;
   wire [MAX_DOA_SIZE-1:0] DOA_PATTERN;
   wire [MAX_DOB_SIZE-1:0] DOB_PATTERN;
   wire [MAX_DOPA_SIZE-1:0] DOPA_PATTERN;
   wire [MAX_DOPB_SIZE-1:0] DOPB_PATTERN;
   wire [MAX_WEA_SIZE-1:0] WEA_PATTERN;
   wire [MAX_WEB_SIZE-1:0] WEB_PATTERN;

   
  wire RSTREGA_PATTERN;
  wire RSTREGB_PATTERN;
  wire RSTRAMA_PATTERN;
  wire RSTRAMB_PATTERN;

  // Pattern for ADDR and ADDRB based on size of address  
   assign ADDRA_PATTERN  = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" ) ? ( (BRAM_SIZE == "18Kb") ? ( (ADDRA_WIDTH == 14) ? ADDRA : (ADDRA_WIDTH == 13) ? {ADDRA, 1'b1} : (ADDRA_WIDTH == 12) ? {ADDRA, 2'b11} : (ADDRA_WIDTH == 11) ? {ADDRA, 3'b111} : (ADDRA_WIDTH == 10) ? {ADDRA, 4'b1111} : (ADDRA_WIDTH == 9) ? {ADDRA, 5'b11111} : ADDRA ) : (BRAM_SIZE == "36Kb") ? ( (ADDRA_WIDTH == 16) ? ADDRA : (ADDRA_WIDTH == 15) ? {1'b1, ADDRA} : (ADDRA_WIDTH == 14) ? {1'b1, ADDRA, 1'b1} : (ADDRA_WIDTH == 13) ? {1'b1, ADDRA, 2'b11} : (ADDRA_WIDTH == 12) ? {1'b1, ADDRA, 3'b111} : (ADDRA_WIDTH == 11) ? {1'b1, ADDRA, 4'b1111} : (ADDRA_WIDTH == 10) ? {1'b1, ADDRA, 5'b11111} : (ADDRA_WIDTH == 9) ? {1'b1, ADDRA, 6'b111111}  : ADDRA ) : ADDRA) : 
  (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? ( (ADDRA_WIDTH == 13) ? ADDRA : (ADDRA_WIDTH == 12) ? {ADDRA, 1'b1} : (ADDRA_WIDTH == 11) ? {ADDRA, 2'b11} : (ADDRA_WIDTH == 10) ? {ADDRA, 3'b111} : (ADDRA_WIDTH == 9) ? {ADDRA, 4'b1111} : ADDRA ) : (BRAM_SIZE == "18Kb") ? ( (ADDRA_WIDTH == 14) ? ADDRA : (ADDRA_WIDTH == 13) ? {ADDRA, 1'b1} : (ADDRA_WIDTH == 12) ? {ADDRA, 2'b11} : (ADDRA_WIDTH == 11) ? {ADDRA, 3'b111} : (ADDRA_WIDTH == 10) ? {ADDRA, 4'b1111} : (ADDRA_WIDTH == 9) ? {ADDRA, 5'b11111}  : ADDRA ) : ADDRA) : 
  ADDRA;

  assign ADDRB_PATTERN  = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" ) ? ( (BRAM_SIZE == "18Kb") ? ( (ADDRB_WIDTH == 14) ? ADDRB : (ADDRB_WIDTH == 13) ? {ADDRB, 1'b1} : (ADDRB_WIDTH == 12) ? {ADDRB, 2'b11} : (ADDRB_WIDTH == 11) ? {ADDRB, 3'b111} : (ADDRB_WIDTH == 10) ? {ADDRB, 4'b1111} : (ADDRB_WIDTH == 9) ? {ADDRB, 5'b11111} : ADDRB ) : (BRAM_SIZE == "36Kb") ? ( (ADDRB_WIDTH == 16) ? ADDRB : (ADDRB_WIDTH == 15) ? {1'b1, ADDRB} : (ADDRB_WIDTH == 14) ? {1'b1, ADDRB, 1'b1} : (ADDRB_WIDTH == 13) ? {1'b1, ADDRB, 2'b11} : (ADDRB_WIDTH == 12) ? {1'b1, ADDRB, 3'b111} : (ADDRB_WIDTH == 11) ? {1'b1, ADDRB, 4'b1111} : (ADDRB_WIDTH == 10) ? {1'b1, ADDRB, 5'b11111} : (ADDRB_WIDTH == 9) ? {1'b1, ADDRB, 6'b111111} : ADDRB )  : ADDRB) : 
 (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? ( (ADDRB_WIDTH == 13) ? ADDRB : (ADDRB_WIDTH == 12) ? {ADDRB, 1'b1} : (ADDRB_WIDTH == 11) ? {ADDRB, 2'b11} : (ADDRB_WIDTH == 10) ? {ADDRB, 3'b111} : (ADDRB_WIDTH == 9) ? {ADDRB, 4'b1111} : ADDRB ) : (BRAM_SIZE == "18Kb") ? ( (ADDRB_WIDTH == 14) ? ADDRB : (ADDRB_WIDTH == 13) ? {ADDRB, 1'b1} : (ADDRB_WIDTH == 12) ? {ADDRB, 2'b11} : (ADDRB_WIDTH == 11) ? {ADDRB, 3'b111} : (ADDRB_WIDTH == 10) ? {ADDRB, 4'b1111} : (ADDRB_WIDTH == 9) ? {ADDRB, 5'b11111}  : ADDRB ) : ADDRB) :
 ADDRB;

  // Pattern for DATA bus

   generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" : 
          begin
            if (WRITEA_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A == 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_A == 36) ))
            begin : dia1
              assign DIPA_PATTERN = 0;
              assign DIA_PATTERN = DIA;
            end
            if (WRITEA_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A < 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_A < 36) ))
            begin : dia2
              assign DIPA_PATTERN = 0;
              assign DIA_PATTERN = {{((MAX_DIA_SIZE)-fin_wr_widtha){1'b0}}, DIA};
            end
          end
       "SPARTAN6" : 
          begin
            if (WRITEA_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_A == 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A == 36) ))
            begin : dia3
              assign DIPA_PATTERN = 0;
              assign DIA_PATTERN = DIA;
            end
            if (WRITEA_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_A < 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A < 36) ))
            begin : dia4
              assign DIPA_PATTERN = 0;
              assign DIA_PATTERN = {{((MAX_DIA_SIZE)-fin_wr_widtha){1'b0}}, DIA};
            end
          end // s1
      default : ;
    endcase
   endgenerate
   generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" :
          begin 
            if (WRITEA_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A == 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_A == 36) ))
              begin : dia5
                assign DIA_PATTERN = DIA[DIA_WIDTH-1:0];
                assign DIPA_PATTERN = DIA[fin_wr_widtha-1 : DIA_WIDTH];
              end
             if (WRITEA_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A < 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_A < 36) ))
              begin : dia6
                assign DIA_PATTERN = {{((MAX_DIA_SIZE)-DIA_WIDTH){1'b0}}, DIA[DIA_WIDTH-1:0]};
                assign DIPA_PATTERN = {{((MAX_DIPA_SIZE)-DIPA_WIDTH){1'b0}}, DIA[fin_wr_widtha-1 : DIA_WIDTH]};
              end
          end
        "SPARTAN6" :
          begin 
            if (WRITEA_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_A == 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A == 36) ))
              begin : dia7
                assign DIA_PATTERN = DIA[DIA_WIDTH-1:0];
                assign DIPA_PATTERN = DIA[fin_wr_widtha-1 : DIA_WIDTH];
              end
            if (WRITEA_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_A <= 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_A <= 36) ))
              begin : dia8
                assign DIA_PATTERN = {{((MAX_DIA_SIZE)-DIA_WIDTH){1'b0}}, DIA[DIA_WIDTH-1:0]};
                assign DIPA_PATTERN = {{((MAX_DIPA_SIZE)-DIPA_WIDTH){1'b0}}, DIA[fin_wr_widtha-1 : DIA_WIDTH]};
              end
          end // s2
       default : ;
    endcase
   endgenerate

   generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" : 
          begin
            if (WRITEB_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B == 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_B == 36) ))
              begin : dib1
                assign DIPB_PATTERN = 0;
                assign DIB_PATTERN = DIB;
              end
            if (WRITEB_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B < 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_B < 36) ))
              begin : dib2
                assign DIPB_PATTERN = 0;
                assign DIB_PATTERN = {{((MAX_DIB_SIZE)-fin_wr_widthb){1'b0}}, DIB};
              end
          end
       "SPARTAN6" : 
          begin
            if (WRITEB_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_B == 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B == 36) ))
              begin : dib3
                assign DIPB_PATTERN = 0;
                assign DIB_PATTERN = DIB;
              end
            if (WRITEB_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_B < 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B < 36) ))
              begin : dib4
                assign DIPB_PATTERN = 0;
                assign DIB_PATTERN = {{((MAX_DIB_SIZE)-fin_wr_widthb){1'b0}}, DIB};
              end
          end // s3
      default : ;
    endcase
   endgenerate
   generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" :
          begin 
            if (WRITEB_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B == 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_B == 36) ))
              begin : dib5
                assign DIB_PATTERN = DIB[DIB_WIDTH-1:0];
                assign DIPB_PATTERN = DIB[fin_wr_widthb-1 : DIB_WIDTH];
              end
            if (WRITEB_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B < 18) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH_B < 36) ))
              begin : dib6
                assign DIB_PATTERN = {{((MAX_DIB_SIZE)-DIB_WIDTH){1'b0}}, DIB[DIB_WIDTH-1:0]};
                assign DIPB_PATTERN = {{((MAX_DIPB_SIZE)-DIPB_WIDTH){1'b0}}, DIB[fin_wr_widthb-1 : DIB_WIDTH]};
              end
         end
       "SPARTAN6" :
          begin 
            if (WRITEB_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_B == 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B == 36) ))
              begin : dib7
                assign DIB_PATTERN = DIB[DIB_WIDTH-1:0];
                assign DIPB_PATTERN = DIB[fin_wr_widthb-1 : DIB_WIDTH];
              end
            if (WRITEB_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH_B < 18) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH_B < 36) ))
              begin : dib8
                assign DIB_PATTERN = {{((MAX_DIB_SIZE)-DIB_WIDTH){1'b0}}, DIB[DIB_WIDTH-1:0]};
                assign DIPB_PATTERN = {{((MAX_DIPB_SIZE)-DIPB_WIDTH){1'b0}}, DIB[fin_wr_widthb-1 : DIB_WIDTH]};
              end
         end // s4
      default : ;
    endcase
   endgenerate

   generate 
     case(DEVICE)
       "VIRTEX5", "VIRTEX6":
          begin 
            if (READA_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && READ_WIDTH_A <= 18) || (BRAM_SIZE == "36Kb" && READ_WIDTH_A <= 36)  ))
              begin : doa1
                assign DOA = DOA_PATTERN[fin_rd_widtha-1:0];
            end
         end 
      "SPARTAN6":
          begin 
            if (READA_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && READ_WIDTH_A <= 18) || (BRAM_SIZE == "18Kb" && READ_WIDTH_A <= 36)  ))
              begin : doa1
                assign DOA = DOA_PATTERN[fin_rd_widtha-1:0];
            end
         end // s5
      default : ;
    endcase
   endgenerate
   generate 
     case(DEVICE)
       "VIRTEX5", "VIRTEX6":
          begin 
            if (READA_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && READ_WIDTH_A <= 18) || (BRAM_SIZE == "36Kb" && READ_WIDTH_A <= 36) ))
              begin : doa2
                assign DOA = {DOPA_PATTERN[DOPA_WIDTH-1:0], DOA_PATTERN[DOA_WIDTH-1:0]};
              end
         end
       "SPARTAN6":
          begin 
            if (READA_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && READ_WIDTH_A <= 18) || (BRAM_SIZE == "18Kb" && READ_WIDTH_A <= 36) ))
              begin : doa2
                assign DOA = {DOPA_PATTERN[DOPA_WIDTH-1:0], DOA_PATTERN[DOA_WIDTH-1:0]};
              end
         end // s6
      default : ;
    endcase
   endgenerate
   generate 
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" :
          begin 
            if (READB_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && READ_WIDTH_B <= 18) || (BRAM_SIZE == "36Kb" && READ_WIDTH_B <= 36) ))
              begin : dob1
                assign DOB = DOB_PATTERN[fin_rd_widthb-1:0];
              end
         end
       "SPARTAN6" :
          begin 
            if (READB_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && READ_WIDTH_B <= 18) || (BRAM_SIZE == "18Kb" && READ_WIDTH_B <= 36) ))
              begin : dob1
                assign DOB = DOB_PATTERN[fin_rd_widthb-1:0];
              end
         end // s7
      default : ;
    endcase
   endgenerate
   generate 
     case(DEVICE)
       "VIRTEX5", "VIRTEX6" :
          begin 
            if (READB_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && READ_WIDTH_B <= 18) || (BRAM_SIZE == "36Kb" && READ_WIDTH_B <= 36) ))
              begin : dob2
                assign DOB = {DOPB_PATTERN[DOPB_WIDTH-1:0], DOB_PATTERN[DOB_WIDTH-1:0]};
              end
         end
       "SPARTAN6" :
          begin 
            if (READB_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && READ_WIDTH_B <= 18) || (BRAM_SIZE == "18Kb" && READ_WIDTH_B <= 36) ))
              begin : dob2
                assign DOB = {DOPB_PATTERN[DOPB_WIDTH-1:0], DOB_PATTERN[DOB_WIDTH-1:0]};
              end
         end // s8
      default : ;
    endcase
   endgenerate

   assign WEA_PATTERN = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ?  ( (WEA_WIDTH == 1) ? {2{WEA}} : (WEA_WIDTH == 2) ? WEA : WEA ) : (BRAM_SIZE == "36Kb") ? ( (WEA_WIDTH == 1) ? {4{WEA}} : (WEA_WIDTH == 2) ? {2{WEA}} : (WEA_WIDTH == 4) ? WEA : WEA ) : WEA) :
(DEVICE == "SPARTAN6") ? ((BRAM_SIZE == "9Kb") ? ((WEA_WIDTH == 1) ? {2{WEA}} : (WEA_WIDTH == 2) ? WEA : WEA) : (BRAM_SIZE == "18Kb") ? ((WEA_WIDTH == 1) ? {4{WEA}} : (WEA_WIDTH == 2) ? {2{WEA}} : (WEA_WIDTH == 4) ? WEA : WEA):WEA): 
WEA; 
    
   assign WEB_PATTERN = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ?  ( (WEB_WIDTH == 1) ? {2{WEB}} : (WEB_WIDTH == 2) ? WEB : WEB ) : (BRAM_SIZE == "36Kb") ? ( (WEB_WIDTH == 1) ? {4{WEB}} : (WEB_WIDTH == 2) ? {2{WEB}} : (WEB_WIDTH == 4) ? WEB : WEB ) : WEB) :
(DEVICE == "SPARTAN6") ? ((BRAM_SIZE == "9Kb") ? ((WEB_WIDTH == 1) ? {2{WEB}} : (WEB_WIDTH == 2) ? WEB : WEB) : (BRAM_SIZE == "18Kb") ? ((WEB_WIDTH == 1) ? {4{WEB}} : (WEB_WIDTH == 2) ? {2{WEB}} : (WEB_WIDTH == 4) ? WEB : WEB):WEB): 
WEB; 

   assign RSTREGA_PATTERN = (DOA_REG == 1'b1) ? RSTA : 1'b0; 
   assign RSTREGB_PATTERN = (DOB_REG == 1'b1) ? RSTB : 1'b0; 
   assign RSTRAMA_PATTERN = (DOA_REG == 1'b0) ? RSTA : 1'b0; 
   assign RSTRAMB_PATTERN = (DOB_REG == 1'b0) ? RSTB : 1'b0; 

   generate 
     case(DEVICE)
       // begin generate Virtex5
       "VIRTEX5" : 
          begin
            if (BRAM_SIZE == "18Kb") begin : bram18_tdp

              RAMB18 # ( 
                .DOA_REG (DOA_REG),
                .DOB_REG (DOB_REG),
                .INITP_00 (INITP_00),
                .INITP_01 (INITP_01),
                .INITP_02 (INITP_02), 
                .INITP_03 (INITP_03),
                .INITP_04 (INITP_04),
                .INITP_05 (INITP_05),
                .INITP_06 (INITP_06),
                .INITP_07 (INITP_07),
                .INIT_00 (INIT_00), 
                .INIT_01 (INIT_01),
                .INIT_02 (INIT_02),
                .INIT_03 (INIT_03),
                .INIT_04 (INIT_04),
                .INIT_05 (INIT_05),
                .INIT_06 (INIT_06),
                .INIT_07 (INIT_07),
                .INIT_08 (INIT_08),
                .INIT_09 (INIT_09),
                .INIT_0A (INIT_0A),
                .INIT_0B (INIT_0B),
                .INIT_0C (INIT_0C),
                .INIT_0D (INIT_0D),
                .INIT_0E (INIT_0E),
                .INIT_0F (INIT_0F),
                .INIT_10 (INIT_10),
                .INIT_11 (INIT_11),
                .INIT_12 (INIT_12),
                .INIT_13 (INIT_13),
                .INIT_14 (INIT_14),
                .INIT_15 (INIT_15),
                .INIT_16 (INIT_16),
                .INIT_17 (INIT_17),
                .INIT_18 (INIT_18),
                .INIT_19 (INIT_19),
                .INIT_1A (INIT_1A),
                .INIT_1B (INIT_1B),
                .INIT_1C (INIT_1C),
                .INIT_1D (INIT_1D),
                .INIT_1E (INIT_1E),
                .INIT_1F (INIT_1F),
                .INIT_20 (INIT_20),
                .INIT_21 (INIT_21),
                .INIT_22 (INIT_22),
                .INIT_23 (INIT_23),
                .INIT_24 (INIT_24),
                .INIT_25 (INIT_25),
                .INIT_26 (INIT_26),
                .INIT_27 (INIT_27),
                .INIT_28 (INIT_28),
                .INIT_29 (INIT_29),
                .INIT_2A (INIT_2A),
                .INIT_2B (INIT_2B),
                .INIT_2C (INIT_2C),
                .INIT_2D (INIT_2D),
                .INIT_2E (INIT_2E),
                .INIT_2F (INIT_2F),
                .INIT_30 (INIT_30),
                .INIT_31 (INIT_31),
                .INIT_32 (INIT_32),
                .INIT_33 (INIT_33),
                .INIT_34 (INIT_34),
                .INIT_35 (INIT_35),
                .INIT_36 (INIT_36),
                .INIT_37 (INIT_37),
                .INIT_38 (INIT_38),
                .INIT_39 (INIT_39),
                .INIT_3A (INIT_3A),
                .INIT_3B (INIT_3B),
                .INIT_3C (INIT_3C),
                .INIT_3D (INIT_3D),
                .INIT_3E (INIT_3E),
                .INIT_3F (INIT_3F),
                .INIT_A (INIT_A),
                .INIT_B (INIT_B),
                .INIT_FILE(INIT_FILE),
                .READ_WIDTH_A (rd_width_a),
                .READ_WIDTH_B (rd_width_b),
                .SIM_COLLISION_CHECK (SIM_COLLISION_CHECK),
                .SIM_MODE (SIM_MODE),
                .SRVAL_A (SRVAL_A),
                .SRVAL_B (SRVAL_B),
                .WRITE_MODE_A (WRITE_MODE_A),
                .WRITE_MODE_B (WRITE_MODE_B),
                .WRITE_WIDTH_A (wr_width_a),
                .WRITE_WIDTH_B (wr_width_b)
                )  bram18_tdp (
                .DOA (DOA_PATTERN), 
                .DOB (DOB_PATTERN), 
                .DOPA (DOPA_PATTERN), 
                .DOPB (DOPB_PATTERN),
                .ADDRA(ADDRA_PATTERN), 
                .ADDRB(ADDRB_PATTERN), 
                .CLKA (CLKA), 
                .CLKB (CLKB), 
                .DIA (DIA_PATTERN), 
                .DIB (DIB_PATTERN), 
                .DIPA (DIPA_PATTERN), 
                .DIPB (DIPB_PATTERN), 
                .ENA (ENA), 
                .ENB (ENB), 
                .REGCEA (REGCEA), 
                .REGCEB (REGCEB), 
                .SSRA (RSTA), 
                .SSRB (RSTB), 
                .WEA (WEA_PATTERN), 
                .WEB (WEB_PATTERN)
                );
              end
              else if (BRAM_SIZE == "36Kb") begin : bram36_tdp

              RAMB36 # ( 
                .DOA_REG (DOA_REG),
                .DOB_REG (DOB_REG),
                .INITP_00 (INITP_00),
                .INITP_01 (INITP_01),
                .INITP_02 (INITP_02), 
                .INITP_03 (INITP_03),
                .INITP_04 (INITP_04),
                .INITP_05 (INITP_05),
                .INITP_06 (INITP_06),
                .INITP_07 (INITP_07),
                .INITP_08 (INITP_08),
                .INITP_09 (INITP_09),
                .INITP_0A (INITP_0A), 
                .INITP_0B (INITP_0B),
                .INITP_0C (INITP_0C),
                .INITP_0D (INITP_0D),
                .INITP_0E (INITP_0E),
                .INITP_0F (INITP_0F),
                .INIT_00 (INIT_00), 
                .INIT_01 (INIT_01),
                .INIT_02 (INIT_02),
                .INIT_03 (INIT_03),
                .INIT_04 (INIT_04),
                .INIT_05 (INIT_05),
                .INIT_06 (INIT_06),
                .INIT_07 (INIT_07),
                .INIT_08 (INIT_08),
                .INIT_09 (INIT_09),
                .INIT_0A (INIT_0A),
                .INIT_0B (INIT_0B),
                .INIT_0C (INIT_0C),
                .INIT_0D (INIT_0D),
                .INIT_0E (INIT_0E),
                .INIT_0F (INIT_0F),
                .INIT_10 (INIT_10),
                .INIT_11 (INIT_11),
                .INIT_12 (INIT_12),
                .INIT_13 (INIT_13),
                .INIT_14 (INIT_14),
                .INIT_15 (INIT_15),
                .INIT_16 (INIT_16),
                .INIT_17 (INIT_17),
                .INIT_18 (INIT_18),
                .INIT_19 (INIT_19),
                .INIT_1A (INIT_1A),
                .INIT_1B (INIT_1B),
                .INIT_1C (INIT_1C),
                .INIT_1D (INIT_1D),
                .INIT_1E (INIT_1E),
                .INIT_1F (INIT_1F),
                .INIT_20 (INIT_20),
                .INIT_21 (INIT_21),
                .INIT_22 (INIT_22),
                .INIT_23 (INIT_23),
                .INIT_24 (INIT_24),
                .INIT_25 (INIT_25),
                .INIT_26 (INIT_26),
                .INIT_27 (INIT_27),
                .INIT_28 (INIT_28),
                .INIT_29 (INIT_29),
                .INIT_2A (INIT_2A),
                .INIT_2B (INIT_2B),
                .INIT_2C (INIT_2C),
                .INIT_2D (INIT_2D),
                .INIT_2E (INIT_2E),
                .INIT_2F (INIT_2F),
                .INIT_30 (INIT_30),
                .INIT_31 (INIT_31),
                .INIT_32 (INIT_32),
                .INIT_33 (INIT_33),
                .INIT_34 (INIT_34),
                .INIT_35 (INIT_35),
                .INIT_36 (INIT_36),
                .INIT_37 (INIT_37),
                .INIT_38 (INIT_38),
                .INIT_39 (INIT_39),
                .INIT_3A (INIT_3A),
                .INIT_3B (INIT_3B),
                .INIT_3C (INIT_3C),
                .INIT_3D (INIT_3D),
                .INIT_3E (INIT_3E),
                .INIT_3F (INIT_3F),
                .INIT_40 (INIT_40), 
                .INIT_41 (INIT_41),
                .INIT_42 (INIT_42),
                .INIT_43 (INIT_43),
                .INIT_44 (INIT_44),
                .INIT_45 (INIT_45),
                .INIT_46 (INIT_46),
                .INIT_47 (INIT_47),
                .INIT_48 (INIT_48),
                .INIT_49 (INIT_49),
                .INIT_4A (INIT_4A),
                .INIT_4B (INIT_4B),
                .INIT_4C (INIT_4C),
                .INIT_4D (INIT_4D),
                .INIT_4E (INIT_4E),
                .INIT_4F (INIT_4F),
                .INIT_50 (INIT_50),
                .INIT_51 (INIT_51),
                .INIT_52 (INIT_52),
                .INIT_53 (INIT_53),
                .INIT_54 (INIT_54),
                .INIT_55 (INIT_55),
                .INIT_56 (INIT_56),
                .INIT_57 (INIT_57),
                .INIT_58 (INIT_58),
                .INIT_59 (INIT_59),
                .INIT_5A (INIT_5A),
                .INIT_5B (INIT_5B),
                .INIT_5C (INIT_5C),
                .INIT_5D (INIT_5D),
                .INIT_5E (INIT_5E),
                .INIT_5F (INIT_5F),
                .INIT_60 (INIT_60),
                .INIT_61 (INIT_61),
                .INIT_62 (INIT_62),
                .INIT_63 (INIT_63),
                .INIT_64 (INIT_64),
                .INIT_65 (INIT_65),
                .INIT_66 (INIT_66),
                .INIT_67 (INIT_67),
                .INIT_68 (INIT_68),
                .INIT_69 (INIT_69),
                .INIT_6A (INIT_6A),
                .INIT_6B (INIT_6B),
                .INIT_6C (INIT_6C),
                .INIT_6D (INIT_6D),
                .INIT_6E (INIT_6E),
                .INIT_6F (INIT_6F),
                .INIT_70 (INIT_70),
                .INIT_71 (INIT_71),
                .INIT_72 (INIT_72),
                .INIT_73 (INIT_73),
                .INIT_74 (INIT_74),
                .INIT_75 (INIT_75),
                .INIT_76 (INIT_76),
                .INIT_77 (INIT_77),
                .INIT_78 (INIT_78),
                .INIT_79 (INIT_79),
                .INIT_7A (INIT_7A),
                .INIT_7B (INIT_7B),
                .INIT_7C (INIT_7C),
                .INIT_7D (INIT_7D),
                .INIT_7E (INIT_7E),
                .INIT_7F (INIT_7F),
                .INIT_A (INIT_A),
                .INIT_B (INIT_B),
                .INIT_FILE (INIT_FILE),
                .READ_WIDTH_A (rd_width_a),
                .READ_WIDTH_B (rd_width_b),
                .SIM_COLLISION_CHECK (SIM_COLLISION_CHECK),
                .SIM_MODE (SIM_MODE),
                .SRVAL_A (SRVAL_A),
                .SRVAL_B (SRVAL_B),
                .WRITE_MODE_A (WRITE_MODE_A),
                .WRITE_MODE_B (WRITE_MODE_B),
                .WRITE_WIDTH_A (wr_width_a),
                .WRITE_WIDTH_B (wr_width_b)
                )  bram36_tdp (
                .CASCADEOUTLATA (),
                .CASCADEOUTLATB (),
                .CASCADEOUTREGA (),
                .CASCADEOUTREGB (),
                .DOA (DOA_PATTERN), 
                .DOB (DOB_PATTERN), 
                .DOPA (DOPA_PATTERN), 
                .DOPB (DOPB_PATTERN),
                .ADDRA (ADDRA_PATTERN), 
                .ADDRB (ADDRB_PATTERN),
                .CASCADEINLATA (1'b0),
                .CASCADEINLATB (1'b0),
                .CASCADEINREGA (1'b0),
                .CASCADEINREGB (1'b0), 
                .CLKA (CLKA), 
                .CLKB (CLKB), 
                .DIA (DIA_PATTERN), 
                .DIB (DIB_PATTERN), 
                .DIPA (DIPA_PATTERN), 
                .DIPB (DIPB_PATTERN), 
                .ENA (ENA), 
                .ENB (ENB), 
                .REGCEA (REGCEA), 
                .REGCEB (REGCEB), 
                .SSRA (RSTA), 
                .SSRB (RSTB), 
                .WEA (WEA_PATTERN), 
                .WEB (WEB_PATTERN)
                );
              end
             end // end generate virtex5
       // begin generate virtex6
       "VIRTEX6" : 
          begin
            if (BRAM_SIZE == "18Kb") begin : bram18_tdp_bl
              
              RAMB18E1 # ( 
                .DOA_REG (DOA_REG),
                .DOB_REG (DOB_REG),
                .INITP_00 (INITP_00),
                .INITP_01 (INITP_01),
                .INITP_02 (INITP_02), 
                .INITP_03 (INITP_03),
                .INITP_04 (INITP_04),
                .INITP_05 (INITP_05),
                .INITP_06 (INITP_06),
                .INITP_07 (INITP_07),
                .INIT_00 (INIT_00), 
                .INIT_01 (INIT_01),
                .INIT_02 (INIT_02),
                .INIT_03 (INIT_03),
                .INIT_04 (INIT_04),
                .INIT_05 (INIT_05),
                .INIT_06 (INIT_06),
                .INIT_07 (INIT_07),
                .INIT_08 (INIT_08),
                .INIT_09 (INIT_09),
                .INIT_0A (INIT_0A),
                .INIT_0B (INIT_0B),
                .INIT_0C (INIT_0C),
                .INIT_0D (INIT_0D),
                .INIT_0E (INIT_0E),
                .INIT_0F (INIT_0F),
                .INIT_10 (INIT_10),
                .INIT_11 (INIT_11),
                .INIT_12 (INIT_12),
                .INIT_13 (INIT_13),
                .INIT_14 (INIT_14),
                .INIT_15 (INIT_15),
                .INIT_16 (INIT_16),
                .INIT_17 (INIT_17),
                .INIT_18 (INIT_18),
                .INIT_19 (INIT_19),
                .INIT_1A (INIT_1A),
                .INIT_1B (INIT_1B),
                .INIT_1C (INIT_1C),
                .INIT_1D (INIT_1D),
                .INIT_1E (INIT_1E),
                .INIT_1F (INIT_1F),
                .INIT_20 (INIT_20),
                .INIT_21 (INIT_21),
                .INIT_22 (INIT_22),
                .INIT_23 (INIT_23),
                .INIT_24 (INIT_24),
                .INIT_25 (INIT_25),
                .INIT_26 (INIT_26),
                .INIT_27 (INIT_27),
                .INIT_28 (INIT_28),
                .INIT_29 (INIT_29),
                .INIT_2A (INIT_2A),
                .INIT_2B (INIT_2B),
                .INIT_2C (INIT_2C),
                .INIT_2D (INIT_2D),
                .INIT_2E (INIT_2E),
                .INIT_2F (INIT_2F),
                .INIT_30 (INIT_30),
                .INIT_31 (INIT_31),
                .INIT_32 (INIT_32),
                .INIT_33 (INIT_33),
                .INIT_34 (INIT_34),
                .INIT_35 (INIT_35),
                .INIT_36 (INIT_36),
                .INIT_37 (INIT_37),
                .INIT_38 (INIT_38),
                .INIT_39 (INIT_39),
                .INIT_3A (INIT_3A),
                .INIT_3B (INIT_3B),
                .INIT_3C (INIT_3C),
                .INIT_3D (INIT_3D),
                .INIT_3E (INIT_3E),
                .INIT_3F (INIT_3F),
                .INIT_A (INIT_A),
                .INIT_B (INIT_B),
                .INIT_FILE(INIT_FILE),
                .RAM_MODE("TDP"),
                .READ_WIDTH_A (rd_width_a),
                .READ_WIDTH_B (rd_width_b),
                .SIM_COLLISION_CHECK (SIM_COLLISION_CHECK),
                .SRVAL_A (SRVAL_A),
                .SRVAL_B (SRVAL_B),
                .WRITE_MODE_A (WRITE_MODE_A),
                .WRITE_MODE_B (WRITE_MODE_B),
                .WRITE_WIDTH_A (wr_width_a),
                .WRITE_WIDTH_B (wr_width_b)
                )  bram18_tdp_bl (
                .DOADO (DOA_PATTERN), 
                .DOBDO (DOB_PATTERN), 
                .DOPADOP (DOPA_PATTERN), 
                .DOPBDOP (DOPB_PATTERN),
                .ADDRARDADDR(ADDRA_PATTERN), 
                .ADDRBWRADDR(ADDRB_PATTERN), 
                .CLKARDCLK (CLKA), 
                .CLKBWRCLK (CLKB), 
                .DIADI (DIA_PATTERN), 
                .DIBDI (DIB_PATTERN), 
                .DIPADIP (DIPA_PATTERN), 
                .DIPBDIP (DIPB_PATTERN), 
                .ENARDEN (ENA), 
                .ENBWREN (ENB), 
                .REGCEAREGCE (REGCEA), 
                .REGCEB (REGCEB), 
                .RSTRAMARSTRAM (RSTRAMA_PATTERN), 
                .RSTREGARSTREG (RSTREGA_PATTERN), 
                .RSTRAMB (RSTRAMB_PATTERN), 
                .RSTREGB (RSTREGB_PATTERN), 
                .WEA (WEA_PATTERN), 
                .WEBWE ({2'b00, WEB_PATTERN})
                );
              end
             else if (BRAM_SIZE == "36Kb") begin : bram36_tdp_bl

              RAMB36E1 # ( 
                .DOA_REG (DOA_REG),
                .DOB_REG (DOB_REG),
                .INITP_00 (INITP_00),
                .INITP_01 (INITP_01),
                .INITP_02 (INITP_02), 
                .INITP_03 (INITP_03),
                .INITP_04 (INITP_04),
                .INITP_05 (INITP_05),
                .INITP_06 (INITP_06),
                .INITP_07 (INITP_07),
                .INITP_08 (INITP_08),
                .INITP_09 (INITP_09),
                .INITP_0A (INITP_0A), 
                .INITP_0B (INITP_0B),
                .INITP_0C (INITP_0C),
                .INITP_0D (INITP_0D),
                .INITP_0E (INITP_0E),
                .INITP_0F (INITP_0F),
                .INIT_00 (INIT_00), 
                .INIT_01 (INIT_01),
                .INIT_02 (INIT_02),
                .INIT_03 (INIT_03),
                .INIT_04 (INIT_04),
                .INIT_05 (INIT_05),
                .INIT_06 (INIT_06),
                .INIT_07 (INIT_07),
                .INIT_08 (INIT_08),
                .INIT_09 (INIT_09),
                .INIT_0A (INIT_0A),
                .INIT_0B (INIT_0B),
                .INIT_0C (INIT_0C),
                .INIT_0D (INIT_0D),
                .INIT_0E (INIT_0E),
                .INIT_0F (INIT_0F),
                .INIT_10 (INIT_10),
                .INIT_11 (INIT_11),
                .INIT_12 (INIT_12),
                .INIT_13 (INIT_13),
                .INIT_14 (INIT_14),
                .INIT_15 (INIT_15),
                .INIT_16 (INIT_16),
                .INIT_17 (INIT_17),
                .INIT_18 (INIT_18),
                .INIT_19 (INIT_19),
                .INIT_1A (INIT_1A),
                .INIT_1B (INIT_1B),
                .INIT_1C (INIT_1C),
                .INIT_1D (INIT_1D),
                .INIT_1E (INIT_1E),
                .INIT_1F (INIT_1F),
                .INIT_20 (INIT_20),
                .INIT_21 (INIT_21),
                .INIT_22 (INIT_22),
                .INIT_23 (INIT_23),
                .INIT_24 (INIT_24),
                .INIT_25 (INIT_25),
                .INIT_26 (INIT_26),
                .INIT_27 (INIT_27),
                .INIT_28 (INIT_28),
                .INIT_29 (INIT_29),
                .INIT_2A (INIT_2A),
                .INIT_2B (INIT_2B),
                .INIT_2C (INIT_2C),
                .INIT_2D (INIT_2D),
                .INIT_2E (INIT_2E),
                .INIT_2F (INIT_2F),
                .INIT_30 (INIT_30),
                .INIT_31 (INIT_31),
                .INIT_32 (INIT_32),
                .INIT_33 (INIT_33),
                .INIT_34 (INIT_34),
                .INIT_35 (INIT_35),
                .INIT_36 (INIT_36),
                .INIT_37 (INIT_37),
                .INIT_38 (INIT_38),
                .INIT_39 (INIT_39),
                .INIT_3A (INIT_3A),
                .INIT_3B (INIT_3B),
                .INIT_3C (INIT_3C),
                .INIT_3D (INIT_3D),
                .INIT_3E (INIT_3E),
                .INIT_3F (INIT_3F),
                .INIT_40 (INIT_40), 
                .INIT_41 (INIT_41),
                .INIT_42 (INIT_42),
                .INIT_43 (INIT_43),
                .INIT_44 (INIT_44),
                .INIT_45 (INIT_45),
                .INIT_46 (INIT_46),
                .INIT_47 (INIT_47),
                .INIT_48 (INIT_48),
                .INIT_49 (INIT_49),
                .INIT_4A (INIT_4A),
                .INIT_4B (INIT_4B),
                .INIT_4C (INIT_4C),
                .INIT_4D (INIT_4D),
                .INIT_4E (INIT_4E),
                .INIT_4F (INIT_4F),
                .INIT_50 (INIT_50),
                .INIT_51 (INIT_51),
                .INIT_52 (INIT_52),
                .INIT_53 (INIT_53),
                .INIT_54 (INIT_54),
                .INIT_55 (INIT_55),
                .INIT_56 (INIT_56),
                .INIT_57 (INIT_57),
                .INIT_58 (INIT_58),
                .INIT_59 (INIT_59),
                .INIT_5A (INIT_5A),
                .INIT_5B (INIT_5B),
                .INIT_5C (INIT_5C),
                .INIT_5D (INIT_5D),
                .INIT_5E (INIT_5E),
                .INIT_5F (INIT_5F),
                .INIT_60 (INIT_60),
                .INIT_61 (INIT_61),
                .INIT_62 (INIT_62),
                .INIT_63 (INIT_63),
                .INIT_64 (INIT_64),
                .INIT_65 (INIT_65),
                .INIT_66 (INIT_66),
                .INIT_67 (INIT_67),
                .INIT_68 (INIT_68),
                .INIT_69 (INIT_69),
                .INIT_6A (INIT_6A),
                .INIT_6B (INIT_6B),
                .INIT_6C (INIT_6C),
                .INIT_6D (INIT_6D),
                .INIT_6E (INIT_6E),
                .INIT_6F (INIT_6F),
                .INIT_70 (INIT_70),
                .INIT_71 (INIT_71),
                .INIT_72 (INIT_72),
                .INIT_73 (INIT_73),
                .INIT_74 (INIT_74),
                .INIT_75 (INIT_75),
                .INIT_76 (INIT_76),
                .INIT_77 (INIT_77),
                .INIT_78 (INIT_78),
                .INIT_79 (INIT_79),
                .INIT_7A (INIT_7A),
                .INIT_7B (INIT_7B),
                .INIT_7C (INIT_7C),
                .INIT_7D (INIT_7D),
                .INIT_7E (INIT_7E),
                .INIT_7F (INIT_7F),
                .INIT_A (INIT_A),
                .INIT_B (INIT_B),
                .INIT_FILE (INIT_FILE),
                .EN_ECC_READ("FALSE"),
                .EN_ECC_WRITE("FALSE"),
                .RAM_MODE("TDP"),
                .READ_WIDTH_A (rd_width_a),
                .READ_WIDTH_B (rd_width_b),
                .SIM_COLLISION_CHECK (SIM_COLLISION_CHECK),
                .SRVAL_A (SRVAL_A),
                .SRVAL_B (SRVAL_B),
                .WRITE_MODE_A (WRITE_MODE_A),
                .WRITE_MODE_B (WRITE_MODE_B),
                .WRITE_WIDTH_A (wr_width_a),
                .WRITE_WIDTH_B (wr_width_b)
                )  bram36_tdp_bl (
                .CASCADEOUTA (),
                .CASCADEOUTB (),
                .DBITERR (),
                .DOADO (DOA_PATTERN), 
                .DOBDO (DOB_PATTERN), 
                .DOPADOP (DOPA_PATTERN), 
                .DOPBDOP (DOPB_PATTERN),
                .ECCPARITY (),
                .RDADDRECC (),
                .SBITERR (),
                .ADDRARDADDR (ADDRA_PATTERN), 
                .ADDRBWRADDR (ADDRB_PATTERN),
                .CASCADEINA (1'b0),
                .CASCADEINB (1'b0), 
                .CLKARDCLK (CLKA), 
                .CLKBWRCLK (CLKB), 
                .DIADI (DIA_PATTERN), 
                .DIBDI (DIB_PATTERN), 
                .DIPADIP (DIPA_PATTERN), 
                .DIPBDIP (DIPB_PATTERN), 
                .ENARDEN (ENA), 
                .ENBWREN (ENB), 
                .INJECTDBITERR(1'b0),
                .INJECTSBITERR(1'b0),
                .REGCEAREGCE (REGCEA), 
                .REGCEB (REGCEB), 
                .RSTRAMARSTRAM (RSTRAMA_PATTERN), 
                .RSTRAMB (RSTRAMB_PATTERN), 
                .RSTREGARSTREG (RSTREGA_PATTERN), 
                .RSTREGB (RSTREGB_PATTERN), 
                .WEA (WEA_PATTERN), 
                .WEBWE ({4'b0000, WEB_PATTERN})
                );
              end
             end // end generate virtex6
       // begin generate spartan6
       "SPARTAN6" :  
          begin
            if (BRAM_SIZE == "9Kb") begin : bram9_tdp_stan
              RAMB8BWER # ( 
                .DOA_REG (DOA_REG),
                .DOB_REG (DOB_REG),
                .INITP_00 (INITP_00),
                .INITP_01 (INITP_01),
                .INITP_02 (INITP_02), 
                .INITP_03 (INITP_03),
                .INIT_00 (INIT_00), 
                .INIT_01 (INIT_01),
                .INIT_02 (INIT_02),
                .INIT_03 (INIT_03),
                .INIT_04 (INIT_04),
                .INIT_05 (INIT_05),
                .INIT_06 (INIT_06),
                .INIT_07 (INIT_07),
                .INIT_08 (INIT_08),
                .INIT_09 (INIT_09),
                .INIT_0A (INIT_0A),
                .INIT_0B (INIT_0B),
                .INIT_0C (INIT_0C),
                .INIT_0D (INIT_0D),
                .INIT_0E (INIT_0E),
                .INIT_0F (INIT_0F),
                .INIT_10 (INIT_10),
                .INIT_11 (INIT_11),
                .INIT_12 (INIT_12),
                .INIT_13 (INIT_13),
                .INIT_14 (INIT_14),
                .INIT_15 (INIT_15),
                .INIT_16 (INIT_16),
                .INIT_17 (INIT_17),
                .INIT_18 (INIT_18),
                .INIT_19 (INIT_19),
                .INIT_1A (INIT_1A),
                .INIT_1B (INIT_1B),
                .INIT_1C (INIT_1C),
                .INIT_1D (INIT_1D),
                .INIT_1E (INIT_1E),
                .INIT_1F (INIT_1F),
                .INIT_A (INIT_A),
                .INIT_B (INIT_B),
                .DATA_WIDTH_A (rd_width_a),
                .DATA_WIDTH_B (rd_width_b),
                .RAM_MODE("TDP"),
                .SIM_COLLISION_CHECK (SIM_COLLISION_CHECK),
                .SRVAL_A (SRVAL_A),
                .SRVAL_B (SRVAL_B),
                .WRITE_MODE_A (WRITE_MODE_A),
                .WRITE_MODE_B (WRITE_MODE_B)
                )  ram8bwe_tdp (
                .DOADO (DOA_PATTERN), 
                .DOBDO (DOB_PATTERN), 
                .DOPADOP (DOPA_PATTERN), 
                .DOPBDOP (DOPB_PATTERN),
                .ADDRAWRADDR (ADDRA_PATTERN), 
                .ADDRBRDADDR (ADDRB_PATTERN), 
                .CLKAWRCLK (CLKA), 
                .CLKBRDCLK (CLKB), 
                .DIADI (DIA_PATTERN), 
                .DIBDI (DIB_PATTERN), 
                .DIPADIP (DIPA_PATTERN), 
                .DIPBDIP (DIPB_PATTERN), 
                .ENAWREN (ENA), 
                .ENBRDEN (ENB), 
                .REGCEA (REGCEA), 
                .REGCEBREGCE (REGCEB), 
                .RSTA (RSTA), 
                .RSTBRST (RSTB), 
                .WEAWEL (WEA_PATTERN), 
                .WEBWEU (WEB_PATTERN)
                );
            end
            else if (BRAM_SIZE == "18Kb") begin : bram18_tdp_stan
             RAMB16BWER # ( 
                .DOA_REG (DOA_REG),
                .DOB_REG (DOB_REG),
                .INITP_00 (INITP_00),
                .INITP_01 (INITP_01),
                .INITP_02 (INITP_02), 
                .INITP_03 (INITP_03),
                .INITP_04 (INITP_04),
                .INITP_05 (INITP_05),
                .INITP_06 (INITP_06),
                .INITP_07 (INITP_07),
                .INIT_00 (INIT_00), 
                .INIT_01 (INIT_01),
                .INIT_02 (INIT_02),
                .INIT_03 (INIT_03),
                .INIT_04 (INIT_04),
                .INIT_05 (INIT_05),
                .INIT_06 (INIT_06),
                .INIT_07 (INIT_07),
                .INIT_08 (INIT_08),
                .INIT_09 (INIT_09),
                .INIT_0A (INIT_0A),
                .INIT_0B (INIT_0B),
                .INIT_0C (INIT_0C),
                .INIT_0D (INIT_0D),
                .INIT_0E (INIT_0E),
                .INIT_0F (INIT_0F),
                .INIT_10 (INIT_10),
                .INIT_11 (INIT_11),
                .INIT_12 (INIT_12),
                .INIT_13 (INIT_13),
                .INIT_14 (INIT_14),
                .INIT_15 (INIT_15),
                .INIT_16 (INIT_16),
                .INIT_17 (INIT_17),
                .INIT_18 (INIT_18),
                .INIT_19 (INIT_19),
                .INIT_1A (INIT_1A),
                .INIT_1B (INIT_1B),
                .INIT_1C (INIT_1C),
                .INIT_1D (INIT_1D),
                .INIT_1E (INIT_1E),
                .INIT_1F (INIT_1F),
                .INIT_20 (INIT_20),
                .INIT_21 (INIT_21),
                .INIT_22 (INIT_22),
                .INIT_23 (INIT_23),
                .INIT_24 (INIT_24),
                .INIT_25 (INIT_25),
                .INIT_26 (INIT_26),
                .INIT_27 (INIT_27),
                .INIT_28 (INIT_28),
                .INIT_29 (INIT_29),
                .INIT_2A (INIT_2A),
                .INIT_2B (INIT_2B),
                .INIT_2C (INIT_2C),
                .INIT_2D (INIT_2D),
                .INIT_2E (INIT_2E),
                .INIT_2F (INIT_2F),
                .INIT_30 (INIT_30),
                .INIT_31 (INIT_31),
                .INIT_32 (INIT_32),
                .INIT_33 (INIT_33),
                .INIT_34 (INIT_34),
                .INIT_35 (INIT_35),
                .INIT_36 (INIT_36),
                .INIT_37 (INIT_37),
                .INIT_38 (INIT_38),
                .INIT_39 (INIT_39),
                .INIT_3A (INIT_3A),
                .INIT_3B (INIT_3B),
                .INIT_3C (INIT_3C),
                .INIT_3D (INIT_3D),
                .INIT_3E (INIT_3E),
                .INIT_3F (INIT_3F),
                .INIT_A (INIT_A),
                .INIT_B (INIT_B),
                .DATA_WIDTH_A (rd_width_a),
                .DATA_WIDTH_B (rd_width_b),
                .SIM_COLLISION_CHECK (SIM_COLLISION_CHECK),
                .SIM_DEVICE("SPARTAN6"),
                .SRVAL_A (SRVAL_A),
                .SRVAL_B (SRVAL_B),
                .WRITE_MODE_A (WRITE_MODE_A),
                .WRITE_MODE_B (WRITE_MODE_B)
                )  ram16bwe_tdp (
                .DOA (DOA_PATTERN), 
                .DOB (DOB_PATTERN), 
                .DOPA (DOPA_PATTERN), 
                .DOPB (DOPB_PATTERN),
                .ADDRA(ADDRA_PATTERN), 
                .ADDRB(ADDRB_PATTERN), 
                .CLKA (CLKA), 
                .CLKB (CLKB), 
                .DIA (DIA_PATTERN), 
                .DIB (DIB_PATTERN), 
                .DIPA (DIPA_PATTERN), 
                .DIPB (DIPB_PATTERN), 
                .ENA (ENA), 
                .ENB (ENB), 
                .REGCEA (REGCEA), 
                .REGCEB (REGCEB), 
                .RSTA (RSTA), 
                .RSTB (RSTB), 
                .WEA (WEA_PATTERN), 
                .WEB (WEB_PATTERN)
                );
            end
          end // end generate spartan6
       default : ;
     endcase
   endgenerate  
endmodule
