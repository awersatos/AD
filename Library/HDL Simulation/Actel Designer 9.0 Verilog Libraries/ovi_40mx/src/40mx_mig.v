/*  
               =========================================
               =                                       =
               =         40mx VERILOG  LIB              =
               =        ACTEL  CORPORATION             =
               =                                       =
               =========================================
*/ 
  
 //BUILT on 07/25/01 17:31:50 
  
  
     
//--------------------------------------------------------------------
//-                    cell  BUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BUF(A, Y);
    
    input A;
    output Y;
    
    buf  BF1  (Y, A);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm" ;




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TA153.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TA153 ( C0, C1, C2, C3, A, B, EN, Y);
    
    input C0, C1, C2, C3, A, B, EN;
    output Y;
    
        U_MUX_4 inst1 (Y_EFF, C0, C1, C2, C3, A, B);
        not     inst2 (NEN, EN); 
        and     inst3 (Y, NEN, Y_EFF);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C0 = 1; 
         specparam   InputLoad$C1 = 1; 
         specparam   InputLoad$C2 = 1; 
         specparam   InputLoad$C3 = 1; 
         specparam   InputLoad$EN = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C0$Y   = 1;
         specparam   ExtraDelayPaths$C1$Y   = 1;
         specparam   ExtraDelayPaths$C2$Y   = 1;
         specparam   ExtraDelayPaths$C3$Y   = 1;
         specparam   ExtraDelayPaths$EN$Y   = 0;



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C2 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C3 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (EN => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TA157.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TA157 ( A, B, S, EN, Y);
    
    input A, B, S, EN;
    output Y;
    
	U_MUX_2	inst1 (Y_EFF, A, B, S);
        not     inst2 (NEN, EN);
	and	inst3 (Y, NEN, Y_EFF);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$EN = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (EN => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XNOR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XNOR(A, B, Y);
    
    input A, B;
    output Y;
    
    xnor XNR1   (Y, A, B);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XOR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XOR(A, B, Y);
    
    input A, B;
    output Y;
    
    xor XR1   (Y, A, B);
    
    specify

         specparam   LibName     = "act1";    
         specparam   InputLoad$A  = 1; 
         specparam   InputLoad$B  = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      

//  ------------------------------  END of 40mx_mig.v ----------------------------
