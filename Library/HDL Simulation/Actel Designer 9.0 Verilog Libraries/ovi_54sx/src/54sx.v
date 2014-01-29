/*  
               =========================================
               =                                       =
               =         54sx VERILOG  LIB              =
               =        ACTEL  CORPORATION             =
               =                                       =
               =========================================
*/ 
  
 //BUILT on 07/25/01 17:35:10 
  
  
     
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  AND5A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND5A(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    not NT1   (NA, A);
    and AN1   (Y, NA, B, C, D, E);
    
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  AND5C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AND5C(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    not NT1   (NA, A);
    not NT2   (NB, B);
    not NT3   (NC, C);
    and AN1   (Y, NA, NB, NC, D, E);
    
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  AO12.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO12(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, NA, B);
	and	inst5 (T2, NA, NC);
	and 	inst6 (T3, B, NC);
	and 	inst7 (T4, A, NB, C);
	or	inst8 (Y, T1, T2, T3, T4);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AO13.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO13(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NC, C);
	and 	inst2 (T1, A, B);
	and 	inst3 (T2, A, NC);
	and	inst4 (T3, B, NC);
	or	inst5 (Y, T1, T2, T3);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AO14.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO14(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, B);
	and	inst5 (T2, A, NC);
	and 	inst6 (T3, B, NC);
	and	inst7 (T4, NA, NB, C);
	or	inst8 (Y, T1, T2, T3, T4);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AO15.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO15(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, NB, C);
	and	inst5 (T2, NA, B, C);
	and	inst6 (T3, NA, NB, NC);
	or	inst7 (Y, T1, T2, T3);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AO16.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO16(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, B, NC);
	and	inst5 (T2, NA, NB, C);
	or	inst6 (Y, T1, T2);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AO17.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO17(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, B, C);
	and 	inst5 (T2, NA, NB, C);
	and	inst6 (T3, NA, B, NC);
	or	inst7 (Y, T1, T2, T3);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AO18.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AO18(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, NA, B);
	and 	inst5 (T2, B, NC);
	and	inst6 (T3, NA, NC);
	or	inst7 (Y, T1, T2, T3);
       
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "act3";
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

         specparam   LibName     = "54sx";
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
//-                    cell  AOI5.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AOI5(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NC, C);
        not     inst3 (NB, B);
	and 	inst4 (T1, NA, B, C);
	and 	inst5 (T2, A, NB, NC);
	or	inst6 (NY, T1, T2);
        not     inst7 (Y, NY);
       
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  AX1D.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AX1D(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	or 	inst1 (T1, A, B);
	xor	inst6 (Y, T1, C);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AX1E.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AX1E(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	and 	inst1 (T1, A, B);
	xor	inst3 (NY, T1, C);
        not	inst2 (Y, NY);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXO1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXO1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	not	inst1 (NC, C);
	or	inst2 (T1, A, NC);
	U_MUX_2	inst3 (Y, C, T1, B);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXO2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXO2(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NC, C);
        or      inst3 (T1, NA, NC);
        U_MUX_2 inst4 (Y, C, T1, B);

    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXO3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXO3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NC, C);
        or      inst2 (T1, A, C);
        U_MUX_2 inst3 (Y, T1, NC, B);

    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXO5.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXO5(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NC, C);
	not 	inst2 (NA, A);
        or      inst3 (T1, NA, C);
        U_MUX_2 inst4 (Y, NC, T1, B);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXO6.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXO6(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NC, C);
        or      inst2 (T1, A, NC);
        U_MUX_2 inst3 (Y, T1, C, B);

    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXO7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXO7(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NA, A);
        not     inst3 (NC, C);
        or      inst4 (T1, NA, C);
        U_MUX_2 inst5 (Y, T1, NC, B);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXOI1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXOI1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NC, C);
        or      inst2 (T1, A, NC);
        U_MUX_2 inst3 (NY, C, T1, B);
	not	inst4 (Y, NY);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXOI2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXOI2(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NA, A);
        not     inst2 (NC, C);
        or      inst3 (T1, NA, NC);
        U_MUX_2 inst4 (NY, C, T1, B);
        not     inst5 (Y, NY);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXOI3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXOI3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NC, C);
        or      inst2 (T1, A, C);
        U_MUX_2 inst3 (NY, T1, NC, B);
        not     inst4 (Y, NY);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXOI4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXOI4(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NC, C);
        or      inst2 (T1, A, C);
        U_MUX_2 inst3 (NY, NC, T1, B);
        not     inst4 (Y, NY);

    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXOI5.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXOI5(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NC, C);
        not     inst2 (NA, A);
        or      inst3 (T1, NA, C);
        U_MUX_2 inst4 (NY, NC, T1, B);
        not     inst5 (Y, NY);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  AXOI7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module AXOI7(A, B, C, Y);
    
    input A, B, C;
    output Y;
    
        not     inst1 (NA, A);
        not     inst2 (NC, C);
        or      inst3 (T1, NA, C);
        U_MUX_2 inst4 (NY, T1, NC, B);
        not     inst5 (Y, NY);
       
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName       = "54sx";
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$Y  = 0;

         specparam   MacroType = "clkbuf";


        (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CLKBUFI.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CLKBUFI(PAD, Y);
    
    input PAD;
    output Y;
    
    not  inst1 (NPAD, PAD);
    buf  BF1   (Y, NPAD);
    
    specify

         specparam   LibName       = "54sx";
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$Y  = 0;

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

         specparam   LibName      = "54sx";
         specparam   InputLoad$A  = 0; 
         specparam   OutputLoad$Y = 0;
         specparam   MacroType    = "io";


        (A => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CLKINTI.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CLKINTI(A, Y);
    
    input A;
    output Y;
    
    not    inst1 (NA, A);
    buf    BF1 (Y, NA);
               
    specify

         specparam   LibName      = "54sx";
         specparam   InputLoad$A  = 0; 
         specparam   OutputLoad$Y = 0;
         specparam   MacroType    = "io";


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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  CM8F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CM8F(D0, D1, D2, D3, S00, S01, S10, S11, Y, FY);
    
    input D0, D1, D2, D3, S00, S01, S10, S11;
    output Y, FY;
    
       
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);
    U_MUX_2  mux4 (FY, T1, T2, Y2);
    

    specify

         specparam   LibName     = "54sx";
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
         ( D0 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S00 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S00 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => FY ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults


      
     
//--------------------------------------------------------------------
//-                    cell  CM8INV.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CM8INV(A, Y);
    
    input A;
    output Y;
    
    not  NT1  (Y, A);
    
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  CMA9.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMA9(D0, D3, DB, S01, S11, Y);
    
    input D0, D3, DB, S01, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, NDB, S01); 
    or       or1  (Y2, NDB, S11);
    U_MUX_2  mux1 (T1, D0, NDB, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$DB = 1;   
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMAF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMAF(D0, D2, D3, DB, S01, S11, Y);
    
    input D0, D2, D3, DB, S01, S11;
    output Y;
 
    supply0 global_0;   
    not      not1 (NDB, DB);   
    and      and1 (Y1, NDB, S01); 
    or       or1  (Y2, NDB, S11);
    U_MUX_2  mux1 (T1, D0, global_0, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 1;  
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$S01 = 1;  
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMB3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMB3(D0, D1, DB, S00, S01, S11, Y);
    
    input D0, D1, DB, S00, S01, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, NDB, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$DB = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1;  
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S00 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMB7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMB7(D0, D1, D2, DB, S00, S01, S11, Y);
    
    input D0, D1, D2, DB, S00, S01, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, NDB, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, D2, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$DB = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1;  
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S00 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMBB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMBB(D0, D1, DB, D3, S00, S01, S11, Y);
    
    input D0, D1, DB, D3, S00, S01, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, NDB, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1;  
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S00 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMBF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMBF(D0, D1, D2, D3, S00, S01, DB, S11, Y);
    
    input D0, D1, D2, D3, S00, S01, DB, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, NDB, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S00 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB  => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMEA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMEA(D1, D3, DB, S01, S10, S11, Y);
    
    input D1, D3, DB, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, NDB, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$DB = 2;  
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMEB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMEB(D0, D1, DB, D3, S01, S10, S11, Y);
    
    input D0, D1, DB, D3, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, NDB, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D3 = 2;  
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMEE.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMEE(DB, D1, D2, D3, S01, S10, S11, Y);
    
    input DB, D1, D2, D3, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, NDB, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, D1, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2;  
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  CMEF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMEF(D0, D1, D2, D3, DB, S01, S10, S11, Y);
    
    input D0, D1, D2, D3, DB, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, NDB, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

         ( DB  => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S01 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S10 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( S11 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults

      
     
//--------------------------------------------------------------------
//-                    cell  CMF1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF1(D0, DB, S00, S01, S10, S11, Y);
    
    input D0, DB, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, NDB, Y1);
    U_MUX_2  mux2 (T2, NDB, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1;  
         specparam   InputLoad$DB = 1;  
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF2.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF2(D1, DB, S00, S01, S10, S11, Y);
    
    input D1, DB, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$DB = 1;  
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";


         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF3(D0, D1, DB, S00, S01, S10, S11, Y);
    
    input D0, D1, DB, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$DB = 1;  
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF4.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF4(D2, DB, S00, S01, S10, S11, Y);
    
    input D2, DB, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, NDB, Y1);
    U_MUX_2  mux2 (T2, D2, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$DB = 1;  
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF5.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF5(D0, DB, D2, S00, S01, S10, S11, Y);
    
    input D0, DB, D2, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);    
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, NDB, Y1);
    U_MUX_2  mux2 (T2, D2, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D2 = 2;  
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF6.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF6(DB, D1, D2, S00, S01, S10, S11, Y);
    
    input DB, D1, D2, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, D1, Y1);
    U_MUX_2  mux2 (T2, D2, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 2;  
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF7.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF7(D0, D1, D2, DB, S00, S01, S10, S11, Y);
    
    input D0, D1, D2, DB, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, D2, NDB, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$DB = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D2 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF8.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF8(D3, DB, S00, S01, S10, S11, Y);
    
    input D3, DB, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, NDB, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D3 = 1; 
         specparam   InputLoad$DB = 1;  
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 1; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D3 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );

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
//-                    cell  CMF9.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMF9(D0, DB, D3, S00, S01, S10, S11, Y);
    
    input D0, DB, D3, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, NDB, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$DB = 1;  
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
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
//-                    cell  CMFA.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMFA(DB, D1, D3, S00, S01, S10, S11, Y);
    
    input DB, D1, D3, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D1 = 1;  
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
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
//-                    cell  CMFB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMFB(D0, D1, DB, D3, S00, S01, S10, S11, Y);
    
    input D0, D1, DB, D3, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, D1, Y1);
    U_MUX_2  mux2 (T2, NDB, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( D1 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
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
//-                    cell  CMFC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMFC(DB, D2, D3, S00, S01, S10, S11, Y);
    
    input DB, D2, D3, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, NDB, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$DB = 1;  
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
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
//-                    cell  CMFD.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMFD(D0, DB, D2, D3, S00, S01, S10, S11, Y);
    
    input D0, DB, D2, D3, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, D0, NDB, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D0 = 1; 
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( D0 => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
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
//-                    cell  CMFE.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module CMFE(DB, D1, D2, D3, S00, S01, S10, S11, Y);
    
    input DB, D1, D2, D3, S00, S01, S10, S11;
    output Y;
    
    not      not1 (NDB, DB);   
    and      and1 (Y1, S00, S01); 
    or       or1  (Y2, S10, S11);
    U_MUX_2  mux1 (T1, NDB, D1, Y1);
    U_MUX_2  mux2 (T2, D2, D3, Y1);
    U_MUX_2  mux3 (Y, T1, T2, Y2);


    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$DB = 1; 
         specparam   InputLoad$D1 = 1; 
         specparam   InputLoad$D2 = 1; 
         specparam   InputLoad$D3 = 2; 
         specparam   InputLoad$S00 = 1; 
         specparam   InputLoad$S01 = 1; 
         specparam   InputLoad$S10 = 1; 
         specparam   InputLoad$S11 = 2; 
         specparam   OutputLoad$Y = 0;

         specparam   MacroType = "slm";



         ( DB => Y ) = ( 1.0:1.0:1.0, 1.0:1.0:1.0 );
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  DFE4F.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE4F(D, E, CLK, PRE, Q);
    
    input    D, E, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFPCEBS  
                inst1 (Q, D, CLK, PRE_, E, NOTIFY_REG);

       not  N1  (PRE_, PRE);                 
       
       and   NR1   (ENABLE, E, PRE_);
           
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   InputLoad$PRE = 3; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, posedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(posedge CLK, negedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $recovery(posedge PRE, posedge CLK &&& ~E, 0.0, NOTIFY_REG);

    endspecify

endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFE4G.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFE4G(D, E, CLK, PRE, Q);
    
    input    D, E, CLK, PRE;
    output   Q;
    
    reg NOTIFY_REG;
    
       UFNCEBS  
                inst1 (Q, D, CLK, PRE_, E, NOTIFY_REG);
                
       not   N1    (PRE_, PRE);
       and   NR1   (ENABLE, E, PRE_);
           
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   InputLoad$PRE = 3; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, negedge CLK &&& (~PRE), 0.0, NOTIFY_REG);
      $hold(negedge CLK, posedge E &&& (~PRE), 0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, negedge CLK &&& ~E, 0.0, NOTIFY_REG);


    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEG.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFEG(D, E, CLK, PRE, CLR, Q);
    
    input    D, E, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UDP_UFPX  
                inst1 (Q, D, CLK, CLR, PRE, E_, NOTIFY_REG);
                
      
        not   N2    (E_, E);

      
       and   AN1   (ENABLE, CLR, PRE, E_);
       and   AN2   (EN1, CLR, PRE);
       nor   NR1   (EN2, PRE, E);
       and   AN3   (EN3, CLR, E_);

    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     


          
           (posedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(negedge E, posedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(posedge CLK, posedge E &&& EN1, 0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


  
      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge PRE, posedge CLK &&& EN3, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, posedge CLK &&& EN2, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFEH.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFEH(D, E, CLK, PRE, CLR, Q);
    
    input    D, E, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UDP_UFNX  
                inst1 (Q, D, CLK, CLR, PRE, E_, NOTIFY_REG);
                
        not   N1    (E_, E);
      
       and   AN1   (ENABLE, CLR, PRE, E_);
       and   AN2   (EN1, CLR, PRE);
       and   AN3   (EN2, PRE, E);
       and   AN4   (EN3, CLR, E_);
           
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$E = 1; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 2;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


           (negedge CLK =>  (Q +: D))  = (1.0:1.0:1.0, 1.0:1.0:1.0);  
           
           (posedge PRE => (Q +: 1'b1)) = (1.0:1.0:1.0, 1.0:1.0:1.0);
          
           (negedge CLR => (Q +: 1'b0)) = (1.0:1.0:1.0, 1.0:1.0:1.0);

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE, 0.0, NOTIFY_REG);

      $setup(posedge E, negedge CLK &&& EN1, 0.0, NOTIFY_REG);
      $hold(negedge CLK, negedge E &&& EN1, 0.0, NOTIFY_REG);
 

      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);

      $recovery(posedge PRE, negedge CLK &&& EN3, 0.0, NOTIFY_REG);
      $recovery(posedge CLR, negedge CLK &&& EN2, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 3; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 3; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 2; 
         specparam   InputLoad$PRE = 2; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "seq";

     


          
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";

     


          
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
//-                    cell  DFPCB.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPCB(D, CLK, PRE, CLR, Q);
    
    input  D, CLR, PRE, CLK;
    output Q;
    
    reg NOTIFY_REG;
    
       UDP_UFPRBSX 
                inst1 (Q, D, CLK, CLR, PRE, NOTIFY_REG);
       
       
       nor (ENABLE, PRE, CLR);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "pos";
     

          (posedge CLK => (Q +: D))     = (1.0:1.0:1.0, 1.0:1.0:1.0);  
         
          (negedge CLR => (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
         
          (posedge PRE => (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

      
      $setup(D, posedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(posedge CLK, D &&& ENABLE,  0.0, NOTIFY_REG);


      $hold(posedge CLK, posedge PRE, 0.0, NOTIFY_REG);

      $hold(posedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, posedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $recovery(posedge PRE, posedge CLK &&& CLR, 0.0, NOTIFY_REG);

    endspecify


endmodule
`endcelldefine
`disable_portfaults
`nosuppress_faults
      
     
//--------------------------------------------------------------------
//-                    cell  DFPCC.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module DFPCC(D, CLK, PRE, CLR, Q);
    
    input    D, CLR, PRE, CLK;
    output   Q;
    
    reg NOTIFY_REG;
    
       UDP_UFNRBSX 
                inst1 (Q, D, CLK, CLR, PRE, NOTIFY_REG);
      
        
       nor  AN1  (ENABLE, PRE, CLR);
    
    specify

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 3; 
         specparam   InputLoad$PRE = 3; 
         specparam   InputLoad$CLK = 2; 
         specparam   OutputLoad$Q = 1;

         specparam   MacroType = "seq";
         specparam   SeqType   = "flipflop";
         specparam   EdgeType  = "neg";
     


          (negedge CLK => (Q +: D))     = (1.0:1.0:1.0, 1.0:1.0:1.0);  
         
          (negedge CLR => (Q +: 1'b0))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 
         
          (negedge PRE => (Q +: 1'b1))  = (1.0:1.0:1.0, 1.0:1.0:1.0); 

      
      $setup(D, negedge CLK &&& ENABLE, 0.0, NOTIFY_REG);
      $hold(negedge CLK, D &&& ENABLE,  0.0, NOTIFY_REG);


      $hold(negedge CLK, posedge PRE, 0.0, NOTIFY_REG);

      $hold(negedge CLK, posedge CLR, 0.0, NOTIFY_REG);


      $width(posedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLK &&& ENABLE, 0.0, 0, NOTIFY_REG);
      $width(negedge CLR, 0.0, 0, NOTIFY_REG);
      $width(negedge PRE, 0.0, 0, NOTIFY_REG);
      
      $recovery(posedge CLR, negedge CLK &&& PRE, 0.0, NOTIFY_REG);
      $recovery(posedge PRE, negedge CLK &&& CLR, 0.0, NOTIFY_REG);

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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";






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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";





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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";






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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$D = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$G = 1; 
         specparam   OutputLoad$Q = 0;

         specparam   MacroType   = "seq";
         specparam   SeqType     = "latch";






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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";

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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  HCLKBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module HCLKBUF(PAD, Y);
    
    input PAD;
    output Y;
    
    buf  BF1  (Y, PAD);
    
    specify

         specparam   LibName       = "54sx";
         specparam   InputLoad$PAD = 0; 
         specparam   OutputLoad$Y  = 0;

         specparam   MacroType = "io";


        (PAD => Y) = (1.0:1.0:1.0, 1.0:1.0:1.0);

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

output  Y;
input  PAD;
    
     buf          BF1   (Y, PAD);

specify 
    specparam   LibName       = "54sx";
    specparam   InputLoad$PAD = 1;
    specparam   OutputLoad$Y  = 0;
    specparam   MacroType     = "io";

 
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";





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

         specparam   LibName     = "54sx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";





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

         specparam   LibName     = "54sx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";





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

         specparam   LibName     = "54sx";
         specparam   InputLoad$J = 1; 
         specparam   InputLoad$K = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";





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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  MAJ3X.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MAJ3X(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, B, NC);
	and	inst5 (T2, A, NB, C);
	and	inst6 (T3, NA, B, C);
	or	inst7 (Y, T1, T2, T3);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  MAJ3XI.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MAJ3XI(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, NA, NB);
	and 	inst5 (T2, NB, NC);
	and	inst6 (T3, NA, NC);
	and	inst7 (T4, A, B, C);
	or	inst8 (Y, T1, T2, T3, T4);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  MIN3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MIN3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, NA, NB);
	and	inst5 (T2, NB, NC);
	and	inst6 (T3, NA, NC);
	or	inst7 (Y, T1, T2, T3);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  MIN3X.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MIN3X(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, NB, NC);
	and	inst5 (T2, NA, B, NC);
	and	inst6 (T3, NA, NB, C);
	or	inst7 (Y, T1, T2, T3);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  MIN3XI.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module MIN3XI(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, B);
	and	inst5 (T2, A, C);
	and 	inst6 (T3, B, C);
	and	inst7 (T4, NA, NB, NC);
	or	inst8 (Y, T1, T2, T3, T4);
       
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  NAND5B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NAND5B(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    not  NT1   (NC, C);
    not  NT2   (ND, D);
    not  NT3   (NE, E);
    or   OR1   (Y, A, B, NC, ND, NE);
    
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  NOR5B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module NOR5B(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    not NT1   (NC, C);
    not NT2   (ND, D);
    not NT3   (NE, E);
    and AN1   (Y, A, B, NC, ND, NE);
    
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  OR5A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR5A(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    not  NT1   (NA, A);
    or   OR1   (Y, NA, B, C, D, E);
    
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  OR5C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module OR5C(A, B, C, D, E, Y);
    
    input A, B, C, D, E;
    output Y;
    
    not  NT1   (NA, A);
    not  NT2   (NB, B);
    not  NT3   (NC, C);
    or   OR1   (Y, NA, NB, NC, D, E);
    
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  OUTBUF.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps

module OUTBUF(D, PAD);

input   D;
output  PAD;


   buf       BF1   (PAD, D);
 
specify 
 
         specparam   LibName        = "54sx";
         specparam   InputLoad$D    = 1;
         specparam   OutputLoad$PAD = 0;
         specparam   MacroType      = "io";
 
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

         specparam   LibName     = "54sx";
         specparam   InputLoad$T = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "pos";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq";     
      


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

         specparam   LibName     = "54sx";
         specparam   InputLoad$T = 1; 
         specparam   InputLoad$CLR = 1; 
         specparam   InputLoad$CLK = 1; 
         specparam   OutputLoad$Q = 1;

         specparam   EdgeType       = "neg";
         specparam   MacroType      = "seq";
         specparam   SeqType        = "flipflop";
         specparam   FlipFlopType   = "combseq"; 
         


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

output  PAD;
input  D, E;

   bufif1       BF1   (PAD, D, E);

specify 
 
         specparam   LibName     = "54sx";
         specparam   OutputLoad$PAD = 0;
         specparam   InputLoad$D = 1;
         specparam   InputLoad$E = 1;
 
         specparam   MacroType = "io";

 
        (E => PAD) = (0.0,0.0,1.0:1.0:1.0,1.0:1.0:1.0,1.0:1.0:1.0,1.0:1.0:1.0);
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

         ?       ?      1     1     ?             :  ?  :    0   ;  // Illegal output 
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
//-                    cell  UDP_UFNRBSX.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_UFNRBSX  (Q, D, CP, RB, SB, NOTIFY_REG);

    output Q;  
    input  D, CP, RB, SB, NOTIFY_REG;
    reg    Q; 

// FUNCTION : NEGATIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. CLEAR PRIORITY WHEN BOTH
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
        ?   ?       0   0       ?      :   ?   :   0;  // CLR Priority

        ?   (?1)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        ?   (0x)    ?   ?       ?      :   ?   :   -;  // ignore rising clock
        *    ?      ?   ?       ?      :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?       ?      :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)     ?      :   ?   :   -;  // set and clear                  
        ?   ?       ?   ?       *      :   ?   :   x;  

    endtable
endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UDP_UFNX.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_UFNX (Q, D, CP, RB, SB, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CE, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. CLR PRIORITY WHEN BOTH
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
        ?   ?       0   0    ?      ?         :   ?   :   0; // CLR Priority (added 0n 11/12/97)

        ?   ?       ?   ?    ?      *         :   ?   :   x;

    endtable

endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UDP_UFPRBSX.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_UFPRBSX (Q, D, CP, RB, SB, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. CLEAR PRIORITY WHEN BOTH
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
        ?   ?       0   0         ?          :   ?   :   0;  // clear priority (11/12/97)

        ?   (?0)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        ?   (1x)    ?   ?         ?          :   ?   :   -;  // ignore falling clock
        *    ?      ?   ?         ?          :   ?   :   -;  // ignore data edges 

        ?   ?     (?1)  ?         ?          :   ?   :   -;  // ignore the edges on 
        ?   ?       ?  (?1)       ?          :   ?   :   -;  //       set and clear                  
       
        ?   ?       ?   ?         *          :   ?   :   x;


    endtable

endprimitive


      
     
//--------------------------------------------------------------------
//-                    cell  UDP_UFPX.v                                  -
//--------------------------------------------------------------------
      
primitive UDP_UFPX (Q, D, CP, RB, SB, CE, NOTIFIER_REG); 

    output Q;  
    input  NOTIFIER_REG,
           D, CP, CE, RB, SB;
    reg    Q; 

// FUNCTION : POSITIVE EDGE TRIGGERED D FLIP-FLOP WITH ACTIVE LOW
//            ASYNCHRONOUS SET AND CLEAR. CLR PRIORITY WHEN BOTH
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

        ?   ?       0   0    ?      ?         :   ?   :   0; // CLR Priority (added 11/12/97)

        ?   ?       ?   ?    ?      *         :   ?   :   x;

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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  XA1B.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XA1B(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NC, C);
	xor 	inst2 (T1, A, B);
	and	inst3 (Y, T1, NC);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  XA1C.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XA1C(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NC, C);
	xor 	inst2 (T1, A, B);
	not 	inst3 (NT1, T1);
	and	inst5 (Y, NC, NT1);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  XAI1.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XAI1(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	xor 	inst1 (T1, A, B);
	nand	inst2 (Y, T1, C);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  XAI1A.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XAI1A(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

	xnor 	inst2 (T1, A, B);
	nand	inst5 (Y, T1, C);
       
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  XNOR3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XNOR3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        xor     inst1 (T1, A, B, C);
        not     inst2 (Y, T1);
       
    specify

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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

         specparam   LibName     = "54sx";
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
//-                    cell  XOR3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module XOR3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        xor     inst1 (Y, A, B, C);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  ZOR3.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module ZOR3(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, B, C);
	and 	inst5 (T2, NA, NB, NC);
	or	inst7 (Y, T1, T2);
       
    specify

         specparam   LibName     = "54sx";
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
//-                    cell  ZOR3I.v                                  -
//--------------------------------------------------------------------
      
`suppress_faults
`enable_portfaults
`celldefine
`delay_mode_path
`timescale 1 ns / 100 ps
module ZOR3I(A, B, C, Y);
    
    input A, B, C;
    output Y;
    

        not     inst1 (NA, A);
        not     inst2 (NB, B);
        not     inst3 (NC, C);
	and 	inst4 (T1, A, B, C);
	and 	inst5 (T2, NA, NB, NC);
	nor	inst6 (Y, T1, T2);
       
    specify

         specparam   LibName     = "54sx";
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
      

//  ------------------------------  END of 54sx.v ----------------------------
