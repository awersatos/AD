module CBD16CE(CEO,TC,Q,C,CE,CLR) /* synthesis syn_black_box */;
	output CEO, TC;
	output [15:0] Q;
	input C, CE, CLR;	
endmodule
module CBD16CLE(CEO,TC,Q,C,CE,CLR,D,L) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [15:0] Q;
	input C, CE, CLR;
	input [15:0] D;
	input L;	
endmodule
module CBD16CLED(CEO,TC,Q,C,CE,CLR,D,L,UP) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [15:0] Q;
	input C, CE, CLR;
	input [15:0] D;
	input L, UP;	
endmodule
module CBD16RE(CEO,TC,Q,C,CE,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [15:0] Q;
	input C, CE, R;	
endmodule
module CBD16RLE(CEO,TC,Q,C,CE,D,L,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [15:0] Q;
	input C, CE;
	input [15:0] D;
	input L, R;	
endmodule
module CBD16X1(CEU,CED,TCU,TCD,Q,C,CLR,D,L,CEOU,CEOD) /* synthesis syn_black_box */ ;
	output CEOU,CEOD,TCU,TCD;
	output [15:0] Q;
	input C, CEU,CED, CLR;
	input [15:0] D;
	input L;	
endmodule
module CBD16X2(CEU,CED,TCU,TCD,Q,C,R,D,L,CEOU,CEOD) /* synthesis syn_black_box */ ;
	output CEOU,CEOD,TCU,TCD;
	output [15:0] Q;
	input C, CEU,CED, R;
	input [15:0] D;
	input L;	
endmodule
module CBD2CE(CEO,TC,Q,C,CE,CLR) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [1:0] Q;
	input C, CE, CLR;	
endmodule
module CBD2CLE(CEO,TC,Q,C,CE,CLR,D,L) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [1:0] Q;
	input C, CE, CLR;
	input [1:0] D;
	input L;	
endmodule
module CBD2CLED(CEO,TC,Q,C,CE,CLR,D,L,UP) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [1:0] Q;
	input C, CE, CLR;
	input [1:0] D;
	input L, UP;	
endmodule
module CBD2RE(CEO,TC,Q,C,CE,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [1:0] Q;
	input C, CE, R;	
endmodule
module CBD2RLE(CEO,TC,Q,C,CE,D,L,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [1:0] Q;
	input C, CE;
	input [1:0] D;
	input L, R;	
endmodule
module CBD2X1(CEU,CED,TCU,TCD,Q,C,CLR,D,L,CEOU,CEOD) /* synthesis syn_black_box */ ;
	output CEOU,CEOD,TCU,TCD;
	output [1:0] Q;
	input C, CEU,CED, CLR;
	input [1:0] D;
	input L;	
endmodule
module CBD2X2(CEU,CED,TCU,TCD,Q,C,R,D,L,CEOU,CEOD) /* synthesis syn_black_box */ ;
	output CEOU,CEOD,TCU,TCD;
	output [1:0] Q;
	input C, CEU,CED, R;
	input [1:0] D;
	input L;	
endmodule
module CBD4CE(CEO,TC,Q,C,CE,CLR) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [3:0] Q;
	input C, CE, CLR;	
endmodule
module CBD4CLE(CEO,TC,Q,C,CE,CLR,D,L) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [3:0] Q;
	input C, CE, CLR;
	input [3:0] D;
	input L;	
endmodule
module CBD4CLED(CEO,TC,Q,C,CE,CLR,D,L,UP) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [3:0] Q;
	input C, CE, CLR;
	input [3:0] D;
	input L, UP;	
endmodule
module CBD4RE(CEO,TC,Q,C,CE,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [3:0] Q;
	input C, CE, R;	
endmodule
module CBD4RLE(CEO,TC,Q,C,CE,D,L,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [3:0] Q;
	input C, CE;
	input [3:0] D;
	input L, R;	
endmodule
module CBD4X1(CEU,CED,TCU,TCD,Q,C,CLR,D,L,CEOU,CEOD) /* synthesis syn_black_box */ ;
	output CEOU,CEOD,TCU,TCD;
	output [3:0] Q;
	input C, CEU,CED, CLR;
	input [3:0] D;
	input L;	
endmodule
module CBD4X2(CEU,CED,TCU,TCD,Q,C,R,D,L,CEOU,CEOD) /* synthesis syn_black_box */ ;
	output CEOU,CEOD,TCU,TCD;
	output [3:0] Q;
	input C, CEU,CED, R;
	input [3:0] D;
	input L;	
endmodule
module CBD8CE(CEO,TC,Q,C,CE,CLR) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [7:0] Q;
	input C, CE, CLR;	
endmodule
module CBD8CLE(CEO,TC,Q,C,CE,CLR,D,L) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [7:0] Q;
	input C, CE, CLR;
	input [7:0] D;
	input L;	
endmodule
module CBD8CLED(CEO,TC,Q,C,CE,CLR,D,L,UP) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [7:0] Q;
	input C, CE, CLR;
	input [7:0] D;
	input L, UP;	
endmodule
module CBD8RE(CEO,TC,Q,C,CE,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [7:0] Q;
	input C, CE, R;	
endmodule
module CBD8RLE(CEO,TC,Q,C,CE,D,L,R) /* synthesis syn_black_box */ ;
	output CEO, TC;
	output [7:0] Q;
	input C, CE;
	input [7:0] D;
	input L, R;	
endmodule
module CBD8X1(CEU,CED,TCU,TCD,Q,C,CLR,D,L,CEOU,CEOD) /* synthesis syn_black_box */ ;
	output CEOU,CEOD,TCU,TCD;
	output [7:0] Q;
	input C, CEU,CED, CLR;
	input [7:0] D;
	input L;	
endmodule
module CDD4CE(CEO,TC,Q,C,CE,CLR) /* synthesis syn_black_box */ ;
	output CEO;
	output TC;
	output [3:0] Q;
	input C;
	input CE;
	input CLR;
endmodule
module CDD4CLE(CEO,TC,Q,C,CE,CLR,D,L) /* synthesis syn_black_box */ ;
	output CEO;
	output TC;
	output [3:0] Q;
	input C;
	input CE;
	input CLR;
	input [3:0] D;
	input L;
endmodule
module CDD4RE(CEO,TC,Q,C,CE,R) /* synthesis syn_black_box */ ;
	output CEO;
	output TC;
	output [3:0] Q;
	input C;
	input CE;
	input R;
endmodule
module CDD4RLE(CEO,TC,Q,C,CE,R,D,L) /* synthesis syn_black_box */ ;
	output CEO;
	output TC;
	output [3:0] Q;
	input C;
	input CE;
	input R;
	input [3:0] D;
	input L;
endmodule
module CJD4CE(Q,C,CE,CLR) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input C, CE, CLR;	
endmodule
module CJD4RE(Q,C,CE,R) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input C, CE, R;	
endmodule
module CJD5CE(Q,C,CE,CLR) /* synthesis syn_black_box */ ;
	output [4:0] Q;
	input C, CE, CLR;	
endmodule
module CJD5RE(Q,C,CE,R) /* synthesis syn_black_box */ ;
	output [4:0] Q;
	input C, CE, R;	
endmodule
module CJD8CE(Q,C,CE,CLR) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input C, CE, CLR;	
endmodule
module CJD8RE(Q,C,CE,R) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input C, CE, R;	
endmodule
module FDD4 (C,D,Q)  /* synthesis syn_black_box */ ;
input C;
input [3:0] D ;
output [3:0] Q ;
endmodule
module FDD4CE (C,D,Q,CLR,CE)  /* synthesis syn_black_box */ ;
input C;
input CLR;
input CE;
input [3:0] D ;
output [3:0] Q ;
endmodule
module FDD4RE (C,R,CE,D,Q)  /* synthesis syn_black_box */ ;
input C;
input R;
input CE;
input [3:0] D ;
output [3:0] Q ;
endmodule
module FDD8 (C,D,Q)  /* synthesis syn_black_box */ ;
input C;
input [7:0] D ;
output [7:0] Q ;
endmodule
module FDD8CE (C,D,Q,CLR,CE)  /* synthesis syn_black_box */ ;
input C;
input CLR;
input CE;
input [7:0] D ;
output [7:0] Q ;
endmodule
module FDD8RE (C,R,CE,D,Q)  /* synthesis syn_black_box */ ;
input C;
input R;
input CE;
input [7:0] D ;
output [7:0] Q ;
endmodule
module FDD16 (C,D,Q)  /* synthesis syn_black_box */ ;
input C;
input [15:0] D ;
output [15:0] Q ;
endmodule
module FDD16CE (C,D,Q,CLR,CE)  /* synthesis syn_black_box */ ;
input C;
input CLR;
input CE;
input [15:0] D ;
output [15:0] Q ;
endmodule
module FDD16RE (C,R,CE,D,Q)  /* synthesis syn_black_box */ ;
input C;
input R;
input CE;
input [15:0] D ;
output [15:0] Q ;
endmodule
module FDDR (C,R,D,Q)  /* synthesis syn_black_box */ ;
input C;
input R;
input D ;
output Q ;
endmodule
module FDDRE (C,CE,R,D,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input R;
input D ;
output Q ;
endmodule
module FDDRS (C,R,S,D,Q)  /* synthesis syn_black_box */ ;
input C;
input R;
input S;
input D ;
output Q ;
endmodule
module FDDRSE (C,CE,R,S,D,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input R;
input S;
input D ;
output Q ;
endmodule
module FDDS (C,S,D,Q)  /* synthesis syn_black_box */ ;
input C;
input S;
input D ;
output Q ;
endmodule
module FDDSE (C,CE,S,D,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input S;
input D ;
output Q ;
endmodule
module FDDSR (C,R,S,D,Q)  /* synthesis syn_black_box */ ;
input C;
input R;
input S;
input D ;
output Q ;
endmodule
module FDDSRE (C,CE,R,S,D,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input R;
input S;
input D ;
output Q ;
endmodule
module FTDC (C,CLR,T,Q) ;
input C;
input CLR;
input T ;
output Q ;
endmodule
module FTDCE (C,CE,CLR,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input CLR;
input T ;
output Q ;
endmodule
module FTDCLE (C,CE,CLR,L,D,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input CLR;
input L;
input D ;
input T ;
output Q ;
endmodule
module FTDCLEX (C,CE,CLR,L,D,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input CLR;
input L;
input D ;
input T ;
output Q ;
endmodule
module FTDCP (C,PRE,CLR,T,Q)  /* synthesis syn_black_box */ ;
input C;
input PRE;
input CLR;
input T ;
output Q ;
endmodule
module FTDCPE (C,PRE,CE,CLR,T,Q)  /* synthesis syn_black_box */ ;
input C;
input PRE;
input CE;
input CLR;
input T ;
output Q ;
endmodule
module FTDCPLE (C,PRE,CE,CLR,L,D,T,Q)  /* synthesis syn_black_box */ ;
input C;
input PRE;
input CE;
input CLR;
input L ;
input D ;
input T ;
output Q ;
endmodule
module FTDRSE (C,CE,R,S,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input R;
input S;
input T ;
output Q ;
endmodule
module FTDRSLE (C,CE,R,S,L,D,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input R;
input S;
input L;
input D;
input T ;
output Q ;
endmodule
module FTDSRE (C,CE,R,S,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input R;
input S;
input T ;
output Q ;
endmodule
module FTDSRLE (C,CE,R,S,L,D,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input R;
input S;
input L;
input D;
input T ;
output Q ;
endmodule
module FTDPE (C,CE,PRE,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input PRE;
input T ;
output Q ;
endmodule
module FTDPLE (C,CE,PRE,L,D,T,Q)  /* synthesis syn_black_box */ ;
input C;
input CE;
input PRE;
input L;
input D ;
input T ;
output Q ;
endmodule
module SRD16CE(Q,C,CE,CLR,SLI) /* synthesis syn_black_box */ ;
	output [15:0] Q;
	input C, CE, CLR, SLI;	
endmodule
module SRD16CLE(Q,C,CE,CLR,SLI,L,D) /* synthesis syn_black_box */ ;
	output [15:0] Q;
	input [15:0] D;
	input C, CE, CLR, SLI, L;	
endmodule
module SRD16CLED(Q,C,CE,CLR,SLI,SRI,LEFT,L,D) /* synthesis syn_black_box */ ;
	output [15:0] Q;
	input [15:0] D;
	input C, CE, CLR, SLI, SRI, LEFT, L;	
endmodule
module SRD16RE(Q,C,CE,R,SLI) /* synthesis syn_black_box */ ;
	output [15:0] Q;
	input C, CE, R, SLI;	
endmodule
module SRD16RLE(Q,C,CE,R,SLI,L,D) /* synthesis syn_black_box */ ;
	output [15:0] Q;
	input [15:0] D;
	input C, CE, R, SLI, L;	
endmodule
module SRD16RLED(Q,C,CE,R,SLI,SRI,LEFT,L,D) /* synthesis syn_black_box */ ;
	output [15:0] Q;
	input [15:0] D;
	input C, CE, R, SLI, SRI, LEFT, L;	
endmodule
module SRD4CE(Q,C,CE,CLR,SLI) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input C, CE, CLR, SLI;	
endmodule
module SRD4CLE(Q,C,CE,CLR,SLI,L,D) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input [3:0] D;
	input C, CE, CLR, SLI, L;	
endmodule
module SRD4CLED(Q,C,CE,CLR,SLI,SRI,LEFT,L,D) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input [3:0] D;
	input C, CE, CLR, SLI, SRI, LEFT, L;	
endmodule
module SRD4RE(Q,C,CE,R,SLI) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input C, CE, R, SLI;	
endmodule
module SRD4RLE(Q,C,CE,R,SLI,L,D) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input [3:0] D;
	input C, CE, R, SLI, L;	
endmodule
module SRD4RLED(Q,C,CE,R,SLI,SRI,LEFT,L,D) /* synthesis syn_black_box */ ;
	output [3:0] Q;
	input [3:0] D;
	input C, CE, R, SLI, SRI, LEFT, L;	
endmodule
module SRD8CE(Q,C,CE,CLR,SLI) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input C, CE, CLR, SLI;	
endmodule
module SRD8CLE(Q,C,CE,CLR,SLI,L,D) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input [7:0] D;
	input C, CE, CLR, SLI, L;	
endmodule
module SRD8CLED(Q,C,CE,CLR,SLI,SRI,LEFT,L,D) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input [7:0] D;
	input C, CE, CLR, SLI, SRI, LEFT, L;	
endmodule
module SRD8RE(Q,C,CE,R,SLI) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input C, CE, R, SLI;	
endmodule
module SRD8RLE(Q,C,CE,R,SLI,L,D) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input [7:0] D;
	input C, CE, R, SLI, L;	
endmodule
module SRD8RLED(Q,C,CE,R,SLI,SRI,LEFT,L,D) /* synthesis syn_black_box */ ;
	output [7:0] Q;
	input [7:0] D;
	input C, CE, R, SLI, SRI, LEFT, L;	
endmodule
