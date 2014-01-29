/* CoolRunner-II Dual Edge Triggered Functions
   Xilinx CPLD Group
   24 Oct 2002
*/     	


`timescale 100 ps / 10 ps

module CBD16CE(CEO,Q,TC,C,CE,CLR);
	
	parameter TERMINAL_COUNT = 16'b1111111111111111;
	parameter WIDTH = 16;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	input C, CE, CLR;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale  100 ps / 10 ps

module CBD16CLE (CEO, Q, TC, C, CE, CLR, D, L);

	parameter TERMINAL_COUNT = 16'b1111111111111111;
	parameter WIDTH = 16;

	output CEO, TC;
	output [WIDTH-1:0] Q;

	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD16CLED(CEO,Q,TC,C,CE,CLR,D,L,UP);

	parameter TERMINAL_COUNT_UP = 16'b1111111111111111;
	parameter TERMINAL_COUNT_DOWN = 16'b0000000000000000;
	parameter WIDTH = 16;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L, UP;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
		begin
			if (UP)
	  			Q <= Q + 1;
			else if (!UP)
				Q <= Q - 1;
		end
end


assign CEO = TC & CE;
assign TC = (Q == TERMINAL_COUNT_UP && UP) || (Q == TERMINAL_COUNT_DOWN && !UP) ;

endmodule

`timescale 100 ps / 10 ps

module CBD16RE(CEO,Q,TC,C,CE,R);

	parameter TERMINAL_COUNT = 16'b1111111111111111;
	parameter WIDTH = 16;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end


assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT; 

endmodule

`timescale 100 ps / 10 ps

module CBD16RLE(CEO,Q,TC,C,CE,D,L,R);
	
	parameter TERMINAL_COUNT = 16'b1111111111111111;
	parameter WIDTH = 16;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE;
	input [WIDTH-1:0] D;
	input L, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD16X1(CEOU,CEOD,Q,TCU,TCD,C,CED,CEU,CLR,D,L);

	parameter TERMINAL_COUNT_UP = 16'b1111111111111111;
	parameter TERMINAL_COUNT_DOWN = 16'b0000000000000000;
	parameter WIDTH = 16;

	output CEOU,CEOD,TCU,TCD;
	output [WIDTH-1:0] Q;
	
	input C, CEU,CED, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

assign CEOU = TCU_INT && CEU;
assign CEOD = TCD_INT && CED;
assign TCU = TCU_INT;
assign TCD = TCD_INT;

endmodule

`timescale 100 ps / 10 ps

module CBD16X2(CEOD,CEOU,Q,TCU,TCD,C,CED,CEU,D,L,R);

	parameter TERMINAL_COUNT_UP = 16'b1111111111111111;
	parameter TERMINAL_COUNT_DOWN = 16'b0000000000000000;
	parameter WIDTH = 16;

	output CEOD,CEOU,TCU,TCD;
	output [WIDTH-1:0] Q;
	
	input C,CEU,CED,L,R;
	input [WIDTH-1:0] D;

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

assign CEOU = TCU_INT && CEU;
assign CEOD = TCD_INT && CED;
assign TCU = TCU_INT;
assign TCD = TCD_INT;

endmodule

`timescale 100 ps / 10 ps

module CBD2CE(CEO,Q,TC,C,CE,CLR);
	
	parameter TERMINAL_COUNT = 2'b11;
	parameter WIDTH = 2;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	input C, CE, CLR;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale  100 ps / 10 ps

module CBD2CLE (CEO, Q, TC, C, CE, CLR, D, L);

	parameter TERMINAL_COUNT = 2'b11;
	parameter WIDTH = 2;

	output CEO, TC;
	output [WIDTH-1:0] Q;

	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD2CLED(CEO,Q,TC,C,CE,CLR,D,L,UP);

	parameter TERMINAL_COUNT_UP = 2'b11;
	parameter TERMINAL_COUNT_DOWN = 2'b00;
	parameter WIDTH = 2;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L, UP;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
		begin
			if (UP)
	  			Q <= Q + 1;
			else if (!UP)
				Q <= Q - 1;
		end
end


assign CEO = TC & CE;
assign TC = ((Q == TERMINAL_COUNT_UP && UP) || (Q == TERMINAL_COUNT_DOWN && !UP));

endmodule

`timescale 100 ps / 10 ps

