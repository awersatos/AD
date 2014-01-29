/*  
               =========================================
               =                                       =
               =         42mx VERILOG  LIB              =
               =        ACTEL  CORPORATION             =
               =                                       =
               =========================================
*/ 
  
 //BUILT on 07/25/01 17:32:34 
  
  
     
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;





    
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
//-                    cell  AND5B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND5B(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    and       AN1   (D_INT, D, E);
    U_AND4_B  inst1 (Y, A, B, C, D_INT);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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

         specparam   LibName     = "3200dx";
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
//-                    cell  AO10.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO10(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    

	and 	inst1 (T1, A, B);
	or	inst2 (T2, T1, C);
	or	inst3 (T3, D, E);
	and	inst4 (Y, T2, T3);
       
    specify

         specparam   LibName     = "3200dx";
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
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO11.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO11(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	and	inst1 (T1, A, B);
	or	inst2 (T2, A, B);
	and	inst3 (T3, T2, C);
	or	inst4 (Y, T1, T3);
       
    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  AO1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO1D(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    not         NT1   (B_INT, B);
    U_AO_1A     inst1 (Y, A, B_INT, C);
       
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO1E(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	not	inst1( A_, A);
	not 	inst2( B_, B);
	not	inst3( C_, C);
	and	inst4 (T1, A_, B_);
	or	inst5 (Y, T1, C_);	
       
    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
    

	not	inst1 (A_, A);
	and	inst2 (T1, A_, B);
	or	inst3 (Y, T1, C, D);
          
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO2B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
   

	not	inst1 (A_, A);
	not 	inst2 (B_, B);
	and 	inst3 (T1, A_, B_);
	or	inst4 (Y, T1, C, D);
          
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO2C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO2C(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
   

	not	inst1 (A_, A);
	not	inst2 (C_, C);
	and	inst3 (T1, A_, B);
	or	inst4 (Y, T1, C_, D);
          
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO2D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO2D(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
   
/*
    not      inst2  (C_,C);  
    not      inst3  (D_,D);  
    U_AO_1A  inst1  (Y_INT, A, B, C_);
    or       OR1    (Y, Y_INT, D_);
*/

	not 	inst1 (A_, A);
	not	inst2 (B_, B);
	not 	inst3 (C_, C);
	and	inst4 (T1, A_, B_);
	or	inst5 (Y, T1, C_, D);
          
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO2E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO2E(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
   
/*
    not      inst2  (C_,C);  
    not      inst3  (B_,B);  
    not      inst4  (D_,D);  
    U_AO_1A  inst1  (Y_INT, A, B_, C_);
    or       OR1    (Y, Y_INT, D_);
*/
          
    not      inst1  (A_,A);  
    not      inst2  (C_,C);  
    not      inst3  (B_,B);  
    not      inst4  (D_,D);  
	and	inst5 (T1, A_, B_);
	or	inst6 (Y, T1, C_, D_);

    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  AO3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO3A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    

	and	inst1 ( T1, A, B, C);
	or	inst2 ( Y, T1, D);
       
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO3B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO3B(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
/*
    not         inst2 (B_,B); 
    not         inst3 (A_,A); 
    U_AO_3A     inst1 (Y, A_, B_, C, D);
*/
	not 	inst1 (A_, A);
	not	inst2 (B_, B);
	and	inst3 (T1, A_, B_, C);
	or	inst4 (Y, T1, D);	
       
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO3C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO3C(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not         inst2 (B_,B); 
    not         inst3 (A_,A); 
    not         inst4 (C_,C); 
	and 	inst5 ( T1, A_, B_, C_);
	or	inst6 ( Y, T1, D);
       
    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  AO6.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO6(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    U_AO_6  inst1 (Y, A, B, C, D);
       
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO6A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO6A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not       NT1   (D_INT, D);
    U_AO_6     inst1 (Y, A, B, C, D_INT);
       
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AO7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO7(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    or          OR1   (D_INT, D, E);
    U_AO_3A     inst1 (Y, A, B, C, D_INT);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO8.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO8(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    

	and	inst1 ( T1, A, B);
	not	inst2 ( C_, C);
	not	inst3 ( D_, D);
	and 	inst4 (T2, C_, D_);
	or	inst5 (Y, T1, T2, E);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  AO9.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO9(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    

	and	inst1 (T1, A, B);
	or	inst2 (Y, T1, C, D, E);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$E = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  AOI1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI1C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	not 	inst1 (A_, A);
	not 	inst2 (B_, B);
	and 	inst3 (T1, A_, B_);
	nor	inst4 (Y, T1, C);
       
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  AOI1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI1D(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	not	inst1 (A_, A);
	not	inst2 (B_, B);
	not	inst3 (C_, C);
	and	inst4 (T1, A_, B_);
	nor	inst5 (Y, T1, C_);	
       
    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 2; 
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 0;
         specparam   ExtraDelayPaths$B$Y   = 0;
         specparam   ExtraDelayPaths$C$Y   = 1;
         specparam   ExtraDelayPaths$D$Y   = 1;





    
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
//-                    cell  AOI4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI4A(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not         NT1   (C_INT, C);
    U_AOI_4     inst1 (Y, A, B, C_INT, D);
       
    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 2; 
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;




    
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

         specparam   LibName     = "3200dx";
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
//-                    cell  AX1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AX1C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
    and      AN1    (A_INT, A, B);
    xor      XR1    (Y, A_INT, C);
           
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  BBDLHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BBDLHS(D, E, GIN, GOUT, PAD, Q);
    
    input   D, E, GIN, GOUT;
    output  Q;
    inout   PAD;
    
    reg     NOTIFY_REG;
    
    ULP   inst1  (PAD_INT, D, GOUT, NOTIFY_REG);
    bufif1      BFIF1  (PAD, PAD_INT, E);
    ULN   inst2  (Q, PAD, GIN, NOTIFY_REG);

                 
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$GIN = 1; 
         specparam   InputLoad$GOUT = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$PAD = 0; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "io";
         



    if(GOUT && E)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
  
    if(E)
    (posedge GOUT => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
    
    if(!GIN)
    (PAD +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    
    (negedge GIN => (Q +: PAD)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   

    $setup(D, negedge GOUT, 0.0, NOTIFY_REG);
    $hold(negedge GOUT, D, 0.0, NOTIFY_REG);

    $setup(PAD, posedge GIN, 0.0, NOTIFY_REG);
    $hold(posedge GIN, PAD, 0.0, NOTIFY_REG);

    $width(posedge GOUT, 0.0, 0, NOTIFY_REG); 
    $width(negedge GIN, 0.0, 0, NOTIFY_REG); 

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  BBHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module BBHS(D, E, PAD, Y);
    
    input   D, E;
    output  Y;
    inout   PAD;
        
    bufif1      BFIF1  (PAD, D, E);
    buf         BF1    (Y, PAD);

    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  CLKBIBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CLKBIBUF(D, E, Y, PAD);
    
    input   D, E;
    output  Y;
    inout   PAD;
        
    bufif1      BFIF1  (PAD, D, E);
    buf         BF1    (Y, PAD);

    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  CLKINT.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CLKINT(A, Y);
    
    input A;
    output Y;
    
    buf    BF1 (Y, A);
               
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 0; 
         specparam   OutputLoad$Y = 0;
         specparam   MacroType   = "io";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CM7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CM7(D0, D1, D2, D3, S0, S10, S11, Y);
    
    input D0, D1, D2, D3, S0, S10, S11;
    output Y;
    
        
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, S0);
    U_MUX_2  mux2 (T2, D2, D3, S0);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S0 = 1;  
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CM8.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CM8(D0, D1, D2, D3, S00, S01, S10, S11, Y);
    
    input D0, D1, D2, D3, S00, S01, S10, S11;
    output Y;
    
       
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S00 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CS1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CS1(A, B, C, D, S, Y);
    
    input A, B, C, D, S;
    output Y;
    
    U_CS_1     inst1  (Y, A, S, B, C, D);
           
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$S = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CS2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CS2(A, B, C, D, S, Y);
    
    input A, S, B, C, D;
    output Y;
    

	or	inst1 (T1, A, S);
	and	inst2 (T2, T1, B);
        U_MUX_2	inst3 (Y, C, D, T2);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$S = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (S => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CY2A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CY2A(A0, A1, B0, B1, Y);
    
    input A0, B0, A1, B1;
    output Y;
    
    and       AN1   (C1_INT, A0, B0);
    U_MAJ_3   inst1 (Y, A1, B1, C1_INT);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A0 = 1; 
         specparam   InputLoad$A1 = 2; 
         specparam   InputLoad$B0 = 1; 
         specparam   InputLoad$B1 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CY2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CY2B(A0, A1, B0, B1, Y);
    
    input A0, B0, A1, B1;
    output Y;
    
    or        OR1   (C1_INT, A0, B0);
    U_MAJ_3   inst1 (Y, A1, B1, C1_INT);

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A0 = 1; 
         specparam   InputLoad$A1 = 2; 
         specparam   InputLoad$B0 = 1; 
         specparam   InputLoad$B1 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B0 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (A1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B1 => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DF1A_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1A_CC(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPQ  
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DF1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1B_CC(D, CLK, Q);
    
    input    D, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFN  
                inst1 (Q, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DF1C_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1C_CC(D, CLK, QN);
    
    input    D, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNQ 
                inst1 (QN, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DF1_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DF1_CC(D, CLK, Q);
    
    input    D, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFP  
                inst1 (Q, D, CLK, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";
         
        
     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";

     


          
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
//-                    cell  DFC1A_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1A_CC(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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
//-                    cell  DFC1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1B_CC(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPRB 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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
//-                    cell  DFC1D_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1D_CC(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNRB 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  DFC1_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFC1_CC(D, CLK, CLR, Q);
    
    input    D, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPR 
                inst1 (Q, D, CLK, CLR, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "CLRN";
         specparam   ExtraDelayPin   = "CLR";
         
        
     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& E, 0.0, NOTIFY_REG);

      $setup(E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, E, 0.0, NOTIFY_REG);
  
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& (~E), 0.0, NOTIFY_REG);

      $setup(E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, E, 0.0, NOTIFY_REG);
  
      $width(negedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE1B_CC(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCEB  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& (~E), 0.0, NOTIFY_REG);

      $setup(E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, E, 0.0, NOTIFY_REG);
  
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& (~E), 0.0, NOTIFY_REG);

      $setup(E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, E, 0.0, NOTIFY_REG);
    
      $width(negedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE1C_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE1C_CC(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCEB  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& (~E), 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& (~E), 0.0, NOTIFY_REG);

      $setup(E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, E, 0.0, NOTIFY_REG);
    
      $width(negedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& (~E), 0.0, 0, NOTIFY_REG);

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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E && CLR)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(E, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, E &&& CLR, 0.0, NOTIFY_REG);


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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E && CLR)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(E, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, E &&& CLR, 0.0, NOTIFY_REG);


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
                
       
       not  N1    (E_, E);
       and  AN1   (ENABLE, E_, CLR);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E && CLR)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


  
      $setup(E, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, E &&& CLR, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (!E && CLR)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(E, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, E &&& CLR, 0.0, NOTIFY_REG);


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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
          if (E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& E, 0.0, NOTIFY_REG);

      $setup(E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, E, 0.0, NOTIFY_REG);
  
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEA_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFEA_CC(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCE  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
          if (E)
           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& E, 0.0, NOTIFY_REG);

      $setup(E, negedge CLK, 0.0, NOTIFY_REG);
      $hold(negedge CLK, E, 0.0, NOTIFY_REG);
  
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE_CC(D, E, CLK, Q);
    
    input    D, E, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCE  
                inst1 (Q, D, CLK, E, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
          if (E)
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, posedge CLK &&& E, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& E, 0.0, NOTIFY_REG);

      $setup(E, posedge CLK, 0.0, NOTIFY_REG);
      $hold(posedge CLK, E, 0.0, NOTIFY_REG);
  
      $width(posedge CLK &&& E, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& E, 0.0, 0, NOTIFY_REG);

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
module DFM(A, B, S, CLK, Q);
    
    input    A, B, S, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSD  
                inst1 (Q, A, CLK, B, S, NOTIFY_REG);
    
       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DFM1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM1B_CC(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFPSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DFM1C_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM1C_CC(A, B, S, CLK, QN);
    
    input    A, B, S, CLK;
    output   QN;
    
    reg NOTIFY_REG;
    
       UFNSDQ  
                inst1 (QN, A, CLK, B, S, NOTIFY_REG);
    
       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";
     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";
     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 2; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DFM6A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM6A(D0, D1, D2, D3, S0, S1, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S1, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_4     inst1 (D_EFF, D0, D1, D2, D3, S0, S1);

       UFPRB  inst2 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
    
                
      
      not    NT1   (S0_, S0);
      not    NT2   (S1_, S1);
      and    AN1   (EN_D0, CLR, S0_, S1_);
      and    AN2   (EN_D1, CLR, S0, S1_);
      and    AN3   (EN_D2, CLR, S0_, S1);
      and    AN4   (EN_D3, CLR, S0, S1);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !S1 &&  CLR)
            (posedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !S1 &&  CLR)
            (posedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && S1 &&  CLR)
            (posedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && S1 &&  CLR)
            (posedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D0, posedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(D1, posedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(D2, posedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(D3, posedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D3 &&& EN_D3, 0.0, NOTIFY_REG);
  
      $setup(S0, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(S1, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S1 &&& CLR, 0.0, NOTIFY_REG);
 
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
//-                    cell  DFM6B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM6B(D0, D1, D2, D3, S0, S1, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S1, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_4     inst1 (D_EFF, D0, D1, D2, D3, S0, S1);

       UFNRB  inst2 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
    
                
      
      not    NT1   (S0_, S0);
      not    NT2   (S1_, S1);
      and    AN1   (EN_D0, CLR, S0_, S1_);
      and    AN2   (EN_D1, CLR, S0, S1_);
      and    AN3   (EN_D2, CLR, S0_, S1);
      and    AN4   (EN_D3, CLR, S0, S1);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !S1 &&  CLR)
            (negedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !S1 &&  CLR)
            (negedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && S1 &&  CLR)
            (negedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && S1 &&  CLR)
            (negedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D0, negedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(D1, negedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(D2, negedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(D3, negedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D3 &&& EN_D3, 0.0, NOTIFY_REG);

      $setup(S0, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(S1, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S1 &&& CLR, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);
 
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(posedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFM7A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM7A ( D0, D1, D2, D3, S0, S10, S11, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S10, S11, CLR, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
    
        or 	OR1_inst ( S1, S10, S11);
	U_MUX_4 inst2 ( D_EFF, D0, D1, D2, D3, S0, S1);

	UFPRB  	inst3 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
      
      or     OR1   (ORs10s11, S10, S11);
      not    NT1   (S0_, S0);
      not    NT2   (ORs10s11_, ORs10s11);
      and    AN1   (EN_D0, CLR, S0_, ORs10s11_);
      and    AN2   (EN_D1, CLR, S0, ORs10s11_);
      and    AN3   (EN_D2, CLR, S0_, ORs10s11);
      and    AN4   (EN_D3, CLR, S0, ORs10s11);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !(S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !(S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && (S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && (S10 || S11) &&  CLR)
            (posedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D0, posedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(D1, posedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(D2, posedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(D3, posedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D3 &&& EN_D3, 0.0, NOTIFY_REG);
  
      $setup(S0, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(S10, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S10 &&& CLR, 0.0, NOTIFY_REG);
      $setup(S11, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, S11 &&& CLR, 0.0, NOTIFY_REG);

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
//-                    cell  DFM7B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM7B ( D0, D1, D2, D3, S0, S10, S11, CLK, CLR, Q);
    
    input    D0, D1, D2, D3, S0, S10, S11, CLR, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
    
        or      OR1_inst ( S1, S10, S11);
        U_MUX_4 inst2 ( D_EFF, D0, D1, D2, D3, S0, S1);

       UFNRB  inst3 (Q, D_EFF, CLK, CLR, NOTIFY_REG);
    
                
      
      or     OR1   (ORs10s11, S10, S11);
      not    NT1   (S0_, S0);
      not    NT2   (ORs10s11_, ORs10s11);
      and    AN1   (EN_D0, CLR, S0_, ORs10s11_);
      and    AN2   (EN_D1, CLR, S0, ORs10s11_);
      and    AN3   (EN_D2, CLR, S0_, ORs10s11);
      and    AN4   (EN_D3, CLR, S0, ORs10s11);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     


      
          if (!S0 && !(S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && !(S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (!S0 && (S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
          if (S0 && (S10 || S11) &&  CLR)
            (negedge CLK =>  (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
            
          (negedge CLR => (Q +: 1'b0))   = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D0, negedge CLK &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D0 &&& EN_D0, 0.0, NOTIFY_REG);
      $setup(D1, negedge CLK &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D1 &&& EN_D1, 0.0, NOTIFY_REG);
      $setup(D2, negedge CLK &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D2 &&& EN_D2, 0.0, NOTIFY_REG);
      $setup(D3, negedge CLK &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D3 &&& EN_D3, 0.0, NOTIFY_REG);
  
      $setup(S0, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S0 &&& CLR, 0.0, NOTIFY_REG);
      $setup(S10, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S10 &&& CLR, 0.0, NOTIFY_REG);
      $setup(S11, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, S11 &&& CLR, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DFMA_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFMA_CC(A, B, S, CLK, Q);
    
    input    A, B, S, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSD  
                inst1 (Q, A, CLK, B, S, NOTIFY_REG);

       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$E = 2; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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
//-                    cell  DFM_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFM_CC(A, B, S, CLK, Q);
    
    input    A, B, S, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSD  
                inst1 (Q, A, CLK, B, S, NOTIFY_REG);
    
       xor XR1 (EN, A, B);

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


      
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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
//-                    cell  DFP1A_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1A_CC(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNS 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 3; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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
//-                    cell  DFP1B_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1B_CC(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPSB 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 3; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "PREN";
         specparam   ExtraDelayPin   = "PRE";
     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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
//-                    cell  DFP1D_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1D_CC(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNSB 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "PREN";
         specparam   ExtraDelayPin   = "PRE";
     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
         if (PRE)
          (negedge CLK =>  (QN -: D))    = (1.0:1.0:1.0, 1.0:1.0:1.0);  

         (negedge PRE =>  (QN +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  

      
      $setup(D, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& PRE, 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);


  
      $width(posedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& (~PRE), 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, negedge CLK, 0.0, NOTIFY_REG);

    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFP1_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFP1_CC(D, CLK, PRE, Q);
    
    input    D, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPS 
                inst1 (Q, D, CLK, PRE, NOTIFY_REG);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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
//-                    cell  DFPC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPC(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UDP_DFPC 
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "3200dx";
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
//-                    cell  DFPCA_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPCA_CC(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
        UFNRBSX
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and  AN1  (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  DFPC_CC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPC_CC(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UDP_DFPC 
                inst1 (Q, D, CLK, CLR, PRE_, NOTIFY_REG);
       not  NT1  (PRE_, PRE);
       
       
       and (ENABLE, PRE_, CLR);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combcomb";

     


          
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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
   UDP_DL2A         inst1 (Q, D, G, CLR_, PRE, NOTIFY_REG);
     
   nor              A1   (ENABLE, CLR_, PRE);


   specify

         specparam   LibName     = "3200dx";
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

    (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (CLR)
    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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
   UDP_DL2B           inst1 (QN, D, G, CLR, PRE_, NOTIFY_REG);
     
   nor                A1   (ENABLE, CLR, PRE_);


   specify

         specparam   LibName     = "3200dx";
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
   UDP_DL2C          inst1 (Q, D, G, CLR_, PRE, NOTIFY_REG);
     
   nor                A1   (ENABLE, CLR_, PRE);


   specify

         specparam   LibName     = "3200dx";
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

    (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (CLR)
    (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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
   UDP_DL2D           inst1 (QN, D, G, CLR, PRE_, NOTIFY_REG);
     
   nor                A1    (ENABLE, CLR, PRE);


   specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 2; 
         specparam   InputLoad$CLR = 2; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 2; 
         specparam   InputLoad$CLR = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






    if (G && E)
    (D +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (E)
    (posedge G => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    if (G)
    (posedge E => (Q +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);


    $setup(D, negedge G &&& E, 0.0, NOTIFY_REG);
    $hold(negedge G &&& E, D, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";





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
//-                    cell  DLM2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM2 (A, B, S, CLR, G, Q); 

    input A, B, S, CLR, G;

    output Q;

    reg NOTIFY_REG;

    U_MUX_2 inst1 (D_EFF, A, B, S);
    ULPRB inst2 (Q, D_EFF, G, CLR, NOTIFY_REG);

    xor       XR1   (EN, A, B);

    specify

         specparam   LibName       = "3200dx";
         specparam   InputLoad$A   = 1; 
         specparam   InputLoad$B   = 1; 
         specparam   InputLoad$S   = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G   = 1; 
         specparam   OutputLoad$Q  = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";

        if (!S && G && CLR) 
        (A +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (S && G && CLR) 
        (B +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (G && (A ^ B) && CLR) 
        (S => Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (CLR)
           (posedge G => (Q  +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
        (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



        $setup(A, negedge G &&& (~S), 0.0, NOTIFY_REG);
        $hold(negedge G &&& (~S), A, 0.0, NOTIFY_REG);

        $setup(B, negedge G &&& S, 0.0, NOTIFY_REG);
        $hold(negedge G &&& S, B, 0.0, NOTIFY_REG);

        $setup(S, negedge G &&& EN, 0.0, NOTIFY_REG);
        $hold(negedge G, S &&& EN, 0.0, NOTIFY_REG);

 
        $width(negedge CLR, 0.0, 0, NOTIFY_REG);
        $width(posedge G &&& CLR, 0.0, 0, NOTIFY_REG);
 
        $recovery(posedge CLR, negedge G, 0.0, NOTIFY_REG);
        $hold(negedge G, posedge CLR, 0.0, NOTIFY_REG);



    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM2B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM2B (A, B, S, CLR, G, Q); 

    input A, B, S, CLR, G;

    output Q;

    reg NOTIFY_REG;

    U_MUX_2 inst1 (D_EFF, A, B, S);
    ULNRB inst2 (Q, D_EFF, G, CLR, NOTIFY_REG);

    xor       XR1   (EN, A, B);

    specify

         specparam   LibName       = "3200dx";
         specparam   InputLoad$A   = 1; 
         specparam   InputLoad$B   = 1; 
         specparam   InputLoad$S   = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G   = 1; 
         specparam   OutputLoad$Q  = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";

        if (!S && !G && CLR) 
        (A +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        if (S && !G && CLR) 
        (B +=>  Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (!G && (A ^ B) && CLR) 
        (S => Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

        if (CLR)
           (negedge G => (Q  +: (B & S) | (A & ~S))) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
        (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);



        $setup(A, posedge G &&& (~S), 0.0, NOTIFY_REG);
        $hold(posedge G &&& (~S), A, 0.0, NOTIFY_REG);

        $setup(B, posedge G &&& S, 0.0, NOTIFY_REG);
        $hold(posedge G &&& S, B, 0.0, NOTIFY_REG);

        $setup(S, posedge G &&& EN, 0.0, NOTIFY_REG);
        $hold(posedge G, S &&& EN, 0.0, NOTIFY_REG);

 
        $hold(posedge G, posedge CLR, 0.0, NOTIFY_REG);

 
        $width(negedge CLR, 0.0, 0, NOTIFY_REG);
        $width(negedge G &&& CLR, 0.0, 0, NOTIFY_REG);
 
        $recovery(posedge CLR, posedge G, 0.0, NOTIFY_REG);



    endspecify



endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM3(D0, D1, D2, D3, S0, S1, G, Q);
    
    input    D0, D1, D2, D3, S0, S1, G;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_4   inst1 (D_EFF, D0, D1, D2, D3, S0, S1);

       ULP   inst2 (Q, D_EFF, G, NOTIFY_REG);
    
                
      
      not    NT1   (S0_, S0);
      nor    NR1   (EN_D0, S0, S1);
      nor    NR2   (EN_D1, S0_, S1);
      and    AN1   (EN_D2, S0_, S1);
      and    AN2   (EN_D3, S0, S1);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";
     



          if (!S0 && !S1 && G)
            (D0 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (S0 && !S1 && G)
            (D1 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!S0 && S1 && G)
            (D2 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (S0 && S1 && G)
            (D3 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

          if (!S0 && !S1)
            (posedge G => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && !S1)
            (posedge G => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && S1)
            (posedge G => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && S1)
            (posedge G => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (!S0 && G)
            (negedge S1 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S1 && G)
            (negedge S0 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && G)
            (negedge S1 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S1 && G)
            (posedge S0 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
             
          if (!S0 && G)
            (posedge S1 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S1 && G)
            (negedge S0 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && G)
            (posedge S1 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S1 && G)
            (posedge S0 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
            

      
      $setup(D0, negedge G &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D0, D0, 0.0, NOTIFY_REG);
      $setup(D1, negedge G &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D1, D1, 0.0, NOTIFY_REG);
      $setup(D2, negedge G &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D2, D2, 0.0, NOTIFY_REG);
      $setup(D3, negedge G &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D3, D3, 0.0, NOTIFY_REG);
  
      $setup(S0, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S0, 0.0, NOTIFY_REG);
      $setup(S1, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S1, 0.0, NOTIFY_REG);

      $width(posedge G, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM3A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM3A(D0, D1, D2, D3, S0, S1, G, Q);
    
    input    D0, D1, D2, D3, S0, S1, G;
    output   Q;
    
    reg NOTIFY_REG;
    
    
       U_MUX_4   inst1 (D_EFF, D0, D1, D2, D3, S0, S1);

       ULN   inst2 (Q, D_EFF, G, NOTIFY_REG);
    
                
      
      not    NT1   (S0_, S0);
      nor    NR1   (EN_D0, S0, S1);
      nor    NR2   (EN_D1, S0_, S1);
      and    AN1   (EN_D2, S0_, S1);
      and    AN2   (EN_D3, S0, S1);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";
     


          if (!S0 && !S1 && !G)
            (D0 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!S0 && !S1)
            (negedge G => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && !G)
            (negedge S1 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S1 && !G)
            (negedge S0 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && !S1 && !G)
            (D1 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (S0 && !S1)
            (negedge G => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && !G)
            (negedge S1 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S1 && !G)
            (posedge S0 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
             
          if (!S0 && S1 && !G)
            (D2 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!S0 && S1)
            (negedge G => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && !G)
            (posedge S1 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S1 && !G)
            (negedge S0 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && S1 && !G)
            (D3 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (S0 && S1)
            (negedge G => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && !G)
            (posedge S1 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S1 && !G)
            (posedge S0 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
            

      
      $setup(D0, posedge G &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D0, D0, 0.0, NOTIFY_REG);
      $setup(D1, posedge G &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D1, D1, 0.0, NOTIFY_REG);
      $setup(D2, posedge G &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D2, D2, 0.0, NOTIFY_REG);
      $setup(D3, posedge G &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D3, D3, 0.0, NOTIFY_REG);

      $setup(S0, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S0, 0.0, NOTIFY_REG);
      $setup(S1, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S1, 0.0, NOTIFY_REG);
  
      $width(negedge G, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM4 ( D0, D1, D2, D3, S0, S10, S11, G, Q);
    
    input    D0, D1, D2, D3, S0, S10, S11, G;
    output   Q;
    
    reg NOTIFY_REG;
    
       or        inst1 ( S1, S10, S11);
       U_MUX_4   inst2 (D_EFF, D0, D1, D2, D3, S0, S1);

       ULP   inst3 (Q, D_EFF, G, NOTIFY_REG);
    
                
      
      or     OR1   (ORs10s11, S10, S11);
      not    NT1   (S0_, S0);
      nor    NR1   (EN_D0, S0, ORs10s11);
      nor    NR2   (EN_D1, S0_, ORs10s11);
      and    AN1   (EN_D2, S0_, ORs10s11);
      and    AN2   (EN_D3, S0, ORs10s11);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";
     



          if (!S0 && !(S10 || S11) && G)
            (D0 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (S0 && !(S10 || S11) && G)
            (D1 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (!S0 && (S10 || S11) && G)
            (D2 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          if (S0 && (S10 || S11) && G)
            (D3 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

          if (!S0 && !(S10 || S11))
            (posedge G => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && !(S10 || S11))
            (posedge G => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && (S10 || S11))
            (posedge G => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && (S10 || S11))
            (posedge G => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (!S0 && G && !S11)
            (negedge S10 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && G && !S10)
            (negedge S10 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!(S10 || S11) && G)
            (negedge S0 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && G && !S11)
            (negedge S10 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && G && !S10)
            (negedge S10 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!(S10 || S11) && G)
            (posedge S0 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
             
          if (!S0 && G && !S11)
            (posedge S10 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && G && !S10)
            (posedge S11 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if ((S10 || S11) && G)
            (negedge S0 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && G && !S11)
            (posedge S10 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && G && !S10)
            (posedge S11 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if ((S10 || S11) && G)
            (posedge S0 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
            

      
      $setup(D0, negedge G &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D0, D0, 0.0, NOTIFY_REG);
      $setup(D1, negedge G &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D1, D1, 0.0, NOTIFY_REG);
      $setup(D2, negedge G &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D2, D2, 0.0, NOTIFY_REG);
      $setup(D3, negedge G &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(negedge G &&& EN_D3, D3, 0.0, NOTIFY_REG);
  
      $setup(S0, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S0, 0.0, NOTIFY_REG);
      $setup(S10, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S10, 0.0, NOTIFY_REG);
      $setup(S11, negedge G, 0.0, NOTIFY_REG);
      $hold(negedge G, S11, 0.0, NOTIFY_REG);

      $width(posedge G, 0.0, 0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DLM4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DLM4A ( D0, D1, D2, D3, S0, S10, S11, G, Q);
    
    input    D0, D1, D2, D3, S0, S10, S11, G;
    output   Q;
    
    reg NOTIFY_REG;
    
       or        inst1 ( S1, S10, S11);
       U_MUX_4   inst2 (D_EFF, D0, D1, D2, D3, S0, S1);

       ULN   inst3 (Q, D_EFF, G, NOTIFY_REG);
    
                
      
      or     OR1   (ORs10s11, S10, S11);
      not    NT1   (S0_, S0);
      nor    NR1   (EN_D0, S0, ORs10s11);
      nor    NR2   (EN_D1, S0_, ORs10s11);
      and    AN1   (EN_D2, S0_, ORs10s11);
      and    AN2   (EN_D3, S0, ORs10s11);
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";
     



         
            (D0 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          
            (D1 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          
            (D2 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          
            (D3 +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);

          if (!S0 && !(S10 || S11))
            (negedge G => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && !(S10 || S11))
            (negedge G => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && (S10 || S11))
            (negedge G => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && (S10 || S11))
            (negedge G => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          
            (negedge S10 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          
            (negedge S11 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          
            (negedge S0 => (Q +: D0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && G && S11)
            (negedge S10 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && G && S10)
            (negedge S11 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!(S10 || S11) && G)
            (negedge S0 => (Q +: D1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
             
          if (!S0 && G && S11)
            (negedge S10 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (!S0 && G && S10)
            (negedge S11 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if ((S10 || S11) && G)
            (negedge S0 => (Q +: D2))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

          if (S0 && G && S11)
            (negedge S10 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if (S0 && G && S10)
            (negedge S11 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
          if ((S10 || S11) && G)
            (negedge S0 => (Q +: D3))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
            

      
      $setup(D0, posedge G &&& EN_D0, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D0, D0, 0.0, NOTIFY_REG);
      $setup(D1, posedge G &&& EN_D1, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D1, D1, 0.0, NOTIFY_REG);
      $setup(D2, posedge G &&& EN_D2, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D2, D2, 0.0, NOTIFY_REG);
      $setup(D3, posedge G &&& EN_D3, 0.0, NOTIFY_REG);
      $hold(posedge G &&& EN_D3, D3, 0.0, NOTIFY_REG);
  
      $setup(S0, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S0, 0.0, NOTIFY_REG);
      $setup(S10, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S10, 0.0, NOTIFY_REG);
      $setup(S11, posedge G, 0.0, NOTIFY_REG);
      $hold(posedge G, S11, 0.0, NOTIFY_REG);

      $width(negedge G, 0.0, 0, NOTIFY_REG);

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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$S = 1; 
         specparam   InputLoad$E = 2; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "combWfb";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$QN = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "seq";






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
//-                    cell  DXAND7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXAND7(A, B, C, D, E, F, G, Y);
    
    input A, B, C, D, E, F, G;
    output Y;
    
    and AN1   (Y, A, B, C, D, E, F, G);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$F = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (F => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DXAX7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXAX7(A, B, C, D, E, F, G, H, Y);
    
    input A, B, C, D, E, F, G, H;
    output Y;
    
    and AN1   (Y1, A, B, C, D, E, F, G);
    xor XO1   (Y, Y1, H);	
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$F = 1; 
         specparam   InputLoad$G = 1; 
         specparam   InputLoad$H = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (F => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (H => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DXNAND7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXNAND7(A, B, C, D, E, F, G, Y);
    
    input A, B, C, D, E, F, G;
    output Y;
    
    nand AN1   (Y, A, B, C, D, E, F, G);
    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$F = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";





    
        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (F => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (G => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DXRAM4A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXRAM4A( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK, WEN, 
                WD0, WD1, WD2, WD3, RDAD0, RDAD1, RDAD2, RDAD3,
                 RDAD4, RDAD5, RD0, RD1, RD2, RD3 );

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0; 
output RD3, RD2, RD1, RD0;

reg [3:0] ram64[63:0];

always @(WCLK === 1'bx && $time > 0)
begin
  $display("Error : WCLK went unknown at time %0.1f\n",$realtime);
end

assign
  {RD3,RD2,RD1,RD0} = ram64[{RDAD5,RDAD4,RDAD3,RDAD2,RDAD1,RDAD0}];

always @(posedge WCLK)
begin
     if (WEN == 1)
     begin
        if ( (WRAD5 == 1 || WRAD5 == 0) &&
             (WRAD4 == 1 || WRAD4 == 0) &&
             (WRAD3 == 1 || WRAD3 == 0) &&
             (WRAD2 == 1 || WRAD2 == 0) &&
             (WRAD1 == 1 || WRAD1 == 0) &&
             (WRAD0 == 1 || WRAD0 == 0) )
            ram64[{WRAD5,WRAD4,WRAD3,WRAD2,WRAD1,WRAD0}] <= {WD3,WD2,WD1,WD0};
        else
            $display("Error : WRAD went unknown at time %0.1f\n",$realtime);
     end
     else
     if (WEN !== 0)
        $display("Error : WEN went unknown at time %0.1f\n",$realtime);
end

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  DXRAM4S.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXRAM4S( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK, WEN, 
                WD0, WD1, WD2, WD3, RDAD0, RDAD1, RDAD2, RDAD3,
                 RDAD4, RDAD5, RCLK, REN, RD0, RD1, RD2, RD3 );

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RCLK, REN, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0; 
output RD3, RD2, RD1, RD0;

reg [3:0] ram64[63:0];
reg RD33, RD22, RD11, RD00;

buf inst1(RD3,RD33);
buf inst2(RD2,RD22);
buf inst3(RD1,RD11);
buf inst4(RD0,RD00);

always @(WCLK === 1'bx && $time > 0)
begin
  $display("Error : WCLK went unknown at time %0.1f\n",$realtime);
end

always @(RCLK === 1'bx && $time > 0)
begin
  $display("Error : RCLK went unknown at time %0.1f\n",$realtime);
  {RD33,RD22,RD11,RD00} <= 4'bxxxx;
end

always @(posedge RCLK)
begin
     if (REN == 1)
     begin
        if ( RDAD5 !== 1'bx  && RDAD4 !== 1'bx  &&
             RDAD3 !== 1'bx  && RDAD2 !== 1'bx  &&
             RDAD1 !== 1'bx  && RDAD0 !== 1'bx )
          {RD33,RD22,RD11,RD00} = ram64[{RDAD5,RDAD4,RDAD3,RDAD2,RDAD1,RDAD0}];
        else
        begin
            $display("Error : RDAD went unknown at time %0.1f\n",$realtime);
            {RD33,RD22,RD11,RD00} <= 4'bxxxx;
        end
     end
     else
     if (REN !== 0)
     begin
        $display("Error : REN went unknown at time %0.1f\n",$realtime);
        {RD33,RD22,RD11,RD00} <= 4'bxxxx;
     end
end

always @(posedge WCLK)
begin
     if (WEN == 1)
     begin
        if ( (WRAD5 == 1 || WRAD5 == 0) &&
             (WRAD4 == 1 || WRAD4 == 0) &&
             (WRAD3 == 1 || WRAD3 == 0) &&
             (WRAD2 == 1 || WRAD2 == 0) &&
             (WRAD1 == 1 || WRAD1 == 0) &&
             (WRAD0 == 1 || WRAD0 == 0) )
            ram64[{WRAD5,WRAD4,WRAD3,WRAD2,WRAD1,WRAD0}] = {WD3,WD2,WD1,WD0};
        else
            $display("Error : WRAD went unknown at time %0.1f\n",$realtime);
     end
     else
     if (WEN !== 0)
        $display("Error : WEN went unknown at time %0.1f\n",$realtime);
end

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  DXRAM4S2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXRAM4S2( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK, WEN, 
                WD0, WD1, WD2, WD3, RDAD0, RDAD1, RDAD2, RDAD3,
                 RDAD4, RDAD5, RCLK, REN, RD0, RD1, RD2, RD3 );

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RCLK, REN, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0; 
output RD3, RD2, RD1, RD0;

reg [3:0] ram64[63:0];
reg RD33, RD22, RD11, RD00;

buf inst1(RD3,RD33);
buf inst2(RD2,RD22);
buf inst3(RD1,RD11);
buf inst4(RD0,RD00);

always @(WCLK === 1'bx && $time > 0)
begin
  $display("Error : WCLK went unknown at time %0.1f\n",$realtime);
end

always @(RCLK === 1'bx && $time > 0)
begin
  $display("Error : RCLK went unknown at time %0.1f\n",$realtime);
  {RD33,RD22,RD11,RD00} <= 4'bxxxx;
end

always @(posedge RCLK)
begin
     if (REN == 1)
     begin
        if ( (RDAD5 == 1 || RDAD5 == 0) &&
             (RDAD4 == 1 || RDAD4 == 0) &&
             (RDAD3 == 1 || RDAD3 == 0) &&
             (RDAD2 == 1 || RDAD2 == 0) &&
             (RDAD1 == 1 || RDAD1 == 0) &&
             (RDAD0 == 1 || RDAD0 == 0) )
          {RD33,RD22,RD11,RD00} = ram64[{RDAD5,RDAD4,RDAD3,RDAD2,RDAD1,RDAD0}];
        else
        begin
            $display("Error : RDAD went unknown at time %0.1f\n",$realtime);
            {RD33,RD22,RD11,RD00} <= 4'bxxxx;
        end
     end
     else
     if (REN !== 0)
     begin
        $display("Error : REN went unknown at time %0.1f\n",$realtime);
        {RD33,RD22,RD11,RD00} <= 4'bxxxx;
     end
end

always @(negedge WCLK)
begin
     if (WEN == 1)
     begin
        if ( (WRAD5 == 1 || WRAD5 == 0) &&
             (WRAD4 == 1 || WRAD4 == 0) &&
             (WRAD3 == 1 || WRAD3 == 0) &&
             (WRAD2 == 1 || WRAD2 == 0) &&
             (WRAD1 == 1 || WRAD1 == 0) &&
             (WRAD0 == 1 || WRAD0 == 0) )
            ram64[{WRAD5,WRAD4,WRAD3,WRAD2,WRAD1,WRAD0}] = {WD3,WD2,WD1,WD0};
        else
            $display("Error : WRAD went unknown at time %0.1f\n",$realtime);
     end
     else
     if (WEN !== 0)
        $display("Error : WEN went unknown at time %0.1f\n",$realtime);
end

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  DXRAM8A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXRAM8A( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK, WEN, WD0, WD1, WD2, 
                WD3, WD4, WD5, WD6, WD7, RDAD0, RDAD1, RDAD2, RDAD3,
                 RDAD4, RD0, RD1, RD2, RD3, RD4, RD5, RD6, RD7 );

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0; 
output RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;

reg [7:0] ram32[31:0];

always @(WCLK === 1'bx && $time > 0)
begin
  $display("Error : WCLK went unknown at time %0.1f\n",$realtime);
end

assign
  {RD7,RD6,RD5,RD4,RD3,RD2,RD1,RD0} = ram32[{RDAD4,RDAD3,RDAD2,RDAD1,RDAD0}];

always @(posedge WCLK)
begin
     if (WEN == 1)
     begin
        if ( (WRAD4 == 1 || WRAD4 == 0) &&
             (WRAD3 == 1 || WRAD3 == 0) &&
             (WRAD2 == 1 || WRAD2 == 0) &&
             (WRAD1 == 1 || WRAD1 == 0) &&
             (WRAD0 == 1 || WRAD0 == 0) )
            ram32[{WRAD4,WRAD3,WRAD2,WRAD1,WRAD0}] <= {WD7,WD6,WD5,WD4,WD3,WD2,WD1,WD0};
        else
            $display("Error : WRAD went unknown at time %0.1f\n",$realtime);
     end
     else
     if (WEN !== 0)
        $display("Error : WEN went unknown at time %0.1f\n",$realtime);
end

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  DXRAM8S.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXRAM8S( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK, WEN, WD0, WD1, WD2, 
                WD3, WD4, WD5, WD6, WD7, RDAD0, RDAD1, RDAD2, RDAD3,
                 RDAD4, RCLK, REN, RD0, RD1, RD2, RD3, RD4, RD5, RD6, RD7 );

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RCLK, REN;
input RDAD1, RDAD0, RDAD4, RDAD3, RDAD2; 
output RD3, RD2, RD1, RD0, RD4, RD5, RD6, RD7;

reg [7:0] ram32[31:0];
reg RD77, RD66, RD55, RD44, RD33, RD22, RD11, RD00;

buf inst1(RD3,RD33);
buf inst2(RD2,RD22);
buf inst3(RD1,RD11);
buf inst4(RD0,RD00);
buf inst5(RD4,RD44);
buf inst6(RD5,RD55);
buf inst7(RD6,RD66);
buf inst8(RD7,RD77);

always @(WCLK === 1'bx && $time > 0)
begin
  $display("Error : WCLK went unknown at time %0.1f\n",$realtime);
end

always @(RCLK === 1'bx && $time > 0)
begin
  $display("Error : RCLK went unknown at time %0.1f\n",$realtime);
  {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} <= 8'bxxxxxxxx;
end

always @(posedge RCLK)
begin
     if (REN == 1)
     begin
        if ( (RDAD4 == 1 || RDAD4 == 0) &&
             (RDAD3 == 1 || RDAD3 == 0) &&
             (RDAD2 == 1 || RDAD2 == 0) &&
             (RDAD1 == 1 || RDAD1 == 0) &&
             (RDAD0 == 1 || RDAD0 == 0) )
          {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} = ram32[{RDAD4,RDAD3,RDAD2,RDAD1,RDAD0}];
        else
        begin
            $display("Error : RDAD went unknown at time %0.1f\n",$realtime);
            {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} <= 8'bxxxxxxxx;
        end
     end
     else
     if (REN !== 0)
     begin
        {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} <= 8'bxxxxxxxx;
        $display("Error : REN went unknown at time %0.1f\n",$realtime);
     end
end

always @(posedge WCLK)
begin
     if (WEN == 1)
     begin
        if ( (WRAD4 == 1 || WRAD4 == 0) &&
             (WRAD3 == 1 || WRAD3 == 0) &&
             (WRAD2 == 1 || WRAD2 == 0) &&
             (WRAD1 == 1 || WRAD1 == 0) &&
             (WRAD0 == 1 || WRAD0 == 0) )
            ram32[{WRAD4,WRAD3,WRAD2,WRAD1,WRAD0}] = {WD7,WD6,WD5,WD4,WD3,WD2,WD1,WD0};
        else
            $display("Error : WRAD went unknown at time %0.1f\n",$realtime);
     end
     else
     if (WEN == 0)
     begin
     end
     else
        $display("Error : WEN went unknown at time %0.1f\n",$realtime);
end

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  DXRAM8S2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DXRAM8S2( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK, WEN, WD0, WD1, WD2, 
                WD3, WD4, WD5, WD6, WD7, RDAD0, RDAD1, RDAD2, RDAD3,
                 RDAD4, RCLK, REN, RD0, RD1, RD2, RD3, RD4, RD5, RD6, RD7 );

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RCLK, REN;
input RDAD1, RDAD0, RDAD4, RDAD3, RDAD2; 
output RD3, RD2, RD1, RD0, RD4, RD5, RD6, RD7;

reg [7:0] ram32[31:0];
reg RD77, RD66, RD55, RD44, RD33, RD22, RD11, RD00;

buf inst1(RD3,RD33);
buf inst2(RD2,RD22);
buf inst3(RD1,RD11);
buf inst4(RD0,RD00);
buf inst5(RD4,RD44);
buf inst6(RD5,RD55);
buf inst7(RD6,RD66);
buf inst8(RD7,RD77);

always @(WCLK === 1'bx && $time > 0)
begin
  $display("Error : WCLK went unknown at time %0.1f\n",$realtime);
end

always @(RCLK === 1'bx && $time > 0)
begin
  $display("Error : RCLK went unknown at time %0.1f\n",$realtime);
  {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} <= 8'bxxxxxxxx;
end

always @(posedge RCLK)
begin
     if (REN == 1)
     begin
        if ( (RDAD4 == 1 || RDAD4 == 0) &&
             (RDAD3 == 1 || RDAD3 == 0) &&
             (RDAD2 == 1 || RDAD2 == 0) &&
             (RDAD1 == 1 || RDAD1 == 0) &&
             (RDAD0 == 1 || RDAD0 == 0) )
          {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} = ram32[{RDAD4,RDAD3,RDAD2,RDAD1,RDAD0}];
        else
        begin
            $display("Error : RDAD went unknown at time %0.1f\n",$realtime);
            {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} <= 8'bxxxxxxxx;
        end
     end
     else
     if (REN !== 0)
     begin
        {RD77,RD66,RD55,RD44,RD33,RD22,RD11,RD00} <= 8'bxxxxxxxx;
        $display("Error : REN went unknown at time %0.1f\n",$realtime);
     end
end

always @(negedge WCLK)
begin
     if (WEN == 1)
     begin
        if ( (WRAD4 == 1 || WRAD4 == 0) &&
             (WRAD3 == 1 || WRAD3 == 0) &&
             (WRAD2 == 1 || WRAD2 == 0) &&
             (WRAD1 == 1 || WRAD1 == 0) &&
             (WRAD0 == 1 || WRAD0 == 0) )
            ram32[{WRAD4,WRAD3,WRAD2,WRAD1,WRAD0}] = {WD7,WD6,WD5,WD4,WD3,WD2,WD1,WD0};
        else
            $display("Error : WRAD went unknown at time %0.1f\n",$realtime);
     end
     else
     if (WEN !== 0)
        $display("Error : WEN went unknown at time %0.1f\n",$realtime);
end

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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 3; 
         specparam   InputLoad$B = 3; 
         specparam   InputLoad$CI = 3; 
         specparam   OutputLoad$CO = 2; 
         specparam   OutputLoad$S = 0;
      
         specparam   MacroType = "sdlm";
         specparam   InternalPinName        = "CO";
         specparam   ExtraDelayPaths$A$CO   = 0;
         specparam   ExtraDelayPaths$B$CO   = 0;
         specparam   ExtraDelayPaths$CI$CO  = 0;
         specparam   ExtraDelayPaths$A$S    = 1;
         specparam   ExtraDelayPaths$B$S    = 1;
         specparam   ExtraDelayPaths$CI$S   = 1;





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 3; 
         specparam   InputLoad$CI = 3; 
         specparam   OutputLoad$CO = 2; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";
         specparam   InternalPinName        = "CO";
         specparam   ExtraDelayPaths$A$CO   = 0;
         specparam   ExtraDelayPaths$B$CO   = 0;
         specparam   ExtraDelayPaths$CI$CO  = 0;
         specparam   ExtraDelayPaths$A$S    = 1;
         specparam   ExtraDelayPaths$B$S    = 1;
         specparam   ExtraDelayPaths$CI$S   = 1;
      



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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A0 = 2; 
         specparam   InputLoad$A1 = 2; 
         specparam   InputLoad$B = 3; 
         specparam   InputLoad$CI = 3; 
         specparam   OutputLoad$CO = 2; 
         specparam   OutputLoad$S = 0;

         specparam   MacroType = "sdlm";
         specparam   InternalPinName        = "CO";
         specparam   ExtraDelayPaths$A0$CO  = 0;
         specparam   ExtraDelayPaths$A1$CO  = 0;
         specparam   ExtraDelayPaths$B$CO   = 0;
         specparam   ExtraDelayPaths$CI$CO  = 0;
         specparam   ExtraDelayPaths$A0$S   = 1;
         specparam   ExtraDelayPaths$A1$S   = 1;
         specparam   ExtraDelayPaths$B$S    = 1;
         specparam   ExtraDelayPaths$CI$S   = 1;

         



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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 2; 
         specparam   InputLoad$B = 2; 
         specparam   OuputLoad$CO = 0; 
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

         specparam   LibName     = "3200dx";
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
//-                    cell  IBDL.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module IBDL(PAD, G, Q);
    
    input   PAD, G;
    output  Q;
        
    reg  NOTIFY_REG ;

    ULN   inst1  (Q, PAD, G, NOTIFY_REG); 

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0; 
         specparam   InputLoad$PAD = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "io";
  



    if (!G)
    (PAD +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (negedge G => (Q +: PAD)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(PAD, posedge G, 0.0, NOTIFY_REG);
    $hold(posedge G, PAD, 0.0, NOTIFY_REG);

    $width(negedge G, 0.0, 0, NOTIFY_REG); 

    
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  IR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module IR ( PAD, CLK, Q);

input PAD, CLK;
output Q;

reg NOTIFY_REG;

	ULN	U0 (int_q, PAD, CLK, NOTIFY_REG);
	ULP	U1 (Q, int_q, CLK, NOTIFY_REG);

    specify

        specparam Libname = "3200dx";
        specparam MacroType = "io";

    if (CLK)
    (PAD +=> Q) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (Q +: PAD)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
 
    $setup(PAD, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, PAD, 0.0, NOTIFY_REG);
 
    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);


    endspecify
    
endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  IRI.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module IRI(CLK,PAD,QN);
input CLK, PAD;
output  QN;

reg NOTIFY_REG;
    
    ULN U0(int_q, PAD, CLK, NOTIFY_REG);
    ULPQ U1(QN, int_q, CLK, NOTIFY_REG);

    specify
      
    specparam Libname = "3200dx";
 
    if (CLK)
    (PAD +=> QN) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (QN +: PAD)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(PAD, posedge CLK, 0.0, NOTIFY_REG);
    $hold(posedge CLK, PAD, 0.0, NOTIFY_REG);
 
    $width(posedge CLK, 0.0, 0, NOTIFY_REG); 
    $width(negedge CLK, 0.0, 0, NOTIFY_REG);

 
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";




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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

         specparam   InternalPinName = "X";
         specparam   ExtraDelayPin   = "CLR";




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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$S = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$S$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;





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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$S0A = 1; 
         specparam   InputLoad$S0B = 1; 
         specparam   InputLoad$S1 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$D0$Y   = 1;
         specparam   ExtraDelayPaths$D1$Y   = 1;
         specparam   ExtraDelayPaths$S0A$Y  = 1;
         specparam   ExtraDelayPaths$D2$Y   = 0;
         specparam   ExtraDelayPaths$D3$Y   = 0;
         specparam   ExtraDelayPaths$S0B$Y  = 0;
         specparam   ExtraDelayPaths$S1$Y   = 0;





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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;





    
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  NAND5C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND5C(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    or       OR1   (A_INT, A, B);
    U_OR4_B  inst1 (Y, E, D, C, A_INT);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;





    
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  NOR5C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR5C(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    and       AN1   (A_INT, A, B);
    U_AND4_B  inst1 (Y, E, D, C, A_INT);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  OA4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OA4(A, B, C, D, Y);
    
    input A, B, C, D;
    output Y;
    
    not         NT1   (C_INT, C);
    U_OA_4A     inst1 (Y, A, B, C_INT, D);
       
    specify

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
//-                    cell  OBDLHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OBDLHS(D, G, PAD);
    
    input   D, G;
    output  PAD;
        
    reg  NOTIFY_REG ;

    ULP   inst1  (PAD, D, G, NOTIFY_REG); 

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "io";
  



    if (G)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge G => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(D, negedge G, 0.0, NOTIFY_REG);
    $hold(negedge G, D, 0.0, NOTIFY_REG);

    $width(posedge G, 0.0, 0, NOTIFY_REG); 

    
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  OBHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OBHS(D, PAD);
    
    input   D;
    output  PAD;
        
    buf      BF1  (PAD, D);

    specify

         specparam   LibName     = "3200dx";
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1;

         specparam   MacroType = "io";
  



    (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "dlm";
         specparam   InternalPinName       = "X";
         specparam   ExtraDelayPaths$A$Y   = 1;
         specparam   ExtraDelayPaths$B$Y   = 1;
         specparam   ExtraDelayPaths$C$Y   = 0;
         specparam   ExtraDelayPaths$D$Y   = 0;





    
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
//-                    cell  OR5B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR5B(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    or       OR1   (D_INT, D, E);
    U_OR4_B  inst1 (Y, A, B, C, D_INT);
       
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 1; 
         specparam   InputLoad$B = 1; 
         specparam   InputLoad$C = 1; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (B => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (C => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (D => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        (E => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  ORH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module ORH ( D, CLK, PAD);

input D, CLK;
output PAD;

reg NOTIFY_REG;

	ULN	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD, int_q, CLK, NOTIFY_REG);

    specify

    if (CLK)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        
 
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
//-                    cell  ORIH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module ORIH ( D, CLK, PAD);

input D, CLK;
output PAD;

reg NOTIFY_REG;

	ULNQ	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD, int_q, CLK, NOTIFY_REG);


specify

 if (CLK)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
        

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
//-                    cell  ORITH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module ORITH ( D, CLK, E, PAD);

input D, E, CLK;
output PAD;

reg NOTIFY_REG;

	ULNQ	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD_INT, int_q, CLK, NOTIFY_REG);
        bufif1  BUFIF1 (PAD, PAD_INT, E);

    specify

    if (CLK && E)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    if(E)
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
        

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
//-                    cell  ORTH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module ORTH ( D, CLK, E, PAD);

input D, E, CLK;
output PAD;

reg NOTIFY_REG;

	ULN	U0 (int_q, D, CLK, NOTIFY_REG);
	ULP	U1 (PAD_INT, int_q, CLK, NOTIFY_REG);
        bufif1  BFIF1 (PAD, PAD_INT, E);


    specify

    if (CLK && E)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    if(E)
    (posedge CLK => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
        

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

         specparam   LibName     = "3200dx";
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
//-                    cell  QCLKBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module QCLKBUF(PAD, Y);
    
    input PAD;
    output Y;
    
    buf  BF1  (Y, PAD);
    
    specify

         specparam   LibName     = "3200dx";
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
//-                    cell  QCLKINT.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module QCLKINT(A, Y);
    
    input A;
    output Y;
    
    buf    BF1 (Y, A);
               
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$A = 0; 
         specparam   OutputLoad$Y = 0;
         specparam   MacroType   = "io";



        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  RAM4FA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM4FA( WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD3, WD2, WD1, WD0, 
               RDAD5, RDAD4, RDAD3, RDAD2, RDAD1, RDAD0,
               BLKEN, BLKENS, WEN, WCLK, 
               RD3, RD2, RD1, RD0 );

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
not  inst3(WCLK1, WCLK);
buf  inst5(RD3, RD33);
buf  inst6(RD2, RD22);
buf  inst7(RD1, RD11);
buf  inst8(RD0, RD00);
buf  inst9(RDAD00, RDAD0);
buf  inst10(RDAD11, RDAD1);
buf  inst11(RDAD22, RDAD2);
buf  inst12(RDAD33, RDAD3);
buf  inst13(RDAD44, RDAD4);
buf  inst14(RDAD55, RDAD5);
DXRAM4A inst4( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK1, WEN_EFF,
               WD0, WD1, WD2, WD3, RDAD00, RDAD11, RDAD22, RDAD33,
               RDAD44, RDAD55, RD00, RD11, RD22, RD33 );

specify
      specparam   LibName     = "3200dx";

      (negedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
      (RDAD0 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, negedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD5, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);

endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM4FF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM4FF( WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD3, WD2, WD1, WD0,  
               RDAD5, RDAD4, RDAD3, RDAD2, RDAD1, RDAD0, 
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK, 
               RD3, RD2, RD1, RD0 ); 

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RCLK, REN, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
not  inst3(RCLK1, RCLK);
not  inst4(WCLK1, WCLK);
DXRAM4S inst5( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK1, WEN_EFF,
               WD0, WD1, WD2, WD3, RDAD0, RDAD1, RDAD2, RDAD3,
               RDAD4, RDAD5, RCLK1, REN, RD0, RD1, RD2, RD3 );

specify
      specparam   LibName     = "3200dx";

      (negedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      (negedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, negedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD5, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, negedge RCLK, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD5, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD5 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM4FR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM4FR( WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD3, WD2, WD1, WD0,  
               RDAD5, RDAD4, RDAD3, RDAD2, RDAD1, RDAD0, 
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK, 
               RD3, RD2, RD1, RD0 ); 

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RCLK, REN, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
buf inst4(WCLK1, WCLK);
buf inst5(RCLK1, RCLK);
DXRAM4S2 inst3( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK1, WEN_EFF,
               WD0, WD1, WD2, WD3, RDAD0, RDAD1, RDAD2, RDAD3,
               RDAD4, RDAD5, RCLK1, REN, RD0, RD1, RD2, RD3 );

specify
      specparam   LibName     = "3200dx";

      (posedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      (negedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, negedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD5, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD5, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD5 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM4RA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM4RA( WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD3, WD2, WD1, WD0,
               RDAD5, RDAD4, RDAD3, RDAD2, RDAD1, RDAD0,
               BLKEN, BLKENS, WEN, WCLK, 
               RD3, RD2, RD1, RD0 );

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
buf  inst4(RD3, RD33);
buf  inst5(RD2, RD22);
buf  inst6(RD1, RD11);
buf  inst7(RD0, RD00);
buf  inst8(WCLK1, WCLK);
buf  inst9(RDAD00, RDAD0);
buf  inst10(RDAD11, RDAD1);
buf  inst11(RDAD22, RDAD2);
buf  inst12(RDAD33, RDAD3);
buf  inst13(RDAD44, RDAD4);
buf  inst14(RDAD55, RDAD5);
DXRAM4A inst3( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK1, WEN_EFF,
               WD0, WD1, WD2, WD3, RDAD00, RDAD11, RDAD22, RDAD33,
               RDAD44, RDAD55, RD00, RD11, RD22, RD33 );

specify
      specparam   LibName     = "3200dx";

      (posedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
      (RDAD0 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD5 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, posedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD5, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);

endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM4RF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM4RF( WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD3, WD2, WD1, WD0,  
               RDAD5, RDAD4, RDAD3, RDAD2, RDAD1, RDAD0, 
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK, 
               RD3, RD2, RD1, RD0 ); 

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RCLK, REN, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
not  inst3(RCLK1, RCLK);
buf  inst5(WCLK1, WCLK);
DXRAM4S inst4( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK1, WEN_EFF,
               WD0, WD1, WD2, WD3, RDAD0, RDAD1, RDAD2, RDAD3,
               RDAD4, RDAD5, RCLK1, REN, RD0, RD1, RD2, RD3 );

specify
      specparam   LibName     = "3200dx";

      (negedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      (posedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, posedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD5, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, negedge RCLK, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD5, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD5 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM4RR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM4RR( WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD3, WD2, WD1, WD0, 
               RDAD5, RDAD4, RDAD3, RDAD2, RDAD1, RDAD0,
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK,
               RD3, RD2, RD1, RD0 );

input WCLK, WEN, WRAD5, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD3, WD2, WD1, WD0, RCLK, REN, RDAD5, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
buf inst4(WCLK1, WCLK);
buf inst5(RCLK1, RCLK);
DXRAM4S inst3( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WRAD5, WCLK1, WEN_EFF,
               WD0, WD1, WD2, WD3, RDAD0, RDAD1, RDAD2, RDAD3,
               RDAD4, RDAD5, RCLK1, REN, RD0, RD1, RD2, RD3 );

specify
      specparam   LibName     = "3200dx";

      (posedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, posedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD5, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD5, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD5 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM8FA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM8FA( WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, 
               RDAD4, RDAD3, RDAD2, RDAD1, RDAD0,
               BLKEN, BLKENS, WEN, WCLK, 
               RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0 );

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
not  inst3(WCLK1, WCLK);
buf  inst17(RD7, RD77);
buf  inst16(RD6, RD66);
buf  inst15(RD5, RD55);
buf  inst14(RD4, RD44);
buf  inst5(RD3, RD33);
buf  inst6(RD2, RD22);
buf  inst7(RD1, RD11);
buf  inst8(RD0, RD00);
buf  inst9(RDAD00, RDAD0);
buf  inst10(RDAD11, RDAD1);
buf  inst11(RDAD22, RDAD2);
buf  inst12(RDAD33, RDAD3);
buf  inst13(RDAD44, RDAD4);
DXRAM8A inst4( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK1, WEN_EFF, WD0, WD1, 
               WD2, WD3, WD4, WD5, WD6, WD7, RDAD00, RDAD11, RDAD22, RDAD33,
               RDAD44, RD00, RD11, RD22, RD33, RD44, RD55, RD66, RD77 );

specify
      specparam   LibName     = "3200dx";

      (negedge WCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
      (RDAD0 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, negedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD7, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD7 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD6, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD6 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD5, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);

endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM8FF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM8FF( WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0,  
               RDAD4, RDAD3, RDAD2, RDAD1, RDAD0, 
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK, 
               RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0 ); 

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RCLK, REN, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
not  inst3(RCLK1, RCLK);
not  inst4(WCLK1, WCLK);
DXRAM8S inst5( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK1, WEN_EFF, WD0, WD1, 
               WD2, WD3, WD4, WD5, WD6, WD7, RDAD0, RDAD1, RDAD2, RDAD3,
               RDAD4, RCLK1, REN, RD0, RD1, RD2, RD3, RD4, RD5, RD6, RD7 );

specify
      specparam   LibName     = "3200dx";

      (negedge RCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, negedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD7, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD7 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD6, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD6 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD5, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, negedge RCLK, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM8FR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM8FR( WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0,  
               RDAD4, RDAD3, RDAD2, RDAD1, RDAD0, 
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK, 
               RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0 ); 

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RCLK, REN, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
buf inst4(WCLK1, WCLK);
buf inst5(RCLK1, RCLK);
DXRAM8S2 inst3( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK1, WEN_EFF, WD0, WD1, 
               WD2, WD3, WD4, WD5, WD6, WD7, RDAD0, RDAD1, RDAD2, RDAD3,
               RDAD4, RCLK1, REN, RD0, RD1, RD2, RD3, RD4, RD5, RD6, RD7 );

specify
      specparam   LibName     = "3200dx";

      (posedge RCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, negedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD7, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD7 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD6, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD6 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD5, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD4, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, negedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(negedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM8RA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM8RA( WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0,
               RDAD4, RDAD3, RDAD2, RDAD1, RDAD0,
               BLKEN, BLKENS, WEN, WCLK, 
               RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0 );

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
buf  inst17(RD7, RD77);
buf  inst16(RD6, RD66);
buf  inst15(RD5, RD55);
buf  inst14(RD4, RD44);
buf  inst4(RD3, RD33);
buf  inst5(RD2, RD22);
buf  inst6(RD1, RD11);
buf  inst7(RD0, RD00);
buf  inst8(WCLK1, WCLK);
buf  inst9(RDAD00, RDAD0);
buf  inst10(RDAD11, RDAD1);
buf  inst11(RDAD22, RDAD2);
buf  inst12(RDAD33, RDAD3);
buf  inst13(RDAD44, RDAD4);
DXRAM8A inst3( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK1, WEN_EFF, WD0, WD1, 
               WD2, WD3, WD4, WD5, WD6, WD7, RDAD00, RDAD11, RDAD22, RDAD33,
               RDAD44, RD00, RD11, RD22, RD33, RD44, RD55, RD66, RD77 );

specify
      specparam   LibName     = "3200dx";

      (posedge WCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
 
      (RDAD0 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD0 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD1 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD2 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD3 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD0) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD1) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD2) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD3) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD4) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD5) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD6) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (RDAD4 => RD7) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, posedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD7, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD7 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD6, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD6 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD5, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);

endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM8RF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM8RF( WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0,  
               RDAD4, RDAD3, RDAD2, RDAD1, RDAD0, 
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK, 
               RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0 ); 

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RCLK, REN, RDAD4, RDAD3, RDAD2; 
input RDAD1, RDAD0, BLKEN, BLKENS; 
output RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
not  inst3(RCLK1, RCLK);
buf  inst5(WCLK1, WCLK);
DXRAM8S inst4( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK1, WEN_EFF, WD0, WD1, 
               WD2, WD3, WD4, WD5, WD6, WD7, RDAD0, RDAD1, RDAD2, RDAD3, 
               RDAD4, RCLK1, REN, RD0, RD1, RD2, RD3, RD4, RD5, RD6, RD7 );

specify
      specparam   LibName     = "3200dx";

      (negedge RCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (negedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);


      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, posedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD7, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD7 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD6, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD6 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD5, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, negedge RCLK, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, negedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(negedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  RAM8RR.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module RAM8RR( WRAD4, WRAD3, WRAD2, WRAD1, WRAD0, 
               WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, 
               RDAD4, RDAD3, RDAD2, RDAD1, RDAD0,
               BLKEN, BLKENS, WEN, WCLK, REN, RCLK,
               RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0 );

input WCLK, WEN, WRAD4, WRAD3, WRAD2, WRAD1, WRAD0;
input WD7, WD6, WD5, WD4, WD3, WD2, WD1, WD0, RCLK, REN, RDAD4; 
input RDAD1, RDAD0, BLKEN, BLKENS, RDAD3, RDAD2; 
output RD7, RD6, RD5, RD4, RD3, RD2, RD1, RD0;

reg NOTIFY_REG;

xnor inst1(BLK, BLKEN, BLKENS);
and  inst2(WEN_EFF, BLK, WEN);
buf inst4(WCLK1, WCLK);
buf inst5(RCLK1, RCLK);
DXRAM8S inst3( WRAD0, WRAD1, WRAD2, WRAD3, WRAD4, WCLK1, WEN_EFF, WD0, WD1, 
               WD2, WD3, WD4, WD5, WD6, WD7, RDAD0, RDAD1, RDAD2, RDAD3,
               RDAD4, RCLK1, REN, RD0, RD1, RD2, RD3, RD4, RD5, RD6, RD7 );

specify
      specparam   LibName     = "3200dx";

      (posedge RCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge RCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD7+:RD7) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD6+:RD6) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD5+:RD5) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD4+:RD4) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD3+:RD3) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD2+:RD2) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD1+:RD1) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);
      (posedge WCLK => (RD0+:RD0) ) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      $width(posedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(negedge WCLK &&& WEN_EFF, 0.0, 0, NOTIFY_REG);
      $width(posedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $width(negedge RCLK &&& REN, 0.0, 0, NOTIFY_REG);
      $setup(BLKEN, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, BLKEN &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WEN, posedge WCLK &&& BLK, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WEN &&& BLK, 0.0, NOTIFY_REG);
      $setup(WRAD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WRAD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WRAD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD7, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD7 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD6, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD6 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD5, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD5 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD4, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD4 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD3, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD3 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD2, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD2 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD1, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD1 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(WD0, posedge WCLK &&& WEN_EFF, 0.0, NOTIFY_REG);
      $hold(posedge WCLK, WD0 &&& WEN_EFF, 0.0, NOTIFY_REG);
      $setup(REN, posedge RCLK, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, REN, 0.0, NOTIFY_REG);
      $setup(RDAD4, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD4 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD3, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD3 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD2, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD2 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD1, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD1 &&& REN, 0.0, NOTIFY_REG);
      $setup(RDAD0, posedge RCLK &&& REN, 0.0, NOTIFY_REG);
      $hold(posedge RCLK, RDAD0 &&& REN, 0.0, NOTIFY_REG);



endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  TBDLHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TBDLHS(D, E, G, PAD);
    
    input   D, E, G;
    output  PAD;
        
    reg  NOTIFY_REG ;

    ULP   inst1  (PAD_INT, D, G, NOTIFY_REG); 
    bufif1      BFIF1  (PAD, PAD_INT, E);

    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";
         specparam   LatchType   = "io";
  



    if (G && E)
    (D +=> PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
   
    if(E)
    (posedge G => (PAD +: D)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
        

    $setup(D, negedge G, 0.0, NOTIFY_REG);
    $hold(negedge G, D, 0.0, NOTIFY_REG);

    $width(posedge G, 0.0, 0, NOTIFY_REG); 

    
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TBHS.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TBHS(D, E, PAD);
    
    input   D, E;
    output  PAD;
        
    bufif1      BFIF1  (PAD, D, E);

    specify

         specparam   LibName     = "3200dx";
         specparam   OutputLoad$PAD = 0; 
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1;

         specparam   MacroType = "io";
  



    (E => PAD) = (0, 0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0, 1.0:1.0:1.0);
    (D => PAD) = (1.0:1.0:1.0, 1.0:1.0:1.0);
    
    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TF1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TF1A(T, CLK, CLR, Q);
    
    input    T, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
      
       not              NT1   (Q_, Q_INT);
       
       U_MUX_2  #(1.0:1.0:1.0)   M1 (D_EFF, Q_INT, Q_, T);
      
       UFPRB     inst2 (Q_INT, D_EFF, CLK, CLR, NOTIFY_REG);
      
       buf              BF1   (Q, Q_INT);

       and              AN1   (EN, CLR, T);
                

    
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$T = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";     
      


         specparam   DelayOverride$M1 = 1.0:1.0:1.0;    


      if(T && CLR)
      (posedge CLK => (Q -: Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  
      
      (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);     


      $setup(T, posedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(posedge CLK, T &&& CLR, 0.0, NOTIFY_REG);

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);
 
      $width(posedge CLK &&& EN, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& EN, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
   
      $recovery(posedge CLR, posedge CLK, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  TF1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module TF1B(T, CLK, CLR, Q);
    
    input    T, CLK, CLR;
    output   Q;
    
    reg NOTIFY_REG;
      

      not              NT1   (Q_, Q_INT);
      
       U_MUX_2  
             #(1.0:1.0:1.0)  M1 (D_EFF, Q_INT, Q_, T);
      
       UFNRB    inst2 (Q_INT, D_EFF, CLK, CLR, NOTIFY_REG);
      
       buf              BF1   (Q, Q_INT);

       and              AN1   (EN, CLR, T);
                       
      
    specify

         specparam   LibName     = "3200dx";
         specparam   InputLoad$T = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq"; 
         


         specparam   DelayOverride$M1 = 1.0:1.0:1.0;    
         

      if(T && CLR)
         (negedge CLK => (Q -: Q)) = (1.0:1.0:1.0, 1.0:1.0:1.0);  
      
      (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);     

      $setup(T, negedge CLK &&& CLR, 0.0, NOTIFY_REG);
      $hold(negedge CLK, T &&& CLR, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);

      $width(posedge CLK &&& EN, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& EN, 0.0, 0, NOTIFY_REG);

      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
   
      $recovery(posedge CLR, negedge CLK, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "3200dx";
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
//-                    cell  UDP_DL2A.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DL2A (Q, D, G, R, S, NOTI_REG); 

 
 

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

         ?       ?      1     1     ?             :  ?  :    0   ;  
                                                                     
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
//-                    cell  UDP_DL2B.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DL2B (QN, D, GN, R, S, NOTI_REG); 

 
 

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

         ?       ?      1     1     ?             :  ?  :    1   ;   
                                                                     
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
//-                    cell  UDP_DL2C.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DL2C (Q, D, GN, R, S, NOTI_REG); 

 
 

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

         ?       ?      1     1     ?             :  ?  :    0   ;  
                                                                   
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
//-                    cell  UDP_DL2D.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_DL2D (QN, D, G, R, S, NOTI_REG); 

 
 

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

         ?       ?      1     1     ?             :  ?  :    1   ;    
                                                                     
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
//-                    cell  U_AO_6.v                                  -
//--------------------------------------------------------------------
      
primitive	U_AO_6 (Y, A, B, C, D);
	output Y;
	input  A, B, C, D;

	table
	//	A	B	C	D	:	Y

		0	?	0	?	:	0	;
		?	0	0	?	:	0	;
		0	?	?	0	:	0	;
		?	0	?	0	:	0	;
		?	?	1	1	:	1	;
		1	1	?	?	:	1	;

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
//-                    cell  U_CS_1.v                                  -
//--------------------------------------------------------------------
      
primitive	U_CS_1 (Y, A, S, B, C, D);
	output Y;
	input  A, S, B, C, D;

	table
	//	A	S	B	C	D	:	Y

		0	0	?	0	?	:	0	;
		0	?	0	0	?	:	0	;
		0	0	?	1	?	:	1	;
		0	?	0	1	?	:	1	;
		?	1	1	?	0	:	0	;
		?	1	1	?	1	:	1	;
		?	?	?	0	0	:	0	;
		1	?	?	?	0	:	0	;
		?	?	?	1	1	:	1	;
		1	?	?	?	1	:	1	;

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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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

         specparam   LibName     = "3200dx";
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
      

//  ------------------------------  END of 42mx.v ----------------------------
