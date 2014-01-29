/*  
               =========================================
               =                                       =
               =         40mx VERILOG  LIB              =
               =        ACTEL  CORPORATION             =
               =                                       =
               =========================================
*/ 
  
 //BUILT on 07/25/01 17:29:49 
  
  
     
//--------------------------------------------------------------------
//-                    cell  AND2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND2(A, B, Y);
    
    input A, B;
    output Y;
    
    and AN1   (Y, A, B);
    
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
//-                    cell  AND2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND2A(A, B, Y);
    
    input A, B;
    output Y;
    
    not NT1   (A_INT_, A);
    and AN1   (Y, A_INT_, B);
    
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
//-                    cell  AND2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND2B(A, B, Y);
    
    input A, B;
    output Y;
    
    nor NR1   (Y, A, B);
    
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
//-                    cell  AND3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    and AN1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND3A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not NT1   (A_INT, A);
    and AN1   (Y, A_INT, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND3B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not NT1   (C_INT, C);
    nor NR1   (Y, A, B, C_INT);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
  
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND3C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    nor NR1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
  
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND4(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    and AN1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND4A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (A_INT_, A);
    and AN1   (Y, A_INT_, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND4B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AND4_B inst1  (Y, A, B, C, D);   
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND4C(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (D_INT_, D);
    nor NR1   (Y, A, B, C, D_INT_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AND4D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND4D(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    nor NR1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    and AN1   (ANAB, A, B);
    or  OR1   (Y, ANAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO1A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_AO_1A  inst1  (Y, A, B, C);
      
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO1B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_AO_1B  inst1  (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO1C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not      NT1    (C_INT_, C);
    U_AO_1A  inst1  (Y, A, B, C_INT_);
      
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO2(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    and AN1   (ANAB, A, B);
    or  OR1   (Y, ANAB, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO2A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AO_1A  inst1  (Y_INT, A, B, C);
    or       OR1    (Y, Y_INT, D);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   InputLoad$D = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO3(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not      NT1    (A_INT, A);
    U_AO_3A  inst1  (Y, A_INT, B, C, D);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO4A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AO_4A  inst1  (Y, A, B, C, D);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO5A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO5A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AO_5A  inst1  (Y, A, B, C, D);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AOI1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    and AN1   (ANAB, A, B);
    nor NR1   (Y, ANAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AOI1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI1A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_AO_1A  inst1  (Y_INT_, A, B, C);
    not      NT1    (Y, Y_INT_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AOI1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI1B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_AO_1B  inst1  (Y_INT_, A, B, C);
    not      NT1    (Y, Y_INT_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AOI2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI2A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AO_1A  inst1  (Y_INT, A, B, C);
    nor      NR1   (Y, Y_INT, D);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AOI2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI2B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AOI_2B  inst1  (Y, A, B, C, D);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   InputLoad$D = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AOI3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI3A(A, B, C, D, Y);

    input A, B, C, D;
    output Y;

    U_OA_5  inst1  (Y, A, B, C, D);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AOI4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI4(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AOI_4  inst1   (Y, A, B, C, D);
      
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 0;
         specparam   ExtraDelayPaths$B$Y   = 0;
         specparam   ExtraDelayPaths$C$Y   = 1;
         specparam   ExtraDelayPaths$D$Y   = 1;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AX1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AX1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_AX_1   inst1  (Y, A, B, C);
        
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AX1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AX1A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_AX_1   inst1  (Y_INT_, A, B, C);
    not      NT1    (Y, Y_INT_);
        
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AX1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AX1B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    nor  NR1   (NRAB, A, B);
    xor  XR1   (Y, NRAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  BIBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BIBUF(D, E, PAD, Y);
    
    input D, E;
    output Y;
    inout PAD;
    
    bufif1  BF1   (PAD, D, E);
    buf     BF2   (Y, PAD);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 0; 
         specparam   InputLoad$E = 0; 
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$PAD = 0;
         specparam   OutputLoad$Y = 0;
         specparam   MacroType = "io";




        (E => PAD) = (0.0,0.0,1.0:1.0:1.0,1.0:1.0:1.0,1.0:1.0:1.0,1.0:1.0:1.0);
        (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  BUFA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BUFA(A, Y);
    
    input A;
    output Y;
    
    buf  BF1  (Y, A);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  BUFD.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BUFD(A, Y);
    
    input A;
    output Y;
    
    buf  BF1  (Y, A);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  BUFF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BUFF(A, Y);
    
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
//-                    cell  CLKBIBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CLKBIBUF(D, E, PAD, Y);
    
    input   D, E;
    output  Y;
    inout   PAD;
        
    bufif1      BFIF1  (PAD, D, E);
    buf         BF1    (Y, PAD);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "io";
  



    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
    (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CLKBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CLKBUF(PAD, Y);
    
    input PAD;
    output Y;
    
    buf  BF1  (Y, PAD);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$Y = 0;
         specparam   MacroType = "clkbuf";




        (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CM8A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CM8A(A0, A1, SA, B0, B1, SB, S0, S1, Y);
    
    input A0, A1, SA, B0, B1, SB, S0, S1;
    output Y;

    or       or1  (Y2, S0, S1);
    U_MUX_2  mux1 (T1, A0, A1, SA);
    U_MUX_2  mux2 (T2, B0, B1, SB);
    U_MUX_2  mux3 (Y, T1, T2, Y2);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A0 = 1;
         specparam   InputLoad$A1 = 1;
         specparam   InputLoad$B0 = 1;
         specparam   InputLoad$B1 = 1;
         specparam   InputLoad$SA = 1;
         specparam   InputLoad$SB = 1;
         specparam   InputLoad$S0 = 1;
         specparam   InputLoad$S1 = 1;
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




         ( A0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( A1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( B0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( B1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( SA => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( SB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1(D, CLK, Q);
    
    input    D, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFP  
                inst1 (Q, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D, 0.0, NOTIFY_REG);
  
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1A(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPQ  
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          (posedge CLK =>  (QN -: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         
      $setup(D, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D, 0.0, NOTIFY_REG);
  
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1B(D, CLK, Q);
    
    input    D, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFN  
                inst1 (Q, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D, 0.0, NOTIFY_REG);
  
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DF1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1C(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNQ 
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          (negedge CLK =>  (QN -: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         
      $setup(D, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D, 0.0, NOTIFY_REG);

      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (!CLR)
          (posedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& (~CLR), 0.0, NOTIFY_REG);
  

      $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1A(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (!CLR)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& (~CLR), 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1B(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPRB 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (CLR)
         (posedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& CLR, 0.0,  NOTIFY_REG);


      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
 
      $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1C(D, CLK, CLR, QN);
    
    input    D, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPRQ 
                inst1 (QN, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (!CLR)
          (posedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (QN +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& (~CLR), 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1D(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNRB 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (CLR)
         (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& CLR,  0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1E(D, CLK, CLR, QN);
    
    input    D, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPRBQ 
                inst1 (QN, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (CLR)
          (posedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (QN +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& CLR, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1F(D, CLK, CLR, QN);
    
    input    D, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNRQ 
                inst1 (QN, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (!CLR)
         (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge CLR =>  (QN +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& (~CLR), 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG);
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFC1G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1G(D, CLK, CLR, QN);
    
    input    D, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNRBQ 
                inst1 (QN, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (CLR)
         (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge CLR =>  (QN +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& CLR, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCE  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& E, 0.0, NOTIFY_REG);

      $setup(posedge E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge E, 0.0, NOTIFY_REG);
  
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE1B(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCEB  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (!E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& (~E), 0.0, NOTIFY_REG);

      $setup(negedge E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E, 0.0, NOTIFY_REG);
  
      $width(negedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE1C(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCEB  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (!E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& (~E), 0.0, NOTIFY_REG);

      $setup(negedge E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E, 0.0, NOTIFY_REG);
    
      $width(negedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE2D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE2D(D, E, CLK, PRE, CLR, Q);
    
    input    D, E, CLK, PRE, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNX  
                inst1 (Q, D, CLK, CLR, PRE_, E_, NOTIFY_REG);
                
        not   N1    (PRE_, PRE);
        not   N2    (E_, E);

      
       and   AN1   (ENABLE, CLR, PRE_, E_);
       and   AN2   (EN1, CLR, PRE_);
       nor   NR1   (EN2, PRE, E);
       and   AN3   (EN3, CLR, E_);
           
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (!E && CLR && !PRE)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
          if (CLR)
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!PRE)
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);



      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge PRE, negedge CLK &&& EN3, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, negedge CLK &&& EN2, 0.0, NOTIFY_REG);


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE3A(D, E, CLK, CLR, Q);
    
    input    D, E, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCERB  
                inst1 (Q, D, CLK, CLR, E, NOTIFY_REG);
                
       
       and  AN1   (ENABLE, E, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (E && CLR)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge E &&& CLR, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, posedge CLK &&& E, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE3B(D, E, CLK, CLR, Q);
    
    input    D, E, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCERB  
                inst1 (Q, D, CLK, CLR, E, NOTIFY_REG);
                
       
       and  AN1   (ENABLE, E, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (E && CLR)
          (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
          (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E &&& CLR, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, negedge CLK &&& E, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE3C(D, E, CLK, CLR, Q);
    
    input    D, E, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCERB  
                inst1 (Q, D, CLK, CLR, E_, NOTIFY_REG);
                
       
       not  N1  (E_, E);
       and  AN1 (ENABLE, E_, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (!E && CLR)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $setup(negedge E, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E &&& CLR, 0.0, NOTIFY_REG);

      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, posedge CLK &&& E_, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE3D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE3D(D, E, CLK, CLR, Q);
    
    input    D, E, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCERB  
                inst1 (Q, D, CLK, CLR, E_, NOTIFY_REG);
                
       
       not  N1    (E_, E);
       and  AN1   (ENABLE, E_, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (!E && CLR)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E &&& CLR, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge CLR, negedge CLK &&& E_, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE4(D, E, CLK, PRE, Q);
    
    input    D, E, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCES  
                inst1 (Q, D, CLK, PRE, E, NOTIFY_REG);
                
       
       not  N1    (PRE_, PRE);
       and  AN1   (ENABLE, E, PRE_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   InputLoad$PRE = 3; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (E && !PRE)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, posedge CLK &&& PRE_, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge E &&& PRE_, 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $recovery(negedge PRE, posedge CLK &&& E, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE4A(D, E, CLK, PRE, Q);
    
    input    D, E, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCES  
                inst1 (Q, D, CLK, PRE, E, NOTIFY_REG);
                
       
       not  N1    (PRE_, PRE);
       and  AN1   (ENABLE, E, PRE_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   InputLoad$PRE = 3; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (E && !PRE)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, negedge CLK &&& PRE_, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E &&& PRE_, 0.0, NOTIFY_REG);
  

      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $recovery(negedge PRE, negedge CLK &&& E, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE4B(D, E, CLK, PRE, Q);
    
    input    D, E, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCEBS  
                inst1 (Q, D, CLK, PRE, E, NOTIFY_REG);
                
       
       nor   NR1   (ENABLE, E, PRE);
           
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   InputLoad$PRE = 3; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (!(E || PRE))
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $recovery(negedge PRE, posedge CLK &&& ~E, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE4C(D, E, CLK, PRE, Q);
    
    input    D, E, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCEBS  
                inst1 (Q, D, CLK, PRE, E, NOTIFY_REG);
                
       
       nor   NR1   (ENABLE, E, PRE);
           
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   InputLoad$PRE = 3; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (!(E || PRE))
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, negedge CLK &&& ~E, 0.0, NOTIFY_REG);


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFEA(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCE  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& E, 0.0, NOTIFY_REG);

      $setup(posedge E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E, 0.0, NOTIFY_REG);
  
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFEB(D, E, CLK, PRE, CLR, Q);
    
    input    D, E, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPX  
                inst1 (Q, D, CLK, CLR, PRE_, E, NOTIFY_REG);
                
        not   N1    (PRE_, PRE);

      
       and   AN1   (ENABLE, CLR, PRE_, E);
       and   AN2   (EN1, CLR, PRE_);
       and   AN3   (EN2, PRE_, E);
       and   AN4   (EN3, CLR, E);
           
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (E && CLR && !PRE)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
          if (CLR)
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!PRE)
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, negedge E &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge PRE, posedge CLK &&& EN3, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, posedge CLK &&& EN2, 0.0, NOTIFY_REG);


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFEC(D, E, CLK, PRE, CLR, Q);
    
    input    D, E, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNX  
                inst1 (Q, D, CLK, CLR, PRE_, E, NOTIFY_REG);
                
        not   N1    (PRE_, PRE);

      
       and   AN1   (ENABLE, CLR, PRE_, E);
       and   AN2   (EN1, CLR, PRE_);
       and   AN3   (EN2, PRE_, E);
       and   AN4   (EN3, CLR, E);
           
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
          if (E && CLR && !PRE)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
          if (CLR)
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!PRE)
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E &&& EN1, 0.0, NOTIFY_REG);
 

      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, negedge CLK &&& EN3, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, negedge CLK &&& EN2, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFED.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFED(D, E, CLK, PRE, CLR, Q);
    
    input    D, E, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPX  
                inst1 (Q, D, CLK, CLR, PRE_, E_, NOTIFY_REG);
                
        not   N1    (PRE_, PRE);
        not   N2    (E_, E);

      
       and   AN1   (ENABLE, CLR, PRE_, E_);
       and   AN2   (EN1, CLR, PRE_);
       nor   NR1   (EN2, PRE, E);
       and   AN3   (EN3, CLR, E_);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
          if (!E && CLR && !PRE)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
          if (CLR)
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!PRE)
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge PRE, posedge CLK &&& EN3, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, posedge CLK &&& EN2, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM (A, B, S, CLK, Q);
    
    input    A, B, S, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSD  
                inst1 (Q, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& (~S), 0.0, NOTIFY_REG);

      $setup(B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& S, 0.0, NOTIFY_REG);
 
      $setup(S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN, 0.0, NOTIFY_REG);
 
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM1B(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S)
            (posedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (posedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& (~S), 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& S, 0.0, NOTIFY_REG);

      $setup(S, posedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN, 0.0, NOTIFY_REG);

      $width(posedge CLK, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM1C(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S)
            (negedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (negedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& (~S), 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& S, 0.0, NOTIFY_REG);
      $setup(S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN, 0.0, NOTIFY_REG);

      $width(negedge CLK, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM3(A, B, S, CLK, CLR, Q);
    
    input    A, B, S, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSDR  
                inst1 (Q, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR_, S);
      not    N1    (CLR_, CLR);
      nor    AN2   (EN_A, S, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR_, EN);
      
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && !CLR)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !CLR)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);
 
      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM3B(A, B, S, CLK, CLR, Q);
    
    input    A, B, S, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSDRB  
                inst1 (Q, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S && CLR)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && CLR)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM3E(A, B, S, CLK, CLR, Q);
    
    input    A, B, S, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSDR  
                inst1 (Q, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR_, S);
      not    N1    (CLR_, CLR);
      nor    AN2   (EN_A, S, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR_, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S && !CLR)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !CLR)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM3F(A, B, S, CLK, CLR, QN);
    
    input    A, B, S, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSDRQ  
                inst1 (QN, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR_, S);
      not    N1    (CLR_, CLR);
      nor    AN2   (EN_A, S, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR_, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && !CLR)
            (posedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !CLR)
            (posedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM3G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM3G(A, B, S, CLK, CLR, QN);
    
    input    A, B, S, CLK, CLR;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSDRQ  
                inst1 (QN, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR_, S);
      not    N1    (CLR_, CLR);
      nor    AN2   (EN_A, S, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR_, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S && !CLR)
            (negedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !CLR)
            (negedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM4(A, B, S, CLK, PRE, Q);
    
    input    A, B, S, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSDS  
                inst1 (Q, A, CLK, B, S, PRE, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, PRE_, S);
      not    N1    (PRE_, PRE);
      nor    AN2   (EN_A, S, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE_, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && !PRE)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !PRE)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE_, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM4A(A, B, S, CLK, PRE, Q);
    
    input    A, B, S, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSDSB  
                inst1 (Q, A, CLK, B, S, PRE, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, PRE, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && PRE)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && PRE)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM4B(A, B, S, CLK, PRE, Q);
    
    input    A, B, S, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSDSB  
                inst1 (Q, A, CLK, B, S, PRE, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, PRE, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S && PRE)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && PRE)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM4C(A, B, S, CLK, PRE, QN);
    
    input    A, B, S, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSDSBQ  
                inst1 (QN, A, CLK, B, S, PRE, NOTIFY_REG);
                
      
      and    AN1   (EN_B, PRE, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && PRE)
            (posedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && PRE)
            (posedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM4D(A, B, S, CLK, PRE, QN);
    
    input    A, B, S, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSDSBQ
                inst1 (QN, A, CLK, B, S, PRE, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, PRE, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S && PRE)
            (negedge CLK =>  (QN -: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && PRE)
            (negedge CLK =>  (QN -: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM4E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM4E(A, B, S, CLK, PRE, Q);
    
    input    A, B, S, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSDS  
                inst1 (Q, A, CLK, B, S, PRE, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, PRE_, S);
      not    N1    (PRE_, PRE);
      nor    AN2   (EN_A, S, PRE);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, PRE_, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S && !PRE)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !PRE)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE_, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& PRE_, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM5A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM5A(A, B, S, CLK, PRE, CLR, Q);
    
    input    A, B, S, CLK, PRE, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_2 
                 inst1  (D_EFF, A, B, S);
    
       UFPRBSX  
                inst2 (Q, D_EFF, CLK, CLR, PRE_, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, ENABLE, S);
      not    N1    (PRE_, PRE);
      and    AN2   (ENABLE, PRE_, CLR);
      not    N2    (S_, S);
      and    AN3   (EN_A, ENABLE, S_);
      xor    XR1   (EN, A, B);
      and    AN4   (EN1, ENABLE, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && !PRE && CLR)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !PRE && CLR)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
          if (CLR) 
            (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!PRE)
            (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge PRE, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, posedge CLK &&& PRE_, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM5B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM5B(A, B, S, CLK, PRE, CLR, Q);
    
    input    A, B, S, CLK, PRE, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_2 
                 inst1  (D_EFF, A, B, S);
    
       UFNRBSX  
                inst2 (Q, D_EFF, CLK, CLR, PRE_, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, ENABLE, S);
      not    N1    (PRE_, PRE);
      and    AN2   (ENABLE, PRE_, CLR);
      not    N2    (S_, S);
      and    AN3   (EN_A, ENABLE, S_);
      xor    XR1   (EN, A, B);
      and    AN4   (EN1, ENABLE, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S && !PRE && CLR)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !PRE && CLR)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
          if (CLR) 
            (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!PRE)
            (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(S, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN1, 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $recovery(negedge PRE, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, negedge CLK &&& PRE_, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFMA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFMA(A, B, S, CLK, Q);
    
    input    A, B, S, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSD  
                inst1 (Q, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


      
          if (!S)
            (negedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S)
            (negedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, negedge CLK &&& (~S), 0.0, NOTIFY_REG);
      $hold(negedge CLK, A &&& (~S), 0.0, NOTIFY_REG);
      $setup(B, negedge CLK &&& S, 0.0, NOTIFY_REG);
      $hold(negedge CLK, B &&& S, 0.0, NOTIFY_REG);
 
      $setup(S, negedge CLK &&& EN, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S &&& EN, 0.0, NOTIFY_REG);
   
      $width(negedge CLK, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFMB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFMB(A, B, S, CLK, CLR, Q);
    
    input    A, B, S, CLR, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSDRB  
                inst1 (Q, A, CLK, B, S, CLR, NOTIFY_REG);
    
                
      
      and    AN1   (EN_B, CLR, S);
      not    N1    (S_, S);
      and    AN2   (EN_A, S_, CLR);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, CLR, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && CLR)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && CLR)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);
 
      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);
 

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);

  
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFME1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFME1A(A, B, S, E, CLK, Q);
    
    input    A, B, S, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       U_MUX_2  
                inst1  (D_EFF, A, B, S);
       UFPCEB  
                inst2 (Q, D_EFF, CLK, E, NOTIFY_REG);
    
                
      
      not    N1    (E_, E);
      and    AN1   (EN_B, E_, S);
      nor    AN2   (EN_A, S, E);
      xor    XR1   (EN, A, B);
      and    AN3   (EN1, E_, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$E = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


      
          if (!S && !E)
            (posedge CLK =>  (Q +: A))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S && !E)
            (posedge CLK =>  (Q +: B))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(A, posedge CLK &&& EN_A, 0.0, NOTIFY_REG);
      $hold(posedge CLK, A &&& EN_A, 0.0, NOTIFY_REG);
      $setup(B, posedge CLK &&& EN_B, 0.0, NOTIFY_REG);
      $hold(posedge CLK, B &&& EN_B, 0.0, NOTIFY_REG);

      $setup(negedge E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E, 0.0, NOTIFY_REG);

      $setup(S, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S &&& EN1, 0.0, NOTIFY_REG);

      $width(posedge CLK &&& E_, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E_, 0.0, 0, NOTIFY_REG);
      
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPS 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (!PRE)
          (posedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1A(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNS 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (!PRE)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& (~PRE), 0.0,  NOTIFY_REG);
  

      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1B(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSB 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (PRE)
          (posedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& PRE, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1C(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (!PRE)
          (posedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1D(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSB 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (PRE)
          (negedge CLK =>  (Q +: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& PRE, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1E(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSBQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (PRE)
         (posedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& PRE, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1F(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (!PRE)
         (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (posedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1G(D, CLK, PRE, QN);
    
    input    D, CLK, PRE;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSBQ 
                inst1 (QN, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          
         if (PRE)
         (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& PRE, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);


  
      $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFPC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPC(D, CLK, PRE, CLR, Q);
    
    input  D, CLR, PRE, CLK;
    output Q;
    
    reg NOTIFY_REG;
    
       UDP_DFPC 
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
         if (CLR && !PRE)
          (posedge CLK => (Q +: D))     = (1.0:1.0:1.0, 1.0:1.0:1.0);  
         
         if (!PRE)
          (negedge CLR => (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
         
         if (CLR)
          (posedge PRE => (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE,  0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, posedge CLK &&& PRE_, 0.0, NOTIFY_REG);
      $recovery(negedge PRE, posedge CLK &&& CLR, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFPCA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPCA(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
        UFNRBSX
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and  AN1  (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
         if (CLR && !PRE)
          (negedge CLK => (Q +: D))     = (1.0:1.0:1.0, 1.0:1.0:1.0);  
         
         if (!PRE)
          (negedge CLR => (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
         
         if (CLR)
          (posedge PRE => (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE,  0.0, NOTIFY_REG);


      $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, negedge CLK &&& PRE_, 0.0, NOTIFY_REG);
      $recovery(negedge PRE, negedge CLK &&& CLR, 0.0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL1 (D, G, Q);

    input  D, G;

    output Q;


    reg  NOTIFY_REG ;

    ULP   inst1 (Q, D, G, NOTIFY_REG); 


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G, 0.0, NOTIFY_REG);
    $hold(negedge G, D, 0.0, NOTIFY_REG);

    $width(posedge G, 0.0, 0, NOTIFY_REG); 

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL1A (D, G, QN);

    input  D, G;

    output QN;


    reg  NOTIFY_REG ;

    ULPQ inst2 (QN, D, G, NOTIFY_REG);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G)
    (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G, 0.0, NOTIFY_REG);
    $hold(negedge G, D, 0.0, NOTIFY_REG);

    $width(posedge G, 0.0, 0, NOTIFY_REG); 

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL1B (D, G, Q);

    input  D, G;

    output Q;


    reg  NOTIFY_REG ;

    ULN   inst1 (Q, D, G, NOTIFY_REG); 


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G, 0.0, NOTIFY_REG);
    $hold(posedge G, D, 0.0, NOTIFY_REG);

    $width(negedge G, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL1C (D, G, QN);

    input  D, G;

    output QN;


    reg  NOTIFY_REG ;

    ULNQ inst2 (QN, D, G, NOTIFY_REG);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G)
    (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G, 0.0, NOTIFY_REG);
    $hold(posedge G, D, 0.0, NOTIFY_REG);

    $width(negedge G, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL2A (D, G, PRE, CLR, Q);

   input   D, G, PRE, CLR;

   output   Q;


   reg NOTIFY_REG;

   not              NT1   (CLR_, CLR);
   ULPRSX  inst1 (Q, D, G, CLR_, PRE, NOTIFY_REG);
     
   nor              A1   (ENABLE, CLR_, PRE);


   specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && CLR && !PRE)
        (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    if (CLR && !PRE)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!PRE)
    (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (CLR)
    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G && !PRE)
    (posedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G && CLR)
    (negedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(D, negedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& ENABLE, 0.0, NOTIFY_REG);


    $hold(negedge G, posedge CLR, 0.0, NOTIFY_REG);

    $hold(negedge G, negedge PRE, 0.0, NOTIFY_REG);
 
 
    $width(posedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge CLR, negedge G &&& (~PRE), 0.0, NOTIFY_REG);
    $recovery(negedge PRE, negedge G &&& CLR, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL2B (D, G, PRE, CLR, QN);

   input   D, G, PRE, CLR;

   output   QN;


   reg NOTIFY_REG;

   not                NT1   (PRE_, PRE);
   ULNRSXQ inst1 (QN, D, G, CLR, PRE_, NOTIFY_REG);
     
   nor                A1   (ENABLE, CLR, PRE_);


   specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !CLR && PRE)
        (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    if (!CLR && PRE)
    (negedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && PRE)
    (negedge CLR => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !CLR)
    (posedge PRE => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& ENABLE, 0.0, NOTIFY_REG);


    $hold(posedge G, posedge PRE, 0.0, NOTIFY_REG);

    $hold(posedge G, negedge CLR, 0.0, NOTIFY_REG);
 
 
    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, posedge G &&& PRE, 0.0, NOTIFY_REG);
    $recovery(posedge PRE, posedge G &&& (~CLR), 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL2C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL2C (D, G, PRE, CLR, Q);

   input   D, G, PRE, CLR;

   output   Q;


   reg NOTIFY_REG;

   not                NT1   (CLR_, CLR);
   ULNRSX    inst1 (Q, D, G, CLR_, PRE, NOTIFY_REG);
     
   nor                A1   (ENABLE, CLR_, PRE);


   specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && CLR && !PRE)
        (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    if (CLR && !PRE)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!PRE)
    (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (CLR)
    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !PRE)
    (posedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && CLR)
    (negedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& ENABLE, 0.0, NOTIFY_REG);


    $hold(posedge G, posedge CLR, 0.0, NOTIFY_REG);

    $hold(posedge G, negedge PRE, 0.0, NOTIFY_REG);
 
 
    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge CLR, posedge G &&& (~PRE), 0.0, NOTIFY_REG);
    $recovery(negedge PRE, posedge G &&& CLR, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DL2D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DL2D (D, G, PRE, CLR, QN);

   input  D, G, PRE, CLR;

   output QN;


   reg NOTIFY_REG;

   not                NT1   (PRE_, PRE);
   ULPRSXQ inst1 (QN, D, G, CLR, PRE_, NOTIFY_REG);
     
   nor                A1    (ENABLE, CLR, PRE_);


   specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && !CLR && PRE)
        (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    if (!CLR && PRE)
    (posedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G && PRE)
    (negedge CLR => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G && !CLR)
    (posedge PRE => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(D, negedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& ENABLE, 0.0, NOTIFY_REG);
 

    $hold(negedge G, posedge PRE, 0.0, NOTIFY_REG);

    $hold(negedge G, negedge CLR, 0.0, NOTIFY_REG);


    $width(posedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, negedge G &&& PRE, 0.0, NOTIFY_REG);
    $recovery(posedge PRE, negedge G &&& (~CLR), 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLC (D, G, CLR, Q);

    input  D, G, CLR;

    output Q;


    reg  NOTIFY_REG ;

    ULPRB    inst1 (Q, D, G, CLR, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && CLR)
        (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (CLR)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (posedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& CLR, 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& CLR, 0.0, NOTIFY_REG);


    $hold(negedge G, posedge CLR, 0.0, NOTIFY_REG);


    $width(posedge G &&& CLR, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge CLR, negedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLC1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLC1 (D, G, CLR, Q);

    input  D, G, CLR;

    output Q;


    reg  NOTIFY_REG ;

    ULPR inst1 (Q, D, G, CLR, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && !CLR)
        (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (negedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& (~CLR), 0.0, NOTIFY_REG);


    $hold(negedge G, negedge CLR, 0.0, NOTIFY_REG);


    $width(posedge G &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, negedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLC1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLC1A (D, G, CLR, Q);

    input  D, G, CLR;

    output Q;


    reg  NOTIFY_REG ;

    ULNR inst1 (Q, D, G, CLR, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !CLR)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (negedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& (~CLR), 0.0, NOTIFY_REG);


    $hold(posedge G, negedge CLR, 0.0, NOTIFY_REG);


    $width(negedge G &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, posedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLC1F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLC1F (D, G, CLR, QN);

    input  D, G, CLR;

    output QN;


    reg  NOTIFY_REG ;

    ULPRQ inst1 (QN, D, G, CLR, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && !CLR)
        (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (posedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (negedge CLR => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& (~CLR), 0.0, NOTIFY_REG);


    $hold(negedge G, negedge CLR, 0.0, NOTIFY_REG);


    $width(posedge G &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, negedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLC1G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLC1G (D, G, CLR, QN);

    input  D, G, CLR;

    output QN;


    reg  NOTIFY_REG ;

    ULNRQ inst1 (QN, D, G, CLR, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !CLR)
    (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!CLR)
    (negedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge CLR => (QN +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (negedge CLR => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& (~CLR), 0.0, NOTIFY_REG);


    $hold(posedge G, negedge CLR, 0.0, NOTIFY_REG);


    $width(negedge G &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, posedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLCA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLCA (D, G, CLR, Q);

    input  D, G, CLR;

    output Q;


    reg  NOTIFY_REG ;

    ULNRB   inst1 (Q, D, G, CLR, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && CLR)
        (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (CLR)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (posedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& CLR, 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& CLR, 0.0, NOTIFY_REG);


    $hold(posedge G, posedge CLR, 0.0, NOTIFY_REG);
 
 
    $width(negedge G &&& CLR, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge CLR, posedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE (D, E, G, Q);

    input  D, E, G;

    output Q;


    reg  NOTIFY_REG ;

    U_DLE inst1 (Q, D, G, E, NOTIFY_REG);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && E)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (E)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (posedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& E, 0.0, NOTIFY_REG);
    $hold(negedge G &&& E, D, 0.0, NOTIFY_REG);

    $setup(posedge E, negedge G, 0.0, NOTIFY_REG);
    $hold(negedge G, negedge E, 0.0, NOTIFY_REG);

    $width(posedge G &&& E, 0.0, 0, NOTIFY_REG); 
    $width(posedge E, 0.0, 0, NOTIFY_REG); 


    $setup(D, negedge E &&& G, 0.0, NOTIFY_REG);
    $hold(negedge E &&& G , D, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE1D (D, E, G, QN);

    input  D, G, E;

    output QN;


    reg  NOTIFY_REG ;

    U_DLE1D  inst1 (QN, D, G, E, NOTIFY_REG);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !E)
    (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!E)
    (negedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (negedge E => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& (~E), 0.0, NOTIFY_REG);
    $hold(posedge G &&& (~E), D, 0.0, NOTIFY_REG);

    $width(negedge G &&& (~E), 0.0, 0, NOTIFY_REG); 
    $width(negedge E, 0.0, 0, NOTIFY_REG); 


    $setup(D, posedge E &&& (~G), 0.0, NOTIFY_REG);
    $hold(posedge E &&& (~G) , D, 0.0, NOTIFY_REG);


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE2A (D, E, G, CLR, Q);

    input  D, G, E, CLR;

    output Q;


    reg  NOTIFY_REG;

    U_DLE2A     inst1 (Q, D, G, E, CLR, NOTIFY_REG);

    not         NT2   (CLR_, CLR);
    and         AN2   (ENABLE, CLR, E);

 
    not         NT3   (G_, G);
    and         AN3   (ENABLE_CLR_G_, CLR, G_);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && E && !CLR)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (E && !CLR)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !CLR)
    (posedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && E)
    (negedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G &&& ENABLE, D, 0.0, NOTIFY_REG);

    $setup(D, negedge E &&& ENABLE_CLR_G_ , 0.0, NOTIFY_REG);
    $hold(negedge E &&& ENABLE_CLR_G_ , D, 0.0, NOTIFY_REG);

    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 
    $width(posedge E &&& CLR_, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery (negedge CLR, posedge G &&& E, 0.0, NOTIFY_REG); 
    $hold(posedge G &&& E, negedge CLR, 0.0, NOTIFY_REG);

    $recovery (negedge CLR, negedge E &&& G_, 0.0, NOTIFY_REG);
    $hold(negedge E &&& G_, negedge CLR, 0.0, NOTIFY_REG);



    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE2B (D, E, G, CLR, Q);

    input  D, G, E, CLR;

    output Q;


    reg  NOTIFY_REG;

    U_DLE2B inst1 (Q, D, G, E, CLR, NOTIFY_REG); 

    not         NT1   (E_, E);
    and         AN1   (ENABLE, CLR, E_);


    not         NT3   (G_, G);
    and         AN3   (ENABLE_CLR_G_, CLR, G_);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !E && CLR)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!E && CLR)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && CLR)
    (negedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !E)
    (posedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G &&& ENABLE, D, 0.0, NOTIFY_REG);

    $setup(D, posedge E &&& ENABLE_CLR_G_ , 0.0, NOTIFY_REG);
    $hold(posedge E &&& ENABLE_CLR_G_ , D, 0.0, NOTIFY_REG);


    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 
    $width(negedge E &&& CLR, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery (posedge CLR, posedge G &&& E_, 0.0, NOTIFY_REG); 
    $hold(posedge G &&& E_, posedge CLR, 0.0, NOTIFY_REG);

    $recovery (posedge CLR, posedge E &&& G_, 0.0, NOTIFY_REG); 
    $hold(posedge E &&& G_, posedge CLR, 0.0, NOTIFY_REG);



    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE2C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE2C (D, E, G, CLR, Q);

    input  D, G, E, CLR;

    output Q;


    reg  NOTIFY_REG;

    U_DLE2C inst1 (Q, D, G, E, CLR, NOTIFY_REG); 

    and  AN1 (ENABLE, CLR, E_);

    not         NT5   (E_, E);
    not         NT4   (CLR_, CLR);
    not         NT3   (G_, G);
    and         AN3   (ENABLE_CLR_G_, CLR, G_);



    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






    if (!G && !E && !CLR)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!E && !CLR)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !CLR)
    (negedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !E)
    (negedge CLR => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G &&& ENABLE, D, 0.0, NOTIFY_REG);
 
    $setup(D, posedge E &&& ENABLE_CLR_G_ , 0.0, NOTIFY_REG);
    $hold(posedge E &&& ENABLE_CLR_G_ , D, 0.0, NOTIFY_REG);
 
 
    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG);
    $width(negedge E &&& CLR, 0.0, 0, NOTIFY_REG);
    $width(posedge CLR, 0.0, 0, NOTIFY_REG);
 
    $recovery (negedge CLR, posedge G &&& E_, 0.0, NOTIFY_REG);
    $hold(posedge G &&& E_, negedge CLR, 0.0, NOTIFY_REG);
 
    $recovery (negedge CLR, posedge E &&& G_, 0.0, NOTIFY_REG);
    $hold(posedge E &&& G_, negedge CLR, 0.0, NOTIFY_REG);
 
 
    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE3A (D, E, G, PRE, Q);

    input  D, G, E, PRE;

    output Q;


    reg  NOTIFY_REG;

    U_DLE3A inst1 (Q, D, G, E, PRE, NOTIFY_REG); 

    not          NT2   (PRE_, PRE);
    and          AN2   (ENABLE, PRE, E);


    not         NT3   (G_, G);
    and         AN3   (ENABLE_PRE_G_, PRE, G_);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && E && !PRE)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (E && !PRE)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !PRE)
    (posedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && E)
    (negedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G &&& ENABLE, D, 0.0, NOTIFY_REG);

    $setup(D, negedge E &&& ENABLE_PRE_G_ , 0.0, NOTIFY_REG);
    $hold(negedge E &&& ENABLE_PRE_G_ , D, 0.0, NOTIFY_REG);



    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 
    $width(posedge E &&& PRE_, 0.0, 0, NOTIFY_REG); 
    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery (negedge PRE, posedge G &&& E, 0.0, NOTIFY_REG); 
    $hold(posedge G &&& E, negedge PRE, 0.0, NOTIFY_REG);

    $recovery (negedge PRE, negedge E &&& G_, 0.0, NOTIFY_REG); 
    $hold(negedge E &&& G_, negedge PRE, 0.0, NOTIFY_REG);


    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE3B (D, E, G, PRE, Q);

    input  D, G, E, PRE;

    output Q;


    reg  NOTIFY_REG;

    U_DLE3B inst1 (Q, D, G, E, PRE, NOTIFY_REG); 

    and         AN1   (ENABLE, PRE, E_);

    not         NT4   (PRE_, PRE);
    not         NT3   (G_, G);
    not         NT2   (E_, E);
    and         AN3   (ENABLE_PRE_G_, PRE, G_);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !E && !PRE)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!E && !PRE)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !PRE)
    (negedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !E)
    (negedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G &&& ENABLE, D, 0.0, NOTIFY_REG);

    $setup(D, posedge E &&& ENABLE_PRE_G_ , 0.0, NOTIFY_REG);
    $hold(posedge E &&& ENABLE_PRE_G_ , D, 0.0, NOTIFY_REG);
 
    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 
    $width(negedge E &&& (~PRE), 0.0, 0, NOTIFY_REG); 
    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery (negedge PRE, posedge G &&& (~E), 0.0, NOTIFY_REG); 
    $hold(posedge G &&& (~E), negedge PRE, 0.0, NOTIFY_REG); 


    $recovery (negedge PRE, posedge E &&& (~G), 0.0, NOTIFY_REG); 
    $hold(posedge E &&& (~G), negedge PRE, 0.0, NOTIFY_REG); 


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLE3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLE3C (D, E, G, PRE, Q);

    input  D, G, E, PRE;

    output Q;


    reg  NOTIFY_REG;

    U_DLE3C inst1 (Q, D, G, E, PRE, NOTIFY_REG); 

    not          NT1   (E_, E);
    and          AN1   (ENABLE, PRE, E_);


    not         NT3   (G_, G);
    and         AN3   (ENABLE_PRE_G_, PRE, G_);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !E && PRE)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!E && PRE)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && PRE)
    (negedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G && !E)
    (posedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& ENABLE, 0.0, NOTIFY_REG);
    $hold(posedge G &&& ENABLE, D, 0.0, NOTIFY_REG);

    $setup(D, posedge E &&& ENABLE_PRE_G_ , 0.0, NOTIFY_REG);
    $hold(posedge E &&& ENABLE_PRE_G_ , D, 0.0, NOTIFY_REG);
 
    $width(negedge G &&& ENABLE, 0.0, 0, NOTIFY_REG); 
    $width(negedge E &&& PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery (posedge PRE, posedge G &&& E_, 0.0, NOTIFY_REG); 
    $hold(posedge G &&& E_, posedge PRE, 0.0, NOTIFY_REG); 

    $recovery (posedge PRE, posedge E &&& G_, 0.0, NOTIFY_REG); 
    $hold(posedge E &&& G_, posedge PRE, 0.0, NOTIFY_REG); 


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLEA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLEA (D, E, G, Q);

    input  D, E, G;

    output Q;


    reg  NOTIFY_REG ;

    U_DLEA inst1 (Q, D, G, E, NOTIFY_REG); 

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && !E)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!E)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (negedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& (~E), 0.0, NOTIFY_REG);
    $hold(negedge G &&& (~E), D, 0.0, NOTIFY_REG);

    $width(posedge G &&& (~E), 0.0, 0, NOTIFY_REG); 
    $width(negedge E, 0.0, 0, NOTIFY_REG); 


    $setup(D, posedge E &&& G, 0.0, NOTIFY_REG);
    $hold(posedge E &&& G , D, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLEB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLEB (D, E, G, Q);

    input  D, E, G;

    output Q;


    reg  NOTIFY_REG ;

    U_DLEA inst1 (Q, D, E, G, NOTIFY_REG); 

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && E)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (E)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (posedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& E, 0.0, NOTIFY_REG);
    $hold(posedge G &&& E, D, 0.0, NOTIFY_REG);

    $width(negedge G &&& E, 0.0, 0, NOTIFY_REG); 
    $width(posedge E, 0.0, 0, NOTIFY_REG); 


    $setup(D, negedge E &&& (~G), 0.0, NOTIFY_REG);
    $hold(negedge E &&& (~G) , D, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLEC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLEC (D, E, G, Q);

    input  D, E, G;

    output Q;


    reg  NOTIFY_REG ;

    U_DLEC inst1 (Q, D, G, E, NOTIFY_REG); 


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !E)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!E)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (negedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& (~E), 0.0, NOTIFY_REG);
    $hold(posedge G &&& (~E), D, 0.0, NOTIFY_REG);

    $width(negedge G &&& (~E), 0.0, 0, NOTIFY_REG); 
    $width(negedge E, 0.0, 0, NOTIFY_REG); 


    $setup(D, posedge E &&& (~G), 0.0, NOTIFY_REG);
    $hold(posedge E &&& (~G) , D, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM (A, B, S, G, Q); 

    input A, B, S, G;

    output Q;

    reg NOTIFY_REG;

    U_MUX_2 inst1 (D_EFF, A, B, S);
    ULP inst2 (Q, D_EFF, G, NOTIFY_REG);

    xor       XR1   (EN, A, B);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";



        if (!S && G) 
        (A +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (S && G) 
        (B +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge G => (Q  +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (G && (A ^ B)) 
        (S => Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);


        $setup(A, negedge G &&& (~S), 0.0, NOTIFY_REG);
        $hold(negedge G &&& (~S), A, 0.0, NOTIFY_REG);

        $setup(B, negedge G &&& S, 0.0, NOTIFY_REG);
        $hold(negedge G &&& S, B, 0.0, NOTIFY_REG);

        $setup(S, negedge G &&& EN, 0.0, NOTIFY_REG);
        $hold(negedge G, S &&& EN, 0.0, NOTIFY_REG);

        $width (posedge G, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM2A (A, B, S, G, CLR, Q); 

    input A, B, S, G, CLR;

    output Q;

    reg NOTIFY_REG;

    U_MUX_2    inst1 (D_EFF, A, B, S);
    ULNRB inst2 (Q, D_EFF, G, CLR_, NOTIFY_REG);
 
    not          NT1   (CLR_, CLR);
    xor          XR1   (EN, A, B);
    nor          NR1   (EN1, CLR, S);
    and          AN1   (EN2, CLR_, S);
    and          AN2   (EN3, CLR_, EN);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";



        if (!S && !G && !CLR) 
        (A +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (S && !G && !CLR) 
        (B +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!CLR)
        (negedge G => (Q +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!G && !CLR && (A ^ B)) 
        (S => Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!G)
        (negedge CLR => (Q +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);



        $setup(A, posedge G &&& EN1, 0.0, NOTIFY_REG);
        $hold(posedge G &&& EN1, A, 0.0, NOTIFY_REG);

 
        $hold(posedge G, negedge CLR, 0.0, NOTIFY_REG); 
 
 
        $setup(B, posedge G &&& EN2, 0.0, NOTIFY_REG);
        $hold(posedge G &&& EN2, B, 0.0, NOTIFY_REG);

        $setup(S, posedge G &&& EN3, 0.0, NOTIFY_REG);
        $hold(posedge G, S &&& EN3, 0.0, NOTIFY_REG);

        $width (negedge G &&& CLR_, 0.0, 0, NOTIFY_REG);
        $width (posedge CLR, 0.0, 0, NOTIFY_REG);

        $recovery (negedge CLR, posedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLMA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLMA (A, B, S, G, Q); 

    input A, B, S, G;

    output Q;

    reg NOTIFY_REG;

    U_MUX_2 inst1 (D_EFF, A, B, S);
    ULN inst2 (Q, D_EFF, G, NOTIFY_REG);
 
    xor       XR1   (EN, A, B);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";



        if (!S && !G) 
        (A +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (S && !G) 
        (B +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (negedge G => (Q  +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!G && (A ^ B)) 
        (S => Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);


        $setup(A, posedge G &&& (~S), 0.0, NOTIFY_REG);
        $hold(posedge G &&& (~S), A, 0.0, NOTIFY_REG);

        $setup(B, posedge G &&& S, 0.0, NOTIFY_REG);
        $hold(posedge G &&& S, B, 0.0, NOTIFY_REG);

        $setup(S, posedge G &&& EN, 0.0, NOTIFY_REG);
        $hold(posedge G, S &&& EN, 0.0, NOTIFY_REG);

        $width (negedge G, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLME1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLME1A (A, B, S, E, G, Q); 

    input A, B, S, E, G;

    output Q;

    reg NOTIFY_REG;

    or        OR1   (G_EFF, G, E);
    U_MUX_2 inst1 (D_EFF, A, B, S);
    ULN inst2 (Q, D_EFF, G_EFF, NOTIFY_REG);

    nor       NR1   (EN1, S, E);
    not       NT1   (E_, E);
    and       AN1   (EN2, S, E_);
    xor       XR1   (AB_XOR, A, B);
    and       AN2   (EN3, AB_XOR, E_);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";



        if (!S && !G && !E) 
        (A +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (S && !G && !E) 
        (B +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!E)
        (negedge G => (Q +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!G)
        (negedge E => (Q +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!G && !E && (A ^ B)) 
        (S => Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);


        $setup(A, posedge G &&& EN1, 0.0, NOTIFY_REG);
        $hold(posedge G &&& EN1, A, 0.0, NOTIFY_REG);

        $setup(B, posedge G &&& EN2, 0.0, NOTIFY_REG);
        $hold(posedge G &&& EN2, B, 0.0, NOTIFY_REG);

        $setup(S, posedge G &&& EN3, 0.0, NOTIFY_REG);
        $hold(posedge G, S &&& EN3, 0.0, NOTIFY_REG);

        $setup(A, posedge E &&& EN1, 0.0, NOTIFY_REG);
        $hold(posedge E &&& EN1, A, 0.0, NOTIFY_REG);

        $setup(B, posedge E &&& EN2, 0.0, NOTIFY_REG);
        $hold(posedge E &&& EN2, B, 0.0, NOTIFY_REG);

        $setup(S, posedge E &&& EN3, 0.0, NOTIFY_REG);
        $hold(posedge E, S &&& EN3, 0.0, NOTIFY_REG);
 
        $width (negedge G &&& E_, 0.0, 0, NOTIFY_REG);
        $width (negedge E, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLP1 (D, G, PRE, Q);

    input  D, G, PRE;

    output Q;


    reg  NOTIFY_REG ;

    ULPS inst1 (Q, D, G, PRE, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && !PRE)
        (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!PRE)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (negedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& (~PRE), 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& (~PRE), 0.0, NOTIFY_REG);


    $hold(negedge G, negedge PRE, 0.0, NOTIFY_REG);


    $width(posedge G &&& (~PRE), 0.0, 0, NOTIFY_REG); 
    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge PRE, negedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLP1A (D, G, PRE, Q);

    input  D, G, PRE;

    output Q;


    reg  NOTIFY_REG ;

    ULNS inst1 (Q, D, G, PRE, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && !PRE)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!PRE)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (negedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& (~PRE), 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& (~PRE), 0.0, NOTIFY_REG);


    $hold(posedge G, negedge PRE, 0.0, NOTIFY_REG);


    $width(negedge G &&& (~PRE), 0.0, 0, NOTIFY_REG); 
    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge PRE, posedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLP1B (D, G, PRE, Q);

    input  D, G, PRE;

    output Q;

    reg  NOTIFY_REG ;

    ULPSB   inst1 (Q, D, G, PRE, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && PRE)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (posedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& PRE, 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& PRE, 0.0, NOTIFY_REG);


    $hold(negedge G, posedge PRE, 0.0, NOTIFY_REG);


    $width(posedge G &&& PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge PRE, negedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLP1C (D, G, PRE, Q);

    input  D, G, PRE;

    output Q;


    reg  NOTIFY_REG ;

    ULNSB   inst1 (Q, D, G, PRE, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && PRE)
        (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (negedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (posedge PRE => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& PRE, 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& PRE, 0.0, NOTIFY_REG);


    $hold(posedge G, posedge PRE, 0.0, NOTIFY_REG);


    $width(negedge G &&& PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge PRE, posedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLP1D (D, G, PRE, QN);

    input  D, G, PRE;

    output QN;


    reg  NOTIFY_REG ;

    ULPSBQ inst1 (QN, D, G, PRE, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (G && PRE)
        (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (posedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (posedge PRE => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& PRE, 0.0, NOTIFY_REG);
    $hold(negedge G, D &&& PRE, 0.0, NOTIFY_REG);


    $hold(negedge G, posedge PRE, 0.0, NOTIFY_REG);


    $width(posedge G &&& PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge PRE, negedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLP1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLP1E (D, G, PRE, QN);

    input  D, G, PRE;

    output QN;


    reg  NOTIFY_REG ;

    ULNSBQ inst1 (QN, D, G, PRE, NOTIFY_REG);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "latch";




    if (!G && PRE)
    (D -=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (PRE)
    (negedge G => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (negedge PRE => (QN +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (!G)
    (posedge PRE => (QN -: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, posedge G &&& PRE, 0.0, NOTIFY_REG);
    $hold(posedge G, D &&& PRE, 0.0, NOTIFY_REG);


    $hold(posedge G, posedge PRE, 0.0, NOTIFY_REG);


    $width(negedge G &&& PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge PRE, posedge G, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  FA1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module FA1(A, B, CI, CO, S);
    
    input A, B, CI;
    output CO, S;
    

    xor    XNR1    (S, A, B, CI);
    and   inst1   (T1, A, B); 
    and   inst2   (T2, A, CI); 
    and   inst3   (T3, B, CI); 
    or    inst4   (CO, T1, T2, T3); 
       

    specify

         specparam   LibName     = "act1";

        (A  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (A  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  FA1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module FA1A(A, B, CI, CO, S);
    
    input A, B, CI;
    output CO, S;
    

    not     NT4    (B_INT, B);
    xnor    XNR1    (S, A, B_INT, CI);
    U_MAJ_3 inst1  (CO, A, B_INT, CI); 
       

    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName        = "CO";
         specparam   ExtraDelayPaths$A$CO   = 0;
         specparam   ExtraDelayPaths$B$CO   = 0;
         specparam   ExtraDelayPaths$CI$CO  = 0;
         specparam   ExtraDelayPaths$A$S    = 1;
         specparam   ExtraDelayPaths$B$S    = 1;
         specparam   ExtraDelayPaths$CI$S   = 1;

         specparam   InputLoad$A = 3; 
         specparam   InputLoad$B = 3; 
         specparam   InputLoad$CI = 3; 
         specparam   OutputLoad$CO = 2; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";




        (A  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  FA1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module FA1B(A, B, CI, CO, S);
    
    input A, B, CI;
    output CO, S;
    

    not     NT3    (A_INT, A);
    not     NT4    (B_INT, B);
    xnor    XNR1   (S, A_INT, B_INT, CI);
    U_MAJ_3 inst1  (CO, A_INT, B_INT, CI); 
       

    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName        = "CO";
         specparam   ExtraDelayPaths$A$CO   = 0;
         specparam   ExtraDelayPaths$B$CO   = 0;
         specparam   ExtraDelayPaths$CI$CO  = 0;
         specparam   ExtraDelayPaths$A$S    = 1;
         specparam   ExtraDelayPaths$B$S    = 1;
         specparam   ExtraDelayPaths$CI$S   = 1;

         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 3; 
         specparam   InputLoad$CI = 3; 
         specparam   OutputLoad$CO = 2; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";




        (A  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  FA2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module FA2A(A0, A1, B, CI, CO, S);
    
    input A0, A1, B, CI;
    output CO, S;
    

   
    or      OR1    (A_INT, A0, A1);
    not     NT3    (B_INT, B);
    xnor    XNR1   (S, A_INT, B_INT, CI);
    U_MAJ_3 inst1  (CO, A_INT, B_INT, CI); 
       

    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName        = "CO";
         specparam   ExtraDelayPaths$A0$CO  = 0;
         specparam   ExtraDelayPaths$A1$CO  = 0;
         specparam   ExtraDelayPaths$B$CO   = 0;
         specparam   ExtraDelayPaths$CI$CO  = 0;
         specparam   ExtraDelayPaths$A0$S   = 1;
         specparam   ExtraDelayPaths$A1$S   = 1;
         specparam   ExtraDelayPaths$B$S    = 1;
         specparam   ExtraDelayPaths$CI$S   = 1;

         specparam   InputLoad$A0 = 2; 
         specparam   InputLoad$A1 = 2; 
         specparam   InputLoad$B = 3; 
         specparam   InputLoad$CI = 3; 
         specparam   OutputLoad$CO = 2; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";




        (A0 => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A1 => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A0 => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A1 => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (CI => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  GAND2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module GAND2(A, G, Y);
    
    input A, G;
    output Y;
    
    and AN1   (Y, A, G);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  GMX4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module GMX4(D0, D1, D2, D3, G, S0, Y);
    
    input D0, D1, D2, D3, G, S0;
    output Y;
    
    U_MUX_4  inst1   (Y, D0, D1, D2, D3, S0, G);   
     
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





        (D0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D2 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D3 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  GNAND2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module GNAND2(A, G, Y);
    
    input A, G;
    output Y;
    
    nand ND1   (Y, A, G);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  GND.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module GND(Y);
    
    output Y;
    supply0 Y;
               
    specify

         specparam   LibName     = "act1";
         specparam   OutputLoad$Y = 0;

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  GNOR2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module GNOR2(A, G, Y);
    
    input A, G;
    output Y;
    
    nor NR1   (Y, A, G);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  GOR2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module GOR2(A, G, Y);
    
    input A, G;
    output Y;
    
    or OR1   (Y, A, G);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  GXOR2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module GXOR2(A, G, Y);
    
    input A, G;
    output Y;
    
    xor XR1   (Y, A, G);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  HA1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module HA1(A, B, CO, S);
    
    input A, B;
    output CO, S;
    
 
    xor    XNR1    (S, A, B);
    and    AN1     (CO, A, B);
    

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   OutputLoad$CO = 0; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";




        (A  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  HA1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module HA1A(A, B, CO, S);
    
    input A, B;
    output CO, S;
    
    not    NT1     (A_INT, A);


    xor    XNR1    (S, A_INT, B);
    and    AN1     (CO, A_INT, B);
    

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   OutputLoad$CO = 0; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";




        (A  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  HA1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module HA1B(A, B, CO, S);
    
    input A, B;
    output CO, S;
    

    xnor    XNR1    (S, A, B);
    nand    ND1     (CO, A, B);
    

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   OutputLoad$CO = 0; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";




        (A  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  HA1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module HA1C(A, B, CO, S);
    
    input A, B;
    output CO, S;
    
   
    xor    XNR1    (S, A, B);
    nand   ND1     (CO, A, B);
    
    specify

         specparam   LibName     = "act1";

         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   OutputLoad$CO = 0; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";




        (A  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => CO) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B  => S)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  INBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module INBUF(PAD, Y);
    
    input PAD;
    output Y;
    
    buf  BF1  (Y, PAD);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$Y = 0;
         specparam   MacroType = "io";




        (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  INV.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module INV(A, Y);
    
    input A;
    output Y;
    
    not  NT1  (Y, A);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  INVA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module INVA(A, Y);
    
    input A;
    output Y;
    
    not  NT1  (Y, A);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  INVD.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module INVD(A, Y);
    
    input A;
    output Y;
    
    not  NT1  (Y, A);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF (J, K, CLK, Q);

    input   J, K, CLK;

    output  Q;

        reg  NOTIFY_REG ;

        UFJKBP inst1 (Q, J, K, CLK, NOTIFY_REG);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";




        if (J == K)
        (posedge CLK => (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (J && !K)
        (posedge CLK => (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, J, 0.0, NOTIFY_REG);

    $setup(K, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, K, 0.0, NOTIFY_REG);

    $width(posedge CLK, 0.0, 0, NOTIFY_REG);
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF1B (J, K, CLK, Q);

    input   J, K, CLK;

    output  Q;

        reg  NOTIFY_REG ;

        UFJKBN inst1 (Q, J, K, CLK, NOTIFY_REG);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";




        if (J == K)
        (negedge CLK => (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (J && !K)
        (negedge CLK => (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, negedge CLK, 0.0, NOTIFY_REG);
    $hold(negedge CLK, J, 0.0, NOTIFY_REG);

    $setup(K, negedge CLK, 0.0, NOTIFY_REG);
    $hold(negedge CLK, K, 0.0, NOTIFY_REG);

    $width(negedge CLK, 0.0, 0, NOTIFY_REG);
    $width(posedge CLK, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF2A (J, K, CLK, CLR, Q);

    input   J, K, CLK, CLR;

    output   Q;


        reg  NOTIFY_REG;
        
        UFJKBPRB inst1 (Q, J, K, CLK, CLR, NOTIFY_REG);   


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";




        if (CLR && (J == K))
        (posedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (CLR && J && !K)
        (posedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (negedge CLR =>  (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
    $hold(posedge CLK, J &&& CLR, 0.0, NOTIFY_REG);

    $setup(K, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
    $hold(posedge CLK, K &&& CLR, 0.0, NOTIFY_REG);


    $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);
 
 
    $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG); 

    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF2B (J, K, CLK, CLR, Q);

    input   J, K, CLK, CLR;

    output   Q;


        reg  NOTIFY_REG;
        
        UFJKBNRB inst1 (Q, J, K, CLK, CLR, NOTIFY_REG);   


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";




        if (CLR && (J == K))
        (negedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (CLR && J && !K)
        (negedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (negedge CLR =>  (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
    $hold(negedge CLK, J &&& CLR, 0.0, NOTIFY_REG);

    $setup(K, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
    $hold(negedge CLK, K &&& CLR, 0.0, NOTIFY_REG);


    $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);


    $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG); 

    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF2C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF2C (J, K, CLK, CLR, Q);

    input   J, K, CLK, CLR;

    output   Q;


        reg  NOTIFY_REG;
        
        UFJKBPR inst1 (Q, J, K, CLK, CLR, NOTIFY_REG);   


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";




        if (!CLR && (J == K))
        (posedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!CLR && J && !K)
        (posedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge CLR =>  (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge CLK, J &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(K, posedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(posedge CLK, K &&& (~CLR), 0.0, NOTIFY_REG);


    $hold(posedge CLK, negedge CLR, 0.0, NOTIFY_REG);


    $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 

    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF2D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF2D (J, K, CLK, CLR, Q);

    input  J, K, CLK, CLR;

    output Q;

        reg  NOTIFY_REG;
        
        UFJKBNR inst1 (Q, J, K, CLK, CLR, NOTIFY_REG);   


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";




        if (!CLR && (J == K))
        (negedge CLK => (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!CLR && J && !K)
        (negedge CLK => (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge CLK, J &&& (~CLR), 0.0, NOTIFY_REG);

    $setup(K, negedge CLK &&& (~CLR), 0.0, NOTIFY_REG);
    $hold(negedge CLK, K &&& (~CLR), 0.0, NOTIFY_REG);


    $hold(negedge CLK, negedge CLR, 0.0, NOTIFY_REG);


    $width(negedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLK &&& (~CLR), 0.0, 0, NOTIFY_REG); 

    $width(posedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF3A (J, K, CLK, PRE, Q);

    input   J, K, CLK, PRE;

    output   Q;


        reg  NOTIFY_REG;
        
        UFJKBPSB inst1 (Q, J, K, CLK, PRE, NOTIFY_REG);   


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";




        if (PRE && (J == K))
        (posedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (PRE && J && !K)
        (posedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (negedge PRE =>  (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, posedge CLK &&& PRE, 0.0, NOTIFY_REG);
    $hold(posedge CLK, J &&& PRE, 0.0, NOTIFY_REG);

    $setup(K, posedge CLK &&& PRE, 0.0, NOTIFY_REG);
    $hold(posedge CLK, K &&& PRE, 0.0, NOTIFY_REG);


    $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);


    $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG); 

    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF3B (J, K, CLK, PRE, Q);

    input   J, K, CLK, PRE;

    output   Q;


        reg  NOTIFY_REG;
        
        UFJKBNSB inst1 (Q, J, K, CLK, PRE, NOTIFY_REG);   


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";




        if (PRE && (J == K))
        (negedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (PRE && J && !K)
        (negedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (negedge PRE =>  (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
    $hold(negedge CLK, J &&& PRE, 0.0, NOTIFY_REG);

    $setup(K, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
    $hold(negedge CLK, K &&& PRE, 0.0, NOTIFY_REG);


    $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);


    $width(negedge CLK &&& PRE, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLK &&& PRE, 0.0, 0, NOTIFY_REG); 

    $width(negedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF3C (J, K, CLK, PRE, Q);

    input   J, K, CLK, PRE;

    output   Q;


        reg  NOTIFY_REG;
        
        UFJKBPS inst1 (Q, J, K, CLK, PRE, NOTIFY_REG);   

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";




        if (!PRE && (J == K))
        (posedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!PRE && J && !K)
        (posedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge PRE =>  (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
    $hold(posedge CLK, J &&& (~PRE), 0.0, NOTIFY_REG);

    $setup(K, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
    $hold(posedge CLK, K &&& (~PRE), 0.0, NOTIFY_REG);


    $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);


    $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG); 

    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge PRE, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF3D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF3D (J, K, CLK, PRE, Q);

    input  J, K, CLK, PRE;

    output Q;

        reg  NOTIFY_REG;
        
        UFJKBNS inst1 (Q, J, K, CLK, PRE, NOTIFY_REG);   


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";




        if (!PRE && (J == K))
        (negedge CLK => (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!PRE && J && !K)
        (negedge CLK => (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
    $hold(negedge CLK, J &&& (~PRE), 0.0, NOTIFY_REG);

    $setup(K, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
    $hold(negedge CLK, K &&& (~PRE), 0.0, NOTIFY_REG);

 
    $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG); 
 
 
    $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG); 
    $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG); 

    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKF4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKF4B (J, K, CLK, PRE, CLR, Q);

    input   J, K, CLK, PRE, CLR;

    output   Q;


        reg  NOTIFY_REG ;
        
        not                 NT1   (PRE_, PRE);
        UFJKBNX inst1 (Q, J, K, CLK, CLR, PRE_, NOTIFY_REG);   

        and                 A1    (ENABLE, CLR, PRE_);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";




        if (!PRE && CLR && (J == K))
        (negedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!PRE && CLR && J && !K)
        (negedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!PRE) 
        (negedge CLR =>  (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (CLR)
        (posedge PRE =>  (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



    $setup(J, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG); 
    $hold(negedge CLK, J &&& ENABLE, 0.0, NOTIFY_REG); 

    $setup(K, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG); 
    $hold(negedge CLK, K &&& ENABLE, 0.0, NOTIFY_REG); 
 

    $hold(negedge CLK, negedge PRE, 0.0, NOTIFY_REG);
 
    $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);
 

    $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG); 
    $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge PRE, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
    $recovery(posedge CLR, negedge CLK &&& PRE_, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  JKFPC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module JKFPC (J, K, CLK, PRE, CLR, Q);

    input   J, K, PRE, CLR, CLK;

    output   Q;


        reg  NOTIFY_REG ;
        
        not                 NT1   (PRE_, PRE);
        UFJKBPX inst1 (Q, J, K, CLK, CLR, PRE_, NOTIFY_REG);   

        and                 A1    (ENABLE, CLR, PRE_);


    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";




        if (!PRE && CLR && (J == K))
        (posedge CLK =>  (Q +: J)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (!PRE && CLR && J && !K)
        (posedge CLK =>  (Q +: ~Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!PRE)
        (negedge CLR =>  (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (CLR)
        (posedge PRE =>  (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(J, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG); 
    $hold(posedge CLK, J &&& ENABLE, 0.0, NOTIFY_REG); 

    $setup(K, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG); 
    $hold(posedge CLK, K &&& ENABLE, 0.0, NOTIFY_REG); 


    $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG); 

    $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG); 

 
    $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG); 

    $width(posedge PRE, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLR, 0.0, 0, NOTIFY_REG); 

    $recovery(negedge PRE, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
    $recovery(posedge CLR, posedge CLK &&& PRE_, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MAJ3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MAJ3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_MAJ_3  inst1  (Y, A, B, C);
          
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MX2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MX2(A, B, S, Y);
    
    input A, B, S;
    output Y;

   
    U_MUX_2  inst1   (Y, A, B, S);
       
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MX2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MX2A(A, B, S, Y);
    
    input A, B, S;
    output Y;
    
    not        NT1     (A_INT, A);

   
    U_MUX_2  inst1   (Y, A_INT, B, S);   
     

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MX2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MX2B(A, B, S, Y);
    
    input A, B, S;
    output Y;
    
    not        NT1     (B_INT, B);

   
    U_MUX_2  inst1   (Y, A, B_INT, S);   
     

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MX2C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MX2C(A, B, S, Y);
    
    input A, B, S;
    output Y;
    

    U_MUX_2  inst1   (Y_INT_, A, B, S);   
     

    not      NT1     (Y, Y_INT_);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MX4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MX4(D0, D1, D2, D3, S0, S1, Y);
    
    input D0, D1, D2, D3, S1, S0;
    output Y;
    

    U_MUX_4  inst1   (Y, D0, D1, D2, D3, S0, S1);   
     

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (D0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D2 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D3 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MXC1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MXC1(A, B, C, D, S, Y);
    
    input S, A, B, C, D;
    output Y;


    U_MUX_2  inst1   (SL, A, B, S);   
    U_MUX_2  inst2   (Y, C, D, SL);   
      
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$S = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  MXT.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MXT(D0, D1, D2, D3, S0A, S0B, S1, Y);
    
    input D0, D1, D2, D3, S0A, S0B, S1;
    output Y;
    

    U_MUX_2  inst1   (Y_INT1, D0, D1, S0A);   
    U_MUX_2  inst2   (Y_INT2, D2, D3, S0B);   
    U_MUX_2  inst3   (Y, Y_INT1, Y_INT2, S1);   

     
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0A = 1; 
         specparam   InputLoad$S0B = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (D0 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D1 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D2 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D3 => Y)   = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S0A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S0B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S1 => Y)  = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND2(A, B, Y);
    
    input A, B;
    output Y;
    
    nand ND1   (Y, A, B);
    
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
//-                    cell  NAND2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND2A(A, B, Y);
    
    input A, B;
    output Y;
    
    not NT1   (A_INT_, A);
    nand ND1  (Y, A_INT_, B);
    
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
//-                    cell  NAND2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND2B(A, B, Y);
    
    input A, B;
    output Y;
    
    or OR1   (Y, A, B);
        
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
//-                    cell  NAND3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    nand ND1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 0;
         specparam   ExtraDelayPaths$C$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND3A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not  NT1   (A_INT, A);
    nand ND1   (Y, A_INT, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND3B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not NT1   (C_INT, C);
    or  OR1   (Y, A, B, C_INT);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND3C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    or OR1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND4(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    nand ND1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND4A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (A_INT_, A);
    nand ND1  (Y, A_INT_, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND4B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AND4_B inst1  (Y_INT_, A, B, C, D);   
    not      NT1    (Y, Y_INT_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND4C(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (D_INT_, D);
    or OR1    (Y, A, B, C, D_INT_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NAND4D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND4D(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    or OR1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR2(A, B, Y);
    
    input A, B;
    output Y;
    
    nor NR1   (Y, A, B);
    
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
//-                    cell  NOR2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR2A(A, B, Y);
    
    input A, B;
    output Y;
    
    not NT1   (A_INT_, A);
    nor NR1   (Y, A_INT_, B);
    
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
//-                    cell  NOR2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR2B(A, B, Y);
    
    input A, B;
    output Y;
    
    and AN1   (Y, A, B);
        
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
//-                    cell  NOR3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    nor NR1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
  
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR3A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    nor NT1   (A_INT, A);
    nor NR1   (Y, A_INT, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
  
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR3B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not NT1   (C_INT, C);
    and AN1   (Y, A, B, C_INT);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR3C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    and AN1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR4(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    nor NR1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR4A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (A_INT_, A);
    nor NR1   (Y, A_INT_, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR4B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_OR4_B inst1   (Y_INT_, A, B, C, D);
    not     NT1     (Y, Y_INT_);
       
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR4C(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (D_INT_, D);
    and AN1   (Y, A, B, C, D_INT_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  NOR4D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR4D(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    and AN1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    or  OR1   (ORAB, A, B);
    and AN1   (Y, ORAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA1A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_OA_1A   inst1  (Y, A, B, C);
     
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA1B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    U_OA_1B   inst1  (Y, A, B, C);
     
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA1C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not       NT1    (C_INT_, C);
    U_OA_1A   inst1  (Y, A, B, C_INT_);
     
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA2(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_OA_2    inst1   (Y, A, B, C, D);
        
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA2A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    or        OR1    (C_INT, C, D);
    U_OA_1A   inst1  (Y, A, B, C_INT);
     
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA3(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    or  OR1  (ORAB, A, B);
    and AN1  (Y, ORAB, C, D);
      
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA3A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_OA_1B   inst1  (Y_INT, A, B, C);
    and       AN1    (Y, Y_INT, D);
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA3B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_OA_3B   inst1  (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   InputLoad$D = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA4A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_OA_4A   inst1  (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OA5.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA5(A, B, C, D, Y);

    input A, B, C, D;
    output Y;

    U_OA_5  inst1  (Y, A, B, C, D);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";




        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OAI1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OAI1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    or   OR1   (ORAB, A, B);
    nand ND1   (Y, ORAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OAI2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OAI2A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    nor  NR1   (NRAB, A, B, C);
    or   OR1   (Y, NRAB, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OAI3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OAI3(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    or     OR1   (ORAB, A, B);
    nand   ND1   (Y, ORAB, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OAI3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OAI3A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not    notC  (C_, C);
    not    notD  (D_, D);
    or     OR1   (ORAB, A, B);
    nand   ND1   (Y, ORAB, C_, D_);

    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR2(A, B, Y);
    
    input A, B;
    output Y;
    
    or OR1   (Y, A, B);
    
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
//-                    cell  OR2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR2A(A, B, Y);
    
    input A, B;
    output Y;
    
    not NT1  (A_INT_, A);
    or OR1   (Y, A_INT_, B);
    
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
//-                    cell  OR2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR2B(A, B, Y);
    
    input A, B;
    output Y;
    
    nand ND1   (Y, A, B);
    
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
//-                    cell  OR3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    or OR1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR3A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not  NT1   (A_INT, A);
    or   OR1   (Y, A_INT, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR3B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not  NT1   (C_INT, C);
    nand ND1   (Y, A, B, C_INT);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR3C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    nand ND1   (Y, A, B, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 0;
         specparam   ExtraDelayPaths$C$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR4(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    or OR1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR4A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (A_INT_, A);
    or OR1    (Y, A_INT_, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR4B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR4B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_OR4_B inst1   (Y, A, B, C, D);
       
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR4C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR4C(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not NT1   (D_INT_, D);
    nand ND1  (Y, A, B, C, D_INT_);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OR4D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR4D(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    nand ND1   (Y, A, B, C, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;

         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OUTBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OUTBUF(D, PAD);
    
    input D;
    output PAD;
    
    buf  BF1  (PAD, D);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 0; 
         specparam   OutputLoad$PAD = 0;
         specparam   MacroType = "io";




        (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TRIBUFF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TRIBUFF(D, E, PAD);
    
    input D, E;
    output PAD;
    
    bufif1  BF1  (PAD, D, E);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$D = 0; 
         specparam   InputLoad$E = 0; 
         specparam   OutputLoad$PAD = 0;
         specparam   MacroType = "io";




        (E => PAD) = (0.0, 0.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  UDP_DFPC.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DFPC (Q, D, CP, RB, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. ILLEGAL OUPUT WHEN BOTH
//            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB  SB     NOTIFIER_REG  :   Qt  :  Qt+1

        1   (01)    1   1         ?          :   ?   :   1;  // clocked data
        1   (01)    1   x         ?          :   ?   :   1;  // pessimism

        1    ?      1   x         ?          :   1   :   1;  // pessimism

        0    0      1   x         ?          :   1   :   1;  // pessimism
        0    x      1 (?x)        ?          :   1   :   1;  // pessimism
        0    1      1 (?x)        ?          :   1   :   1;  // pessimism

        x    0      1   x         ?          :   1   :   1;  // pessimism
        x    x      1 (?x)        ?          :   1   :   1;  // pessimism
        x    1      1 (?x)        ?          :   1   :   1;  // pessimism

        0   (01)    1   1         ?          :   ?   :   0;  // clocked data
        0   (01)    x   1         ?          :   ?   :   0;  // pessimism

        0    ?      x   1         ?          :   0   :   0;  // pessimism

        1    0      x   1         ?          :   0   :   0;  // pessimism
        1    x    (?x)  1         ?          :   0   :   0;  // pessimism
        1    1    (?x)  1         ?          :   0   :   0;  // pessimism

        x    0      x   1         ?          :   0   :   0;  // pessimism
        x    x    (?x)  1         ?          :   0   :   0;  // pessimism
        x    1    (?x)  1         ?          :   0   :   0;  // pessimism
                                                           
        1   (x1)    1   1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1   1         ?          :   0   :   0;                          
        1   (0x)    1   1         ?          :   1   :   1;  
        0   (0x)    1   1         ?          :   0   :   0;  

        ?   ?       0   1         ?          :   ?   :   0;  // asynchronous clear
        ?   ?       1   0         ?          :   ?   :   1;  // asynchronous set
        ?   ?       0   0         ?          :   ?   :   0;  // asynchronous set

        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?         ?          :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)       ?          :   ?   :   -;  //       set and clear                  
       
        ?   ?       ?   ?         *          :   ?   :   x;


    endtable

endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBN.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBN (Q, J, K, CP, NOTIFIER_REG); 

    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP;

// FUNCTION : NEGATIVE EDGE TRIGGERED JK FLIP FLOP

    table
      //    J   K   CP      NOTIFIER_REG  :  Qtn   :   Qtn+1
                       
            0   1  (10)        ?          :   ?    :     - ;      // Output retains the 
                       
            0   0  (10)        ?          :   ?    :     0 ;      // Clocked J and K.
            1   1  (10)        ?          :   ?    :     1 ;    
                       
            1   0  (10)        ?          :   0    :     1 ;      // Clocked toggle.
            1   0  (10)        ?          :   1    :     0 ;
                       
            0   1  (1x)        ?          :   ?    :     - ;      //possible clocked JK
            0   0  (1x)        ?          :   0    :     0 ;   
            1   1  (1x)        ?          :   1    :     1 ;
            0   1  (x0)        ?          :   ?    :     - ;
            0   0  (x0)        ?          :   0    :     0 ;
            1   1  (x0)        ?          :   1    :     1 ;
                       
            *   ?   ?          ?          :   ?    :     - ;      // Insensitive to 
            ?   *   ?          ?          :   ?    :     - ;      // transitions on J and K
                                                 // with steady clock.  
            ?   ? (?1)         ?          :   ?    :     - ;      
            ?   ? (0x)         ?          :   ?    :     - ;                                
                       
                       
            x   1   f          ?          :   1    :     1 ;   // reducing pessimism for unknown J  
            x   0   f          ?          :   1    :     0 ;   // reducing pessimism for unknown J  
            0   x   f          ?          :   0    :     0 ;   // reducing pessimism for unknown K  
            1   x   f          ?          :   0    :     1 ;   // reducing pessimism for unknown K  
                       
            x   1  (1x)        ?          :   1    :     1 ;   //possible clocked with
            0   x  (1x)        ?          :   0    :     0 ;   //possible J & K                                 
            x   1  (x0)        ?          :   1    :     1 ;
            0   x  (x0)        ?          :   0    :     0 ;
            ?   ?   ?          *          :   ?    :     x ;

    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBNR.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBNR (Q, J, K, CP, R, NOTIFIER_REG); 


    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           R;                                   // CLEAR INPUT.

// FUNCTION : NEGATIVE EDGE TRIGGERED JK FLIP FLOP, WITH CLEAR 
//            ACTIVE HIGH

    table
      // J   K   CP   R      NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (10)  0         ?          :   ?  :   - ;         // Output retains the 
                                                                  // present state if both 
                                                                  // J and K are 0.
         0   0  (10)  0         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (10)  0         ?          :   ?  :   1 ;    

         0   0  (10)  x         ?          :   ?  :   0 ;         // pessimism
         ?   ?   ?    x         ?          :   0  :   0 ;         // pessimism

         1   0  (10)  0         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (10)  0         ?          :   1  :   0 ;

         ?   0  (10)  x         ?          :   1  :   0 ;         // pessimism

         0   1  (x0)  0         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x0)  0         ?          :   0  :   0 ;   
         1   1  (x0)  0         ?          :   1  :   1 ;
         0   1  (1x)  0         ?          :   ?  :   - ;
         0   0  (1x)  0         ?          :   0  :   0 ;
         1   1  (1x)  0         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                  // with steady clock.
         ?   ? (?1)   0         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (0x)   0         ?          :   ?  :   - ;
                                         
         x   1   f    0         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   f    0         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   f    0         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   f    0         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x0)  0         ?          :   1  :   1 ;         //possible clocked with
         0   x  (x0)  0         ?          :   0  :   0 ;         //possible J & K                                 
         x   1  (1x)  0         ?          :   1  :   1 ;
         0   x  (1x)  0         ?          :   0  :   0 ;

         ?   ?   ?    1         ?          :   ?  :   0 ;         // Clear. 

         ?   ?   ?   (?0)       ?          :   ?  :   - ;         // insensitive to a falling
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on RESET.


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBNRB.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBNRB (Q, J, K, CP, RB, NOTIFIER_REG); 


    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           RB;                                  // CLEAR INPUT.

// FUNCTION : NEGATIVE EDGE TRIGGERED JK FLIP FLOP, WITH CLEAR 
//            ACTIVE LOW 

    table
      // J   K   CP   RB     NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (10)  1         ?          :   ?  :   - ;         // Output retains the 
                                                                  // present state if both 
                                                                  // J and K are 0.
         0   0  (10)  1         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (10)  1         ?          :   ?  :   1 ;    

         0   0  (10)  x         ?          :   ?  :   0 ;         // pessimism
         ?   ?   ?    x         ?          :   0  :   0 ;         // pessimism

         1   0  (10)  1         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (10)  1         ?          :   1  :   0 ;

         ?   0  (10)  x         ?          :   1  :   0 ;         // pessimism

         0   1  (x0)  1         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x0)  1         ?          :   0  :   0 ;   
         1   1  (x0)  1         ?          :   1  :   1 ;
         0   1  (1x)  1         ?          :   ?  :   - ;
         0   0  (1x)  1         ?          :   0  :   0 ;
         1   1  (1x)  1         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                  // with steady clock.
         ?   ? (?1)   1         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (0x)   1         ?          :   ?  :   - ;
                                         
         x   1   f    1         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   f    1         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   f    1         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   f    1         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x0)  1         ?          :   1  :   1 ;         //possible clocked with
         0   x  (x0)  1         ?          :   0  :   0 ;         //possible J & K                                 
         x   1  (1x)  1         ?          :   1  :   1 ;
         0   x  (1x)  1         ?          :   0  :   0 ;

         ?   ?   ?    0         ?          :   ?  :   0 ;         // Clear. 

         ?   ?   ?   (?1)       ?          :   ?  :   - ;         // Insensitive to a rising
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on RESET.


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBNS.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBNS (Q, J, K, CP, S, NOTIFIER_REG); 
 

    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           S;                                   // SET INPUT.

// FUNCTION : NEGATIVE EDGE TRIGGERED J K FLIP FLOP, WITH
//            ASYNCHRONOUS ACTIVE HIGH SET

    table
      // J   K   CP   S      NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (10)  0         ?          :   ?  :   - ;         // Output retains the 
                                                                  // present state if both 
                                                                  // J and K are 0.

         0   0  (10)  0         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (10)  0         ?          :   ?  :   1 ;    

         1   1  (10)  x         ?          :   ?  :   1 ;         // pessimism
         ?   ?   ?    x         ?          :   1  :   1 ;         // pessimism

         1   0  (10)  0         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (10)  0         ?          :   1  :   0 ;

         1   ?  (10)  x         ?          :   0  :   1 ;         // pessimism

         0   1  (x0)  0         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x0)  0         ?          :   0  :   0 ;   
         1   1  (x0)  0         ?          :   1  :   1 ;
         0   1  (1x)  0         ?          :   ?  :   - ;
         0   0  (1x)  0         ?          :   0  :   0 ;
         1   1  (1x)  0         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                  // with steady clock.
         ?   ? (?1)   0         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (0x)   0         ?          :   ?  :   - ;
                                         
         x   1   f    0         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   f    0         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   f    0         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   f    0         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x0)  0         ?          :   1  :   1 ;         //possible clocked with
         0   x  (x0)  0         ?          :   0  :   0 ;         //possible J & K                                 
         x   1  (1x)  0         ?          :   1  :   1 ;
         0   x  (1x)  0         ?          :   0  :   0 ;

         ?   ?   ?    1         ?          :   ?  :   1 ;         // SET. 

         ?   ?   ?   (?0)       ?          :   ?  :   - ;         // insensitive to a falling
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on SET .


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBNSB.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBNSB (Q, J, K, CP, SB, NOTIFIER_REG); 
 

    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           SB;                                  // SET INPUT.

// FUNCTION : NEGATIVE EDGE TRIGGERED J K FLIP FLOP, WITH
//            ASYNCHRONOUS ACTIVE LOW SET

    table
      // J   K   CP   SB     NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (10)  1         ?          :   ?  :   - ;         // Output retains the 
                                                                  // present state if both 
                                                                  // J and K are 0.

         0   0  (10)  1         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (10)  1         ?          :   ?  :   1 ;    

         1   1  (10)  x         ?          :   ?  :   1 ;         // pessimism
         ?   ?   ?    x         ?          :   1  :   1 ;         // pessimism

         1   0  (10)  1         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (10)  1         ?          :   1  :   0 ;

         1   ?  (10)  x         ?          :   0  :   1 ;         // pessimism

         0   1  (x0)  1         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x0)  1         ?          :   0  :   0 ;   
         1   1  (x0)  1         ?          :   1  :   1 ;
         0   1  (1x)  1         ?          :   ?  :   - ;
         0   0  (1x)  1         ?          :   0  :   0 ;
         1   1  (1x)  1         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                  // with steady clock.
         ?   ? (?1)   1         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (0x)   1         ?          :   ?  :   - ;
                                         
         x   1   f    1         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   f    1         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   f    1         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   f    1         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x0)  1         ?          :   1  :   1 ;         //possible clocked with
         0   x  (x0)  1         ?          :   0  :   0 ;         //possible J & K                                 
         x   1  (1x)  1         ?          :   1  :   1 ;
         0   x  (1x)  1         ?          :   0  :   0 ;

         ?   ?   ?    0         ?          :   ?  :   1 ;         // SET. 

         ?   ?   ?   (?1)       ?          :   ?  :   - ;         // Insensitive to a rising 
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on SET .


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBNX.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBNX (Q, J, K, CP, RB, SB, NOTIFIER_REG); 

    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
            CP,                                  // Clock.
            RB,                                  // Clear input 
            SB;                                  // Set input  

// FUNCTION :NEGATIVE EDGE TRIGGERED JK FLIP FLOP, WITH ACTIVE LOW 
//           ASYNCHRONOUS CLEAR AND  SET
//           OUTPUT GOES TO "X" WHEN BOTH CLEAR AND SET ARE ACTIVE 

    table
      // J   K   CP  RB   SB       NOTIFIER_REG  : Qtn : Qtn+1
                    
         0   1  (10) 1    1           ?          :  ?  :   - ;    // Output retains the 
                    
         0   0  (10) 1    1           ?          :  ?  :   0 ;    // Clocked J and K.
         0   0  (10) x    1           ?          :  ?  :   0 ;    // pessimism
         ?   ?   ?   x    1           ?          :  0  :   0 ;    // pessimism
                    
         1   1  (10) 1    1           ?          :  ?  :   1 ;    
         1   1  (10) 1    x           ?          :  ?  :   1 ;    // pessimism
         ?   ?   ?   1    x           ?          :  1  :   1 ;    // pessimism
                    
         1   0  (10) 1    1           ?          :  0  :   1 ;    // Clocked toggle.
         1   0  (10) 1    1           ?          :  1  :   0 ;
                    
         ?   0  (10) x    1           ?          :  1  :   0 ;    //pessimism
         1   ?  (10) 1    x           ?          :  0  :   1 ;
                    
                    
         0   1  (1x) 1    1           ?          :  ?  :   - ;    //possible clocked JK
         0   0  (1x) 1    1           ?          :  0  :   0 ;   
         1   1  (1x) 1    1           ?          :  1  :   1 ;
         0   1  (x0) 1    1           ?          :  ?  :   - ;
         0   0  (x0) 1    1           ?          :  0  :   0 ;
         1   1  (x0) 1    1           ?          :  1  :   1 ;
                    
                                
         *   ?   ?   1    1           ?          :  ?  :   - ;    // Insensitive to 
         ?   *   ?   1    1           ?          :  ?  :   - ;    // transitions on J and K
                                                                  // with steady clock.
                    
         ?   ?   ?   0    1           ?          :  ?  :   0 ;    // Clear.
         ?   ?   ?   1    0           ?          :  ?  :   1 ;    // Set.
         ?   ?   ?   0    0           ?          :  ?  :   x ;    // ILLEGAL 
                    
         x   1   f   1    1           ?          :  1  :   1 ;
         x   0   f   1    1           ?          :  1  :   0 ;
         0   x   f   1    1           ?          :  0  :   0 ;
         1   x   f   1    1           ?          :  0  :   1 ;
                    
         x   1 (1x)  1    1           ?          :  1  :   1 ;    //possible clocked with
         0   x (1x)  1    1           ?          :  0  :   0 ;    //possible J & K                                 
         x   1 (x0)  1    1           ?          :  1  :   1 ;
         0   x (x0)  1    1           ?          :  0  :   0 ;
                    
                    
         ?   ? (?1)  ?    ?           ?          :  ?  :   - ;    
         ?   ? (0x)  ?    ?           ?          :  ?  :   - ;
                    
         ?   ?   ? (?1)   1           ?          :  ?  :   - ;    //ignore changes on set and
         ?   ?   ?   1  (?1)          ?          :  ?  :   - ;    //reset.
         ?   ?   ?   ?    ?           *          :  ?  :   x ;

    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBP.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBP (Q, J, K, CP, NOTIFIER_REG); 
 

    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP;

// FUNCTION : POSITIVE EDGE TRIGGERED JK_ FLIP FLOP

    table
      //    J   K   CP      NOTIFIER_REG  :  Qtn   :   Qtn+1

            0   1  (01)        ?          :   ?    :     - ;      // Output retains the 

            0   0  (01)        ?          :   ?    :     0 ;      // Clocked J and K.
            1   1  (01)        ?          :   ?    :     1 ;    

            1   0  (01)        ?          :   0    :     1 ;      // Clocked toggle.
            1   0  (01)        ?          :   1    :     0 ;

            0   1  (x1)        ?          :   ?    :     - ;      //possible clocked JK
            0   0  (x1)        ?          :   0    :     0 ;   
            1   1  (x1)        ?          :   1    :     1 ;
            0   1  (0x)        ?          :   ?    :     - ;
            0   0  (0x)        ?          :   0    :     0 ;
            1   1  (0x)        ?          :   1    :     1 ;

            *   ?   ?          ?          :   ?    :     - ;      // Insensitive to 
            ?   *   ?          ?          :   ?    :     - ;      // transitions on J and K
                                                 // with steady clock.  
            ?   ? (?0)         ?          :   ?    :     - ;      //ignore falling clock.  
            ?   ? (1x)         ?          :   ?    :     - ;                                


            x   1   r          ?          :   1    :     1 ;   // reducing pessimism for unknown J  
            x   0   r          ?          :   1    :     0 ;   // reducing pessimism for unknown J  
            0   x   r          ?          :   0    :     0 ;   // reducing pessimism for unknown K  
            1   x   r          ?          :   0    :     1 ;   // reducing pessimism for unknown K  
    
            x   1  (x1)        ?          :   1    :     1 ;   //possible clocked with
            0   x  (x1)        ?          :   0    :     0 ;   //possible J & K                                 
            x   1  (0x)        ?          :   1    :     1 ;
            0   x  (0x)        ?          :   0    :     0 ;
            ?   ?   ?          *          :   ?    :     x ;

    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBPR.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBPR (Q, J, K, CP, R, NOTIFIER_REG); 
 


    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           R;                                   // CLEAR INPUT.

// FUNCTION : POSITIVE EDGE TRIGGERED JK FLIP FLOP, WITH CLEAR 
//            ACTIVE HIGH

    table
      // J   K   CP   R      NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (01)  0         ?          :   ?  :   - ;         // Output retains the 
                                                 // present state if both 
                                                 // J and K are 0.

         0   0  (01)  0         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (01)  0         ?          :   ?  :   1 ;    

         0   0  (01)  x         ?          :   ?  :   0 ;         // pessimism
         ?   ?   ?    x         ?          :   0  :   0 ;         // pessimism

         1   0  (01)  0         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (01)  0         ?          :   1  :   0 ;

         ?   0  (01)  x         ?          :   1  :   0 ;         // pessimism

         0   1  (x1)  0         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x1)  0         ?          :   0  :   0 ;   
         1   1  (x1)  0         ?          :   1  :   1 ;
         0   1  (0x)  0         ?          :   ?  :   - ;
         0   0  (0x)  0         ?          :   0  :   0 ;
         1   1  (0x)  0         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                 // with steady clock.
         ?   ? (?0)   0         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (1x)   0         ?          :   ?  :   - ;
                                         
         x   1   r    0         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   r    0         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   r    0         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   r    0         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x1)  0         ?          :   1  :   1 ;        //possible clocked with
         0   x  (x1)  0         ?          :   0  :   0 ;        //possible J & K                                 
         x   1  (0x)  0         ?          :   1  :   1 ;
         0   x  (0x)  0         ?          :   0  :   0 ;

         ?   ?   ?    1         ?          :   ?  :   0 ;         // Clear. 

         ?   ?   ?   (?0)       ?          :   ?  :   - ;         // Insensitive to a rising
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on RESET.


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBPRB.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBPRB (Q, J, K, CP, RB, NOTIFIER_REG); 


    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           RB;                                  // CLEAR INPUT.

// FUNCTION : POSITIVE EDGE TRIGGERED JK FLIP FLOP, WITH CLEAR 
//            ACTIVE LOW 

    table
      // J   K   CP   RB     NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (01)  1         ?          :   ?  :   - ;         // Output retains the 
                                                                  // present state if both 
                                                                  // J and K are 0.
         0   0  (01)  1         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (01)  1         ?          :   ?  :   1 ;    

         0   0  (01)  x         ?          :   ?  :   0 ;         // pessimism
         ?   ?   ?    x         ?          :   0  :   0 ;         // pessimism

         1   0  (01)  1         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (01)  1         ?          :   1  :   0 ;

         ?   0  (01)  x         ?          :   1  :   0 ;         // pessimism

         0   1  (x1)  1         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x1)  1         ?          :   0  :   0 ;   
         1   1  (x1)  1         ?          :   1  :   1 ;
         0   1  (0x)  1         ?          :   ?  :   - ;
         0   0  (0x)  1         ?          :   0  :   0 ;
         1   1  (0x)  1         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                  // with steady clock.
         ?   ? (?0)   1         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (1x)   1         ?          :   ?  :   - ;
                                         
         x   1   r    1         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   r    1         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   r    1         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   r    1         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x1)  1         ?          :   1  :   1 ;         //possible clocked with
         0   x  (x1)  1         ?          :   0  :   0 ;         //possible J & K                                 
         x   1  (0x)  1         ?          :   1  :   1 ;
         0   x  (0x)  1         ?          :   0  :   0 ;

         ?   ?   ?    0         ?          :   ?  :   0 ;         // Clear. 

         ?   ?   ?   (?1)       ?          :   ?  :   - ;         // Insensitive to a rising
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on RESET.


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBPS.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBPS (Q, J, K, CP, S, NOTIFIER_REG); 
 



    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           S;                                   // SET INPUT.

// FUNCTION : POSITIVE EDGE TRIGGERED J K FLIP FLOP, WITH
//            ASYNCHRONOUS ACTIVE HIGH SET



    table
      // J   K   CP   S      NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (01)  0         ?          :   ?  :   - ;         // Output retains the 
                                                                  // present state if both 
                                                                  // J and K are 0.

         0   0  (01)  0         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (01)  0         ?          :   ?  :   1 ;    

         1   1  (01)  x         ?          :   ?  :   1 ;         // pessimism
         ?   ?   ?    x         ?          :   1  :   1 ;         // pessimism

         1   0  (01)  0         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (01)  0         ?          :   1  :   0 ;

         1   ?  (01)  x         ?          :   0  :   1 ;         // pessimism

         0   1  (x1)  0         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x1)  0         ?          :   0  :   0 ;   
         1   1  (x1)  0         ?          :   1  :   1 ;
         0   1  (0x)  0         ?          :   ?  :   - ;
         0   0  (0x)  0         ?          :   0  :   0 ;
         1   1  (0x)  0         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                   // with steady clock.
         ?   ? (?0)   0         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (1x)   0         ?          :   ?  :   - ;
                                         
         x   1   r    0         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   r    0         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   r    0         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   r    0         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x1)  0         ?          :   1  :   1 ;        //possible clocked with
         0   x  (x1)  0         ?          :   0  :   0 ;        //possible J & K                                 
         x   1  (0x)  0         ?          :   1  :   1 ;
         0   x  (0x)  0         ?          :   0  :   0 ;

         ?   ?   ?    1         ?          :   ?  :   1 ;         // SET. 

         ?   ?   ?   (?0)       ?          :   ?  :   - ;         // Insensitive to a falling
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on SET .


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBPSB.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBPSB (Q, J, K, CP, SB, NOTIFIER_REG); 
 

    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // CLOCK.
           SB;                                  // SET INPUT.

// FUNCTION : POSITIVE EDGE TRIGGERED J K FLIP FLOP, WITH
//            ASYNCHRONOUS ACTIVE LOW SET

    table
      // J   K   CP   SB     NOTIFIER_REG  :  Qtn : Qtn+1

         0   1  (01)  1         ?          :   ?  :   - ;         // Output retains the 
                                                                  // present state if both 
                                                                  // J and K are 0.

         0   0  (01)  1         ?          :   ?  :   0 ;         // Clocked J and K.
         1   1  (01)  1         ?          :   ?  :   1 ;    

         1   1  (01)  x         ?          :   ?  :   1 ;         // pessimism
         ?   ?   ?    x         ?          :   1  :   1 ;         // pessimism

         1   0  (01)  1         ?          :   0  :   1 ;         // Clocked toggle.
         1   0  (01)  1         ?          :   1  :   0 ;

         1   ?  (01)  x         ?          :   0  :   1 ;         // pessimism

         0   1  (x1)  1         ?          :   ?  :   - ;         //possible clocked JK
         0   0  (x1)  1         ?          :   0  :   0 ;   
         1   1  (x1)  1         ?          :   1  :   1 ;
         0   1  (0x)  1         ?          :   ?  :   - ;
         0   0  (0x)  1         ?          :   0  :   0 ;
         1   1  (0x)  1         ?          :   1  :   1 ;


         *   ?   ?    ?         ?          :   ?  :   - ;         // Insensitive to 
         ?   *   ?    ?         ?          :   ?  :   - ;         // transitions on J and K
                                                                  // with steady clock.
         ?   ? (?0)   1         ?          :   ?  :   - ;         //ignore falling clock.
         ?   ? (1x)   1         ?          :   ?  :   - ;
                                         
         x   1   r    1         ?          :   1  :   1 ;         // reducing pessimism for unknown J 
         x   0   r    1         ?          :   1  :   0 ;         // reducing pessimism for unknown J 
         0   x   r    1         ?          :   0  :   0 ;         // reducing pessimism for unknown K 
         1   x   r    1         ?          :   0  :   1 ;         // reducing pessimism for unknown K 

         x   1  (x1)  1         ?          :   1  :   1 ;         //possible clocked with
         0   x  (x1)  1         ?          :   0  :   0 ;         //possible J & K                                 
         x   1  (0x)  1         ?          :   1  :   1 ;
         0   x  (0x)  1         ?          :   0  :   0 ;

         ?   ?   ?    0         ?          :   ?  :   1 ;         // SET. 

         ?   ?   ?   (?1)       ?          :   ?  :   - ;         // Insensitive to a rising 
         ?   ?   ?    ?         *          :   ?  :   x ;         // edge on SET .


    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFJKBPX.v                                  -
//--------------------------------------------------------------------
      
primitive UFJKBPX (Q, J, K, CP, RB, SB, NOTIFIER_REG); 
 
 
 
 

    output Q;
    reg    Q;  
    input  NOTIFIER_REG,
           J,K,
           CP,                                  // Clock.
           RB,                                  // Clear input 
           SB;                                  // Set input  

// FUNCTION :POSITIVE EDGE TRIGGERED JK FLIP FLOP, WITH ACTIVE LOW 
//           ASYNCHRONOUS CLEAR AND  SET
//           OUTPUT GOES TO "x" WHEN BOTH CLEAR AND SET ARE ACTIVE 


    table
      // J   K  CP  RB   SB        NOTIFIER_REG  : Qtn : Qtn+1

         0   1  (01) 1    1           ?          :  ?  :   - ;    // Output retains the 

         0   0  (01) 1    1           ?          :  ?  :   0 ;    // Clocked J and K.
         0   0  (01) x    1           ?          :  ?  :   0 ;    // pessimism
         ?   ?   ?   x    1           ?          :  0  :   0 ;    // pessimism

         1   1  (01) 1    1           ?          :  ?  :   1 ;    
         1   1  (01) 1    x           ?          :  ?  :   1 ;    // pessimism
         ?   ?   ?   1    x           ?          :  1  :   1 ;    // pessimism

         1   0  (01) 1    1           ?          :  0  :   1 ;    // Clocked toggle.
         1   0  (01) 1    1           ?          :  1  :   0 ;
         
         ?   0  (01) x    1           ?          :  1  :   0 ;     //pessimism
         1   ?  (01) 1    x           ?          :  0  :   1 ;


         0   1  (x1) 1    1           ?          :  ?  :   - ;   //possible clocked JK
         0   0  (x1) 1    1           ?          :  0  :   0 ;   
         1   1  (x1) 1    1           ?          :  1  :   1 ;
         0   1  (0x) 1    1           ?          :  ?  :   - ;
         0   0  (0x) 1    1           ?          :  0  :   0 ;
         1   1  (0x) 1    1           ?          :  1  :   1 ;

                                
         *   ?   ?   1    1           ?          :  ?  :   - ;    // Insensitive to 
         ?   *   ?   1    1           ?          :  ?  :   - ;    // transitions on J and K
                                                                  // with steady clock.

         ?   ?   ?   0    1           ?          :  ?  :   0 ;    // Clear.
         ?   ?   ?   1    0           ?          :  ?  :   1 ;    // Set.
         ?   ?   ?   0    0           ?          :  ?  :   x ;    // ILLEGAL 

         x   1   r   1    1           ?          :  1  :   1 ;
         x   0   r   1    1           ?          :  1  :   0 ;
         0   x   r   1    1           ?          :  0  :   0 ;
         1   x   r   1    1           ?          :  0  :   1 ;
         
         x   1 (x1)  1    1           ?          :  1  :   1 ;        //possible clocked with
         0   x (x1)  1    1           ?          :  0  :   0 ;        //possible J & K                                 
         x   1 (0x)  1    1           ?          :  1  :   1 ;
         0   x (0x)  1    1           ?          :  0  :   0 ;


         ?   ? (?0)  1    1           ?          :  ?  :   - ;    //ignore falling clock.
         ?   ? (1x)  1    1           ?          :  ?  :   - ;

         ?   ?   ? (?1)   1           ?          :  ?  :   - ;    //ignore changes on set and
         ?   ?   ?   1  (?1)          ?          :  ?  :   - ;    //reset.
         ?   ?   ?   ?    ?           *          :  ?  :   x ;

    endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFN.v                                  -
//--------------------------------------------------------------------
      
primitive UFN (Q, D, CP , NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP;
    reg    Q;  

// FUNCTION :  NEGATIVE EDGE TRIGGERED D FLIP-FLOP ( Q OUTPUT UDP ).


    table
 
    //  D   CP           NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)            ?          :   ?   :   1;  // clocked data
        0   (10)            ?          :   ?   :   0;
                                                           
        1   (1x)            ?          :   1   :   1;  // reducing pessimism
        0   (1x)            ?          :   0   :   0;                          
        1   (x0)            ?          :   1   :   1;  
        0   (x0)            ?          :   0   :   0; 
        
        ?   (0x)            ?          :   ?   :   -;  // no change on rising edge 
        ?   (?1)            ?          :   ?   :   -;  

        *    ?              ?          :   ?   :   -;  // ignore edges on data
        
        ?    ?              *          :   ?   :   x;
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNCE.v                                  -
//--------------------------------------------------------------------
      
primitive UFNCE (Q, D, CP, CEB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CEB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP ) 


    table
 
    //  D   CP      CEB     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (10)    1         ?          :   ?   :   1;  // clocked data
        0   (10)    1         ?          :   ?   :   0;
                            
        1   (1x)    1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1         ?          :   0   :   0;                          
        1   (x0)    1         ?          :   1   :   1;  
        0   (x0)    1         ?          :   0   :   0;  
                            
                            
        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
                                  
        1   (10)    x         ?          :   1   :   1;  // reducing pessimism
        0   (10)    x         ?          :   0   :   0;                      
             
        1   (1x)    x         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    x         ?          :   0   :   0;                          
        1   (x0)    x         ?          :   1   :   1;  
        0   (x0)    x         ?          :   0   :   0;  

 
        ?   (?0)    0         ?          :   ?   :   -;  // reducing pessimism
        ?   (1x)    0         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFNCEB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNCEB (Q, D, CP, CEB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CEB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP ) 


    table
 
    //  D   CP      CEB     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (10)    0         ?          :   ?   :   1;  // clocked data
        0   (10)    0         ?          :   ?   :   0;
                            
        1   (1x)    0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0         ?          :   0   :   0;                          
        1   (x0)    0         ?          :   1   :   1;  
        0   (x0)    0         ?          :   0   :   0;  
                            
                            
        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
                                  
        1   (10)    x         ?          :   1   :   1;  // reducing pessimism
        0   (10)    x         ?          :   0   :   0;                      
             
        1   (1x)    x         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    x         ?          :   0   :   0;                          
        1   (x0)    x         ?          :   1   :   1;  
        0   (x0)    x         ?          :   0   :   0;  

 
        ?   (?0)    1         ?          :   ?   :   -;  // reducing pessimism
        ?   (1x)    1         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFNCEBS.v                                  -
//--------------------------------------------------------------------
      
primitive UFNCEBS (Q, D, CP, S, CEB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S, CEB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS PRESET and ENABLE ( Q OUTPUT UDP ).


    table
 
    //  D   CP      S   CEB      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    0    0          ?          :   ?   :   1;  // clocked data
        0   (10)    0    0          ?          :   ?   :   0;
 
        1   (10)    0    x          ?          :   1   :   1;  // clocked data
        0   (10)    0    x          ?          :   0   :   0;

        1   (10)    x    0          ?          :   ?   :   1;  // pessimism
        1    ?      x    0          ?          :   1   :   1;  // pessimism

        0    1      x    0          ?          :   1   :   1;  // pessimism
        0    x    (?x)   0          ?          :   1   :   1;  // pessimism
        0    0    (?x)   0          ?          :   1   :   1;  // pessimism

        x    1      x    0          ?          :   1   :   1;  // pessimism
        x    x    (?x)   0          ?          :   1   :   1;  // pessimism
        x    0    (?x)   0          ?          :   1   :   1;  // pessimism
        
        1    ?      x    x          ?          :   1   :   1;  // pessimism

        0    1      x    x          ?          :   1   :   1;  // pessimism
        0    x    (?x)   x          ?          :   1   :   1;  // pessimism
        0    0    (?x)   x          ?          :   1   :   1;  // pessimism

        x    1      x    x          ?          :   1   :   1;  // pessimism
        x    x    (?x)   x          ?          :   1   :   1;  // pessimism
        x    0    (?x)   x          ?          :   1   :   1;  // pessimism


        1   (1x)    0    0          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0    0          ?          :   0   :   0;                          
        1   (x0)    0    0          ?          :   1   :   1;  
        0   (x0)    0    0          ?          :   0   :   0;  

        1   (1x)    0    x          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0    x          ?          :   0   :   0;                          
        1   (x0)    0    x          ?          :   1   :   1;  
        0   (x0)    0    x          ?          :   0   :   0;  


        ?    ?      1    ?          ?          :   ?   :   1;  // asynchronous preset

        ?   (?0)    0    1          ?          :   ?   :   -;  // chip is not enabled
        ?   (1x)    0    1          ?          :   ?   :   -;  // chip is not enabled

        ?   (?0)    x    1          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?   (1x)    x    1          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?    ?    (?x)   1          ?          :   1   :   1;  // chip is not enabled pessimism with preset


        ?   (?1)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)   ?          ?          :   ?   :   -;  // ignore the edges on preset
  
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNCERB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNCERB (Q, D, CP, RB, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB, CE;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR and ENABLE ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB   CE      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    1    1          ?          :   ?   :   1;  // clocked data
        0   (10)    1    1          ?          :   ?   :   0;
 
        1   (10)    1    x          ?          :   1   :   1;  // clocked data
        0   (10)    1    x          ?          :   0   :   0;

        0   (10)    x    1          ?          :   ?   :   0;  // pessimism
        0    ?      x    1          ?          :   0   :   0;  // pessimism

        1    1      x    1          ?          :   0   :   0;  // pessimism
        1    x    (?x)   1          ?          :   0   :   0;  // pessimism
        1    0    (?x)   1          ?          :   0   :   0;  // pessimism

        x    1      x    1          ?          :   0   :   0;  // pessimism
        x    x    (?x)   1          ?          :   0   :   0;  // pessimism
        x    0    (?x)   1          ?          :   0   :   0;  // pessimism
        
        0    ?      x    x          ?          :   0   :   0;  // pessimism

        1    1      x    x          ?          :   0   :   0;  // pessimism
        1    x    (?x)   x          ?          :   0   :   0;  // pessimism
        1    0    (?x)   x          ?          :   0   :   0;  // pessimism

        x    1      x    x          ?          :   0   :   0;  // pessimism
        x    x    (?x)   x          ?          :   0   :   0;  // pessimism
        x    0    (?x)   x          ?          :   0   :   0;  // pessimism


        1   (1x)    1    1          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1    1          ?          :   0   :   0;                          
        1   (x0)    1    1          ?          :   1   :   1;  
        0   (x0)    1    1          ?          :   0   :   0;  

        1   (1x)    1    x          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1    x          ?          :   0   :   0;                          
        1   (x0)    1    x          ?          :   1   :   1;  
        0   (x0)    1    x          ?          :   0   :   0;  


        ?    ?      0    ?          ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    1    0          ?          :   ?   :   -;  // chip is not enabled
        ?   (1x)    1    0          ?          :   ?   :   -;  // chip is not enabled

        ?   (?0)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?   (1x)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?    ?    (?x)   0          ?          :   0   :   0;  // chip is not enabled pessimism with reset


        ?   (?1)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)   ?          ?          :   ?   :   -;  // ignore the edges on clear 
  
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNCES.v                                  -
//--------------------------------------------------------------------
      
primitive UFNCES (Q, D, CP, S, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S, CE;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS PRESET and ENABLE ( Q OUTPUT UDP ).


    table
 
    //  D   CP      S   CE      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    0    1          ?          :   ?   :   1;  // clocked data
        0   (10)    0    1          ?          :   ?   :   0;
 
        1   (10)    0    x          ?          :   1   :   1;  // clocked data
        0   (10)    0    x          ?          :   0   :   0;

        1   (10)    x    1          ?          :   ?   :   1;  // pessimism
        1    ?      x    1          ?          :   1   :   1;  // pessimism

        0    1      x    1          ?          :   1   :   1;  // pessimism
        0    x    (?x)   1          ?          :   1   :   1;  // pessimism
        0    0    (?x)   1          ?          :   1   :   1;  // pessimism

        x    1      x    1          ?          :   1   :   1;  // pessimism
        x    x    (?x)   1          ?          :   1   :   1;  // pessimism
        x    0    (?x)   1          ?          :   1   :   1;  // pessimism
        
        1    ?      x    x          ?          :   1   :   1;  // pessimism

        0    1      x    x          ?          :   1   :   1;  // pessimism
        0    x    (?x)   x          ?          :   1   :   1;  // pessimism
        0    0    (?x)   x          ?          :   1   :   1;  // pessimism

        x    1      x    x          ?          :   1   :   1;  // pessimism
        x    x    (?x)   x          ?          :   1   :   1;  // pessimism
        x    0    (?x)   x          ?          :   1   :   1;  // pessimism


        1   (1x)    0    1          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0    1          ?          :   0   :   0;                          
        1   (x0)    0    1          ?          :   1   :   1;  
        0   (x0)    0    1          ?          :   0   :   0;  

        1   (1x)    0    x          ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0    x          ?          :   0   :   0;                          
        1   (x0)    0    x          ?          :   1   :   1;  
        0   (x0)    0    x          ?          :   0   :   0;  


        ?    ?      1    ?          ?          :   ?   :   1;  // asynchronous preset

        ?   (?0)    0    0          ?          :   ?   :   -;  // chip is not enabled
        ?   (1x)    0    0          ?          :   ?   :   -;  // chip is not enabled

        ?   (?0)    x    0          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?   (1x)    x    0          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?    ?    (?x)   0          ?          :   1   :   1;  // chip is not enabled pessimism with preset


        ?   (?1)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)   ?          ?          :   ?   :   -;  // ignore the edges on preset
  
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNQ (QN, D, CP , NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP;
    reg    QN;  

// FUNCTION :  NEGATIVE EDGE TRIGGERED D FLIP-FLOP ( QN OUTPUT UDP ).


    table
 
    //  D   CP           NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (10)            ?          :   ?   :   0;  // clocked data
        0   (10)            ?          :   ?   :   1;
                                                           
        1   (1x)            ?          :   0   :   0;  // reducing pessimism
        0   (1x)            ?          :   1   :   1;                          
        1   (x0)            ?          :   0   :   0;  
        0   (x0)            ?          :   1   :   1; 
        
        ?   (0x)            ?          :   ?   :   -;  // no change on rising edge 
        ?   (?1)            ?          :   ?   :   -;  

        *    ?              ?          :   ?   :   -;  // ignore edges on data
        
        ?    ?              *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNR.v                                  -
//--------------------------------------------------------------------
      
primitive UFNR (Q, D, CP, R, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, R;
    reg    Q; 
    
// FUNCTION :  NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//             ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).


    table
 
    //  D   CP      R      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    0         ?          :   ?   :   1;  // clocked data
        0   (10)    0         ?          :   ?   :   0;

        0   (10)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    1      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism
                                                           
        1   (1x)    0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0         ?          :   0   :   0;                          
        1   (x0)    0         ?          :   1   :   1;  
        0   (x0)    0         ?          :   0   :   0;  


        ?   ?       1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)        ?          :   ?   :   -;  // ignore the edges on clear 
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNRB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNRB (Q, D, CP, RB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    1         ?          :   ?   :   1;  // clocked data
        0   (10)    1         ?          :   ?   :   0;

        0   (10)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    1      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism

        1   (1x)    1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1         ?          :   0   :   0;                          
        1   (x0)    1         ?          :   1   :   1;  
        0   (x0)    1         ?          :   0   :   0;  


        ?   ?       0         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear 

        ?    ?      ?         *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNRBQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNRBQ (QN, D, CP, RB, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    QN; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( QN OUTPUT UDP )


    table
 
    //  D   CP      RB     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (10)    1         ?          :   ?   :   0;  // clocked data
        0   (10)    1         ?          :   ?   :   1;

        0   (10)    x         ?          :   ?   :   1;  // pessimism
        0    ?      x         ?          :   1   :   1;  // pessimism

        1    1      x         ?          :   1   :   1;  // pessimism
        1    x    (?x)        ?          :   1   :   1;  // pessimism
        1    0    (?x)        ?          :   1   :   1;  // pessimism

        x    1      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    0    (?x)        ?          :   1   :   1;  // pessimism

                                                           
        1   (1x)    1         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    1         ?          :   1   :   1;                          
        1   (x0)    1         ?          :   0   :   0;  
        0   (x0)    1         ?          :   1   :   1;  


        ?   ?       0         ?          :   ?   :   1;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear 
         
        ?    ?      ?         *          :   ?   :   x; 

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNRBSX.v                                  -
//--------------------------------------------------------------------
      
primitive UFNRBSX  (Q, D, CP, RB, SB, NOTIFY_REG);

    output Q;  
    input  D, CP, RB, SB, NOTIFY_REG;
    reg    Q; 

// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. ILLEGAL OUPUT WHEN BOTH
//            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).

    table
 
    //  D    CP     RB  SB  NOTIFY_REG :   Qt  :   Qt+1

        1   (10)    1   1       ?      :   ?   :   1;  // clocked data
        1   (10)    1   x       ?      :   ?   :   1;  // pessimism

        1    ?      1   x       ?      :   1   :   1;  // pessimism

        0    1      1   x       ?      :   1   :   1;  // pessimism
        0    x      1 (?x)      ?      :   1   :   1;  // pessimism
        0    0      1 (?x)      ?      :   1   :   1;  // pessimism

        x    1      1   x       ?      :   1   :   1;  // pessimism
        x    x      1 (?x)      ?      :   1   :   1;  // pessimism
        x    0      1 (?x)      ?      :   1   :   1;  // pessimism


        0   (10)    1   1       ?      :   ?   :   0;  // clocked data
        0   (10)    x   1       ?      :   ?   :   0;  // pessimism

        0    ?      x   1       ?      :   0   :   0;  // pessimism

        1    1      x   1       ?      :   0   :   0;  // pessimism
        1    x    (?x)  1       ?      :   0   :   0;  // pessimism
        1    0    (?x)  1       ?      :   0   :   0;  // pessimism

        x    1      x   1       ?      :   0   :   0;  // pessimism
        x    x    (?x)  1       ?      :   0   :   0;  // pessimism
        x    0    (?x)  1       ?      :   0   :   0;  // pessimism
                                                           
        1   (1x)    1   1       ?      :   1   :   1;  // reducing pessimism
        0   (1x)    1   1       ?      :   0   :   0;                          
        1   (x0)    1   1       ?      :   1   :   1;  
        0   (x0)    1   1       ?      :   0   :   0;  

        ?   ?       0   1       ?      :   ?   :   0;  // asynchronous clear
        ?   ?       1   0       ?      :   ?   :   1;  // asynchronous set
        ?   ?       0   0       ?      :   ?   :   x;  // illegal output

        ?   (?1)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?       ?      :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?       ?      :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)     ?      :   ?   :   -;  // set and clear                  
        ?   ?       ?   ?       *      :   ?   :   x;  

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNRQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNRQ (QN, D, CP, R, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, R;
    reg    QN; 
    
// FUNCTION :  NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//             ASYNCHRONOUS CLEAR ( QN OUTPUT UDP ).


    table
 
    //  D   CP      R      NOTIFIER_REG  :   QNt  :   QNt+0

        1   (10)    0         ?          :   ?   :   0;  // clocked data
        0   (10)    0         ?          :   ?   :   1;

        0   (10)    x         ?          :   ?   :   1;  // pessimism
        0    ?      x         ?          :   1   :   1;  // pessimism

        1    1      x         ?          :   1   :   1;  // pessimism
        1    x    (?x)        ?          :   1   :   1;  // pessimism
        1    0    (?x)        ?          :   1   :   1;  // pessimism

        x    1      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    0    (?x)        ?          :   1   :   1;  // pessimism
                                                           
        1   (1x)    0         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    0         ?          :   1   :   1;                          
        1   (x0)    0         ?          :   0   :   0;  
        0   (x0)    0         ?          :   1   :   1;  


        ?   ?       1         ?          :   ?   :   1;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)        ?          :   ?   :   -;  // ignore the edges on clear 
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNS.v                                  -
//--------------------------------------------------------------------
      
primitive UFNS (Q, D, CP, S, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( Q OUTPUT UDP )


    table
 
    //  D   CP      S     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    0         ?          :   ?   :   1;  // clocked data
        0   (10)    0         ?          :   ?   :   0;
        1   (10)    x         ?          :   ?   :   1;  // reducing pessimism
        1    ?      x         ?          :   1   :   1;  // pessimism

        0    1      x         ?          :   1   :   1;  // pessimism
        0    x    (?x)        ?          :   1   :   1;  // pessimism
        0    0    (?x)        ?          :   1   :   1;  // pessimism

        x    1      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    0    (?x)        ?          :   1   :   1;  // pessimism

        1   (1x)    0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0         ?          :   0   :   0;                          
        1   (x0)    0         ?          :   1   :   1;  
        0   (x0)    0         ?          :   0   :   0;  

        ?    ?      1         ?          :   ?   :   1;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNSB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSB (Q, D, CP, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, SB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( Q OUTPUT UDP )


    table
 
    //  D   CP      SB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (10)    1         ?          :   ?   :   1;  // clocked data
        0   (10)    1         ?          :   ?   :   0;
        1   (10)    x         ?          :   ?   :   1;  // reducing pessimism
        1    ?      x         ?          :   1   :   1;  // pessimism

        0    1      x         ?          :   1   :   1;  // pessimism
        0    x    (?x)        ?          :   1   :   1;  // pessimism
        0    0    (?x)        ?          :   1   :   1;  // pessimism

        x    1      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    0    (?x)        ?          :   1   :   1;  // pessimism

        1   (1x)    1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    1         ?          :   0   :   0;                          
        1   (x0)    1         ?          :   1   :   1;  
        0   (x0)    1         ?          :   0   :   0;  

        ?    ?      0         ?          :   ?   :   1;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?1)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNSBQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSBQ (QN, D, CP, SB, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, SB;
    reg    QN; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table
 
    //  D   CP      SB     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (10)    1         ?          :   ?   :   0;  // clocked data
        0   (10)    1         ?          :   ?   :   1;
        1   (10)    x         ?          :   ?   :   0;  // reducing pessimism
        1    ?      x         ?          :   0   :   0;  // pessimism

        0    1      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism

        1   (1x)    1         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    1         ?          :   1   :   1;                          
        1   (x0)    1         ?          :   0   :   0;  
        0   (x0)    1         ?          :   1   :   1;  

        ?    ?      0         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?1)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNSD.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSD (Q, D, CP, TI, TE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( Q OUTPUT UDP ) 

    table
 
    //  D    CP     TI  TE     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (10)    ?   0         ?          :   ?   :   1;  // clocked data
        0   (10)    ?   0         ?          :   ?   :   0;
                            
        1   (1x)    ?   0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    ?   0         ?          :   0   :   0;                          
        1   (x0)    ?   0         ?          :   1   :   1;  
        0   (x0)    ?   0         ?          :   0   :   0;  
                            
                            
        ?   (?1)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                            
        ?   (10)    0   1         ?          :   ?   :   0;  // scan data
        ?   (10)    1   1         ?          :   ?   :   1;  // scan data  
                
        ?   (1x)    1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (1x)    0   1         ?          :   0   :   0;  // for scan data                        
        ?   (x0)    1   1         ?          :   1   :   1;  
        ?   (x0)    0   1         ?          :   0   :   0;  
                
        1   (10)    1   x         ?          :   ?   :   1;  // reducing pessimism
        0   (10)    0   x         ?          :   ?   :   0;                      
                
        1   (1x)    1   x         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    0   x         ?          :   0   :   0;                          
        1   (x0)    1   x         ?          :   1   :   1;  
        0   (x0)    0   x         ?          :   0   :   0;  
                
        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges      
                
        ?    ?      ?   *         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFNSDQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSDQ (QN, D, CP, TI, TE, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    QN; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( QN OUTPUT UDP )

    table
 
    //  D    CP     TI  TE     NOTIFIER_REG  :   Qtn :   Qtn+1
                            
        1   (10)    ?   0         ?          :   ?   :   0;  // clocked data
        0   (10)    ?   0         ?          :   ?   :   1;
                            
        1   (1x)    ?   0         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    ?   0         ?          :   1   :   1;                          
        1   (x0)    ?   0         ?          :   0   :   0;  
        0   (x0)    ?   0         ?          :   1   :   1;  
                            
                            
        ?   (?1)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?         ?          :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                            
        ?   (10)    0   1         ?          :   ?   :   1;  // SCAN DATA
        ?   (10)    1   1         ?          :   ?   :   0;  // 
                
        ?   (1x)    1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (1x)    0   1         ?          :   1   :   1;  // for scan data                        
        ?   (x0)    1   1         ?          :   0   :   0;  
        ?   (x0)    0   1         ?          :   1   :   1;  
                
        1   (10)    1   x         ?          :   ?   :   0; // reducing pessimism
        0   (10)    0   x         ?          :   ?   :   1;                      
                
        1   (1x)    1   x         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    0   x         ?          :   1   :   1;                          
        1   (x0)    1   x         ?          :   0   :   0;  
        0   (x0)    0   x         ?          :   1   :   1;  
                
        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges      
                
        ?    ?      ?   *         ?          :   ?   :   -;  // ignore edges on TE

        ?    ?      ?   ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFNSDR.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSDR (Q, D, CP, TI, TE, R, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, R;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  R     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (10)    ?   0   0         ?          :   ?   :   1;  // clocked data
        0   (10)    ?   0   0         ?          :   ?   :   0;
                                
        0   (10)    ?   0   x         ?          :   ?   :   0;  // pessimism
                                
        0    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        1    1      ?   0   x         ?          :   0   :   0;  // pessimism
        1    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        1    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    1      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      0   1   x         ?          :   0   :   0;  // pessimism
                     
        ?    1      1   1   x         ?          :   0   :   0;  // pessimism
        ?    x      1   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      1   1 (?x)        ?          :   0   :   0;  // pessimism
                     
        ?    1      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      x   1 (?x)        ?          :   0   :   0;  // pessimism
                                                                   
        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB

        1   (1x)    ?   0   0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    ?   0   0         ?          :   0   :   0;                          
        1   (x0)    ?   0   0         ?          :   1   :   1;  
        0   (x0)    ?   0   0         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   1         ?          :   ?   :   0;  // asynchronous clear
                                
        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on clear 

        ?   (10)    0   1   0         ?          :   ?   :   0;  // scan data
        ?   (10)    1   1   0         ?          :   ?   :   1;  // 

        ?   (10)    0   1   x         ?          :   ?   :   0;
        
        ?   (1x)    1   1   0         ?          :   1   :   1;  // reducing pessimism
        ?   (1x)    0   1   0         ?          :   0   :   0;  // for scan data                        
        ?   (x0)    1   1   0         ?          :   1   :   1;  
        ?   (x0)    0   1   0         ?          :   0   :   0;  

        1   (10)    1   x   0         ?          :   ?   :   1; // reducing pessimism
        0   (10)    0   x   0         ?          :   ?   :   0;                      

        0   (1x)    0   x   0         ?          :   0   :   0; //AB
        0   (x0)    0   x   0         ?          :   0   :   0; //AB    

        1   (1x)    1   x   0         ?          :   1   :   1; //AB
        1   (x0)    1   x   0         ?          :   1   :   1; //AB   
             
        0   (10)    0   x   x         ?          :   ?   :   0; 
        0   (1x)    0   x   x         ?          :   0   :   0; //AB
        0   (x0)    0   x   x         ?          :   0   :   0; //AB
             
        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;  

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFNSDRB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSDRB (Q, D, CP, TI, TE, RB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, RB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  RB     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (10)    ?   0   1         ?          :   ?   :   1;  // clocked data
        0   (10)    ?   0   1         ?          :   ?   :   0;
                                
        0   (10)    ?   0   x         ?          :   ?   :   0;  // pessimism
                                
        0    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        1    1      ?   0   x         ?          :   0   :   0;  // pessimism
        1    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        1    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    1      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      0   1   x         ?          :   0   :   0;  // pessimism
                     
        ?    1      1   1   x         ?          :   0   :   0;  // pessimism
        ?    x      1   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      1   1 (?x)        ?          :   0   :   0;  // pessimism
                     
        ?    1      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      x   1 (?x)        ?          :   0   :   0;  // pessimism
                                                                   
        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB

        1   (1x)    ?   0   1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    ?   0   1         ?          :   0   :   0;                          
        1   (x0)    ?   0   1         ?          :   1   :   1;  
        0   (x0)    ?   0   1         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   0         ?          :   ?   :   0;  // asynchronous clear
                                
        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on clear 

        ?   (10)    0   1   1         ?          :   ?   :   0;  // scan data
        ?   (10)    1   1   1         ?          :   ?   :   1;  // 

        ?   (10)    0   1   x         ?          :   ?   :   0;
        
        ?   (1x)    1   1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (1x)    0   1   1         ?          :   0   :   0;  // for scan data                        
        ?   (x0)    1   1   1         ?          :   1   :   1;  
        ?   (x0)    0   1   1         ?          :   0   :   0;  

        1   (10)    1   x   1         ?          :   ?   :   1; // reducing pessimism
        0   (10)    0   x   1         ?          :   ?   :   0;                      

        0   (1x)    0   x   1         ?          :   0   :   0; //AB
        0   (x0)    0   x   1         ?          :   0   :   0; //AB    

        1   (1x)    1   x   1         ?          :   1   :   1; //AB
        1   (x0)    1   x   1         ?          :   1   :   1; //AB   
             
        0   (10)    0   x   x         ?          :   ?   :   0; 
        0   (1x)    0   x   x         ?          :   0   :   0; //AB
        0   (x0)    0   x   x         ?          :   0   :   0; //AB
             
        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   1         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   1         *          :   ?   :   x;  

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFNSDRQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSDRQ (QN, D, CP, TI, TE, R, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, R;
    reg    QN; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( QN OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  R     NOTIFIER_REG  :   QNt  :   QNt+0
                                
        1   (10)    ?   0   0         ?          :   ?   :   0;  // clocked data
        0   (10)    ?   0   0         ?          :   ?   :   1;
                                
        0   (10)    ?   0   x         ?          :   ?   :   1;  // pessimism
                                
        0    ?      ?   0   x         ?          :   1   :   1;  // pessimism

        1    1      ?   0   x         ?          :   1   :   1;  // pessimism
        1    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        1    0      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        x    1      ?   0   x         ?          :   1   :   1;  // pessimism
        x    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        x    0      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        ?    ?      0   1   x         ?          :   1   :   1;  // pessimism
                     
        ?    1      1   1   x         ?          :   1   :   1;  // pessimism
        ?    x      1   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    0      1   1 (?x)        ?          :   1   :   1;  // pessimism
                     
        ?    1      x   1   x         ?          :   1   :   1;  // pessimism
        ?    x      x   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    0      x   1 (?x)        ?          :   1   :   1;  // pessimism
                                                                   
        ?    ?      ?   x (?x)        ?          :   1   :   1;  // AB

        1   (1x)    ?   0   0         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    ?   0   0         ?          :   1   :   1;                          
        1   (x0)    ?   0   0         ?          :   0   :   0;  
        0   (x0)    ?   0   0         ?          :   1   :   1;  
                                
                                
        ?    ?      ?   ?   1         ?          :   ?   :   1;  // asynchronous clear
                                
        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on clear 

        ?   (10)    0   1   0         ?          :   ?   :   1;  // scan data
        ?   (10)    1   1   0         ?          :   ?   :   0;  // 

        ?   (10)    0   1   x         ?          :   ?   :   1;
        
        ?   (1x)    1   1   0         ?          :   0   :   0;  // reducing pessimism
        ?   (1x)    0   1   0         ?          :   1   :   1;  // for scan data                        
        ?   (x0)    1   1   0         ?          :   0   :   0;  
        ?   (x0)    0   1   0         ?          :   1   :   1;  

        1   (10)    1   x   0         ?          :   ?   :   0; // reducing pessimism
        0   (10)    0   x   0         ?          :   ?   :   1;                      

        0   (1x)    0   x   0         ?          :   1   :   1; //AB
        0   (x0)    0   x   0         ?          :   1   :   1; //AB    

        1   (1x)    1   x   0         ?          :   0   :   0; //AB
        1   (x0)    1   x   0         ?          :   0   :   0; //AB   
             
        0   (10)    0   x   x         ?          :   ?   :   1; 
        0   (1x)    0   x   x         ?          :   1   :   1; //AB
        0   (x0)    0   x   x         ?          :   1   :   1; //AB
             
        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;  

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFNSDS.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSDS (Q, D, CP, TI, TE, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET WITH  scan inputs ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (10)    ?   0   0         ?          :   ?   :   1;  // clocked data
        0   (10)    ?   0   0         ?          :   ?   :   0;
                                
        1   (10)    ?   1   x         ?          :   ?   :   1;  // pessimism
                                
        1    ?      ?   0   x         ?          :   1   :   1;  // pessimism

        0    1      ?   0   x         ?          :   1   :   1;  // pessimism
        0    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        0    0      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        x    1      ?   0   x         ?          :   1   :   1;  // pessimism
        x    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        x    0      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        ?    ?      1   1   x         ?          :   1   :   1;  // pessimism
                     
        ?    1      0   1   x         ?          :   1   :   1;  // pessimism
        ?    x      0   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    0      0   1 (?x)        ?          :   1   :   1;  // pessimism
                     
        ?    1      x   1   x         ?          :   1   :   1;  // pessimism
        ?    x      x   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    0      x   1 (?x)        ?          :   1   :   1;  // pessimism
  
        ?    ?      ?   x (?x)        ?          :   1   :   1;  // AB
                                                                      
        1   (1x)    ?   0   0         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    ?   0   0         ?          :   0   :   0;                          
        1   (x0)    ?   0   0         ?          :   1   :   1;  
        0   (x0)    ?   0   0         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   1         ?          :   ?   :   1;  // asynchronous set
                                
        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on set 

        ?   (10)    0   1   0         ?          :   ?   :   0;  // scan data
        ?   (10)    1   1   0         ?          :   ?   :   1;  // 

        ?   (10)    1   1   x         ?          :   ?   :   1;
        
        ?   (1x)    1   1   0         ?          :   1   :   1;  // reducing pessimism
        ?   (1x)    0   1   0         ?          :   0   :   0;  // for scan data                        
        ?   (x0)    1   1   0         ?          :   1   :   1;  
        ?   (x0)    0   1   0         ?          :   0   :   0;  

        1   (10)    1   x   0         ?          :   ?   :   1; // reducing pessimism
        0   (10)    0   x   0         ?          :   ?   :   0;                      
             
        0   (1x)    0   x   0         ?          :   0   :   0; //AB
        0   (x0)    0   x   0         ?          :   0   :   0; //AB    

        1   (1x)    1   x   0         ?          :   1   :   1; //AB
        1   (x0)    1   x   0         ?          :   1   :   1; //AB   
             
        1   (10)    1   x   x         ?          :   ?   :   1; 
        1   (1x)    1   x   x         ?          :   1   :   1; //AB
        1   (x0)    1   x   x         ?          :   1   :   1; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFNSDSB.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSDSB (Q, D, CP, TI, TE, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    Q; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET WITH  scan inputs ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (10)    ?   0   1         ?          :   ?   :   1;  // clocked data
        0   (10)    ?   0   1         ?          :   ?   :   0;
                                
        1   (10)    ?   1   x         ?          :   ?   :   1;  // pessimism
                                
        1    ?      ?   0   x         ?          :   1   :   1;  // pessimism

        0    1      ?   0   x         ?          :   1   :   1;  // pessimism
        0    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        0    0      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        x    1      ?   0   x         ?          :   1   :   1;  // pessimism
        x    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        x    0      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        ?    ?      1   1   x         ?          :   1   :   1;  // pessimism
                     
        ?    1      0   1   x         ?          :   1   :   1;  // pessimism
        ?    x      0   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    0      0   1 (?x)        ?          :   1   :   1;  // pessimism
                     
        ?    1      x   1   x         ?          :   1   :   1;  // pessimism
        ?    x      x   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    0      x   1 (?x)        ?          :   1   :   1;  // pessimism
  
        ?    ?      ?   x (?x)        ?          :   1   :   1;  // AB
                                                                      
        1   (1x)    ?   0   1         ?          :   1   :   1;  // reducing pessimism
        0   (1x)    ?   0   1         ?          :   0   :   0;                          
        1   (x0)    ?   0   1         ?          :   1   :   1;  
        0   (x0)    ?   0   1         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   0         ?          :   ?   :   1;  // asynchronous set
                                
        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on set 

        ?   (10)    0   1   1         ?          :   ?   :   0;  // scan data
        ?   (10)    1   1   1         ?          :   ?   :   1;  // 

        ?   (10)    1   1   x         ?          :   ?   :   1;
        
        ?   (1x)    1   1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (1x)    0   1   1         ?          :   0   :   0;  // for scan data                        
        ?   (x0)    1   1   1         ?          :   1   :   1;  
        ?   (x0)    0   1   1         ?          :   0   :   0;  

        1   (10)    1   x   1         ?          :   ?   :   1; // reducing pessimism
        0   (10)    0   x   1         ?          :   ?   :   0;                      
             
        0   (1x)    0   x   1         ?          :   0   :   0; //AB
        0   (x0)    0   x   1         ?          :   0   :   0; //AB    

        1   (1x)    1   x   1         ?          :   1   :   1; //AB
        1   (x0)    1   x   1         ?          :   1   :   1; //AB   
             
        1   (10)    1   x   x         ?          :   ?   :   1; 
        1   (1x)    1   x   x         ?          :   1   :   1; //AB
        1   (x0)    1   x   x         ?          :   1   :   1; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFNSDSBQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSDSBQ (QN, D, CP, TI, TE, SB, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    QN; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET WITH  scan inputs ( QN OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   QNt  :   QNt+0
                                
        1   (10)    ?   0   1         ?          :   ?   :   0;  // clocked data
        0   (10)    ?   0   1         ?          :   ?   :   1;
                                
        1   (10)    ?   1   x         ?          :   ?   :   0;  // pessimism
                                
        1    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        0    1      ?   0   x         ?          :   0   :   0;  // pessimism
        0    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        0    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    1      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    0      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      1   1   x         ?          :   0   :   0;  // pessimism
                     
        ?    1      0   1   x         ?          :   0   :   0;  // pessimism
        ?    x      0   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      0   1 (?x)        ?          :   0   :   0;  // pessimism
                     
        ?    1      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    0      x   1 (?x)        ?          :   0   :   0;  // pessimism
  
        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB
                                                                      
        1   (1x)    ?   0   1         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    ?   0   1         ?          :   1   :   1;                          
        1   (x0)    ?   0   1         ?          :   0   :   0;  
        0   (x0)    ?   0   1         ?          :   1   :   1;  
                                
                                
        ?    ?      ?   ?   0         ?          :   ?   :   0;  // asynchronous set
                                
        ?   (?1)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on set 

        ?   (10)    0   1   1         ?          :   ?   :   1;  // scan data
        ?   (10)    1   1   1         ?          :   ?   :   0;  // 

        ?   (10)    1   1   x         ?          :   ?   :   0;
        
        ?   (1x)    1   1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (1x)    0   1   1         ?          :   1   :   1;  // for scan data                        
        ?   (x0)    1   1   1         ?          :   0   :   0;  
        ?   (x0)    0   1   1         ?          :   1   :   1;  

        1   (10)    1   x   1         ?          :   ?   :   0; // reducing pessimism
        0   (10)    0   x   1         ?          :   ?   :   1;                      
             
        0   (1x)    0   x   1         ?          :   1   :   1; //AB
        0   (x0)    0   x   1         ?          :   1   :   1; //AB    

        1   (1x)    1   x   1         ?          :   0   :   0; //AB
        1   (x0)    1   x   1         ?          :   0   :   0; //AB   
             
        1   (10)    1   x   x         ?          :   ?   :   0; 
        1   (1x)    1   x   x         ?          :   0   :   0; //AB
        1   (x0)    1   x   x         ?          :   0   :   0; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFNSQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFNSQ (QN, D, CP, S, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, S;
    reg    QN; 
    
// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table
 
    //  D   CP      S     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (10)    0         ?          :   ?   :   0;  // clocked data
        0   (10)    0         ?          :   ?   :   1;
        1   (10)    x         ?          :   ?   :   0;  // reducing pessimism
        1    ?      x         ?          :   0   :   0;  // pessimism

        0    1      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    0    (?x)        ?          :   0   :   0;  // pessimism

        x    1      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    0    (?x)        ?          :   0   :   0;  // pessimism

        1   (1x)    0         ?          :   0   :   0;  // reducing pessimism
        0   (1x)    0         ?          :   1   :   1;                          
        1   (x0)    0         ?          :   0   :   0;  
        0   (x0)    0         ?          :   1   :   1;  

        ?    ?      1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFNX.v                                  -
//--------------------------------------------------------------------
      
primitive UFNX (Q, D, CP, RB, SB, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CE, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. ILLEGAL OUPUT WHEN BOTH
//            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB  SB   CE  NOTIFIER_REG  :   Qt  :  Qt+1
 
        1   (10)    1   1    1      ?         :   ?   :   1;  // clocked data
        0   (10)    1   1    1      ?         :   ?   :   0;  // clocked data

        1   (10)    1   1    x      ?         :   1   :   1;  // clocked data
        0   (10)    1   1    x      ?         :   0   :   0;

        1   (10)    1   x    1      ?         :   ?   :   1;  // pessimism
        1    ?      1   x    1      ?         :   1   :   1;  // pessimism

        0    1      1   x    1      ?         :   1   :   1;  // pessimism
        0    x      1 (?x)   1      ?         :   1   :   1;  // pessimism
        0    0      1 (?x)   1      ?         :   1   :   1;  // pessimism

        x    1      1   x    1      ?         :   1   :   1;  // pessimism
        x    x      1 (?x)   1      ?         :   1   :   1;  // pessimism
        x    0      1 (?x)   1      ?         :   1   :   1;  // pessimism

        1    ?      1   x    x      ?         :   1   :   1;  // pessimism

        0    1      1   x    x      ?         :   1   :   1;  // pessimism
        0    x      1 (?x)   x      ?         :   1   :   1;  // pessimism
        0    0      1 (?x)   x      ?         :   1   :   1;  // pessimism

        x    1      1   x    x      ?         :   1   :   1;  // pessimism
        x    x      1 (?x)   x      ?         :   1   :   1;  // pessimism
        x    0      1 (?x)   x      ?         :   1   :   1;  // pessimism

        0   (10)    x   1    1      ?         :   ?   :   0;  // pessimism
        0    ?      x   1    1      ?         :   0   :   0;  // pessimism

        1    0      x   1    1      ?         :   0   :   0;  // pessimism
        1    x    (?x)  1    1      ?         :   0   :   0;  // pessimism
        1    1    (?x)  1    1      ?         :   0   :   0;  // pessimism

        x    0      x   1    1      ?         :   0   :   0;  // pessimism
        x    x    (?x)  1    1      ?         :   0   :   0;  // pessimism
        x    1    (?x)  1    1      ?         :   0   :   0;  // pessimism

        0    ?      x   1    x      ?         :   0   :   0;  // pessimism

        1    0      x   1    x      ?         :   0   :   0;  // pessimism
        1    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
        1    1    (?x)  1    x      ?         :   0   :   0;  // pessimism

        x    0      x   1    x      ?         :   0   :   0;  // pessimism
        x    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
        x    1    (?x)  1    x      ?         :   0   :   0;  // pessimism

        1   (1x)    1   1    1      ?         :   1   :   1;  // reducing pessimism
        0   (1x)    1   1    1      ?         :   0   :   0;                          
        1   (x0)    1   1    1      ?         :   1   :   1;  
        0   (x0)    1   1    1      ?         :   0   :   0;  

        1   (1x)    1   1    x      ?         :   1   :   1;  // reducing pessimism
        0   (1x)    1   1    x      ?         :   0   :   0;                          
        1   (x0)    1   1    x      ?         :   1   :   1;  
        0   (x0)    1   1    x      ?         :   0   :   0;  

        ?   ?       0   1    ?      ?         :   ?   :   0;  // asynchronous clear
        ?   ?       1   0    ?      ?         :   ?   :   1;  // asynchronous set

        ?  (?0)     1   1    0      ?         :   ?   :   -;  //no action for CE = 1
        ?  (1x)     1   1    0      ?         :   ?   :   -;  //no action for CE = 1

        ?   (?0)    x   1    0      ?         :   0   :   0;  // chip is not enabled pessimism with reset
        ?   (1x)    x   1    0      ?         :   0   :   0;  // chip is not enabled pessimism with reset
        ?    ?    (?x)  1    0      ?         :   0   :   0;  // chip is not enabled pessimism with reset

        ?   (?0)    1   x    0      ?         :   1   :   1;  // chip is not enabled pessimism with reset
        ?   (1x)    1   x    0      ?         :   1   :   1;  // chip is not enabled pessimism with reset
        ?    ?      1  (?x)  0      ?         :   1   :   1;  // chip is not enabled pessimism with reset

        ?   ?       ?   ?    *      ?         :   ?   :   -;

        ?   (?1)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
        ?   (0x)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?    ?      ?         :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?    ?      ?         :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)  ?      ?         :   ?   :   -;  //       set and clear                  

        ?   ?       ?   ?    ?      *         :   ?   :   x;

    endtable

endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFP.v                                  -
//--------------------------------------------------------------------
      
primitive UFP (Q, D, CP , NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP;
    reg    Q;  

// FUNCTION :  POSITIVE EDGE TRIGGERED D FLIP-FLOP ( Q OUTPUT UDP ).


    table
 
    //  D   CP           NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)            ?          :   ?   :   1;  // clocked data
        0   (01)            ?          :   ?   :   0;
                                                           
        1   (x1)            ?          :   1   :   1;  // reducing pessimism
        0   (x1)            ?          :   0   :   0;                          
        1   (0x)            ?          :   1   :   1;  
        0   (0x)            ?          :   0   :   0; 
        
        ?   (1x)            ?          :   ?   :   -;  // no change on falling edge 
        ?   (?0)            ?          :   ?   :   -;  

        *    ?              ?          :   ?   :   -;  // ignore edges on data
        
        ?    ?              *          :   ?   :   x;
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPCE.v                                  -
//--------------------------------------------------------------------
      
primitive UFPCE (Q, D, CP, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CE;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP ) 


    table
 
    //  D   CP      CE     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (01)    1         ?          :   ?   :   1;  // clocked data
        0   (01)    1         ?          :   ?   :   0;
                            
        1   (x1)    1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1         ?          :   0   :   0;                          
        1   (0x)    1         ?          :   1   :   1;  
        0   (0x)    1         ?          :   0   :   0;  
                            
                            
        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
                                  
        1   (01)    x         ?          :   1   :   1;  // reducing pessimism
        0   (01)    x         ?          :   0   :   0;                      
             
        1   (x1)    x         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    x         ?          :   0   :   0;                          
        1   (0x)    x         ?          :   1   :   1;  
        0   (0x)    x         ?          :   0   :   0;  

 
        ?   (?1)    0         ?          :   ?   :   -;  // reducing pessimism
        ?   (0x)    0         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFPCEB.v                                  -
//--------------------------------------------------------------------
      
primitive UFPCEB (Q, D, CP, CEB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CEB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH CLOCK ENABLE INPUT ( Q OUTPUT UDP ) 


    table
 
    //  D   CP      CEB     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (01)    0         ?          :   ?   :   1;  // clocked data
        0   (01)    0         ?          :   ?   :   0;
                            
        1   (x1)    0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0         ?          :   0   :   0;                          
        1   (0x)    0         ?          :   1   :   1;  
        0   (0x)    0         ?          :   0   :   0;  
                            
                            
        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data
                                  
        1   (01)    x         ?          :   1   :   1;  // reducing pessimism
        0   (01)    x         ?          :   0   :   0;                      
             
        1   (x1)    x         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    x         ?          :   0   :   0;                          
        1   (0x)    x         ?          :   1   :   1;  
        0   (0x)    x         ?          :   0   :   0;  

 
        ?   (?1)    1         ?          :   ?   :   -;  // reducing pessimism
        ?   (0x)    1         ?          :   ?   :   -;  // reducing pessimism

        ?    ?      *         ?          :   ?   :   -; // ignore edges on CE
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFPCEBS.v                                  -
//--------------------------------------------------------------------
      
primitive UFPCEBS (Q, D, CP, S, CEB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S, CEB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS PRESET and ENABLE ACTIVE LOW ( Q OUTPUT UDP ).


    table
 
    //  D   CP      S   CEB      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    0    0          ?          :   ?   :   1;  // clocked data
        0   (01)    0    0          ?          :   ?   :   0;
 
        1   (01)    0    x          ?          :   1   :   1;  // clocked data
        0   (01)    0    x          ?          :   0   :   0;

        1   (01)    x    0          ?          :   ?   :   1;  // pessimism
        1    ?      x    0          ?          :   1   :   1;  // pessimism

        0    0      x    0          ?          :   1   :   1;  // pessimism
        0    x    (?x)   0          ?          :   1   :   1;  // pessimism
        0    1    (?x)   0          ?          :   1   :   1;  // pessimism

        x    0      x    0          ?          :   1   :   1;  // pessimism
        x    x    (?x)   0          ?          :   1   :   1;  // pessimism
        x    1    (?x)   0          ?          :   1   :   1;  // pessimism
        
        1    ?      x    x          ?          :   1   :   1;  // pessimism

        0    0      x    x          ?          :   1   :   1;  // pessimism
        0    x    (?x)   x          ?          :   1   :   1;  // pessimism
        0    1    (?x)   x          ?          :   1   :   1;  // pessimism

        x    0      x    x          ?          :   1   :   1;  // pessimism
        x    x    (?x)   x          ?          :   1   :   1;  // pessimism
        x    1    (?x)   x          ?          :   1   :   1;  // pessimism


        1   (x1)    0    0          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0    0          ?          :   0   :   0;                          
        1   (0x)    0    0          ?          :   1   :   1;  
        0   (0x)    0    0          ?          :   0   :   0;  

        1   (x1)    0    x          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0    x          ?          :   0   :   0;                          
        1   (0x)    0    x          ?          :   1   :   1;  
        0   (0x)    0    x          ?          :   0   :   0;  


        ?    ?      1    ?          ?          :   ?   :   1;  // asynchronous preset

        ?   (?1)    0    1          ?          :   ?   :   -;  // chip is not enabled
        ?   (0x)    0    1          ?          :   ?   :   -;  // chip is not enabled

        ?   (?1)    x    1          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?   (0x)    x    1          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?    ?    (?x)   1          ?          :   1   :   1;  // chip is not enabled pessimism with preset


        ?   (?0)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)   ?          ?          :   ?   :   -;  // ignore the edges on preset
  
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPCERB.v                                  -
//--------------------------------------------------------------------
      
primitive UFPCERB (Q, D, CP, RB, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB, CE;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR and ENABLE ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB   CE      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    1    1          ?          :   ?   :   1;  // clocked data
        0   (01)    1    1          ?          :   ?   :   0;
 
        1   (01)    1    x          ?          :   1   :   1;  // clocked data
        0   (01)    1    x          ?          :   0   :   0;

        0   (01)    x    1          ?          :   ?   :   0;  // pessimism
        0    ?      x    1          ?          :   0   :   0;  // pessimism

        1    0      x    1          ?          :   0   :   0;  // pessimism
        1    x    (?x)   1          ?          :   0   :   0;  // pessimism
        1    1    (?x)   1          ?          :   0   :   0;  // pessimism

        x    0      x    1          ?          :   0   :   0;  // pessimism
        x    x    (?x)   1          ?          :   0   :   0;  // pessimism
        x    1    (?x)   1          ?          :   0   :   0;  // pessimism
        
        0    ?      x    x          ?          :   0   :   0;  // pessimism

        1    0      x    x          ?          :   0   :   0;  // pessimism
        1    x    (?x)   x          ?          :   0   :   0;  // pessimism
        1    1    (?x)   x          ?          :   0   :   0;  // pessimism

        x    0      x    x          ?          :   0   :   0;  // pessimism
        x    x    (?x)   x          ?          :   0   :   0;  // pessimism
        x    1    (?x)   x          ?          :   0   :   0;  // pessimism


        1   (x1)    1    1          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1    1          ?          :   0   :   0;                          
        1   (0x)    1    1          ?          :   1   :   1;  
        0   (0x)    1    1          ?          :   0   :   0;  

        1   (x1)    1    x          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1    x          ?          :   0   :   0;                          
        1   (0x)    1    x          ?          :   1   :   1;  
        0   (0x)    1    x          ?          :   0   :   0;  


        ?    ?      0    ?          ?          :   ?   :   0;  // asynchronous clear

        ?   (?1)    1    0          ?          :   ?   :   -;  // chip is not enabled
        ?   (0x)    1    0          ?          :   ?   :   -;  // chip is not enabled

        ?   (?1)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?   (0x)    x    0          ?          :   0   :   0;  // chip is not enabled pessimism with reset
        ?    ?    (?x)   0          ?          :   0   :   0;  // chip is not enabled pessimism with reset


        ?   (?0)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)   ?          ?          :   ?   :   -;  // ignore the edges on clear 
  
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPCES.v                                  -
//--------------------------------------------------------------------
      
primitive UFPCES (Q, D, CP, S, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S, CE;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS PRESET and ENABLE ( Q OUTPUT UDP ).


    table
 
    //  D   CP      S   CE      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    0    1          ?          :   ?   :   1;  // clocked data
        0   (01)    0    1          ?          :   ?   :   0;
 
        1   (01)    0    x          ?          :   1   :   1;  // clocked data
        0   (01)    0    x          ?          :   0   :   0;

        1   (01)    x    1          ?          :   ?   :   1;  // pessimism
        1    ?      x    1          ?          :   1   :   1;  // pessimism

        0    0      x    1          ?          :   1   :   1;  // pessimism
        0    x    (?x)   1          ?          :   1   :   1;  // pessimism
        0    1    (?x)   1          ?          :   1   :   1;  // pessimism

        x    0      x    1          ?          :   1   :   1;  // pessimism
        x    x    (?x)   1          ?          :   1   :   1;  // pessimism
        x    1    (?x)   1          ?          :   1   :   1;  // pessimism
        
        1    ?      x    x          ?          :   1   :   1;  // pessimism

        0    0      x    x          ?          :   1   :   1;  // pessimism
        0    x    (?x)   x          ?          :   1   :   1;  // pessimism
        0    1    (?x)   x          ?          :   1   :   1;  // pessimism

        x    0      x    x          ?          :   1   :   1;  // pessimism
        x    x    (?x)   x          ?          :   1   :   1;  // pessimism
        x    1    (?x)   x          ?          :   1   :   1;  // pessimism


        1   (x1)    0    1          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0    1          ?          :   0   :   0;                          
        1   (0x)    0    1          ?          :   1   :   1;  
        0   (0x)    0    1          ?          :   0   :   0;  

        1   (x1)    0    x          ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0    x          ?          :   0   :   0;                          
        1   (0x)    0    x          ?          :   1   :   1;  
        0   (0x)    0    x          ?          :   0   :   0;  


        ?    ?      1    ?          ?          :   ?   :   1;  // asynchronous preset

        ?   (?1)    0    0          ?          :   ?   :   -;  // chip is not enabled
        ?   (0x)    0    0          ?          :   ?   :   -;  // chip is not enabled

        ?   (?1)    x    0          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?   (0x)    x    0          ?          :   1   :   1;  // chip is not enabled pessimism with preset
        ?    ?    (?x)   0          ?          :   1   :   1;  // chip is not enabled pessimism with preset


        ?   (?0)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?    ?          ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?    ?          ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)   ?          ?          :   ?   :   -;  // ignore the edges on preset
  
        ?    ?      ?    *          ?          :   ?   :   -;

        ?    ?      ?    ?          *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPQ (QN, D, CP , NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP;
    reg    QN;  

// FUNCTION :  POSITIVE EDGE TRIGGERED D FLIP-FLOP ( QN OUTPUT UDP ).


    table
 
    //  D   CP           NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)            ?          :   ?   :   0;  // clocked data
        0   (01)            ?          :   ?   :   1;
                                                           
        1   (x1)            ?          :   0   :   0;  // reducing pessimism
        0   (x1)            ?          :   1   :   1;                          
        1   (0x)            ?          :   0   :   0;  
        0   (0x)            ?          :   1   :   1; 
        
        ?   (1x)            ?          :   ?   :   -;  // no change on falling edge 
        ?   (?0)            ?          :   ?   :   -;  

        *    ?              ?          :   ?   :   -;  // ignore edges on data
        
        ?    ?              *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPR.v                                  -
//--------------------------------------------------------------------
      
primitive UFPR (Q, D, CP, R, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, R;
    reg    Q; 
    
// FUNCTION :  POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//             ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).


    table
 
    //  D   CP      R      NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    0         ?          :   ?   :   1;  // clocked data
        0   (01)    0         ?          :   ?   :   0;

        0   (01)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    0      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    1    (?x)        ?          :   0   :   0;  // pessimism

        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism
                                                           
        1   (x1)    0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0         ?          :   0   :   0;                          
        1   (0x)    0         ?          :   1   :   1;  
        0   (0x)    0         ?          :   0   :   0;  


        ?   ?       1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)        ?          :   ?   :   -;  // ignore the edges on clear 
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPRB.v                                  -
//--------------------------------------------------------------------
      
primitive UFPRB (Q, D, CP, RB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    1         ?          :   ?   :   1;  // clocked data
        0   (01)    1         ?          :   ?   :   0;

        0   (01)    x         ?          :   ?   :   0;  // pessimism
        0    ?      x         ?          :   0   :   0;  // pessimism

        1    0      x         ?          :   0   :   0;  // pessimism
        1    x    (?x)        ?          :   0   :   0;  // pessimism
        1    1    (?x)        ?          :   0   :   0;  // pessimism

        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism

        1   (x1)    1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1         ?          :   0   :   0;                          
        1   (0x)    1         ?          :   1   :   1;  
        0   (0x)    1         ?          :   0   :   0;  


        ?   ?       0         ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear 

        ?    ?      ?         *          :   ?   :   x;
 
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPRBQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPRBQ (QN, D, CP, RB, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, RB;
    reg    QN; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR ( QN OUTPUT UDP )


    table
 
    //  D   CP      RB     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)    1         ?          :   ?   :   0;  // clocked data
        0   (01)    1         ?          :   ?   :   1;

        0   (01)    x         ?          :   ?   :   1;  // pessimism
        0    ?      x         ?          :   1   :   1;  // pessimism

        1    0      x         ?          :   1   :   1;  // pessimism
        1    x    (?x)        ?          :   1   :   1;  // pessimism
        1    1    (?x)        ?          :   1   :   1;  // pessimism

        x    0      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    1    (?x)        ?          :   1   :   1;  // pessimism

                                                           
        1   (x1)    1         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    1         ?          :   1   :   1;                          
        1   (0x)    1         ?          :   0   :   0;  
        0   (0x)    1         ?          :   1   :   1;  


        ?   ?       0         ?          :   ?   :   1;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?1)        ?          :   ?   :   -;  // ignore the edges on clear 
         
        ?    ?      ?         *          :   ?   :   x; 

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPRBSX.v                                  -
//--------------------------------------------------------------------
      
primitive UFPRBSX (Q, D, CP, RB, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. ILLEGAL OUPUT WHEN BOTH
//            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB  SB     NOTIFIER_REG  :   Qt  :  Qt+1

        1   (01)    1   1         ?          :   ?   :   1;  // clocked data
        1   (01)    1   x         ?          :   ?   :   1;  // pessimism

        1    ?      1   x         ?          :   1   :   1;  // pessimism

        0    0      1   x         ?          :   1   :   1;  // pessimism
        0    x      1 (?x)        ?          :   1   :   1;  // pessimism
        0    1      1 (?x)        ?          :   1   :   1;  // pessimism

        x    0      1   x         ?          :   1   :   1;  // pessimism
        x    x      1 (?x)        ?          :   1   :   1;  // pessimism
        x    1      1 (?x)        ?          :   1   :   1;  // pessimism

        0   (01)    1   1         ?          :   ?   :   0;  // clocked data
        0   (01)    x   1         ?          :   ?   :   0;  // pessimism

        0    ?      x   1         ?          :   0   :   0;  // pessimism

        1    0      x   1         ?          :   0   :   0;  // pessimism
        1    x    (?x)  1         ?          :   0   :   0;  // pessimism
        1    1    (?x)  1         ?          :   0   :   0;  // pessimism

        x    0      x   1         ?          :   0   :   0;  // pessimism
        x    x    (?x)  1         ?          :   0   :   0;  // pessimism
        x    1    (?x)  1         ?          :   0   :   0;  // pessimism
                                                           
        1   (x1)    1   1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1   1         ?          :   0   :   0;                          
        1   (0x)    1   1         ?          :   1   :   1;  
        0   (0x)    1   1         ?          :   0   :   0;  

        ?   ?       0   1         ?          :   ?   :   0;  // asynchronous clear
        ?   ?       1   0         ?          :   ?   :   1;  // asynchronous set
        ?   ?       0   0         ?          :   ?   :   x;  // asynchronous set

        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?         ?          :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)       ?          :   ?   :   -;  //       set and clear                  
       
        ?   ?       ?   ?         *          :   ?   :   x;


    endtable

endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPRQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPRQ (QN, D, CP, R, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, R;
    reg    QN; 
    
// FUNCTION :  POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//             ASYNCHRONOUS CLEAR ( QN OUTPUT UDP ).


    table
 
    //  D   CP      R      NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)    0         ?          :   ?   :   0;  // clocked data
        0   (01)    0         ?          :   ?   :   1;

        0   (01)    x         ?          :   ?   :   1;  // pessimism
        0    ?      x         ?          :   1   :   1;  // pessimism

        1    0      x         ?          :   1   :   1;  // pessimism
        1    x    (?x)        ?          :   1   :   1;  // pessimism
        1    1    (?x)        ?          :   1   :   1;  // pessimism

        x    0      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    1    (?x)        ?          :   1   :   1;  // pessimism
                                                           
                                                           
        1   (x1)    0         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    0         ?          :   1   :   1;                          
        1   (0x)    0         ?          :   0   :   0;  
        0   (0x)    0         ?          :   1   :   1;  


        ?    ?      1         ?          :   ?   :   1;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the edges on data

        ?    ?    (?0)        ?          :   ?   :   -;  // ignore the edges on clear 
        ?    ?      ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPS.v                                  -
//--------------------------------------------------------------------
      
primitive UFPS (Q, D, CP, S, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, S;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( Q OUTPUT UDP )


    table
 
    //  D   CP      S     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    0         ?          :   ?   :   1;  // clocked data
        0   (01)    0         ?          :   ?   :   0;
        1   (01)    x         ?          :   ?   :   1;  // reducing pessimism
        1    ?      x         ?          :   1   :   1;  // pessimism

        0    0      x         ?          :   1   :   1;  // pessimism
        0    x    (?x)        ?          :   1   :   1;  // pessimism
        0    1    (?x)        ?          :   1   :   1;  // pessimism

        x    0      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    1    (?x)        ?          :   1   :   1;  // pessimism

        1   (x1)    0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0         ?          :   0   :   0;                          
        1   (0x)    0         ?          :   1   :   1;  
        0   (0x)    0         ?          :   0   :   0;  

        ?    ?      1         ?          :   ?   :   1;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPSB.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSB (Q, D, CP, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, SB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( Q OUTPUT UDP )


    table
 
    //  D   CP      SB     NOTIFIER_REG  :   Qt  :   Qt+1

        1   (01)    1         ?          :   ?   :   1;  // clocked data
        0   (01)    1         ?          :   ?   :   0;
        1   (01)    x         ?          :   ?   :   1;  // reducing pessimism
        1    ?      x         ?          :   1   :   1;  // pessimism

        0    0      x         ?          :   1   :   1;  // pessimism
        0    x    (?x)        ?          :   1   :   1;  // pessimism
        0    1    (?x)        ?          :   1   :   1;  // pessimism

        x    0      x         ?          :   1   :   1;  // pessimism
        x    x    (?x)        ?          :   1   :   1;  // pessimism
        x    1    (?x)        ?          :   1   :   1;  // pessimism

        1   (x1)    1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    1         ?          :   0   :   0;                          
        1   (0x)    1         ?          :   1   :   1;  
        0   (0x)    1         ?          :   0   :   0;  

        ?    ?      0         ?          :   ?   :   1;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?1)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPSBQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSBQ (QN, D, CP, SB, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, SB;
    reg    QN; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table
 
    //  D   CP      SB     NOTIFIER_REG  :   Qtn :   Qtn+1

        1   (01)    1         ?          :   ?   :   0;  // clocked data
        0   (01)    1         ?          :   ?   :   1;
        1   (01)    x         ?          :   ?   :   0;  // reducing pessimism

        1    ?      x         ?          :   0   :   0;  // pessimism

        0    0      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    1    (?x)        ?          :   0   :   0;  // pessimism

        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism

                                                           
        1   (x1)    1         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    1         ?          :   1   :   1;                          
        1   (0x)    1         ?          :   0   :   0;  
        0   (0x)    1         ?          :   1   :   1;  

        ?    ?      0         ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?    ?     (?1)       ?          :   ?   :   -;  // ignore the edges on set
        
        ?    ?      ?         *          :   ?   :   x;
    
    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPSD.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSD (Q, D, CP, TI, TE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( Q OUTPUT UDP ) 


    table
 
    //  D   CP      TI  TE     NOTIFIER_REG  :   Qt  :   Qt+1
                            
        1   (01)    ?   0         ?          :   ?   :   1;  // clocked data
        0   (01)    ?   0         ?          :   ?   :   0;
                            
        1   (x1)    ?   0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    ?   0         ?          :   0   :   0;                          
        1   (0x)    ?   0         ?          :   1   :   1;  
        0   (0x)    ?   0         ?          :   0   :   0;  
                            
                            
        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                            
        ?   (01)    0   1         ?          :   ?   :   0;  // scan data
        ?   (01)    1   1         ?          :   ?   :   1;  // scan data  
      
        ?   (x1)    1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (x1)    0   1         ?          :   0   :   0;  // for scan data                        
        ?   (0x)    1   1         ?          :   1   :   1;  
        ?   (0x)    0   1         ?          :   0   :   0;  

        1   (01)    1   x         ?          :   ?   :   1;  // reducing pessimism
        0   (01)    0   x         ?          :   ?   :   0;                      
             
        1   (x1)    1   x         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    0   x         ?          :   0   :   0;                          
        1   (0x)    1   x         ?          :   1   :   1;  
        0   (0x)    0   x         ?          :   0   :   0;  

        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *          ?          :   ?   :   -; // ignore edges on TE
        ?    ?      ?   ?         *          :   ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFPSDQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSDQ (QN, D, CP, TI, TE, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, TI, TE;
    reg    QN; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH SCAN INPUTS ( QN OUTPUT UDP )


    table
 
    //  D   CP      TI  TE     NOTIFIER_REG  :   Qtn :   Qtn+1
                            
        1   (01)    ?   0         ?          :   ?   :   0;  // clocked data
        0   (01)    ?   0         ?          :   ?   :   1;
                            
        1   (x1)    ?   0         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    ?   0         ?          :   1   :   1;                          
        1   (0x)    ?   0         ?          :   0   :   0;  
        0   (0x)    ?   0         ?          :   1   :   1;  
                            
                            
        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                            
        ?   (01)    0   1         ?          :   ?   :   1;  // SCAN DATA
        ?   (01)    1   1         ?          :   ?   :   0;  // 

        ?   (x1)    1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (x1)    0   1         ?          :   1   :   1;  // for scan data                        
        ?   (0x)    1   1         ?          :   0   :   0;  
        ?   (0x)    0   1         ?          :   1   :   1;  

        1   (01)    1   x         ?          :   ?   :   0; // reducing pessimism
        0   (01)    0   x         ?          :   ?   :   1;                      
              
        1   (x1)    1   x         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    0   x         ?          :   1   :   1;                          
        1   (0x)    1   x         ?          :   0   :   0;  
        0   (0x)    0   x         ?          :   1   :   1;  


        ?    ?      *   ?         ?          :   ?   :   -;  // ignore edges      
//added by sp
        ?    ?      ?   *         ?          :   ?   :   -;  // ignore edges on TE
//end
        ?    ?      ?   ?         *          :   ?   :   x;


    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  UFPSDR.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSDR (Q, D, CP, TI, TE, R, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, R;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  R     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (01)    ?   0   0         ?          :   ?   :   1;  // clocked data
        0   (01)    ?   0   0         ?          :   ?   :   0;
                                
        0   (01)    ?   0   x         ?          :   ?   :   0;  // pessimism
                                
        0    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        1    0      ?   0   x         ?          :   0   :   0;  // pessimism
        1    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        1    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    0      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      0   1   x         ?          :   0   :   0;  // pessimism
                     
        ?    0      1   1   x         ?          :   0   :   0;  // pessimism
        ?    x      1   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      1   1 (?x)        ?          :   0   :   0;  // pessimism
     
        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB
                     
        ?    0      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      x   1 (?x)        ?          :   0   :   0;  // pessimism
                                                                   
        1   (x1)    ?   0   0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    ?   0   0         ?          :   0   :   0;                          
        1   (0x)    ?   0   0         ?          :   1   :   1;  
        0   (0x)    ?   0   0         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   1        ?          :   ?   :   0;  // asynchronous clear
                                
        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on clear 

        ?   (01)    0   1   0         ?          :   ?   :   0;  // scan data
        ?   (01)    1   1   0         ?          :   ?   :   1;  // 

        ?   (01)    0   1   x         ?          :   ?   :   0;
        
        ?   (x1)    1   1   0         ?          :   1   :   1;  // reducing pessimism
        ?   (x1)    0   1   0         ?          :   0   :   0;  // for scan data                        
        ?   (0x)    1   1   0         ?          :   1   :   1;  
        ?   (0x)    0   1   0         ?          :   0   :   0;  

        1   (01)    1   x   0         ?          :   ?   :   1; // reducing pessimism
        0   (01)    0   x   0         ?          :   ?   :   0;                              
        0   (0x)    0   x   0         ?          :   0   :   0; //AB
        0   (x1)    0   x   0         ?          :   0   :   0; //AB    

        1   (0x)    1   x   0         ?          :   1   :   1; //AB
        1   (x1)    1   x   0         ?          :   1   :   1; //AB   
             
        0   (01)    0   x   x         ?          :   ?   :   0; 
        0   (0x)    0   x   x         ?          :   0   :   0; //AB
        0   (x1)    0   x   x         ?          :   0   :   0; //AB

             
        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;  

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFPSDRB.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSDRB (Q, D, CP, TI, TE, RB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, RB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  RB     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (01)    ?   0   1         ?          :   ?   :   1;  // clocked data
        0   (01)    ?   0   1         ?          :   ?   :   0;
                                
        0   (01)    ?   0   x         ?          :   ?   :   0;  // pessimism
                                
        0    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        1    0      ?   0   x         ?          :   0   :   0;  // pessimism
        1    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        1    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    0      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      0   1   x         ?          :   0   :   0;  // pessimism
                     
        ?    0      1   1   x         ?          :   0   :   0;  // pessimism
        ?    x      1   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      1   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB
                     
        ?    0      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      x   1 (?x)        ?          :   0   :   0;  // pessimism
                                                                   
        1   (x1)    ?   0   1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    ?   0   1         ?          :   0   :   0;                          
        1   (0x)    ?   0   1         ?          :   1   :   1;  
        0   (0x)    ?   0   1         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   0         ?          :   ?   :   0;  // asynchronous clear
                                
        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on clear 

        ?   (01)    0   1   1         ?          :   ?   :   0;  // scan data
        ?   (01)    1   1   1         ?          :   ?   :   1;  // 

        ?   (01)    0   1   x         ?          :   ?   :   0;
        
        ?   (x1)    1   1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (x1)    0   1   1         ?          :   0   :   0;  // for scan data                        
        ?   (0x)    1   1   1         ?          :   1   :   1;  
        ?   (0x)    0   1   1         ?          :   0   :   0;  

        1   (01)    1   x   1         ?          :   ?   :   1; // reducing pessimism
        0   (01)    0   x   1         ?          :   ?   :   0;                      
        0   (0x)    0   x   1         ?          :   0   :   0; //AB
        0   (x1)    0   x   1         ?          :   0   :   0; //AB    

        1   (0x)    1   x   1         ?          :   1   :   1; //AB
        1   (x1)    1   x   1         ?          :   1   :   1; //AB   
             
        0   (01)    0   x   x         ?          :   ?   :   0; 
        0   (0x)    0   x   x         ?          :   0   :   0; //AB
        0   (x1)    0   x   x         ?          :   0   :   0; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
//added by sp
        ?    ?      ?   *   1         ?          :   ?   :   -;  // ignore edges on TE
//end     
        ?    ?      ?   ?   1         *          :   ?   :   x;  

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFPSDRQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSDRQ (QN, D, CP, TI, TE, R, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, R;
    reg    QN; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS CLEAR WITH  SCAN INPUTS ( QN OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  R     NOTIFIER_REG  :   QNt  :   QNt+0
                                
        1   (01)    ?   0   0         ?          :   ?   :   0;  // clocked data
        0   (01)    ?   0   0         ?          :   ?   :   1;
                                
        0   (01)    ?   0   x         ?          :   ?   :   1;  // pessimism
                                
        0    ?      ?   0   x         ?          :   1   :   1;  // pessimism

        1    0      ?   0   x         ?          :   1   :   1;  // pessimism
        1    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        1    1      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        x    0      ?   0   x         ?          :   1   :   1;  // pessimism
        x    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        x    1      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        ?    ?      0   1   x         ?          :   1   :   1;  // pessimism
                     
        ?    0      1   1   x         ?          :   1   :   1;  // pessimism
        ?    x      1   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    1      1   1 (?x)        ?          :   1   :   1;  // pessimism
     
        ?    ?      ?   x (?x)        ?          :   1   :   1;  // AB
                     
        ?    0      x   1   x         ?          :   1   :   1;  // pessimism
        ?    x      x   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    1      x   1 (?x)        ?          :   1   :   1;  // pessimism
                                                                   
        1   (x1)    ?   0   0         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    ?   0   0         ?          :   1   :   1;                          
        1   (0x)    ?   0   0         ?          :   0   :   0;  
        0   (0x)    ?   0   0         ?          :   1   :   1;  
                                
                                
        ?    ?      ?   ?   1        ?          :   ?   :   1;  // asynchronous clear
                                
        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on clear 

        ?   (01)    0   1   0         ?          :   ?   :   1;  // scan data
        ?   (01)    1   1   0         ?          :   ?   :   0;  // 

        ?   (01)    0   1   x         ?          :   ?   :   1;
        
        ?   (x1)    1   1   0         ?          :   0   :   0;  // reducing pessimism
        ?   (x1)    0   1   0         ?          :   1   :   1;  // for scan data                        
        ?   (0x)    1   1   0         ?          :   0   :   0;  
        ?   (0x)    0   1   0         ?          :   1   :   1;  

        1   (01)    1   x   0         ?          :   ?   :   0; // reducing pessimism
        0   (01)    0   x   0         ?          :   ?   :   1;                              
        0   (0x)    0   x   0         ?          :   1   :   1; //AB
        0   (x1)    0   x   0         ?          :   1   :   1; //AB    

        1   (0x)    1   x   0         ?          :   0   :   0; //AB
        1   (x1)    1   x   0         ?          :   0   :   0; //AB   
             
        0   (01)    0   x   x         ?          :   ?   :   1; 
        0   (0x)    0   x   x         ?          :   1   :   1; //AB
        0   (x1)    0   x   x         ?          :   1   :   1; //AB

             
        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;  

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFPSDS.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSDS (Q, D, CP, TI, TE, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET WITH  scan inputs ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (01)    ?   0   0         ?          :   ?   :   1;  // clocked data
        0   (01)    ?   0   0         ?          :   ?   :   0;
                                
        1   (01)    ?   1   x         ?          :   ?   :   1;  // pessimism
                                
        1    ?      ?   0   x         ?          :   1   :   1;  // pessimism

        0    0      ?   0   x         ?          :   1   :   1;  // pessimism
        0    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        0    1      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        x    0      ?   0   x         ?          :   1   :   1;  // pessimism
        x    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        x    1      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        ?    ?      1   1   x         ?          :   1   :   1;  // pessimism
                     
        ?    0      0   1   x         ?          :   1   :   1;  // pessimism
        ?    x      0   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    1      0   1 (?x)        ?          :   1   :   1;  // pessimism
                     
        ?    0      x   1   x         ?          :   1   :   1;  // pessimism
        ?    x      x   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    1      x   1 (?x)        ?          :   1   :   1;  // pessimism
  
        ?    ?      ?   x (?x)        ?          :   1   :   1;  // AB
                                                                      
        1   (x1)    ?   0   0         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    ?   0   0         ?          :   0   :   0;                          
        1   (0x)    ?   0   0         ?          :   1   :   1;  
        0   (0x)    ?   0   0         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   1         ?          :   ?   :   1;  // asynchronous set
                                
        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?0)       ?          :   ?   :   -;  // ignore the edges on set 

        ?   (01)    0   1   0         ?          :   ?   :   0;  // scan data
        ?   (01)    1   1   0         ?          :   ?   :   1;  // 

        ?   (01)    1   1   x         ?          :   ?   :   1;
        
        ?   (x1)    1   1   0         ?          :   1   :   1;  // reducing pessimism
        ?   (x1)    0   1   0         ?          :   0   :   0;  // for scan data                        
        ?   (0x)    1   1   0         ?          :   1   :   1;  
        ?   (0x)    0   1   0         ?          :   0   :   0;  

        1   (01)    1   x   0         ?          :   ?   :   1; // reducing pessimism
        0   (01)    0   x   0         ?          :   ?   :   0;                      
             
        0   (0x)    0   x   0         ?          :   0   :   0; //AB
        0   (x1)    0   x   0         ?          :   0   :   0; //AB    

        1   (0x)    1   x   0         ?          :   1   :   1; //AB
        1   (x1)    1   x   0         ?          :   1   :   1; //AB   
             
        1   (01)    1   x   x         ?          :   ?   :   1; 
        1   (0x)    1   x   x         ?          :   1   :   1; //AB
        1   (x1)    1   x   x         ?          :   1   :   1; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
        ?    ?      ?   *   ?         ?          :   ?   :   -;  // ignore edges on TE
        ?    ?      ?   ?   ?         *          :   ?   :   x;

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFPSDSB.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSDSB (Q, D, CP, TI, TE, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    Q; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET WITH  scan inputs ( Q OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   Qt  :   Qt+1
                                
        1   (01)    ?   0   1         ?          :   ?   :   1;  // clocked data
        0   (01)    ?   0   1         ?          :   ?   :   0;
                                
        1   (01)    ?   1   x         ?          :   ?   :   1;  // pessimism
                                
        1    ?      ?   0   x         ?          :   1   :   1;  // pessimism

        0    0      ?   0   x         ?          :   1   :   1;  // pessimism
        0    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        0    1      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        x    0      ?   0   x         ?          :   1   :   1;  // pessimism
        x    x      ?   0 (?x)        ?          :   1   :   1;  // pessimism
        x    1      ?   0 (?x)        ?          :   1   :   1;  // pessimism

        ?    ?      1   1   x         ?          :   1   :   1;  // pessimism
                     
        ?    0      0   1   x         ?          :   1   :   1;  // pessimism
        ?    x      0   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    1      0   1 (?x)        ?          :   1   :   1;  // pessimism
                     
        ?    0      x   1   x         ?          :   1   :   1;  // pessimism
        ?    x      x   1 (?x)        ?          :   1   :   1;  // pessimism
        ?    1      x   1 (?x)        ?          :   1   :   1;  // pessimism

        ?    ?      ?   x (?x)        ?          :   1   :   1;  // AB
                                                                      
        1   (x1)    ?   0   1         ?          :   1   :   1;  // reducing pessimism
        0   (x1)    ?   0   1         ?          :   0   :   0;                          
        1   (0x)    ?   0   1         ?          :   1   :   1;  
        0   (0x)    ?   0   1         ?          :   0   :   0;  
                                
                                
        ?    ?      ?   ?   0         ?          :   ?   :   1;  // asynchronous set
                                
        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on set 

        ?   (01)    0   1   1         ?          :   ?   :   0;  // scan data
        ?   (01)    1   1   1         ?          :   ?   :   1;  // 

        ?   (01)    1   1   x         ?          :   ?   :   1;
        
        ?   (x1)    1   1   1         ?          :   1   :   1;  // reducing pessimism
        ?   (x1)    0   1   1         ?          :   0   :   0;  // for scan data                        
        ?   (0x)    1   1   1         ?          :   1   :   1;  
        ?   (0x)    0   1   1         ?          :   0   :   0;  

        1   (01)    1   x   1         ?          :   ?   :   1; // reducing pessimism
        0   (01)    0   x   1         ?          :   ?   :   0;                      
             
        0   (0x)    0   x   1         ?          :   0   :   0; //AB
        0   (x1)    0   x   1         ?          :   0   :   0; //AB    

        1   (0x)    1   x   1         ?          :   1   :   1; //AB
        1   (x1)    1   x   1         ?          :   1   :   1; //AB   
             
        1   (01)    1   x   x         ?          :   ?   :   1; 
        1   (0x)    1   x   x         ?          :   1   :   1; //AB
        1   (x1)    1   x   x         ?          :   1   :   1; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
//added by sp
        ?    ?      ?   *   1         ?          :   ?   :   -;  // ignore edges on TE
//end     
        ?    ?      ?   ?   1         *          :   ?   :   x;

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFPSDSBQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSDSBQ (QN, D, CP, TI, TE, SB, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, TI, TE, SB;
    reg    QN; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET WITH  scan inputs ( QN OUTPUT UDP )


    table
 
    //  D   CP      TI  TE  SB     NOTIFIER_REG  :   QNt  :   QNt+0
                                
        1   (01)    ?   0   1         ?          :   ?   :   0;  // clocked data
        0   (01)    ?   0   1         ?          :   ?   :   1;
                                
        1   (01)    ?   1   x         ?          :   ?   :   0;  // pessimism
                                
        1    ?      ?   0   x         ?          :   0   :   0;  // pessimism

        0    0      ?   0   x         ?          :   0   :   0;  // pessimism
        0    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        0    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        x    0      ?   0   x         ?          :   0   :   0;  // pessimism
        x    x      ?   0 (?x)        ?          :   0   :   0;  // pessimism
        x    1      ?   0 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      1   1   x         ?          :   0   :   0;  // pessimism
                     
        ?    0      0   1   x         ?          :   0   :   0;  // pessimism
        ?    x      0   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      0   1 (?x)        ?          :   0   :   0;  // pessimism
                     
        ?    0      x   1   x         ?          :   0   :   0;  // pessimism
        ?    x      x   1 (?x)        ?          :   0   :   0;  // pessimism
        ?    1      x   1 (?x)        ?          :   0   :   0;  // pessimism

        ?    ?      ?   x (?x)        ?          :   0   :   0;  // AB
                                                                      
        1   (x1)    ?   0   1         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    ?   0   1         ?          :   1   :   1;                          
        1   (0x)    ?   0   1         ?          :   0   :   0;  
        0   (0x)    ?   0   1         ?          :   1   :   1;  
                                
                                
        ?    ?      ?   ?   0         ?          :   ?   :   0;  // asynchronous set
                                
        ?   (?0)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?   ?         ?          :   ?   :   -;  // ignore the edges on data
                                
        ?    ?      ?   ?  (?1)       ?          :   ?   :   -;  // ignore the edges on set 

        ?   (01)    0   1   1         ?          :   ?   :   1;  // scan data
        ?   (01)    1   1   1         ?          :   ?   :   0;  // 

        ?   (01)    1   1   x         ?          :   ?   :   0;
        
        ?   (x1)    1   1   1         ?          :   0   :   0;  // reducing pessimism
        ?   (x1)    0   1   1         ?          :   1   :   1;  // for scan data                        
        ?   (0x)    1   1   1         ?          :   0   :   0;  
        ?   (0x)    0   1   1         ?          :   1   :   1;  

        1   (01)    1   x   1         ?          :   ?   :   0; // reducing pessimism
        0   (01)    0   x   1         ?          :   ?   :   1;                      
             
        0   (0x)    0   x   1         ?          :   1   :   1; //AB
        0   (x1)    0   x   1         ?          :   1   :   1; //AB    

        1   (0x)    1   x   1         ?          :   0   :   0; //AB
        1   (x1)    1   x   1         ?          :   0   :   0; //AB   
             
        1   (01)    1   x   x         ?          :   ?   :   0; 
        1   (0x)    1   x   x         ?          :   0   :   0; //AB
        1   (x1)    1   x   x         ?          :   0   :   0; //AB

        ?    ?      *   ?   ?         ?          :   ?   :   -;  // ignore edges      
//added by sp
        ?    ?      ?   *   1         ?          :   ?   :   -;  // ignore edges on TE
//end     
        ?    ?      ?   ?   1         *          :   ?   :   x;

    endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  UFPSQ.v                                  -
//--------------------------------------------------------------------
      
primitive UFPSQ (QN, D, CP, S, NOTIFIER_REG); 

    output QN;  
    input  NOTIFIER_REG,
           D, CP, S;
    reg    QN; 
    
// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( QN OUTPUT UDP )


    table
 
    //  D   CP      S     NOTIFIER_REG  :   QNt  :   QNt+0

        1   (01)    0         ?          :   ?   :   0;  // clocked data
        0   (01)    0         ?          :   ?   :   1;
        1   (01)    x         ?          :   ?   :   0;  // reducing pessimism
        1    ?      x         ?          :   0   :   0;  // pessimism

        0    0      x         ?          :   0   :   0;  // pessimism
        0    x    (?x)        ?          :   0   :   0;  // pessimism
        0    1    (?x)        ?          :   0   :   0;  // pessimism

        x    0      x         ?          :   0   :   0;  // pessimism
        x    x    (?x)        ?          :   0   :   0;  // pessimism
        x    1    (?x)        ?          :   0   :   0;  // pessimism

        1   (x1)    0         ?          :   0   :   0;  // reducing pessimism
        0   (x1)    0         ?          :   1   :   1;                          
        1   (0x)    0         ?          :   0   :   0;  
        0   (0x)    0         ?          :   1   :   1;  

        ?    ?      1         ?          :   ?   :   0;  // asynchronous clear

        ?   (?0)    ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?         ?          :   ?   :   -;  // ignore the data edges

        ?   ?     (?0)        ?          :   ?   :   -;  // ignore the edges on set
        
        ?   ?       ?         *          :   ?   :   x;

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UFPX.v                                  -
//--------------------------------------------------------------------
      
primitive UFPX (Q, D, CP, RB, SB, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CE, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. ILLEGAL OUPUT WHEN BOTH
//            SET AND CLEAR ARE LOW ( Q OUTPUT UDP ).


    table
 
    //  D   CP      RB  SB   CE  NOTIFIER_REG  :   Qt  :  Qt+1
 
        1   (01)    1   1    1      ?         :   ?   :   1;  // clocked data
        0   (01)    1   1    1      ?         :   ?   :   0;  // clocked data

        1   (01)    1   1    x      ?         :   1   :   1;  // clocked data
        0   (01)    1   1    x      ?         :   0   :   0;

        1   (01)    1   x    1      ?         :   ?   :   1;  // pessimism
        1    ?      1   x    1      ?         :   1   :   1;  // pessimism

        0    0      1   x    1      ?         :   1   :   1;  // pessimism
        0    x      1 (?x)   1      ?         :   1   :   1;  // pessimism
        0    1      1 (?x)   1      ?         :   1   :   1;  // pessimism

        x    0      1   x    1      ?         :   1   :   1;  // pessimism
        x    x      1 (?x)   1      ?         :   1   :   1;  // pessimism
        x    1      1 (?x)   1      ?         :   1   :   1;  // pessimism

        1    ?      1   x    x      ?         :   1   :   1;  // pessimism

        0    0      1   x    x      ?         :   1   :   1;  // pessimism
        0    x      1 (?x)   x      ?         :   1   :   1;  // pessimism
        0    1      1 (?x)   x      ?         :   1   :   1;  // pessimism

        x    0      1   x    x      ?         :   1   :   1;  // pessimism
        x    x      1 (?x)   x      ?         :   1   :   1;  // pessimism
        x    1      1 (?x)   x      ?         :   1   :   1;  // pessimism

        0   (01)    x   1    1      ?         :   ?   :   0;  // pessimism
        0    ?      x   1    1      ?         :   0   :   0;  // pessimism

        1    0      x   1    1      ?         :   0   :   0;  // pessimism
        1    x    (?x)  1    1      ?         :   0   :   0;  // pessimism
        1    1    (?x)  1    1      ?         :   0   :   0;  // pessimism

        x    0      x   1    1      ?         :   0   :   0;  // pessimism
        x    x    (?x)  1    1      ?         :   0   :   0;  // pessimism
        x    1    (?x)  1    1      ?         :   0   :   0;  // pessimism

        0    ?      x   1    x      ?         :   0   :   0;  // pessimism

        1    0      x   1    x      ?         :   0   :   0;  // pessimism
        1    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
        1    1    (?x)  1    x      ?         :   0   :   0;  // pessimism

        x    0      x   1    x      ?         :   0   :   0;  // pessimism
        x    x    (?x)  1    x      ?         :   0   :   0;  // pessimism
        x    1    (?x)  1    x      ?         :   0   :   0;  // pessimism

        1   (x1)    1   1    1      ?         :   1   :   1;  // reducing pessimism
        0   (x1)    1   1    1      ?         :   0   :   0;                          
        1   (0x)    1   1    1      ?         :   1   :   1;  
        0   (0x)    1   1    1      ?         :   0   :   0;  

        1   (x1)    1   1    x      ?         :   1   :   1;  // reducing pessimism
        0   (x1)    1   1    x      ?         :   0   :   0;                          
        1   (0x)    1   1    x      ?         :   1   :   1;  
        0   (0x)    1   1    x      ?         :   0   :   0;  

        ?   ?       0   1    ?      ?         :   ?   :   0;  // asynchronous clear
        ?   ?       1   0    ?      ?         :   ?   :   1;  // asynchronous set

        ?  (?1)     1   1    0      ?         :   ?   :   -;  //no action for CE = 1
        ?  (0x)     1   1    0      ?         :   ?   :   -;  //no action for CE = 1

        ?   (?1)    x   1    0      ?         :   0   :   0;  // chip is not enabled pessimism with reset
        ?   (0x)    x   1    0      ?         :   0   :   0;  // chip is not enabled pessimism with reset
        ?    ?    (?x)  1    0      ?         :   0   :   0;  // chip is not enabled pessimism with reset

        ?   (?1)    1   x    0      ?         :   1   :   1;  // chip is not enabled pessimism with reset
        ?   (0x)    1   x    0      ?         :   1   :   1;  // chip is not enabled pessimism with reset
        ?    ?      1  (?x)  0      ?         :   1   :   1;  // chip is not enabled pessimism with reset

        ?   ?       ?   ?    *      ?         :   ?   :   -;

        ?   (?0)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?    ?      ?         :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?    ?      ?         :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?    ?      ?         :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)  ?      ?         :   ?   :   -;  //       set and clear                  

        ?   ?       ?   ?    ?      *         :   ?   :   x;

    endtable

endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  ULN.v                                  -
//--------------------------------------------------------------------
      
primitive ULN (Q, D, GN, NOTI_REG); 

 
 
 

    output Q; 
    reg    Q;                               
    input  D,                // data
           GN,                // clock
           NOTI_REG;         // NOTIFY_REG
// FUNCTION :  D-LATCH, GATED  ACTIVE LOW / STANDARD DRIVE ( Q OUTPUT UDP )
//


   table
     //  D       GN    NOTI_REG        : Qt  :   Qt+1

         ?      (0x)    ?             :  ?  :    -   ;
         ?      (?1)    ?             :  ?  :    -   ;

         *       1      ?             :  ?  :    -   ;

       (?0)      0      ?             :  ?  :    0   ;
       (?1)      0      ?             :  ?  :    1   ; 
        0       (10)    ?             :  ?  :    0   ;
        1       (10)    ?             :  ?  :    1   ; 

       (?1)      x      ?             :  1  :    1   ;    // Reducing pessimism.
       (?0)      x      ?             :  0  :    0   ; 

         0      (1x)    ?             :  0  :    0   ;   // Reducing pessimism.
         1      (1x)    ?             :  1  :    1   ;
         0      (x0)    ?             :  ?  :    0   ;
         1      (x0)    ?             :  ?  :    1   ;
         
         ?       ?      *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULNQ (QN, D, GN, NOTI_REG); 

 

    output QN; 
    reg    QN;                               
    input  D,                // data
           GN,                // clock
           NOTI_REG;         // NOTIFY REG
// FUNCTION : DLATCH, GATED  ACTIVE LOW / STANDARD DRIVE ( QN OUTPUT UDP )
//


   table
     //  D       GN   NOTI_REG        : Qtn :   Qtn+1

         ?      (0x)    ?             :  ?  :    -   ;
         ?      (?1)    ?             :  ?  :    -   ;

         *       1      ?             :  ?  :    -   ;

       (?0)      0      ?             :  ?  :    1   ;
       (?1)      0      ?             :  ?  :    0   ; 
        0       (10)    ?             :  ?  :    1   ;
        1       (10)    ?             :  ?  :    0   ; 

       (?1)      x      ?             :  0  :    0   ;    // Reducing pessimism.
       (?0)      x      ?             :  1  :    1   ; 

         0      (1x)    ?             :  1  :    1   ;   // Reducing pessimism.
         1      (1x)    ?             :  0  :    0   ;
         0      (x0)    ?             :  ?  :    1   ;
         1      (x0)    ?             :  ?  :    0   ;
         
         ?       ?      *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNR.v                                  -
//--------------------------------------------------------------------
      
primitive ULNR (Q, D, GN, R, NOTI_REG); 



    output Q; 
    reg    Q;                               
    input  D,              // DATA
           GN,             // CLOCK
           R,              // CLEAR ACTIVE HIGH
           NOTI_REG;        // NOTIFY REG

// FUNCTION : D-LATCH, CLEAR DIRECT (ACTIVE HIGH), GATE ACTIVE LOW 
//            STANDARD DRIVE ( Q OUTPUT UDP )



   table
     //  D      GN       R     NOTI_REG       : Qt  :   Qt+1
                     
         *      1        0      ?             :  ?  :    -   ;
                     
         ?      ?        1      ?             :  ?  :    0   ; // asynchro clear
                     
         ?     (?1)      0      ?             :  ?  :    -   ; // RAE
         ?     (0X)      0      ?             :  ?  :    -   ; // RAE
                     
         0     (X0)      0      ?             :  ?  :    0   ;
         1     (X0)      0      ?             :  ?  :    1   ;
         0     (1X)      0      ?             :  0  :    0   ;
         1     (1X)      0      ?             :  1  :    1   ;
                     
        (?0)    0        0      ?             :  ?  :    0   ;
        (?1)    0        0      ?             :  ?  :    1   ; 
         0     (10)      0      ?             :  ?  :    0   ;
         1     (10)      0      ?             :  ?  :    1   ; 
                     
         ?       1     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1       x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (1x)     x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0     (?0)      x      ?             :  ?  :    0   ; // Reducing pessimism.
        (?0)    0        x      ?             :  ?  :    0   ; // Reducing pessimism.
         0      0      (?x)     ?             :  ?  :    0   ;   // Reducing pessimism.//AB
                     
         ?      1       (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0      0       (?0)    ?             :  ?  :    0   ;
         1      0       (?0)    ?             :  ?  :    1   ;
                     
        (?1)    x        0      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)    x        0      ?             :  0  :    0   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNRB.v                                  -
//--------------------------------------------------------------------
      
primitive ULNRB (Q, D, GN, RB, NOTI_REG); 



    output Q; 
    reg    Q;                               
    input  D,               // DATA
           GN,               // CLOCK
           RB,              // CLEAR ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : D-LATCH, CLEAR DIRECT( ACTIVE LOW ), GATE ACTIVE LOW 
//             STANDARD DRIVE ( Q OUTPUT UDP )



   table
     //  D      GN       RB    NOTI_REG       : Qt  :   Qt+1
                     
         *      1        1      ?             :  ?  :    -   ;
                     
         ?      ?        0      ?             :  ?  :    0   ; // asynchro clear
                     
         ?     (?1)      ?      ?             :  ?  :    -   ; //AB
         ?     (0X)      ?      ?             :  ?  :    -   ; //AB
                     
         0     (X0)      1      ?             :  ?  :    0   ;
         1     (X0)      1      ?             :  ?  :    1   ;
         0     (1X)      1      ?             :  0  :    0   ;
         1     (1X)      1      ?             :  1  :    1   ;
                     
        (?0)    0        1      ?             :  ?  :    0   ;
        (?1)    0        1      ?             :  ?  :    1   ; 
         0     (10)      1      ?             :  ?  :    0   ;
         1     (10)      1      ?             :  ?  :    1   ; 
                     
         ?       1     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1       x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (1x)     x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0     (?0)      x      ?             :  ?  :    0   ; // Reducing pessimism.
        (?0)    0        x      ?             :  ?  :    0   ; // Reducing pessimism.
         0      0      (?x)     ?             :  ?  :    0   ;   // Reducing pessimism.//AB
                     
         ?      1       (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         0      0       (?1)    ?             :  ?  :    0   ;
         1      0       (?1)    ?             :  ?  :    1   ;
                     
        (?1)    x        1      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)    x        1      ?             :  0  :    0   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNRQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULNRQ (QN, D, GN, R, NOTI_REG); 


    output QN; 
    reg    QN;                               
    input  D,              // DATA
           GN,             // CLOCK
           R,              // CLEAR ACTIVE HIGH
           NOTI_REG;       // NOTIFY REG

// FUNCTION : D-LATCH, CLEAR DIRECT (ACTIVE HIGH), GATE ACTIVE LOW 
//            STANDARD DRIVE ( QN OUTPUT UDP )

   table
     //  D      GN       R     NOTI_REG       : QNt  :   QNt+0
                     
         *      1        0      ?             :  ?  :    -   ;
                     
         ?      ?        1      ?             :  ?  :    1   ; // asynchro clear
                     
         ?     (?1)      0      ?             :  ?  :    -   ; // RAE
         ?     (0X)      0      ?             :  ?  :    -   ; // RAE
                     
         0     (X0)      0      ?             :  ?  :    1   ;
         1     (X0)      0      ?             :  ?  :    0   ;
         0     (1X)      0      ?             :  1  :    1   ;
         1     (1X)      0      ?             :  0  :    0   ;
                     
        (?0)    0        0      ?             :  ?  :    1   ;
        (?1)    0        0      ?             :  ?  :    0   ; 
         0     (10)      0      ?             :  ?  :    1   ;
         1     (10)      0      ?             :  ?  :    0   ; 
                     
         ?       1     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?0)     x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0      (1x)     x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         0     (?0)      x      ?             :  ?  :    1   ; // Reducing pessimism.
        (?0)    0        x      ?             :  ?  :    1   ; // Reducing pessimism.
         0      0      (?x)     ?             :  ?  :    1   ;   // Reducing pessimism.//AB
                     
         ?      1       (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0      0       (?0)    ?             :  ?  :    1   ;
         1      0       (?0)    ?             :  ?  :    0   ;
                     
        (?1)    x        0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)    x        0      ?             :  1  :    1   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNRSX.v                                  -
//--------------------------------------------------------------------
      
primitive ULNRSX (Q, D, GN, R, S, NOTI_REG); 

 
 

    output Q; 
    reg    Q;                               
    input  D,               // DATA
           GN,               // CLOCK
           R,              // CLEAR ACTIVE HIGH
           S,              // SET ACTIVE HIGH
           NOTI_REG;        // NOTIFY_REG
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.  ( Q OUTPUT UDP ).


   table
     //  D       GN     RB    SB   NOTI_REG       : Qtn :   Qtn+1
                                  
         *       1      0     0     ?             :  ?  :    -   ;
                                  
         ?       ?      1     0     ?             :  ?  :    0   ; // asynchro clear
     
         ?       ?      0     1     ?             :  ?  :    1   ; 

         ?       ?      1     1     ?             :  ?  :    x   ;  // Illegal output 
                                                                    // occurs 
         ?      (?1)    ?     ?     ?             :  ?  :    -   ;  //AB
         ?      (0x)    ?     ?     ?             :  ?  :    -   ;  //AB
                                  
         0      (1x)    0     0     ?             :  0  :    0   ;
         1      (1x)    0     0     ?             :  1  :    1   ;
         0      (x0)    0     0     ?             :  ?  :    0   ;
         1      (x0)    0     0     ?             :  ?  :    1   ;
                                  
        (?0)     0      0     0     ?             :  ?  :    0   ;
        (?1)     0      0     0     ?             :  ?  :    1   ; 
         0      (10)    0     0     ?             :  ?  :    0   ;
         1      (10)    0     0     ?             :  ?  :    1   ; 
                                  
       
         ?       1     (?x)   0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       1      x    (?0)   ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1      x     0     ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     x      x     0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      *     0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (1x)    x     0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      x    (?0)   ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0      (?0)    x     0     ?             :  ?  :    0   ; // Reducing pessimism.
        (?0)     0      x     0     ?             :  ?  :    0   ; // Reducing pessimism.
         0       0     (?x)   0     ?             :  ?  :    0   ; // Reducing pessimism.//AB
         0       0      x    (?0)   ?             :  ?  :    0   ; // Reducing pessimism.//AB
     
        
         ?       1      0    (?x)   ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       1     (?0)   x     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1      0     x     ?             :  1  :    1   ;   // Reducing pessimism//AB
 
        (?1)     x      0     x     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      0     *     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (1x)    0     x     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x     (?0)   x     ?             :  1  :    1   ;   // Reducing pessimism.//AB

      
         1      (?0)    0     x     ?             :  ?  :    1   ; // Reducing pessimism.
        (?1)     0      0     x     ?             :  ?  :    1   ; // Reducing pessimism.
         1       0     (?0)   x     ?             :  ?  :    1   ; // Reducing pessimism.//AB
         1       0      0    (?x)   ?             :  ?  :    1   ; // Reducing pessimism.//AB
                                  
         ?       1     (?0)   0     ?             :  ?  :    -   ;   // ignore edge on clear
         0       0     (?0)   0     ?             :  ?  :    0   ;   // pessimism .
         1       0     (?0)   0     ?             :  ?  :    1   ;  

                                  
         ?       1      0    (?0)   ?             :  ?  :    -   ;   // ignore edge on set
         0       0      0    (?0)   ?             :  ?  :    0   ;   // pessimism .
         1       0      0    (?0)   ?             :  ?  :    1   ;  

        (?1)     x      0     0     ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     x      0     0     ?             :  0  :    0   ; // Reducing pessimism.
                                  
         ?       ?      ?     ?     *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNRSXQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULNRSXQ (QN, D, GN, R, S, NOTI_REG); 

 
 

    output QN; 
    reg    QN;                               
    input  D,               // DATA
           GN,               // CLOCK
           R,              // CLEAR ACTIVE HIGH
           S,              // SET ACTIVE HIGH
           NOTI_REG;        // NOTIFY_REG
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.  ( QN OUTPUT UDP ).


   table
     //  D       GN     RB    SB   NOTI_REG       : QNtn :   QNtn+0
                                  
         *       1      0     0     ?             :  ?  :    -   ;
                                  
         ?       ?      1     0     ?             :  ?  :    1   ; // asynchro clear
     
         ?       ?      0     1     ?             :  ?  :    0   ; 

         ?       ?      1     1     ?             :  ?  :    x   ;  // Illegal output 
                                                                    // occurs 
         ?      (?1)    ?     ?     ?             :  ?  :    -   ;  //AB
         ?      (0x)    ?     ?     ?             :  ?  :    -   ;  //AB
                                  
         0      (1x)    0     0     ?             :  1  :    1   ;
         1      (1x)    0     0     ?             :  0  :    0   ;
         0      (x0)    0     0     ?             :  ?  :    1   ;
         1      (x0)    0     0     ?             :  ?  :    0   ;
                                  
        (?0)     0      0     0     ?             :  ?  :    1   ;
        (?1)     0      0     0     ?             :  ?  :    0   ; 
         0      (10)    0     0     ?             :  ?  :    1   ;
         1      (10)    0     0     ?             :  ?  :    0   ; 
                                  
       
         ?       1     (?x)   0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       1      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1      x     0     ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?0)     x      x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      *     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0      (1x)    x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB

         0      (?0)    x     0     ?             :  ?  :    1   ; // Reducing pessimism.
        (?0)     0      x     0     ?             :  ?  :    1   ; // Reducing pessimism.
         0       0     (?x)   0     ?             :  ?  :    1   ; // Reducing pessimism.//AB
         0       0      x    (?0)   ?             :  ?  :    1   ; // Reducing pessimism.//AB
     
        
         ?       1      0    (?x)   ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       1     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1      0     x     ?             :  0  :    0   ;   // Reducing pessimism//AB
 
        (?1)     x      0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x      0     *    ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1      (1x)    0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB

      
         1      (?0)    0     x     ?             :  ?  :    0   ; // Reducing pessimism.
        (?1)     0      0     x     ?             :  ?  :    0   ; // Reducing pessimism.
         1       0     (?0)   x     ?             :  ?  :    0   ; // Reducing pessimism.//AB
         1       0      0    (?x)   ?             :  ?  :    0   ; // Reducing pessimism.//AB
                                  
         ?       1     (?0)   0     ?             :  ?  :    -   ;   // ignore edge on clear
         0       0     (?0)   0     ?             :  ?  :    1   ;   // pessimism .
         1       0     (?0)   0     ?             :  ?  :    0   ;  

                                  
         ?       1      0    (?0)   ?             :  ?  :    -   ;   // ignore edge on set
         0       0      0    (?0)   ?             :  ?  :    1   ;   // pessimism .
         1       0      0    (?0)   ?             :  ?  :    0   ;  

        (?1)     x      0     0     ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0     0     ?             :  1  :    1   ; // Reducing pessimism.
                                  
         ?       ?      ?     ?     *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNS.v                                  -
//--------------------------------------------------------------------
      
primitive ULNS (Q, D, GN, S, NOTI_REG); 

 

    output Q; 
    reg    Q;                               
    input  D,               // DATA
           GN,              // CLOCK
           S,               // SET ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( Q OUTPUT UDP ).


   table
     //  D      GN       S     NOTI_REG       : Qt  :   Qt+1
                     
         *      1        0      ?             :  ?  :    -   ;
                     
         ?      ?        1      ?             :  ?  :    1   ; // asynchro SET
                     
         ?     (?1)      0      ?             :  ?  :    -   ; // RAE
         ?     (0X)      0      ?             :  ?  :    -   ; // RAE
                     
         0     (X0)      0      ?             :  ?  :    0   ;
         1     (X0)      0      ?             :  ?  :    1   ;
         0     (1X)      0      ?             :  0  :    0   ;
         1     (1X)      0      ?             :  1  :    1   ;
                     
        (?0)    0        0      ?             :  ?  :    0   ;
        (?1)    0        0      ?             :  ?  :    1   ; 
         0     (10)      0      ?             :  ?  :    0   ;
         1     (10)      0      ?             :  ?  :    1   ; 
                     
       
         ?       1     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?1)     x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (1x)     x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1     (?0)      x      ?             :  ?  :    1   ; // Reducing pessimism.
        (?1)    0        x      ?             :  ?  :    1   ; // Reducing pessimism.
         1      0       (?x)    ?             :  ?  :    1   ; // Reducing pessimism.
                     
         ?      1       (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0      0       (?0)    ?             :  ?  :    0   ;
         1      0       (?0)    ?             :  ?  :    1   ;
                     
        (?1)    x        0      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)    x        0      ?             :  0  :    0   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNSB.v                                  -
//--------------------------------------------------------------------
      
primitive ULNSB (Q, D, GN, SB, NOTI_REG); 

 
 
 

    output Q; 
    reg    Q;                               
    input  D,               // DATA
           GN,               // CLOCK
           SB,              // SET ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( Q OUTPUT UDP ).


   table
     //  D      GN       SB    NOTI_REG       : Qt  :   Qt+1
                     
         *      1        1      ?             :  ?  :    -   ;
                     
         ?      ?        0      ?             :  ?  :    1   ; // asynchro SET
                     
         ?     (?1)      ?      ?             :  ?  :    -   ; //AB
         ?     (0X)      ?      ?             :  ?  :    -   ; //AB
                     
         0     (X0)      1      ?             :  ?  :    0   ;
         1     (X0)      1      ?             :  ?  :    1   ;
         0     (1X)      1      ?             :  0  :    0   ;
         1     (1X)      1      ?             :  1  :    1   ;
                     
        (?0)    0        1      ?             :  ?  :    0   ;
        (?1)    0        1      ?             :  ?  :    1   ; 
         0     (10)      1      ?             :  ?  :    0   ;
         1     (10)      1      ?             :  ?  :    1   ; 
                     
       
         ?       1     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?1)     x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (1x)     x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1     (?0)      x      ?             :  ?  :    1   ; // Reducing pessimism.
        (?1)    0        x      ?             :  ?  :    1   ; // Reducing pessimism.
         1      0       (?x)    ?             :  ?  :    1   ; // Reducing pessimism.
                     
         ?      1       (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         0      0       (?1)    ?             :  ?  :    0   ;
         1      0       (?1)    ?             :  ?  :    1   ;
                     
        (?1)    x        1      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)    x        1      ?             :  0  :    0   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULNSBQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULNSBQ (QN, D, GN, SB, NOTI_REG); 

 
 
 

    output QN; 
    reg    QN;                               
    input  D,               // DATA
           GN,               // CLOCK
           SB,              // SET ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : NEGATIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( QN OUTPUT UDP ).


   table
     //  D      GN       SB    NOTI_REG       : QNt  :   QNt+0
                     
         *      1        1      ?             :  ?  :    -   ;
                     
         ?      ?        0      ?             :  ?  :    0   ; // asynchro SET
                     
         ?     (?1)      ?      ?             :  ?  :    -   ; //AB
         ?     (0X)      ?      ?             :  ?  :    -   ; //AB
                     
         0     (X0)      1      ?             :  ?  :    1   ;
         1     (X0)      1      ?             :  ?  :    0   ;
         0     (1X)      1      ?             :  1  :    1   ;
         1     (1X)      1      ?             :  0  :    0   ;
                     
        (?0)    0        1      ?             :  ?  :    1   ;
        (?1)    0        1      ?             :  ?  :    0   ; 
         0     (10)      1      ?             :  ?  :    1   ;
         1     (10)      1      ?             :  ?  :    0   ; 
                     
       
         ?       1     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1       x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?1)     x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1      (1x)     x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         1     (?0)      x      ?             :  ?  :    0   ; // Reducing pessimism.
        (?1)    0        x      ?             :  ?  :    0   ; // Reducing pessimism.
         1      0       (?x)    ?             :  ?  :    0   ; // Reducing pessimism.
                     
         ?      1       (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         0      0       (?1)    ?             :  ?  :    1   ;
         1      0       (?1)    ?             :  ?  :    0   ;
                     
        (?1)    x        1      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)    x        1      ?             :  1  :    1   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULP.v                                  -
//--------------------------------------------------------------------
      
primitive ULP (Q, D, G, NOTI_REG); 

 
 
 

    output Q; 
    reg    Q;                               
    input  D,              // data
           G,              // clock
           NOTI_REG;       
// FUNCTION : DLATCH, GATED  STANDARD DRIVE / ACTIVE HIGH ( Q OUTPUT UDP )
//


   table
     //  D       G    NOTI_REG        : Qtn :   Qtn+1

         *       0      ?             :  ?  :    -   ;

         ?      (?0)    ?             :  ?  :    -   ;
         ?      (1x)    ?             :  ?  :    -   ;

         0      (0x)    ?             :  0  :    0   ;
         1      (0x)    ?             :  1  :    1   ;
         0      (x1)    ?             :  ?  :    0   ;
         1      (x1)    ?             :  ?  :    1   ;

        (?0)     1      ?             :  ?  :    0   ;
        (?1)     1      ?             :  ?  :    1   ; 
         0      (01)    ?             :  ?  :    0   ;
         1      (01)    ?             :  ?  :    1   ; 

        (?1)     x      ?             :  1  :    1   ;    // Reducing pessimism.
        (?0)     x      ?             :  0  :    0   ; 
         
         ?       ?      *             :  ?  :    x   ;


   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULPQ (QN, D, G, NOTI_REG); 

 

    output QN; 
    reg    QN;                               
    input  D,              // data
           G,              // clock
           NOTI_REG;       // NOTIFY REG
// FUNCTION : D-LATCH, GATED  STANDARD DRIVE / ACTIVE HIGH ( QN OUTPUT UDP )
//


   table
     //  D       G    NOTI_REG        : Qtn :   Qtn+1

         *       0      ?             :  ?  :    -   ;

         ?      (?0)    ?             :  ?  :    -   ;
         ?      (1x)    ?             :  ?  :    -   ;

         0      (0x)    ?             :  1  :    1   ;
         1      (0x)    ?             :  0  :    0   ;
         0      (x1)    ?             :  ?  :    1   ;
         1      (x1)    ?             :  ?  :    0   ;

        (?0)     1      ?             :  ?  :    1   ;
        (?1)     1      ?             :  ?  :    0   ; 
         0      (01)    ?             :  ?  :    1   ;
         1      (01)    ?             :  ?  :    0   ; 

        (?1)     x      ?             :  0  :    0   ;    // Reducing pessimism.
        (?0)     x      ?             :  1  :    1   ; 
         
         ?       ?      *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPR.v                                  -
//--------------------------------------------------------------------
      
primitive ULPR (Q, D, G, R, NOTI_REG); 

 

    output Q; 
    reg    Q;                               
    input  D,               // DATA
           G,               // CLOCK
           R,              // CLEAR ACTIVE HIGH
           NOTI_REG;        // NOTIFY REG
// FUNCTION : D-LATCH, GATED  CLEAR DIRECT /GATE ACTIVE HIGH ( Q OUTPUT UDP ) 
//


   table
     //  D       G      R    NOTI_REG       : Qt  :   Qt+1

         *       0      0      ?             :  ?  :    -   ;

         ?       ?      1      ?             :  ?  :    0   ; // asynchro clear

         ?      (?0)    0      ?             :  ?  :    -   ; //RAE
         ?      (1x)    0      ?             :  ?  :    -   ; //RAE

         0      (0x)    0      ?             :  0  :    0   ;
         1      (0x)    0      ?             :  1  :    1   ;
         0      (x1)    0      ?             :  ?  :    0   ;
         1      (x1)    0      ?             :  ?  :    1   ;

        (?0)     1      0      ?             :  ?  :    0   ;
        (?1)     1      0      ?             :  ?  :    1   ; 
         0      (01)    0      ?             :  ?  :    0   ;
         1      (01)    0      ?             :  ?  :    1   ; 

         ?       0     (?x)    ?             :  0  :    0   ;
         *       0      x      ?             :  0  :    0   ;

        (?0)     x      x      ?             :  0  :    0   ;   
         0       x      *      ?             :  0  :    0   ;   
         0      (0x)    x      ?             :  0  :    0   ;  
         
         0      (?1)    x      ?             :  ?  :    0   ;  
        (?0)     1      x      ?             :  ?  :    0   ;   
         0       1     (?x)    ?             :  ?  :    0   ;  

         ?       0     (?0)    ?             :  ?  :    -   ; 
         0       1     (?0)    ?             :  ?  :    0   ;
         1       1     (?0)    ?             :  ?  :    1   ;  

        (?1)     x      0      ?             :  1  :    1   ;
        (?0)     x      0      ?             :  0  :    0   ; 
         
         ?       ?      ?      *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPRB.v                                  -
//--------------------------------------------------------------------
      
primitive ULPRB (Q, D, G, RB, NOTI_REG); 

 

    output Q; 
    reg    Q;                               
    input  D,               // DATA
           G,               // CLOCK
           RB,              // CLEAR ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : D-LATCH, GATED  CLEAR DIRECT /GATE ACTIVE HIGH ( Q OUTPUT UDP ) 
//


   table
     //  D       G      RB    NOTI_REG       : Qt  :   Qt+1

         *       0      1      ?             :  ?  :    -   ;

         ?       ?      0      ?             :  ?  :    0   ; // asynchro clear

         ?      (?0)    ?      ?             :  ?  :    -   ; //AB
         ?      (1x)    ?      ?             :  ?  :    -   ; //AB

         0      (0x)    1      ?             :  0  :    0   ;
         1      (0x)    1      ?             :  1  :    1   ;
         0      (x1)    1      ?             :  ?  :    0   ;
         1      (x1)    1      ?             :  ?  :    1   ;

        (?0)     1      1      ?             :  ?  :    0   ;
        (?1)     1      1      ?             :  ?  :    1   ; 
         0      (01)    1      ?             :  ?  :    0   ;
         1      (01)    1      ?             :  ?  :    1   ; 

         ?       0     (?x)    ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       0      x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     x      x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (0x)    x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         
         0      (?1)    x      ?             :  ?  :    0   ;   // Reducing pessimism.
        (?0)     1      x      ?             :  ?  :    0   ;   // Reducing pessimism.
         0       1     (?x)    ?             :  ?  :    0   ;   // Reducing pessimism.//AB

         ?       0     (?1)    ?             :  ?  :    -   ;   // ignore edge on clear
         0       1     (?1)    ?             :  ?  :    0   ;   // pessimism .
         1       1     (?1)    ?             :  ?  :    1   ;  

        (?1)     x      1      ?             :  1  :    1   ;   // Reducing pessimism.
        (?0)     x      1      ?             :  0  :    0   ;   // Reducing pessimism.
         
         ?       ?      ?      *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPRQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULPRQ (QN, D, G, R, NOTI_REG); 


    output QN; 
    reg    QN;                               
    input  D,               // DATA
           G,               // CLOCK
           R,               // CLEAR ACTIVE HIGH
           NOTI_REG;        // NOTIFY REG
// FUNCTION : D-LATCH, GATED  CLEAR DIRECT /GATE ACTIVE HIGH ( QN OUTPUT UDP ) 


   table

     //  D       G      R    NOTI_REG        : QNt  :   QNt+0

         *       0      0      ?             :  ?  :    -   ;

         ?       ?      1      ?             :  ?  :    1   ; // asynchro clear

         ?      (?0)    0      ?             :  ?  :    -   ; // RAE
         ?      (1x)    0      ?             :  ?  :    -   ; // RAE

         0      (0x)    0      ?             :  1  :    1   ;
         1      (0x)    0      ?             :  0  :    0   ;
         0      (x1)    0      ?             :  ?  :    1   ;
         1      (x1)    0      ?             :  ?  :    0   ;

        (?0)     1      0      ?             :  ?  :    1   ;
        (?1)     1      0      ?             :  ?  :    0   ; 
         0      (01)    0      ?             :  ?  :    1   ;
         1      (01)    0      ?             :  ?  :    0   ; 

         ?       0     (?x)    ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       0      x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?0)     x      x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0      (0x)    x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         
         0      (?1)    x      ?             :  ?  :    1   ;   // Reducing pessimism.
        (?0)     1      x      ?             :  ?  :    1   ;   // Reducing pessimism.
         0       1     (?x)    ?             :  ?  :    1   ;   // Reducing pessimism.//AB

         ?       0     (?0)    ?             :  ?  :    -   ;   // ignore edge on clear
         0       1     (?0)    ?             :  ?  :    1   ;   // pessimism .
         1       1     (?0)    ?             :  ?  :    0   ;  

        (?1)     x      0      ?             :  0  :    0   ;   // Reducing pessimism.
        (?0)     x      0      ?             :  1  :    1   ;   // Reducing pessimism.
         
         ?       ?      ?      *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPRSX.v                                  -
//--------------------------------------------------------------------
      
primitive ULPRSX (Q, D, G, R, S, NOTI_REG); 

 
 

    output Q; 
    reg    Q;                               
    input  D,               // DATA
           G,               // CLOCK
           R,              // CLEAR ACTIVE HIGH
           S,              // SET ACTIVE HIGH
           NOTI_REG;        // NOTIFY_REG
// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.  ( Q OUTPUT UDP ).


   table
     //  D       G     RB    SB   NOTI_REG       : Qtn :   Qtn+1
                                  
         *       0      0     0     ?             :  ?  :    -   ;
                                  
         ?       ?      1     0     ?             :  ?  :    0   ; // asynchro clear
     
         ?       ?      0     1     ?             :  ?  :    1   ; 

         ?       ?      1     1     ?             :  ?  :    x   ;  // Illegal output 
                                                                    // occurs 
         ?      (?0)    ?     ?     ?             :  ?  :    -   ;  //AB
         ?      (1x)    ?     ?     ?             :  ?  :    -   ;  //AB
                                  
         0      (0x)    0     0     ?             :  0  :    0   ;
         1      (0x)    0     0     ?             :  1  :    1   ;
         0      (x1)    0     0     ?             :  ?  :    0   ;
         1      (x1)    0     0     ?             :  ?  :    1   ;
                                  
        (?0)     1      0     0     ?             :  ?  :    0   ;
        (?1)     1      0     0     ?             :  ?  :    1   ; 
         0      (01)    0     0     ?             :  ?  :    0   ;
         1      (01)    0     0     ?             :  ?  :    1   ; 
                                  
       
         ?       0     (?x)   0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       0      x    (?0)   ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       0      x     0     ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     x      x     0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      *     0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (0x)    x     0     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      x    (?0)   ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0      (?1)    x     0     ?             :  ?  :    0   ; // Reducing pessimism.
        (?0)     1      x     0     ?             :  ?  :    0   ; // Reducing pessimism.
         0       1     (?x)   0     ?             :  ?  :    0   ; // Reducing pessimism.//AB
         0       1      x    (?0)   ?             :  ?  :    0   ; // Reducing pessimism.//AB
     
        
         ?       0      0    (?x)   ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       0     (?0)   x     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       0      0     x     ?             :  1  :    1   ;   // Reducing pessimism//AB
 
        (?1)     x      0     x     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      0     *     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (0x)    0     x     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x     (?0)   x     ?             :  1  :    1   ;   // Reducing pessimism.//AB

      
         1      (?1)    0     x     ?             :  ?  :    1   ; // Reducing pessimism.
        (?1)     1      0     x     ?             :  ?  :    1   ; // Reducing pessimism.
         1       1     (?0)   x     ?             :  ?  :    1   ; // Reducing pessimism.//AB
         1       1      0    (?x)   ?             :  ?  :    1   ; // Reducing pessimism.//AB
                                  
         ?       0     (?0)   0     ?             :  ?  :    -   ;   // ignore edge on clear
         0       1     (?0)   0     ?             :  ?  :    0   ;   // pessimism .
         1       1     (?0)   0     ?             :  ?  :    1   ;  

                                  
         ?       0      0    (?0)   ?             :  ?  :    -   ;   // ignore edge on set
         0       1      0    (?0)   ?             :  ?  :    0   ;   // pessimism .
         1       1      0    (?0)   ?             :  ?  :    1   ;  

        (?1)     x      0     0     ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     x      0     0     ?             :  0  :    0   ; // Reducing pessimism.
                                  
         ?       ?      ?     ?     *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPRSXQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULPRSXQ (QN, D, G, R, S, NOTI_REG); 

 
 

    output QN; 
    reg    QN;                               
    input  D,               // DATA
           G,               // CLOCK
           R,              // CLEAR ACTIVE HIGH
           S,              // SET ACTIVE HIGH
           NOTI_REG;        // NOTIFY_REG
// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET AND RESET.  ( QN OUTPUT UDP ).


   table
     //  D       G     RB    SB   NOTI_REG       : QNtn :   QNtn+0
                                  
         *       0      0     0     ?             :  ?  :    -   ;
                                  
         ?       ?      1     0     ?             :  ?  :    1   ; // asynchro clear
     
         ?       ?      0     1     ?             :  ?  :    0   ; 

         ?       ?      1     1     ?             :  ?  :    x   ;  // Illegal output 
                                                                    // occurs 
         ?      (?0)    ?     ?     ?             :  ?  :    -   ;  //AB
         ?      (1x)    ?     ?     ?             :  ?  :    -   ;  //AB
                                  
         0      (0x)    0     0     ?             :  1  :    1   ;
         1      (0x)    0     0     ?             :  0  :    0   ;
         0      (x1)    0     0     ?             :  ?  :    1   ;
         1      (x1)    0     0     ?             :  ?  :    0   ;
                                  
        (?0)     1      0     0     ?             :  ?  :    1   ;
        (?1)     1      0     0     ?             :  ?  :    0   ; 
         0      (01)    0     0     ?             :  ?  :    1   ;
         1      (01)    0     0     ?             :  ?  :    0   ; 
                                  
       
         ?       0     (?x)   0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       0      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       0      x     0     ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?0)     x      x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      *     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0      (0x)    x     0     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         0       x      x    (?0)   ?             :  1  :    1   ;   // Reducing pessimism.//AB

         0      (?1)    x     0     ?             :  ?  :    1   ; // Reducing pessimism.
        (?0)     1      x     0     ?             :  ?  :    1   ; // Reducing pessimism.
         0       1     (?x)   0     ?             :  ?  :    1   ; // Reducing pessimism.//AB
         0       1      x    (?0)   ?             :  ?  :    1   ; // Reducing pessimism.//AB
     
        
         ?       0      0    (?x)   ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       0     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       0      0     x     ?             :  0  :    0   ;   // Reducing pessimism//AB
 
        (?1)     x      0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x      0     *     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1      (0x)    0     x     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x     (?0)   x     ?             :  0  :    0   ;   // Reducing pessimism.//AB

      
         1      (?1)    0     x     ?             :  ?  :    0   ; // Reducing pessimism.
        (?1)     1      0     x     ?             :  ?  :    0   ; // Reducing pessimism.
         1       1     (?0)   x     ?             :  ?  :    0   ; // Reducing pessimism.//AB
         1       1      0    (?x)   ?             :  ?  :    0   ; // Reducing pessimism.//AB
                                  
         ?       0     (?0)   0     ?             :  ?  :    -   ;   // ignore edge on clear
         0       1     (?0)   0     ?             :  ?  :    1   ;   // pessimism .
         1       1     (?0)   0     ?             :  ?  :    0   ;  

                                  
         ?       0      0    (?0)   ?             :  ?  :    -   ;   // ignore edge on set
         0       1      0    (?0)   ?             :  ?  :    1   ;   // pessimism .
         1       1      0    (?0)   ?             :  ?  :    0   ;  

        (?1)     x      0     0     ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0     0     ?             :  1  :    1   ; // Reducing pessimism.
                                  
         ?       ?      ?     ?     *             :  ?  :    x   ;

   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPS.v                                  -
//--------------------------------------------------------------------
      
primitive ULPS (Q, D, G, S, NOTI_REG); 


    output Q; 
    reg    Q;                               
    input  D,               // DATA
           G,               // CLOCK
           S,               // SET ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE HIGH
//            ASYNCHRONOUS SET ( Q OUTPUT UDP ).


   table
     //  D      G        S     NOTI_REG       : Qt  :   Qt+1
                     
         *      0        0      ?             :  ?  :    -   ;
                     
         ?      ?        1      ?             :  ?  :    1   ; // asynchro SET
                     
         ?     (?0)      0      ?             :  ?  :    -   ; // RAE
         ?     (1X)      0      ?             :  ?  :    -   ; // RAE
                     
         0     (X1)      0      ?             :  ?  :    0   ;
         1     (X1)      0      ?             :  ?  :    1   ;
         0     (0X)      0      ?             :  0  :    0   ;
         1     (0X)      0      ?             :  1  :    1   ;
                     
        (?0)    1        0      ?             :  ?  :    0   ;
        (?1)    1        0      ?             :  ?  :    1   ; 
         0     (01)      0      ?             :  ?  :    0   ;
         1     (01)      0      ?             :  ?  :    1   ; 
                     
       
         ?       0     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       0       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?1)     x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (0x)     x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1     (?1)      x      ?             :  ?  :    1   ; // Reducing pessimism.
        (?1)    1        x      ?             :  ?  :    1   ; // Reducing pessimism.
         1      1       (?x)    ?             :  ?  :    1   ; // Reducing pessimism.
                     
         ?      0       (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0      1       (?0)    ?             :  ?  :    0   ;
         1      1       (?0)    ?             :  ?  :    1   ;
                     
        (?1)    x        0      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)    x        0      ?             :  0  :    0   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPSB.v                                  -
//--------------------------------------------------------------------
      
primitive ULPSB (Q, D, G, SB, NOTI_REG); 


    output Q; 
    reg    Q;                               
    input  D,               // DATA
           G,               // CLOCK
           SB,              // SET ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( Q OUTPUT UDP ).


   table
     //  D      G       SB    NOTI_REG       : Qt  :   Qt+1
                     
         *      0        1      ?             :  ?  :    -   ;
                     
         ?      ?        0      ?             :  ?  :    1   ; // asynchro SET
                     
         ?     (?0)      ?      ?             :  ?  :    -   ; //AB
         ?     (1X)      ?      ?             :  ?  :    -   ; //AB
                     
         0     (X1)      1      ?             :  ?  :    0   ;
         1     (X1)      1      ?             :  ?  :    1   ;
         0     (0X)      1      ?             :  0  :    0   ;
         1     (0X)      1      ?             :  1  :    1   ;
                     
        (?0)    1        1      ?             :  ?  :    0   ;
        (?1)    1        1      ?             :  ?  :    1   ; 
         0     (01)      1      ?             :  ?  :    0   ;
         1     (01)      1      ?             :  ?  :    1   ; 
                     
       
         ?       0     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       0       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?1)     x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (0x)     x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1     (?1)      x      ?             :  ?  :    1   ; // Reducing pessimism.
        (?1)    1        x      ?             :  ?  :    1   ; // Reducing pessimism.
         1      1       (?x)    ?             :  ?  :    1   ; // Reducing pessimism.
                     
         ?      0       (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         0      1       (?1)    ?             :  ?  :    0   ;
         1      1       (?1)    ?             :  ?  :    1   ;
                     
        (?1)    x        1      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)    x        1      ?             :  0  :    0   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  ULPSBQ.v                                  -
//--------------------------------------------------------------------
      
primitive ULPSBQ (QN, D, G, SB, NOTI_REG); 


    output QN; 
    reg    QN;                               
    input  D,               // DATA
           G,               // CLOCK
           SB,              // SET ACTIVE LOW
           NOTI_REG;        // NOTIFY REG
// FUNCTION : POSITIVE LEVEL SENSITIVE D-TYPE LATCH WITH ACTIVE LOW
//            ASYNCHRONOUS SET ( QN OUTPUT UDP ).


   table
     //  D      G       SB    NOTI_REG       : QNt  :   QNt+0
                     
         *      0        1      ?             :  ?  :    -   ;
                     
         ?      ?        0      ?             :  ?  :    0   ; // asynchro SET
                     
         ?     (?0)      ?      ?             :  ?  :    -   ; //AB
         ?     (1X)      ?      ?             :  ?  :    -   ; //AB
                     
         0     (X1)      1      ?             :  ?  :    1   ;
         1     (X1)      1      ?             :  ?  :    0   ;
         0     (0X)      1      ?             :  1  :    1   ;
         1     (0X)      1      ?             :  0  :    0   ;
                     
        (?0)    1        1      ?             :  ?  :    1   ;
        (?1)    1        1      ?             :  ?  :    0   ; 
         0     (01)      1      ?             :  ?  :    1   ;
         1     (01)      1      ?             :  ?  :    0   ; 
                     
       
         ?       0     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       0       x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?1)     x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1       x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         1      (0x)     x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         1     (?1)      x      ?             :  ?  :    0   ; // Reducing pessimism.
        (?1)    1        x      ?             :  ?  :    0   ; // Reducing pessimism.
         1      1       (?x)    ?             :  ?  :    0   ; // Reducing pessimism.
                     
         ?      0       (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         0      1       (?1)    ?             :  ?  :    1   ;
         1      1       (?1)    ?             :  ?  :    0   ;
                     
        (?1)    x        1      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)    x        1      ?             :  1  :    1   ; // Reducing pessimism.
                     
         ?      ?        ?      *             :  ?  :    x   ;
                     
   endtable

endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_AND4_B.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AND4_B (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	0	1	1	:	1	;
		?	?	0	?	:	0	;
		?	?	?	0	:	0	;
		1	?	?	?	:	0	;
		?	1	?	?	:	0	;

	endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_AOI_2B.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AOI_2B (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		?	0	1	0	:	1	;
		1	?	1	0	:	1	;
		0	1	?	?	:	0	;
		?	?	0	?	:	0	;
		?	?	?	1	:	0	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_AOI_4.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AOI_4 (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	?	0	?	:	1	;
		?	0	0	?	:	1	;
		0	?	?	0	:	1	;
		?	0	?	0	:	1	;
		?	?	1	1	:	0	;
		1	1	?	?	:	0	;

	endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_AO_1A.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AO_1A (Y, A, B, C);
	output Y;
	input  A, B, C;

	table
	//	A	B	C	:	Y

		?	0	0	:	0	;
		0	1	?	:	1	;
		1	?	0	:	0	;
		?	?	1	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_AO_1B.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AO_1B (Y, A, B, C);
	output Y;
	input  A, B, C;

	table
	//	A	B	C	:	Y

		0	?	1	:	0	;
		?	0	1	:	0	;
		1	1	?	:	1	;
		?	?	0	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_AO_3A.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AO_3A (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		1	1	1	?	:	1	;
		?	0	?	0	:	0	;
		?	?	0	0	:	0	;
		0	?	?	0	:	0	;
		?	?	?	1	:	1	;

	endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_AO_4A.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AO_4A (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	1	1	?	:	1	;
		?	1	1	1	:	1	;
		1	?	1	1	:	1	;
		0	0	?	?	:	0	;
		?	0	?	0	:	0	;
		1	?	?	0	:	0	;
		?	?	0	?	:	0	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_AO_5A.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AO_5A (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	0	?	0	:	0	;
		?	0	0	0	:	0	;
		1	?	0	0	:	0	;
		0	1	?	?	:	1	;
		1	?	1	?	:	1	;
		?	1	1	?	:	1	;
		?	?	?	1	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_AX_1.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AX_1 (Y, A, B, C);
	output Y;
	input  A, B, C;

	table
	//	A	B	C	:	Y

		0	1	0	:	1	;
		0	1	1	:	0	;
		?	0	0	:	0	;
		?	0	1	:	1	;
		1	?	0	:	0	;
		1	?	1	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE (Q, D, G, E, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D,  G, E;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ( Q OUTPUT UDP ) .


    table
//   D    G       E      NOTIFIER_REG      :  Qt  :  Qt+1
                      
     1  (?1)      1             ?          :  ?   :   1; 
     1  (0x)      1             ?          :  1   :   1; //AB
     1    1      (?1)           ?          :  ?   :   1;
     1    1      (0x)           ?          :  1   :   1; //AB
     
     0  (?1)      1             ?          :  ?   :   0;
     0  (0x)      1             ?          :  0   :   0; //AB
     0    1      (?1)           ?          :  ?   :   0;
     0    1      (0x)           ?          :  0   :   0; //AB
    
    (?1)  1       1             ?          :  ?   :   1;
    (?0)  1       1             ?          :  ?   :   0;

     *    0       ?             ?          :  ?   :   -;
     *    ?       0             ?          :  ?   :   -;

   (?1)   ?       ?             ?          :  1   :   1;   // Reducing Pessimism
   (?0)   ?       ?             ?          :  0   :   0;
  
     ?    n       ?             ?          :  ?   :   -;  
     ?    p       0             ?          :  ?   :   -;  
     ?    0       p             ?          :  ?   :   -;  
     ?    ?       n             ?          :  ?   :   -;  
     ?    ?       ?             *          :  ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE1D.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE1D (QN, D, ACLK, BCLK, NOTIFIER_REG); 

    output QN; 

    input  NOTIFIER_REG,
           D,  ACLK, BCLK;

    reg    QN;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ( QN OUTPUT UDP ) .


    table
//   D   ACLK      BCLK      NOTIFIER_REG  :  QNt  :  QNt+0
                      
     1  (?0)      0             ?          :  ?   :   0;
     1  (1x)      0             ?          :  0   :   0;
     1    0      (?0)           ?          :  ?   :   0;
     1    0      (1x)           ?          :  0   :   0;
     0  (?0)      0             ?          :  ?   :   1;
     0  (1x)      0             ?          :  1   :   1;
     0    0      (?0)           ?          :  ?   :   1;
     0    0      (1x)           ?          :  1   :   1;
    
    (?1)  0       0             ?          :  ?   :   0;
    (?0)  0       0             ?          :  ?   :   1;

     *    1       ?             ?          :  ?   :   -;
     *    ?       1             ?          :  ?   :   -;

   (?1)   ?       ?             ?          :  0   :   0;   // Reducing Pessimism
   (?0)   ?       ?             ?          :  1   :   1;
  
     ?    p       ?             ?          :  ?   :   -;  
     ?    n       1             ?          :  ?   :   -;  
     ?    1       n             ?          :  ?   :   -;  
     ?    ?       p             ?          :  ?   :   -;  
     ?    ?       ?             *          :  ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE2A.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE2A (Q, D, G, E, R, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D,  G, E, R;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS  AND RESET ( Q OUTPUT UDP ) .


    table
//       D       G      E      R   NOTIFIER_REG      :  Qt  :  Qt+1
                      
         *       1      ?      0       ?             :  ?  :    -   ;
         *       ?      0      0       ?             :  ?  :    -   ;

         ?       ?      ?      1       ?             :  ?  :    0   ;

         ?      (?1)    ?      ?       ?             :  ?  :    -   ;
         ?      (0x)    ?      ?       ?             :  ?  :    -   ; //AB
         ?       ?    (?0)     ?       ?             :  ?  :    -   ;
         ?       ?    (1x)     ?       ?             :  ?  :    -   ; //AB
      
         0      (1x)    1      0       ?             :  0  :    0   ;
         1      (1x)    1      0       ?             :  1  :    1   ;
         0      (x0)    1      0       ?             :  ?  :    0   ;
         1      (x0)    1      0       ?             :  ?  :    1   ;

         0       0    (0x)     0       ?             :  0  :    0   ;
         1       0    (0x)     0       ?             :  1  :    1   ;
         0       0    (x1)     0       ?             :  ?  :    0   ;
         1       0    (x1)     0       ?             :  ?  :    1   ;

        (?0)     0      1      0       ?             :  ?  :    0   ;
        (?1)     0      1      0       ?             :  ?  :    1   ;

         0     (10)     1      0       ?             :  ?  :    0   ;
         0       0     (01)    0       ?             :  ?  :    0   ;
         1     (10)     1      0       ?             :  ?  :    1   ;
         1       0     (01)    0       ?             :  ?  :    1   ;

         ?       1      ?     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       ?      0     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1      ?       x      ?             :  0  :    0   ;   // Reducing pessimism//AB
         *       ?      0       x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     0      x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
        (?0)     x      1       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
        (?0)     x      x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0       0      x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      1       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0       0    (0x)      x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (1x)    1       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0      (?0)    1       x      ?             :  ?  :    0   ; // Reducing pessimism.
         0       0     (?1)     x      ?             :  ?  :    0   ; // Reducing pessimism.

        (?0)     0      1       x      ?             :  ?  :    0   ; // Reducing pessimism.
         0       0      1      (?x)    ?             :  ?  :    0   ;   // Reducing pessimism.//AB
 
         ?       1      ?      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         ?       ?      0      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0       0      1      (?0)    ?             :  ?  :    0   ;
         1       0      1      (?0)    ?             :  ?  :    1   ;
 
        (?1)     0      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      1       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     0      x       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      1       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      x       0      ?             :  0  :    0   ; // Reducing pessimism.
 
         ?       n      0       ?      ?             :  ?  :    -   ;
         ?       1      p       ?      ?             :  ?  :    -   ;
         ?       ?      ?       ?      *             :  ?  :    x   ;
 
    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE2B.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE2B (Q, D, G, E, R, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D,  G, E, R;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS  AND RESET ( Q OUTPUT UDP ) .

    table
//       D       G      E      R   NOTIFIER_REG      :  Qt  :  Qt+1
                      
         *       1      ?      1       ?             :  ?  :    -   ;
         *       ?      1      1       ?             :  ?  :    -   ;

         ?       ?      ?      0       ?             :  ?  :    0   ;

         ?      (?1)    ?      ?       ?             :  ?  :    -   ;
         ?      (0x)    ?      ?       ?             :  ?  :    -   ; 
         ?       ?    (?1)     ?       ?             :  ?  :    -   ;
         ?       ?    (0x)     ?       ?             :  ?  :    -   ; 
      
         0      (1x)    0      1       ?             :  0  :    0   ;
         1      (1x)    0      1       ?             :  1  :    1   ;
         0      (x0)    0      1       ?             :  ?  :    0   ;
         1      (x0)    0      1       ?             :  ?  :    1   ;

         0       0    (1x)     1       ?             :  0  :    0   ;
         1       0    (1x)     1       ?             :  1  :    1   ;
         0       0    (x0)     1       ?             :  ?  :    0   ;
         1       0    (x0)     1       ?             :  ?  :    1   ;

        (?0)     0      0      1       ?             :  ?  :    0   ;
        (?1)     0      0      1       ?             :  ?  :    1   ;

         0     (10)     0      1       ?             :  ?  :    0   ;
         0       0     (10)    1       ?             :  ?  :    0   ;
         1     (10)     0      1       ?             :  ?  :    1   ;
         1       0     (10)    1       ?             :  ?  :    1   ;

         ?       1      ?     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       ?      1     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1      ?       x      ?             :  0  :    0   ;   // Reducing pessimism//AB
         *       ?      1       x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     0      x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
        (?0)     x      0       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
        (?0)     x      x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0       0      x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      0       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0       0    (1x)      x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (1x)    0       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0      (?0)    0       x      ?             :  ?  :    0   ; // Reducing pessimism.
         0       0     (?0)     x      ?             :  ?  :    0   ; // Reducing pessimism.

        (?0)     0      0       x      ?             :  ?  :    0   ; // Reducing pessimism.
         0       0      0      (?x)    ?             :  ?  :    0   ;   // Reducing pessimism.//AB
 
         ?       1      ?      (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         ?       ?      1      (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         0       0      0      (?1)    ?             :  ?  :    0   ;
         1       0      0      (?1)    ?             :  ?  :    1   ;

        (?1)     0      x       1      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      0       1      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      x       1      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     0      x       1      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0       1      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      x       1      ?             :  0  :    0   ; // Reducing pessimism.
 
         ?       n      1       ?      ?             :  ?  :    -   ;
         ?       1      n       ?      ?             :  ?  :    -   ;
         ?       ?      ?       ?      *             :  ?  :    x   ;
 
    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE2C.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE2C (Q, D, G, E, R, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D,  G, E, R;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS  AND RESET ( Q OUTPUT UDP ) .

    table
//       D       G      E      R   NOTIFIER_REG      :  Qt  :  Qt+1
                      
         *       1      ?      0       ?             :  ?  :    -   ;
         *       ?      1      0       ?             :  ?  :    -   ;

         ?       ?      ?      1       ?             :  ?  :    0   ;

         ?      (?1)    ?      ?       ?             :  ?  :    -   ;
         ?      (0x)    ?      ?       ?             :  ?  :    -   ; //AB
         ?       ?    (?1)     ?       ?             :  ?  :    -   ;
         ?       ?    (0x)     ?       ?             :  ?  :    -   ; //AB
      
         0      (1x)    0      0       ?             :  0  :    0   ;
         1      (1x)    0      0       ?             :  1  :    1   ;
         0      (x0)    0      0       ?             :  ?  :    0   ;
         1      (x0)    0      0       ?             :  ?  :    1   ;

         0       0    (1x)     0       ?             :  0  :    0   ;
         1       0    (1x)     0       ?             :  1  :    1   ;
         0       0    (x0)     0       ?             :  ?  :    0   ;
         1       0    (x0)     0       ?             :  ?  :    1   ;

        (?0)     0      0      0       ?             :  ?  :    0   ;
        (?1)     0      0      0       ?             :  ?  :    1   ;

         0     (10)     0      0       ?             :  ?  :    0   ;
         0       0     (10)    0       ?             :  ?  :    0   ;
         1     (10)     0      0       ?             :  ?  :    1   ;
         1       0     (10)    0       ?             :  ?  :    1   ;

         ?       1      ?     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         ?       ?      1     (?x)     ?             :  0  :    0   ;   // Reducing pessimism.//AB
         *       1      ?       x      ?             :  0  :    0   ;   // Reducing pessimism//AB
         *       ?      1       x      ?             :  0  :    0   ;   // Reducing pessimism//AB

        (?0)     0      x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
        (?0)     x      0       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
        (?0)     x      x       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0       0      x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      0       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0       x      x       *      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0       0    (1x)      x      ?             :  0  :    0   ;   // Reducing pessimism.//AB
         0      (1x)    0       x      ?             :  0  :    0   ;   // Reducing pessimism.//AB

         0      (?0)    0       x      ?             :  ?  :    0   ; // Reducing pessimism.
         0       0     (?0)     x      ?             :  ?  :    0   ; // Reducing pessimism.

        (?0)     0      0       x      ?             :  ?  :    0   ; // Reducing pessimism.
         0       0      0      (?x)    ?             :  ?  :    0   ;   // Reducing pessimism.//AB
 
         ?       1      ?      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         ?       ?      1      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0       0      0      (?0)    ?             :  ?  :    0   ;
         1       0      0      (?0)    ?             :  ?  :    1   ;
 
        (?1)     0      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      0       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     0      x       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      x       0      ?             :  0  :    0   ; // Reducing pessimism.
 
         ?       n      1       ?      ?             :  ?  :    -   ;
         ?       1      n       ?      ?             :  ?  :    -   ;
         ?       ?      ?       ?      *             :  ?  :    x   ;
 
    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE3A.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE3A (Q, D, G, E, S, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D, G, E, S;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS  AND PRESET ( Q OUTPUT UDP ) .


    table
//       D       G      E      S   NOTIFIER_REG      :  Qt  :  Qt+1
                      
         *       1      ?      0       ?             :  ?  :    -   ;
         *       ?      0      0       ?             :  ?  :    -   ;

         ?       ?      ?      1       ?             :  ?  :    1   ;

         ?      (?1)    ?      ?       ?             :  ?  :    -   ;
         ?      (0x)    ?      ?       ?             :  ?  :    -   ; //AB
         ?       ?    (?0)     ?       ?             :  ?  :    -   ;
         ?       ?    (1x)     ?       ?             :  ?  :    -   ; //AB
      
         0      (1x)    1      0       ?             :  0  :    0   ;
         1      (1x)    1      0       ?             :  1  :    1   ;
         0      (x0)    1      0       ?             :  ?  :    0   ;
         1      (x0)    1      0       ?             :  ?  :    1   ;

         0       0    (0x)     0       ?             :  0  :    0   ;
         1       0    (0x)     0       ?             :  1  :    1   ;
         0       0    (x1)     0       ?             :  ?  :    0   ;
         1       0    (x1)     0       ?             :  ?  :    1   ;

        (?0)     0      1      0       ?             :  ?  :    0   ;
        (?1)     0      1      0       ?             :  ?  :    1   ;

         0     (10)     1      0       ?             :  ?  :    0   ;
         0       0     (01)    0       ?             :  ?  :    0   ;
         1     (10)     1      0       ?             :  ?  :    1   ;
         1       0     (01)    0       ?             :  ?  :    1   ;

         ?       1      ?     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       ?      0     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1      ?       x      ?             :  1  :    1   ;   // Reducing pessimism//AB
         *       ?      0       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?1)     0      x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
        (?1)     x      1       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
        (?1)     x      x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1       0      x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      1       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1       0    (0x)      x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (1x)    1       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1      (?0)    1       x      ?             :  ?  :    1   ; // Reducing pessimism.
         1       0     (?1)     x      ?             :  ?  :    1   ; // Reducing pessimism.

        (?1)     0      1       x      ?             :  ?  :    1   ; // Reducing pessimism.
         1       0      1      (?x)    ?             :  ?  :    1   ;   // Reducing pessimism.//AB
 
         ?       1      ?      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         ?       ?      0      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0       0      1      (?0)    ?             :  ?  :    0   ;
         1       0      1      (?0)    ?             :  ?  :    1   ;
 
        (?1)     0      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      1       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     0      x       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      1       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      x       0      ?             :  0  :    0   ; // Reducing pessimism.
 
         ?       n      0       ?      ?             :  ?  :    -   ;
         ?       1      p       ?      ?             :  ?  :    -   ;
         ?       ?      ?       ?      *             :  ?  :    x   ;
 
    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE3B.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE3B (Q, D, G, E, S, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D, G, E, S;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS  AND PRESET ( Q OUTPUT UDP ) .


    table
//       D       G      E      S   NOTIFIER_REG      :  Qt  :  Qt+1
                      
         *       1      ?      0       ?             :  ?  :    -   ;
         *       ?      1      0       ?             :  ?  :    -   ;

         ?       ?      ?      1       ?             :  ?  :    1   ;

         ?      (?1)    ?      ?       ?             :  ?  :    -   ;
         ?      (0x)    ?      ?       ?             :  ?  :    -   ; //AB
         ?       ?    (?1)     ?       ?             :  ?  :    -   ;
         ?       ?    (0x)     ?       ?             :  ?  :    -   ; //AB
      
         0      (1x)    0      0       ?             :  0  :    0   ;
         1      (1x)    0      0       ?             :  1  :    1   ;
         0      (x0)    0      0       ?             :  ?  :    0   ;
         1      (x0)    0      0       ?             :  ?  :    1   ;

         0       0    (1x)     0       ?             :  0  :    0   ;
         1       0    (1x)     0       ?             :  1  :    1   ;
         0       0    (x0)     0       ?             :  ?  :    0   ;
         1       0    (x0)     0       ?             :  ?  :    1   ;

        (?0)     0      0      0       ?             :  ?  :    0   ;
        (?1)     0      0      0       ?             :  ?  :    1   ;

         0     (10)     0      0       ?             :  ?  :    0   ;
         0       0     (10)    0       ?             :  ?  :    0   ;
         1     (10)     0      0       ?             :  ?  :    1   ;
         1       0     (10)    0       ?             :  ?  :    1   ;

         ?       1      ?     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       ?      1     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1      ?       x      ?             :  1  :    1   ;   // Reducing pessimism//AB
         *       ?      1       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?1)     0      x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
        (?1)     x      0       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
        (?1)     x      x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1       0      x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      0       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1       0    (1x)      x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (1x)    0       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1      (?0)    0       x      ?             :  ?  :    1   ; // Reducing pessimism.
         1       0     (?0)     x      ?             :  ?  :    1   ; // Reducing pessimism.

        (?1)     0      0       x      ?             :  ?  :    1   ; // Reducing pessimism.
         1       0      0      (?x)    ?             :  ?  :    1   ;   // Reducing pessimism.//AB
 
         ?       1      ?      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         ?       ?      1      (?0)    ?             :  ?  :    -   ; // ignore edge on clear
         0       0      0      (?0)    ?             :  ?  :    0   ;
         1       0      0      (?0)    ?             :  ?  :    1   ;
 
        (?1)     0      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      0       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      x       0      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     0      x       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0       0      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      x       0      ?             :  0  :    0   ; // Reducing pessimism.
 
         ?       n      1       ?      ?             :  ?  :    -   ;
         ?       1      n       ?      ?             :  ?  :    -   ;
         ?       ?      ?       ?      *             :  ?  :    x   ;
 
    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLE3C.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLE3C (Q, D, G, E, S, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D, G, E, S;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS  AND PRESET ( Q OUTPUT UDP ) .


    table
//       D       G      E      S   NOTIFIER_REG      :  Qt  :  Qt+1
                      
         *       1      ?      1       ?             :  ?  :    -   ;
         *       ?      1      1       ?             :  ?  :    -   ;

         ?       ?      ?      0       ?             :  ?  :    1   ;

         ?      (?1)    ?      ?       ?             :  ?  :    -   ;
         ?      (0x)    ?      ?       ?             :  ?  :    -   ; //AB
         ?       ?    (?1)     ?       ?             :  ?  :    -   ;
         ?       ?    (0x)     ?       ?             :  ?  :    -   ; //AB
      
         0      (1x)    0      1       ?             :  0  :    0   ;
         1      (1x)    0      1       ?             :  1  :    1   ;
         0      (x0)    0      1       ?             :  ?  :    0   ;
         1      (x0)    0      1       ?             :  ?  :    1   ;

         0       0    (1x)     1       ?             :  0  :    0   ;
         1       0    (1x)     1       ?             :  1  :    1   ;
         0       0    (x0)     1       ?             :  ?  :    0   ;
         1       0    (x0)     1       ?             :  ?  :    1   ;

        (?0)     0      0      1       ?             :  ?  :    0   ;
        (?1)     0      0      1       ?             :  ?  :    1   ;

         0     (10)     0      1       ?             :  ?  :    0   ;
         0       0     (10)    1       ?             :  ?  :    0   ;
         1     (10)     0      1       ?             :  ?  :    1   ;
         1       0     (10)    1       ?             :  ?  :    1   ;

         ?       1      ?     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         ?       ?      1     (?x)     ?             :  1  :    1   ;   // Reducing pessimism.//AB
         *       1      ?       x      ?             :  1  :    1   ;   // Reducing pessimism//AB
         *       ?      1       x      ?             :  1  :    1   ;   // Reducing pessimism//AB

        (?1)     0      x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
        (?1)     x      0       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
        (?1)     x      x       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1       0      x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      0       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1       x      x       *      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1       0    (1x)      x      ?             :  1  :    1   ;   // Reducing pessimism.//AB
         1      (1x)    0       x      ?             :  1  :    1   ;   // Reducing pessimism.//AB

         1      (?0)    0       x      ?             :  ?  :    1   ; // Reducing pessimism.
         1       0     (?0)     x      ?             :  ?  :    1   ; // Reducing pessimism.

        (?1)     0      0       x      ?             :  ?  :    1   ; // Reducing pessimism.
         1       0      0      (?x)    ?             :  ?  :    1   ;   // Reducing pessimism.//AB
 
         ?       1      ?      (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         ?       ?      1      (?1)    ?             :  ?  :    -   ; // ignore edge on clear
         0       0      0      (?1)    ?             :  ?  :    0   ;
         1       0      0      (?1)    ?             :  ?  :    1   ;
 
        (?1)     0      x       1      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      0       1      ?             :  1  :    1   ; // Reducing pessimism.
        (?1)     x      x       1      ?             :  1  :    1   ; // Reducing pessimism.
        (?0)     0      x       1      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      0       1      ?             :  0  :    0   ; // Reducing pessimism.
        (?0)     x      x       1      ?             :  0  :    0   ; // Reducing pessimism.
 
         ?       n      1       ?      ?             :  ?  :    -   ;
         ?       1      n       ?      ?             :  ?  :    -   ;
         ?       ?      ?       ?      *             :  ?  :    x   ;
 
    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLEA.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLEA (Q, D, ACLK, BCLK, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D,  ACLK, BCLK;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ( Q OUTPUT UDP ) .


    table
//   D   ACLK      BCLK      NOTIFIER_REG  :  Qt  :  Qt+1
                      
     1  (?1)      0             ?          :  ?   :   1;
     1  (0x)      0             ?          :  1   :   1;
     1    1      (?0)           ?          :  ?   :   1;
     1    1      (1x)           ?          :  1   :   1;
     0  (?1)      0             ?          :  ?   :   0;
     0  (0x)      0             ?          :  0   :   0;
     0    1      (?0)           ?          :  ?   :   0;
     0    1      (1x)           ?          :  0   :   0;
    
    (?1)  1       0             ?          :  ?   :   1;
    (?0)  1       0             ?          :  ?   :   0;

     *    0       ?             ?          :  ?   :   -;
     *    ?       1             ?          :  ?   :   -;

   (?1)   ?       ?             ?          :  1   :   1;   // Reducing Pessimism
   (?0)   ?       ?             ?          :  0   :   0;
  
     ?    n       ?             ?          :  ?   :   -;  
     ?    p       1             ?          :  ?   :   -;  
     ?    0       n             ?          :  ?   :   -;  
     ?    ?       p             ?          :  ?   :   -;  
     ?    ?       ?             *          :  ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_DLEC.v                                  -
//--------------------------------------------------------------------
      
primitive U_DLEC (Q, D, ACLK, BCLK, NOTIFIER_REG); 

    output Q; 

    input  NOTIFIER_REG,
           D,  ACLK, BCLK;

    reg    Q;                               

// FUNCTION : D LATCH WITH DUAL CLOCK INPUTS ( Q OUTPUT UDP ) .


    table
//   D   ACLK      BCLK      NOTIFIER_REG  :  Qt  :  Qt+1
                      
     1  (?0)      0             ?          :  ?   :   1;
     1  (1x)      0             ?          :  1   :   1;
     1    0      (?0)           ?          :  ?   :   1;
     1    0      (1x)           ?          :  1   :   1;
     0  (?0)      0             ?          :  ?   :   0;
     0  (1x)      0             ?          :  0   :   0;
     0    0      (?0)           ?          :  ?   :   0;
     0    0      (1x)           ?          :  0   :   0;
    
    (?1)  0       0             ?          :  ?   :   1;
    (?0)  0       0             ?          :  ?   :   0;

     *    1       ?             ?          :  ?   :   -;
     *    ?       1             ?          :  ?   :   -;

   (?1)   ?       ?             ?          :  1   :   1;   // Reducing Pessimism
   (?0)   ?       ?             ?          :  0   :   0;
  
     ?    p       ?             ?          :  ?   :   -;  
     ?    n       1             ?          :  ?   :   -;  
     ?    1       n             ?          :  ?   :   -;  
     ?    ?       p             ?          :  ?   :   -;  
     ?    ?       ?             *          :  ?   :   x;

    endtable
endprimitive
      
     
//--------------------------------------------------------------------
//-                    cell  U_MAJ_3.v                                  -
//--------------------------------------------------------------------
      
primitive	U_MAJ_3 (Y, A, B, C);
	output Y;
	input  A, B, C;

	table
	//	A	B	C	:	Y

		0	0	?	:	0	;
		0	?	0	:	0	;
		?	0	0	:	0	;
		?	1	1	:	1	;
		1	?	1	:	1	;
		1	1	?	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_MUX_2.v                                  -
//--------------------------------------------------------------------
      
primitive U_MUX_2 (Q, A, B, SL);
    output Q;
    input A, B, SL;

// FUNCTION :  TWO TO ONE MULTIPLEXER

    table
    //  A   B   SL  :   Q
        0   0   ?   :   0 ;
        1   1   ?   :   1 ;

        0   ?   0   :   0 ;
        1   ?   0   :   1 ;

        ?   0   1   :   0 ;
        ?   1   1   :   1 ;

    endtable
endprimitive    
      
     
//--------------------------------------------------------------------
//-                    cell  U_MUX_4.v                                  -
//--------------------------------------------------------------------
      
primitive U_MUX_4 (Y, D0, D1, D2, D3, S0, S1);

    input D0, D1, D2, D3, S0, S1;
    output Y;
   
// FUNCTION :  FOUR TO ONE MULTIPLEXER WITH 2 SELECT CONTROLS

    table

//   D0  D1  D2 D3  S0  S1 : Y
                       
     0   ?   ?  ?    0  0  : 0 ; 
     1   ?   ?  ?    0  0  : 1 ; 
                                 
     ?   0   ?  ?    1  0  : 0 ; 
     ?   1   ?  ?    1  0  : 1 ; 
                                 
     ?   ?   0  ?    0  1  : 0 ; 
     ?   ?   1  ?    0  1  : 1 ; 
                                 
     ?   ?   ?  0    1  1  : 0 ; 
     ?   ?   ?  1    1  1  : 1 ; 
                                 
                                 
     0   0   0   0   ?  ?  : 0 ; 
                       
     1   1   1   1   ?  ?  : 1 ; 

     0   0   ?   ?   ?  0  : 0 ;    
     1   1   ?   ?   ?  0  : 1 ; 

     ?   ?   0   0   ?  1  : 0 ; 
     ?   ?   1   1   ?  1  : 1 ; 

     0   ?   0   ?   0  ?  : 0 ; 
     1   ?   1   ?   0  ?  : 1 ; 

     ?   0   ?   0   1  ?  : 0 ; 
     ?   1   ?   1   1  ?  : 1 ; 
                 
     endtable
endprimitive
    
      
     
//--------------------------------------------------------------------
//-                    cell  U_OA_1A.v                                  -
//--------------------------------------------------------------------
      
primitive	U_OA_1A (Y, A, B, C);
	output Y;
	input  A, B, C;

	table
	//	A	B	C	:	Y

		0	?	1	:	1	;
		1	0	?	:	0	;
		?	1	1	:	1	;
		?	?	0	:	0	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_OA_1B.v                                  -
//--------------------------------------------------------------------
      
primitive	U_OA_1B (Y, A, B, C);
	output Y;
	input  A, B, C;

	table
	//	A	B	C	:	Y

		0	0	?	:	0	;
		?	1	0	:	1	;
		1	?	0	:	1	;
		?	?	1	:	0	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_OA_2.v                                  -
//--------------------------------------------------------------------
      
primitive	U_OA_2 (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	0	?	?	:	0	;
		?	?	0	0	:	0	;
		?	1	?	1	:	1	;
		1	?	1	?	:	1	;
		?	1	1	?	:	1	;
		1	?	?	1	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_OA_3B.v                                  -
//--------------------------------------------------------------------
      
primitive	U_OA_3B (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	?	0	1	:	1	;
		?	1	0	1	:	1	;
		1	0	?	?	:	0	;
		?	?	?	0	:	0	;
		?	?	1	?	:	0	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_OA_4A.v                                  -
//--------------------------------------------------------------------
      
primitive	U_OA_4A (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	0	1	?	:	0	;
		?	?	0	1	:	1	;
		?	1	?	1	:	1	;
		1	?	?	1	:	1	;
		?	?	?	0	:	0	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_OA_5.v                                  -
//--------------------------------------------------------------------
      
primitive	U_OA_5 (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	0	0	?	:	0	;
		0	?	?	0	:	0	;
		?	?	1	1	:	1	;
		?	1	?	1	:	1	;
		1	?	?	?	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  U_OR4_B.v                                  -
//--------------------------------------------------------------------
      
primitive	U_OR4_B (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		1	1	0	0	:	0	;
		?	0	?	?	:	1	;
		0	?	?	?	:	1	;
		?	?	?	1	:	1	;
		?	?	1	?	:	1	;

	endtable
endprimitive

      
     
//--------------------------------------------------------------------
//-                    cell  VCC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module VCC(Y);
    
    output Y;
    supply1 Y;
               
    specify

         specparam   LibName     = "act1";
         specparam   OutputLoad$Y = 0;

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XA1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XA1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    xor XR1   (XAB, A, B);
    and AN1   (Y, XAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XA1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XA1A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    xnor XNR1  (XNAB, A, B);
    and  AN1   (Y, XNAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XNOR2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XNOR2(A, B, Y);
    
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
//-                    cell  XO1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XO1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    xor XR1   (XAB, A, B);
    or  OR1   (Y, XAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XO1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XO1A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    xnor XNR1  (XNAB, A, B);
    or   OR1   (Y, XNAB, C);
    
    specify

         specparam   LibName     = "act1";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  XOR2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XOR2(A, B, Y);
    
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
      

//  ------------------------------  END of 40mx.v ----------------------------