module CBD2RE(CEO,Q,TC,C,CE,R);

	parameter TERMINAL_COUNT = 2'b11;
	parameter WIDTH = 2;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end


assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT; 

endmodule

`timescale 100 ps / 10 ps

module CBD2RLE(CEO,Q,TC,C,CE,D,L,R);
	
	parameter TERMINAL_COUNT = 2'b11;
	parameter WIDTH = 2;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE;
	input [WIDTH-1:0] D;
	input L, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD2X1(CEOU,CEOD,Q,TCU,TCD,C,CED,CEU,CLR,D,L);

	parameter TERMINAL_COUNT_UP = 2'b11;
	parameter TERMINAL_COUNT_DOWN = 2'b00;
	parameter WIDTH = 2;

	output CEOU,CEOD,TCU,TCD;
	output [WIDTH-1:0] Q;
	
	input C, CEU,CED, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

assign CEOU = TCU_INT && CEU;
assign CEOD = TCD_INT && CED;
assign TCU = TCU_INT;
assign TCD = TCD_INT;

endmodule

`timescale 100 ps / 10 ps

module CBD2X2(CEOD,CEOU,Q,TCU,TCD,C,CED,CEU,D,L,R);

	parameter TERMINAL_COUNT_UP = 2'b11;
	parameter TERMINAL_COUNT_DOWN = 2'b00;
	parameter WIDTH = 2;

	output CEOD,CEOU,TCU,TCD;
	output [WIDTH-1:0] Q;
	
	input C,CEU,CED,L,R;
	input [WIDTH-1:0] D;

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

assign CEOU = TCU_INT && CEU;
assign CEOD = TCD_INT && CED;
assign TCU = TCU_INT;
assign TCD = TCD_INT;

endmodule

`timescale 100 ps / 10 ps

module CBD4CE(CEO,Q,TC,C,CE,CLR);
	
	parameter TERMINAL_COUNT = 4'b1111;
	parameter WIDTH = 4;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	input C, CE, CLR;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale  100 ps / 10 ps

module CBD4CLE (CEO, Q, TC, C, CE, CLR, D, L);

	parameter TERMINAL_COUNT = 4'b1111;
	parameter WIDTH = 4;

	output CEO, TC;
	output [WIDTH-1:0] Q;

	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD4CLED(CEO,Q,TC,C,CE,CLR,D,L,UP);

	parameter TERMINAL_COUNT_UP = 4'b1111;
	parameter TERMINAL_COUNT_DOWN = 4'b0000;
	parameter WIDTH = 4;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L, UP;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
		begin
			if (UP)
	  			Q <= Q + 1;
			else if (!UP)
				Q <= Q - 1;
		end
end


assign CEO = TC & CE;
assign TC = (Q == TERMINAL_COUNT_UP && UP) || (TERMINAL_COUNT_DOWN && !UP);

endmodule

`timescale 100 ps / 10 ps

module CBD4RE(CEO,Q,TC,C,CE,R);

	parameter TERMINAL_COUNT = 4'b1111;
	parameter WIDTH = 4;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end


assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT; 

endmodule

`timescale 100 ps / 10 ps

module CBD4RLE(CEO,Q,TC,C,CE,D,L,R);
	
	parameter TERMINAL_COUNT = 4'b1111;
	parameter WIDTH = 4;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE;
	input [WIDTH-1:0] D;
	input L, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD4X1(CEOU,CEOD,Q,TCU,TCD,C,CED,CEU,CLR,D,L);

	parameter TERMINAL_COUNT_UP = 4'b1111;
	parameter TERMINAL_COUNT_DOWN = 4'b0000;
	parameter WIDTH = 4;

	output CEOU,CEOD,TCU,TCD;
	output [WIDTH-1:0] Q;
	
	input C, CEU,CED, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

assign CEOU = TCU_INT && CEU;
assign CEOD = TCD_INT && CED;
assign TCU = TCU_INT;
assign TCD = TCD_INT;

endmodule

module CBD4X2(CEU,CED,TCU,TCD,Q,C,R,D,L,CEOU,CEOD);
	parameter WIDTH = 4;
	parameter TERMINAL_COUNT_UP = 4'b1111;
	parameter TERMINAL_COUNT_DOWN = 4'b0000;

	output CEOU,CEOD,TCU,TCD;
	output [WIDTH-1:0] Q;
	input C, CEU,CED, R;
	input [WIDTH-1:0] D;
	input L;	

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT,TCU,TCD;
	reg CEOU,CEOD;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

always @(TCU_INT or CEU or TCD_INT or CED)
begin
CEOU <= TCU_INT && CEU;
CEOD <= TCD_INT && CED;
TCU <= TCU_INT;
TCD <= TCD_INT;
end

endmodule

`timescale 100 ps / 10 ps

