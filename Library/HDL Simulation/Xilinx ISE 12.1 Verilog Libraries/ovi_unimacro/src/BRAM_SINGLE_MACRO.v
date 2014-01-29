// $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/unimacro/data/devlib/verilog/BRAM_SINGLE_MACRO.v,v 1.13 2009/08/27 18:32:47 vandanad Exp $
///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2008 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : 11.1
//  \   \         Description : Xilinx Functional Simulation Library Component
//  /   /                  Macro for Single Port Block RAM 
// /___/   /\     Filename : BRAM_SINGLE_MACRO.v
// \   \  /  \    Timestamp : Wed April 04 16:44:06 PST 2008
//  \___\/\___\
//
// Revision:
//    04/04/08 - Initial version.
//    02/05/09 - Corrected RDADDRECC width.
// End Revision


`timescale 1 ps/1 ps

module BRAM_SINGLE_MACRO (DO,  
                   ADDR, CLK, DI, EN, REGCE, RST, WE); 

   parameter BRAM_SIZE = "18Kb";  
   parameter DEVICE = "VIRTEX5";
   parameter DO_REG = 0;
   parameter INIT = 72'h0;
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
   parameter READ_WIDTH  = 1;
   parameter SIM_MODE = "SAFE"; // This parameter is valid only for Virtex5
   parameter SRVAL = 72'h0;
   parameter WRITE_MODE = "WRITE_FIRST";
   parameter WRITE_WIDTH = 1;
   

   // Parameter Checks for invalid combinations
    localparam READ_P = ( (READ_WIDTH == 9) ||  (READ_WIDTH == 17) || (READ_WIDTH == 18) || (READ_WIDTH == 33) || (READ_WIDTH == 34) || (READ_WIDTH == 35) || (READ_WIDTH == 36) || (READ_WIDTH == 65) || (READ_WIDTH == 66) || (READ_WIDTH == 67) || (READ_WIDTH == 68) || (READ_WIDTH == 69) || (READ_WIDTH == 70) || (READ_WIDTH == 71) || (READ_WIDTH == 72) ) ? "TRUE" : "FALSE" ;
   localparam WRITE_P = ( (WRITE_WIDTH == 9) ||  (WRITE_WIDTH == 17) || (WRITE_WIDTH == 18) || (WRITE_WIDTH == 33) || (WRITE_WIDTH == 34) || (WRITE_WIDTH == 35) || (WRITE_WIDTH == 36) || (WRITE_WIDTH == 65) || (WRITE_WIDTH == 66) || (WRITE_WIDTH == 67) || (WRITE_WIDTH == 68) || (WRITE_WIDTH == 69) || (WRITE_WIDTH == 70) || (WRITE_WIDTH == 71) || (WRITE_WIDTH == 72) ) ? "TRUE" : "FALSE" ;

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
           case ({WRITE_P, READ_P})

             {"FALSE", "FALSE"} , {"TRUE", "TRUE"} :  ;

             {"FALSE", "TRUE"}: 
                begin 
                  $display("Port Width Mismatch on READ_WIDTH : The width READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  The parity bit(s) have not been written and hence cannot be read. ", READ_WIDTH);
                end
             {"TRUE", "FALSE"}: 
                begin 
                  $display("Port Width Mismatch on WRITE_WIDTH: The width WRITE_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  The parity bit(s) cannot be read ", WRITE_WIDTH);
	        end
            endcase
            if(BRAM_SIZE == "18Kb" || BRAM_SIZE == "36Kb") ;
            else
              begin
	        $display("Attribute Syntax Error : The attribute BRAM_SIZE on BRAM_SINGLE_MACRO instance %m is set to %s.  Legal values for this attribute are 18Kb or 36Kb", BRAM_SIZE);
                $finish;
              end
            if (READ_WIDTH == 0)
              begin 
                $display("Attribute Syntax Error : The attribute READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  This attribute must atleast be equal to 1.", READ_WIDTH);
                $finish;
              end
            else if (READ_WIDTH > 36 && BRAM_SIZE == "18Kb" )
	      begin 
                $display("Attribute Syntax Error : The attribute READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  For BRAM_SIZE of 18Kb, allowed values of this attribute are 1 to 18.", READ_WIDTH);
                $finish;
              end
            else if (READ_WIDTH > 72)
              begin 
                $display("Attribute Syntax Error : The attribute READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 18Kb and 1 to 36 for BRAM_SIZE of 36Kb.", READ_WIDTH);
                $finish;
              end
            if (WRITE_WIDTH == 0)
	      begin 
                $display("Attribute Syntax Error : The attribute WRITE_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  This attribute must atleast be equal to 1.", WRITE_WIDTH);
                $finish;
              end
            else if (WRITE_WIDTH > 36 && BRAM_SIZE == "18Kb" )
	      begin 
                $display("Attribute Syntax Error : The attribute WRITE_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  For BRAM_SIZE of 18Kb, allowed values of this attribute are 1 to 18.", WRITE_WIDTH);
                $finish;
              end
            else if (WRITE_WIDTH > 72)
	      begin 
                $display("Attribute Syntax Error : The attribute WRITE_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 18 for BRAM_SIZE of 18Kb and 1 to 36 for BRAM_SIZE of 36Kb.", WRITE_WIDTH);
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
          if (READ_WIDTH != WRITE_WIDTH )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  READ_WIDTH must be equal to WRITE_WIDTH", READ_WIDTH);
              $finish;
            end
          else if (READ_WIDTH == 0 )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  This attribute must be atleast equal to 1.", READ_WIDTH);
              $finish;
            end
          else if (READ_WIDTH > 36 && BRAM_SIZE == "9Kb" )
            begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  For BRAM_SIZE of 9Kb, allowed values of this attribute are 1 to 36.", READ_WIDTH);
              $finish;
            end
          else if (READ_WIDTH > 72)
	    begin 
              $display("Attribute Syntax Error : The attribute READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  Allowed values of this attribute are 1 to 36 for BRAM_SIZE of 9Kb and 1 to 72 for BRAM_SIZE of 18Kb.", READ_WIDTH);
              $finish;
            end
          case ({WRITE_P, READ_P})

             {"FALSE", "FALSE"} , {"TRUE", "TRUE"} :  ;

             {"FALSE", "TRUE"}: 
                begin 
                  $display("Port Width Mismatch on READ_WIDTH : The width READ_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  The parity bit(s) have not been written and hence cannot be read. ", READ_WIDTH);
                end
             {"TRUE", "FALSE"}: 
                begin 
                  $display("Port Width Mismatch on WRITE_WIDTH: The width WRITE_WIDTH on BRAM_SINGLE_MACRO instance %m is set to %d.  The parity bit(s) cannot be read ", WRITE_WIDTH);
	        end
          endcase
         end //  end checks spartan6
    end

   localparam rd_width = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH == 0) ? 0 : (READ_WIDTH == 1) ? 1 : (READ_WIDTH == 2) ? 2 : (READ_WIDTH > 2 && READ_WIDTH <= 4) ? 4 : (READ_WIDTH > 4 && READ_WIDTH <= 9) ? 9 : (READ_WIDTH > 9 && READ_WIDTH <= 18) ? 18 : (READ_WIDTH > 18 && READ_WIDTH <= 36) ? 36 :  (BRAM_SIZE == "18Kb") ? 18 : 36 ) : 36;

   localparam wr_width = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH == 0) ? 0 : (WRITE_WIDTH == 1) ? 1 : (WRITE_WIDTH == 2) ? 2 : (WRITE_WIDTH > 2 && WRITE_WIDTH <= 4) ? 4 : (WRITE_WIDTH > 4 && WRITE_WIDTH <= 9) ? 9 : (WRITE_WIDTH > 9 && WRITE_WIDTH <= 18) ? 18 : (WRITE_WIDTH > 18 && WRITE_WIDTH <= 36) ? 36 : (BRAM_SIZE == "18Kb") ? 18 : 36 ) : 36;

   // Widths of Parity Bus
   localparam DIP_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH < 9) ? 0 : (WRITE_WIDTH == 9) ? 1 : (WRITE_WIDTH == 17) ? 1 : (WRITE_WIDTH == 18) ? 2 : (WRITE_WIDTH == 33) ? 1 : (WRITE_WIDTH == 34) ? 2 : (WRITE_WIDTH == 35) ? 3 : (WRITE_WIDTH == 36) ? 4 : (WRITE_WIDTH == 65) ? 1 : (WRITE_WIDTH == 66) ? 2 : (WRITE_WIDTH == 67) ? 3 : (WRITE_WIDTH == 68) ? 4 : (WRITE_WIDTH == 69) ? 5 : (WRITE_WIDTH == 70) ? 6 : (WRITE_WIDTH == 71) ? 7 : (WRITE_WIDTH == 72) ? 8 : 0 ) : 0;
  
   localparam DOP_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH < 9) ? 0 : (READ_WIDTH == 9) ? 1 : (READ_WIDTH == 17) ? 1 : (READ_WIDTH == 18) ? 2 : (READ_WIDTH == 33) ? 1 : (READ_WIDTH == 34) ? 2 : (READ_WIDTH == 35) ? 3 : (READ_WIDTH == 36) ? 4 : (READ_WIDTH == 65) ? 1 : (READ_WIDTH == 66) ? 2 : (READ_WIDTH == 67) ? 3 : (READ_WIDTH == 68) ? 4 : (READ_WIDTH == 69) ? 5 : (READ_WIDTH == 70) ? 6 : (READ_WIDTH == 71) ? 7 : (READ_WIDTH == 72) ? 8 : 0 ) : 0;

   // Widths of Data Bus
  localparam DI_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH == 1) ? 1 : (WRITE_WIDTH == 2) ? 2 : (WRITE_WIDTH > 2 && WRITE_WIDTH <= 4) ? 4 : (WRITE_WIDTH > 4 && WRITE_WIDTH <= 9) ? 8 : (WRITE_WIDTH > 9 && WRITE_WIDTH <= 18) ? 16 : (BRAM_SIZE == "18Kb" && WRITE_WIDTH > 18 && WRITE_WIDTH <= 36) ? (WRITE_WIDTH-DIP_WIDTH) : (BRAM_SIZE == "36Kb" && WRITE_WIDTH > 18 && WRITE_WIDTH <= 36) ? 32 : (BRAM_SIZE == "36Kb" && WRITE_WIDTH > 36 && WRITE_WIDTH <= 72) ? (WRITE_WIDTH-DIP_WIDTH) : (WRITE_WIDTH-DIP_WIDTH) ): (WRITE_WIDTH-DIP_WIDTH);
  
  localparam DO_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (READ_WIDTH == 1) ? 1 : (READ_WIDTH == 2) ? 2 : (READ_WIDTH > 2 && READ_WIDTH <= 4) ? 4 : (READ_WIDTH > 4 && READ_WIDTH <= 9) ? 8 : (READ_WIDTH > 9 && READ_WIDTH <= 18) ? 16 : (BRAM_SIZE == "18Kb" && READ_WIDTH > 18 && READ_WIDTH <= 36) ? (READ_WIDTH-DOP_WIDTH) : (BRAM_SIZE == "36Kb" && READ_WIDTH > 18 && READ_WIDTH <= 36) ? 32 : (BRAM_SIZE == "36Kb" && READ_WIDTH > 36 && READ_WIDTH <= 72) ? (READ_WIDTH-DOP_WIDTH) : (READ_WIDTH-DOP_WIDTH) ): (READ_WIDTH-DOP_WIDTH);

   localparam least_width = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (DI_WIDTH <= DO_WIDTH) ? DI_WIDTH : DO_WIDTH ) : DO_WIDTH;

   // Widths of Address Bus
   localparam ADDR_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (BRAM_SIZE == "9Kb") ? ( (least_width == 1) ? 13 : (least_width == 2) ? 12 : (least_width > 2 && least_width <= 4) ? 11 : (least_width > 4 && least_width <= 9) ? 10 : (least_width > 9 && least_width <= 18) ? 9 : (least_width > 18 && least_width <= 36) ? 8 : 13 ) : (BRAM_SIZE == "18Kb") ? ( (least_width == 1) ? 14 : (least_width == 2) ? 13 : (least_width > 2 && least_width <= 4) ? 12 : (least_width > 4 && least_width <= 9) ? 11 : (least_width > 9 && least_width <= 18) ? 10 : (least_width > 18 && least_width <= 36) ? 9 : (least_width > 36 && least_width <= 72) ? 8 : 14 ) : (BRAM_SIZE == "36Kb") ? ( (least_width == 1) ? 15 : (least_width == 2) ? 14 : (least_width > 2 && least_width <= 4) ? 13 : (least_width > 4 && least_width <= 9) ? 12 : (least_width > 9 && least_width <= 18) ? 11 : (least_width > 18 && least_width <= 36) ? 10 : (least_width > 36 && least_width <= 72) ? 9 : 15 ) : 15 ) : 15; 

   // Widths of Write Enables
   localparam WE_WIDTH = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6" || DEVICE == "SPARTAN6" ) ? ( (WRITE_WIDTH <= 9) ? 1 : (WRITE_WIDTH > 9 && WRITE_WIDTH <= 18) ? 2 : (WRITE_WIDTH > 18 && WRITE_WIDTH <= 36) ? 4 : (WRITE_WIDTH > 36 && WRITE_WIDTH <= 72) ? 8 : (BRAM_SIZE == "9Kb" || BRAM_SIZE == "18Kb") ? 2 : 4 ) : 4;

   // Output Ports
   output [READ_WIDTH-1:0] DO;

   // Input Ports
   input [ADDR_WIDTH-1:0] ADDR;
   input CLK;
   input [WRITE_WIDTH-1:0] DI;
   input EN;
   input REGCE;
   input RST;
   input [WE_WIDTH-1:0] WE;

// Mapping wire sizes
   localparam MAX_ADDR_SIZE = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 14 : 16 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 13 : 14 ) :
   16;
   localparam MAX_DI_SIZE   = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 32 : 64 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 32 : 64 ) :
   32;
   localparam MAX_DIP_SIZE  = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 4 : 8 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 4 : 8 ) :
   4;
   localparam MAX_DO_SIZE   = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 32 : 64 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 32 : 64 ) :
   32;
   localparam MAX_DOP_SIZE  = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 4 : 8 ) : 
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 4 : 8 ) :
   4;
   localparam MAX_WE_SIZE   = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? 4 : 8 ) :
   (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? 4 : 8 ) :
   4;
   localparam fin_rd_width = (READ_WIDTH == 0) ? 1 : READ_WIDTH;
   localparam fin_wr_width = (WRITE_WIDTH == 0) ? 1 : WRITE_WIDTH;

   wire [MAX_ADDR_SIZE-1:0] ADDR_PATTERN;
   wire [MAX_DI_SIZE-1:0] DI_PATTERN;
   wire [MAX_DIP_SIZE-1:0] DIP_PATTERN;
   wire [MAX_DO_SIZE-1:0] DO_PATTERN;
   wire [MAX_DOP_SIZE-1:0] DOP_PATTERN;
   wire [MAX_WE_SIZE-1:0] WE_PATTERN;
    
   
  wire RSTREG_PATTERN;
  wire RSTRAM_PATTERN;

  // Pattern for ADDR based on size of address  
   assign ADDR_PATTERN  = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ? ( (ADDR_WIDTH == 14) ? ADDR : (ADDR_WIDTH == 13) ? {ADDR, 1'b1} : (ADDR_WIDTH == 12) ? {ADDR, 2'b11} : (ADDR_WIDTH == 11) ? {ADDR, 3'b111} : (ADDR_WIDTH == 10) ? {ADDR, 4'b1111} : (ADDR_WIDTH == 9) ? {ADDR, 5'b11111} : ADDR ) : (BRAM_SIZE == "36Kb") ? ( (ADDR_WIDTH == 16) ? ADDR : (ADDR_WIDTH == 15) ? {1'b1, ADDR} : (ADDR_WIDTH == 14) ? {1'b1, ADDR, 1'b1} : (ADDR_WIDTH == 13) ? {1'b1, ADDR, 2'b11} : (ADDR_WIDTH == 12) ? {1'b1, ADDR, 3'b111} : (ADDR_WIDTH == 11) ? {1'b1, ADDR, 4'b1111} : (ADDR_WIDTH == 10) ? {1'b1, ADDR, 5'b11111} : (ADDR_WIDTH == 9) ? {1'b1, ADDR, 6'b111111}  : ADDR ) : ADDR ) : 
  (DEVICE == "SPARTAN6") ? ( (BRAM_SIZE == "9Kb") ? ( (ADDR_WIDTH == 13) ? ADDR : (ADDR_WIDTH == 12) ? {ADDR, 1'b1} : (ADDR_WIDTH == 11) ? {ADDR, 2'b11} : (ADDR_WIDTH == 10) ? {ADDR, 3'b111} : (ADDR_WIDTH == 9) ? {ADDR, 4'b1111} : ADDR ) : (BRAM_SIZE == "18Kb") ? ( (ADDR_WIDTH == 14) ? ADDR : (ADDR_WIDTH == 13) ? {ADDR, 1'b1} : (ADDR_WIDTH == 12) ? {ADDR, 2'b11} : (ADDR_WIDTH == 11) ? {ADDR, 3'b111} : (ADDR_WIDTH == 10) ? {ADDR, 4'b1111} : (ADDR_WIDTH == 9) ? {ADDR, 5'b11111}  : ADDR ) : ADDR) :
  ADDR;

  // Pattern for DATA bus

   generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6": 
          begin
            if (WRITE_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH == 36) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH == 72) ))
              begin : di1
                assign DIP_PATTERN = 0;
                assign DI_PATTERN = DI;
              end
            if (WRITE_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH < 36) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH < 72) ))
              begin : di2
                assign DIP_PATTERN = 0;
                assign DI_PATTERN = {{((MAX_DI_SIZE)-fin_wr_width){1'b0}}, DI};
              end
          end
         "SPARTAN6" : 
          begin
            if (WRITE_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH == 36) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH == 72) ))
              begin : dia1
                assign DIP_PATTERN = 0;
                assign DI_PATTERN = DI;
              end
            if (WRITE_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH < 36) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH < 72) ))
              begin : dia2
                assign DIP_PATTERN = 0;
                assign DI_PATTERN = {{((MAX_DI_SIZE)-fin_wr_width){1'b0}}, DI};
              end
          end // s1
       default : ;
     endcase
   endgenerate
   generate
     case(DEVICE)
       "VIRTEX5", "VIRTEX6": 
        begin
          if (WRITE_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH == 36) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH == 72) ))
            begin : di3
              assign DI_PATTERN = DI[DI_WIDTH-1:0];
              assign DIP_PATTERN =  DI[fin_wr_width-1 : DI_WIDTH];
           end
          if (WRITE_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && WRITE_WIDTH < 36) || (BRAM_SIZE == "36Kb" && WRITE_WIDTH < 72) ))
            begin : di4
              assign DI_PATTERN = {{((MAX_DI_SIZE)-DI_WIDTH){1'b0}}, DI[DI_WIDTH-1:0]};
              assign DIP_PATTERN = {{((MAX_DIP_SIZE)-DIP_WIDTH){1'b0}}, DI[fin_wr_width-1 : DI_WIDTH]};
           end
        end
       "SPARTAN6" :
          begin 
            if (WRITE_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH == 36) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH == 72) ))
              begin : dia3
                assign DI_PATTERN = DI[DI_WIDTH-1:0];
                assign DIP_PATTERN = DI[fin_wr_width-1 : DI_WIDTH];
              end
            if (WRITE_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && WRITE_WIDTH < 36) || (BRAM_SIZE == "18Kb" && WRITE_WIDTH < 72) ))
              begin : dia4
                assign DI_PATTERN = {{((MAX_DI_SIZE)-DI_WIDTH){1'b0}}, DI[DI_WIDTH-1:0]};
                assign DIP_PATTERN = {{((MAX_DIP_SIZE)-DIP_WIDTH){1'b0}}, DI[fin_wr_width-1 : DI_WIDTH]};
              end
          end // s2
       default : ;
     endcase
   endgenerate

   generate 
     case(DEVICE)
       "VIRTEX5", "VIRTEX6": 
          if (READ_P == "FALSE" && ( (BRAM_SIZE == "18Kb" && READ_WIDTH <= 36) || (BRAM_SIZE == "36Kb" && READ_WIDTH <= 72) ))
            begin : do1
              assign DO = DO_PATTERN[fin_rd_width-1:0];
            end
       "SPARTAN6":
          begin 
            if (READ_P == "FALSE" && ( (BRAM_SIZE == "9Kb" && READ_WIDTH <= 36) || (BRAM_SIZE == "18Kb" && READ_WIDTH <= 72)  ))
              begin : do1
                assign DO = DO_PATTERN[fin_rd_width-1:0];
            end
         end // s3
       default : ;
     endcase
   endgenerate
   generate 
     case(DEVICE)
       "VIRTEX5", "VIRTEX6": 
          if (READ_P == "TRUE" && ( (BRAM_SIZE == "18Kb" && READ_WIDTH <= 36) || (BRAM_SIZE == "36Kb" && READ_WIDTH <= 72) ))
            begin : do2
              assign DO = {DOP_PATTERN[DOP_WIDTH-1:0], DO_PATTERN[DO_WIDTH-1:0]};
            end
       "SPARTAN6":
          begin 
            if (READ_P == "TRUE" && ( (BRAM_SIZE == "9Kb" && READ_WIDTH <= 36) || (BRAM_SIZE == "18Kb" && READ_WIDTH <= 72) ))
              begin : do2
                assign DO = {DOP_PATTERN[DOP_WIDTH-1:0], DO_PATTERN[DO_WIDTH-1:0]};
              end
         end // s4
       default : ;
     endcase
   endgenerate

   assign WE_PATTERN = (DEVICE == "VIRTEX5" || DEVICE == "VIRTEX6") ? ( (BRAM_SIZE == "18Kb") ?  ( (WE_WIDTH == 1) ? {2{WE}} : (WE_WIDTH == 2) ? WE : WE ) : (BRAM_SIZE == "36Kb") ? ( (WE_WIDTH == 1) ? {4{WE}} : (WE_WIDTH == 2) ? {2{WE}} : (WE_WIDTH == 4) ? WE : WE ) : WE) :
(DEVICE == "SPARTAN6") ? ((BRAM_SIZE == "9Kb") ? ((WE_WIDTH == 1) ? {4{WE}} : (WE_WIDTH == 2) ? {2{WE}} : (WE_WIDTH == 4) ? WE : WE) : (BRAM_SIZE == "18Kb") ? ((WE_WIDTH == 1) ? {8{WE}} : (WE_WIDTH == 2) ? {4{WE}} : (WE_WIDTH == 4) ? {2{WE}} : (WE_WIDTH == 8) ? WE : WE):WE): 
WE; 
   assign RSTREG_PATTERN = (DO_REG == 1'b1) ? RST : 1'b0; 
   assign RSTRAM_PATTERN = (DO_REG == 1'b0) ? RST : 1'b0; 

   generate 
     case (DEVICE)
       "VIRTEX5" : 
          if (BRAM_SIZE == "18Kb" && READ_WIDTH <= 18 && WRITE_WIDTH <= 18 ) begin : bram18_single
    
          RAMB18 # ( 
            .DOA_REG (DO_REG),
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
            .INIT_A (INIT),
            .INIT_FILE (INIT_FILE),
            .READ_WIDTH_A (rd_width),
            .SIM_COLLISION_CHECK ("NONE"),
            .SIM_MODE (SIM_MODE),
            .SRVAL_A (SRVAL),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_WIDTH_A (wr_width)
            )  bram18_single (
            .DOA (DO_PATTERN), 
            .DOB (), 
            .DOPA (DOP_PATTERN), 
            .DOPB (),
            .ADDRA(ADDR_PATTERN), 
            .ADDRB(14'b0), 
            .CLKA (CLK), 
            .CLKB (1'b0), 
            .DIA (DI_PATTERN), 
            .DIB (16'b0), 
            .DIPA (DIP_PATTERN), 
            .DIPB (2'b0), 
            .ENA (EN), 
            .ENB (1'b0), 
            .REGCEA (REGCE), 
            .REGCEB (1'b0), 
            .SSRA (RST), 
            .SSRB (1'b0), 
            .WEA (WE_PATTERN), 
            .WEB (2'b0)
            );
          end
          else if (BRAM_SIZE == "18Kb" && (READ_WIDTH > 18 && READ_WIDTH <= 36) && (WRITE_WIDTH > 18 && WRITE_WIDTH <= 36) ) begin : bram18_single_1
    
          RAMB18 # ( 
            .DOA_REG (DO_REG),
            .DOB_REG (DO_REG),
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
            .INIT_A ({INIT[35:34],INIT[31:16]}),
            .INIT_B ({INIT[33:32],INIT[15:0]}),
            .INIT_FILE (INIT_FILE),
            .READ_WIDTH_A (18),
            .READ_WIDTH_B (18),
            .SIM_COLLISION_CHECK ("NONE"),
            .SIM_MODE (SIM_MODE),
            .SRVAL_A ({SRVAL[35:34],SRVAL[31:16]}),
            .SRVAL_B ({SRVAL[33:32],SRVAL[15:0]}),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_MODE_B (WRITE_MODE),
            .WRITE_WIDTH_A (18),
            .WRITE_WIDTH_B (18)
            )  bram18_single (
            .DOA (DO_PATTERN[31:16]), 
            .DOB (DO_PATTERN[15:0]), 
            .DOPA (DOP_PATTERN[3:2]), 
            .DOPB (DOP_PATTERN[1:0]),
            .ADDRA({ADDR,1'b0,3'b111}), 
            .ADDRB({ADDR,1'b1,3'b111}), 
            .CLKA (CLK), 
            .CLKB (CLK), 
            .DIA (DI_PATTERN[31:16]), 
            .DIB (DI_PATTERN[15:0]), 
            .DIPA (DIP_PATTERN[3:2]), 
            .DIPB (DIP_PATTERN[1:0]), 
            .ENA (EN), 
            .ENB (EN), 
            .REGCEA (REGCE), 
            .REGCEB (REGCE), 
            .SSRA (RST), 
            .SSRB (RST), 
            .WEA (WE_PATTERN[3:2]), 
            .WEB (WE_PATTERN[1:0])
            );
          end
          else if (BRAM_SIZE == "36Kb" && READ_WIDTH <= 36 && WRITE_WIDTH <= 36) begin : bram36_single
   
          RAMB36 # ( 
            .DOA_REG (DO_REG),
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
            .INIT_A (INIT),
            .INIT_FILE (INIT_FILE),
            .READ_WIDTH_A (rd_width),
            .SIM_COLLISION_CHECK ("NONE"),
            .SIM_MODE (SIM_MODE),
            .SRVAL_A (SRVAL),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_WIDTH_A (wr_width)
            )  bram36_single (
            .CASCADEOUTLATA (),
            .CASCADEOUTLATB (),
            .CASCADEOUTREGA (),
            .CASCADEOUTREGB (),
            .DOA (DO_PATTERN), 
            .DOB (), 
            .DOPA (DOP_PATTERN), 
            .DOPB (),
            .ADDRA (ADDR_PATTERN), 
            .ADDRB (16'b0),
            .CASCADEINLATA (1'b0),
            .CASCADEINLATB (1'b0),
            .CASCADEINREGA (1'b0),
            .CASCADEINREGB (1'b0), 
            .CLKA (CLK), 
            .CLKB (1'b0), 
            .DIA (DI_PATTERN), 
            .DIB (32'b0), 
            .DIPA (DIP_PATTERN), 
            .DIPB (4'b0), 
            .ENA (EN), 
            .ENB (1'b0), 
            .REGCEA (REGCE), 
            .REGCEB (1'b0), 
            .SSRA (RST), 
            .SSRB (1'b0), 
            .WEA (WE_PATTERN), 
            .WEB (4'b0)
            );
          end
        else if (BRAM_SIZE == "36Kb" && (READ_WIDTH > 36 && READ_WIDTH <= 72) && (WRITE_WIDTH > 36 && WRITE_WIDTH <= 72)) begin : bram36_single_1
   
          RAMB36 # ( 
            .DOA_REG (DO_REG),
            .DOB_REG (DO_REG),
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
            .INIT_A ({INIT[71:68],INIT[63:32]}),
            .INIT_B ({INIT[67:64],INIT[31:0]}),
            .INIT_FILE (INIT_FILE),
            .READ_WIDTH_A (36),
            .READ_WIDTH_B (36),
            .SIM_COLLISION_CHECK ("NONE"),
            .SIM_MODE (SIM_MODE),
            .SRVAL_A ({SRVAL[71:68],SRVAL[63:32]}),
            .SRVAL_B ({SRVAL[67:64],SRVAL[31:0]}),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_MODE_B (WRITE_MODE),
            .WRITE_WIDTH_A (36),
            .WRITE_WIDTH_B (36)
            )  bram36_single_1 (
            .CASCADEOUTLATA (),
            .CASCADEOUTLATB (),
            .CASCADEOUTREGA (),
            .CASCADEOUTREGB (),
            .DOA (DO_PATTERN[63:32]), 
            .DOB (DO_PATTERN[31:0]), 
            .DOPA (DOP_PATTERN[7:4]), 
            .DOPB (DOP_PATTERN[3:0]),
            .ADDRA ({1'b1, ADDR, 1'b0, 5'b11111}), 
            .ADDRB ({1'b1, ADDR, 1'b1, 5'b11111}),
            .CASCADEINLATA (1'b0),
            .CASCADEINLATB (1'b0),
            .CASCADEINREGA (1'b0),
            .CASCADEINREGB (1'b0), 
            .CLKA (CLK), 
            .CLKB (CLK), 
            .DIA (DI_PATTERN[63:32]), 
            .DIB (DI_PATTERN[31:0]), 
            .DIPA (DIP_PATTERN[7:4]), 
            .DIPB (DIP_PATTERN[3:0]), 
            .ENA (EN), 
            .ENB (EN), 
            .REGCEA (REGCE), 
            .REGCEB (REGCE), 
            .SSRA (RST), 
            .SSRB (RST), 
            .WEA (WE_PATTERN[7:4]), 
            .WEB (WE_PATTERN[3:0])
            );
          end
        // begin generate virtex6
        "VIRTEX6" : 
          begin
            if (BRAM_SIZE == "18Kb" && READ_WIDTH <= 18 && WRITE_WIDTH <= 18) begin : bram18_single_bl
              
             RAMB18E1 # ( 
            .DOA_REG (DO_REG),
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
            .INIT_A (INIT),
            .INIT_FILE(INIT_FILE),
            .RAM_MODE("TDP"),
            .READ_WIDTH_A (rd_width),
            .SIM_COLLISION_CHECK("NONE"),
            .SRVAL_A (SRVAL),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_WIDTH_A (wr_width)
            )  bram18_single_bl (
            .DOADO (DO_PATTERN), 
            .DOBDO (), 
            .DOPADOP (DOP_PATTERN), 
            .DOPBDOP (),
            .ADDRARDADDR(ADDR_PATTERN), 
            .ADDRBWRADDR(14'b0), 
            .CLKARDCLK (CLK), 
            .CLKBWRCLK (1'b0), 
            .DIADI (DI_PATTERN), 
            .DIBDI (16'b0), 
            .DIPADIP (DIP_PATTERN), 
            .DIPBDIP (2'b0), 
            .ENARDEN (EN), 
            .ENBWREN (1'b0), 
            .REGCEAREGCE (REGCE), 
            .REGCEB (1'b0), 
            .RSTRAMARSTRAM (RSTRAM_PATTERN), 
            .RSTREGARSTREG (RSTREG_PATTERN), 
            .RSTRAMB (1'b0), 
            .RSTREGB (1'b0), 
            .WEA (WE_PATTERN), 
            .WEBWE (4'b0)
            );
            end
            else if (BRAM_SIZE == "18Kb" && ( READ_WIDTH > 18 && READ_WIDTH <= 36) && (WRITE_WIDTH > 18 && WRITE_WIDTH <= 36)) begin : bram18_single_bl_1
              
             RAMB18E1 # ( 
            .DOA_REG (DO_REG),
            .DOB_REG (DO_REG),
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
            .INIT_A ({INIT[35:34],INIT[31:16]}),
            .INIT_B ({INIT[33:32],INIT[15:0]}),
            .INIT_FILE(INIT_FILE),
            .RAM_MODE("TDP"),
            .READ_WIDTH_A (18),
            .READ_WIDTH_B (18),
            .SIM_COLLISION_CHECK("NONE"),
            .SRVAL_A ({SRVAL[35:34],SRVAL[31:16]}),
            .SRVAL_B ({SRVAL[33:32],SRVAL[15:0]}),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_MODE_B (WRITE_MODE),
            .WRITE_WIDTH_A (18),
            .WRITE_WIDTH_B (18)
            )  bram18_single_bl_1 (
            .DOADO (DO_PATTERN[31:16]), 
            .DOBDO (DO_PATTERN[15:0]), 
            .DOPADOP (DOP_PATTERN[3:2]), 
            .DOPBDOP (DOP_PATTERN[1:0]),
            .ADDRARDADDR({ADDR,1'b0,3'b111}), 
            .ADDRBWRADDR({ADDR,1'b1,3'b111}), 
            .CLKARDCLK (CLK), 
            .CLKBWRCLK (CLK), 
            .DIADI (DI_PATTERN[31:16]), 
            .DIBDI (DI_PATTERN[15:0]), 
            .DIPADIP (DIP_PATTERN[3:2]), 
            .DIPBDIP (DIP_PATTERN[1:0]), 
            .ENARDEN (EN), 
            .ENBWREN (EN), 
            .REGCEAREGCE (REGCE), 
            .REGCEB (REGCE), 
            .RSTRAMARSTRAM (RSTRAM_PATTERN), 
            .RSTREGARSTREG (RSTREG_PATTERN), 
            .RSTRAMB (RSTRAM_PATTERN), 
            .RSTREGB (RSTRAM_PATTERN), 
            .WEA (WE_PATTERN[3:2]), 
            .WEBWE (WE_PATTERN)
            );
            end
             else if (BRAM_SIZE == "36Kb" && READ_WIDTH <= 36 && WRITE_WIDTH <= 36 ) begin : bram36_single_bl

             RAMB36E1 # ( 
            .DOA_REG (DO_REG),
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
            .INIT_A (INIT),
            .INIT_FILE (INIT_FILE),
            .EN_ECC_READ("FALSE"),
            .EN_ECC_WRITE("FALSE"),
            .RAM_MODE("TDP"),
            .READ_WIDTH_A (rd_width),
            .SIM_COLLISION_CHECK("NONE"),
            .SRVAL_A (SRVAL),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_WIDTH_A (wr_width)
            )  bram36_single_bl (
            .CASCADEOUTA (),
            .CASCADEOUTB (),
            .DBITERR (),
            .DOADO (DO_PATTERN), 
            .DOBDO (), 
            .DOPADOP (DOP_PATTERN), 
            .DOPBDOP (),
            .ECCPARITY (),
            .RDADDRECC (),
            .SBITERR (),
            .ADDRARDADDR (ADDR_PATTERN), 
            .ADDRBWRADDR (16'b0),
            .CASCADEINA (1'b0),
            .CASCADEINB (1'b0), 
            .CLKARDCLK (CLK), 
            .CLKBWRCLK (1'b0), 
            .DIADI (DI_PATTERN), 
            .DIBDI (32'b0), 
            .DIPADIP (DIP_PATTERN), 
            .DIPBDIP (4'b0), 
            .ENARDEN (EN), 
            .ENBWREN (1'b0), 
            .INJECTDBITERR(1'b0),
            .INJECTSBITERR(1'b0),
            .REGCEAREGCE (REGCE), 
            .REGCEB (1'b0), 
            .RSTRAMARSTRAM (RSTRAM_PATTERN), 
            .RSTRAMB (1'b0), 
            .RSTREGARSTREG (RSTREG_PATTERN), 
            .RSTREGB (1'b0), 
            .WEA (WE_PATTERN), 
            .WEBWE (8'b0)
            );
           end
           else if (BRAM_SIZE == "36Kb" && (READ_WIDTH > 36 && READ_WIDTH <= 72) && (WRITE_WIDTH > 36 && WRITE_WIDTH <= 72) ) begin : bram36_single_bl_1

             RAMB36E1 # ( 
            .DOA_REG (DO_REG),
            .DOB_REG (DO_REG),
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
            .INIT_A ({INIT[71:68],INIT[63:32]}),
            .INIT_B ({INIT[67:64],INIT[31:0]}),
            .INIT_FILE (INIT_FILE),
            .EN_ECC_READ("FALSE"),
            .EN_ECC_WRITE("FALSE"),
            .RAM_MODE("TDP"),
            .READ_WIDTH_A (36),
            .READ_WIDTH_B (36),
            .SIM_COLLISION_CHECK("NONE"),
            .SRVAL_A ({SRVAL[71:68],SRVAL[63:32]}),
            .SRVAL_B ({SRVAL[67:64],SRVAL[31:0]}),
            .WRITE_MODE_A (WRITE_MODE),
            .WRITE_MODE_B (WRITE_MODE),
            .WRITE_WIDTH_A (36),
            .WRITE_WIDTH_B (36)
            )  bram36_single_bl (
            .CASCADEOUTA (),
            .CASCADEOUTB (),
            .DBITERR (),
            .DOADO (DO_PATTERN[63:32]), 
            .DOBDO (DO_PATTERN[31:0]), 
            .DOPADOP (DOP_PATTERN[7:4]), 
            .DOPBDOP (DOP_PATTERN[3:0]),
            .ECCPARITY (),
            .RDADDRECC (),
            .SBITERR (),
            .ADDRARDADDR ({1'b1,ADDR,1'b0,5'b11111}), 
            .ADDRBWRADDR ({1'b1,ADDR,1'b1,5'b11111}),
            .CASCADEINA (1'b0),
            .CASCADEINB (1'b0), 
            .CLKARDCLK (CLK), 
            .CLKBWRCLK (CLK), 
            .DIADI (DI_PATTERN[63:32]), 
            .DIBDI (DI_PATTERN[31:0]), 
            .DIPADIP (DIP_PATTERN[7:4]), 
            .DIPBDIP (DIP_PATTERN[3:0]), 
            .ENARDEN (EN), 
            .ENBWREN (EN), 
            .INJECTDBITERR(1'b0),
            .INJECTSBITERR(1'b0),
            .REGCEAREGCE (REGCE), 
            .REGCEB (REGCE), 
            .RSTRAMARSTRAM (RSTRAM_PATTERN), 
            .RSTRAMB (RSTRAM_PATTERN), 
            .RSTREGARSTREG (RSTREG_PATTERN), 
            .RSTREGB (RSTREG_PATTERN), 
            .WEA (WE_PATTERN[7:4]), 
            .WEBWE (WE_PATTERN)
            );
           end
         end  // end generate virtex6
        // begin generate spartan6
       "SPARTAN6" :  
          begin
            if (BRAM_SIZE == "9Kb" && (READ_WIDTH == WRITE_WIDTH) && (READ_WIDTH <= 18) ) begin : bram9_single_stan
              RAMB8BWER # ( 
                .DOA_REG (DO_REG),
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
                .INIT_A (INIT),
                .DATA_WIDTH_A (rd_width),
                .RAM_MODE ("TDP"),
                .SIM_COLLISION_CHECK ("NONE"),
                .SRVAL_A (SRVAL),
                .WRITE_MODE_A (WRITE_MODE)
                )  ramb8bwe_single (
                .DOADO (DO_PATTERN), 
                .DOBDO (), 
                .DOPBDOP (),
                .DOPADOP (DOP_PATTERN), 
                .ADDRAWRADDR(ADDR_PATTERN), 
                .ADDRBRDADDR(13'b0), 
                .CLKAWRCLK (CLK), 
                .CLKBRDCLK (1'b0), 
                .DIADI (DI_PATTERN), 
                .DIBDI (16'b0), 
                .DIPADIP (DIP_PATTERN), 
                .DIPBDIP (2'b0), 
                .ENAWREN (EN), 
                .ENBRDEN (1'b0), 
                .REGCEA (REGCE), 
                .REGCEBREGCE (1'b0), 
                .RSTA (RST), 
                .RSTBRST (1'b0), 
                .WEAWEL (WE_PATTERN), 
                .WEBWEU (2'b0)
                );
            end
            else if (BRAM_SIZE == "9Kb" && (READ_WIDTH == WRITE_WIDTH) && (READ_WIDTH > 18 && READ_WIDTH <= 36) ) begin : bram9_single_stan_1
              RAMB8BWER # ( 
                .DOA_REG (DO_REG),
                .DOB_REG (DO_REG),
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
                .INIT_A ({INIT[35:34],INIT[31:16]}),
                .INIT_B ({INIT[33:32],INIT[15:0]}),
                .DATA_WIDTH_A (18),
                .DATA_WIDTH_B (18),
                .RAM_MODE ("TDP"),
                .SIM_COLLISION_CHECK ("NONE"),
                .SRVAL_A ({SRVAL[35:34],SRVAL[31:16]}),
                .SRVAL_B ({SRVAL[33:32],SRVAL[15:0]}),
                .WRITE_MODE_B (WRITE_MODE),
                .WRITE_MODE_A (WRITE_MODE)
                )  ram8bwe_single_1 (
                .DOADO (DO_PATTERN[31:16]), 
                .DOBDO (DO_PATTERN[15:0]), 
                .DOPADOP (DOP_PATTERN[3:2]),
                .DOPBDOP (DOP_PATTERN[1:0]), 
                .ADDRAWRADDR({ADDR,1'b0,4'b1111}), 
                .ADDRBRDADDR({ADDR,1'b1,4'b1111}), 
                .CLKAWRCLK (CLK), 
                .CLKBRDCLK (CLK), 
                .DIADI (DI_PATTERN[31:16]), 
                .DIBDI (DI_PATTERN[15:0]), 
                .DIPADIP (DIP_PATTERN[3:2]), 
                .DIPBDIP (DIP_PATTERN[1:0]), 
                .ENAWREN (EN), 
                .ENBRDEN (EN), 
                .REGCEA (REGCCE), 
                .REGCEBREGCE (REGCE), 
                .RSTA (RST), 
                .RSTBRST (RST), 
                .WEAWEL (WE_PATTERN[3:2]), 
                .WEBWEU (WE_PATTERN[1:0])
                );
            end
            else if (BRAM_SIZE == "18Kb" && (READ_WIDTH == WRITE_WIDTH) && (READ_WIDTH <=36) ) begin : bram18_single_stan
             RAMB16BWER # ( 
                .DOA_REG (DO_REG),
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
                .INIT_A (INIT),
                .DATA_WIDTH_A (rd_width),
                .DATA_WIDTH_B (rd_width),
                .SIM_COLLISION_CHECK ("NONE"),
                .SIM_DEVICE ("SPARTAN6"),
                .SRVAL_A (SRVAL),
                .WRITE_MODE_A (WRITE_MODE)
                )  ram16bwe_single (
                .DOA (DO_PATTERN), 
                .DOB (), 
                .DOPA (DOP_PATTERN), 
                .DOPB (),
                .ADDRA(ADDR_PATTERN), 
                .ADDRB(14'b0), 
                .CLKA (CLK), 
                .CLKB (1'b0), 
                .DIA (DI_PATTERN), 
                .DIB (32'b0), 
                .DIPA (DIP_PATTERN), 
                .DIPB (4'b0), 
                .ENA (EN), 
                .ENB (1'b0), 
                .REGCEA (REGCE), 
                .REGCEB (1'b0), 
                .RSTA (RST), 
                .RSTB (1'b0), 
                .WEA (WE_PATTERN), 
                .WEB (4'b0)
                );
            end
            else if (BRAM_SIZE == "18Kb" && (READ_WIDTH == WRITE_WIDTH) && (READ_WIDTH > 36 && READ_WIDTH <= 72) ) begin : bram18_single_stan_1
             RAMB16BWER # ( 
                .DOA_REG (DO_REG),
                .DOB_REG (DO_REG),
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
                .INIT_A ({INIT[71:68],INIT[63:32]}),
                .INIT_B ({INIT[67:64],INIT[31:0]}),
                .DATA_WIDTH_A (36),
                .DATA_WIDTH_B (36),
                .SIM_COLLISION_CHECK ("NONE"),
                .SIM_DEVICE ("SPARTAN6"),
                .SRVAL_A ({SRVAL[71:68],SRVAL[63:32]}),
                .SRVAL_B ({SRVAL[67:64],SRVAL[31:0]}),
                .WRITE_MODE_A (WRITE_MODE),
                .WRITE_MODE_B (WRITE_MODE)
                )  ram16bwe_single_1 (
                .DOA (DO_PATTERN[63:32]), 
                .DOB (DO_PATTERN[31:0]), 
                .DOPA (DOP_PATTERN[7:4]), 
                .DOPB (DOP_PATTERN[3:0]),
                .ADDRA({ADDR,1'b0,5'b11111}), 
                .ADDRB({ADDR,1'b1,5'b11111}), 
                .CLKA (CLK), 
                .CLKB (CLK), 
                .DIA (DI_PATTERN[63:32]), 
                .DIB (DI_PATTERN[31:0]), 
                .DIPA (DIP_PATTERN[7:4]), 
                .DIPB (DIP_PATTERN[3:0]), 
                .ENA (EN), 
                .ENB (EN), 
                .REGCEA (REGCE), 
                .REGCEB (REGCE), 
                .RSTA (RST), 
                .RSTB (RST), 
                .WEA (WE_PATTERN[7:4]), 
                .WEB (WE_PATTERN[3:0])
                );
            end
          end // end generate spartan6
        default : ;
     endcase
   endgenerate  
endmodule