module CBD8CE(CEO,Q,TC,C,CE,CLR);
	
	parameter TERMINAL_COUNT = 8'b11111111;
	parameter WIDTH = 8;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	input C, CE, CLR;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale  100 ps / 10 ps

module CBD8CLE (CEO, Q, TC, C, CE, CLR, D, L);

	parameter TERMINAL_COUNT = 8'b11111111;
	parameter WIDTH = 8;

	output CEO, TC;
	output [WIDTH-1:0] Q;

	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD8CLED(CEO,Q,TC,C,CE,CLR,D,L,UP);

	parameter TERMINAL_COUNT_UP = 8'b11111111;
	parameter TERMINAL_COUNT_DOWN = 8'b00000000;
	parameter WIDTH = 8;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, CLR;
	input [WIDTH-1:0] D;
	input L, UP;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
		begin
			if (UP)
	  			Q <= Q + 1;
			else if (!UP)
				Q <= Q - 1;
		end
end


assign CEO = TC & CE;
assign TC = ((Q == TERMINAL_COUNT_UP && UP) || (Q == TERMINAL_COUNT_DOWN && !UP));

endmodule

`timescale 100 ps / 10 ps

module CBD8RE(CEO,Q,TC,C,CE,R);

	parameter TERMINAL_COUNT = 8'b11111111;
	parameter WIDTH = 8;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	  	Q <= Q + 1;
end


assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT; 

endmodule

`timescale 100 ps / 10 ps

module CBD8RLE(CEO,Q,TC,C,CE,D,L,R);
	
	parameter TERMINAL_COUNT = 8'b11111111;
	parameter WIDTH = 8;

	output CEO, TC;
	output [WIDTH-1:0] Q;
	
	input C, CE;
	input [WIDTH-1:0] D;
	input L, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
	  	Q <= Q + 1;
end

assign CEO = TC & CE;
assign TC = Q == TERMINAL_COUNT;

endmodule

`timescale 100 ps / 10 ps

module CBD8X1(CEOU,CEOD,Q,TCU,TCD,C,CED,CEU,CLR,D,L);

	parameter TERMINAL_COUNT_UP = 8'b11111111;
	parameter TERMINAL_COUNT_DOWN = 8'b00000000;
	parameter WIDTH = 8;

	output CEOU,CEOD,TCU,TCD;
	output [WIDTH-1:0] Q;
	
	input C, CEU,CED, CLR;
	input [WIDTH-1:0] D;
	input L;	

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

assign CEOU = TCU_INT && CEU;
assign CEOD = TCD_INT && CED;
assign TCU = TCU_INT;
assign TCD = TCD_INT;

endmodule

module CBD8X2(CEU,CED,TCU,TCD,Q,C,R,D,L,CEOU,CEOD);
	parameter WIDTH = 8;
	parameter TERMINAL_COUNT_UP = 8'b11111111;
	parameter TERMINAL_COUNT_DOWN = 8'b00000000;

	output CEOU,CEOD,TCU,TCD;
	output [WIDTH-1:0] Q;
	input C, CEU,CED, R;
	input [WIDTH-1:0] D;
	input L;	

	reg CEU_INT,CED_INT,TCU_INT,TCD_INT,TCU,TCD;
	reg CEOU,CEOD;
	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
	begin
		Q <= 0;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
	else if (L)
	begin
		Q <= D;
		CEU_INT <= CEU;
		CED_INT <= CED;
	end
	else if (CEU)
		begin
	         Q <= Q + 1;
		CEU_INT <= 1;
		CED_INT <= 0;
	end
			else if (CED)
	begin
		Q <= Q - 1;
		CEU_INT <= 1'b0;
		CED_INT <= 1'b1;
	end
end

always @(Q or CEU_INT or CED_INT)
begin
	if (Q == TERMINAL_COUNT_UP && CEU_INT) 
	begin
	TCU_INT <= 1;
	TCD_INT <= 0;
	end
	else if ((Q == TERMINAL_COUNT_DOWN) && CED_INT)
	begin
	TCU_INT <= 0;
	TCD_INT <= 1;
   end
	else
	begin
	TCU_INT <= 0;
	TCD_INT <= 0;
	end
end

always @(TCU_INT or CEU or TCD_INT or CED)
begin
CEOU <= TCU_INT && CEU;
CEOD <= TCD_INT && CED;
TCU <= TCU_INT;
TCD <= TCD_INT;
end

endmodule

`timescale 100 ps  / 10 ps

module CDD4CE(CEO,Q,TC,C,CE,CLR);

	output CEO;
	output TC;
	output [3:0] Q;

	input C;
	input CE;
	input CLR;

	reg [3:0] Q;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
 	begin
		if (Q == 4'b1001)
			Q <= 4'b0000;
		else if (Q == 4'b1011)
			Q <= 4'b0110;
		else if (Q == 4'b1101)
			Q <= 4'b0100;
		else if (Q == 4'b1111)
			Q <= 4'b0010;
		else
			Q <= Q + 1;
	end
end

assign TC = Q == 4'b1001;

assign CEO = TC && CE;

endmodule

`timescale 100 ps / 10 ps

module CDD4CLE(CEO,Q,TC,C,CE,CLR,D,L);

	output CEO;
	output TC;
	output [3:0] Q;

	input C;
	input CE;
	input CLR;
	input [3:0] D;
	input L;

	reg [3:0] Q;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
 	begin
		if (Q == 4'b1001)
			Q <= 4'b0000;
		else if (Q == 4'b1011)
			Q <= 4'b0110;
		else if (Q == 4'b1101)
			Q <= 4'b0100;
		else if (Q == 4'b1111)
			Q <= 4'b0010;
		else
			Q <= Q + 1;
	end
end

assign TC = Q == 4'b1001;

assign	CEO = TC && CE;

endmodule

`timescale 100 ps / 10 ps

module CDD4RE(CEO,Q,TC,C,CE,R);

	output CEO;
	output TC;
	output [3:0] Q;

	input C;
	input CE;
	input R;

	reg [3:0] Q;

always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
 	begin
		if (Q == 4'b1001)
			Q <= 4'b0000;
		else if (Q == 4'b1011)
			Q <= 4'b0110;
		else if (Q == 4'b1101)
			Q <= 4'b0100;
		else if (Q == 4'b1111)
			Q <= 4'b0010;
		else
			Q <= Q + 1;
	end
end

assign TC = Q == 4'b1001;

assign CEO = TC && CE;

endmodule

`timescale 100 ps / 10 ps

module CDD4RLE(CEO,Q,TC,C,CE,R,D,L);

	output CEO;
	output TC;
	output [3:0] Q;

	input C;
	input CE;
	input R;
	input L;
	input [3:0] D;

	reg [3:0] Q;

always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (L)
		Q <= D;
	else if (CE)
 	begin
		if (Q == 4'b1001)
			Q <= 4'b0000;
		else if (Q == 4'b1011)
			Q <= 4'b0110;
		else if (Q == 4'b1101)
			Q <= 4'b0100;
		else if (Q == 4'b1111)
			Q <= 4'b0010;
		else
			Q <= Q + 1;
	end
end

assign TC = Q == 4'b1001;

assign CEO = TC && CE;

endmodule

`timescale 100 ps / 10 ps

module CJD4CE(Q,C,CE,CLR);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input C, CE, CLR;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
		begin
	  	Q[0] <= !Q[WIDTH-1];
	  	Q[WIDTH-1:1] <= Q[WIDTH-2:0];
	        end
end

endmodule

`timescale 100 ps / 10 ps

module CJD4RE(Q,C,CE,R);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input C, CE, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
		begin
	  	Q[0] <= !Q[WIDTH-1];
	  	Q[WIDTH-1:1] <= Q[WIDTH-2:0];
		end
end

endmodule

`timescale 100 ps / 10 ps

module CJD5CE(Q,C,CE,CLR);

	parameter WIDTH = 5;

	output [WIDTH-1:0] Q;

	input C, CE, CLR;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
		begin
	  	Q[0] <= !Q[WIDTH-1];
	  	Q[WIDTH-1:1] <= Q[WIDTH-2:0];
	        end
end

endmodule

`timescale 100 ps / 10 ps

module CJD5RE(Q,C,CE,R);

	parameter WIDTH = 5;

	output [WIDTH-1:0] Q;

	input C, CE, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
		begin
	  	Q[0] <= !Q[WIDTH-1];
	  	Q[WIDTH-1:1] <= Q[WIDTH-2:0];
		end
end

endmodule

`timescale 100 ps / 10 ps

module CJD8CE(Q,C,CE,CLR);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, CLR;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
		begin
	  	Q[0] <= !Q[WIDTH-1];
	  	Q[WIDTH-1:1] <= Q[WIDTH-2:0];
	        end
end

endmodule

`timescale 100 ps / 10 ps

module CJD8RE(Q,C,CE,R);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, R;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
		begin
	  	Q[0] <= !Q[WIDTH-1];
	  	Q[WIDTH-1:1] <= Q[WIDTH-2:0];
		end
end

endmodule

`timescale 100 ps / 10 ps

module FDD (Q,C,D) ;

	output Q ;

	input C;
	input D ;

	reg Q ;

always @(posedge C or negedge C)
	Q = D ;

endmodule


`timescale 100 ps / 10 ps

module FDD16 (Q,C,D) ;

	output [15:0] Q ;

	input C;
	input [15:0] D ;

	reg [15:0] Q ;

always @(posedge C or negedge C)
	Q[15:0] = D[15:0] ;

endmodule


`timescale 100 ps / 10 ps

module FDD16CE (Q,C,CE,CLR,D) ;

	output [15:0] Q ;

	input C;
	input CE;
	input CLR;
	input [15:0] D ;

	reg [15:0] Q ;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 16'b0;
	else if (CE)
		Q[15:0] = D[15:0] ;
end

endmodule


`timescale 100 ps / 10 ps

module FDD16RE (Q,C,CE,D,R) ;

	output [15:0] Q ;

	input C;
	input CE;
	input R;
	input [15:0] D ;

	reg [15:0] Q ;

always @(posedge C or negedge C)
	if (R)
		Q = 16'b0;
	else if (CE)
		Q[15:0] = D[15:0] ;

endmodule


`timescale 100 ps / 10 ps

module FDD4 (Q,C,D) ;

	output [3:0] Q ;

	input C;
	input [3:0] D ;

	reg [3:0] Q ;

always @(posedge C or negedge C)
	Q[3:0] = D[3:0] ;

endmodule


`timescale 100 ps / 10 ps

module FDD4CE (Q,C,CE,CLR,D) ;

	output [3:0] Q ;

	input C;
	input CE;
	input CLR;
	input [3:0] D ;

	reg [3:0] Q ;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 4'b0;
	else if (CE)
		Q[3:0] = D[3:0] ;
end

endmodule


`timescale 100 ps / 10 ps

module FDD4RE (Q,C,CE,D,R) ;

	output [3:0] Q ;

	input C;
	input CE;
	input R;
	input [3:0] D ;

	reg [3:0] Q ;

always @(posedge C or negedge C)
	if (R)
		Q = 4'b0;
	else if (CE)
		Q[3:0] = D[3:0] ;

endmodule


`timescale 100 ps / 10 ps

module FDD8 (Q,C,D) ;

	output [7:0] Q ;

	input C;
	input [7:0] D ;

	reg [7:0] Q ;

always @(posedge C or negedge C)
	Q[7:0] = D[7:0] ;

endmodule


`timescale 100 ps / 10 ps

module FDD8CE (Q,C,CE,CLR,D) ;

	output [7:0] Q ;

	input C;
	input CE;
	input CLR;
	input [7:0] D ;

	reg [7:0] Q ;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 8'b0;
	else if (CE)
		Q[7:0] = D[7:0] ;
end

endmodule


`timescale 100 ps / 10 ps

module FDD8RE (Q,C,CE,D,R) ;

	output [7:0] Q ;

	input C;
	input CE;
	input R;
	input [7:0] D ;

	reg [7:0] Q ;

always @(posedge C or negedge C)
	if (R)
		Q = 8'b0;
	else if (CE)
		Q[7:0] = D[7:0] ;

endmodule


`timescale 100 ps / 10 ps

module FDDC (Q,C,CLR,D) ;

	output Q ;

	input C;
	input CLR;
	input D ;

	reg Q ;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 1'b0;
	else
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDCE (Q,C,CE,CLR,D) ;

	output Q ;

	input C;
	input CE;
	input CLR;
	input D ;

	reg Q ;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 1'b0;
	else
	if (CE)
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDCP (Q,C,CLR,D,PRE) ;

	output Q ;

	input C;
	input CLR;
	input D ;
	input PRE;

	reg Q ;

always @(posedge C or negedge C or posedge CLR or posedge PRE)
begin
	if (CLR)
		Q = 1'b0;
	else
	if (PRE)
		Q = 1'b1;
	else
		Q = D ;
end

endmodule


`timescale 100 ps / 10 ps

module FDDCPE (Q,C,CE,CLR,D,PRE) ;

	output Q ;

	input C;
	input PRE;
	input CE;
	input CLR;
	input D ;

	reg Q ;

always @(posedge C or negedge C or posedge CLR or posedge PRE)
begin
	if (CLR)
		Q = 1'b0;
	else if (PRE)
		Q = 1'b1;
	else if (CE)
		Q = D ;
end

endmodule


`timescale 100 ps / 10 ps

module FDDP (Q,C,D,PRE) ;

	output Q ;

	input C;
	input D ;
	input PRE;

	reg Q ;

always @(posedge C or negedge C or posedge PRE)
begin
	if (PRE)
		Q = 1'b1;
	else
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDPE (Q,C,CE,D,PRE) ;

	output Q ;

	input C;
	input CE;
	input D ;
	input PRE;

	reg Q ;

always @(posedge C or negedge C or posedge PRE)
begin
	if (PRE)
		Q = 1'b1;
	else if (CE)
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDR (Q,C,D,R) ;

	output Q ;

	input C;
	input D ;
	input R;

	reg Q ;

always @(posedge C or negedge C)
begin
	if (R)
		Q = 1'b0;
	else
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDRE (Q,C,CE,D,R) ;

	output Q ;

	input C;
	input CE;
	input D ;
	input R;

	reg Q ;

always @(posedge C or negedge C)
begin
	if (R)
		Q = 1'b0;
	else if (CE)
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDRS (Q,C,D,R,S) ;

	output Q ;

	input C;
	input D ;
	input R;
	input S;

	reg Q ;

always @(posedge C or negedge C)
begin
	if (R)
		Q = 1'b0;
	else if (S)
		Q = 1'b1;
	else
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDRSE (Q,C,CE,D,R,S) ;

	output Q ;

	input C;
	input CE;
	input D ;
	input R;
	input S;

	reg Q ;

always @(posedge C or negedge C)
begin
	if (R)
		Q = 1'b0;
	else if (S)
		Q = 1'b1;
	else if (CE)
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDS (Q,C,D,S) ;

	output Q ;

	input C;
	input S;
	input D ;


	reg Q ;

always @(posedge C or negedge C)
begin
	if (S)
		Q = 1'b1;
	else
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDSE (Q,C,CE,D,S) ;

	output Q ;

	input C;
	input CE;
	input D ;
	input S;

	reg Q ;

always @(posedge C or negedge C)
begin
	if (S)
		Q = 1'b1;
	else if (CE)
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FDDSR (Q,C,D,R,S) ;

	output Q ;

	input C;
	input D ;
	input R;
	input S;

	reg Q ;

always @(posedge C or negedge C)
begin
	if (S)
		Q = 1'b1;
	else if (R)
		Q = 1'b0;
	else
		Q = D ;
end

endmodule


`timescale 100 ps / 10 ps

module FDDSRE (Q,C,CE,D,R,S) ;

	output Q ;

	input C;
	input CE;
	input D ;
	input R;
	input S;

	reg Q ;

always @(posedge C or negedge C)
begin
	if (S)
		Q = 1'b1;
	else if (R)
		Q = 1'b0;
	else if (CE)
		Q = D ;
	end

endmodule


`timescale 100 ps / 10 ps

module FTDC (Q,C,CLR,T) ;

	output Q ;

	input C;
	input CLR;
	input T ;

	reg Q ;
	wire D;


always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 1'b0;
	else
		Q = D ;
end

assign D = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDCE (Q,C,CE,CLR,T) ;

	output Q ;

	input C;
	input CE;
	input CLR;
	input T ;

	reg Q ;
	wire D;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 1'b0;
	else if (CE)
		Q = D ;
end

assign D = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDCLE (Q,C,CE,CLR,D,L,T) ;

	output Q ;

	input C;
	input CE;
	input CLR;
	input D ;
	input L;
	input T ;

	reg Q ;
	wire D_I;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 1'b0;
	else if (L)
		Q = D;
	else if (CE)
		Q = D_I ;
end

assign D_I = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDCLEX (Q,C,CE,CLR,D,L,T) ;

	output Q ;

	input C;
	input CE;
	input CLR;
	input D ;
	input L;
	input T ;

	reg Q ;
	wire D_I;

always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q = 1'b0;
	else if (L)
		Q = D;
	else if (CE)
		Q = D_I;
end

assign D_I = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDCP (Q,C,CLR,PRE,T) ;

	output Q ;

	input C;
	input CLR;
	input PRE;
	input T ;

	reg Q ;
	wire D;

always @(posedge C or negedge C or posedge CLR or posedge PRE)
begin
	if (CLR)
		Q = 1'b0;
	else if (PRE)
		Q = 1'b1;
	else
		Q = D ;
end

assign D = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDCPE (Q,C,CE,CLR,PRE,T) ;

	output Q ;

	input C;
	input CE;
	input CLR;
	input PRE;
	input T ;

	reg Q ;
	wire D;

always @(posedge C or negedge C or posedge CLR or posedge PRE)
begin
	if (CLR)
		Q = 1'b0;
	else if (PRE)
		Q = 1'b1;
	else if (CE)
		Q = D ;
end

assign D = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDCPLE (Q,C,CE,CLR,D,L,PRE,T) ;

	output Q ;

	input C;
	input CE;
	input CLR;
	input D ;
	input L ;
	input PRE;
	input T ;

	reg Q ;
	wire D_I;

always @(posedge C or negedge C or posedge CLR or posedge PRE)
begin
	if (CLR)
		Q = 1'b0;
	else if (PRE)
		Q = 1'b1;
	else if (L)
		Q = D;
	else if (CE)
		Q = D_I ;
end

assign D_I = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDPE (Q,C,CE,PRE,T) ;

	output Q ;

	input C;
	input CE;
	input PRE;
	input T ;

	reg Q ;
	wire D;

always @(posedge C or negedge C or posedge PRE)
begin
	if (PRE)
		Q = 1'b1;
	else if (CE)
		Q = D ;
end

assign D = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDPLE (Q,C,CE,D,L,PRE,T) ;

	output Q ;

	input C;
	input CE;
	input D ;
	input L;
	input PRE;
	input T ;

	reg Q ;
	wire D_I;

always @(posedge C or negedge C or posedge PRE)
begin
	if (PRE)
		Q = 1'b1;
	else if (L)
		Q = D;
	else if (CE)
		Q = D_I ;
end

assign D_I = Q ^ T;

endmodule


`timescale 100 ps / 10 ps 

module FTDRSE (C,CE,R,S,T,Q) ;

	output Q ;

	input C;
	input CE;
	input R;
	input S;
	input T ;

	reg Q ;
	wire D;

always @(posedge C or negedge C)
begin
	if (R)
		Q = 1'b0;
	else if (S)
		Q = 1'b1;
	else if (CE)
		Q = D ;
end

assign D = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDRSLE (Q,C,CE,D,L,R,S,T) ;

	output Q ;

	input C;
	input CE;
	input D;
	input L;
	input R;
	input S;
	input T ;

	reg Q ;
	wire D_I;

always @(posedge C or negedge C)
begin
	if (R)
		Q = 1'b0;
	else if (S)
		Q = 1'b1;
	else if (L)
		Q = D ;
	if (CE)
		Q = D_I ;
end

assign D_I = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDSRE (Q,C,CE,R,S,T) ;

	output Q ;

	input C;
	input CE;
	input R;
	input S;
	input T ;

	reg Q ;
	wire D;

always @(posedge C or negedge C)
begin
	if (S)
		Q = 1'b1;
	else if (R)
		Q = 1'b0;
	else if (CE)
		Q = D ;
end

assign D = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module FTDSRLE (Q,C,CE,D,L,R,S,T) ;

	output Q ;

	input C;
	input CE;
	input D;
	input L;
	input R;
	input S;
	input T ;

	reg Q ;
	wire D_I;

always @(posedge C or negedge C)
begin
	if (S)
		Q = 1'b1;
	else if (R)
		Q = 1'b0;
	else if (L)
		Q = D ;
	if (CE)
		Q = D_I ;
end

assign D_I = Q ^ T;

endmodule


`timescale 100 ps / 10 ps

module SRD16CE(Q,C,CE,CLR,SLI);

	parameter WIDTH = 16;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, SLI;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	  	Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD16CLE(Q,C,CE,CLR,D,L,SLI);

	parameter WIDTH = 16;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, L, SLI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else
	  Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD16CLED(Q,C,CE,CLR,D,L,LEFT,SLI,SRI);

	parameter WIDTH = 16;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, L, LEFT, SLI, SRI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else if (LEFT)
	  Q <= {Q[WIDTH-2:0],SLI} ;
	else
	  Q <= {SRI, Q[WIDTH-1:1]} ;

end


endmodule

`timescale 100 ps / 10 ps

module SRD16RE(Q,C,CE,R,SLI);

	parameter WIDTH = 16;

	output [WIDTH-1:0] Q;

	input C, CE, R, SLI;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	  	Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD16RLE(Q,C,CE,L,D,R,SLI);

	parameter WIDTH = 16;

	output [WIDTH-1:0] Q;

	input C, CE, L, R, SLI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else
	  Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD16RLED(Q,C,CE,D,L,LEFT,R,SLI,SRI);

	parameter WIDTH = 16;

	output [WIDTH-1:0] Q;

	input C, CE, L, LEFT, R, SLI, SRI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else if (LEFT)
	  Q <= {Q[WIDTH-2:0],SLI} ;
	else
	  Q <= {SRI, Q[WIDTH-1:1]} ;

end


endmodule

`timescale 100 ps / 10 ps

module SRD4CE(Q,C,CE,CLR,SLI);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, SLI;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	  	Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD4CLE(Q,C,CE,CLR,D,L,SLI);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, L, SLI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else
	  Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD4CLED(Q,C,CE,CLR,D,L,LEFT,SLI,SRI);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, L, LEFT, SLI, SRI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else if (LEFT)
	  Q <= {Q[WIDTH-2:0],SLI} ;
	else
	  Q <= {SRI, Q[WIDTH-1:1]} ;

end


endmodule

`timescale 100 ps / 10 ps

module SRD4RE(Q,C,CE,R,SLI);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input C, CE, R, SLI;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	  	Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD4RLE(Q,C,CE,D,L,R,SLI);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input C, CE, R, SLI, L;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else
	  Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD4RLED(Q,C,CE,D,L,LEFT,R,SLI,SRI);

	parameter WIDTH = 4;

	output [WIDTH-1:0] Q;

	input [WIDTH-1:0] D;
	input C, CE, R, SLI, SRI, LEFT, L;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else if (LEFT)
	  Q <= {Q[WIDTH-2:0],SLI} ;
	else
	  Q <= {SRI, Q[WIDTH-1:1]} ;

end


endmodule

`timescale 100 ps / 10 ps

module SRD8CE(Q,C,CE,CLR,SLI);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, SLI;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	  	Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD8CLE(Q,C,CE,CLR,D,L,SLI);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, L, SLI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else
	  Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD8CLED(Q,C,CE,CLR,D,L,LEFT,SLI,SRI);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, CLR, L, LEFT, SLI, SRI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C or posedge CLR)
begin
	if (CLR)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else if (LEFT)
	  Q <= {Q[WIDTH-2:0],SLI} ;
	else
	  Q <= {SRI, Q[WIDTH-1:1]} ;

end


endmodule

`timescale 100 ps / 10 ps

module SRD8RE(Q,C,CE,R,SLI);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, R, SLI;	

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	  	Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD8RLE(Q,C,CE,D,L,R,SLI);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, L, R, SLI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else
	  Q <= {Q[WIDTH-2:0],SLI} ;
end


endmodule

`timescale 100 ps / 10 ps

module SRD8RLED(Q,C,CE,D,L,LEFT,R,SLI,SRI);

	parameter WIDTH = 8;

	output [WIDTH-1:0] Q;

	input C, CE, L, LEFT, R, SLI, SRI;	
	input [WIDTH-1:0] D;

	reg [WIDTH-1:0] Q;
	
always @(posedge C or negedge C)
begin
	if (R)
		Q <= 0;
	else if (CE)
	if (L)
	Q <= D;
	else if (LEFT)
	  Q <= {Q[WIDTH-2:0],SLI} ;
	else
	  Q <= {SRI, Q[WIDTH-1:1]} ;

end


endmodule

